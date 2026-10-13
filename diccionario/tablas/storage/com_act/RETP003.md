# storage.com_act.RETP003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 3 columna(s) usadas · 8 procedimiento(s) · tabla con 4 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/RETP003.sql](../../../../extraccion/sql/03-tablas/storage/com_act/RETP003.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `RCODPROD` | int | ✅ confirmada | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md), [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md), [GDCGEST_ACTIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md), [GMOVCLI01](../../../procedimientos/mod_rep/com/GMOVCLI01.md), [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md), [GRESDESCRE02](../../../procedimientos/mod_rep/com/GRESDESCRE02.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `RDESGRU01` | varchar(255) | ✅ confirmada | [GDCGEST_ACTIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | — |
| `RDESPROD` | varchar(255) | ✅ confirmada | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md), [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md), [GDCGEST_ACTIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md), [GMOVCLI01](../../../procedimientos/mod_rep/com/GMOVCLI01.md), [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md), [GRESDESCRE02](../../../procedimientos/mod_rep/com/GRESDESCRE02.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | lee | `COSELISTADO_02` |
| [mod_rep.com.GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | lee | `COSESEMAFORO_01` |
| [mod_rep.com.GDCGEST_ACTIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | lee | `GST_ACTIVAS_01`, `GST_ACTIVAS_02`, `GST_ACTIVAS_03`, `GST_ACTIVAS_04`, `GST_ACTIVAS_05`, `GST_ACTIVAS_06`, `GST_ACTIVAS_M_01`, `GST_ACTIVAS_M_02`, `GST_ACTIVAS_M_03`, `GST_ACTIVAS_M_04`, `GST_ACTIVAS_M_05`, `GST_ACTIVAS_M_06` |
| [mod_rep.com.GMOVCLI01](../../../procedimientos/mod_rep/com/GMOVCLI01.md) | lee | `MOVIMIENTO_CLIENTES_01` |
| [mod_rep.com.GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | lee | `PRECOSECUADRO_03` |
| [mod_rep.com.GRESDESCRE02](../../../procedimientos/mod_rep/com/GRESDESCRE02.md) | lee | `DESCRED_01` |
| [mod_rep.com.GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | lee | `RPROGOB_03`, `RPROGOB_M_03`, `RPROGOB_04`, `RPROGOB_M_04` |
| [mod_rep.com.GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | lee | `GRSCMIS_04` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `RCODPROD`: _por documentar_
- `RDESGRU01`: _por documentar_
- `RDESPROD`: _por documentar_
