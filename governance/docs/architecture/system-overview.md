# Visión general

El repositorio es un **compilador de documentación**: toma cuatro fuentes, las une en un modelo y
deriva todo lo demás. Nada derivado se edita a mano, salvo la prosa marcada para eso.

```text
                 FUENTES                              MODELO                       DERIVADOS
 ┌──────────────────────────────┐
 │ fuente/reportes.json         │──┐
 │ procedimientos/**/*.sql      │──┤   lib/catalogo.mjs  (agrupa por SP)     ┌─ sql/01-extraccion, 02-dependencias
 │ fuente/dependencias/*.csv    │──┼─► lib/tsql.mjs      (analiza cuerpos) ──┼─ diccionario/ (fichas, índices, JSON)
 │ fuente/consumo-front.json    │──┘   lib/dependencias.mjs (motor)         ├─ sql/03-tablas
 └──────────────────────────────┘      lib/modelo.mjs    (une + hallazgos)  └─ docs: catálogo y hallazgos
```

## Unidades

| Unidad | Clave | Archivo |
|---|---|---|
| Reporte | `RCODREP` | renglón de `fuente/reportes.json` |
| Procedimiento | `base.esquema.SP` en minúsculas | `procedimientos/<base>/<esquema>/<SP>.sql` |
| Tabla | `base.esquema.tabla` en minúsculas | `diccionario/tablas/<base>/<esquema>/<tabla>.md` |
| Columna | nombre en minúsculas dentro de su tabla | renglón de la ficha de tabla |

La clave es en minúsculas porque SQL Server compara nombres sin distinguir mayúsculas; la grafía
que se muestra es la del catálogo o la del cuerpo.

## Escala

- **Un archivo por objeto** (SP, tabla, SQL de extracción): los cambios se revisan por objeto y no hay
  archivos gigantes que generen conflictos. Ver [ADR-0001](./adr/ADR-0001-un-archivo-por-objeto.md).
- **Carpetas por base y esquema**: el árbol de `procedimientos/`, `sql/` y `diccionario/` es el mismo,
  así que encontrar el SQL de una ficha es cambiar el prefijo.
- **Generación idempotente**: un archivo solo se reescribe si cambió; `--check` lo convierte en compuerta.
