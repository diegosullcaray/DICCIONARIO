# Visión general

El repositorio es un **compilador de documentación**: lee fuentes, las une en un modelo y deriva todo
lo demás. Nada derivado se edita a mano, salvo la prosa marcada para eso.

```text
 FUENTES (entran)                      MODELO (governance/scripts/lib)          DERIVADOS (salen)
 fuente/reportes.json        ──┐       catalogo.mjs     agrupa por SP         ┌─ sql/01, 02, 03, 05
 procedimientos/**/*.sql     ──┤       tsql.mjs         analiza cuerpos       ├─ diccionario/  fichas, índices, JSON
 fuente/dependencias/*.csv   ──┼──►    dependencias.mjs motor                 ├─ docs: catálogo, calidad, hallazgos
 fuente/estructura/*.csv     ──┤       estructura.mjs   tablas reales         └─ .claude/  copia de agentes y skills
 fuente/consumo-front.json   ──┘       modelo.mjs       une + hallazgos
         ▲
 herramientas/bd.py (Python, SQL Server) llena procedimientos/ y fuente/
```

## Qué es cada cosa y si se edita a mano

| Qué | Dónde | Lo produce | ¿A mano? |
|---|---|---|---|
| Catálogo RCODREP → SP → parámetros | `fuente/reportes.json` | export de la tabla de reportes del backend | no: se reemplaza por un export nuevo |
| Cuerpo de cada SP | `procedimientos/<base>/<esquema>/<SP>.sql` | `bd.py extraer` o SSMS | no: tal cual sale de la base |
| Dependencias según el motor | `fuente/dependencias/<base>.csv` | `bd.py dependencias` (o `sql/02-dependencias` en SSMS) | no |
| Estructura real de tablas | `fuente/estructura/<base>.csv` | `bd.py estructura` | no |
| Consumo del front | `fuente/consumo-front.json` | `npm run trazar:front` | no |
| SQL de extracción, dependencias, tablas y por SP | `sql/01-*`, `02-*`, `03-*`, `05-*` | `npm run generar` | no |
| Consultas utilitarias | `sql/04-consultas/` | personas | sí |
| Fichas, índices y JSON | `diccionario/` | `npm run generar` | solo la prosa **debajo** de `<!-- generado:fin -->` |
| Línea base de hallazgos | `governance/linea-base.json` | `validar.mjs --guardar-linea-base` | no: se regenera deliberadamente |
| Agentes y skills | `governance/agents/`, `governance/skills/` | personas | sí (`.claude/` es copia) |

## Unidades y claves

| Unidad | Clave | Archivo |
|---|---|---|
| Reporte | `RCODREP` | renglón de `fuente/reportes.json` |
| Procedimiento | `base.esquema.SP` en minúsculas | `procedimientos/<base>/<esquema>/<SP>.sql` |
| Tabla | `base.esquema.tabla` en minúsculas | `diccionario/tablas/<base>/<esquema>/<tabla>.md` |
| Columna | nombre en minúsculas dentro de su tabla | renglón de la ficha de tabla |

Las claves van en minúsculas porque SQL Server no distingue mayúsculas en nombres. La **grafía** que se
muestra y la que da nombre a archivos y carpetas es la real de la base (`fuente/estructura`); si no se
conoce, la más frecuente. Así una tabla escrita `STORAGE.com_pas.X` y `storage.com_pas.X` no genera dos
carpetas que en Windows chocarían.

## Qué es una tabla para el diccionario

El motor de SQL Server no solo lista tablas: también funciones (`util.FFMTVAR`), tipos de tabla
(`piv.TPIVCONF`), SP invocados y alias que no pudo resolver. Una referencia es **tabla** si el CSV del motor
dice que lo es (`ref_objeto_tipo`), si el análisis estático también la ve, o si existe en la estructura
real. Lo demás aparece en la ficha del SP como *Otros objetos que referencia*.

Una tabla que el propio SP crea o borra (`SELECT … INTO`, `DROP TABLE`) es una **tabla de trabajo**:
no existir en la base entre ejecuciones es lo esperado.

## Escala

- Un archivo por objeto, en el mismo árbol `<base>/<esquema>/` en `procedimientos/`, `sql/` y `diccionario/`
  ([ADR-0001](./adr/ADR-0001-un-archivo-por-objeto.md)).
- Generación idempotente: un archivo solo se reescribe si cambió; `--check` lo vuelve compuerta.
- Las fichas de objetos que dejan de existir se borran solas si nadie escribió en ellas; si tienen prosa,
  el generador avisa y una persona decide.
