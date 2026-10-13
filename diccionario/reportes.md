# Reportes → procedimientos

Un renglón por entrada de `fuente/reportes.json`. Varios RCODREP pueden ejecutar el mismo SP con parámetros distintos.

<!-- generado:inicio reportes -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| RCODREP | Descripción | Procedimiento | Parámetros (en orden) | Estado | Front MIS |
|---|---|---|---|---|---|
| `actividadtasas_01` | Actividad y Tasas | [strategos.mod_rep_com_act.GDACTITASA01](procedimientos/strategos/mod_rep_com_act/GDACTITASA01.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `AGRO_01` | AGRO | [mod_rep.com.GRESREAGRO01](procedimientos/mod_rep/com/GRESREAGRO01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Comercial Ejecutivo |
| `APP_USO_01` | Usabilidad APP | [mod_rep.com.RSAPPUSO001](procedimientos/mod_rep/com/RSAPPUSO001.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Aplicativo Movil |
| `CAP_SEGUI_BP_01` | Captaciones Seguimiento BP | [mod_rep.com.GSEGCAPBP01](procedimientos/mod_rep/com/GSEGCAPBP01.md) | `tip_cod`, `cod_rel`, `fec`, `prod` | ✅ validado | reportes / actividad-diaria / Captaciones |
| `CAP_SEGUI_BP_FC_01` | Gestión Red de Agencias | [mod_rep.com.GSEGCAPBP02](procedimientos/mod_rep/com/GSEGCAPBP02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `CAP_SEGUI_FC_BP_01` | Gestión Red de Agencias | [mod_rep.com.GSEGCAPBP02](procedimientos/mod_rep/com/GSEGCAPBP02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Captaciones |
| `CAP_SEGUI_RED_01` | Captaciones Seguimiento Red | [mod_rep.com.GSEGCAPRED01](procedimientos/mod_rep/com/GSEGCAPRED01.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `CaptaBP_01` | CMG CAPTACIONES BP | [strategos.mod_rep_com_act.GDCCAP_BP01](procedimientos/strategos/mod_rep_com_act/GDCCAP_BP01.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `CARACT_CARTERA_01` | CARACT.CARTERA | [mod_rep.com.RSRDFCA035](procedimientos/mod_rep/com/RSRDFCA035.md) | `tip_cod`, `cod_rel`, `fec`, `prod` | ✅ validado | reportes / actividad-diaria / Captaciones |
| `CARACT_CARTERA_M_01` | CARACT.CARTERA.Mensual | [mod_rep.com.RSRDFCA035](procedimientos/mod_rep/com/RSRDFCA035.md) | `tip_cod`, `cod_rel`, `fec`, `prod` | ✅ validado | reportes / actividad-mensual |
| `CARACT_pas_01` | CARACT.pas | [mod_rep.com.RSRDFCA036](procedimientos/mod_rep/com/RSRDFCA036.md) | `tip_cod`, `cod_rel`, `fec`, `prod`, `segmento` | ✅ validado | reportes / actividad-diaria / Captaciones<br>shared / ui |
| `CARACT_pas_M_01` | CARACT.pas,Mensual | [mod_rep.com.RSRDFCA036](procedimientos/mod_rep/com/RSRDFCA036.md) | `tip_cod`, `cod_rel`, `fec`, `prod`, `segmento` | ✅ validado | reportes / actividad-mensual |
| `CEROCUOTA_TOPCNUEVA_01` | Top 10 Cero Cuotas Nuevas | [mod_rep.com.GTOPCERCUO001](procedimientos/mod_rep/com/GTOPCERCUO001.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_02` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO002](procedimientos/mod_rep/com/GTOPCERCUO002.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_03` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO003](procedimientos/mod_rep/com/GTOPCERCUO003.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_04` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO004](procedimientos/mod_rep/com/GTOPCERCUO004.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_05` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO005](procedimientos/mod_rep/com/GTOPCERCUO005.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_M_01` | Top 10 Cero Cuotas Nuevas | [mod_rep.com.GTOPCERCUO001](procedimientos/mod_rep/com/GTOPCERCUO001.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | — |
| `CEROCUOTA_TOPCNUEVA_M_02` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO002](procedimientos/mod_rep/com/GTOPCERCUO002.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | — |
| `CEROCUOTA_TOPCNUEVA_M_03` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO003](procedimientos/mod_rep/com/GTOPCERCUO003.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | — |
| `CEROCUOTA_TOPCNUEVA_M_04` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO004](procedimientos/mod_rep/com/GTOPCERCUO004.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | — |
| `CEROCUOTA_TOPCNUEVA_M_05` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | [mod_rep.com.GTOPCERCUO005](procedimientos/mod_rep/com/GTOPCERCUO005.md) | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ✅ validado | — |
| `CEROYCUOTA_01` | CERO Y UNA CUOTA | [mod_rep.com.GRCEROCUOTAO01](procedimientos/mod_rep/com/GRCEROCUOTAO01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CEROYCUOTA_02` | CERO Y UNA CUOTA | [mod_rep.com.GRCEROCUOTAO02](procedimientos/mod_rep/com/GRCEROCUOTAO02.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CLI_VULNERABLE_01` | Filtro Clientes Vulnerables | [mod_rep.com.RSCLIVULNER01](procedimientos/mod_rep/com/RSCLIVULNER01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `CLI_VULNERABLE_01` | Filtro Clientes Vulnerables | [mod_rep.com.RSCLIVULNER01](procedimientos/mod_rep/com/RSCLIVULNER01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `Clientes_01` | Clientes | [mod_rep.com.RSRDFCA007](procedimientos/mod_rep/com/RSRDFCA007.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Comercial Ejecutivo |
| `Clientes_nuevoRec_01` | Clientes nuevos y recurrentes | [mod_rep.com.RSRDFCA011](procedimientos/mod_rep/com/RSRDFCA011.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Clientes |
| `Clientes_Ope_01` | Clientes y Operaciones | [mod_rep.com.GDCLIOPE01](procedimientos/mod_rep/com/GDCLIOPE01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Clientes |
| `CMCUONUEV_01` | Cuadro de Mando Cero Cuotas Nuevas | [mod_rep.com.GCMCNUE001](procedimientos/mod_rep/com/GCMCNUE001.md) | `tip_cod`, `cod_rel`, `fec`, `prod`, `tipcuota` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CMCUONUEV_02` | Tipo Cero Cuotas Nuevas | [mod_rep.com.GCMCNUE002](procedimientos/mod_rep/com/GCMCNUE002.md) | `tip_cod`, `cod_rel`, `fec`, `prod`, `tipcuota` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `CMG_CARTERA_01` | CMG CARTERA | [mod_rep.com.RSCMGFCA002](procedimientos/mod_rep/com/RSCMGFCA002.md) | `codrel`, `Fecha`, `tipcod`, `met`, `prod` | ✅ validado | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `CMG_CARTERA_02` | CMG CARTERA | [mod_rep.com.RSRDFCA037](procedimientos/mod_rep/com/RSRDFCA037.md) | `tipcod`, `cod_rel`, `tipmet`, `prod`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `CMG_CARTERA_03` | CMG CARTERA | `mod_rep.com.RSRDFCA038` | `tipcod`, `cod_rel`, `tipmet`, `prod` | ❌ no existe en la base | — |
| `CMG_CARTERA_ASESOR_01` | Cartera Asesor | `mod_rep.com.GCMGCARTAS001` | `cod_rel`, `Fecha`, `tip_cod`, `met` | ❌ no existe en la base | — |
| `CMG_CLI_PAS_01` | CMG Clientes Pasivos | [mod_rep.com.RSCMGCLIPAS01](procedimientos/mod_rep/com/RSCMGCLIPAS01.md) | `tip_cod`, `cod_rel`, `fec`, `agru` | ✅ validado | reportes / actividad-diaria / Captaciones |
| `CMG_CLI_PAS_DETA_01` | CMG Clientes Pasivos Detalle | [mod_rep.com.RSCMGCLIPAS03](procedimientos/mod_rep/com/RSCMGCLIPAS03.md) | `tip_cod`, `cod_rel`, `fec`, `agru`, `grupo` | ✅ validado | — |
| `CMG_CLI_PAS_STOCK_02` | CMG Clientes Pasivos Stock | [mod_rep.com.RSCMGCLIPAS02](procedimientos/mod_rep/com/RSCMGCLIPAS02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `CMG_CLIF_01` | CMG Clientes Flujo | [mod_rep.com.RSCMGCF001](procedimientos/mod_rep/com/RSCMGCF001.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Clientes<br>reportes / actividad-mensual |
| `cmg_mora_simp_01` | Cmg Mora Sin Impulso | [mod_rep.com.GCMGMORA001_SIMP](procedimientos/mod_rep/com/GCMGMORA001_SIMP.md) | `cod_rel`, `fec`, `tip_cod` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `cmg_mora_simp_m_01` | Cmg Mora Sin Impulso Mensual | [mod_rep.com.GCMGMORA001_SIMP](procedimientos/mod_rep/com/GCMGMORA001_SIMP.md) | `cod_rel`, `fec`, `tip_cod` | ✅ validado | reportes / actividad-mensual |
| `CON_AGRO_FEN` | Consulta FEN CENEPRED | [mod_rep.com.REXPAGRO01](procedimientos/mod_rep/com/REXPAGRO01.md) | `col`, `val` | 🔎 extraído | consulta-fen |
| `CONT_ELECT_M_01` | Contraración Electrónica | [mod_rep.com.RSRDFCA024](procedimientos/mod_rep/com/RSRDFCA024.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-mensual |
| `CONT_ELECT_M_02` | Contraración Electrónica | [mod_rep.com.RSRDFCA025](procedimientos/mod_rep/com/RSRDFCA025.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-mensual |
| `CONT_ELECT_M_03` | Contraración Electrónica | [mod_rep.com.RSRDFCA026](procedimientos/mod_rep/com/RSRDFCA026.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-mensual |
| `CONT_ELECT_M_04` | Contraración Electrónica | [mod_rep.com.RSRDFCA032](procedimientos/mod_rep/com/RSRDFCA032.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-mensual |
| `COSELISTADO_02` | Listado Cosechas | [mod_rep.com.GCOSELIS001](procedimientos/mod_rep/com/GCOSELIS001.md) | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro`, `madu`, `pagen`, `nom` | ✅ validado | — |
| `COSESEMAFORO_01` | SEMAFORO DE COSECHAS | [mod_rep.com.GCOSEMAF002](procedimientos/mod_rep/com/GCOSEMAF002.md) | `tip_cod`, `cod_rel`, `prod`, `subpro`, `madu`, `op` | ✅ validado | reportes / actividad-mensual |
| `cuadro_Variable_M_01` | Cuadro Variable Riesgo Mensual | [mod_rep.com.GCMGMORA001](procedimientos/mod_rep/com/GCMGMORA001.md) | `cod_rel`, `fec`, `tip_cod` | ✅ validado | reportes / actividad-mensual |
| `cuadro_Variable_Riesgo_01` | Cuadro Variable Riesgo | [mod_rep.com.GCMGMORA001](procedimientos/mod_rep/com/GCMGMORA001.md) | `cod_rel`, `fec`, `tip_cod` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `cuadro_Variable_Riesgo_F_01` | Cuadro Variable Riesgo Finanzas | [mod_rep.com.GCMGMORA003](procedimientos/mod_rep/com/GCMGMORA003.md) | `cod_rel`, `fec`, `tip_cod` | ✅ validado | — |
| `DASHBOARD_CLIENTES_01` | Dashboard Clientes | [mod_rep.com.GDASHCLI01](procedimientos/mod_rep/com/GDASHCLI01.md) | `uni_cfg`, `sel_cfg` | 🔎 extraído | — |
| `DESCRED_01` | Reporte de Destino de Crédito | [mod_rep.com.GRESDESCRE02](procedimientos/mod_rep/com/GRESDESCRE02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera |
| `DESE_SOC_01` | Desempeno Social | [mod_rep.com.RSDESEMP01](procedimientos/mod_rep/com/RSDESEMP01.md) | `uni_cfg` | ✅ validado | — |
| `DESE_SOC_AS_01` | Desempeno Social | [mod_rep.com.RSDESEMP02](procedimientos/mod_rep/com/RSDESEMP02.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `DESEMBOLSOS_01` | Desembolsos SIN FAE NI REACTIVA | [mod_rep.com.GDACDESEM01](procedimientos/mod_rep/com/GDACDESEM01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Comercial Ejecutivo |
| `DesemDiario_01` | Desembolsos Diarios | [strategos.mod_rep_com_act.GDDESEMDIA](procedimientos/strategos/mod_rep_com_act/GDDESEMDIA.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `DesemDiario_02` | Operaciones Diario CE 01 | [mod_rep.com.RSRDFCA021](procedimientos/mod_rep/com/RSRDFCA021.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `DesemDiario_03` | Operaciones Diario CE 02 | [mod_rep.com.RSRDFCA022](procedimientos/mod_rep/com/RSRDFCA022.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `DesemDiario_04` | Operaciones Diario CE 03 | [mod_rep.com.RSRDFCA023](procedimientos/mod_rep/com/RSRDFCA023.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `DesemDiario_05` | Operaciones Diario CE 05 | [mod_rep.com.RSRDFCA031](procedimientos/mod_rep/com/RSRDFCA031.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `DESEMP_SOC_01` | Desempeño Social | [mod_rep.com.RSDESEMP01](procedimientos/mod_rep/com/RSDESEMP01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / desarrollo-sostenible |
| `DESEMP_SOC_PAS_01` | Desempeno Social Pasivos | [mod_rep.com.RSDESEMPAS01](procedimientos/mod_rep/com/RSDESEMPAS01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `DET_CLI_01` | Lista Clientes Reprogramados  | [mod_rep.com.GLISDETCLI01](procedimientos/mod_rep/com/GLISDETCLI01.md) | `cod_rel` | ✅ validado | — |
| `DET_INCEN_PDM_01` | DETALLE INCENTIVO PDM | [mod_rep.com.DINCEPDM01](procedimientos/mod_rep/com/DINCEPDM01.md) | `tip_cod`, `cod_rel`, `fecha`, `pagen` | ✅ validado | reportes / actividad-diaria / Cartera |
| `EfecRecTramos_01` | Portafolio Agro | [strategos.mod_rep_com_act.GDEFECTMORA01](procedimientos/strategos/mod_rep_com_act/GDEFECTMORA01.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `enrolamiento_colaboradores_01` | Enrolamiento Colaboradores | [mod_rep.com.RENRCOLAB01](procedimientos/mod_rep/com/RENRCOLAB01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `enrolamiento_desembolso_01` | Enrolamiento Desembolso | [mod_rep.com.RENRDESEM01](procedimientos/mod_rep/com/RENRDESEM01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `enrolamiento_Ope_01` | Enrolamiento Operaciones | [mod_rep.com.RENROPE01](procedimientos/mod_rep/com/RENROPE01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `enrolamiento_pasivo_01` | Enrolamiento Pasivo | [mod_rep.com.RENRPAS01](procedimientos/mod_rep/com/RENRPAS01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `enrolamiento_pasivo_pas_02` | Enrolamiento Pasivo | [mod_rep.com.RENRPAS02](procedimientos/mod_rep/com/RENRPAS02.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `GCMGCAP_01` | CMG Pasivas | [mod_rep.com.GCMGCAP01](procedimientos/mod_rep/com/GCMGCAP01.md) | `fec`, `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Captaciones<br>reportes / actividad-mensual |
| `GCOMCRE_02` | Comite de Créditos Diario | [mod_rep.com.GCOMCRE02](procedimientos/mod_rep/com/GCOMCRE02.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GCTABDIG_VR2_COM_03` | GC TABLERO DIGITAL - Comercial | `mod_rep.com.GRGCTABDIGO03` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | — |
| `GCTABDIG_VR2_OPE_02` | GC TABLERO DIGITAL - Operacional | [mod_rep.com.GRGCTABDIGO02](procedimientos/mod_rep/com/GRGCTABDIGO02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `GLISAUTRO_04` | Listado Autonomias | [mod_rep.com.GLISAUTRO05](procedimientos/mod_rep/com/GLISAUTRO05.md) | `tip_cod`, `cod_rel`, `cargo` | ✅ validado | — |
| `GRAF_GEST_COM_01` | GRAF Gestión Comercial | [mod_rep.com.RGRAFGESTCOM01](procedimientos/mod_rep/com/RGRAFGESTCOM01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_02` | GRAF Gestión Comercial | [mod_rep.com.RGRAFGESTCOM02](procedimientos/mod_rep/com/RGRAFGESTCOM02.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_03` | Graf Gestión Comercial | [mod_rep.com.RGRAFGESTCOM03](procedimientos/mod_rep/com/RGRAFGESTCOM03.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_04` | Graf Gestión Comercial | [mod_rep.com.RGRAFGESTCOM04](procedimientos/mod_rep/com/RGRAFGESTCOM04.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_05` | Graf Gestión Comercial | [mod_rep.com.RGRAFGESTCOM05](procedimientos/mod_rep/com/RGRAFGESTCOM05.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_06` | Graf Gestión Comercial | [mod_rep.com.RGRAFGESTCOM06](procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_07` | Graf Gestión Comercial | [mod_rep.com.RGRAFGESTCOM07](procedimientos/mod_rep/com/RGRAFGESTCOM07.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_07_` | DEV Graf Gestión Comercial | [storage.com.RGRAFGESTCOM07_](procedimientos/storage/com/RGRAFGESTCOM07_.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `GRAF_ZCUO_01` | Graf Zero Cuotas | [mod_rep.com.RGRAFZCUO01](procedimientos/mod_rep/com/RGRAFZCUO01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `GRAF_ZCUO_02` | Graf Zero Cuotas | [mod_rep.com.RGRAFZCUO02](procedimientos/mod_rep/com/RGRAFZCUO02.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `GRAF_ZCUO_03` | Graf Zero Cuotas | [mod_rep.com.RGRAFZCUO03](procedimientos/mod_rep/com/RGRAFZCUO03.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `GRAF_ZCUO_04` | Graf Zero Cuotas | [mod_rep.com.RGRAFZCUO04](procedimientos/mod_rep/com/RGRAFZCUO04.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `GRAFSEGPAS_01` | GRAFICO SEGURO PASIVOS ONCOLOGICO | [mod_rep.com.RGRAFSEGPAS01](procedimientos/mod_rep/com/RGRAFSEGPAS01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `GRAFSEGPAS_02` | GRAFICO SEGURO PASIVOS MULTIPLE AHORRO | [mod_rep.com.RGRAFSEGPAS02](procedimientos/mod_rep/com/RGRAFSEGPAS02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `GRBSOLI_01` | Reporte Grupo Solidario | `mod_rep.com.RSDEPGSOLID01` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes / actividad-diaria / Reportes PDM |
| `GREPORCORRE_01` | Corresponsales | [mod_rep.com.RCORRES01](procedimientos/mod_rep/com/RCORRES01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `GREPORCORRE_05` | Grafico Mapa Corresponsales | [mod_rep.com.RCORRES05](procedimientos/mod_rep/com/RCORRES05.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `GREPORCORRE_06` | Corresponsales Metas | [mod_rep.com.RCORRES06](procedimientos/mod_rep/com/RCORRES06.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `GREPROSPCORRE_01` | TAB_MENU_PROSPECTO_Corresponsales | [mod_rep.com.RPROSCORR002](procedimientos/mod_rep/com/RPROSCORR002.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `GREPROSPCORRE_02` | Graf_Pie_PROSTO_Corresponsales | [mod_rep.com.RPROSCORR004](procedimientos/mod_rep/com/RPROSCORR004.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `GREPROSPCORRE_03` | Graf_Pie_PROSTO_Inst_Corresponsales | [mod_rep.com.RPROSCORR006](procedimientos/mod_rep/com/RPROSCORR006.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | — |
| `GREPROSPCORRE_06` | Meta_PROSPECTO_Corresponsales | [mod_rep.com.RPROSCORR005](procedimientos/mod_rep/com/RPROSCORR005.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `GRESCAMIMP_01` | Campaña Imparables | [mod_rep.com.GRESCAMIMP01](procedimientos/mod_rep/com/GRESCAMIMP01.md) | `cod_rel`, `tip_cod` | ✅ validado | — |
| `GRESCAMIMP_02` | Top Imparables | [mod_rep.com.GRESTOPIMP01](procedimientos/mod_rep/com/GRESTOPIMP01.md) | `cod_rel`, `tip_cod` | ✅ validado | — |
| `GRESCONDO_01` | Modulo de Condonaciones | [mod_rep.com.GRESCAMCOND01](procedimientos/mod_rep/com/GRESCAMCOND01.md) | `tip_cod`, `cod_rel`, `tdcrMonto`, `tdcrMoti` | ✅ validado | — |
| `GRESCONDO_02` | Modulo de Condonaciones Mes Día  | [mod_rep.com.GRESCAMCOND01](procedimientos/mod_rep/com/GRESCAMCOND01.md) | `tip_cod`, `cod_rel`, `tdcrMonto`, `tdcrMoti`, `diariomes`, `niveles` | ✅ validado | — |
| `GRESCONDO_03` | Modulo de Condonaciones Mes Día  | [mod_rep.com.GRESCAMCOND03](procedimientos/mod_rep/com/GRESCAMCOND03.md) | `tip_cod`, `cod_rel`, `fec`, `tdcrMonto`, `tdcrMoti`, `niveles` | ✅ validado | — |
| `GRSCMIS_01` | Modulo de Detalle Seguro | [mod_rep.com.GRESREPSEG01](procedimientos/mod_rep/com/GRESREPSEG01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Seguros |
| `GRSCMIS_02` | Modulo de Detalle Asesor | [mod_rep.com.GRESREPSEG02](procedimientos/mod_rep/com/GRESREPSEG02.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Seguros |
| `GRSCMIS_03` | Modulo de Resumen Pasivos | [mod_rep.com.GRESREPSEG03](procedimientos/mod_rep/com/GRESREPSEG03.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `GRSCMIS_04` | Meta por Producto | [mod_rep.com.GRESREPSEG05](procedimientos/mod_rep/com/GRESREPSEG05.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Seguros |
| `GRSCMIS_05` | Reporte Detalle | [mod_rep.com.GRESREPSEG06](procedimientos/mod_rep/com/GRESREPSEG06.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Seguros |
| `GRSCMISREP_01` | Seguro Optativo | [mod_rep.com.GRESREPSEG_01](procedimientos/mod_rep/com/GRESREPSEG_01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Seguros |
| `GSCAMP_01` | Campaña Agil | [mod_rep.com.GSCAMP01](procedimientos/mod_rep/com/GSCAMP01.md) | `cod_rel`, `tip_cod`, `ind`, `sem` | ✅ validado | — |
| `GSCASEG_01` | Campaña de Seguros | [mod_rep.com.GSCASEG01](procedimientos/mod_rep/com/GSCASEG01.md) | `cod_rel`, `tip_cod` | ✅ validado | — |
| `GSMODAGEN_01` | Modulo de Agendamiento | [mod_rep.com.GSMODAGEN01](procedimientos/mod_rep/com/GSMODAGEN01.md) | `cod_rel`, `tip_cod` | ✅ validado | — |
| `GSREVA01` | Reporte Reva | [mod_rep.rep.GSREVA01](procedimientos/mod_rep/rep/GSREVA01.md) | `Fecha`, `tipcod`, `codrel`, `codmod` | ✅ validado | — |
| `GSREVA101` | Reporte Reva | [mod_rep.rep.GSREVA01](procedimientos/mod_rep/rep/GSREVA01.md) | `Fecha`, `tipcod`, `codrel`, `codmod` | ✅ validado | — |
| `GSREVA201` | Reporte Reva | [mod_rep.rep.GSREVA01](procedimientos/mod_rep/rep/GSREVA01.md) | `Fecha`, `tipcod`, `codrel`, `codmod` | ✅ validado | — |
| `GST_ACTIVAS_01` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_02` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_03` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_04` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_05` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_06` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_07` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST03](procedimientos/mod_rep/com/GDCGEST_ACTIVAST03.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_08` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST03](procedimientos/mod_rep/com/GDCGEST_ACTIVAST03.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_09` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST04](procedimientos/mod_rep/com/GDCGEST_ACTIVAST04.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_10` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST04](procedimientos/mod_rep/com/GDCGEST_ACTIVAST04.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_M_01` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_M_02` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_M_03` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_M_04` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_M_05` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_ACTIVAS_M_06` | GESTION TASAS ACTIVAS | [mod_rep.com.GDCGEST_ACTIVAST01](procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ✅ validado | — |
| `GST_PASIVA_01` | GESTION TASAS PASIVAS | [mod_rep.com.GDCGEST_PASIVAST01](procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ✅ validado | reportes / actividad-diaria / Captaciones |
| `GST_PASIVA_02` | GESTION TASAS PASIVAS | [mod_rep.com.GDCGEST_PASIVAST01](procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ✅ validado | reportes / actividad-diaria / Captaciones |
| `GST_PASIVA_03` | GESTION TASAS PASIVAS | [mod_rep.com.GDCGEST_PASIVAST01](procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ✅ validado | — |
| `GST_PASIVA_M_01` | GESTION TASAS PASIVAS | [mod_rep.com.GDCGEST_PASIVAST01](procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ✅ validado | — |
| `GST_PASIVA_M_02` | GESTION TASAS PASIVAS | [mod_rep.com.GDCGEST_PASIVAST01](procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ✅ validado | — |
| `GST_PASIVA_M_03` | GESTION TASAS PASIVAS | [mod_rep.com.GDCGEST_PASIVAST01](procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ✅ validado | — |
| `HCARBONO_01` | Huella de carbono | [mod_rep.com.RSHHCARB001](procedimientos/mod_rep/com/RSHHCARB001.md) | `tip_cod`, `cod_rel`, `fec`, `cargambiental` | ✅ validado | reportes / actividad-mensual |
| `HTTPTRACE_01` | Servicio Reporte de Uso | [strategos.mod_rep_com_act.HTTPTRACE](procedimientos/strategos/mod_rep_com_act/HTTPTRACE.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `INCEN_PDM_01` | INCENTIVOS PDM | `mod_rep.com.RINCEPDM01` | `tip_cod`, `cod_rel`, `fecha` | ❌ no existe en la base | — |
| `LCCUOTANUEVA_01` | BASE DE GESTION CERO CUOTAS NUEVAS | [mod_rep.com.RSLISTCCN01](procedimientos/mod_rep/com/RSLISTCCN01.md) | `tip_cod`, `cod_rel`, `pagen`, `tipcuota` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `LIS_CAPRET_01` | List Capacity Retailer | [mod_rep.com.GLISCAPRET01](procedimientos/mod_rep/com/GLISCAPRET01.md) | `cod_rel` | ✅ validado | — |
| `LIS_PROSPE_01` | Lista de Prospectos | [mod_rep.com.GLISPROSP01](procedimientos/mod_rep/com/GLISPROSP01.md) | `cod_rel` | ✅ validado | — |
| `LSRC_DATA_REACT_01` | Data de Reactivados | [mod_rep.com.RCDATREACT01](procedimientos/mod_rep/com/RCDATREACT01.md) | `fecha` | ✅ validado | — |
| `LST_AUT_01` | Lista Autonomias | [mod_rep.com.GLISAUTO01](procedimientos/mod_rep/com/GLISAUTO01.md) | `tip_cod`, `cod_rel`, `c_aut`, `aut` | ✅ validado | — |
| `Monitor_Dese_01` | Monitor desembolsos Operación | [mod_rep.com.RSRDFCA027](procedimientos/mod_rep/com/RSRDFCA027.md) | `tipmet`, `tip_cod`, `cod_rel` | ✅ validado | core / winder<br>reportes / avance-comercial |
| `Monitor_Dese_02` | Monitor desembolsos Monto | [mod_rep.com.RSRDFCA030](procedimientos/mod_rep/com/RSRDFCA030.md) | `tipmet`, `tip_cod`, `cod_rel` | ✅ validado | reportes / avance-comercial |
| `Monitor_Dese_03` | Monitor desembolsos Cumplimiento | [mod_rep.com.RSRDFCA028](procedimientos/mod_rep/com/RSRDFCA028.md) | `tipmet`, `tip_cod`, `cod_rel` | ✅ validado | reportes / avance-comercial |
| `Monitor_Dese_04` | Monitor desembolsos Promedio | [mod_rep.com.RSRDFCA029](procedimientos/mod_rep/com/RSRDFCA029.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / avance-comercial |
| `Monitor_Dese_misi_01` | Monitor desembolsos Operación | `mod_rep.com.RSRDFCA050` | `tipmet`, `tip_cod`, `cod_rel`, `prod` | ❌ no existe en la base | reportes / desarrollo-sostenible |
| `Monitor_Dese_misi_02` | Monitor desembolsos Operación  | `mod_rep.com.RSRDFCA050_3` | `tipmet`, `tip_cod`, `cod_rel`, `prod` | ❌ no existe en la base | reportes / desarrollo-sostenible |
| `MOVIMIENTO_CLIENTES_01` | Movimiento Clientes | [mod_rep.com.GMOVCLI01](procedimientos/mod_rep/com/GMOVCLI01.md) | — | ✅ validado | reportes / actividad-diaria / Clientes |
| `P_Datos_01` | Plan de Datos | [mod_rep.com.GRESPDATOS01](procedimientos/mod_rep/com/GRESPDATOS01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-mensual |
| `P_Datos_02` | Plan de Datos | [mod_rep.com.GRESPDATOS02](procedimientos/mod_rep/com/GRESPDATOS02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PANEL_SUP_01` | Panel de Supervisión | [mod_rep.com.RSPANSUP001](procedimientos/mod_rep/com/RSPANSUP001.md) | `tip_cod`, `cod_rel`, `carg` | ✅ validado | — |
| `PANEL_SUP_02` | Panel de Supervisión Detalle | [mod_rep.com.RSPANSUP002](procedimientos/mod_rep/com/RSPANSUP002.md) | `tip_cod`, `cod_rel`, `carg`, `state` | ✅ validado | — |
| `PANEL_SUP_02` | Panel de Supervisión Detalle | [mod_rep.com.RSPANSUP002](procedimientos/mod_rep/com/RSPANSUP002.md) | `tip_cod`, `cod_rel`, `carg`, `state` | ✅ validado | — |
| `PANEL_SUP_03` | Panel de Supervisión 2 | [mod_rep.com.RSPANSUP003](procedimientos/mod_rep/com/RSPANSUP003.md) | `tip_cod`, `cod_rel`, `carg` | ✅ validado | — |
| `PANEL_SUP_04` | Supervision desembolsos | [mod_rep.com.RSPANSUP004](procedimientos/mod_rep/com/RSPANSUP004.md) | `tip_cod`, `cod_rel`, `cant` | ✅ validado | — |
| `PANEL_SUP_05` | Detalle Supervision desembolsos | [mod_rep.com.RSPANSUP005](procedimientos/mod_rep/com/RSPANSUP005.md) | `tip_cod`, `cod_rel`, `cant` | ✅ validado | — |
| `Pasivo_01` | Pasivos | [mod_rep.com.GPASP001](procedimientos/mod_rep/com/GPASP001.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `PDM_01` | PDM | [mod_rep.com.GPDM001](procedimientos/mod_rep/com/GPDM001.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Comercial Ejecutivo |
| `PLANMOV_01` | Planilla Movilidad | [mod_rep.com.GLIMOVO01](procedimientos/mod_rep/com/GLIMOVO01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOV_02` | Planilla Movilidad | [mod_rep.com.GLIMOVO02](procedimientos/mod_rep/com/GLIMOVO02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOV_03` | Detalle | [mod_rep.com.GLIMOVO05](procedimientos/mod_rep/com/GLIMOVO05.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOV_04` | Detalle Dep | [mod_rep.com.GLIMOVO06](procedimientos/mod_rep/com/GLIMOVO06.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOVPERFIL_01` | Planilla Movilidad Perfil | [mod_rep.com.GLIMOVO01](procedimientos/mod_rep/com/GLIMOVO01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOVPERFIL_02` | Planilla Movilidad Perfil | [mod_rep.com.GLIMOVO02](procedimientos/mod_rep/com/GLIMOVO02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOVR_01` | Planilla Movilidad Recuperador | [mod_rep.com.GLIMOVRO01](procedimientos/mod_rep/com/GLIMOVRO01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOVR_03` | Planilla Movilidad Recuperador | [mod_rep.com.GLIMOVRO05](procedimientos/mod_rep/com/GLIMOVRO05.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `PLANMOVR_04` | Detalle Dep Recuperador | [mod_rep.com.GLIMOVRO06](procedimientos/mod_rep/com/GLIMOVRO06.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `pob_misi_01` | Productos Top Territorio | `mod_rep.com.RSRTOPPOMIS001` | `tip_cod`, `cod_rel`, `fec`, `prod` | ❌ no existe en la base | — |
| `pob_misi_02` | Productos Top corredor | `mod_rep.com.RSRTOPPOMIS002` | `tip_cod`, `cod_rel`, `fec`, `prod` | ❌ no existe en la base | — |
| `pob_misi_03` | Productos Top Unidad | `mod_rep.com.RSRTOPPOMIS003` | `tip_cod`, `cod_rel`, `fec`, `prod` | ❌ no existe en la base | — |
| `pob_misi_04` | Productos Top Asesores | `mod_rep.com.RSRTOPPOMIS004` | `tip_cod`, `cod_rel`, `fec`, `prod` | ❌ no existe en la base | — |
| `PortafolioAgro_01` | Portafolio Agro | [strategos.mod_rep_com_act.GDPORTAGRO01](procedimientos/strategos/mod_rep_com_act/GDPORTAGRO01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `PORTSUPE_01` | Portafolio y Supervision | [strategos.mod_rep_com_act.GDPSUPERV01](procedimientos/strategos/mod_rep_com_act/GDPSUPERV01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `PORTSUPE_02` | Portafolio y Supervision | [strategos.mod_rep_com_act.GDPSUPERV02](procedimientos/strategos/mod_rep_com_act/GDPSUPERV02.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `PRECOSECUADRO_03` | Cuadro Pre Cosechas | [mod_rep.com.GPRECOSCUAD001](procedimientos/mod_rep/com/GPRECOSCUAD001.md) | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro` | ✅ validado | — |
| `PRECOSELISTADO_02` | Listado Pre Cosechas | [mod_rep.com.GPRECOSELIS001](procedimientos/mod_rep/com/GPRECOSELIS001.md) | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro`, `pagen`, `nom` | ✅ validado | — |
| `prod_misi_01` | Productos Top corredor | [mod_rep.com.RSRTOPMIS001](procedimientos/mod_rep/com/RSRTOPMIS001.md) | `tip_cod`, `cod_rel`, `fec`, `prod` | ✅ validado | reportes / desarrollo-sostenible |
| `prod_misi_02` | Productos Top Unidad | [mod_rep.com.RSRTOPMIS002](procedimientos/mod_rep/com/RSRTOPMIS002.md) | `tip_cod`, `cod_rel`, `fec`, `prod` | ✅ validado | reportes / desarrollo-sostenible |
| `prod_misi_03` | Productos Top Asesores | [mod_rep.com.RSRTOPMIS003](procedimientos/mod_rep/com/RSRTOPMIS003.md) | `tip_cod`, `cod_rel`, `fec`, `prod` | ✅ validado | reportes / desarrollo-sostenible |
| `prod_misi_04` | Productos Top Territorio | [mod_rep.com.RSRTOPMIS004](procedimientos/mod_rep/com/RSRTOPMIS004.md) | `tip_cod`, `cod_rel`, `fec`, `prod` | ✅ validado | reportes / desarrollo-sostenible |
| `prod_misi_05` | Monitor desembolsos Operación  | `mod_rep.com.RSRDFCA050_4` | `tip_cod`, `cod_rel`, `fec`, `prod` | ❌ no existe en la base | reportes / desarrollo-sostenible |
| `PROYEC_COLREC_01` | proyeccion de colocaciones | [mod_rep.com.RSPROYCOLDES001](procedimientos/mod_rep/com/RSPROYCOLDES001.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Proyecciones |
| `PROYEC_COLREC_02` | proyeccion de recuperaciones | [mod_rep.com.RSPROYCOLDES002](procedimientos/mod_rep/com/RSPROYCOLDES002.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `PROYEC_COLREC_03` | proyeccion diaria colocacion detalle | [mod_rep.com.RSPROYCOLDES009](procedimientos/mod_rep/com/RSPROYCOLDES009.md) | `tip_cod`, `cod_rel`, `pagen` | ✅ validado | reportes / actividad-diaria / Proyecciones |
| `PROYEC_COLREC_04` | proyeccion diaria recuperacion detalle | [mod_rep.com.RSPROYCOLDES010](procedimientos/mod_rep/com/RSPROYCOLDES010.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `PROYEC_DIACOLREC_01` | proyeccion diaria colocaciones | [mod_rep.com.RSPROYCOLDES003](procedimientos/mod_rep/com/RSPROYCOLDES003.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Proyecciones |
| `PROYEC_DIACOLREC_02` | proyeccion diaria monto | [mod_rep.com.RSPROYCOLDES004](procedimientos/mod_rep/com/RSPROYCOLDES004.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Proyecciones |
| `PROYEC_DIACOLREC_03` | proyeccion diaria efectividades | [mod_rep.com.RSPROYCOLDES005](procedimientos/mod_rep/com/RSPROYCOLDES005.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `PROYEC_DIACOLREC_AS_01` | proyeccion diaria colocaciones asesor | [mod_rep.com.RSPROYCOLDES006](procedimientos/mod_rep/com/RSPROYCOLDES006.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `PROYEC_DIACOLREC_AS_02` | proyeccion diaria monto asesor | [mod_rep.com.RSPROYCOLDES007](procedimientos/mod_rep/com/RSPROYCOLDES007.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `PROYEC_DIACOLREC_AS_03` | proyeccion diaria efectividades asesor | [mod_rep.com.RSPROYCOLDES008](procedimientos/mod_rep/com/RSPROYCOLDES008.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `R_APADRINA_01` | Apadrinamiento | [mod_rep.com.RSRDMA023](procedimientos/mod_rep/com/RSRDMA023.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Campañas |
| `RACTGP_01` | Activas PDM | [mod_rep.com.RACTGP01](procedimientos/mod_rep/com/RACTGP01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera |
| `rankKay_01` | Ranking Kaypacha | [mod_rep.com.GDASHKAY03](procedimientos/mod_rep/com/GDASHKAY03.md) | `cod_rel`, `fec`, `Ter` | ✅ validado | reportes / actividad-mensual |
| `rankKayOpe_01` | Ranking Kaypacha Operaciones | [mod_rep.com.GDASHKAY05](procedimientos/mod_rep/com/GDASHKAY05.md) | `cod_rel`, `fec`, `Ter` | ✅ validado | reportes / actividad-mensual |
| `rankKayrecu_01` | Ranking Kaypacha Recuperaciones | [mod_rep.com.GDASHKAY06](procedimientos/mod_rep/com/GDASHKAY06.md) | `cod_rel`, `fec`, `Ter` | ✅ validado | reportes / actividad-mensual |
| `RDETCORR_01` | Detalle Corresponsales | [mod_rep.com.RDETCORR01](procedimientos/mod_rep/com/RDETCORR01.md) | `tip_cod`, `cod_rel`, `fec`, `pagen`, `tipo` | ✅ validado | — |
| `REACT_PDM_01` | Lista Clientes PDM Reprogramados | [mod_rep.com.GLISDETCLIPDM01](procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | `cod_rel`, `base` | ✅ validado | — |
| `RECSERV_PAS_01` | Recaudos Pasivos | [mod_rep.com.RSRSRV001](procedimientos/mod_rep/com/RSRSRV001.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Captaciones |
| `REP_CATEGO_ASE_01` | Reporte Categorización Asesor | [mod_sec.dbo.GCATSEC01](procedimientos/mod_sec/dbo/GCATSEC01.md) | `cod_bt` | ✅ validado | — |
| `REP_CERCUOT_01` | Reporte cero cuota | [mod_rep.com.GDCEROCN003](procedimientos/mod_rep/com/GDCEROCN003.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `REP_CERCUOT_02` | Reporte cero cuota | [mod_rep.com.GDCEROCN004](procedimientos/mod_rep/com/GDCEROCN004.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `reporte_autonomia_new_01` | Lista... | [mod_rep.com.GDCGEST_ACTIVAST02](procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-mensual |
| `reporte_autonomia_newdiaria_01` | Lista... | [mod_rep.com.GDCGEST_ACTIVAST02](procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera |
| `reporte-demo` | Reporte Demo | `mod_rep.dbo.REPORTE_DEMO` | `fecha`, `cod_user_bt` | ❌ no existe en la base | — |
| `RES_SEC_REP_01` | Lista Clientes Reprogramados | [mod_rep.com.GRESCLIREP01](procedimientos/mod_rep/com/GRESCLIREP01.md) | `cod_rel` | ✅ validado | — |
| `RESINCGRUP_01` | Incentivos Meta Grupos PDM | [mod_rep.com.RINCEGP01](procedimientos/mod_rep/com/RINCEGP01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera |
| `RESMORAGP_01` | Mora Grupos PDM | [mod_rep.com.RMORAGP01](procedimientos/mod_rep/com/RMORAGP01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera |
| `RESNMOV_01` | Mov. Resumen Detalle Comercial | [mod_rep.com.RESDMOV01](procedimientos/mod_rep/com/RESDMOV01.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria |
| `RESNMOV_02` | Mov. Resumen Detalle Analista | [mod_rep.com.RESDMOV02](procedimientos/mod_rep/com/RESDMOV02.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `RESNMOVR_01` | Mov. Resumen Detalle Recuperaciones | [mod_rep.com.RESDMOV02](procedimientos/mod_rep/com/RESDMOV02.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria |
| `resultado_unidad_negocio_rma_01` | RESULTADO GUN | [strategos.mod_rep_com_act.CABGMRESULUNINEGB01](procedimientos/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.md) | `tip_cod`, `cod_rel`, `fec`, `canal` | ✅ validado | reportes / actividad-mensual |
| `resultado_unidad_negocio_rma_ope_01` | RESULTADO GUN | [strategos.mod_rep_com_act.CABGMRESULUNINEGB01](procedimientos/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.md) | `tip_cod`, `cod_rel`, `fec`, `canal` | ✅ validado | — |
| `rma/administracion/Mora/monitor_efectividad_rma_03` | Gestión de Monitor Efectividades | [mod_rep.com.RSGESMOEF001](procedimientos/mod_rep/com/RSGESMOEF001.md) | `tip_cod`, `cod_rel`, `tram` | ✅ validado | — |
| `RMENTORIN_01` | Reporte Mentoring 01 | [mod_rep.com.GRMENTOR001](procedimientos/mod_rep/com/GRMENTOR001.md) | `tip_cod`, `cod_rel`, `fec`, `resp` | ✅ validado | reportes / actividad-diaria / Campañas |
| `RMENTORIN_02` | Reporte Mentoring 02 | [mod_rep.com.GRMENTOR002](procedimientos/mod_rep/com/GRMENTOR002.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `RMESA_01` | Efectividades Sin Asignar | [mod_rep.com.RMESA01](procedimientos/mod_rep/com/RMESA01.md) | `tip_cod`, `cod_rel`, `pagen` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RPROGOB_01` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB01](procedimientos/mod_rep/com/GRESPROGOB01.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | — |
| `RPROGOB_02` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB01](procedimientos/mod_rep/com/GRESPROGOB01.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | — |
| `RPROGOB_03` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB02](procedimientos/mod_rep/com/GRESPROGOB02.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | — |
| `RPROGOB_04` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB02](procedimientos/mod_rep/com/GRESPROGOB02.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | — |
| `RPROGOB_M_01` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB01](procedimientos/mod_rep/com/GRESPROGOB01.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | reportes / actividad-mensual |
| `RPROGOB_M_02` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB01](procedimientos/mod_rep/com/GRESPROGOB01.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | reportes / actividad-mensual |
| `RPROGOB_M_03` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB02](procedimientos/mod_rep/com/GRESPROGOB02.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | reportes / actividad-mensual |
| `RPROGOB_M_04` | Reporte de cartera de progamas del gobierno | [mod_rep.com.GRESPROGOB02](procedimientos/mod_rep/com/GRESPROGOB02.md) | `cod_rel`, `tip_cod`, `fec`, `var` | ✅ validado | reportes / actividad-mensual |
| `RS_AGE_COM_01` | Agendamiento Comercial | [mod_rep.com.RSAGECOM01](procedimientos/mod_rep/com/RSAGECOM01.md) | `tip_cod`, `cod_rel`, `fecha`, `mode`, `fuga`, `prop` | ✅ validado | reportes / actividad-diaria / Campañas |
| `RS_AGE_COM_02` | Detalle Agendamiento Comercial | [mod_rep.com.RSAGECOM02](procedimientos/mod_rep/com/RSAGECOM02.md) | `tip_cod`, `cod_rel`, `fecha`, `mode`, `fuga`, `prop`, `nom` | ✅ validado | reportes / actividad-diaria / Campañas |
| `RS_AGE_COM_03` | Detalle Agendamiento Automatico y Express | [mod_rep.com.RSAGECOM03](procedimientos/mod_rep/com/RSAGECOM03.md) | `tip_cod`, `cod_rel`, `fecha`, `mode`, `fuga`, `prop` | ✅ validado | reportes / actividad-diaria / Campañas |
| `RS_AGE_COM_CR_01` | Agendamiento Comercial Reasignado | [mod_rep.com.RS_AGE_COM_CR_01](procedimientos/mod_rep/com/RS_AGE_COM_CR_01.md) | `tip_cod`, `cod_rel`, `ver`, `fecha` | ✅ validado | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_AGE_COM_CR_03` | Detalle Agendamiento Comercial Reasignado | [mod_rep.com.RS_AGE_COM_CR_02](procedimientos/mod_rep/com/RS_AGE_COM_CR_02.md) | `tip_cod`, `cod_rel`, `pagen`, `fecha` | ✅ validado | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_AGE_COM_CRM_01` | Agendamiento Comercial Reasignado Mensual | [mod_rep.com.RS_AGE_COM_CR_01](procedimientos/mod_rep/com/RS_AGE_COM_CR_01.md) | `tip_cod`, `cod_rel`, `ver`, `fecha` | ✅ validado | — |
| `RS_AGE_COM_CRM_03` | Detalle Agendamiento Comercial Reasignado Mesual | [mod_rep.com.RS_AGE_COM_CR_02](procedimientos/mod_rep/com/RS_AGE_COM_CR_02.md) | `tip_cod`, `cod_rel`, `pagen`, `fecha` | ✅ validado | reportes / actividad-mensual |
| `RS_AGE_COM_CRM_F_01` | Agendamiento Comercial Reasignado Flujo | [mod_rep.com.RS_AGE_COM_CR_M_01](procedimientos/mod_rep/com/RS_AGE_COM_CR_M_01.md) | `tip_cod`, `cod_rel`, `ver`, `fecha` | ✅ validado | reportes / actividad-mensual |
| `RS_AGE_COM_CRM_F_03` | DetalleAgendamiento Comercial Reasignado Flujo | [mod_rep.com.RS_AGE_COM_CR_M_02](procedimientos/mod_rep/com/RS_AGE_COM_CR_M_02.md) | `tip_cod`, `cod_rel`, `pagen`, `fecha` | ✅ validado | — |
| `RS_AGE_COM_CRM_S_01` | Agendamiento Comercial Reasignado Stock | [mod_rep.com.RS_AGE_COM_CR_M_03](procedimientos/mod_rep/com/RS_AGE_COM_CR_M_03.md) | `tip_cod`, `cod_rel`, `ver`, `fecha`, `tipo_ase` | ✅ validado | — |
| `RS_AGE_COM_CRM_S_03` | DetalleAgendamiento Comercial Reasignado Stock | [mod_rep.com.RS_AGE_COM_CR_M_04](procedimientos/mod_rep/com/RS_AGE_COM_CR_M_04.md) | `tip_cod`, `cod_rel`, `ver`, `fecha`, `tipo_ase` | ✅ validado | — |
| `RS_AGROMIX_01` | REPORTE AGROMIX | `mod_rep.com.RAGROMIX` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_AGROMIX_02` | Graf Vencido AGROMIX | `mod_rep.com.RS_AGROMIX_CHART` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes |
| `RS_AGROMIX_03` | Graf Capital AGROMIX | `mod_rep.com.RS_AGROMIX_CHART2` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes |
| `RS_AGROMIX_04` | Graf Clientes AGROMIX | `mod_rep.com.RS_AGROMIX_CHART3` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes |
| `RS_AGROMIX_05` | Graf Resumen AGROMIX | `mod_rep.com.RS_AGROMIX_CHART4` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes |
| `RS_AVA_POR_01` | Avance de Portafolio | [mod_rep.com.RSAVAPOR01](procedimientos/mod_rep/com/RSAVAPOR01.md) | `tip_cod`, `cod_rel`, `mode`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_BASE_NEG_01` | Base Negativa Riesgos | [mod_rep.com.RSBASENEG01](procedimientos/mod_rep/com/RSBASENEG01.md) | `nom` | 🔎 extraído | core / winder<br>herramientas |
| `RS_CAL_CAR_01` | Calidad de Cartera 1 | [mod_rep.com.RSCALCAR01](procedimientos/mod_rep/com/RSCALCAR01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_CAL_CAR_02` | Calidad de Cartera 2 | [mod_rep.com.RSCALCAR02](procedimientos/mod_rep/com/RSCALCAR02.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_CARD_ZCUO_01` | Card reporte cero cuotas | [mod_rep.com.RCARDZCUO01](procedimientos/mod_rep/com/RCARDZCUO01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_CARTEPAS_01` | Reporte Carterización Pasivo | `mod_rep.com.RSCOMPAS01` | `tipcod`, `codrel`, `fecha` | ❌ no existe en la base | reportes / actividad-diaria / Captaciones |
| `RS_DAT_PRO_01` | Datos por Producto 1 | [mod_rep.com.RSDATPRO01](procedimientos/mod_rep/com/RSDATPRO01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DAT_PRO_02` | Datos por Producto 2 | [mod_rep.com.RSDATPRO02](procedimientos/mod_rep/com/RSDATPRO02.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DAT_PRO_03` | Datos por Producto 3 | [mod_rep.com.RSDATPRO03](procedimientos/mod_rep/com/RSDATPRO03.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DAT_PRO_04` | Datos por Producto 4 | [mod_rep.com.RSDATPRO04](procedimientos/mod_rep/com/RSDATPRO04.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DESEMB_01` | Estructura de Desembolsos | [mod_rep.com.RSDESEMB](procedimientos/mod_rep/com/RSDESEMB.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual<br>reportes / actividad-mensual / Cartera<br>shared / ui |
| `RS_DESEMB_02` | Estructura de Desembolsos Mensual | [mod_rep.com.RSDESEMB02](procedimientos/mod_rep/com/RSDESEMB02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-mensual<br>reportes / actividad-mensual / Cartera |
| `RS_FECH` | Fechas Reporte Mensual | [mod_rep.com.RFECREPMEN](procedimientos/mod_rep/com/RFECREPMEN.md) | `fec` | ✅ validado | reportes<br>reportes / actividad-diaria / Cartera<br>reportes / actividad-diaria / Cartera en Mora<br>reportes / actividad-diaria / Seguros<br>reportes / actividad-mensual<br>reportes / actividad-mensual / Cartera<br>reportes / actividad-mensual / Tablero Digital |
| `RS_FECH02` | Fecha Reporte Hoy Mensual | [mod_rep.com.RFECREPMEN02](procedimientos/mod_rep/com/RFECREPMEN02.md) | `fec` | ✅ validado | reportes<br>reportes / actividad-diaria / Cartera<br>reportes / actividad-diaria / Seguros |
| `RS_GEST_COM_01` | Reporte Gestión Comercial | [mod_rep.com.RSGETCOM01](procedimientos/mod_rep/com/RSGETCOM01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `RS_GEST_COM_02` | Reporte Evolutivo Var Vigente | `mod_rep.com.RREPGESTCOM02` | `tip_cod`, `cod_rel`, `fecha` | ❌ no existe en la base | reportes / actividad-diaria / Cartera |
| `RS_GEST_COM_03` | Reporte Evolutivo Var Cliente Stock | `mod_rep.com.RREPGESTCOM03` | `tip_cod`, `cod_rel`, `fecha` | ❌ no existe en la base | reportes / actividad-diaria / Cartera |
| `RS_MON_CAR_01` | Control Cargas Prod | [mod_rep.com.RSRPD001](procedimientos/mod_rep/com/RSRPD001.md) | `opt` | ✅ validado | reportes / control-cargas |
| `RS_MON_EFEC_01` | Monitor de Efectividades | [mod_rep.com.RSMONEFE01](procedimientos/mod_rep/com/RSMONEFE01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFEC_02` | Detalle de Efectividades | [mod_rep.com.RSMONEFE02](procedimientos/mod_rep/com/RSMONEFE02.md) | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `nom`, `resp`, `tdcr`, `pagen`, `fcompro`, `precosechaf` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFEC_03` | Gestión de Monitor Efectividades | [mod_rep.com.RSMONEFE03](procedimientos/mod_rep/com/RSMONEFE03.md) | `tip_cod`, `cod_rel`, `tram` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFEC_SEC_01` | Detalle de Efectividades Asesor | [mod_rep.com.RSMONEFE05](procedimientos/mod_rep/com/RSMONEFE05.md) | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `tdcr`, `pagen` | ✅ validado | — |
| `RS_MON_EFECM_01` | Monitor de Efectividades Mensual | [mod_rep.com.RSMONEFE01](procedimientos/mod_rep/com/RSMONEFE01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-mensual |
| `RS_MON_EFECM_02` | Detalle de Efectividades Mensual | [mod_rep.com.RSMONEFE02](procedimientos/mod_rep/com/RSMONEFE02.md) | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `nom`, `resp`, `tdcr`, `pagen`, `fcompro`, `precosechaf` | ✅ validado | reportes / actividad-mensual |
| `RS_MON_EFECM_03` | Gestión de Monitor Efectividades Mensual | [mod_rep.com.RSMONEFE03](procedimientos/mod_rep/com/RSMONEFE03.md) | `tip_cod`, `cod_rel`, `tram` | ✅ validado | reportes / actividad-mensual |
| `RS_MON_EFECREASIG_01` | Monitor de Efectividades Reasignados | [mod_rep.com.RSMONEFER01](procedimientos/mod_rep/com/RSMONEFER01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_MON_EFECREASIG_02` | Detalle de Efectividades | [mod_rep.com.RSMONEFER02](procedimientos/mod_rep/com/RSMONEFER02.md) | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `nom`, `resp`, `tdcr`, `pagen`, `fcompro` | ✅ validado | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_MON_EFECREASIG_03` | Efectividades Reasignados fechas | [mod_rep.com.RSMONEFER03](procedimientos/mod_rep/com/RSMONEFER03.md) | `tip_cod`, `cod_rel`, `fec`, `imp` | ✅ validado | — |
| `RS_MON_EFECREASIGM_01` | Monitor de Efectividades Reasignados Mensual | [mod_rep.com.RSMONEFER01](procedimientos/mod_rep/com/RSMONEFER01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-mensual |
| `RS_MON_EFECREPRO_01` | Monitor de Efectividades Reprogramados | [mod_rep.com.RSMONEFEREPRO01](procedimientos/mod_rep/com/RSMONEFEREPRO01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFECTRAMOSC_01` | Seguimiento PDM | [mod_rep.com.RSMONEFETRC01](procedimientos/mod_rep/com/RSMONEFETRC01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_INT_COM_01` | Reporte Monitor Inteligencia Comercial | `mod_rep.com.RMONINTCOM01` | `tip_cod`, `cod_rel`, `fecha` | ❌ no existe en la base | reportes / actividad-diaria / Cartera |
| `RS_MON_REP_01` | Monitor de reprogramados | [mod_rep.com.GDMREP001](procedimientos/mod_rep/com/GDMREP001.md) | `cod_rel`, `fec`, `tip_cod`, `car` | ✅ validado | reportes / avance-comercial |
| `RS_MON_REP_SEC_01` | Monitor de reprogramados | [mod_rep.com.GDMREP001](procedimientos/mod_rep/com/GDMREP001.md) | `cod_rel`, `fec`, `tip_cod`, `car` | ✅ validado | — |
| `RS_MON_SALCAP_COM_01` | Reporte Saldo Captacion Cartera | `mod_rep.com.RSCAPCOME01` | `codrel`, `fecha`, `tipcod` | ❌ no existe en la base | reportes<br>reportes / actividad-diaria / Captaciones |
| `RS_RANK_COM_01` | Ranking Comercial | `mod_rep.com.RSRANKCOM01` | `territorio`, `corredor`, `fecha` | ❌ no existe en la base | reportes / actividad-diaria / Cartera |
| `RS_RANK_MUJ_01` | RANKING MUJER | [mod_rep.com.RRANKM01](procedimientos/mod_rep/com/RRANKM01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `RS_RANK_MUJ_02` | RANKING MUJER CARTERA | `mod_rep.com.RRANKM02` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | — |
| `RS_RETE_01` | Modulo Retención | [mod_rep.com.RSMONRENT01](procedimientos/mod_rep/com/RSMONRENT01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `RS_SAL_CAR_01` | Saldo Puntual de Cartera | [mod_rep.com.RSSALCAR01](procedimientos/mod_rep/com/RSSALCAR01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `RS_SAL_CAR_02` | Cartera por Producto | [mod_rep.com.RSSALCAR02](procedimientos/mod_rep/com/RSSALCAR02.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `RS_SAL_CAR_03` | Productividad | [mod_rep.com.RSSALCAR03](procedimientos/mod_rep/com/RSSALCAR03.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera |
| `RS_SAL_CAR_04` | Saldo Puntual de Cartera Vigente | [mod_rep.com.RSSALCARVIGE01](procedimientos/mod_rep/com/RSSALCARVIGE01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera<br>shared / ui |
| `RS_SAL_CAR_05` | Cartera por Producto Vigente | `mod_rep.com.RSSALCARVIGE02` | `tip_cod`, `cod_rel`, `fecha` | ❌ no existe en la base | reportes / actividad-diaria / Cartera |
| `RS_SEG_PAS_01` | Seguros Pasivos Oncologico | [mod_rep.com.RSSEGPAS01](procedimientos/mod_rep/com/RSSEGPAS01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Seguros |
| `RS_SEG_PAS_02` | Seguros Pasivos Multiple Ahorro | [mod_rep.com.RSSEGPAS02](procedimientos/mod_rep/com/RSSEGPAS02.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Seguros |
| `RS_SEG_PAS_03` | Seguros Pasivos Resumen | [mod_rep.com.RSSEGPAS03](procedimientos/mod_rep/com/RSSEGPAS03.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Seguros |
| `RS_SEG_PAS_04` | Seguros Pasivos Protección Total | `mod_rep.com.RSSEGPAS04` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes / actividad-diaria / Seguros |
| `RS_TAB_COM_01` | TABLERO DIGITAL COMERCIAL | [mod_rep.com.RSTABCOMER](procedimientos/mod_rep/com/RSTABCOMER.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes<br>reportes / actividad-diaria / Tablero Digital<br>reportes / actividad-mensual |
| `RS_TAB_COM_02` | TABLERO DIGITAL COMERCIAL DETALLE | `mod_rep.com.RSTABCOMER02` | `usuariobt`, `fecha` | ❌ no existe en la base | — |
| `RS_TOP_ZCUO_01` | top 10 asesores Zcuo | [mod_rep.com.RTOPZCUO01](procedimientos/mod_rep/com/RTOPZCUO01.md) | `tip_cod`, `cod_rel`, `fecha` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RSIMR_01` | IMR | [mod_rep.com.RSIMR01](procedimientos/mod_rep/com/RSIMR01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `RSRTOP01` | Monitor de Efectividades TOP | [mod_rep.com.RSRTOP001](procedimientos/mod_rep/com/RSRTOP001.md) | `tip_cod`, `level` | ✅ validado | — |
| `RSRTOPV01` | Monitor de Efectividades TOP | [mod_rep.com.RSRTOPV001](procedimientos/mod_rep/com/RSRTOPV001.md) | `tip_cod`, `tip_cod2`, `level`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Cartera en Mora |
| `RVIUWGCOR_01` | Reporte Vista General Corresponsal | [mod_rep.com.GRVGENCORO01](procedimientos/mod_rep/com/GRVGENCORO01.md) | `tip_cod`, `cod_rel`, `fec`, `tip_age` | ✅ validado | reportes / actividad-diaria / Tablero Digital |
| `RVIUWGCORE_02` | Reporte Vista Gestión Corresponsal | [mod_rep.com.GRVGENCORO02](procedimientos/mod_rep/com/GRVGENCORO02.md) | `tip_cod`, `cod_rel`, `fec`, `tip_age` | ✅ validado | reportes / actividad-diaria / Tablero Digital |
| `Sec_ciiu_01` | Seguimiento de Sectores | [mod_rep.com.RSEGSECTOR001](procedimientos/mod_rep/com/RSEGSECTOR001.md) | `tip_cod`, `cod_rel`, `fec`, `grup` | ✅ validado | — |
| `SEG_AGRO_01` | SEGURO AGRO | [mod_rep.com.GRESREPSEG04](procedimientos/mod_rep/com/GRESREPSEG04.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `SEG_PDM_01` | Seguimiento PDM | [mod_rep.com.RSSEGPDM01](procedimientos/mod_rep/com/RSSEGPDM01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Reportes PDM |
| `SEGUI_COMITE_01` | SEGUIMIENTO COMITE | [mod_rep.com.GCOMCRE01](procedimientos/mod_rep/com/GCOMCRE01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | — |
| `SEGUI_INC_SEC_01` | Seguimiento Incentivos Asesores | [mod_rep.com.GSEGUIINC001](procedimientos/mod_rep/com/GSEGUIINC001.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `SEGUROS_ASESOR_01` | Tablero Seguros Asesor | `mod_rep.com.RSEGASE01` | `cod_rel`, `Fecha`, `tip_cod` | ❌ no existe en la base | — |
| `SEL_CIU_01` | Filtro CIIU | [mod_rep.com.GSELCIUT001](procedimientos/mod_rep/com/GSELCIUT001.md) | — | ✅ validado | — |
| `SEL_CIU_02` | Filtro CIIU Sector Eco | [mod_rep.com.GSELCIUT002](procedimientos/mod_rep/com/GSELCIUT002.md) | — | ✅ validado | — |
| `SEL_EFEC_01` | Filtro Detalle Efectividad | [mod_rep.com.GSELREP001](procedimientos/mod_rep/com/GSELREP001.md) | — | ✅ validado | reportes / actividad-diaria / Cartera en Mora<br>reportes / actividad-diaria / Portafolio Reasignado<br>reportes / actividad-mensual |
| `SEL_JEFE_01` | Filtro de Jefes | [mod_rep.com.GSELREP002](procedimientos/mod_rep/com/GSELREP002.md) | `codmod` | ✅ validado | — |
| `SEL_JER_01` | Filtro Territorio,Corred,agencia | [mod_rep.com.GSELJERAR001](procedimientos/mod_rep/com/GSELJERAR001.md) | — | ✅ validado | — |
| `SEL_JER_MENTORING_01` | FILTRO ASESORES | [mod_rep.com.GSELJERAR002](procedimientos/mod_rep/com/GSELJERAR002.md) | `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-diaria / Campañas |
| `TAB_CUE_RES_01` | Cuenta de Resultados | [mod_rep.rep.RTABCUERES01](procedimientos/mod_rep/rep/RTABCUERES01.md) | `fecha`, `tip_cod`, `cod_rel` | ✅ validado | reportes / actividad-mensual<br>reportes / actividad-mensual / Rentabilidad |
| `Tab_Dig_Com_A_01` | Tablero Digital Comercial Asesor | `mod_rep.com.RSTABCOMER02` | `usuariobt`, `Fecha` | ❌ no existe en la base | — |
| `TABDIG_01` | APP CLIENTES | [mod_rep.com.GRTABAPPO01](procedimientos/mod_rep/com/GRTABAPPO01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Tablero Digital |
| `TABDIG_02` | Tablero digital Corresponsal | [mod_rep.com.GRTABCORRO01](procedimientos/mod_rep/com/GRTABCORRO01.md) | `tip_cod`, `cod_rel`, `fec` | ✅ validado | reportes / actividad-diaria / Tablero Digital |
| `TABDIG_VR2_01` | TABLERO DIGITAL | `mod_rep.com.GRTABDIGO01` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | reportes / actividad-diaria / Tablero Digital |
| `TABDIG_VR2_COM_02` | TABLERO DIGITAL - COMERCIAL | `mod_rep.com.GRTABDIGO02` | `tip_cod`, `cod_rel`, `fec` | ❌ no existe en la base | — |
| `TABDIGITAL_COMERCIAL_01` | TABLERO DIGITAL COMERCIAL | [mod_rep.com.RTABDIGCOM01](procedimientos/mod_rep/com/RTABDIGCOM01.md) | `tip_cod`, `cod_rel` | ✅ validado | — |
| `TB_PANEL_OPE_01` | PANEL OPERACIONES PASIVO | `mod_rep.com.RSROPERA001` | `tip_cod`, `cod_rel`, `fec`, `prod` | ❌ no existe en la base | reportes / actividad-diaria / Captaciones |
| `TB_PANEL_OPE_02` | PANEL OPERACIONES PASIVO REGULA | `mod_rep.com.RSROPERA002` | `tip_cod`, `cod_rel`, `fec`, `prod` | ❌ no existe en la base | reportes / actividad-diaria / Captaciones |
| `VAC_RES_EJE_01` | Resumen ejecutivo | `mod_gpa.vac.GRESEJE01` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `VAC_RES_EJE_02` | Resumen Ejecutivo por Meses | `mod_gpa.vac.GRESEJE02` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
<!-- generado:fin -->
