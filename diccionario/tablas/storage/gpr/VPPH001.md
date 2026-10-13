# storage.gpr.VPPH001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `gpr` · 5 columna(s) usadas · 23 procedimiento(s) · vista con 5 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/gpr/VPPH001.sql](../../../../extraccion/sql/03-tablas/storage/gpr/VPPH001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `hcodbt` | varchar(15) | ✅ confirmada | [GDASHKAY06](../../../procedimientos/mod_rep/com/GDASHKAY06.md), [GLIMOVO02](../../../procedimientos/mod_rep/com/GLIMOVO02.md), [GLIMOVO05](../../../procedimientos/mod_rep/com/GLIMOVO05.md), [GLIMOVO06](../../../procedimientos/mod_rep/com/GLIMOVO06.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md), [GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md), [GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md), [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md), [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md), [GLISPROSP01](../../../procedimientos/mod_rep/com/GLISPROSP01.md), [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md), [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md), [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md), [GSEGUIINC001](../../../procedimientos/mod_rep/com/GSEGUIINC001.md), [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md), [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md), [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md), [RSPROYCOLDES006](../../../procedimientos/mod_rep/com/RSPROYCOLDES006.md), [RSPROYCOLDES007](../../../procedimientos/mod_rep/com/RSPROYCOLDES007.md), [RSPROYCOLDES008](../../../procedimientos/mod_rep/com/RSPROYCOLDES008.md) | — |
| `HDESCAR` | varchar(255) | ✅ confirmada | [GDASHKAY06](../../../procedimientos/mod_rep/com/GDASHKAY06.md), [GSEGUIINC001](../../../procedimientos/mod_rep/com/GSEGUIINC001.md) | — |
| `HDESPER` | varchar(255) | ✅ confirmada | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md), [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md), [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md) | — |
| `HMAILPER` | varchar(100) not null | ✅ confirmada | [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md), [GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md), [GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md), [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HNUMDOC` | varchar(50) | ✅ confirmada | [GLIMOVO02](../../../procedimientos/mod_rep/com/GLIMOVO02.md), [GLIMOVO05](../../../procedimientos/mod_rep/com/GLIMOVO05.md), [GLIMOVO06](../../../procedimientos/mod_rep/com/GLIMOVO06.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md), [GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md), [GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md), [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md), [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md), [GLISPROSP01](../../../procedimientos/mod_rep/com/GLISPROSP01.md), [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md), [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md), [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md), [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md), [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md), [RSPROYCOLDES006](../../../procedimientos/mod_rep/com/RSPROYCOLDES006.md), [RSPROYCOLDES007](../../../procedimientos/mod_rep/com/RSPROYCOLDES007.md), [RSPROYCOLDES008](../../../procedimientos/mod_rep/com/RSPROYCOLDES008.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDASHKAY06](../../../procedimientos/mod_rep/com/GDASHKAY06.md) | lee | `rankKayrecu_01` |
| [mod_rep.com.GLIMOVO02](../../../procedimientos/mod_rep/com/GLIMOVO02.md) | lee | `PLANMOV_02`, `PLANMOVPERFIL_02` |
| [mod_rep.com.GLIMOVO05](../../../procedimientos/mod_rep/com/GLIMOVO05.md) | lee | `PLANMOV_03` |
| [mod_rep.com.GLIMOVO06](../../../procedimientos/mod_rep/com/GLIMOVO06.md) | lee | `PLANMOV_04` |
| [mod_rep.com.GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | lee | `PLANMOVR_01` |
| [mod_rep.com.GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md) | lee | `PLANMOVR_03` |
| [mod_rep.com.GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md) | lee | `PLANMOVR_04` |
| [mod_rep.com.GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | lee | `LIS_CAPRET_01` |
| [mod_rep.com.GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | lee | `DET_CLI_01` |
| [mod_rep.com.GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | lee | `REACT_PDM_01` |
| [mod_rep.com.GLISPROSP01](../../../procedimientos/mod_rep/com/GLISPROSP01.md) | lee | `LIS_PROSPE_01` |
| [mod_rep.com.GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | lee | `RES_SEC_REP_01` |
| [mod_rep.com.GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md) | lee | `P_Datos_01` |
| [mod_rep.com.GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md) | lee | `P_Datos_02` |
| [mod_rep.com.GSEGUIINC001](../../../procedimientos/mod_rep/com/GSEGUIINC001.md) | lee | `SEGUI_INC_SEC_01` |
| [mod_rep.com.RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md) | lee | `enrolamiento_pasivo_01` |
| [mod_rep.com.RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | lee | `RESNMOVR_01`, `RESNMOV_02` |
| [mod_rep.com.RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | lee | `DESE_SOC_AS_01` |
| [mod_rep.com.RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | lee | `Sec_ciiu_01` |
| [mod_rep.com.RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | lee | `RS_MON_EFEC_SEC_01` |
| [mod_rep.com.RSPROYCOLDES006](../../../procedimientos/mod_rep/com/RSPROYCOLDES006.md) | lee | `PROYEC_DIACOLREC_AS_01` |
| [mod_rep.com.RSPROYCOLDES007](../../../procedimientos/mod_rep/com/RSPROYCOLDES007.md) | lee | `PROYEC_DIACOLREC_AS_02` |
| [mod_rep.com.RSPROYCOLDES008](../../../procedimientos/mod_rep/com/RSPROYCOLDES008.md) | lee | `PROYEC_DIACOLREC_AS_03` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hcodbt`: _por documentar_
- `HDESCAR`: _por documentar_
- `HDESPER`: _por documentar_
- `HMAILPER`: _por documentar_
- `HNUMDOC`: _por documentar_
