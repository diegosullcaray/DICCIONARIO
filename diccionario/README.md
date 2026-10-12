# Diccionario de reportes

Qué procedimiento ejecuta cada reporte, qué tablas lee y qué columnas usa de cada una.
Todo lo de este directorio se **genera** con `npm run generar`; lo único que se escribe a mano
es la prosa debajo del bloque generado de cada ficha.

<!-- generado:inicio resumen -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Indicador | Valor |
|---|---:|
| Reportes (RCODREP) en el catálogo | 324 |
| Procedimientos distintos | 271 |
| Procedimientos extraídos (cuerpo analizado) | 1 (0 %) |
| Procedimientos validados con el motor | 0 (0 %) |
| Tablas descubiertas | 1 |
| Columnas descubiertas | 1 |
| Reportes consumidos por el front MIS | 176 (commit `d67bf84`) |
| Hallazgos de calidad | 0 error(es) · 3 aviso(s) |

### Avance por base

| Base | SP | Extraídos | Validados | Tablas usadas | Lote de extracción | Dependencias |
|---|---:|---:|---:|---:|---|---|
| `mod_gpa` | 2 | 0 | 0 | 0 | [lote](../sql/01-extraccion/_lotes/mod_gpa.sql) | [dependencias](../sql/02-dependencias/mod_gpa.sql) |
| `mod_rep` | 258 | 1 | 0 | 1 | [lote](../sql/01-extraccion/_lotes/mod_rep.sql) | [dependencias](../sql/02-dependencias/mod_rep.sql) |
| `mod_sec` | 1 | 0 | 0 | 0 | [lote](../sql/01-extraccion/_lotes/mod_sec.sql) | [dependencias](../sql/02-dependencias/mod_sec.sql) |
| `storage` | 1 | 0 | 0 | 0 | [lote](../sql/01-extraccion/_lotes/storage.sql) | [dependencias](../sql/02-dependencias/storage.sql) |
| `strategos` | 9 | 0 | 0 | 0 | [lote](../sql/01-extraccion/_lotes/strategos.sql) | [dependencias](../sql/02-dependencias/strategos.sql) |
<!-- generado:fin -->

## Cómo navegar

| Si buscás… | Abrí |
|---|---|
| Qué SP ejecuta un RCODREP | [reportes.md](./reportes.md) |
| El estado de cada SP | [procedimientos.md](./procedimientos.md) |
| Qué reportes usan una tabla o columna | [tablas.md](./tablas.md) |
| Todo en formato máquina | [diccionario.json](./diccionario.json) |
| Qué está mal en la fuente | [hallazgos](../governance/docs/evidence/quality/hallazgos.md) |
