# Reportes → procedimientos

Un renglón por entrada de `fuente/reportes.json`. Varios RCODREP pueden ejecutar el mismo SP con parámetros distintos.

<!-- generado:inicio reportes -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| RCODREP | Descripción | Procedimiento | Parámetros (en orden) | Estado | Front MIS |
|---|---|---|---|---|---|
| `actividadtasas_01` | Actividad y Tasas | `strategos.mod_rep_com_act.GDACTITASA01` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `AGRO_01` | AGRO | `mod_rep.com.GRESREAGRO01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Comercial Ejecutivo |
| `APP_USO_01` | Usabilidad APP | `mod_rep.com.RSAPPUSO001` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Aplicativo Movil |
| `CAP_SEGUI_BP_01` | Captaciones Seguimiento BP | `mod_rep.com.GSEGCAPBP01` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `CAP_SEGUI_BP_FC_01` | Gestión Red de Agencias | `mod_rep.com.GSEGCAPBP02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `CAP_SEGUI_FC_BP_01` | Gestión Red de Agencias | `mod_rep.com.GSEGCAPBP02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `CAP_SEGUI_RED_01` | Captaciones Seguimiento Red | `mod_rep.com.GSEGCAPRED01` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `CaptaBP_01` | CMG CAPTACIONES BP | `strategos.mod_rep_com_act.GDCCAP_BP01` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `CARACT_CARTERA_01` | CARACT.CARTERA | `mod_rep.com.RSRDFCA035` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `CARACT_CARTERA_M_01` | CARACT.CARTERA.Mensual | `mod_rep.com.RSRDFCA035` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / actividad-mensual |
| `CARACT_pas_01` | CARACT.pas | `mod_rep.com.RSRDFCA036` | `tip_cod`, `cod_rel`, `fec`, `prod`, `segmento` | ⏳ pendiente | reportes / actividad-diaria / Captaciones<br>shared / ui |
| `CARACT_pas_M_01` | CARACT.pas,Mensual | `mod_rep.com.RSRDFCA036` | `tip_cod`, `cod_rel`, `fec`, `prod`, `segmento` | ⏳ pendiente | reportes / actividad-mensual |
| `CEROCUOTA_TOPCNUEVA_01` | Top 10 Cero Cuotas Nuevas | `mod_rep.com.GTOPCERCUO001` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_02` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO002` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_03` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO003` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_04` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO004` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_05` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO005` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_M_01` | Top 10 Cero Cuotas Nuevas | `mod_rep.com.GTOPCERCUO001` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | — |
| `CEROCUOTA_TOPCNUEVA_M_02` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO002` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | — |
| `CEROCUOTA_TOPCNUEVA_M_03` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO003` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | — |
| `CEROCUOTA_TOPCNUEVA_M_04` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO004` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | — |
| `CEROCUOTA_TOPCNUEVA_M_05` | Top 5 TOP 5  CORREDOR SALDO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `mod_rep.com.GTOPCERCUO005` | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | ⏳ pendiente | — |
| `CEROYCUOTA_01` | CERO Y UNA CUOTA | `mod_rep.com.GRCEROCUOTAO01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CEROYCUOTA_02` | CERO Y UNA CUOTA | `mod_rep.com.GRCEROCUOTAO02` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CLI_VULNERABLE_01` | Filtro Clientes Vulnerables | `mod_rep.com.RSCLIVULNER01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `CLI_VULNERABLE_01` | Filtro Clientes Vulnerables | `mod_rep.com.RSCLIVULNER01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `Clientes_01` | Clientes | `mod_rep.com.RSRDFCA007` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Comercial Ejecutivo |
| `Clientes_nuevoRec_01` | Clientes nuevos y recurrentes | `mod_rep.com.RSRDFCA011` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Clientes |
| `Clientes_Ope_01` | Clientes y Operaciones | `mod_rep.com.GDCLIOPE01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Clientes |
| `CMCUONUEV_01` | Cuadro de Mando Cero Cuotas Nuevas | `mod_rep.com.GCMCNUE001` | `tip_cod`, `cod_rel`, `fec`, `prod`, `tipcuota` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CMCUONUEV_02` | Tipo Cero Cuotas Nuevas | `mod_rep.com.GCMCNUE002` | `tip_cod`, `cod_rel`, `fec`, `prod`, `tipcuota` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `CMG_CARTERA_01` | CMG CARTERA | `mod_rep.com.RSCMGFCA002` | `codrel`, `Fecha`, `tipcod`, `met`, `prod` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `CMG_CARTERA_02` | CMG CARTERA | `mod_rep.com.RSRDFCA037` | `tipcod`, `cod_rel`, `tipmet`, `prod`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `CMG_CARTERA_03` | CMG CARTERA | `mod_rep.com.RSRDFCA038` | `tipcod`, `cod_rel`, `tipmet`, `prod` | ⏳ pendiente | — |
| `CMG_CARTERA_ASESOR_01` | Cartera Asesor | `mod_rep.com.GCMGCARTAS001` | `cod_rel`, `Fecha`, `tip_cod`, `met` | ⏳ pendiente | — |
| `CMG_CLI_PAS_01` | CMG Clientes Pasivos | `mod_rep.com.RSCMGCLIPAS01` | `tip_cod`, `cod_rel`, `fec`, `agru` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `CMG_CLI_PAS_DETA_01` | CMG Clientes Pasivos Detalle | `mod_rep.com.RSCMGCLIPAS03` | `tip_cod`, `cod_rel`, `fec`, `agru`, `grupo` | ⏳ pendiente | — |
| `CMG_CLI_PAS_STOCK_02` | CMG Clientes Pasivos Stock | `mod_rep.com.RSCMGCLIPAS02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `CMG_CLIF_01` | CMG Clientes Flujo | `mod_rep.com.RSCMGCF001` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Clientes<br>reportes / actividad-mensual |
| `cmg_mora_simp_01` | Cmg Mora Sin Impulso | `mod_rep.com.GCMGMORA001_SIMP` | `cod_rel`, `fec`, `tip_cod` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `cmg_mora_simp_m_01` | Cmg Mora Sin Impulso Mensual | `mod_rep.com.GCMGMORA001_SIMP` | `cod_rel`, `fec`, `tip_cod` | ⏳ pendiente | reportes / actividad-mensual |
| `CON_AGRO_FEN` | Consulta FEN CENEPRED | `mod_rep.com.REXPAGRO01` | `col`, `val` | ⏳ pendiente | consulta-fen |
| `CONT_ELECT_M_01` | Contraración Electrónica | `mod_rep.com.RSRDFCA024` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-mensual |
| `CONT_ELECT_M_02` | Contraración Electrónica | `mod_rep.com.RSRDFCA025` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-mensual |
| `CONT_ELECT_M_03` | Contraración Electrónica | `mod_rep.com.RSRDFCA026` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-mensual |
| `CONT_ELECT_M_04` | Contraración Electrónica | `mod_rep.com.RSRDFCA032` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-mensual |
| `COSELISTADO_02` | Listado Cosechas | `mod_rep.com.GCOSELIS001` | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro`, `madu`, `pagen`, `nom` | ⏳ pendiente | — |
| `COSESEMAFORO_01` | SEMAFORO DE COSECHAS | `mod_rep.com.GCOSEMAF002` | `tip_cod`, `cod_rel`, `prod`, `subpro`, `madu`, `op` | ⏳ pendiente | reportes / actividad-mensual |
| `cuadro_Variable_M_01` | Cuadro Variable Riesgo Mensual | `mod_rep.com.GCMGMORA001` | `cod_rel`, `fec`, `tip_cod` | ⏳ pendiente | reportes / actividad-mensual |
| `cuadro_Variable_Riesgo_01` | Cuadro Variable Riesgo | `mod_rep.com.GCMGMORA001` | `cod_rel`, `fec`, `tip_cod` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `cuadro_Variable_Riesgo_F_01` | Cuadro Variable Riesgo Finanzas | `mod_rep.com.GCMGMORA003` | `cod_rel`, `fec`, `tip_cod` | ⏳ pendiente | — |
| `DASHBOARD_CLIENTES_01` | Dashboard Clientes | `mod_rep.com.GDASHCLI01` | `uni_cfg`, `sel_cfg` | ⏳ pendiente | — |
| `DESCRED_01` | Reporte de Destino de Crédito | `mod_rep.com.GRESDESCRE02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `DESE_SOC_01` | Desempeno Social | `mod_rep.com.RSDESEMP01` | `uni_cfg` | ⏳ pendiente | — |
| `DESE_SOC_AS_01` | Desempeno Social | `mod_rep.com.RSDESEMP02` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `DESEMBOLSOS_01` | Desembolsos SIN FAE NI REACTIVA | `mod_rep.com.GDACDESEM01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Comercial Ejecutivo |
| `DesemDiario_01` | Desembolsos Diarios | `strategos.mod_rep_com_act.GDDESEMDIA` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `DesemDiario_02` | Operaciones Diario CE 01 | `mod_rep.com.RSRDFCA021` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `DesemDiario_03` | Operaciones Diario CE 02 | `mod_rep.com.RSRDFCA022` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `DesemDiario_04` | Operaciones Diario CE 03 | `mod_rep.com.RSRDFCA023` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `DesemDiario_05` | Operaciones Diario CE 05 | `mod_rep.com.RSRDFCA031` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `DESEMP_SOC_01` | Desempeño Social | `mod_rep.com.RSDESEMP01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `DESEMP_SOC_PAS_01` | Desempeno Social Pasivos | `mod_rep.com.RSDESEMPAS01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `DET_CLI_01` | Lista Clientes Reprogramados  | `mod_rep.com.GLISDETCLI01` | `cod_rel` | ⏳ pendiente | — |
| `DET_INCEN_PDM_01` | DETALLE INCENTIVO PDM | `mod_rep.com.DINCEPDM01` | `tip_cod`, `cod_rel`, `fecha`, `pagen` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `EfecRecTramos_01` | Portafolio Agro | `strategos.mod_rep_com_act.GDEFECTMORA01` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `enrolamiento_colaboradores_01` | Enrolamiento Colaboradores | `mod_rep.com.RENRCOLAB01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `enrolamiento_desembolso_01` | Enrolamiento Desembolso | `mod_rep.com.RENRDESEM01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `enrolamiento_Ope_01` | Enrolamiento Operaciones | `mod_rep.com.RENROPE01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `enrolamiento_pasivo_01` | Enrolamiento Pasivo | `mod_rep.com.RENRPAS01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `enrolamiento_pasivo_pas_02` | Enrolamiento Pasivo | `mod_rep.com.RENRPAS02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `GCMGCAP_01` | CMG Pasivas | `mod_rep.com.GCMGCAP01` | `fec`, `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Captaciones<br>reportes / actividad-mensual |
| `GCOMCRE_02` | Comite de Créditos Diario | `mod_rep.com.GCOMCRE02` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GCTABDIG_VR2_COM_03` | GC TABLERO DIGITAL - Comercial | `mod_rep.com.GRGCTABDIGO03` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `GCTABDIG_VR2_OPE_02` | GC TABLERO DIGITAL - Operacional | `mod_rep.com.GRGCTABDIGO02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `GLISAUTRO_04` | Listado Autonomias | `mod_rep.com.GLISAUTRO05` | `tip_cod`, `cod_rel`, `cargo` | ⏳ pendiente | — |
| `GRAF_GEST_COM_01` | GRAF Gestión Comercial | `mod_rep.com.RGRAFGESTCOM01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_02` | GRAF Gestión Comercial | `mod_rep.com.RGRAFGESTCOM02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_03` | Graf Gestión Comercial | `mod_rep.com.RGRAFGESTCOM03` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_04` | Graf Gestión Comercial | `mod_rep.com.RGRAFGESTCOM04` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_05` | Graf Gestión Comercial | `mod_rep.com.RGRAFGESTCOM05` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_06` | Graf Gestión Comercial | `mod_rep.com.RGRAFGESTCOM06` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_07` | Graf Gestión Comercial | `mod_rep.com.RGRAFGESTCOM07` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `GRAF_GEST_COM_07_` | DEV Graf Gestión Comercial | `storage.com.RGRAFGESTCOM07_` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `GRAF_ZCUO_01` | Graf Zero Cuotas | `mod_rep.com.RGRAFZCUO01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `GRAF_ZCUO_02` | Graf Zero Cuotas | `mod_rep.com.RGRAFZCUO02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `GRAF_ZCUO_03` | Graf Zero Cuotas | `mod_rep.com.RGRAFZCUO03` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `GRAF_ZCUO_04` | Graf Zero Cuotas | `mod_rep.com.RGRAFZCUO04` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `GRAFSEGPAS_01` | GRAFICO SEGURO PASIVOS ONCOLOGICO | `mod_rep.com.RGRAFSEGPAS01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `GRAFSEGPAS_02` | GRAFICO SEGURO PASIVOS MULTIPLE AHORRO | `mod_rep.com.RGRAFSEGPAS02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `GRBSOLI_01` | Reporte Grupo Solidario | `mod_rep.com.RSDEPGSOLID01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Reportes PDM |
| `GREPORCORRE_01` | Corresponsales | `mod_rep.com.RCORRES01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `GREPORCORRE_05` | Grafico Mapa Corresponsales | `mod_rep.com.RCORRES05` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `GREPORCORRE_06` | Corresponsales Metas | `mod_rep.com.RCORRES06` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `GREPROSPCORRE_01` | TAB_MENU_PROSPECTO_Corresponsales | `mod_rep.com.RPROSCORR002` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `GREPROSPCORRE_02` | Graf_Pie_PROSTO_Corresponsales | `mod_rep.com.RPROSCORR004` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `GREPROSPCORRE_03` | Graf_Pie_PROSTO_Inst_Corresponsales | `mod_rep.com.RPROSCORR006` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `GREPROSPCORRE_06` | Meta_PROSPECTO_Corresponsales | `mod_rep.com.RPROSCORR005` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `GRESCAMIMP_01` | Campaña Imparables | `mod_rep.com.GRESCAMIMP01` | `cod_rel`, `tip_cod` | ⏳ pendiente | — |
| `GRESCAMIMP_02` | Top Imparables | `mod_rep.com.GRESTOPIMP01` | `cod_rel`, `tip_cod` | ⏳ pendiente | — |
| `GRESCONDO_01` | Modulo de Condonaciones | `mod_rep.com.GRESCAMCOND01` | `tip_cod`, `cod_rel`, `tdcrMonto`, `tdcrMoti` | ⏳ pendiente | — |
| `GRESCONDO_02` | Modulo de Condonaciones Mes Día  | `mod_rep.com.GRESCAMCOND01` | `tip_cod`, `cod_rel`, `tdcrMonto`, `tdcrMoti`, `diariomes`, `niveles` | ⏳ pendiente | — |
| `GRESCONDO_03` | Modulo de Condonaciones Mes Día  | `mod_rep.com.GRESCAMCOND03` | `tip_cod`, `cod_rel`, `fec`, `tdcrMonto`, `tdcrMoti`, `niveles` | ⏳ pendiente | — |
| `GRSCMIS_01` | Modulo de Detalle Seguro | `mod_rep.com.GRESREPSEG01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `GRSCMIS_02` | Modulo de Detalle Asesor | `mod_rep.com.GRESREPSEG02` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `GRSCMIS_03` | Modulo de Resumen Pasivos | `mod_rep.com.GRESREPSEG03` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `GRSCMIS_04` | Meta por Producto | `mod_rep.com.GRESREPSEG05` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `GRSCMIS_05` | Reporte Detalle | `mod_rep.com.GRESREPSEG06` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `GRSCMISREP_01` | Seguro Optativo | `mod_rep.com.GRESREPSEG_01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `GSCAMP_01` | Campaña Agil | `mod_rep.com.GSCAMP01` | `cod_rel`, `tip_cod`, `ind`, `sem` | ⏳ pendiente | — |
| `GSCASEG_01` | Campaña de Seguros | `mod_rep.com.GSCASEG01` | `cod_rel`, `tip_cod` | ⏳ pendiente | — |
| `GSMODAGEN_01` | Modulo de Agendamiento | `mod_rep.com.GSMODAGEN01` | `cod_rel`, `tip_cod` | ⏳ pendiente | — |
| `GSREVA01` | Reporte Reva | `mod_rep.rep.GSREVA01` | `Fecha`, `tipcod`, `codrel`, `codmod` | ⏳ pendiente | — |
| `GSREVA101` | Reporte Reva | `mod_rep.rep.GSREVA01` | `Fecha`, `tipcod`, `codrel`, `codmod` | ⏳ pendiente | — |
| `GSREVA201` | Reporte Reva | `mod_rep.rep.GSREVA01` | `Fecha`, `tipcod`, `codrel`, `codmod` | ⏳ pendiente | — |
| `GST_ACTIVAS_01` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_02` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_03` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_04` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_05` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_06` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_07` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST03` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_08` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST03` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_09` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST04` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_10` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST04` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_M_01` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_M_02` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_M_03` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_M_04` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_M_05` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_ACTIVAS_M_06` | GESTION TASAS ACTIVAS | `mod_rep.com.GDCGEST_ACTIVAST01` | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | ⏳ pendiente | — |
| `GST_PASIVA_01` | GESTION TASAS PASIVAS | `mod_rep.com.GDCGEST_PASIVAST01` | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `GST_PASIVA_02` | GESTION TASAS PASIVAS | `mod_rep.com.GDCGEST_PASIVAST01` | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `GST_PASIVA_03` | GESTION TASAS PASIVAS | `mod_rep.com.GDCGEST_PASIVAST01` | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ⏳ pendiente | — |
| `GST_PASIVA_M_01` | GESTION TASAS PASIVAS | `mod_rep.com.GDCGEST_PASIVAST01` | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ⏳ pendiente | — |
| `GST_PASIVA_M_02` | GESTION TASAS PASIVAS | `mod_rep.com.GDCGEST_PASIVAST01` | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ⏳ pendiente | — |
| `GST_PASIVA_M_03` | GESTION TASAS PASIVAS | `mod_rep.com.GDCGEST_PASIVAST01` | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | ⏳ pendiente | — |
| `HCARBONO_01` | Huella de carbono | `mod_rep.com.RSHHCARB001` | `tip_cod`, `cod_rel`, `fec`, `cargambiental` | ⏳ pendiente | reportes / actividad-mensual |
| `HTTPTRACE_01` | Servicio Reporte de Uso | `strategos.mod_rep_com_act.HTTPTRACE` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `INCEN_PDM_01` | INCENTIVOS PDM | `mod_rep.com.RINCEPDM01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | — |
| `LCCUOTANUEVA_01` | BASE DE GESTION CERO CUOTAS NUEVAS | `mod_rep.com.RSLISTCCN01` | `tip_cod`, `cod_rel`, `pagen`, `tipcuota` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `LIS_CAPRET_01` | List Capacity Retailer | `mod_rep.com.GLISCAPRET01` | `cod_rel` | ⏳ pendiente | — |
| `LIS_PROSPE_01` | Lista de Prospectos | `mod_rep.com.GLISPROSP01` | `cod_rel` | ⏳ pendiente | — |
| `LSRC_DATA_REACT_01` | Data de Reactivados | `mod_rep.com.RCDATREACT01` | `fecha` | ⏳ pendiente | — |
| `LST_AUT_01` | Lista Autonomias | `mod_rep.com.GLISAUTO01` | `tip_cod`, `cod_rel`, `c_aut`, `aut` | ⏳ pendiente | — |
| `Monitor_Dese_01` | Monitor desembolsos Operación | `mod_rep.com.RSRDFCA027` | `tipmet`, `tip_cod`, `cod_rel` | ⏳ pendiente | core / winder<br>reportes / avance-comercial |
| `Monitor_Dese_02` | Monitor desembolsos Monto | `mod_rep.com.RSRDFCA030` | `tipmet`, `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / avance-comercial |
| `Monitor_Dese_03` | Monitor desembolsos Cumplimiento | `mod_rep.com.RSRDFCA028` | `tipmet`, `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / avance-comercial |
| `Monitor_Dese_04` | Monitor desembolsos Promedio | `mod_rep.com.RSRDFCA029` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / avance-comercial |
| `Monitor_Dese_misi_01` | Monitor desembolsos Operación | `mod_rep.com.RSRDFCA050` | `tipmet`, `tip_cod`, `cod_rel`, `prod` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `Monitor_Dese_misi_02` | Monitor desembolsos Operación  | `mod_rep.com.RSRDFCA050_3` | `tipmet`, `tip_cod`, `cod_rel`, `prod` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `MOVIMIENTO_CLIENTES_01` | Movimiento Clientes | `mod_rep.com.GMOVCLI01` | — | ⏳ pendiente | reportes / actividad-diaria / Clientes |
| `P_Datos_01` | Plan de Datos | `mod_rep.com.GRESPDATOS01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-mensual |
| `P_Datos_02` | Plan de Datos | `mod_rep.com.GRESPDATOS02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PANEL_SUP_01` | Panel de Supervisión | `mod_rep.com.RSPANSUP001` | `tip_cod`, `cod_rel`, `carg` | ⏳ pendiente | — |
| `PANEL_SUP_02` | Panel de Supervisión Detalle | `mod_rep.com.RSPANSUP002` | `tip_cod`, `cod_rel`, `carg`, `state` | ⏳ pendiente | — |
| `PANEL_SUP_02` | Panel de Supervisión Detalle | `mod_rep.com.RSPANSUP002` | `tip_cod`, `cod_rel`, `carg`, `state` | ⏳ pendiente | — |
| `PANEL_SUP_03` | Panel de Supervisión 2 | `mod_rep.com.RSPANSUP003` | `tip_cod`, `cod_rel`, `carg` | ⏳ pendiente | — |
| `PANEL_SUP_04` | Supervision desembolsos | `mod_rep.com.RSPANSUP004` | `tip_cod`, `cod_rel`, `cant` | ⏳ pendiente | — |
| `PANEL_SUP_05` | Detalle Supervision desembolsos | `mod_rep.com.RSPANSUP005` | `tip_cod`, `cod_rel`, `cant` | ⏳ pendiente | — |
| `Pasivo_01` | Pasivos | `mod_rep.com.GPASP001` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `PDM_01` | PDM | `mod_rep.com.GPDM001` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Comercial Ejecutivo |
| `PLANMOV_01` | Planilla Movilidad | `mod_rep.com.GLIMOVO01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOV_02` | Planilla Movilidad | `mod_rep.com.GLIMOVO02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOV_03` | Detalle | `mod_rep.com.GLIMOVO05` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOV_04` | Detalle Dep | `mod_rep.com.GLIMOVO06` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOVPERFIL_01` | Planilla Movilidad Perfil | `mod_rep.com.GLIMOVO01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOVPERFIL_02` | Planilla Movilidad Perfil | `mod_rep.com.GLIMOVO02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOVR_01` | Planilla Movilidad Recuperador | `mod_rep.com.GLIMOVRO01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOVR_03` | Planilla Movilidad Recuperador | `mod_rep.com.GLIMOVRO05` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `PLANMOVR_04` | Detalle Dep Recuperador | `mod_rep.com.GLIMOVRO06` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `pob_misi_01` | Productos Top Territorio | `mod_rep.com.RSRTOPPOMIS001` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | — |
| `pob_misi_02` | Productos Top corredor | `mod_rep.com.RSRTOPPOMIS002` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | — |
| `pob_misi_03` | Productos Top Unidad | `mod_rep.com.RSRTOPPOMIS003` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | — |
| `pob_misi_04` | Productos Top Asesores | `mod_rep.com.RSRTOPPOMIS004` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | — |
| `PortafolioAgro_01` | Portafolio Agro | `strategos.mod_rep_com_act.GDPORTAGRO01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `PORTSUPE_01` | Portafolio y Supervision | `strategos.mod_rep_com_act.GDPSUPERV01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `PORTSUPE_02` | Portafolio y Supervision | `strategos.mod_rep_com_act.GDPSUPERV02` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `PRECOSECUADRO_03` | Cuadro Pre Cosechas | `mod_rep.com.GPRECOSCUAD001` | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro` | ⏳ pendiente | — |
| `PRECOSELISTADO_02` | Listado Pre Cosechas | `mod_rep.com.GPRECOSELIS001` | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro`, `pagen`, `nom` | ⏳ pendiente | — |
| `prod_misi_01` | Productos Top corredor | `mod_rep.com.RSRTOPMIS001` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `prod_misi_02` | Productos Top Unidad | `mod_rep.com.RSRTOPMIS002` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `prod_misi_03` | Productos Top Asesores | `mod_rep.com.RSRTOPMIS003` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `prod_misi_04` | Productos Top Territorio | `mod_rep.com.RSRTOPMIS004` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `prod_misi_05` | Monitor desembolsos Operación  | `mod_rep.com.RSRDFCA050_4` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / desarrollo-sostenible |
| `PROYEC_COLREC_01` | proyeccion de colocaciones | `mod_rep.com.RSPROYCOLDES001` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Proyecciones |
| `PROYEC_COLREC_02` | proyeccion de recuperaciones | `mod_rep.com.RSPROYCOLDES002` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `PROYEC_COLREC_03` | proyeccion diaria colocacion detalle | `mod_rep.com.RSPROYCOLDES009` | `tip_cod`, `cod_rel`, `pagen` | ⏳ pendiente | reportes / actividad-diaria / Proyecciones |
| `PROYEC_COLREC_04` | proyeccion diaria recuperacion detalle | `mod_rep.com.RSPROYCOLDES010` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `PROYEC_DIACOLREC_01` | proyeccion diaria colocaciones | `mod_rep.com.RSPROYCOLDES003` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Proyecciones |
| `PROYEC_DIACOLREC_02` | proyeccion diaria monto | `mod_rep.com.RSPROYCOLDES004` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Proyecciones |
| `PROYEC_DIACOLREC_03` | proyeccion diaria efectividades | `mod_rep.com.RSPROYCOLDES005` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `PROYEC_DIACOLREC_AS_01` | proyeccion diaria colocaciones asesor | `mod_rep.com.RSPROYCOLDES006` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `PROYEC_DIACOLREC_AS_02` | proyeccion diaria monto asesor | `mod_rep.com.RSPROYCOLDES007` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `PROYEC_DIACOLREC_AS_03` | proyeccion diaria efectividades asesor | `mod_rep.com.RSPROYCOLDES008` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `R_APADRINA_01` | Apadrinamiento | `mod_rep.com.RSRDMA023` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Campañas |
| `RACTGP_01` | Activas PDM | `mod_rep.com.RACTGP01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `rankKay_01` | Ranking Kaypacha | `mod_rep.com.GDASHKAY03` | `cod_rel`, `fec`, `Ter` | ⏳ pendiente | reportes / actividad-mensual |
| `rankKayOpe_01` | Ranking Kaypacha Operaciones | `mod_rep.com.GDASHKAY05` | `cod_rel`, `fec`, `Ter` | ⏳ pendiente | reportes / actividad-mensual |
| `rankKayrecu_01` | Ranking Kaypacha Recuperaciones | `mod_rep.com.GDASHKAY06` | `cod_rel`, `fec`, `Ter` | ⏳ pendiente | reportes / actividad-mensual |
| `RDETCORR_01` | Detalle Corresponsales | `mod_rep.com.RDETCORR01` | `tip_cod`, `cod_rel`, `fec`, `pagen`, `tipo` | ⏳ pendiente | — |
| `REACT_PDM_01` | Lista Clientes PDM Reprogramados | `mod_rep.com.GLISDETCLIPDM01` | `cod_rel`, `base` | ⏳ pendiente | — |
| `RECSERV_PAS_01` | Recaudos Pasivos | `mod_rep.com.RSRSRV001` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `REP_CATEGO_ASE_01` | Reporte Categorización Asesor | `mod_sec.dbo.GCATSEC01` | `cod_bt` | ⏳ pendiente | — |
| `REP_CERCUOT_01` | Reporte cero cuota | `mod_rep.com.GDCEROCN003` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `REP_CERCUOT_02` | Reporte cero cuota | `mod_rep.com.GDCEROCN004` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `reporte_autonomia_new_01` | Lista... | `mod_rep.com.GDCGEST_ACTIVAST02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-mensual |
| `reporte_autonomia_newdiaria_01` | Lista... | `mod_rep.com.GDCGEST_ACTIVAST02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `reporte-demo` | Reporte Demo | `mod_rep.dbo.REPORTE_DEMO` | `fecha`, `cod_user_bt` | ⏳ pendiente | — |
| `RES_SEC_REP_01` | Lista Clientes Reprogramados | `mod_rep.com.GRESCLIREP01` | `cod_rel` | ⏳ pendiente | — |
| `RESINCGRUP_01` | Incentivos Meta Grupos PDM | `mod_rep.com.RINCEGP01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RESMORAGP_01` | Mora Grupos PDM | `mod_rep.com.RMORAGP01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RESNMOV_01` | Mov. Resumen Detalle Comercial | `mod_rep.com.RESDMOV01` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria |
| `RESNMOV_02` | Mov. Resumen Detalle Analista | `mod_rep.com.RESDMOV02` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `RESNMOVR_01` | Mov. Resumen Detalle Recuperaciones | `mod_rep.com.RESDMOV02` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria |
| `resultado_unidad_negocio_rma_01` | RESULTADO GUN | `strategos.mod_rep_com_act.CABGMRESULUNINEGB01` | `tip_cod`, `cod_rel`, `fec`, `canal` | ⏳ pendiente | reportes / actividad-mensual |
| `resultado_unidad_negocio_rma_ope_01` | RESULTADO GUN | `strategos.mod_rep_com_act.CABGMRESULUNINEGB01` | `tip_cod`, `cod_rel`, `fec`, `canal` | ⏳ pendiente | — |
| `rma/administracion/Mora/monitor_efectividad_rma_03` | Gestión de Monitor Efectividades | `mod_rep.com.RSGESMOEF001` | `tip_cod`, `cod_rel`, `tram` | ⏳ pendiente | — |
| `RMENTORIN_01` | Reporte Mentoring 01 | `mod_rep.com.GRMENTOR001` | `tip_cod`, `cod_rel`, `fec`, `resp` | ⏳ pendiente | reportes / actividad-diaria / Campañas |
| `RMENTORIN_02` | Reporte Mentoring 02 | `mod_rep.com.GRMENTOR002` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `RMESA_01` | Efectividades Sin Asignar | `mod_rep.com.RMESA01` | `tip_cod`, `cod_rel`, `pagen` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RPROGOB_01` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB01` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | — |
| `RPROGOB_02` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB01` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | — |
| `RPROGOB_03` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB02` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | — |
| `RPROGOB_04` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB02` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | — |
| `RPROGOB_M_01` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB01` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | reportes / actividad-mensual |
| `RPROGOB_M_02` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB01` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | reportes / actividad-mensual |
| `RPROGOB_M_03` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB02` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | reportes / actividad-mensual |
| `RPROGOB_M_04` | Reporte de cartera de progamas del gobierno | `mod_rep.com.GRESPROGOB02` | `cod_rel`, `tip_cod`, `fec`, `var` | ⏳ pendiente | reportes / actividad-mensual |
| `RS_AGE_COM_01` | Agendamiento Comercial | `mod_rep.com.RSAGECOM01` | `tip_cod`, `cod_rel`, `fecha`, `mode`, `fuga`, `prop` | ⏳ pendiente | reportes / actividad-diaria / Campañas |
| `RS_AGE_COM_02` | Detalle Agendamiento Comercial | `mod_rep.com.RSAGECOM02` | `tip_cod`, `cod_rel`, `fecha`, `mode`, `fuga`, `prop`, `nom` | ⏳ pendiente | reportes / actividad-diaria / Campañas |
| `RS_AGE_COM_03` | Detalle Agendamiento Automatico y Express | `mod_rep.com.RSAGECOM03` | `tip_cod`, `cod_rel`, `fecha`, `mode`, `fuga`, `prop` | ⏳ pendiente | reportes / actividad-diaria / Campañas |
| `RS_AGE_COM_CR_01` | Agendamiento Comercial Reasignado | `mod_rep.com.RS_AGE_COM_CR_01` | `tip_cod`, `cod_rel`, `ver`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_AGE_COM_CR_03` | Detalle Agendamiento Comercial Reasignado | `mod_rep.com.RS_AGE_COM_CR_02` | `tip_cod`, `cod_rel`, `pagen`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_AGE_COM_CRM_01` | Agendamiento Comercial Reasignado Mensual | `mod_rep.com.RS_AGE_COM_CR_01` | `tip_cod`, `cod_rel`, `ver`, `fecha` | ⏳ pendiente | — |
| `RS_AGE_COM_CRM_03` | Detalle Agendamiento Comercial Reasignado Mesual | `mod_rep.com.RS_AGE_COM_CR_02` | `tip_cod`, `cod_rel`, `pagen`, `fecha` | ⏳ pendiente | reportes / actividad-mensual |
| `RS_AGE_COM_CRM_F_01` | Agendamiento Comercial Reasignado Flujo | `mod_rep.com.RS_AGE_COM_CR_M_01` | `tip_cod`, `cod_rel`, `ver`, `fecha` | ⏳ pendiente | reportes / actividad-mensual |
| `RS_AGE_COM_CRM_F_03` | DetalleAgendamiento Comercial Reasignado Flujo | `mod_rep.com.RS_AGE_COM_CR_M_02` | `tip_cod`, `cod_rel`, `pagen`, `fecha` | ⏳ pendiente | — |
| `RS_AGE_COM_CRM_S_01` | Agendamiento Comercial Reasignado Stock | `mod_rep.com.RS_AGE_COM_CR_M_03` | `tip_cod`, `cod_rel`, `ver`, `fecha`, `tipo_ase` | ⏳ pendiente | — |
| `RS_AGE_COM_CRM_S_03` | DetalleAgendamiento Comercial Reasignado Stock | `mod_rep.com.RS_AGE_COM_CR_M_04` | `tip_cod`, `cod_rel`, `ver`, `fecha`, `tipo_ase` | ⏳ pendiente | — |
| `RS_AGROMIX_01` | REPORTE AGROMIX | `mod_rep.com.RAGROMIX` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_AGROMIX_02` | Graf Vencido AGROMIX | `mod_rep.com.RS_AGROMIX_CHART` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes |
| `RS_AGROMIX_03` | Graf Capital AGROMIX | `mod_rep.com.RS_AGROMIX_CHART2` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes |
| `RS_AGROMIX_04` | Graf Clientes AGROMIX | `mod_rep.com.RS_AGROMIX_CHART3` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes |
| `RS_AGROMIX_05` | Graf Resumen AGROMIX | `mod_rep.com.RS_AGROMIX_CHART4` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes |
| `RS_AVA_POR_01` | Avance de Portafolio | `mod_rep.com.RSAVAPOR01` | `tip_cod`, `cod_rel`, `mode`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_BASE_NEG_01` | Base Negativa Riesgos | `mod_rep.com.RSBASENEG01` | `nom` | ⏳ pendiente | core / winder<br>herramientas |
| `RS_CAL_CAR_01` | Calidad de Cartera 1 | `mod_rep.com.RSCALCAR01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_CAL_CAR_02` | Calidad de Cartera 2 | `mod_rep.com.RSCALCAR02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_CARD_ZCUO_01` | Card reporte cero cuotas | `mod_rep.com.RCARDZCUO01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_CARTEPAS_01` | Reporte Carterización Pasivo | `mod_rep.com.RSCOMPAS01` | `tipcod`, `codrel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `RS_DAT_PRO_01` | Datos por Producto 1 | `mod_rep.com.RSDATPRO01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DAT_PRO_02` | Datos por Producto 2 | `mod_rep.com.RSDATPRO02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DAT_PRO_03` | Datos por Producto 3 | `mod_rep.com.RSDATPRO03` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DAT_PRO_04` | Datos por Producto 4 | `mod_rep.com.RSDATPRO04` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |
| `RS_DESEMB_01` | Estructura de Desembolsos | `mod_rep.com.RSDESEMB` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual<br>reportes / actividad-mensual / Cartera<br>shared / ui |
| `RS_DESEMB_02` | Estructura de Desembolsos Mensual | `mod_rep.com.RSDESEMB02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-mensual<br>reportes / actividad-mensual / Cartera |
| `RS_FECH` | Fechas Reporte Mensual | `mod_rep.com.RFECREPMEN` | `fec` | ⏳ pendiente | reportes<br>reportes / actividad-diaria / Cartera<br>reportes / actividad-diaria / Cartera en Mora<br>reportes / actividad-diaria / Seguros<br>reportes / actividad-mensual<br>reportes / actividad-mensual / Cartera<br>reportes / actividad-mensual / Tablero Digital |
| `RS_FECH02` | Fecha Reporte Hoy Mensual | `mod_rep.com.RFECREPMEN02` | `fec` | ⏳ pendiente | reportes<br>reportes / actividad-diaria / Cartera<br>reportes / actividad-diaria / Seguros |
| `RS_GEST_COM_01` | Reporte Gestión Comercial | `mod_rep.com.RSGETCOM01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_GEST_COM_02` | Reporte Evolutivo Var Vigente | `mod_rep.com.RREPGESTCOM02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_GEST_COM_03` | Reporte Evolutivo Var Cliente Stock | `mod_rep.com.RREPGESTCOM03` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_MON_CAR_01` | Control Cargas Prod | `mod_rep.com.RSRPD001` | `opt` | ⏳ pendiente | reportes / control-cargas |
| `RS_MON_EFEC_01` | Monitor de Efectividades | `mod_rep.com.RSMONEFE01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFEC_02` | Detalle de Efectividades | `mod_rep.com.RSMONEFE02` | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `nom`, `resp`, `tdcr`, `pagen`, `fcompro`, `precosechaf` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFEC_03` | Gestión de Monitor Efectividades | `mod_rep.com.RSMONEFE03` | `tip_cod`, `cod_rel`, `tram` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFEC_SEC_01` | Detalle de Efectividades Asesor | `mod_rep.com.RSMONEFE05` | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `tdcr`, `pagen` | ⏳ pendiente | — |
| `RS_MON_EFECM_01` | Monitor de Efectividades Mensual | `mod_rep.com.RSMONEFE01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-mensual |
| `RS_MON_EFECM_02` | Detalle de Efectividades Mensual | `mod_rep.com.RSMONEFE02` | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `nom`, `resp`, `tdcr`, `pagen`, `fcompro`, `precosechaf` | ⏳ pendiente | reportes / actividad-mensual |
| `RS_MON_EFECM_03` | Gestión de Monitor Efectividades Mensual | `mod_rep.com.RSMONEFE03` | `tip_cod`, `cod_rel`, `tram` | ⏳ pendiente | reportes / actividad-mensual |
| `RS_MON_EFECREASIG_01` | Monitor de Efectividades Reasignados | `mod_rep.com.RSMONEFER01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_MON_EFECREASIG_02` | Detalle de Efectividades | `mod_rep.com.RSMONEFER02` | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `nom`, `resp`, `tdcr`, `pagen`, `fcompro` | ⏳ pendiente | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_MON_EFECREASIG_03` | Efectividades Reasignados fechas | `mod_rep.com.RSMONEFER03` | `tip_cod`, `cod_rel`, `fec`, `imp` | ⏳ pendiente | — |
| `RS_MON_EFECREASIGM_01` | Monitor de Efectividades Reasignados Mensual | `mod_rep.com.RSMONEFER01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-mensual |
| `RS_MON_EFECREPRO_01` | Monitor de Efectividades Reprogramados | `mod_rep.com.RSMONEFEREPRO01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFECTRAMOSC_01` | Seguimiento PDM | `mod_rep.com.RSMONEFETRC01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_INT_COM_01` | Reporte Monitor Inteligencia Comercial | `mod_rep.com.RMONINTCOM01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_MON_REP_01` | Monitor de reprogramados | `mod_rep.com.GDMREP001` | `cod_rel`, `fec`, `tip_cod`, `car` | ⏳ pendiente | reportes / avance-comercial |
| `RS_MON_REP_SEC_01` | Monitor de reprogramados | `mod_rep.com.GDMREP001` | `cod_rel`, `fec`, `tip_cod`, `car` | ⏳ pendiente | — |
| `RS_MON_SALCAP_COM_01` | Reporte Saldo Captacion Cartera | `mod_rep.com.RSCAPCOME01` | `codrel`, `fecha`, `tipcod` | ⏳ pendiente | reportes<br>reportes / actividad-diaria / Captaciones |
| `RS_RANK_COM_01` | Ranking Comercial | `mod_rep.com.RSRANKCOM01` | `territorio`, `corredor`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_RANK_MUJ_01` | RANKING MUJER | `mod_rep.com.RRANKM01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `RS_RANK_MUJ_02` | RANKING MUJER CARTERA | `mod_rep.com.RRANKM02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `RS_RETE_01` | Modulo Retención | `mod_rep.com.RSMONRENT01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `RS_SAL_CAR_01` | Saldo Puntual de Cartera | `mod_rep.com.RSSALCAR01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_SAL_CAR_02` | Cartera por Producto | `mod_rep.com.RSSALCAR02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_SAL_CAR_03` | Productividad | `mod_rep.com.RSSALCAR03` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_SAL_CAR_04` | Saldo Puntual de Cartera Vigente | `mod_rep.com.RSSALCARVIGE01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera<br>shared / ui |
| `RS_SAL_CAR_05` | Cartera por Producto Vigente | `mod_rep.com.RSSALCARVIGE02` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera |
| `RS_SEG_PAS_01` | Seguros Pasivos Oncologico | `mod_rep.com.RSSEGPAS01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `RS_SEG_PAS_02` | Seguros Pasivos Multiple Ahorro | `mod_rep.com.RSSEGPAS02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `RS_SEG_PAS_03` | Seguros Pasivos Resumen | `mod_rep.com.RSSEGPAS03` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `RS_SEG_PAS_04` | Seguros Pasivos Protección Total | `mod_rep.com.RSSEGPAS04` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Seguros |
| `RS_TAB_COM_01` | TABLERO DIGITAL COMERCIAL | `mod_rep.com.RSTABCOMER` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes<br>reportes / actividad-diaria / Tablero Digital<br>reportes / actividad-mensual |
| `RS_TAB_COM_02` | TABLERO DIGITAL COMERCIAL DETALLE | `mod_rep.com.RSTABCOMER02` | `usuariobt`, `fecha` | ⏳ pendiente | — |
| `RS_TOP_ZCUO_01` | top 10 asesores Zcuo | `mod_rep.com.RTOPZCUO01` | `tip_cod`, `cod_rel`, `fecha` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RSIMR_01` | IMR | `mod_rep.com.RSIMR01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `RSRTOP01` | Monitor de Efectividades TOP | `mod_rep.com.RSRTOP001` | `tip_cod`, `level` | ⏳ pendiente | — |
| `RSRTOPV01` | Monitor de Efectividades TOP | `mod_rep.com.RSRTOPV001` | `tip_cod`, `tip_cod2`, `level`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Cartera en Mora |
| `RVIUWGCOR_01` | Reporte Vista General Corresponsal | `mod_rep.com.GRVGENCORO01` | `tip_cod`, `cod_rel`, `fec`, `tip_age` | ⏳ pendiente | reportes / actividad-diaria / Tablero Digital |
| `RVIUWGCORE_02` | Reporte Vista Gestión Corresponsal | `mod_rep.com.GRVGENCORO02` | `tip_cod`, `cod_rel`, `fec`, `tip_age` | ⏳ pendiente | reportes / actividad-diaria / Tablero Digital |
| `Sec_ciiu_01` | Seguimiento de Sectores | `mod_rep.com.RSEGSECTOR001` | `tip_cod`, `cod_rel`, `fec`, `grup` | ⏳ pendiente | — |
| `SEG_AGRO_01` | SEGURO AGRO | `mod_rep.com.GRESREPSEG04` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `SEG_PDM_01` | Seguimiento PDM | `mod_rep.com.RSSEGPDM01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Reportes PDM |
| `SEGUI_COMITE_01` | SEGUIMIENTO COMITE | `mod_rep.com.GCOMCRE01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `SEGUI_INC_SEC_01` | Seguimiento Incentivos Asesores | `mod_rep.com.GSEGUIINC001` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `SEGUROS_ASESOR_01` | Tablero Seguros Asesor | `mod_rep.com.RSEGASE01` | `cod_rel`, `Fecha`, `tip_cod` | ⏳ pendiente | — |
| `SEL_CIU_01` | Filtro CIIU | `mod_rep.com.GSELCIUT001` | — | ⏳ pendiente | — |
| `SEL_CIU_02` | Filtro CIIU Sector Eco | `mod_rep.com.GSELCIUT002` | — | ⏳ pendiente | — |
| `SEL_EFEC_01` | Filtro Detalle Efectividad | [mod_rep.com.GSELREP001](procedimientos/mod_rep/com/GSELREP001.md) | — | 🔎 extraído | reportes / actividad-diaria / Cartera en Mora<br>reportes / actividad-diaria / Portafolio Reasignado<br>reportes / actividad-mensual |
| `SEL_JEFE_01` | Filtro de Jefes | `mod_rep.com.GSELREP002` | `codmod` | ⏳ pendiente | — |
| `SEL_JER_01` | Filtro Territorio,Corred,agencia | `mod_rep.com.GSELJERAR001` | — | ⏳ pendiente | — |
| `SEL_JER_MENTORING_01` | FILTRO ASESORES | `mod_rep.com.GSELJERAR002` | `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-diaria / Campañas |
| `TAB_CUE_RES_01` | Cuenta de Resultados | `mod_rep.rep.RTABCUERES01` | `fecha`, `tip_cod`, `cod_rel` | ⏳ pendiente | reportes / actividad-mensual<br>reportes / actividad-mensual / Rentabilidad |
| `Tab_Dig_Com_A_01` | Tablero Digital Comercial Asesor | `mod_rep.com.RSTABCOMER02` | `usuariobt`, `Fecha` | ⏳ pendiente | — |
| `TABDIG_01` | APP CLIENTES | `mod_rep.com.GRTABAPPO01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Tablero Digital |
| `TABDIG_02` | Tablero digital Corresponsal | `mod_rep.com.GRTABCORRO01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Tablero Digital |
| `TABDIG_VR2_01` | TABLERO DIGITAL | `mod_rep.com.GRTABDIGO01` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | reportes / actividad-diaria / Tablero Digital |
| `TABDIG_VR2_COM_02` | TABLERO DIGITAL - COMERCIAL | `mod_rep.com.GRTABDIGO02` | `tip_cod`, `cod_rel`, `fec` | ⏳ pendiente | — |
| `TABDIGITAL_COMERCIAL_01` | TABLERO DIGITAL COMERCIAL | `mod_rep.com.RTABDIGCOM01` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `TB_PANEL_OPE_01` | PANEL OPERACIONES PASIVO | `mod_rep.com.RSROPERA001` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `TB_PANEL_OPE_02` | PANEL OPERACIONES PASIVO REGULA | `mod_rep.com.RSROPERA002` | `tip_cod`, `cod_rel`, `fec`, `prod` | ⏳ pendiente | reportes / actividad-diaria / Captaciones |
| `VAC_RES_EJE_01` | Resumen ejecutivo | `mod_gpa.vac.GRESEJE01` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
| `VAC_RES_EJE_02` | Resumen Ejecutivo por Meses | `mod_gpa.vac.GRESEJE02` | `tip_cod`, `cod_rel` | ⏳ pendiente | — |
<!-- generado:fin -->
