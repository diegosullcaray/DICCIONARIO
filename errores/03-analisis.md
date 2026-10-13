# Pendientes del análisis

<!-- generado:inicio errores -->
<!-- Generado por governance/scripts/generar-errores.mjs. No editar dentro de este bloque: se regenera. -->

Lo que el análisis automático no pudo resolver. No son errores del SP: hay que leerlo y anotar el resultado en *Notas del analista* de su ficha.

## SQL dinámico (59)

El SP arma consultas como texto (`EXEC(@sql)`, `sp_executesql`): las tablas de ese texto no figuran en el diccionario.

| SP | Dónde | Reportes | Pantalla del front |
|---|---|---|---|
| [mod_rep.com.GCOSEMAF002](../diccionario/procedimientos/mod_rep/com/GCOSEMAF002.md) | línea [190](../extraccion/procedimientos/mod_rep/com/GCOSEMAF002.sql#L190), [363](../extraccion/procedimientos/mod_rep/com/GCOSEMAF002.sql#L363), [527](../extraccion/procedimientos/mod_rep/com/GCOSEMAF002.sql#L527) | `COSESEMAFORO_01` | reportes / actividad-mensual |
| [mod_rep.com.GDASHCLI01](../diccionario/procedimientos/mod_rep/com/GDASHCLI01.md) | línea [51](../extraccion/procedimientos/mod_rep/com/GDASHCLI01.sql#L51), [62](../extraccion/procedimientos/mod_rep/com/GDASHCLI01.sql#L62) | `DASHBOARD_CLIENTES_01` | — (no lo usa el front) |
| [mod_rep.com.GDCEROCN004](../diccionario/procedimientos/mod_rep/com/GDCEROCN004.md) | línea [70](../extraccion/procedimientos/mod_rep/com/GDCEROCN004.sql#L70) | `REP_CERCUOT_02` | reportes / actividad-diaria / Cartera en Mora |
| [mod_rep.com.GDCGEST_ACTIVAST02](../diccionario/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | línea [274](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L274), [475](../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql#L475) | `reporte_autonomia_newdiaria_01`, `reporte_autonomia_new_01` | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| [mod_rep.com.GLISAUTRO05](../diccionario/procedimientos/mod_rep/com/GLISAUTRO05.md) | línea [132](../extraccion/procedimientos/mod_rep/com/GLISAUTRO05.sql#L132), [188](../extraccion/procedimientos/mod_rep/com/GLISAUTRO05.sql#L188) | `GLISAUTRO_04` | — (no lo usa el front) |
| [mod_rep.com.GRESCAMCOND01](../diccionario/procedimientos/mod_rep/com/GRESCAMCOND01.md) | línea [83](../extraccion/procedimientos/mod_rep/com/GRESCAMCOND01.sql#L83), [207](../extraccion/procedimientos/mod_rep/com/GRESCAMCOND01.sql#L207) | `GRESCONDO_02`, `GRESCONDO_01` | — (no lo usa el front) |
| [mod_rep.com.GRESCAMCOND03](../diccionario/procedimientos/mod_rep/com/GRESCAMCOND03.md) | línea [305](../extraccion/procedimientos/mod_rep/com/GRESCAMCOND03.sql#L305), [419](../extraccion/procedimientos/mod_rep/com/GRESCAMCOND03.sql#L419) | `GRESCONDO_03` | — (no lo usa el front) |
| [mod_rep.com.GRESCAMIMP01](../diccionario/procedimientos/mod_rep/com/GRESCAMIMP01.md) | línea [77](../extraccion/procedimientos/mod_rep/com/GRESCAMIMP01.sql#L77) | `GRESCAMIMP_01` | — (no lo usa el front) |
| [mod_rep.com.GRESREPSEG06](../diccionario/procedimientos/mod_rep/com/GRESREPSEG06.md) | línea [234](../extraccion/procedimientos/mod_rep/com/GRESREPSEG06.sql#L234) | `GRSCMIS_05` | reportes / actividad-diaria / Seguros |
| [mod_rep.com.GRESTOPIMP01](../diccionario/procedimientos/mod_rep/com/GRESTOPIMP01.md) | línea [119](../extraccion/procedimientos/mod_rep/com/GRESTOPIMP01.sql#L119) | `GRESCAMIMP_02` | — (no lo usa el front) |
| [mod_rep.com.GRTABAPPO01](../diccionario/procedimientos/mod_rep/com/GRTABAPPO01.md) | línea [372](../extraccion/procedimientos/mod_rep/com/GRTABAPPO01.sql#L372) | `TABDIG_01` | reportes / actividad-diaria / Tablero Digital |
| [mod_rep.com.GRTABCORRO01](../diccionario/procedimientos/mod_rep/com/GRTABCORRO01.md) | línea [278](../extraccion/procedimientos/mod_rep/com/GRTABCORRO01.sql#L278) | `TABDIG_02` | reportes / actividad-diaria / Tablero Digital |
| [mod_rep.com.GSCAMP01](../diccionario/procedimientos/mod_rep/com/GSCAMP01.md) | línea [161](../extraccion/procedimientos/mod_rep/com/GSCAMP01.sql#L161) | `GSCAMP_01` | — (no lo usa el front) |
| [mod_rep.com.GSCASEG01](../diccionario/procedimientos/mod_rep/com/GSCASEG01.md) | línea [78](../extraccion/procedimientos/mod_rep/com/GSCASEG01.sql#L78) | `GSCASEG_01` | — (no lo usa el front) |
| [mod_rep.com.GSEGCAPBP01](../diccionario/procedimientos/mod_rep/com/GSEGCAPBP01.md) | línea [249](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP01.sql#L249), [287](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP01.sql#L287), [564](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP01.sql#L564) | `CAP_SEGUI_BP_01` | reportes / actividad-diaria / Captaciones |
| [mod_rep.com.GSEGCAPBP02](../diccionario/procedimientos/mod_rep/com/GSEGCAPBP02.md) | línea [57](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP02.sql#L57), [100](../extraccion/procedimientos/mod_rep/com/GSEGCAPBP02.sql#L100) | `CAP_SEGUI_BP_FC_01`, `CAP_SEGUI_FC_BP_01` | reportes / actividad-diaria / Captaciones |
| [mod_rep.com.GSEGCAPRED01](../diccionario/procedimientos/mod_rep/com/GSEGCAPRED01.md) | línea [132](../extraccion/procedimientos/mod_rep/com/GSEGCAPRED01.sql#L132) | `CAP_SEGUI_RED_01` | — (no lo usa el front) |
| [mod_rep.com.GSMODAGEN01](../diccionario/procedimientos/mod_rep/com/GSMODAGEN01.md) | línea [122](../extraccion/procedimientos/mod_rep/com/GSMODAGEN01.sql#L122) | `GSMODAGEN_01` | — (no lo usa el front) |
| [mod_rep.com.RACTGP01](../diccionario/procedimientos/mod_rep/com/RACTGP01.md) | línea [117](../extraccion/procedimientos/mod_rep/com/RACTGP01.sql#L117) | `RACTGP_01` | reportes / actividad-diaria / Cartera |
| [mod_rep.com.RCORRES01](../diccionario/procedimientos/mod_rep/com/RCORRES01.md) | línea [158](../extraccion/procedimientos/mod_rep/com/RCORRES01.sql#L158) | `GREPORCORRE_01` | — (no lo usa el front) |
| [mod_rep.com.RCORRES06](../diccionario/procedimientos/mod_rep/com/RCORRES06.md) | línea [74](../extraccion/procedimientos/mod_rep/com/RCORRES06.sql#L74) | `GREPORCORRE_06` | — (no lo usa el front) |
| [mod_rep.com.RESDMOV01](../diccionario/procedimientos/mod_rep/com/RESDMOV01.md) | línea [172](../extraccion/procedimientos/mod_rep/com/RESDMOV01.sql#L172) | `RESNMOV_01` | reportes / actividad-diaria |
| [mod_rep.com.REXPAGRO01](../diccionario/procedimientos/mod_rep/com/REXPAGRO01.md) | línea [28](../extraccion/procedimientos/mod_rep/com/REXPAGRO01.sql#L28) | `CON_AGRO_FEN` | consulta-fen |
| [mod_rep.com.RPROSCORR005](../diccionario/procedimientos/mod_rep/com/RPROSCORR005.md) | línea [200](../extraccion/procedimientos/mod_rep/com/RPROSCORR005.sql#L200) | `GREPROSPCORRE_06` | — (no lo usa el front) |
| [mod_rep.com.RS_AGE_COM_CR_01](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_01.md) | línea [154](../extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_01.sql#L154) | `RS_AGE_COM_CR_01`, `RS_AGE_COM_CRM_01` | reportes / actividad-diaria / Portafolio Reasignado |
| [mod_rep.com.RS_AGE_COM_CR_02](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_02.md) | línea [109](../extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_02.sql#L109) | `RS_AGE_COM_CR_03`, `RS_AGE_COM_CRM_03` | reportes / actividad-diaria / Portafolio Reasignado<br>reportes / actividad-mensual |
| [mod_rep.com.RS_AGE_COM_CR_M_01](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_01.md) | línea [156](../extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_01.sql#L156) | `RS_AGE_COM_CRM_F_01` | reportes / actividad-mensual |
| [mod_rep.com.RS_AGE_COM_CR_M_02](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_02.md) | línea [110](../extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_02.sql#L110) | `RS_AGE_COM_CRM_F_03` | — (no lo usa el front) |
| [mod_rep.com.RS_AGE_COM_CR_M_03](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_03.md) | línea [150](../extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_03.sql#L150) | `RS_AGE_COM_CRM_S_01` | — (no lo usa el front) |
| [mod_rep.com.RS_AGE_COM_CR_M_04](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_04.md) | línea [115](../extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_04.sql#L115) | `RS_AGE_COM_CRM_S_03` | — (no lo usa el front) |
| [mod_rep.com.RSAGECOM02](../diccionario/procedimientos/mod_rep/com/RSAGECOM02.md) | línea [165](../extraccion/procedimientos/mod_rep/com/RSAGECOM02.sql#L165) | `RS_AGE_COM_02` | reportes / actividad-diaria / Campañas |
| [mod_rep.com.RSAGECOM03](../diccionario/procedimientos/mod_rep/com/RSAGECOM03.md) | línea [165](../extraccion/procedimientos/mod_rep/com/RSAGECOM03.sql#L165) | `RS_AGE_COM_03` | reportes / actividad-diaria / Campañas |
| [mod_rep.com.RSAPPUSO001](../diccionario/procedimientos/mod_rep/com/RSAPPUSO001.md) | línea [135](../extraccion/procedimientos/mod_rep/com/RSAPPUSO001.sql#L135) | `APP_USO_01` | reportes / actividad-diaria / Aplicativo Movil |
| [mod_rep.com.RSBASENEG01](../diccionario/procedimientos/mod_rep/com/RSBASENEG01.md) | línea [33](../extraccion/procedimientos/mod_rep/com/RSBASENEG01.sql#L33) | `RS_BASE_NEG_01` | core / winder<br>herramientas |
| [mod_rep.com.RSEGSECTOR001](../diccionario/procedimientos/mod_rep/com/RSEGSECTOR001.md) | línea [367](../extraccion/procedimientos/mod_rep/com/RSEGSECTOR001.sql#L367), [466](../extraccion/procedimientos/mod_rep/com/RSEGSECTOR001.sql#L466), [569](../extraccion/procedimientos/mod_rep/com/RSEGSECTOR001.sql#L569) | `Sec_ciiu_01` | — (no lo usa el front) |
| [mod_rep.com.RSMONRENT01](../diccionario/procedimientos/mod_rep/com/RSMONRENT01.md) | línea [206](../extraccion/procedimientos/mod_rep/com/RSMONRENT01.sql#L206) | `RS_RETE_01` | — (no lo usa el front) |
| [mod_rep.com.RSPANSUP001](../diccionario/procedimientos/mod_rep/com/RSPANSUP001.md) | línea [433](../extraccion/procedimientos/mod_rep/com/RSPANSUP001.sql#L433) | `PANEL_SUP_01` | — (no lo usa el front) |
| [mod_rep.com.RSPANSUP004](../diccionario/procedimientos/mod_rep/com/RSPANSUP004.md) | línea [99](../extraccion/procedimientos/mod_rep/com/RSPANSUP004.sql#L99) | `PANEL_SUP_04` | — (no lo usa el front) |
| [mod_rep.com.RSPANSUP005](../diccionario/procedimientos/mod_rep/com/RSPANSUP005.md) | línea [77](../extraccion/procedimientos/mod_rep/com/RSPANSUP005.sql#L77) | `PANEL_SUP_05` | — (no lo usa el front) |
| [mod_rep.com.RSPROYCOLDES001](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES001.md) | línea [194](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES001.sql#L194) | `PROYEC_COLREC_01` | reportes / actividad-diaria / Proyecciones |
| [mod_rep.com.RSPROYCOLDES002](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES002.md) | línea [114](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES002.sql#L114) | `PROYEC_COLREC_02` | — (no lo usa el front) |
| [mod_rep.com.RSPROYCOLDES009](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES009.md) | línea [65](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES009.sql#L65) | `PROYEC_COLREC_03` | reportes / actividad-diaria / Proyecciones |
| [mod_rep.com.RSPROYCOLDES010](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES010.md) | línea [58](../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES010.sql#L58) | `PROYEC_COLREC_04` | — (no lo usa el front) |
| [mod_rep.com.RSRDFCA021](../diccionario/procedimientos/mod_rep/com/RSRDFCA021.md) | línea [82](../extraccion/procedimientos/mod_rep/com/RSRDFCA021.sql#L82) | `DesemDiario_02` | reportes / actividad-diaria / Cartera |
| [mod_rep.com.RSRDFCA022](../diccionario/procedimientos/mod_rep/com/RSRDFCA022.md) | línea [81](../extraccion/procedimientos/mod_rep/com/RSRDFCA022.sql#L81) | `DesemDiario_03` | reportes / actividad-diaria / Cartera |
| [mod_rep.com.RSRDFCA023](../diccionario/procedimientos/mod_rep/com/RSRDFCA023.md) | línea [104](../extraccion/procedimientos/mod_rep/com/RSRDFCA023.sql#L104) | `DesemDiario_04` | reportes / actividad-diaria / Cartera |
| [mod_rep.com.RSRDFCA024](../diccionario/procedimientos/mod_rep/com/RSRDFCA024.md) | línea [99](../extraccion/procedimientos/mod_rep/com/RSRDFCA024.sql#L99) | `CONT_ELECT_M_01` | reportes / actividad-mensual |
| [mod_rep.com.RSRDFCA025](../diccionario/procedimientos/mod_rep/com/RSRDFCA025.md) | línea [99](../extraccion/procedimientos/mod_rep/com/RSRDFCA025.sql#L99) | `CONT_ELECT_M_02` | reportes / actividad-mensual |
| [mod_rep.com.RSRDFCA026](../diccionario/procedimientos/mod_rep/com/RSRDFCA026.md) | línea [116](../extraccion/procedimientos/mod_rep/com/RSRDFCA026.sql#L116) | `CONT_ELECT_M_03` | reportes / actividad-mensual |
| [mod_rep.com.RSRDFCA031](../diccionario/procedimientos/mod_rep/com/RSRDFCA031.md) | línea [107](../extraccion/procedimientos/mod_rep/com/RSRDFCA031.sql#L107) | `DesemDiario_05` | reportes / actividad-diaria / Cartera |
| [mod_rep.com.RSRDFCA032](../diccionario/procedimientos/mod_rep/com/RSRDFCA032.md) | línea [116](../extraccion/procedimientos/mod_rep/com/RSRDFCA032.sql#L116) | `CONT_ELECT_M_04` | reportes / actividad-mensual |
| [mod_rep.com.RSRDFCA035](../diccionario/procedimientos/mod_rep/com/RSRDFCA035.md) | línea [218](../extraccion/procedimientos/mod_rep/com/RSRDFCA035.sql#L218), [259](../extraccion/procedimientos/mod_rep/com/RSRDFCA035.sql#L259), [283](../extraccion/procedimientos/mod_rep/com/RSRDFCA035.sql#L283) | `CARACT_CARTERA_01`, `CARACT_CARTERA_M_01` | reportes / actividad-diaria / Captaciones<br>reportes / actividad-mensual |
| [mod_rep.com.RSRDFCA036](../diccionario/procedimientos/mod_rep/com/RSRDFCA036.md) | línea [250](../extraccion/procedimientos/mod_rep/com/RSRDFCA036.sql#L250), [291](../extraccion/procedimientos/mod_rep/com/RSRDFCA036.sql#L291), [317](../extraccion/procedimientos/mod_rep/com/RSRDFCA036.sql#L317) | `CARACT_pas_M_01`, `CARACT_pas_01` | reportes / actividad-diaria / Captaciones<br>reportes / actividad-mensual<br>shared / ui |
| [mod_rep.com.RSRDFCA050](../diccionario/procedimientos/mod_rep/com/RSRDFCA050.md) | línea [274](../extraccion/procedimientos/mod_rep/com/RSRDFCA050.sql#L274) | `Monitor_Dese_misi_01` | reportes / desarrollo-sostenible |
| [mod_rep.com.RSRDFCA050_3](../diccionario/procedimientos/mod_rep/com/RSRDFCA050_3.md) | línea [145](../extraccion/procedimientos/mod_rep/com/RSRDFCA050_3.sql#L145), [157](../extraccion/procedimientos/mod_rep/com/RSRDFCA050_3.sql#L157) | `Monitor_Dese_misi_02` | reportes / desarrollo-sostenible |
| [mod_rep.com.RSRDFCA050_4](../diccionario/procedimientos/mod_rep/com/RSRDFCA050_4.md) | línea [157](../extraccion/procedimientos/mod_rep/com/RSRDFCA050_4.sql#L157), [169](../extraccion/procedimientos/mod_rep/com/RSRDFCA050_4.sql#L169) | `prod_misi_05` | reportes / desarrollo-sostenible |
| [mod_rep.com.RSRDMA023](../diccionario/procedimientos/mod_rep/com/RSRDMA023.md) | línea [231](../extraccion/procedimientos/mod_rep/com/RSRDMA023.sql#L231), [277](../extraccion/procedimientos/mod_rep/com/RSRDMA023.sql#L277) | `R_APADRINA_01` | reportes / actividad-diaria / Campañas |
| [mod_rep.com.RSROPERA001](../diccionario/procedimientos/mod_rep/com/RSROPERA001.md) | línea [267](../extraccion/procedimientos/mod_rep/com/RSROPERA001.sql#L267), [284](../extraccion/procedimientos/mod_rep/com/RSROPERA001.sql#L284), [384](../extraccion/procedimientos/mod_rep/com/RSROPERA001.sql#L384) | `TB_PANEL_OPE_01` | reportes / actividad-diaria / Captaciones |
| [mod_rep.com.RSROPERA002](../diccionario/procedimientos/mod_rep/com/RSROPERA002.md) | línea [237](../extraccion/procedimientos/mod_rep/com/RSROPERA002.sql#L237), [254](../extraccion/procedimientos/mod_rep/com/RSROPERA002.sql#L254), [354](../extraccion/procedimientos/mod_rep/com/RSROPERA002.sql#L354) | `TB_PANEL_OPE_02` | reportes / actividad-diaria / Captaciones |

## `columna-sin-resolver` (8)

Columna sin calificar con varias tablas posibles que la estructura real no pudo desempatar.

| Objeto | Detalle |
|---|---|
| `mod_rep.com.GRESREPSEG05` | `SCODAGR` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAF002 o storage.com_seg.SDSF001 |
| `mod_rep.com.GRESREPSEG06` | `SCODAGR` podría ser de storage.com_act.SDAF002 o storage.com_seg.SDSF001 |
| `mod_rep.com.GRTABDIGO01` | `HORD` podría ser de STORAGE.com_pas.WCLIENRO001 o STORAGE.com_pas.WTRXMONE001 o storage.com_pas.WCAP002 |
| `mod_rep.com.GRTABDIGO01` | `HFECPRO` podría ser de STORAGE.com_pas.WCLIENRO001 o STORAGE.com_pas.WTRXMONE001 o storage.com_pas.WCAP002 |
| `mod_rep.com.GRTABDIGO01` | `HCODCAN` podría ser de STORAGE.com_pas.WTRXMONE001 o storage.com_pas.WCAP002 |
| `mod_rep.com.GRTABDIGO02` | `HCODCAN` podría ser de STORAGE.com_pas.WTRXMONE001 o storage.com_pas.WCAP002 |
| `mod_rep.com.GSEGCAPBP01` | `HFECPRO` podría ser de storage.com_act.HTDA001 o storage.com_act.WAPPCLI001 |
| `mod_rep.com.RGRAFGESTCOM06` | `hfecpro` podría ser de STORAGE.COM_ACT.WTIPCLI001 o storage.com_act.wjas001 |

## `columna-inferida-inexistente` (3)

Columna inferida que no existe en la tabla: el analizador la atribuyó mal (alias o columna de otra tabla).

| Objeto | Detalle |
|---|---|
| `storage.com_act.HRESINC001.des_gru` | la usa mod_rep.com.GSEGUIINC001 |
| `storage.com.VDMCOM01.Tip_cod` | la usa mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS04 |
| `storage.com.VDMCOM01.tip_cod2` | la usa mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS04 |

## `analisis-aproximado` (68)

MERGE o PIVOT: revisar columnas a mano.

| Objeto | Detalle |
|---|---|
| `mod_rep.com.GCMCNUE001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GCMGCARTAS001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GCMGMORA001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GCMGMORA001_SIMP` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GCMGMORA003` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GCOMCRE01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GCOMCRE02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GDACDESEM01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GDASHCLI01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GDCGEST_ACTIVAST01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GDCGEST_ACTIVAST02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GDCGEST_ACTIVAST03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GDCGEST_ACTIVAST04` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GDCGEST_PASIVAST01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GMOVCLI01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRESCAMCOND03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRESREPSEG_01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRESREPSEG01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRESREPSEG02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRESREPSEG05` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRESREPSEG06` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRMENTOR001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRMENTOR002` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRTABAPPO01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRTABDIGO01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GRTABDIGO02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.GSCAMP01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RACTGP01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RMONINTCOM01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RREPGESTCOM02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RREPGESTCOM03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSCMGCF001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSCMGCLIPAS01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSCMGCLIPAS02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSCMGCLIPAS03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSCMGFCA002` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSDESEMP01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSDESEMP02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSDESEMPAS01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSEGASE01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSEGSECTOR001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSGETCOM01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSIMR01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSMONEFE01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSMONEFER01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSMONEFER03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSMONEFEREPRO01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSMONEFETRC01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA007` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA024` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA025` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA026` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA027` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA028` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA029` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA030` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA032` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA035` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA036` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA037` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA038` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDFCA050` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRDMA023` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSRPD001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSSALCAR01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSSALCARVIGE01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.com.RSSEGPDM01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| `mod_rep.rep.GSREVA01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
<!-- generado:fin -->
