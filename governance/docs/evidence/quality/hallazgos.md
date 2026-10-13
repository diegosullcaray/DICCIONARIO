# Hallazgos de calidad

Lo que el validador encuentra en las fuentes del diccionario. Se **deriva**: corregir la causa
(en `fuente/reportes.json`, en el SP o en el cuerpo extraído) y regenerar; no se borra un renglón a mano.

Qué significa cada regla y cómo se resuelve: [calidad del dato](../../data/quality.md).

<!-- generado:inicio hallazgos -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Nivel | Regla | Cantidad |
|---|---|---:|
| error | `columna-inexistente` | 6 |
| error | `parametros-de-mas` | 1 |
| error | `parametros-faltantes` | 1 |
| error | `tabla-inexistente` | 37 |
| aviso | `codigo-duplicado` | 2 |
| aviso | `columna-inexistente` | 14 |
| aviso | `columna-sin-resolver` | 336 |
| aviso | `discrepancia-motor` | 7 |
| aviso | `motor-con-error` | 33 |
| aviso | `nombre-con-espacios` | 1 |
| aviso | `sql-dinamico` | 54 |
| info | `analisis-aproximado` | 59 |
| info | `parametro-con-variantes` | 3 |
| info | `parametro-nombre-distinto` | 55 |
| info | `varios-resultados` | 94 |

| Nivel | Regla | Objeto | Detalle |
|---|---|---|---|
| error | `columna-inexistente` | `storage.com_act.SDAS006.SCARGO` | no existe en la tabla y la usa mod_rep.com.RSPANSUP003 |
| error | `columna-inexistente` | `storage.com_act.SDAS013.SFECPRO` | no existe en la tabla y la usa mod_rep.com.GCOSEMAF002 |
| error | `columna-inexistente` | `storage.com_act.WGATH001.RCODUCO` | no existe en la tabla y la usa mod_rep.com.GDCGEST_ACTIVAST02 |
| error | `columna-inexistente` | `storage.com_act.WGATH001.RDESUCO` | no existe en la tabla y la usa mod_rep.com.GDCGEST_ACTIVAST02 |
| error | `columna-inexistente` | `storage.com_act.WIMR001.haseoper` | no existe en la tabla y la usa mod_rep.com.RSIMR01 |
| error | `columna-inexistente` | `storage.ref.WJERCOR01.RCODADM` | no existe en la tabla y la usa mod_rep.com.GRESPDATOS01 |
| error | `parametros-de-mas` | `HTTPTRACE_01` | reportes.json envía 2 parámetro(s) y strategos.mod_rep_com_act.HTTPTRACE declara 0 |
| error | `parametros-faltantes` | `DESE_SOC_01` | reportes.json envía 1 y mod_rep.com.RSDESEMP01 exige 3 sin valor por defecto |
| error | `tabla-inexistente` | `mod_rep.com.#temp3` | no existe en la base: la usan mod_rep.com.GRESCAMCOND03 |
| error | `tabla-inexistente` | `mod_rep.com.Datos_AGR` | no existe en la base: la usan mod_rep.com.RS_AGE_COM_CR_02, mod_rep.com.RS_AGE_COM_CR_M_02, mod_rep.com.RS_AGE_COM_CR_M_04 |
| error | `tabla-inexistente` | `mod_rep.com.Datos_PD` | no existe en la base: la usan mod_rep.com.RSPROYCOLDES009 |
| error | `tabla-inexistente` | `mod_rep.com.FLIMNEG` | no existe en la base: la usan mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA037 |
| error | `tabla-inexistente` | `mod_rep.com.TDILMETA` | no existe en la base: la usan mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA037 |
| error | `tabla-inexistente` | `mod_rep.com.TEMP_RESDMOV01_MOV` | no existe en la base: la usan mod_rep.com.RESDMOV01 |
| error | `tabla-inexistente` | `mod_rep.com.TFECMES` | no existe en la base: la usan mod_rep.com.RSRDMA023 |
| error | `tabla-inexistente` | `mod_rep.dbo.a` | no existe en la base: la usan mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCOSEMAF002, mod_rep.com.GDCGEST_ACTIVAST02, mod_rep.com.GDCLIOPE01, mod_rep.com.GPDM001, mod_rep.com.GRESREPSEG03, mod_rep.com.GRESREPSEG04, mod_rep.com.GRESREPSEG06, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GSEGCAPBP01, mod_rep.com.RCORRES06, mod_rep.com.RGRAFGESTCOM02, mod_rep.com.RGRAFGESTCOM05, mod_rep.com.RGRAFGESTCOM06, mod_rep.com.RMORAGP01, mod_rep.com.RPROSCORR002, mod_rep.com.RPROSCORR004, mod_rep.com.RPROSCORR005, mod_rep.com.RPROSCORR006, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSGETCOM01, mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFER02, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA037, mod_rep.com.RSTABCOMER, mod_rep.com.RTABDIGCOM01 |
| error | `tabla-inexistente` | `mod_rep.dbo.Datos_AGR` | no existe en la base: la usan mod_rep.com.RS_AGE_COM_CR_02, mod_rep.com.RS_AGE_COM_CR_M_02, mod_rep.com.RS_AGE_COM_CR_M_04 |
| error | `tabla-inexistente` | `mod_rep.dbo.Datos_PD` | no existe en la base: la usan mod_rep.com.RSPROYCOLDES009 |
| error | `tabla-inexistente` | `mod_rep.dbo.TEMP_RESDMOV01_MOV` | no existe en la base: la usan mod_rep.com.RESDMOV01 |
| error | `tabla-inexistente` | `mod_rep.piv.TPIVCONF` | no existe en la base: la usan mod_rep.com.GCMCNUE001, mod_rep.com.GCMCNUE002, mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GDACDESEM01, mod_rep.com.GDCGEST_ACTIVAST01, mod_rep.com.GDCGEST_ACTIVAST03, mod_rep.com.GDCGEST_ACTIVAST04, mod_rep.com.GDCLIOPE01, mod_rep.com.GPASP001, mod_rep.com.GPDM001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG_01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSEGCAPBP01, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RGRAFGESTCOM01, mod_rep.com.RGRAFGESTCOM02, mod_rep.com.RGRAFSEGPAS01, mod_rep.com.RGRAFSEGPAS02, mod_rep.com.RMORAGP01, mod_rep.com.RSAGECOM01, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSGETCOM01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP001, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA021, mod_rep.com.RSRDFCA022, mod_rep.com.RSRDFCA023, mod_rep.com.RSRDFCA024, mod_rep.com.RSRDFCA025, mod_rep.com.RSRDFCA026, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA031, mod_rep.com.RSRDFCA032, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDFCA037, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS03, mod_rep.com.RSTABCOMER, mod_rep.com.RTABDIGCOM01 |
| error | `tabla-inexistente` | `mod_rep.piv.TPIVFIL` | no existe en la base: la usan mod_rep.com.GCMCNUE001, mod_rep.com.GCMCNUE002, mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GDACDESEM01, mod_rep.com.GDCGEST_ACTIVAST01, mod_rep.com.GDCGEST_ACTIVAST03, mod_rep.com.GDCGEST_ACTIVAST04, mod_rep.com.GDCLIOPE01, mod_rep.com.GPASP001, mod_rep.com.GPDM001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG_01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSEGCAPBP01, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RGRAFGESTCOM01, mod_rep.com.RGRAFGESTCOM02, mod_rep.com.RGRAFSEGPAS01, mod_rep.com.RGRAFSEGPAS02, mod_rep.com.RMORAGP01, mod_rep.com.RSAGECOM01, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSGETCOM01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP001, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA021, mod_rep.com.RSRDFCA022, mod_rep.com.RSRDFCA023, mod_rep.com.RSRDFCA024, mod_rep.com.RSRDFCA025, mod_rep.com.RSRDFCA026, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA031, mod_rep.com.RSRDFCA032, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDFCA037, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS03, mod_rep.com.RSTABCOMER, mod_rep.com.RTABDIGCOM01 |
| error | `tabla-inexistente` | `mod_rep.piv.TPIVVAR` | no existe en la base: la usan mod_rep.com.GCMCNUE001, mod_rep.com.GCMCNUE002, mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GDACDESEM01, mod_rep.com.GDCGEST_ACTIVAST01, mod_rep.com.GDCGEST_ACTIVAST03, mod_rep.com.GDCGEST_ACTIVAST04, mod_rep.com.GDCLIOPE01, mod_rep.com.GPASP001, mod_rep.com.GPDM001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG_01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSEGCAPBP01, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RGRAFGESTCOM01, mod_rep.com.RGRAFGESTCOM02, mod_rep.com.RGRAFSEGPAS01, mod_rep.com.RGRAFSEGPAS02, mod_rep.com.RMORAGP01, mod_rep.com.RSAGECOM01, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSGETCOM01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP001, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA021, mod_rep.com.RSRDFCA022, mod_rep.com.RSRDFCA023, mod_rep.com.RSRDFCA024, mod_rep.com.RSRDFCA025, mod_rep.com.RSRDFCA026, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA031, mod_rep.com.RSRDFCA032, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDFCA037, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS03, mod_rep.com.RSTABCOMER, mod_rep.com.RTABDIGCOM01 |
| error | `tabla-inexistente` | `mod_rep.rep.FFORMAT` | no existe en la base: la usan mod_rep.rep.GSREVA01 |
| error | `tabla-inexistente` | `mod_rep.rep.FFTHCOLDEF` | no existe en la base: la usan mod_rep.com.DINCEPDM01, mod_rep.com.GCMCNUE001, mod_rep.com.GCMCNUE002, mod_rep.com.GCMGCAP01, mod_rep.com.GCOMCRE01, mod_rep.com.GCOMCRE02, mod_rep.com.GCOSELIS001, mod_rep.com.GCOSEMAF002, mod_rep.com.GDASHKAY03, mod_rep.com.GDASHKAY05, mod_rep.com.GDASHKAY06, mod_rep.com.GDCGEST_ACTIVAST02, mod_rep.com.GDCLIOPE01, mod_rep.com.GLIMOVO01, mod_rep.com.GLIMOVO02, mod_rep.com.GLIMOVO05, mod_rep.com.GLIMOVO06, mod_rep.com.GLIMOVRO01, mod_rep.com.GLIMOVRO05, mod_rep.com.GLIMOVRO06, mod_rep.com.GLISAUTO01, mod_rep.com.GLISAUTRO05, mod_rep.com.GLISCAPRET01, mod_rep.com.GLISPROSP01, mod_rep.com.GPASP001, mod_rep.com.GPDM001, mod_rep.com.GPRECOSCUAD001, mod_rep.com.GPRECOSELIS001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND01, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESCAMIMP01, mod_rep.com.GRESDESCRE02, mod_rep.com.GRESPDATOS01, mod_rep.com.GRESPDATOS02, mod_rep.com.GRESPROGOB01, mod_rep.com.GRESPROGOB02, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG05, mod_rep.com.GRESREPSEG06, mod_rep.com.GRESTOPIMP01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRTABCORRO01, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSCAMP01, mod_rep.com.GSCASEG01, mod_rep.com.GSEGCAPBP01, mod_rep.com.GSEGCAPBP02, mod_rep.com.GSEGCAPRED01, mod_rep.com.GSELCIUT002, mod_rep.com.GSELJERAR001, mod_rep.com.GSELJERAR002, mod_rep.com.GSMODAGEN01, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RACTGP01, mod_rep.com.RCORRES01, mod_rep.com.RCORRES06, mod_rep.com.RDETCORR01, mod_rep.com.RENRCOLAB01, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RENRPAS01, mod_rep.com.RENRPAS02, mod_rep.com.RESDMOV01, mod_rep.com.RESDMOV02, mod_rep.com.RINCEGP01, mod_rep.com.RMESA01, mod_rep.com.RMORAGP01, mod_rep.com.RPROSCORR002, mod_rep.com.RPROSCORR005, mod_rep.com.RS_AGE_COM_CR_01, mod_rep.com.RS_AGE_COM_CR_02, mod_rep.com.RS_AGE_COM_CR_M_01, mod_rep.com.RS_AGE_COM_CR_M_02, mod_rep.com.RS_AGE_COM_CR_M_03, mod_rep.com.RS_AGE_COM_CR_M_04, mod_rep.com.RSAPPUSO001, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS02, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSDESEMP01, mod_rep.com.RSDESEMP02, mod_rep.com.RSDESEMPAS01, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSHHCARB001, mod_rep.com.RSLISTCCN01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFE05, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFER02, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP004, mod_rep.com.RSPANSUP005, mod_rep.com.RSPROYCOLDES001, mod_rep.com.RSPROYCOLDES002, mod_rep.com.RSPROYCOLDES003, mod_rep.com.RSPROYCOLDES004, mod_rep.com.RSPROYCOLDES005, mod_rep.com.RSPROYCOLDES006, mod_rep.com.RSPROYCOLDES007, mod_rep.com.RSPROYCOLDES008, mod_rep.com.RSPROYCOLDES009, mod_rep.com.RSPROYCOLDES010, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDMA023, mod_rep.com.RSRSRV001, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPDM01 |
| error | `tabla-inexistente` | `mod_rep.rep.FUMB` | no existe en la base: la usan mod_rep.rep.GSREVA01 |
| error | `tabla-inexistente` | `mod_rep.rep.if` | no existe en la base: la usan mod_rep.rep.RTABCUERES01 |
| error | `tabla-inexistente` | `mod_rep.rep.TCADS` | no existe en la base: la usan mod_rep.com.GCMGCAP01, mod_rep.com.GRESCAMCOND01, mod_rep.com.GRESCAMIMP01, mod_rep.com.GRESTOPIMP01, mod_rep.com.GSCAMP01, mod_rep.com.GSCASEG01, mod_rep.com.GSMODAGEN01 |
| error | `tabla-inexistente` | `mod_rep.rep.TFECMES` | no existe en la base: la usan mod_rep.com.GSCAMP01 |
| error | `tabla-inexistente` | `mod_rep.rep.TTHCOLDEF` | no existe en la base: la usan mod_rep.com.DINCEPDM01, mod_rep.com.GCMCNUE001, mod_rep.com.GCMCNUE002, mod_rep.com.GCMGCAP01, mod_rep.com.GCOMCRE01, mod_rep.com.GCOMCRE02, mod_rep.com.GCOSELIS001, mod_rep.com.GCOSEMAF002, mod_rep.com.GDASHKAY03, mod_rep.com.GDASHKAY05, mod_rep.com.GDASHKAY06, mod_rep.com.GDCGEST_ACTIVAST02, mod_rep.com.GDCLIOPE01, mod_rep.com.GLIMOVO01, mod_rep.com.GLIMOVO02, mod_rep.com.GLIMOVO05, mod_rep.com.GLIMOVO06, mod_rep.com.GLIMOVRO01, mod_rep.com.GLIMOVRO05, mod_rep.com.GLIMOVRO06, mod_rep.com.GLISAUTO01, mod_rep.com.GLISAUTRO05, mod_rep.com.GLISCAPRET01, mod_rep.com.GLISPROSP01, mod_rep.com.GPASP001, mod_rep.com.GPDM001, mod_rep.com.GPRECOSCUAD001, mod_rep.com.GPRECOSELIS001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND01, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESCAMIMP01, mod_rep.com.GRESDESCRE02, mod_rep.com.GRESPDATOS01, mod_rep.com.GRESPDATOS02, mod_rep.com.GRESPROGOB01, mod_rep.com.GRESPROGOB02, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG05, mod_rep.com.GRESREPSEG06, mod_rep.com.GRESTOPIMP01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRTABCORRO01, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSCAMP01, mod_rep.com.GSCASEG01, mod_rep.com.GSEGCAPBP01, mod_rep.com.GSEGCAPBP02, mod_rep.com.GSEGCAPRED01, mod_rep.com.GSELCIUT002, mod_rep.com.GSELJERAR001, mod_rep.com.GSELJERAR002, mod_rep.com.GSMODAGEN01, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RACTGP01, mod_rep.com.RCORRES01, mod_rep.com.RCORRES06, mod_rep.com.RDETCORR01, mod_rep.com.RENRCOLAB01, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RENRPAS01, mod_rep.com.RENRPAS02, mod_rep.com.RESDMOV01, mod_rep.com.RESDMOV02, mod_rep.com.RINCEGP01, mod_rep.com.RMESA01, mod_rep.com.RMORAGP01, mod_rep.com.RPROSCORR002, mod_rep.com.RPROSCORR005, mod_rep.com.RS_AGE_COM_CR_01, mod_rep.com.RS_AGE_COM_CR_02, mod_rep.com.RS_AGE_COM_CR_M_01, mod_rep.com.RS_AGE_COM_CR_M_02, mod_rep.com.RS_AGE_COM_CR_M_03, mod_rep.com.RS_AGE_COM_CR_M_04, mod_rep.com.RSAGECOM01, mod_rep.com.RSAPPUSO001, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS02, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSDESEMP01, mod_rep.com.RSDESEMP02, mod_rep.com.RSDESEMPAS01, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSHHCARB001, mod_rep.com.RSLISTCCN01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFE05, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFER02, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP001, mod_rep.com.RSPANSUP004, mod_rep.com.RSPANSUP005, mod_rep.com.RSPROYCOLDES001, mod_rep.com.RSPROYCOLDES002, mod_rep.com.RSPROYCOLDES003, mod_rep.com.RSPROYCOLDES004, mod_rep.com.RSPROYCOLDES005, mod_rep.com.RSPROYCOLDES006, mod_rep.com.RSPROYCOLDES007, mod_rep.com.RSPROYCOLDES008, mod_rep.com.RSPROYCOLDES009, mod_rep.com.RSPROYCOLDES010, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDMA023, mod_rep.com.RSRSRV001, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPDM01 |
| error | `tabla-inexistente` | `mod_rep.util.FFMTVAR` | no existe en la base: la usan mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GCOMCRE01, mod_rep.com.GCOMCRE02, mod_rep.com.GDCLIOPE01, mod_rep.com.GSEGCAPBP01, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDESEMP01, mod_rep.com.RSDESEMP02, mod_rep.com.RSDESEMPAS01, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSRDFCA011 |
| error | `tabla-inexistente` | `mod_rep.util.FSEMVAR` | no existe en la base: la usan mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GCOMCRE01, mod_rep.com.GDCLIOPE01, mod_rep.com.GSEGCAPBP01, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDESEMP01, mod_rep.com.RSDESEMP02, mod_rep.com.RSDESEMPAS01, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036 |
| error | `tabla-inexistente` | `storage.api.FUSECDIV01` | no existe en la base: la usan mod_rep.com.RSPANSUP003 |
| error | `tabla-inexistente` | `storage.com_act.SDAF002_SINFAEREACT` | no existe en la base: la usan mod_rep.com.GDACDESEM01 |
| error | `tabla-inexistente` | `storage.com_act.VCAH004` | no existe en la base: la usan mod_rep.com.RSPROYCOLDES001, mod_rep.com.RSPROYCOLDES003, mod_rep.com.RSPROYCOLDES006 |
| error | `tabla-inexistente` | `storage.com_act.WBCH001` | no existe en la base: la usan mod_rep.com.GCOSELIS001 |
| error | `tabla-inexistente` | `storage.com_act.WHBECA001` | no existe en la base: la usan mod_rep.com.RSCLIVULNER01 |
| error | `tabla-inexistente` | `storage.com_act.WTRXMON001` | no existe en la base: la usan mod_rep.com.GRTABAPPO01 |
| error | `tabla-inexistente` | `storage.com_pas.SDPF007` | no existe en la base: la usan mod_rep.com.GSEGCAPBP02 |
| error | `tabla-inexistente` | `storage.com_pas.WJAS002` | no existe en la base: la usan mod_rep.com.RSCMGCLIPAS02 |
| error | `tabla-inexistente` | `STORAGE.com_pas.WJAS009` | no existe en la base: la usan mod_rep.com.GSEGCAPBP01 |
| error | `tabla-inexistente` | `storage.com_pas.WJAS010` | no existe en la base: la usan mod_rep.com.GSEGCAPBP02 |
| error | `tabla-inexistente` | `storage.com.FCAMPFEC2` | no existe en la base: la usan mod_rep.com.GSCAMP01 |
| error | `tabla-inexistente` | `storage.com.metas_saldos` | no existe en la base: la usan mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRESREPSEG05, mod_rep.com.RPROSCORR005, mod_rep.com.RSSEGPDM01 |
| error | `tabla-inexistente` | `storage.ref.REABP01` | no existe en la base: la usan mod_rep.com.GSEGCAPBP02 |
| error | `tabla-inexistente` | `storage.ref.ResGridCiiu2` | no existe en la base: la usan mod_rep.com.RSEGSECTOR001 |
| aviso | `codigo-duplicado` | `CLI_VULNERABLE_01` | aparece 2 veces en reportes.json (entradas idénticas) |
| aviso | `codigo-duplicado` | `PANEL_SUP_02` | aparece 2 veces en reportes.json (entradas idénticas) |
| aviso | `columna-inexistente` | `STORAGE.com_act.HBMOV001.mm` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `STORAGE.com_act.HBMOV001.yyyy` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `STORAGE.com_act.HBMOV003.mm` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `STORAGE.com_act.HBMOV003.yyyy` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.com_act.HRESINC001.des_gru` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.com_act.WCRE001.GROUPING` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.com.VDMCOM01.month` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.com.VDMCOM01.Tip_cod` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.com.VDMCOM01.tip_cod2` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.ref.RCALEN001.day` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.ref.RCALEN001.MM` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.ref.RCALEN001.MONTH` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `storage.ref.RCALEN001.yy` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-inexistente` | `strategos.etl.ABPEVLOG01.dd` | inferida pero no existe en la tabla: el analizador la atribuyó mal o es un alias |
| aviso | `columna-sin-resolver` | `mod_rep.com.DINCEPDM01` | `HFECPRO` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.DINCEPDM01` | `HCODOPE` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.DINCEPDM01` | `HNROG` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.DINCEPDM01` | `HMONDESMN` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.DINCEPDM01` | `HDOCC` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HAVG_OPE` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HMAX_OPE` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HAVG_DURA` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HMAX_DURA` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HAVG_ASIST` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HMAX_ASIST` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HSALVENMN_CC` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HCAST12M` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HVENTA_CARTMN12M` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HRECCAST12M` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HSALCAPMN_CC` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HSALVENMN_SC` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE01` | `HSALCAPMN_SC` podría ser de storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE02` | `HMIN_DURA_H` podría ser de storage.com_act.WDCB003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE02` | `HMAX_DURA_H` podría ser de storage.com_act.WDCB003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE02` | `HOPE_APROB` podría ser de storage.com_act.WDCB003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE02` | `HOPE_OBS` podría ser de storage.com_act.WDCB003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOMCRE02` | `HOPE_RECH` podría ser de storage.com_act.WDCB003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSELIS001` | `HTIPCMB` podría ser de storage.com_act.HCDA001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSELIS001` | `HRANDES` podría ser de storage.com_act.SRCC001 o storage.com_act.SRIESGO001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSELIS001` | `RDESPROD` podría ser de storage.com_act.SRCC001 o storage.com_act.SRIESGO001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSEMAF002` | `RDESTER` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSEMAF002` | `RDESCOR` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSEMAF002` | `RDESGRU` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSEMAF002` | `RDESADM` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GCOSEMAF002` | `RDESPROD` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_ACTIVAST01` | `RDESGRU01` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.WGATH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_ACTIVAST01` | `RDESPROD` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.WGATH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_ACTIVAST01` | `ORD` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.WGATH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_ACTIVAST02` | `RINDFEC` podría ser de storage.com_act.WGATH001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_ACTIVAST02` | `ORD` podría ser de storage.com_act.WGATH001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_PASIVAST01` | `HMAPER` podría ser de storage.com_pas.WBAUT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_PASIVAST01` | `HAOTASA` podría ser de storage.com_pas.WBAUT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_PASIVAST01` | `HTMAXI` podría ser de storage.com_pas.WBAUT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_PASIVAST01` | `HFECPRO` podría ser de storage.com_pas.WBAUT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_PASIVAST01` | `HRENOV` podría ser de storage.com_pas.WBAUT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_PASIVAST01` | `HDMODU` podría ser de storage.com_pas.WBAUT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GDCGEST_PASIVAST01` | `CANAL` podría ser de storage.com_pas.WBAUT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GLIMOVO01` | `HMOTIV` podría ser de STORAGE.com_act.HBMOV001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GLIMOVRO01` | `HMOTIV` podría ser de STORAGE.com_act.HBMOV001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSCUAD001` | `RDESTER` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSCUAD001` | `RDESCOR` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSCUAD001` | `RDESGRU` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSCUAD001` | `RDESADM` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSCUAD001` | `RDESPROD` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSELIS001` | `HCTACLI` podría ser de storage.com_act.WBCH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSELIS001` | `HDESCLI` podría ser de storage.com_act.WBCH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSELIS001` | `HCODOPE` podría ser de storage.com_act.WBCH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSELIS001` | `HMONDESMN` podría ser de storage.com_act.WBCH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSELIS001` | `HSUCCLI` podría ser de storage.com_act.WBCH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSELIS001` | `HCODMOD` podría ser de storage.com_act.WBCH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GPRECOSELIS001` | `HDTIPOPE` podría ser de storage.com_act.WBCH002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESDESCRE02` | `RCODTER` podría ser de storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESDESCRE02` | `RCODCOR` podría ser de storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESDESCRE02` | `RCODUNI` podría ser de storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESDESCRE02` | `RCODUCO` podría ser de storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESDESCRE02` | `RINDFEC` podría ser de storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPDATOS01` | `htipo` podría ser de storage.gpr.VPPH001 o storage.ref.WJERCOR01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPDATOS01` | `hratio` podría ser de storage.gpr.VPPH001 o storage.ref.WJERCOR01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPDATOS01` | `hcindi` podría ser de storage.gpr.VPPH001 o storage.ref.WJERCOR01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPDATOS01` | `RINDFEC` podría ser de storage.ref.WJERCOR01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPDATOS02` | `htipo` podría ser de storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPDATOS02` | `hratio` podría ser de storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPDATOS02` | `hcindi` podría ser de storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPROGOB01` | `HFECPRO` podría ser de storage.com_act.HCDA001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESPROGOB02` | `HFECPRO` podría ser de storage.com_act.HCDA001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG_01` | `pvt.SCODDESCRIP`: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG01` | `SEG` podría ser de storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG01` | `RINDFEC` podría ser de storage.com_seg.VCSH006 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG01` | `SCODSEC` podría ser de storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG01` | `HCODSEC` podría ser de storage.com_seg.VCSH006 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG01` | `pvt.SCODDESCRIP`: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG02` | `SEG` podría ser de storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG02` | `RINDFEC` podría ser de storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG02` | `pvt.SCODDESCRIP`: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG05` | `SFECPRO` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAF002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG05` | `SCODAGR` podría ser de storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAF002 o storage.com_seg.SDSF001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG05` | `RCODPROD` podría ser de storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG05` | `RINDFEC` podría ser de storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG05` | `SCODSEG` podría ser de storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG05` | `pvt.SCODDESCRIP`: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG06` | `SCODMOD` podría ser de storage.com_act.SDAF002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG06` | `STIPOPE` podría ser de storage.com_act.SDAF002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG06` | `SSUBTIP` podría ser de storage.com_act.SDAF002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG06` | `SCODAGR` podría ser de storage.com_act.SDAF002 o storage.com_seg.SDSF001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG06` | `scodseg` podría ser de storage.com_seg.SDSF001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRESREPSEG06` | `pvt.SCODDESCRIP`: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRGCTABDIGO02` | `hfecpro` podría ser de storage.com_act.WUSABCLIENR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRGCTABDIGO02` | `htipcod` podría ser de storage.com_act.WUSABCLIENR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRGCTABDIGO02` | `hcodrel` podría ser de storage.com_act.WUSABCLIENR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR001` | `SNUMPLZ` podría ser de storage.com_seg.SDSF001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR001` | `HNUMRETENCION` podría ser de storage.com_act.WCLIRETE001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR001` | `HNUMCLISTOCK` podría ser de storage.com_act.WCLIRETE001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR001` | `HCODVAR` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR001` | `HTIPCOD` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR001` | `HCODREL` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR002` | `HCODVAR` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR002` | `hcodrel` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR002` | `HFECPRO` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR002` | `HTIPMETA` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRMENTOR002` | `HTIPCOD` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HTIPCRED` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HTIPPASI` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HTIPAMBO` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HTIPFALT` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HPERCENTCART` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HPERCENTPASI` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HTOTALCLIENROL` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HPERCENTUSABILIDAD` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HPERCENTENROCLINET` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `HDATINPUTRXUSA` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABAPPO01` | `hcodrel` podría ser de storage.com.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABCORRO01` | `STERRIT` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABCORRO01` | `SCORRED` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABCORRO01` | `SAGENCI` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GRTABCORRO01` | `SCORRES` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HFECPRO` podría ser de storage.com_act.HTDA001 o storage.com_act.WAPPCLI001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HTIPNUMDOC` podría ser de storage.com_act.WAPPCLI001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HTIPDOC` podría ser de storage.com_act.HTDA001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HNUMDOC` podría ser de storage.com_act.HTDA001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HPENDOC` podría ser de storage.com_pas.HCDP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HPETDOC` podría ser de storage.com_pas.HCDP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HPEPAIS` podría ser de storage.com_pas.HCDP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HSBCTA` podría ser de storage.com_pas.HCDP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HSBOPER` podría ser de storage.com_pas.HCDP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HSBSBOP` podría ser de storage.com_pas.HCDP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP01` | `HCODSEC` podría ser de storage.com_pas.HCDP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `rord` podría ser de storage.ref.REABP01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `sfecpro` podría ser de storage.ref.REABP01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `SINTMESSALMN` podría ser de storage.ref.REABP01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.GSEGCAPBP02` | `SSALMN` podría ser de storage.ref.REABP01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RACTGP01` | `RCODTER` podría ser de storage.com_act.WACTGRP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RACTGP01` | `RCODCOR` podría ser de storage.com_act.WACTGRP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RACTGP01` | `RCODGRU` podría ser de storage.com_act.WACTGRP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RACTGP01` | `RCODUNI` podría ser de storage.com_act.WACTGRP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RACTGP01` | `RCODUCO` podría ser de storage.com_act.WACTGRP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `STERRIT` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `SCORRED` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `SAGENCI` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `SFECPRO` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `SCORRES` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `STIPTRA` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `SNUMTRANS` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `SMONTO` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `STICKPROM` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES01` | `SNUMCORRE` podría ser de storage.com_act.SDAS021: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES05` | `HFECPRO` podría ser de STORAGE.com_act.HCGEO002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES05` | `HNOMCOR` podría ser de STORAGE.com_act.HCGEO002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES05` | `HCOORDE` podría ser de STORAGE.com_act.HCGEO002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES05` | `HTERRIT` podría ser de STORAGE.com_act.HCGEO002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES05` | `HCORRED` podría ser de STORAGE.com_act.HCGEO002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RCORRES05` | `HAGENCI` podría ser de STORAGE.com_act.HCGEO002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RDETCORR01` | `HFECHAMOV` podría ser de storage.com_act.HCMC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RDETCORR01` | `HCAUSAL` podría ser de storage.com_act.HCMC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RDETCORR01` | `hfecpro` podría ser de storage.com_act.HCMC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RDETCORR01` | `HTIPOTRN` podría ser de storage.com_act.HCMC001 o storage.ref.vjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RDETCORR01` | `HVALORTX` podría ser de storage.com_act.HCMC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRCOLAB01` | `HNUMDOC` podría ser de storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRCOLAB01` | `hfecpro` podría ser de storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRCOLAB01` | `rcodter` podría ser de storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRCOLAB01` | `rcodcor` podría ser de storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRCOLAB01` | `rcodmat` podría ser de storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRCOLAB01` | `RCODAGEH` podría ser de storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `HUSERBP` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001 o storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `HSBFECH` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `dw` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `day` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `HSBTOPE` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `HCODSEC` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `HESTADO` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `HSBSDO1` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `nro_Clientes` podría ser de storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `nro_clientes_instalados` podría ser de storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `nro_clientes_apertura` podría ser de storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS01` | `nro_clientes_apertura_instalados` podría ser de storage.gpr.VPPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `HSBSUC` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `HSBFECH` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `dw` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `day` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `HSBTOPE` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `HCODSEC` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `HESTADO` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RENRPAS02` | `HSBSDO1` podría ser de storage.com_act.VLCAPP001 o storage.com_pas.VCPH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM05` | `hfecpro` podría ser de storage.com_act.WJAS001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM05` | `hnumcli` podría ser de storage.com_act.WJAS001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM06` | `hfecpro` podría ser de STORAGE.COM_ACT.WTIPCLI001 o storage.com_act.wjas001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM06` | `HNUMCLIN` podría ser de storage.com_act.wjas001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM06` | `HNUMCLIINGR` podría ser de STORAGE.COM_ACT.WTIPCLI001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM06` | `HNUMCLIVENC` podría ser de STORAGE.COM_ACT.WTIPCLI001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM06` | `HNUMCLIPROG` podría ser de STORAGE.COM_ACT.WTIPCLI001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RGRAFGESTCOM06` | `HNUMCLIANTI` podría ser de STORAGE.COM_ACT.WTIPCLI001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RINCEGP01` | `HINDCAR` podría ser de storage.com_act.RFOC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RMORAGP01` | `HESTG` podría ser de storage.com_act.HDGP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RMORAGP01` | `HESTI` podría ser de storage.com_act.HDGP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RMORAGP01` | `hfecpro` podría ser de storage.com_act.HDGP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RMORAGP01` | `HNROG` podría ser de storage.com_act.HDGP001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RPROSCORR005` | `HFECPRO` podría ser de storage.ref.vjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `HEVTO` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `HINDBASE` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `HNUMCON` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `HINDDESB` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `HFECPRO` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `RCODTER` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `RCODCOR` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `RCODGRU` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `RCODUNI` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `RCODUCO` podría ser de storage.com_act.WABDC001 o storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSAGECOM01` | `Rowsort` podría ser de storage.com_act.VABRE001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `rindfec` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `RCODFC` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `RCODGRU` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `RCODTER` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `RCODCOR` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `RCODUNI` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `RCODUCO` podría ser de storage.ref.wjercor03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP01` | `variables` podría ser de storage.com.VDMCOM01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP02` | `F` podría ser de storage.com_act.wacli007: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP02` | `HINDBANC` podría ser de storage.com_act.wacli007: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP02` | `HCODPER` podría ser de storage.com_act.wacli007: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP02` | `HINDGEN` podría ser de storage.com_act.wacli007: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP02` | `HINDRUR` podría ser de storage.com_act.wacli007: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP02` | `HINDMIGR` podría ser de storage.com_act.wacli007: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSDESEMP02` | `hcodsec` podría ser de storage.com_act.wacli007: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `ORD` podría ser de storage.com_act.WACIIU0013 o storage.ref.WJERCOR01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `codvarsFormat` podría ser de storage.ref.ResGridCiiu2: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem1` podría ser de storage.ref.ResGridCiiu2: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem2` podría ser de storage.ref.ResGridCiiu2: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem3` podría ser de storage.ref.ResGridCiiu2: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSEGSECTOR001` | `Sem4` podría ser de storage.ref.ResGridCiiu2: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSHHCARB001` | `HHUCARUN` podría ser de storage.COM.HHDC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSHHCARB001` | `HHCARBCA` podría ser de storage.COM.HHDC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSHHCARB001` | `HHCARBMO` podría ser de storage.COM.HHDC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSHHCARB001` | `HHUECARUN` podría ser de storage.COM.HHDC002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSHHCARB001` | `HHUECARCA` podría ser de storage.COM.HHDC002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSHHCARB001` | `HHUECARMO` podría ser de storage.COM.HHDC002: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSIMR01` | `HDESPROD` podría ser de storage.com_act.WIMR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSIMR01` | `HFECPRO` podría ser de storage.com_act.WIMR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSIMR01` | `HTIPO_IS` podría ser de storage.com_act.WIMR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSIMR01` | `HMONTIPOMN` podría ser de storage.com_act.WIMR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSIMR01` | `HFLAG_ASESOR` podría ser de storage.com_act.WIMR001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSMONEFE02` | `HINDBASE` podría ser de storage.com_act.WCED001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `RFECPRO` podría ser de storage.gpr.HPAD001 o storage.ref.RECCA001 o storage.ref.RECCT001 o storage.ref.RECUC001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `RDESGRU` podría ser de storage.gpr.HPAD001 o storage.ref.RECCA001 o storage.ref.RECCT001 o storage.ref.RECUC001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `RINDFEC` podría ser de storage.gpr.HPAD001 o storage.ref.RECCA001 o storage.ref.RECCT001 o storage.ref.RECUC001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `RCODADM` podría ser de storage.gpr.HPAD001 o storage.ref.RECCT001 o storage.ref.RECUC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `rcodsec` podría ser de storage.gpr.HPAD001 o storage.ref.RECUC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `RCODTER` podría ser de storage.gpr.HPAD001 o storage.ref.RECUC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `SCODUSE` podría ser de storage.gpr.HPAD001 o storage.ref.RECUC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `RCODCOR` podría ser de storage.ref.RECCA001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP001` | `RCODGRU` podría ser de storage.ref.RECCA001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP003` | `SOPEPOST` podría ser de storage.com_act.SDAS006 o storage.ref.REAM001 o storage.ref.REMR001 o storage.ref.RERT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP003` | `SOPESEAL` podría ser de storage.com_act.SDAS006 o storage.ref.REAM001 o storage.ref.REMR001 o storage.ref.RERT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSPANSUP003` | `SOPEREGR` podría ser de storage.com_act.SDAS006 o storage.ref.REAM001 o storage.ref.REMR001 o storage.ref.RERT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA035` | `hfecpro` podría ser de storage.com_act.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA035` | `htipcod` podría ser de storage.com_act.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA035` | `hcodrel` podría ser de storage.com_act.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA035` | `RDESCPROD02` podría ser de storage.com_act.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA036` | `hfecpro` podría ser de storage.com_pas.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA036` | `htipcod` podría ser de storage.com_pas.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA036` | `hcodrel` podría ser de storage.com_pas.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDFCA036` | `RDESCPROD02` podría ser de storage.com_pas.WJAS004: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HCODOPE` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HSALCAPMN` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HDIAATR` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HNOMREG` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HCODSEC` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HNUMDOC` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HTIPDOC` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HCTACLI` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HDESCLI` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HDSUCSEC` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HFECDES` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HTOTCUO` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HMONDES` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HINDCAR` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `HFECPRO` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `RCODTER` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `RCODCOR` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `RCODGRU` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `RCODUNI` podría ser de storage.com_act.VCAM001 o storage.ref.WJERCOR03: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `GESTION` podría ser de storage.com_act.VCAH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSRDMA023` | `PAGO` podría ser de storage.com_act.VCAH001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPAS03` | `num_pol_pasiv_3` podría ser de storage.com_seg.RETC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPAS03` | `num_pol_pasiv_2` podría ser de storage.com_seg.RETC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPAS03` | `cod_Prod_Seg` podría ser de storage.com_seg.RETC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPAS03` | `HCOMIFC` podría ser de storage.com_seg.RETC001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HDESREL` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HNUMCLI_ANT` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `10062` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HNUMCLI` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HNROG_ANT` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `10044` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HNROG` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `NUEVO_DESEM` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HNROG_DESEM` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HULTVEN_RECUR_DESEM` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `RECURRENTE_DESEM` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HSALCAPMN_ANT` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `8000` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HSALCAPMN` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HSALCAPMN_1_30_ANT` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HSALCAPMN_1_30` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HSALCAPMN_ma_30_ANT` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.com.RSSEGPDM01` | `HSALCAPMN_ma_30` podría ser de storage.com_act.WPDM001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.GSREVA01` | `SAMBFIL` podría ser de mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.GSREVA01` | `SDESVAR` podría ser de mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.GSREVA01` | `RDESVAR` podría ser de mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.GSREVA01` | `json` podría ser de mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.GSREVA01` | `path` podría ser de mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.RTABCUERES01` | `WACUMT1` podría ser de mod_rep.dbo.REVARPYG: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.RTABCUERES01` | `WACUMT2` podría ser de mod_rep.dbo.REVARPYG: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.RTABCUERES01` | `WACUMT3` podría ser de mod_rep.dbo.REVARPYG: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_rep.rep.RTABCUERES01` | `WACUMT4` podría ser de mod_rep.dbo.REVARPYG: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HNUMDOC` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HDESSEC` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCARSEC` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCATSEC` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HGENSEC` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HREQ001` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HREQ002` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HREQ003` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HREQ004` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCOM001` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCOM002` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCOM003` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCOM004` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCOM005` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCOM006` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCOMFIN` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HCODSEC` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `columna-sin-resolver` | `mod_sec.dbo.GCATSEC01` | `HFECPRO` podría ser de storage.gpr.HBASCAT001: calificarla con alias o confirmar con el motor |
| aviso | `discrepancia-motor` | `mod_rep.com.GRESCAMCOND03` | mod_rep.com.#temp3 aparece en el análisis estático pero no en el motor |
| aviso | `discrepancia-motor` | `mod_rep.com.RESDMOV01` | mod_rep.com.TEMP_RESDMOV01_MOV aparece en el análisis estático pero no en el motor |
| aviso | `discrepancia-motor` | `mod_rep.com.RS_AGE_COM_CR_02` | mod_rep.com.Datos_AGR aparece en el análisis estático pero no en el motor |
| aviso | `discrepancia-motor` | `mod_rep.com.RS_AGE_COM_CR_M_02` | mod_rep.com.Datos_AGR aparece en el análisis estático pero no en el motor |
| aviso | `discrepancia-motor` | `mod_rep.com.RS_AGE_COM_CR_M_04` | mod_rep.com.Datos_AGR aparece en el análisis estático pero no en el motor |
| aviso | `discrepancia-motor` | `mod_rep.com.RSPROYCOLDES009` | mod_rep.com.Datos_PD aparece en el análisis estático pero no en el motor |
| aviso | `discrepancia-motor` | `mod_rep.rep.RTABCUERES01` | mod_rep.rep.if aparece en el análisis estático pero no en el motor |
| aviso | `motor-con-error` | `mod_rep.com.GCMGCARTAS001` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.GRGCTABDIGO03` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.GRTABDIGO01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.GRTABDIGO02` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RAGROMIX` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RINCEPDM01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RMONINTCOM01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RRANKM02` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RREPGESTCOM02` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RREPGESTCOM03` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RS_AGROMIX_CHART` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RS_AGROMIX_CHART2` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RS_AGROMIX_CHART3` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RS_AGROMIX_CHART4` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSCAPCOME01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSCOMPAS01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSDEPGSOLID01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSEGASE01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRANKCOM01` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRDFCA038` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRDFCA050` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRDFCA050_3` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRDFCA050_4` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSROPERA001` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSROPERA002` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRTOPPOMIS001` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRTOPPOMIS002` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRTOPPOMIS003` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSRTOPPOMIS004` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSSALCARVIGE02` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSSEGPAS04` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.com.RSTABCOMER02` | El SP no existe en esta base |
| aviso | `motor-con-error` | `mod_rep.dbo.REPORTE_DEMO` | El SP no existe en esta base |
| aviso | `nombre-con-espacios` | `strategos.mod_rep_com_act.GDDESEMDIA` | escrito como "strategos.mod_rep_com_act.GDDESEMDIA  ": los espacios rompen búsquedas y comparaciones |
| aviso | `sql-dinamico` | `mod_rep.com.GCOSEMAF002` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GDASHCLI01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GDCEROCN004` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GDCGEST_ACTIVAST02` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GLISAUTRO05` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GRESCAMCOND01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GRESCAMCOND03` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GRESCAMIMP01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GRESREPSEG06` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GRESTOPIMP01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GRTABAPPO01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GRTABCORRO01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GSCAMP01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GSCASEG01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GSEGCAPBP01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GSEGCAPBP02` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GSEGCAPRED01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.GSMODAGEN01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RACTGP01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RCORRES01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RCORRES06` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RESDMOV01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.REXPAGRO01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RPROSCORR005` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_02` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_02` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_03` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RS_AGE_COM_CR_M_04` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSAGECOM02` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSAGECOM03` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSAPPUSO001` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSBASENEG01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSEGSECTOR001` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSMONRENT01` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSPANSUP001` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSPANSUP004` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSPANSUP005` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES001` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES002` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES009` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSPROYCOLDES010` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA021` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA022` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA023` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA024` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA025` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA026` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA031` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA032` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA035` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDFCA036` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| aviso | `sql-dinamico` | `mod_rep.com.RSRDMA023` | usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor |
| info | `analisis-aproximado` | `mod_rep.com.GCMCNUE001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GCMGMORA001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GCMGMORA001_SIMP` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GCMGMORA003` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GCOMCRE01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GCOMCRE02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GDACDESEM01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GDASHCLI01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GDCGEST_ACTIVAST01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GDCGEST_ACTIVAST02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GDCGEST_ACTIVAST03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GDCGEST_ACTIVAST04` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GDCGEST_PASIVAST01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GMOVCLI01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRESCAMCOND03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRESREPSEG_01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRESREPSEG01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRESREPSEG02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRESREPSEG05` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRESREPSEG06` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRMENTOR001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRMENTOR002` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GRTABAPPO01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.GSCAMP01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RACTGP01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSCMGCF001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSCMGCLIPAS01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSCMGCLIPAS02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSCMGCLIPAS03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSCMGFCA002` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSDESEMP01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSDESEMP02` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSDESEMPAS01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSEGSECTOR001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSGETCOM01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSIMR01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSMONEFE01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSMONEFER01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSMONEFER03` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSMONEFEREPRO01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSMONEFETRC01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA007` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA024` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA025` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA026` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA027` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA028` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA029` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA030` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA032` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA035` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA036` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDFCA037` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRDMA023` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSRPD001` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSSALCAR01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSSALCARVIGE01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.com.RSSEGPDM01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `analisis-aproximado` | `mod_rep.rep.GSREVA01` | PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven. |
| info | `parametro-con-variantes` | `cod_rel` | se escribe de 2 formas: `codrel` (6), `cod_rel` (298) |
| info | `parametro-con-variantes` | `fecha` | se escribe de 2 formas: `Fecha` (7), `fecha` (69) |
| info | `parametro-con-variantes` | `tip_cod` | se escribe de 2 formas: `tipcod` (8), `tip_cod` (289) |
| info | `parametro-nombre-distinto` | `actividadtasas_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `actividadtasas_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CaptaBP_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CaptaBP_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_02` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_02` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_03` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_03` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_04` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `CONT_ELECT_M_04` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DESE_SOC_01` | posición 1: `uni_cfg` en reportes.json, `@tip_cod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_02` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_02` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_03` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_03` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_04` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_04` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_05` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `DesemDiario_05` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `EfecRecTramos_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `EfecRecTramos_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GRESCONDO_02` | posición 6: `niveles` en reportes.json, `@vista` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_02` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_02` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_03` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_03` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_M_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_M_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_M_02` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_M_02` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_M_03` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `GST_PASIVA_M_03` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `PortafolioAgro_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `PortafolioAgro_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `PORTSUPE_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `PORTSUPE_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `PORTSUPE_02` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `PORTSUPE_02` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `R_APADRINA_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `R_APADRINA_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `R_APADRINA_01` | posición 3: `fecha` en reportes.json, `@fec` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `resultado_unidad_negocio_rma_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `resultado_unidad_negocio_rma_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `resultado_unidad_negocio_rma_ope_01` | posición 1: `tip_cod` en reportes.json, `@tipcod` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `resultado_unidad_negocio_rma_ope_01` | posición 2: `cod_rel` en reportes.json, `@codrel` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `RMENTORIN_02` | posición 3: `fec` en reportes.json, `@Fecha` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `RS_AGE_COM_02` | posición 3: `fecha` en reportes.json, `@fec` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `RS_AGE_COM_03` | posición 3: `fecha` en reportes.json, `@fec` en el SP (si el backend pasa por posición, no afecta) |
| info | `parametro-nombre-distinto` | `RS_AGE_COM_CRM_S_03` | posición 3: `ver` en reportes.json, `@pagen` en el SP (si el backend pasa por posición, no afecta) |
| info | `varios-resultados` | `mod_rep.com.DINCEPDM01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GCMGMORA001_SIMP` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GCMGMORA003` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GCOSELIS001` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GCOSEMAF002` | devuelve 4 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDASHCLI01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDASHKAY03` | devuelve 6 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDASHKAY05` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDASHKAY06` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDCEROCN003` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDCGEST_ACTIVAST01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDCGEST_ACTIVAST02` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDCGEST_ACTIVAST03` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDCGEST_ACTIVAST04` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GDCLIOPE01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLIMOVO01` | devuelve 5 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLIMOVO02` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLIMOVO05` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLIMOVO06` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLIMOVRO01` | devuelve 4 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLIMOVRO05` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLIMOVRO06` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLISAUTO01` | devuelve 5 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GLISAUTRO05` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GMOVCLI01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GPASP001` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GPDM001` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GPRECOSCUAD001` | devuelve 5 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GPRECOSELIS001` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESCAMCOND01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESCAMCOND03` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESPROGOB01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESPROGOB02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESREAGRO01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESREPSEG_01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESREPSEG03` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRESREPSEG04` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRMENTOR001` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GRTABAPPO01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GSCAMP01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.GSEGUIINC001` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RCARDZCUO01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RCORRES01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RCORRES05` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RDETCORR01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RESDMOV01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RESDMOV02` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RFECREPMEN` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RFECREPMEN02` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RGRAFSEGPAS01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RGRAFSEGPAS02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RINCEGP01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RMESA01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RPROSCORR002` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RPROSCORR004` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RPROSCORR006` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RRANKM01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RS_AGE_COM_CR_02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RS_AGE_COM_CR_M_02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RS_AGE_COM_CR_M_04` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSCLIVULNER01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSCMGCLIPAS03` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSDESEMB` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSDESEMB02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSEGSECTOR001` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSGETCOM01` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSIMR01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSLISTCCN01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSMONEFE02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSMONEFE05` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSMONEFER02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSMONEFER03` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSMONRENT01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSPROYCOLDES009` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRDFCA007` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRDFCA011` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRDFCA028` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRDFCA036` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRDFCA037` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRPD001` | devuelve 4 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRTOPMIS001` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRTOPMIS002` | devuelve 3 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRTOPMIS003` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSRTOPMIS004` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSSALCAR01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSSALCARVIGE01` | devuelve 4 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSSEGPAS01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSSEGPAS02` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSSEGPAS03` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RSTABCOMER` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RTABDIGCOM01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.com.RTOPZCUO01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_rep.rep.RTABCUERES01` | devuelve 2 conjuntos de resultados |
| info | `varios-resultados` | `mod_sec.dbo.GCATSEC01` | devuelve 2 conjuntos de resultados |
<!-- generado:fin -->
