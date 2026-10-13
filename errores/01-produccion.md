# Errores de producción

<!-- generado:inicio errores -->
<!-- Generado por governance/scripts/generar-errores.mjs. No editar dentro de este bloque: se regenera. -->

Errores en el código de los SP o en la base. **No se corrigen en este repositorio**: se entregan al dueño del SP.
Columna *Línea base*: "sí" = conocido y documentado; "**nuevo**" = apareció en la última extracción.

## SP del catálogo que no existen en la base (0)

Ninguno.

## Tablas que los SP leen y no existen en la base (19)

Si el SP pasa por esa línea, el reporte falla. Puede ser una tabla renombrada, borrada, de otro esquema o sin permiso de lectura.

| Tabla | Dónde la usa | Reportes afectados | Pantalla del front | Línea base |
|---|---|---|---|---|
| `storage.com_act.SDAF002_SINFAEREACT` | com.GDACDESEM01 línea [9](../extraccion/procedimientos/mod_rep/com/GDACDESEM01.sql#L9) | `DESEMBOLSOS_01` | reportes / actividad-diaria / Comercial Ejecutivo | sí |
| `storage.com_act.VCAH004` | com.RSPROYCOLDES001 línea [14](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES001.sql#L14), [16](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES001.sql#L16)<br>com.RSPROYCOLDES003 línea [29](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES003.sql#L29), [31](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES003.sql#L31)<br>com.RSPROYCOLDES006 línea [25](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES006.sql#L25) | `PROYEC_COLREC_01`, `PROYEC_DIACOLREC_01`, `PROYEC_DIACOLREC_AS_01` | reportes / actividad-diaria / Proyecciones | sí |
| `storage.com_act.VRANKCOM01` | com.RSRANKCOM01 línea [10](../extraccion/procedimientos/mod_rep/com/RSRANKCOM01.sql#L10) | `RS_RANK_COM_01` | reportes / actividad-diaria / Cartera | sí |
| `storage.com_act.WBCH001` | com.GCOSELIS001 línea [136](../extraccion/procedimientos/mod_rep/com/GCOSELIS001.sql#L136) | `COSELISTADO_02` | — (no lo usa el front) | sí |
| `storage.com_act.WCMAG001` | com.RAGROMIX línea [41](../extraccion/procedimientos/mod_rep/com/RAGROMIX.sql#L41), [124](../extraccion/procedimientos/mod_rep/com/RAGROMIX.sql#L124)<br>com.RS_AGROMIX_CHART línea [23](../extraccion/procedimientos/mod_rep/com/RS_AGROMIX_CHART.sql#L23)<br>com.RS_AGROMIX_CHART2 línea [28](../extraccion/procedimientos/mod_rep/com/RS_AGROMIX_CHART2.sql#L28)<br>com.RS_AGROMIX_CHART3 línea [29](../extraccion/procedimientos/mod_rep/com/RS_AGROMIX_CHART3.sql#L29)<br>com.RS_AGROMIX_CHART4 línea [33](../extraccion/procedimientos/mod_rep/com/RS_AGROMIX_CHART4.sql#L33) | `RS_AGROMIX_01`, `RS_AGROMIX_02`, `RS_AGROMIX_03`, `RS_AGROMIX_04`, `RS_AGROMIX_05` | reportes<br>reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual | sí |
| `storage.com_act.WHBECA001` | com.RSCLIVULNER01 línea [29](../extraccion/procedimientos/mod_rep/com/RSCLIVULNER01.sql#L29) | `CLI_VULNERABLE_01` | — (no lo usa el front) | sí |
| `storage.com_act.WRCOMPASDIG01` | com.RSCOMPAS01 línea [131](../extraccion/procedimientos/mod_rep/com/RSCOMPAS01.sql#L131) | `RS_CARTEPAS_01` | reportes / actividad-diaria / Captaciones | sí |
| `storage.com_act.WSALCAPCOMER01` | com.RSCAPCOME01 línea [160](../extraccion/procedimientos/mod_rep/com/RSCAPCOME01.sql#L160), [246](../extraccion/procedimientos/mod_rep/com/RSCAPCOME01.sql#L246), [251](../extraccion/procedimientos/mod_rep/com/RSCAPCOME01.sql#L251) | `RS_MON_SALCAP_COM_01` | reportes<br>reportes / actividad-diaria / Captaciones | sí |
| `storage.com_act.WTRXMON001` | com.GRTABAPPO01 línea [115](../extraccion/procedimientos/mod_rep/com/GRTABAPPO01.sql#L115), [156](../extraccion/procedimientos/mod_rep/com/GRTABAPPO01.sql#L156) | `TABDIG_01` | reportes / actividad-diaria / Tablero Digital | sí |
| `storage.com_pas.SDPF007` | com.GSEGCAPBP02 línea [65](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP02.sql#L65) | `CAP_SEGUI_BP_FC_01`, `CAP_SEGUI_FC_BP_01` | reportes / actividad-diaria / Captaciones | sí |
| `storage.com_pas.WCLIENRO001` | com.GRTABDIGO01 línea [58](../extraccion/procedimientos/mod_rep/com/GRTABDIGO01.sql#L58)<br>com.GRTABDIGO02 línea [57](../extraccion/procedimientos/mod_rep/com/GRTABDIGO02.sql#L57) | `TABDIG_VR2_01`, `TABDIG_VR2_COM_02` | reportes / actividad-diaria / Tablero Digital | sí |
| `storage.com_pas.WJAS002` | com.RSCMGCLIPAS02 línea [61](../extraccion/procedimientos/mod_rep/com/RSCMGCLIPAS02.sql#L61) | `CMG_CLI_PAS_STOCK_02` | — (no lo usa el front) | sí |
| `storage.com_pas.WJAS009` | com.GSEGCAPBP01 línea [254](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP01.sql#L254), [259](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP01.sql#L259) | `CAP_SEGUI_BP_01` | reportes / actividad-diaria / Captaciones | sí |
| `storage.com_pas.WJAS010` | com.GSEGCAPBP02 línea [46](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP02.sql#L46), [53](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP02.sql#L53) | `CAP_SEGUI_BP_FC_01`, `CAP_SEGUI_FC_BP_01` | reportes / actividad-diaria / Captaciones | sí |
| `storage.com_pas.WJAS011` | com.RSROPERA002 línea [189](../extraccion/procedimientos/mod_rep/com/RSROPERA002.sql#L189), [194](../extraccion/procedimientos/mod_rep/com/RSROPERA002.sql#L194) | `TB_PANEL_OPE_02` | reportes / actividad-diaria / Captaciones | sí |
| `storage.com.metas_saldos` | com.GRCEROCUOTAO01 línea [138](../extraccion/procedimientos/mod_rep/com/GRCEROCUOTAO01.sql#L138), [158](../extraccion/procedimientos/mod_rep/com/GRCEROCUOTAO01.sql#L158)<br>com.GRESREPSEG05 línea [278](../extraccion/procedimientos/mod_rep/com/GRESREPSEG05.sql#L278)<br>com.RPROSCORR005 línea [12](../extraccion/procedimientos/mod_rep/com/RPROSCORR005.sql#L12)<br>com.RSSEGPDM01 línea [116](../extraccion/procedimientos/mod_rep/com/RSSEGPDM01.sql#L116), [203](../extraccion/procedimientos/mod_rep/com/RSSEGPDM01.sql#L203) | `CEROYCUOTA_01`, `GREPROSPCORRE_06`, `GRSCMIS_04`, `SEG_PDM_01` | reportes / actividad-diaria / Cartera en Mora<br>reportes / actividad-diaria / Reportes PDM<br>reportes / actividad-diaria / Seguros | sí |
| `storage.com.metas_saldos_anual` | com.RSRTOPPOMIS001 línea [37](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS001.sql#L37), [93](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS001.sql#L93)<br>com.RSRTOPPOMIS002 línea [35](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS002.sql#L35), [91](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS002.sql#L91)<br>com.RSRTOPPOMIS003 línea [36](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS003.sql#L36), [92](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS003.sql#L92)<br>com.RSRTOPPOMIS004 línea [38](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS004.sql#L38), [95](../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS004.sql#L95) | `pob_misi_01`, `pob_misi_02`, `pob_misi_03`, `pob_misi_04` | — (no lo usa el front) | sí |
| `storage.ref.REABP01` | com.GSEGCAPBP02 línea [75](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP02.sql#L75) | `CAP_SEGUI_BP_FC_01`, `CAP_SEGUI_FC_BP_01` | reportes / actividad-diaria / Captaciones | sí |
| `storage.ref.ResGridCiiu2` | com.RSEGSECTOR001 línea [575](../extraccion/procedimientos/mod_rep/com/RSEGSECTOR001.sql#L575) | `Sec_ciiu_01` | — (no lo usa el front) | sí |

## Columnas que los SP usan y la tabla no tiene (6)

La tabla existe, pero no tiene esa columna: el SP falla al compilar esa consulta. *Parecidas* sugiere columnas reales con nombre cercano (posible renombre).

| Tabla · columna | Dónde la usa | Columnas reales parecidas | Reportes afectados | Pantalla del front | Línea base |
|---|---|---|---|---|---|
| `storage.com_act.SDAS006` · `SCARGO` | com.RSPANSUP003 línea [52](../extraccion/procedimientos/mod_rep/com/RSPANSUP003.sql#L52) | `SCARG` | `PANEL_SUP_03` | — (no lo usa el front) | sí |
| `storage.com_act.SDAS013` · `SFECPRO` | com.GCOSEMAF002 línea [18](../extraccion/procedimientos/mod_rep/com/GCOSEMAF002.sql#L18), [54](../extraccion/procedimientos/mod_rep/com/GCOSEMAF002.sql#L54), [61](../extraccion/procedimientos/mod_rep/com/GCOSEMAF002.sql#L61) | — | `COSESEMAFORO_01` | reportes / actividad-mensual | sí |
| `storage.com_act.WGATH001` · `RCODUCO` | com.GDCGEST_ACTIVAST02 línea [96](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L96), [142](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L142), [179](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L179) | `RCODCOR`, `RCODUNI` | `reporte_autonomia_new_01`, `reporte_autonomia_newdiaria_01` | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual | sí |
| `storage.com_act.WGATH001` · `RDESUCO` | com.GDCGEST_ACTIVAST02 línea [123](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L123), [155](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L155), [301](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L301) | `RDESCOR`, `RDESUNI` | `reporte_autonomia_new_01`, `reporte_autonomia_newdiaria_01` | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual | sí |
| `storage.com_act.WIMR001` · `haseoper` | com.RSIMR01 línea [87](../extraccion/procedimientos/mod_rep/com/RSIMR01.sql#L87) | — | `RSIMR_01` | — (no lo usa el front) | sí |
| `storage.ref.wjercor01` · `RCODADM` | com.GRESPDATOS01 línea [38](../extraccion/procedimientos/mod_rep/com/GRESPDATOS01.sql#L38) | — | `P_Datos_01` | reportes / actividad-mensual | sí |

## Parámetros que no cuadran entre el catálogo y el SP (2)

| Reporte | Problema | Pantalla del front | Línea base |
|---|---|---|---|
| `HTTPTRACE_01` | reportes.json envía 2 y strategos.mod_rep_com_act.HTTPTRACE declara 0 | — (no lo usa el front) | sí |
| `DESE_SOC_01` | reportes.json envía 1 y mod_rep.com.RSDESEMP01 exige 3 sin valor por defecto | — (no lo usa el front) | sí |
<!-- generado:fin -->
