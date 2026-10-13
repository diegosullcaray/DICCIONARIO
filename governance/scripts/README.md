# Scripts de gobernanza — DICCIONARIO

Automatización del diccionario. Node 20+ sin dependencias externas: corren en Windows, Linux, macOS y CI.
Ninguno se conecta a la base de datos; el único que lo hace es `extraer-definiciones.ps1`, y lo hace
con el servidor que se le pasa por parámetro.

Comparten [`lib/`](./lib/):

| Módulo | Responsabilidad |
|---|---|
| [`catalogo.mjs`](./lib/catalogo.mjs) | lee `fuente/reportes.json`, normaliza nombres de SP y los agrupa |
| [`tsql.mjs`](./lib/tsql.mjs) | analizador estático de T-SQL: tablas, columnas, firma, EXEC, salida |
| [`dependencias.mjs`](./lib/dependencias.mjs) | importa el CSV de `sql/02-dependencias` |
| [`modelo.mjs`](./lib/modelo.mjs) | une las fuentes, clasifica tablas y otros objetos, deriva hallazgos (`REGLAS`) |
| [`estructura.mjs`](./lib/estructura.mjs) | importa `fuente/estructura/*.csv` (columnas y tipos reales) |
| [`salida.mjs`](./lib/salida.mjs) | escribe solo si cambió, inyecta bloques generados, modo `--check` |

## Índice

| Script | Propósito | npm |
|---|---|---|
| [`generar-extraccion.mjs`](./generar-extraccion.mjs) | SQL de extracción y de dependencias | `npm run generar` |
| [`generar-diccionario.mjs`](./generar-diccionario.mjs) | fichas, índices, JSON, SQL por tabla | `npm run generar` |
| [`sincronizar-agentes.mjs`](./sincronizar-agentes.mjs) | `governance/` → `.claude/` y `.agents/skills.json` | `npm run generar` |
| [`validar.mjs`](./validar.mjs) | verificación única | `npm run verificar` |
| [`trazar-front.mjs`](./trazar-front.mjs) | consumo de RCODREP en MIS-angular-front | `npm run trazar:front` |
| [`extraer-definiciones.ps1`](./extraer-definiciones.ps1) | descarga de cuerpos con `sqlcmd` | — |

Todos los generadores aceptan `--check`: no escriben, y fallan si algún archivo quedó desactualizado.

---

## 1. Extracción

```bash
node governance/scripts/generar-extraccion.mjs [--check]
```

| Genera | Para qué |
|---|---|
| `sql/01-extraccion/<base>/<esquema>/<SP>.sql` | el patrón `USE … GO EXEC sp_helptext` de un SP, con los RCODREP que lo usan y dónde pegar el resultado |
| `sql/01-extraccion/_lotes/<base>.sql` | todos los SP de una base: si existen, fechas de creación/modificación y `OBJECT_DEFINITION` |
| `sql/01-extraccion/manifiesto.json` | lista de SP, destino y si ya está extraído; lo lee el `.ps1` |
| `sql/02-dependencias/<base>.sql` | `sys.dm_sql_referenced_entities` por SP, con `TRY/CATCH` para que un SP roto no corte el lote, más `sys.sql_expression_dependencies` para referencias a otras bases, con el tipo real de cada objeto (`ref_objeto_tipo`) |

Un SP aparece una vez aunque lo usen varios RCODREP: el archivo los lista a todos.

## 2. Descarga en lote (Windows)

```powershell
./governance/scripts/extraer-definiciones.ps1 -Servidor <servidor>                 # todos los pendientes
./governance/scripts/extraer-definiciones.ps1 -Servidor <servidor> -Base mod_rep
./governance/scripts/extraer-definiciones.ps1 -Servidor <servidor> -Nombre GSREVA01 -Sobrescribir
```

Usa `OBJECT_DEFINITION` (no corta líneas como `sp_helptext`) y autenticación de Windows; con
`-Usuario`, `sqlcmd` pide la contraseña. Informa los SP del catálogo que ya no existen en el servidor.

## 3. Diccionario

```bash
node governance/scripts/generar-diccionario.mjs [--check]
```

Construye el [modelo](./lib/modelo.mjs) y escribe `diccionario/`, `sql/03-tablas/` y los bloques
generados de `docs/data/catalog.md` y `docs/evidence/quality/hallazgos.md`.

Las fichas usan marcadores `<!-- generado:inicio ficha -->` / `<!-- generado:fin -->`: lo de adentro se
reescribe, lo de afuera se conserva. En las fichas de tabla, las líneas `` - `COLUMNA`: descripción ``
escritas a mano se copian a la columna **Descripción** de la tabla generada.

## 4. Validación

```bash
node governance/scripts/validar.mjs                       # informe: errores y avisos nuevos
node governance/scripts/validar.mjs --check               # falla ante errores nuevos o fallas estructurales (npm run verificar)
node governance/scripts/validar.mjs --check --estricto    # falla también con avisos nuevos
node governance/scripts/validar.mjs --detalle             # todo, incluidos informativos y línea base (npm run hallazgos)
node governance/scripts/validar.mjs --sin-linea-base      # cuenta todo como nuevo
node governance/scripts/validar.mjs --guardar-linea-base  # congela los actuales (deliberado: ADR-0006)
node governance/scripts/validar.mjs --json
```

Las reglas, su nivel y su origen viven en `REGLAS` (`lib/modelo.mjs`); la tabla de
[calidad](../docs/data/quality.md) se genera desde ahí. Además de los hallazgos, controla que los
generados estén al día (incluido `.agents/skills.json`, que se deriva del frontmatter de las skills), los enlaces internos, que no haya rutas que solo difieran
en mayúsculas y que la línea base no tenga entradas vencidas.

## 5. Traza con el front

```bash
node governance/scripts/trazar-front.mjs --front=../MIS-angular-front
```

Busca cada RCODREP como literal en `src/app/**/*.ts` del front y guarda `fuente/consumo-front.json`
con el commit leído. Es una foto: volver a trazar cuando el front cambie.

## 6. Pruebas

```bash
npm test
```

`tests/tsql.test.mjs` fija el comportamiento del analizador con el SP real `GSELREP001` y un caso por
patrón (JOIN, CASE, subconsultas, escrituras, SQL dinámico, UNION). **Un SP mal analizado se arregla
agregando primero su caso a la prueba.**
