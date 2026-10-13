# Lo que falta

<!-- generado:inicio errores -->
<!-- Generado por governance/scripts/generar-errores.mjs. No editar dentro de este bloque: se regenera. -->

Lo que falta para que el diccionario esté completo, en orden de prioridad.

| Pendiente | Cantidad | Cómo se resuelve |
|---|---:|---|
| SP sin extraer | 2 | `python extraccion/herramientas/bd.py extraer` |
| SP extraídos sin validar con el motor | 4 | `python extraccion/herramientas/bd.py dependencias` |
| Tablas sin estructura consultada (otra base) | 1 | `python extraccion/herramientas/bd.py estructura` (necesita acceso a esa base) |
| SP sin propósito documentado | 268 de 269 | ficha del SP, sección *Propósito* (skill `dic-fichas`) |
| Tablas sin descripción | 202 de 202 | ficha de la tabla, sección *Descripción* |
| Columnas sin descripción | 2041 de 2041 | ficha de la tabla, sección *Columnas* |

## SP sin extraer (2)

- `mod_gpa.vac.GRESEJE01` — `VAC_RES_EJE_01`
- `mod_gpa.vac.GRESEJE02` — `VAC_RES_EJE_02`

## SP extraídos sin validar con el motor (4)

- [mod_rep.com.GDASHCLI01](../diccionario/procedimientos/mod_rep/com/GDASHCLI01.md)
- [mod_rep.com.REXPAGRO01](../diccionario/procedimientos/mod_rep/com/REXPAGRO01.md)
- [mod_rep.com.RSBASENEG01](../diccionario/procedimientos/mod_rep/com/RSBASENEG01.md)
- [mod_rep.dbo.REPORTE_DEMO](../diccionario/procedimientos/mod_rep/dbo/REPORTE_DEMO.md)

## Tablas sin estructura consultada (1)

- [FCMIS_REP.dbo.ControlCargaData](../diccionario/tablas/FCMIS_REP/dbo/ControlCargaData.md)

## SP con pantalla en el front y sin propósito documentado (empezar por acá) (162)

- [mod_rep.com.DINCEPDM01](../diccionario/procedimientos/mod_rep/com/DINCEPDM01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.GCMCNUE001](../diccionario/procedimientos/mod_rep/com/GCMCNUE001.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GCMCNUE002](../diccionario/procedimientos/mod_rep/com/GCMCNUE002.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GCMGCAP01](../diccionario/procedimientos/mod_rep/com/GCMGCAP01.md) — reportes / actividad-diaria / Captaciones; reportes / actividad-mensual
- [mod_rep.com.GCMGMORA001](../diccionario/procedimientos/mod_rep/com/GCMGMORA001.md) — reportes / actividad-diaria / Cartera en Mora; reportes / actividad-mensual
- [mod_rep.com.GCMGMORA001_SIMP](../diccionario/procedimientos/mod_rep/com/GCMGMORA001_SIMP.md) — reportes / actividad-diaria / Cartera en Mora; reportes / actividad-mensual
- [mod_rep.com.GCOMCRE02](../diccionario/procedimientos/mod_rep/com/GCOMCRE02.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.GCOSEMAF002](../diccionario/procedimientos/mod_rep/com/GCOSEMAF002.md) — reportes / actividad-mensual
- [mod_rep.com.GDACDESEM01](../diccionario/procedimientos/mod_rep/com/GDACDESEM01.md) — reportes / actividad-diaria / Comercial Ejecutivo
- [mod_rep.com.GDASHKAY03](../diccionario/procedimientos/mod_rep/com/GDASHKAY03.md) — reportes / actividad-mensual
- [mod_rep.com.GDASHKAY05](../diccionario/procedimientos/mod_rep/com/GDASHKAY05.md) — reportes / actividad-mensual
- [mod_rep.com.GDASHKAY06](../diccionario/procedimientos/mod_rep/com/GDASHKAY06.md) — reportes / actividad-mensual
- [mod_rep.com.GDCEROCN003](../diccionario/procedimientos/mod_rep/com/GDCEROCN003.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GDCEROCN004](../diccionario/procedimientos/mod_rep/com/GDCEROCN004.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GDCGEST_ACTIVAST02](../diccionario/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.GDCGEST_PASIVAST01](../diccionario/procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.GDCLIOPE01](../diccionario/procedimientos/mod_rep/com/GDCLIOPE01.md) — reportes / actividad-diaria / Clientes
- [mod_rep.com.GDMREP001](../diccionario/procedimientos/mod_rep/com/GDMREP001.md) — reportes / avance-comercial
- [mod_rep.com.GMOVCLI01](../diccionario/procedimientos/mod_rep/com/GMOVCLI01.md) — reportes / actividad-diaria / Clientes
- [mod_rep.com.GPDM001](../diccionario/procedimientos/mod_rep/com/GPDM001.md) — reportes / actividad-diaria / Comercial Ejecutivo
- [mod_rep.com.GRCEROCUOTAO01](../diccionario/procedimientos/mod_rep/com/GRCEROCUOTAO01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GRCEROCUOTAO02](../diccionario/procedimientos/mod_rep/com/GRCEROCUOTAO02.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GRESDESCRE02](../diccionario/procedimientos/mod_rep/com/GRESDESCRE02.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.GRESPDATOS01](../diccionario/procedimientos/mod_rep/com/GRESPDATOS01.md) — reportes / actividad-mensual
- [mod_rep.com.GRESPROGOB01](../diccionario/procedimientos/mod_rep/com/GRESPROGOB01.md) — reportes / actividad-mensual
- [mod_rep.com.GRESPROGOB02](../diccionario/procedimientos/mod_rep/com/GRESPROGOB02.md) — reportes / actividad-mensual
- [mod_rep.com.GRESREAGRO01](../diccionario/procedimientos/mod_rep/com/GRESREAGRO01.md) — reportes / actividad-diaria / Comercial Ejecutivo
- [mod_rep.com.GRESREPSEG_01](../diccionario/procedimientos/mod_rep/com/GRESREPSEG_01.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.GRESREPSEG01](../diccionario/procedimientos/mod_rep/com/GRESREPSEG01.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.GRESREPSEG02](../diccionario/procedimientos/mod_rep/com/GRESREPSEG02.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.GRESREPSEG05](../diccionario/procedimientos/mod_rep/com/GRESREPSEG05.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.GRESREPSEG06](../diccionario/procedimientos/mod_rep/com/GRESREPSEG06.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.GRMENTOR001](../diccionario/procedimientos/mod_rep/com/GRMENTOR001.md) — reportes / actividad-diaria / Campañas
- [mod_rep.com.GRTABAPPO01](../diccionario/procedimientos/mod_rep/com/GRTABAPPO01.md) — reportes / actividad-diaria / Tablero Digital
- [mod_rep.com.GRTABCORRO01](../diccionario/procedimientos/mod_rep/com/GRTABCORRO01.md) — reportes / actividad-diaria / Tablero Digital
- [mod_rep.com.GRTABDIGO01](../diccionario/procedimientos/mod_rep/com/GRTABDIGO01.md) — reportes / actividad-diaria / Tablero Digital
- [mod_rep.com.GRVGENCORO01](../diccionario/procedimientos/mod_rep/com/GRVGENCORO01.md) — reportes / actividad-diaria / Tablero Digital
- [mod_rep.com.GRVGENCORO02](../diccionario/procedimientos/mod_rep/com/GRVGENCORO02.md) — reportes / actividad-diaria / Tablero Digital
- [mod_rep.com.GSEGCAPBP01](../diccionario/procedimientos/mod_rep/com/GSEGCAPBP01.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.GSEGCAPBP02](../diccionario/procedimientos/mod_rep/com/GSEGCAPBP02.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.GSELJERAR002](../diccionario/procedimientos/mod_rep/com/GSELJERAR002.md) — reportes / actividad-diaria / Campañas
- [mod_rep.com.GTOPCERCUO001](../diccionario/procedimientos/mod_rep/com/GTOPCERCUO001.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GTOPCERCUO002](../diccionario/procedimientos/mod_rep/com/GTOPCERCUO002.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GTOPCERCUO003](../diccionario/procedimientos/mod_rep/com/GTOPCERCUO003.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GTOPCERCUO004](../diccionario/procedimientos/mod_rep/com/GTOPCERCUO004.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.GTOPCERCUO005](../diccionario/procedimientos/mod_rep/com/GTOPCERCUO005.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RACTGP01](../diccionario/procedimientos/mod_rep/com/RACTGP01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RAGROMIX](../diccionario/procedimientos/mod_rep/com/RAGROMIX.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.RCARDZCUO01](../diccionario/procedimientos/mod_rep/com/RCARDZCUO01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RESDMOV01](../diccionario/procedimientos/mod_rep/com/RESDMOV01.md) — reportes / actividad-diaria
- [mod_rep.com.RESDMOV02](../diccionario/procedimientos/mod_rep/com/RESDMOV02.md) — reportes / actividad-diaria
- [mod_rep.com.REXPAGRO01](../diccionario/procedimientos/mod_rep/com/REXPAGRO01.md) — consulta-fen
- [mod_rep.com.RFECREPMEN](../diccionario/procedimientos/mod_rep/com/RFECREPMEN.md) — reportes; reportes / actividad-diaria / Cartera; reportes / actividad-diaria / Cartera en Mora; reportes / actividad-diaria / Seguros; reportes / actividad-mensual; reportes / actividad-mensual / Cartera; reportes / actividad-mensual / Tablero Digital
- [mod_rep.com.RFECREPMEN02](../diccionario/procedimientos/mod_rep/com/RFECREPMEN02.md) — reportes; reportes / actividad-diaria / Cartera; reportes / actividad-diaria / Seguros
- [mod_rep.com.RGRAFGESTCOM01](../diccionario/procedimientos/mod_rep/com/RGRAFGESTCOM01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RGRAFGESTCOM02](../diccionario/procedimientos/mod_rep/com/RGRAFGESTCOM02.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RGRAFGESTCOM03](../diccionario/procedimientos/mod_rep/com/RGRAFGESTCOM03.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RGRAFGESTCOM04](../diccionario/procedimientos/mod_rep/com/RGRAFGESTCOM04.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RGRAFGESTCOM05](../diccionario/procedimientos/mod_rep/com/RGRAFGESTCOM05.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RGRAFGESTCOM06](../diccionario/procedimientos/mod_rep/com/RGRAFGESTCOM06.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RGRAFGESTCOM07](../diccionario/procedimientos/mod_rep/com/RGRAFGESTCOM07.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RGRAFZCUO01](../diccionario/procedimientos/mod_rep/com/RGRAFZCUO01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RGRAFZCUO02](../diccionario/procedimientos/mod_rep/com/RGRAFZCUO02.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RGRAFZCUO03](../diccionario/procedimientos/mod_rep/com/RGRAFZCUO03.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RGRAFZCUO04](../diccionario/procedimientos/mod_rep/com/RGRAFZCUO04.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RINCEGP01](../diccionario/procedimientos/mod_rep/com/RINCEGP01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RMESA01](../diccionario/procedimientos/mod_rep/com/RMESA01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RMONINTCOM01](../diccionario/procedimientos/mod_rep/com/RMONINTCOM01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RMORAGP01](../diccionario/procedimientos/mod_rep/com/RMORAGP01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RREPGESTCOM02](../diccionario/procedimientos/mod_rep/com/RREPGESTCOM02.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RREPGESTCOM03](../diccionario/procedimientos/mod_rep/com/RREPGESTCOM03.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RS_AGE_COM_CR_01](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_01.md) — reportes / actividad-diaria / Portafolio Reasignado
- [mod_rep.com.RS_AGE_COM_CR_02](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_02.md) — reportes / actividad-diaria / Portafolio Reasignado; reportes / actividad-mensual
- [mod_rep.com.RS_AGE_COM_CR_M_01](../diccionario/procedimientos/mod_rep/com/RS_AGE_COM_CR_M_01.md) — reportes / actividad-mensual
- [mod_rep.com.RS_AGROMIX_CHART](../diccionario/procedimientos/mod_rep/com/RS_AGROMIX_CHART.md) — reportes
- [mod_rep.com.RS_AGROMIX_CHART2](../diccionario/procedimientos/mod_rep/com/RS_AGROMIX_CHART2.md) — reportes
- [mod_rep.com.RS_AGROMIX_CHART3](../diccionario/procedimientos/mod_rep/com/RS_AGROMIX_CHART3.md) — reportes
- [mod_rep.com.RS_AGROMIX_CHART4](../diccionario/procedimientos/mod_rep/com/RS_AGROMIX_CHART4.md) — reportes
- [mod_rep.com.RSAGECOM01](../diccionario/procedimientos/mod_rep/com/RSAGECOM01.md) — reportes / actividad-diaria / Campañas
- [mod_rep.com.RSAGECOM02](../diccionario/procedimientos/mod_rep/com/RSAGECOM02.md) — reportes / actividad-diaria / Campañas
- [mod_rep.com.RSAGECOM03](../diccionario/procedimientos/mod_rep/com/RSAGECOM03.md) — reportes / actividad-diaria / Campañas
- [mod_rep.com.RSAPPUSO001](../diccionario/procedimientos/mod_rep/com/RSAPPUSO001.md) — reportes / actividad-diaria / Aplicativo Movil
- [mod_rep.com.RSAVAPOR01](../diccionario/procedimientos/mod_rep/com/RSAVAPOR01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RSBASENEG01](../diccionario/procedimientos/mod_rep/com/RSBASENEG01.md) — core / winder; herramientas
- [mod_rep.com.RSCALCAR01](../diccionario/procedimientos/mod_rep/com/RSCALCAR01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RSCALCAR02](../diccionario/procedimientos/mod_rep/com/RSCALCAR02.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RSCAPCOME01](../diccionario/procedimientos/mod_rep/com/RSCAPCOME01.md) — reportes; reportes / actividad-diaria / Captaciones
- [mod_rep.com.RSCMGCF001](../diccionario/procedimientos/mod_rep/com/RSCMGCF001.md) — reportes / actividad-diaria / Clientes; reportes / actividad-mensual
- [mod_rep.com.RSCMGCLIPAS01](../diccionario/procedimientos/mod_rep/com/RSCMGCLIPAS01.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.RSCMGFCA002](../diccionario/procedimientos/mod_rep/com/RSCMGFCA002.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.RSCOMPAS01](../diccionario/procedimientos/mod_rep/com/RSCOMPAS01.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.RSDATPRO01](../diccionario/procedimientos/mod_rep/com/RSDATPRO01.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.RSDATPRO02](../diccionario/procedimientos/mod_rep/com/RSDATPRO02.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.RSDATPRO03](../diccionario/procedimientos/mod_rep/com/RSDATPRO03.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.RSDATPRO04](../diccionario/procedimientos/mod_rep/com/RSDATPRO04.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.RSDEPGSOLID01](../diccionario/procedimientos/mod_rep/com/RSDEPGSOLID01.md) — reportes / actividad-diaria / Reportes PDM
- [mod_rep.com.RSDESEMB](../diccionario/procedimientos/mod_rep/com/RSDESEMB.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual; reportes / actividad-mensual / Cartera; shared / ui
- [mod_rep.com.RSDESEMB02](../diccionario/procedimientos/mod_rep/com/RSDESEMB02.md) — reportes / actividad-mensual; reportes / actividad-mensual / Cartera
- [mod_rep.com.RSDESEMP01](../diccionario/procedimientos/mod_rep/com/RSDESEMP01.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSGETCOM01](../diccionario/procedimientos/mod_rep/com/RSGETCOM01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSHHCARB001](../diccionario/procedimientos/mod_rep/com/RSHHCARB001.md) — reportes / actividad-mensual
- [mod_rep.com.RSLISTCCN01](../diccionario/procedimientos/mod_rep/com/RSLISTCCN01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RSMONEFE01](../diccionario/procedimientos/mod_rep/com/RSMONEFE01.md) — reportes / actividad-diaria / Cartera en Mora; reportes / actividad-mensual
- [mod_rep.com.RSMONEFE02](../diccionario/procedimientos/mod_rep/com/RSMONEFE02.md) — reportes / actividad-diaria / Cartera en Mora; reportes / actividad-mensual
- [mod_rep.com.RSMONEFE03](../diccionario/procedimientos/mod_rep/com/RSMONEFE03.md) — reportes / actividad-diaria / Cartera en Mora; reportes / actividad-mensual
- [mod_rep.com.RSMONEFER01](../diccionario/procedimientos/mod_rep/com/RSMONEFER01.md) — reportes / actividad-diaria / Portafolio Reasignado; reportes / actividad-mensual
- [mod_rep.com.RSMONEFER02](../diccionario/procedimientos/mod_rep/com/RSMONEFER02.md) — reportes / actividad-diaria / Portafolio Reasignado
- [mod_rep.com.RSMONEFEREPRO01](../diccionario/procedimientos/mod_rep/com/RSMONEFEREPRO01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RSMONEFETRC01](../diccionario/procedimientos/mod_rep/com/RSMONEFETRC01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RSPROYCOLDES001](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES001.md) — reportes / actividad-diaria / Proyecciones
- [mod_rep.com.RSPROYCOLDES003](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES003.md) — reportes / actividad-diaria / Proyecciones
- [mod_rep.com.RSPROYCOLDES004](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES004.md) — reportes / actividad-diaria / Proyecciones
- [mod_rep.com.RSPROYCOLDES009](../diccionario/procedimientos/mod_rep/com/RSPROYCOLDES009.md) — reportes / actividad-diaria / Proyecciones
- [mod_rep.com.RSRANKCOM01](../diccionario/procedimientos/mod_rep/com/RSRANKCOM01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSRDFCA007](../diccionario/procedimientos/mod_rep/com/RSRDFCA007.md) — reportes / actividad-diaria / Comercial Ejecutivo
- [mod_rep.com.RSRDFCA011](../diccionario/procedimientos/mod_rep/com/RSRDFCA011.md) — reportes / actividad-diaria / Clientes
- [mod_rep.com.RSRDFCA021](../diccionario/procedimientos/mod_rep/com/RSRDFCA021.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSRDFCA022](../diccionario/procedimientos/mod_rep/com/RSRDFCA022.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSRDFCA023](../diccionario/procedimientos/mod_rep/com/RSRDFCA023.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSRDFCA024](../diccionario/procedimientos/mod_rep/com/RSRDFCA024.md) — reportes / actividad-mensual
- [mod_rep.com.RSRDFCA025](../diccionario/procedimientos/mod_rep/com/RSRDFCA025.md) — reportes / actividad-mensual
- [mod_rep.com.RSRDFCA026](../diccionario/procedimientos/mod_rep/com/RSRDFCA026.md) — reportes / actividad-mensual
- [mod_rep.com.RSRDFCA027](../diccionario/procedimientos/mod_rep/com/RSRDFCA027.md) — core / winder; reportes / avance-comercial
- [mod_rep.com.RSRDFCA028](../diccionario/procedimientos/mod_rep/com/RSRDFCA028.md) — reportes / avance-comercial
- [mod_rep.com.RSRDFCA029](../diccionario/procedimientos/mod_rep/com/RSRDFCA029.md) — reportes / avance-comercial
- [mod_rep.com.RSRDFCA030](../diccionario/procedimientos/mod_rep/com/RSRDFCA030.md) — reportes / avance-comercial
- [mod_rep.com.RSRDFCA031](../diccionario/procedimientos/mod_rep/com/RSRDFCA031.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSRDFCA032](../diccionario/procedimientos/mod_rep/com/RSRDFCA032.md) — reportes / actividad-mensual
- [mod_rep.com.RSRDFCA035](../diccionario/procedimientos/mod_rep/com/RSRDFCA035.md) — reportes / actividad-diaria / Captaciones; reportes / actividad-mensual
- [mod_rep.com.RSRDFCA036](../diccionario/procedimientos/mod_rep/com/RSRDFCA036.md) — reportes / actividad-diaria / Captaciones; reportes / actividad-mensual; shared / ui
- [mod_rep.com.RSRDFCA037](../diccionario/procedimientos/mod_rep/com/RSRDFCA037.md) — reportes / actividad-diaria / Cartera; reportes / actividad-mensual
- [mod_rep.com.RSRDFCA050](../diccionario/procedimientos/mod_rep/com/RSRDFCA050.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSRDFCA050_3](../diccionario/procedimientos/mod_rep/com/RSRDFCA050_3.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSRDFCA050_4](../diccionario/procedimientos/mod_rep/com/RSRDFCA050_4.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSRDMA023](../diccionario/procedimientos/mod_rep/com/RSRDMA023.md) — reportes / actividad-diaria / Campañas
- [mod_rep.com.RSROPERA001](../diccionario/procedimientos/mod_rep/com/RSROPERA001.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.RSROPERA002](../diccionario/procedimientos/mod_rep/com/RSROPERA002.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.RSRPD001](../diccionario/procedimientos/mod_rep/com/RSRPD001.md) — reportes / control-cargas
- [mod_rep.com.RSRSRV001](../diccionario/procedimientos/mod_rep/com/RSRSRV001.md) — reportes / actividad-diaria / Captaciones
- [mod_rep.com.RSRTOPMIS001](../diccionario/procedimientos/mod_rep/com/RSRTOPMIS001.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSRTOPMIS002](../diccionario/procedimientos/mod_rep/com/RSRTOPMIS002.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSRTOPMIS003](../diccionario/procedimientos/mod_rep/com/RSRTOPMIS003.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSRTOPMIS004](../diccionario/procedimientos/mod_rep/com/RSRTOPMIS004.md) — reportes / desarrollo-sostenible
- [mod_rep.com.RSRTOPV001](../diccionario/procedimientos/mod_rep/com/RSRTOPV001.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.com.RSSALCAR01](../diccionario/procedimientos/mod_rep/com/RSSALCAR01.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSSALCAR02](../diccionario/procedimientos/mod_rep/com/RSSALCAR02.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSSALCAR03](../diccionario/procedimientos/mod_rep/com/RSSALCAR03.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSSALCARVIGE01](../diccionario/procedimientos/mod_rep/com/RSSALCARVIGE01.md) — reportes / actividad-diaria / Cartera; shared / ui
- [mod_rep.com.RSSALCARVIGE02](../diccionario/procedimientos/mod_rep/com/RSSALCARVIGE02.md) — reportes / actividad-diaria / Cartera
- [mod_rep.com.RSSEGPAS01](../diccionario/procedimientos/mod_rep/com/RSSEGPAS01.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.RSSEGPAS02](../diccionario/procedimientos/mod_rep/com/RSSEGPAS02.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.RSSEGPAS03](../diccionario/procedimientos/mod_rep/com/RSSEGPAS03.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.RSSEGPAS04](../diccionario/procedimientos/mod_rep/com/RSSEGPAS04.md) — reportes / actividad-diaria / Seguros
- [mod_rep.com.RSSEGPDM01](../diccionario/procedimientos/mod_rep/com/RSSEGPDM01.md) — reportes / actividad-diaria / Reportes PDM
- [mod_rep.com.RSTABCOMER](../diccionario/procedimientos/mod_rep/com/RSTABCOMER.md) — reportes; reportes / actividad-diaria / Tablero Digital; reportes / actividad-mensual
- [mod_rep.com.RTOPZCUO01](../diccionario/procedimientos/mod_rep/com/RTOPZCUO01.md) — reportes / actividad-diaria / Cartera en Mora
- [mod_rep.rep.RTABCUERES01](../diccionario/procedimientos/mod_rep/rep/RTABCUERES01.md) — reportes / actividad-mensual; reportes / actividad-mensual / Rentabilidad
- [strategos.mod_rep_com_act.CABGMRESULUNINEGB01](../diccionario/procedimientos/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.md) — reportes / actividad-mensual
- [strategos.mod_rep_com_act.GDDESEMDIA](../diccionario/procedimientos/strategos/mod_rep_com_act/GDDESEMDIA.md) — reportes / actividad-diaria / Cartera
- [strategos.mod_rep_com_act.GDPORTAGRO01](../diccionario/procedimientos/strategos/mod_rep_com_act/GDPORTAGRO01.md) — reportes / actividad-diaria / Cartera
- [strategos.mod_rep_com_act.GDPSUPERV01](../diccionario/procedimientos/strategos/mod_rep_com_act/GDPSUPERV01.md) — reportes / actividad-diaria / Cartera en Mora
- [strategos.mod_rep_com_act.GDPSUPERV02](../diccionario/procedimientos/strategos/mod_rep_com_act/GDPSUPERV02.md) — reportes / actividad-diaria / Cartera en Mora
<!-- generado:fin -->
