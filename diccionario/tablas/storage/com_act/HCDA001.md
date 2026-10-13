# storage.com_act.HCDA001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 20 columna(s) usadas · 24 procedimiento(s) · tabla con 103 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/HCDA001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/HCDA001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `*` | ⚠️ no existe | 🎯 exacta | [GRESPROGOB01](../../../procedimientos/mod_rep/com/GRESPROGOB01.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | — |
| `HASEOPER` | varchar(10) | 🎯 exacta | [GRESPROGOB01](../../../procedimientos/mod_rep/com/GRESPROGOB01.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md), [GSEGUIINC001](../../../procedimientos/mod_rep/com/GSEGUIINC001.md) | — |
| `HCODMOD` | smallint not null | 🎯 exacta | [GRESPROGOB01](../../../procedimientos/mod_rep/com/GRESPROGOB01.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | — |
| `HCODMON` | smallint | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HCODOPE` | int | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HCTACLI` | int | ✅ confirmada | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md), [GLIMOVO05](../../../procedimientos/mod_rep/com/GLIMOVO05.md), [GLIMOVO06](../../../procedimientos/mod_rep/com/GLIMOVO06.md), [GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md), [GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md) | — |
| `HDCODSEC` | varchar(80) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HDESCLI` | varchar(40) | ✅ confirmada | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md), [GLIMOVO05](../../../procedimientos/mod_rep/com/GLIMOVO05.md), [GLIMOVO06](../../../procedimientos/mod_rep/com/GLIMOVO06.md), [GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md), [GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md) | — |
| `HDSUCCLI` | varchar(40) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HDTIPOPE` | varchar(40) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HFECMOR` | date | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [GCMCNUE002](../../../procedimientos/mod_rep/com/GCMCNUE002.md), [GCMGCAP01](../../../procedimientos/mod_rep/com/GCMGCAP01.md), [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md), [GLIMOVO05](../../../procedimientos/mod_rep/com/GLIMOVO05.md), [GLIMOVO06](../../../procedimientos/mod_rep/com/GLIMOVO06.md), [GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md), [GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md), [GRESPROGOB01](../../../procedimientos/mod_rep/com/GRESPROGOB01.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md), [GSEGUIINC001](../../../procedimientos/mod_rep/com/GSEGUIINC001.md), [GTOPCERCUO001](../../../procedimientos/mod_rep/com/GTOPCERCUO001.md), [GTOPCERCUO002](../../../procedimientos/mod_rep/com/GTOPCERCUO002.md), [GTOPCERCUO003](../../../procedimientos/mod_rep/com/GTOPCERCUO003.md), [GTOPCERCUO004](../../../procedimientos/mod_rep/com/GTOPCERCUO004.md), [GTOPCERCUO005](../../../procedimientos/mod_rep/com/GTOPCERCUO005.md), [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA029](../../../procedimientos/mod_rep/com/RSRDFCA029.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [GDACTITASA01](../../../procedimientos/strategos/mod_rep_com_act/GDACTITASA01.md), [GDEFECTMORA01](../../../procedimientos/strategos/mod_rep_com_act/GDEFECTMORA01.md), [GDPORTAGRO01](../../../procedimientos/strategos/mod_rep_com_act/GDPORTAGRO01.md), [GDPSUPERV01](../../../procedimientos/strategos/mod_rep_com_act/GDPSUPERV01.md), [GDPSUPERV02](../../../procedimientos/strategos/mod_rep_com_act/GDPSUPERV02.md) | — |
| `HINDCAR` | varchar(20) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HMONDES` | numeric(17,2) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HNUMDOC` | varchar(20) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HSALVENMN` | numeric(17,2) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HSUBTIP` | int | 🎯 exacta | [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | — |
| `HTIPCMB` | numeric(17,4) | 🧩 por estructura | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HTIPDOC` | smallint | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `HTIPOPE` | smallint | 🎯 exacta | [GRESPROGOB01](../../../procedimientos/mod_rep/com/GRESPROGOB01.md), [GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GCMCNUE002](../../../procedimientos/mod_rep/com/GCMCNUE002.md) | lee | `CMCUONUEV_02` |
| [mod_rep.com.GCMGCAP01](../../../procedimientos/mod_rep/com/GCMGCAP01.md) | lee | `GCMGCAP_01` |
| [mod_rep.com.GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | lee | `COSELISTADO_02` |
| [mod_rep.com.GLIMOVO05](../../../procedimientos/mod_rep/com/GLIMOVO05.md) | lee | `PLANMOV_03` |
| [mod_rep.com.GLIMOVO06](../../../procedimientos/mod_rep/com/GLIMOVO06.md) | lee | `PLANMOV_04` |
| [mod_rep.com.GLIMOVRO05](../../../procedimientos/mod_rep/com/GLIMOVRO05.md) | lee | `PLANMOVR_03` |
| [mod_rep.com.GLIMOVRO06](../../../procedimientos/mod_rep/com/GLIMOVRO06.md) | lee | `PLANMOVR_04` |
| [mod_rep.com.GRESPROGOB01](../../../procedimientos/mod_rep/com/GRESPROGOB01.md) | lee | `RPROGOB_01`, `RPROGOB_M_01`, `RPROGOB_02`, `RPROGOB_M_02` |
| [mod_rep.com.GRESPROGOB02](../../../procedimientos/mod_rep/com/GRESPROGOB02.md) | lee | `RPROGOB_03`, `RPROGOB_M_03`, `RPROGOB_04`, `RPROGOB_M_04` |
| [mod_rep.com.GSEGUIINC001](../../../procedimientos/mod_rep/com/GSEGUIINC001.md) | lee | `SEGUI_INC_SEC_01` |
| [mod_rep.com.GTOPCERCUO001](../../../procedimientos/mod_rep/com/GTOPCERCUO001.md) | lee | `CEROCUOTA_TOPCNUEVA_01`, `CEROCUOTA_TOPCNUEVA_M_01` |
| [mod_rep.com.GTOPCERCUO002](../../../procedimientos/mod_rep/com/GTOPCERCUO002.md) | lee | `CEROCUOTA_TOPCNUEVA_02`, `CEROCUOTA_TOPCNUEVA_M_02` |
| [mod_rep.com.GTOPCERCUO003](../../../procedimientos/mod_rep/com/GTOPCERCUO003.md) | lee | `CEROCUOTA_TOPCNUEVA_03`, `CEROCUOTA_TOPCNUEVA_M_03` |
| [mod_rep.com.GTOPCERCUO004](../../../procedimientos/mod_rep/com/GTOPCERCUO004.md) | lee | `CEROCUOTA_TOPCNUEVA_04`, `CEROCUOTA_TOPCNUEVA_M_04` |
| [mod_rep.com.GTOPCERCUO005](../../../procedimientos/mod_rep/com/GTOPCERCUO005.md) | lee | `CEROCUOTA_TOPCNUEVA_05`, `CEROCUOTA_TOPCNUEVA_M_05` |
| [mod_rep.com.RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md) | lee | `Monitor_Dese_01` |
| [mod_rep.com.RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md) | lee | `Monitor_Dese_03` |
| [mod_rep.com.RSRDFCA029](../../../procedimientos/mod_rep/com/RSRDFCA029.md) | lee | `Monitor_Dese_04` |
| [mod_rep.com.RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md) | lee | `Monitor_Dese_02` |
| [strategos.mod_rep_com_act.GDACTITASA01](../../../procedimientos/strategos/mod_rep_com_act/GDACTITASA01.md) | lee | `actividadtasas_01` |
| [strategos.mod_rep_com_act.GDEFECTMORA01](../../../procedimientos/strategos/mod_rep_com_act/GDEFECTMORA01.md) | lee | `EfecRecTramos_01` |
| [strategos.mod_rep_com_act.GDPORTAGRO01](../../../procedimientos/strategos/mod_rep_com_act/GDPORTAGRO01.md) | lee | `PortafolioAgro_01` |
| [strategos.mod_rep_com_act.GDPSUPERV01](../../../procedimientos/strategos/mod_rep_com_act/GDPSUPERV01.md) | lee | `PORTSUPE_01` |
| [strategos.mod_rep_com_act.GDPSUPERV02](../../../procedimientos/strategos/mod_rep_com_act/GDPSUPERV02.md) | lee | `PORTSUPE_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `*`: _por documentar_
- `HASEOPER`: _por documentar_
- `HCODMOD`: _por documentar_
- `HCODMON`: _por documentar_
- `HCODOPE`: _por documentar_
- `HCTACLI`: _por documentar_
- `HDCODSEC`: _por documentar_
- `HDESCLI`: _por documentar_
- `HDSUCCLI`: _por documentar_
- `HDTIPOPE`: _por documentar_
- `HFECMOR`: _por documentar_
- `HFECPRO`: _por documentar_
- `HINDCAR`: _por documentar_
- `HMONDES`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HSALVENMN`: _por documentar_
- `HSUBTIP`: _por documentar_
- `HTIPDOC`: _por documentar_
- `HTIPOPE`: _por documentar_
