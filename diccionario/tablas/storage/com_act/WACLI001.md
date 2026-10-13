# storage.com_act.WACLI001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 5 columna(s) usadas · 7 procedimiento(s) · tabla con 19 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WACLI001.sql](../../../../sql/03-tablas/storage/com_act/WACLI001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `hclinue` | int not null | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `hconcli` | varchar(34) not null | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `hfecpro` | date not null | ✅ confirmada | [GDCGEST_ACTIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md), [GDCGEST_ACTIVAST03](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST03.md), [GDCGEST_ACTIVAST04](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST04.md), [GDCLIOPE01](../../../procedimientos/mod_rep/com/GDCLIOPE01.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md), [RSRDFCA011](../../../procedimientos/mod_rep/com/RSRDFCA011.md), [RTABDIGCOM01](../../../procedimientos/mod_rep/com/RTABDIGCOM01.md) | — |
| `hinddes` | bit | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDCGEST_ACTIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | lee | `GST_ACTIVAS_01`, `GST_ACTIVAS_02`, `GST_ACTIVAS_03`, `GST_ACTIVAS_04`, `GST_ACTIVAS_05`, `GST_ACTIVAS_06`, `GST_ACTIVAS_M_01`, `GST_ACTIVAS_M_02`, `GST_ACTIVAS_M_03`, `GST_ACTIVAS_M_04`, `GST_ACTIVAS_M_05`, `GST_ACTIVAS_M_06` |
| [mod_rep.com.GDCGEST_ACTIVAST03](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST03.md) | lee | `GST_ACTIVAS_08`, `GST_ACTIVAS_07` |
| [mod_rep.com.GDCGEST_ACTIVAST04](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST04.md) | lee | `GST_ACTIVAS_09`, `GST_ACTIVAS_10` |
| [mod_rep.com.GDCLIOPE01](../../../procedimientos/mod_rep/com/GDCLIOPE01.md) | lee | `Clientes_Ope_01` |
| [mod_rep.com.GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | lee | `RMENTORIN_01` |
| [mod_rep.com.RSRDFCA011](../../../procedimientos/mod_rep/com/RSRDFCA011.md) | lee | `Clientes_nuevoRec_01` |
| [mod_rep.com.RTABDIGCOM01](../../../procedimientos/mod_rep/com/RTABDIGCOM01.md) | lee | `TABDIGITAL_COMERCIAL_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hclinue`: _por documentar_
- `HCODSEC`: _por documentar_
- `hconcli`: _por documentar_
- `hfecpro`: _por documentar_
- `hinddes`: _por documentar_
