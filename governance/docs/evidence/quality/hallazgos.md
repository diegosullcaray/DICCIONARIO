# Hallazgos de calidad

Lo que el validador encuentra en las fuentes del diccionario. Se **deriva**: corregir la causa
(en `fuente/reportes.json`, en el SP o en el cuerpo extraído) y regenerar; no se borra un renglón a mano.

Qué significa cada regla y cómo se resuelve: [calidad del dato](../../data/quality.md).

<!-- generado:inicio hallazgos -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Origen | Errores | Avisos | Info | En línea base |
|---|---:|---:|---:|---:|
| catalogo | 0 | 3 | 3 | 3 |
| produccion | 53 | 0 | 0 | 53 |
| repositorio | 0 | 0 | 0 | 0 |
| analisis | 0 | 70 | 211 | 70 |

### Catálogo

Catálogo (`fuente/reportes.json`): corregir en la tabla de reportes del backend y reexportar.

| Nivel | Regla | Objeto | Detalle | Línea base |
|---|---|---|---|---|
| aviso | `codigo-duplicado` | `CLI_VULNERABLE_01` | aparece 2 veces en reportes.json (entradas idénticas) | sí |
| aviso | `codigo-duplicado` | `PANEL_SUP_02` | aparece 2 veces en reportes.json (entradas idénticas) | sí |
| aviso | `nombre-con-espacios` | `strategos.mod_rep_com_act.GDDESEMDIA` | escrito como "strategos.mod_rep_com_act.GDDESEMDIA  " | sí |

### Producción

Producción (código del SP o la base): reportar al dueño del SP; acá no se corrige.

| Nivel | Regla | Objeto | Detalle | Línea base |
|---|---|---|---|---|
| error | `columna-inexistente` | `storage.com_act.SDAS006.SCARGO` | la usa mod_rep.com.RSPANSUP003 | sí |
| error | `columna-inexistente` | `storage.com_act.SDAS013.SFECPRO` | la usa mod_rep.com.GCOSEMAF002 | sí |
| error | `columna-inexistente` | `storage.com_act.WGATH001.RCODUCO` | la usa mod_rep.com.GDCGEST_ACTIVAST02 | sí |
| error | `columna-inexistente` | `storage.com_act.WGATH001.RDESUCO` | la usa mod_rep.com.GDCGEST_ACTIVAST02 | sí |
| error | `columna-inexistente` | `storage.com_act.WIMR001.haseoper` | la usa mod_rep.com.RSIMR01 | sí |
| error | `columna-inexistente` | `storage.ref.wjercor01.RCODADM` | la usa mod_rep.com.GRESPDATOS01 | sí |
| error | `parametros-de-mas` | `HTTPTRACE_01` | reportes.json envía 2 y strategos.mod_rep_com_act.HTTPTRACE declara 0 | sí |
| error | `parametros-faltantes` | `DESE_SOC_01` | reportes.json envía 1 y mod_rep.com.RSDESEMP01 exige 3 sin valor por defecto | sí |
| error | `sp-inexistente` | `mod_rep.com.GCMGCARTAS001` | lo ejecutan CMG_CARTERA_ASESOR_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.GRGCTABDIGO03` | lo ejecutan GCTABDIG_VR2_COM_03 | sí |
| error | `sp-inexistente` | `mod_rep.com.GRTABDIGO01` | lo ejecutan TABDIG_VR2_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.GRTABDIGO02` | lo ejecutan TABDIG_VR2_COM_02 | sí |
| error | `sp-inexistente` | `mod_rep.com.RAGROMIX` | lo ejecutan RS_AGROMIX_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RINCEPDM01` | lo ejecutan INCEN_PDM_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RMONINTCOM01` | lo ejecutan RS_MON_INT_COM_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RRANKM02` | lo ejecutan RS_RANK_MUJ_02 | sí |
| error | `sp-inexistente` | `mod_rep.com.RREPGESTCOM02` | lo ejecutan RS_GEST_COM_02 | sí |
| error | `sp-inexistente` | `mod_rep.com.RREPGESTCOM03` | lo ejecutan RS_GEST_COM_03 | sí |
| error | `sp-inexistente` | `mod_rep.com.RS_AGROMIX_CHART` | lo ejecutan RS_AGROMIX_02 | sí |
| error | `sp-inexistente` | `mod_rep.com.RS_AGROMIX_CHART2` | lo ejecutan RS_AGROMIX_03 | sí |
| error | `sp-inexistente` | `mod_rep.com.RS_AGROMIX_CHART3` | lo ejecutan RS_AGROMIX_04 | sí |
| error | `sp-inexistente` | `mod_rep.com.RS_AGROMIX_CHART4` | lo ejecutan RS_AGROMIX_05 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSCAPCOME01` | lo ejecutan RS_MON_SALCAP_COM_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSCOMPAS01` | lo ejecutan RS_CARTEPAS_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSDEPGSOLID01` | lo ejecutan GRBSOLI_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSEGASE01` | lo ejecutan SEGUROS_ASESOR_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRANKCOM01` | lo ejecutan RS_RANK_COM_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRDFCA038` | lo ejecutan CMG_CARTERA_03 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRDFCA050` | lo ejecutan Monitor_Dese_misi_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRDFCA050_3` | lo ejecutan Monitor_Dese_misi_02 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRDFCA050_4` | lo ejecutan prod_misi_05 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSROPERA001` | lo ejecutan TB_PANEL_OPE_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSROPERA002` | lo ejecutan TB_PANEL_OPE_02 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRTOPPOMIS001` | lo ejecutan pob_misi_01 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRTOPPOMIS002` | lo ejecutan pob_misi_02 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRTOPPOMIS003` | lo ejecutan pob_misi_03 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSRTOPPOMIS004` | lo ejecutan pob_misi_04 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSSALCARVIGE02` | lo ejecutan RS_SAL_CAR_05 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSSEGPAS04` | lo ejecutan RS_SEG_PAS_04 | sí |
| error | `sp-inexistente` | `mod_rep.com.RSTABCOMER02` | lo ejecutan Tab_Dig_Com_A_01, RS_TAB_COM_02 | sí |
| error | `sp-inexistente` | `mod_rep.dbo.REPORTE_DEMO` | lo ejecutan reporte-demo | sí |
| error | `tabla-inexistente` | `storage.com_act.SDAF002_SINFAEREACT` | la usan mod_rep.com.GDACDESEM01 | sí |
| error | `tabla-inexistente` | `storage.com_act.VCAH004` | la usan mod_rep.com.RSPROYCOLDES001, mod_rep.com.RSPROYCOLDES003, mod_rep.com.RSPROYCOLDES006 | sí |
| error | `tabla-inexistente` | `storage.com_act.WBCH001` | la usan mod_rep.com.GCOSELIS001 | sí |
| error | `tabla-inexistente` | `storage.com_act.WHBECA001` | la usan mod_rep.com.RSCLIVULNER01 | sí |
| error | `tabla-inexistente` | `storage.com_act.WTRXMON001` | la usan mod_rep.com.GRTABAPPO01 | sí |
| error | `tabla-inexistente` | `storage.com_pas.SDPF007` | la usan mod_rep.com.GSEGCAPBP02 | sí |
| error | `tabla-inexistente` | `storage.com_pas.WJAS002` | la usan mod_rep.com.RSCMGCLIPAS02 | sí |
| error | `tabla-inexistente` | `storage.com_pas.WJAS009` | la usan mod_rep.com.GSEGCAPBP01 | sí |
| error | `tabla-inexistente` | `storage.com_pas.WJAS010` | la usan mod_rep.com.GSEGCAPBP02 | sí |
| error | `tabla-inexistente` | `storage.com.metas_saldos` | la usan mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRESREPSEG05, mod_rep.com.RPROSCORR005, mod_rep.com.RSSEGPDM01 | sí |
| error | `tabla-inexistente` | `storage.ref.REABP01` | la usan mod_rep.com.GSEGCAPBP02 | sí |
| error | `tabla-inexistente` | `storage.ref.ResGridCiiu2` | la usan mod_rep.com.RSEGSECTOR001 | sí |

### Análisis

Límite del análisis: revisar a mano y anotar en la ficha.

| Nivel | Regla | Objeto | Detalle | Línea base |
|---|---|---|---|---|
| aviso | `columna-inferida-inexistente` | `storage.com_act.HRESINC001.des_gru` | la usa mod_rep.com.GSEGUIINC001 | sí |
| aviso | `columna-inferida-inexistente` | `storage.com.VDMCOM01.Tip_cod` | la usa mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02 | sí |
| aviso | `columna-inferida-inexistente` | `storage.com.VDMCOM01.tip_cod2` | la usa mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG05` | `SCODAGR` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAF002 o storage.com_seg.SDSF001 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG06` | `SCODAGR` podría ser de storage.com_act.SDAF002 o storage.com_seg.SDSF001 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HFECPRO` podría ser de storage.com_act.HTDA001 o storage.com_act.WAPPCLI001 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `rord` podría ser de storage.ref.REABP01 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `sfecpro` podría ser de storage.ref.REABP01 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `SINTMESSALMN` podría ser de storage.ref.REABP01 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `SSALMN` podría ser de storage.ref.REABP01 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM06` | `hfecpro` podría ser de STORAGE.COM_ACT.WTIPCLI001 o storage.com_act.wjas001 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `codvarsFormat` podría ser de storage.ref.ResGridCiiu2 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem1` podría ser de storage.ref.ResGridCiiu2 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem2` podría ser de storage.ref.ResGridCiiu2 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem3` podría ser de storage.ref.ResGridCiiu2 | sí |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem4` podría ser de storage.ref.ResGridCiiu2 | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GCOSEMAF002` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GDASHCLI01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GDCEROCN004` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GDCGEST_ACTIVAST02` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GLISAUTRO05` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GRESCAMCOND01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GRESCAMCOND03` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GRESCAMIMP01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GRESREPSEG06` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GRESTOPIMP01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GRTABAPPO01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GRTABCORRO01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GSCAMP01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GSCASEG01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GSEGCAPBP01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GSEGCAPBP02` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GSEGCAPRED01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.GSMODAGEN01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RACTGP01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RCORRES01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RCORRES06` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RESDMOV01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.REXPAGRO01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RPROSCORR005` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_02` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_02` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_03` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_04` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSAGECOM02` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSAGECOM03` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSAPPUSO001` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSBASENEG01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSEGSECTOR001` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSMONRENT01` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSPANSUP001` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSPANSUP004` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSPANSUP005` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES001` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES002` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES009` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES010` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA021` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA022` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA023` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA024` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA025` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA026` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA031` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA032` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA035` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA036` | revisar a mano las tablas del texto dinámico | sí |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDMA023` | revisar a mano las tablas del texto dinámico | sí |

Más 214 hallazgo(s) informativo(s): `npm run hallazgos` o `diccionario/diccionario.json`.
<!-- generado:fin -->
