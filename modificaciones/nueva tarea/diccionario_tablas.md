# Diccionario de las tablas del tablero (HTABSEG001–004)

Tablas físicas que cargan los SP del tablero en `storage.com_act`. DDL propuesto, no ejecutado:
[03_tablas_destino.sql](03_tablas_destino.sql). Este diccionario se genera del DDL;
`verificar_sql.py` comprueba que columnas, tipos y nulabilidad coincidan. Definiciones
de negocio: [variables.md](variables.md); reglas: [consideraciones.md](consideraciones.md);
cómo se leen en el tablero: [diccionario_reporte.md](diccionario_reporte.md).

## 1. Resumen

| Tabla | Contenido | Columnas | Clave primaria (agrupada) | Niveles |
|---|---|---:|---|---|
| `HTABSEG001` | **Base**: cada entidad con población en t; stock actual (incluye heredados), medidas exclusivas, metas y población ajustada | 84 | HFECPRO, HTIPCOD, HCODREL | 1, 17, 18, 19, 20, 7 |
| `HTABSEG002` | **Trasladados**: medidas que salieron de la entidad (se restituyen al origen) | 35 | HFECPRO, HTIPCOD, HCODREL | 1, 17, 18, 19, 20 |
| `HTABSEG003` | **Heredados**: medidas recibidas de otra entidad (ya incluidas en base) | 35 | HFECPRO, HTIPCOD, HCODREL | 1, 17, 18, 19, 20 |
| `HTABSEG004` | **Detalle**: una fila por crédito lógico de la unión t−1/t | 74 | HFECPRO, HCODOPE, HTIPOPE | — |

**Carga** (dos pasos, idempotentes por corte):

1. `com_act.PSLHTABSEG001` (cartera): `DELETE` + `INSERT` del corte en las cuatro tablas, en una transacción. Deja el bloque de seguros en NULL.
2. `com_act.PSLHTABSEG002` (seguros, cuando llega HCDS001): solo `UPDATE` de las columnas marcadas **S**. No inserta ni borra filas. Reprocesar la cartera vuelve a dejar seguros en NULL.

**Diseño físico:** partición mensual por HFECPRO (`ps_data_master_date`), compresión PAGE y `LOCK_ESCALATION = AUTO` (la carga bloquea solo la partición del mes).

## 2. Cómo leer las tablas

- **Niveles (`HTIPCOD`):** 1 asesor, 17 coordinación, 18 unidad, 19 corredor, 20 territorio, 7 financiera (`HCODREL = '231'`). Trasladados y heredados no tienen nivel 7.
- **Códigos especiales (`HCODREL`):** `''` asesor vacío (créditos sin asesor); `'-999'` agrupa a quienes no tienen jerarquía en ese nivel (SIN ASIGNAR) y suma en la financiera.
- **Base incluye heredados.** Los trasladados ya no están en la base del origen. No son segmentos disjuntos.
- **Población ajustada (neto):** para importes, base + trasladado − heredado. Los **conteos** (operaciones, clientes, asesores) no son aditivos: un mismo HCODOPE o cliente puede estar en dos grupos. Por eso la base guarda conteos y tasas `…NET` ya calculados sobre la población ajustada; no se suman ni restan conteos de las tres tablas.
- **Conteos de operaciones:** COUNT(DISTINCT HCODOPE) después de evaluar las reglas por clave lógica (HCODOPE + HTIPOPE). Los importes de todos los tipos se suman.
- **Tasas y ratios:** fracciones (0,2332 = 23,32 %). Las tasas guardadas son finales; no se suman entre grupos ni entidades.
- **NULL:** en medidas de cartera, sin población para promediar (tasas) o meta inexistente. En el bloque **S**, seguros aún no cargado; el reporte lo muestra como pendiente, no como cero.
- **Comparaciones:** las variaciones contra el cierre anterior se hacen leyendo la fila ya registrada en t−1 (otra HFECPRO), no hay columnas comparativas.
- **Carga:** **C** = la escribe la carga de cartera; **S** = la escribe la carga de seguros.

## 3. HTABSEG001 — base

| # | Columna | Tipo | Nulo | Bloque | Carga | En 002/003 | Descripción | Variable |
|---:|---|---|:-:|---|:-:|:-:|---|---|
| 1 | `HFECPRO` | date | No | Clave | C | Sí | Corte efectivo t: último día hábil (RCALEN001.RDIAFER = 0) menor o igual a la fecha de referencia. Única fecha que se guarda; no hay fecha de ejecución. |  |
| 2 | `HTIPCOD` | smallint | No | Clave | C | Sí | Nivel de la entidad: 1 asesor, 17 coordinación, 18 unidad, 19 corredor, 20 territorio, 7 financiera. |  |
| 3 | `HCODREL` | varchar(30) | No | Clave | C | Sí | Código de la entidad dentro del nivel. Asesor vacío (NULL, '' y '--' normalizados) = ''; jerarquía faltante = '-999' (SIN ASIGNAR); financiera = '231'. El territorio es el código compuesto de FJERCOR02 (grupo_territorio). |  |
| 4 | `HOPEDES` | bigint | No | Desembolsos | C | Sí | Operaciones desembolsadas en el mes hasta t: COUNT(DISTINCT HCODOPE) tras evaluar la elegibilidad por clave lógica (HCODOPE + HTIPOPE). Excluye reprogramados; fecha corregida con RFOC001. | DES01 |
| 5 | `HOPEDESSEG` | bigint | Sí | Desembolsos / seguros | S | Sí | De HOPEDES, operaciones con al menos una póliza optativa (sin desgravamen) vigente/activa en la foto HCDS001 del corte. Penetración de optativos = HOPEDESSEG / HOPEDES. NULL hasta la carga de seguros. | SEG13 |
| 6 | `HASEDES` | bigint | No | Desembolsos | C | Sí | Asesores distintos con desembolsos del mes vigentes en t. Base y heredados: asesor en t (en la base del asesor vale 1); trasladados: asesor al desembolsar. El asesor vacío cuenta uno; sin filtro de meta. Denominador de la productividad en niveles superiores. | DES03 |
| 7 | `HSALDES` | decimal(28,6) | Sí | Desembolsos | C | Sí | Monto desembolsado en PEN; no soles con RTCM001.RVALCA del último RFECCIE ≤ t. | DES06 |
| 8 | `HTASDES` | decimal(19,10) | Sí | Desembolsos | C | Sí | TAPP del mes: SUM(monto × tasa) / SUM(monto), como fracción; 0 sin desembolsos. | DES13 |
| 9 | `HTASMIN` | decimal(19,10) | Sí | Desembolsos | C | Sí | TAPP mínima: SUM(monto × tasa mínima HGAT001) / SUM(monto); sin mínima o (101,40)/(104,40), la tasa del crédito. | DES14 |
| 10 | `HSALRECPRO` | decimal(28,6) | No | Recuperación (solo base) | C | — | Saldo para recuperación programada: SUM(capital t−1 / cuotas pendientes t−1) de los créditos vigentes al día con cuota en el mes. Entidad de t−1. | REC01 |
| 11 | `HSALRECEFE` | decimal(28,6) | No | Recuperación (solo base) | C | — | Saldo de recuperación efectiva: mismo importe programado de los créditos que bajaron cuotas y capital o se cancelaron (sin castigo ni venta). | REC02 |
| 12 | `HOPERECPRO` | bigint | No | Recuperación (solo base) | C | — | Operaciones distintas de la recuperación programada. | REC04 |
| 13 | `HOPERECEFE` | bigint | No | Recuperación (solo base) | C | — | Operaciones distintas con recuperación efectiva. | REC05 |
| 14 | `HEFETRAUNO` | decimal(19,10) | Sí | Efectividad (solo base) | C | — | Efectividad −30 a 0 días (núcleo SDAE002): (recuperado + mantenido) / saldo inicial, fracción. Entidad de t−1. | REC07 |
| 15 | `HEFETRADOS` | decimal(19,10) | Sí | Efectividad (solo base) | C | — | Efectividad 1 a 30 días (núcleo SDAE003). | REC09 |
| 16 | `HEFETRATRE` | decimal(19,10) | Sí | Efectividad (solo base) | C | — | Efectividad 31 a 60 días (núcleo SDAE004); adicional, no visible. | REC11 |
| 17 | `HCLIMOR` | bigint | No | Mora | C | Sí | Clientes distintos con al menos un crédito en mora en t (atraso > 0 o JUDICIAL). | REC13 |
| 18 | `HSALMOR` | decimal(28,6) | No | Mora | C | Sí | Capital (HSALCAPMN) de los créditos en mora en t. | REC15 |
| 19 | `HOPEINGMOR` | bigint | No | Mora | C | Sí | Ingresos a mora: operaciones del stock de t con atraso ≤ 0 en t−1 y > 0 en t; asesor de t. | REC17 |
| 20 | `HSALINGMOR` | decimal(28,6) | No | Mora | C | Sí | Capital en t de los créditos que ingresaron a mora. | REC18 |
| 21 | `HSALCIE` | decimal(28,6) | No | Cartera | C | Sí | Saldo capital total en t (SUM HSALCAPMN). En base es el stock actual, incluidos heredados. | CAR01 |
| 22 | `HSALCIEVIG` | decimal(28,6) | No | Cartera | C | Sí | Saldo capital vigente en t: capital − vencido solo de los rubros VIGENTE (sin refinanciados). | CAR02 |
| 23 | `HOPECAR` | bigint | No | Cartera | C | Sí | Operaciones distintas del stock de t. | CAR07 |
| 24 | `HTASSTKTOT` | decimal(19,10) | Sí | Cartera | C | Sí | TAPP stock total: SUM(capital × tasa) / SUM(capital), fracción. | CAR16 |
| 25 | `HTASSTKVIG` | decimal(19,10) | Sí | Cartera | C | Sí | TAPP stock vigente, ponderada por el capital vigente de cada rubro. | CAR22 |
| 26 | `HSALMEDTOT` | decimal(28,6) | No | Cartera (solo base) | C | — | Saldo medio total del mes: saldos diarios por asesor operativo y jerarquía de cada día / días calendario hasta t; feriados con el último hábil. | CAR12 |
| 27 | `HSALMEDVIG` | decimal(28,6) | No | Cartera (solo base) | C | — | Saldo medio vigente, mismo cálculo con el capital vigente por rubro. | CAR13 |
| 28 | `HCLICAR` | bigint | No | Clientes | C | Sí | Clientes distintos (país + tipo + documento) con cartera en t. | CLI01 |
| 29 | `HCLINUE` | bigint | No | Clientes | C | Sí | Clientes nuevos reales del mes (HBCN001 frente a HBCA001, cruzados con desembolsos). | CLI12 |
| 30 | `HCLIBAN` | bigint | No | Clientes | C | Sí | Clientes bancarizados con la lógica y el desfase t−2 de HRESINC003. | CLI14 |
| 31 | `HCLIING` | bigint | No | Clientes (solo base) | C | — | Ingresos del mes: clientes que no pertenecían a la entidad en t−1 y pertenecen en t. | CLI03 |
| 32 | `HCLISAL` | bigint | No | Clientes (solo base) | C | — | Salidas del mes: clientes que pertenecían en t−1 y ya no en t. | CLI04 |
| 33 | `HCLIRETINI` | bigint | No | Clientes (solo base) | C | — | Base inicial de retención: clientes de t−1 en su entidad de destino ajustada por traslados, sin desembolsos del mes. | CLI18 |
| 34 | `HCLIRETFIN` | bigint | No | Clientes (solo base) | C | — | Clientes de esa base que siguen en la entidad en t (también por créditos del mes). | CLI19 |
| 35 | `HINDSININI` | bit | No | Clientes (solo base) | C | — | 1 = sin cartera de inicio (cero clientes en t−1). No significa asesor nuevo. Activa las reglas del 100 % de recuperación y retención. |  |
| 36 | `HCLIENR` | bigint | No | Digital | C | Sí | Clientes de t enrolados: primer registro en HISLOGAPP001 ≤ t. | DIG01 |
| 37 | `HCLIENRNUE` | bigint | No | Digital | C | Sí | Enrolados cuya primera fecha de enrolamiento está en el mes de t. | DIG12 |
| 38 | `HCLITRX` | bigint | No | Digital | C | Sí | Transaccionales: enrolados con al menos una transacción en HTDA001 del snapshot de t, en el mes. | DIG05 |
| 39 | `HCLITRXMON` | bigint | No | Digital | C | Sí | Transaccionales con al menos una transacción monetaria (HTIPTRAX = 'S'). | DIG14 |
| 40 | `HCLIPAGDIG` | bigint | No | Digital | C | Sí | Monetarios con pago de crédito digital ('S' y HCODPROC = 5). | DIG16 |
| 41 | `HNUMTRXMON` | bigint | No | Digital | C | Sí | Número de transacciones monetarias del mes (SUM HTOTINTE de 'S'), una vez por cliente y entidad; no aditivo entre grupos. | DIG18 |
| 42 | `HOPECAS` | bigint | No | Salidas | C | Sí | Operaciones castigadas en el mes (HCCA001), al titular a la salida. | SAL01 |
| 43 | `HSALCAS` | decimal(28,6) | No | Salidas | C | Sí | Monto castigado: HSALCAS de HCCA001 convertido con RTCM001; una vez por HCODOPE. | SAL02 |
| 44 | `HOPEVTA` | bigint | No | Salidas | C | Sí | Operaciones vendidas en el mes (HRVC001). | SAL03 |
| 45 | `HSALVTA` | decimal(28,6) | No | Salidas | C | Sí | Monto vendido: HSALCAPMN de HRVC001. | SAL04 |
| 46 | `HOPECANPRE` | bigint | No | Salidas | C | Sí | Cancelaciones anticipadas: año-mes de t anterior al del vencimiento de t−1. | SAL05 |
| 47 | `HSALCANPRE` | decimal(28,6) | No | Salidas | C | Sí | Capital del último snapshot de las cancelaciones anticipadas. | SAL06 |
| 48 | `HOPECANCON` | bigint | No | Salidas | C | Sí | Cancelaciones contractuales: año-mes de t igual o posterior al del vencimiento de t−1. | SAL07 |
| 49 | `HSALCANCON` | decimal(28,6) | No | Salidas | C | Sí | Capital del último snapshot de las cancelaciones contractuales. | SAL08 |
| 50 | `HNUMPLZ` | bigint | Sí | Seguros (solo base) | S | — | Pólizas optativas vendidas en el mes (foto HCDS001 del corte con la lógica de SDSF001), al asesor vendedor (HUSCOL) y su jerarquía. Suma de los seis productos. NULL = seguros pendiente. | SEG04 |
| 51 | `HPLZMUL` | bigint | Sí | Seguros (solo base) | S | — | Multirriesgo (200, 220, 230). | SEG07 |
| 52 | `HPLZPCU` | bigint | Sí | Seguros (solo base) | S | — | Protección de cuota (802, 824). | SEG08 |
| 53 | `HPLZVID` | bigint | Sí | Seguros (solo base) | S | — | Vida Segura (803, 817). | SEG09 |
| 54 | `HPLZONC` | bigint | Sí | Seguros (solo base) | S | — | Oncológico (814, 828). | SEG10 |
| 55 | `HPLZAGR` | bigint | Sí | Seguros (solo base) | S | — | Agropecuario (806, 815, 825). | SEG11 |
| 56 | `HPLZPTO` | bigint | Sí | Seguros (solo base) | S | — | Protección total (822). | SEG12 |
| 57 | `HASESINVTA` | bigint | Sí | Seguros (solo base) | S | — | Asesores con cartera en t (sin el asesor vacío) sin pólizas optativas en el mes; en el asesor, 0/1. | SEG14 |
| 58 | `HMETPRO` | decimal(28,6) | Sí | Metas (solo base) | C | — | Meta de productividad, VDMCOM01 HCODVAR = 8070 (asesor: operaciones; arriba: operaciones por asesor). NULL = sin meta. | DES04 |
| 59 | `HMETVARVIG` | decimal(28,6) | Sí | Metas (solo base) | C | — | Meta de variación de saldo vigente (9000). Meta de stock = HSALCIEVIG de t−1 + esta meta (en el reporte). | CAR10 |
| 60 | `HMETVARCLI` | decimal(28,6) | Sí | Metas (solo base) | C | — | Meta de variación de clientes (10062). Meta de stock = HCLICAR de t−1 + esta meta. | CLI08 |
| 61 | `HMETEFEUNO` | decimal(19,10) | Sí | Metas (solo base) | C | — | Meta de efectividad −30 a 0 (126), en la escala de la fuente. | REC08 |
| 62 | `HMETEFEDOS` | decimal(19,10) | Sí | Metas (solo base) | C | — | Meta de efectividad 1 a 30 (122). | REC10 |
| 63 | `HMETEFETRE` | decimal(19,10) | Sí | Metas (solo base) | C | — | Meta de efectividad 31 a 60 (124). | REC12 |
| 64 | `HMETTRXENR` | decimal(19,10) | Sí | Metas (solo base) | C | — | Meta de usabilidad sobre enrolados, fija 0,205 (RSTABCOMER); VDMCOM01 10251 pendiente (P09). | DIG07 |
| 65 | `HMETTRXCAR` | decimal(19,10) | Sí | Metas (solo base) | C | — | Meta de usabilidad sobre cartera, fija 0,09 (RSTABCOMER); VDMCOM01 10252 pendiente (P09). | DIG09 |
| 66 | `HMETPLZ` | decimal(28,6) | Sí | Metas (solo base) | S | — | Meta de pólizas 5001: publicada (asesor 2→1, coordinación) o suma de metas de asesor por la jerarquía del corte. NULL = sin meta o seguros pendiente. | SEG05 |
| 67 | `HDIAHABTOT` | int | No | Calendario (solo base) | C | — | Días hábiles del mes de t; no aditivo entre entidades. | DES09 |
| 68 | `HDIAHABAVA` | int | No | Calendario (solo base) | C | — | Días hábiles transcurridos hasta t inclusive. | DES10 |
| 69 | `HASEDESNET` | bigint | No | Población ajustada (solo base) | C | — | Asesores distintos de la población ajustada de desembolsos, contados por asesor al desembolsar. |  |
| 70 | `HTASDESNET` | decimal(19,10) | Sí | Población ajustada (solo base) | C | — | TAPP mes de la población ajustada. |  |
| 71 | `HTASMINNET` | decimal(19,10) | Sí | Población ajustada (solo base) | C | — | TAPP mínima de la población ajustada. |  |
| 72 | `HTASSTKTOTNET` | decimal(19,10) | Sí | Población ajustada (solo base) | C | — | TAPP stock total de la población ajustada. |  |
| 73 | `HTASSTKVIGNET` | decimal(19,10) | Sí | Población ajustada (solo base) | C | — | TAPP stock vigente de la población ajustada. |  |
| 74 | `HOPEDESNET` | bigint | No | Población ajustada (solo base) | C | — | Operaciones desembolsadas de la población ajustada. |  |
| 75 | `HOPECARNET` | bigint | No | Población ajustada (solo base) | C | — | Operaciones del stock ajustado. | CAR09 |
| 76 | `HOPECARPRO` | bigint | No | Población ajustada (solo base) | C | — | Operaciones propias: base sin claves heredadas (segmento "Propia"). | CAR21 |
| 77 | `HOPEINGMORNET` | bigint | No | Población ajustada (solo base) | C | — | Ingresos a mora de la población ajustada. |  |
| 78 | `HCLICARNET` | bigint | No | Población ajustada (solo base) | C | — | Clientes distintos del stock ajustado; base del crecimiento neto de clientes. | CLI07 |
| 79 | `HCLINUENET` | bigint | No | Población ajustada (solo base) | C | — | Clientes nuevos de la población ajustada. |  |
| 80 | `HCLIBANNET` | bigint | No | Población ajustada (solo base) | C | — | Bancarizados de la población ajustada. |  |
| 81 | `HOPECASNET` | bigint | No | Población ajustada (solo base) | C | — | Castigos de la población ajustada. |  |
| 82 | `HOPEVTANET` | bigint | No | Población ajustada (solo base) | C | — | Ventas de la población ajustada. |  |
| 83 | `HOPECANPRENET` | bigint | No | Población ajustada (solo base) | C | — | Cancelaciones anticipadas de la población ajustada. |  |
| 84 | `HOPECANCONNET` | bigint | No | Población ajustada (solo base) | C | — | Cancelaciones contractuales de la población ajustada. |  |

Restricciones: `CK_HTABSEG001_HTIPCOD` (niveles 1, 7, 17–20) y `CK_HTABSEG001_HDIAHAB` (`HDIAHABAVA` entre 0 y `HDIAHABTOT`).

## 4. HTABSEG002 — trasladados y HTABSEG003 — heredados

Las dos tablas tienen las mismas 35 columnas (las comunes de la base, marcadas "Sí" en la columna *En 002/003*), con la definición de la sección 3 aplicada al grupo:

- **Trasladados (002):** medidas de los créditos que cambiaron de entidad, contadas en la entidad de **origen** (asesor de t−1, asesor al desembolsar o titular anterior a la salida).
- **Heredados (003):** las mismas medidas contadas en la entidad de **destino**; ya están dentro de la base de esa entidad.
- Solo tienen fila las entidades con algún movimiento. No tienen recuperación, efectividad, saldo medio, metas ni población ajustada (solo existen en base).
- Un crédito se mueve si cambia la entidad en ese nivel: puede ser traslado entre asesores y no entre unidades.

| # | Columna | Tipo | Nulo | Carga |
|---:|---|---|:-:|:-:|
| 1 | `HFECPRO` | date | No | C |
| 2 | `HTIPCOD` | smallint | No | C |
| 3 | `HCODREL` | varchar(30) | No | C |
| 4 | `HOPEDES` | bigint | No | C |
| 5 | `HOPEDESSEG` | bigint | Sí | S |
| 6 | `HASEDES` | bigint | No | C |
| 7 | `HSALDES` | decimal(28,6) | Sí | C |
| 8 | `HTASDES` | decimal(19,10) | Sí | C |
| 9 | `HTASMIN` | decimal(19,10) | Sí | C |
| 10 | `HCLIMOR` | bigint | No | C |
| 11 | `HSALMOR` | decimal(28,6) | No | C |
| 12 | `HOPEINGMOR` | bigint | No | C |
| 13 | `HSALINGMOR` | decimal(28,6) | No | C |
| 14 | `HSALCIE` | decimal(28,6) | No | C |
| 15 | `HSALCIEVIG` | decimal(28,6) | No | C |
| 16 | `HOPECAR` | bigint | No | C |
| 17 | `HTASSTKTOT` | decimal(19,10) | Sí | C |
| 18 | `HTASSTKVIG` | decimal(19,10) | Sí | C |
| 19 | `HCLICAR` | bigint | No | C |
| 20 | `HCLINUE` | bigint | No | C |
| 21 | `HCLIBAN` | bigint | No | C |
| 22 | `HCLIENR` | bigint | No | C |
| 23 | `HCLIENRNUE` | bigint | No | C |
| 24 | `HCLITRX` | bigint | No | C |
| 25 | `HCLITRXMON` | bigint | No | C |
| 26 | `HCLIPAGDIG` | bigint | No | C |
| 27 | `HNUMTRXMON` | bigint | No | C |
| 28 | `HOPECAS` | bigint | No | C |
| 29 | `HSALCAS` | decimal(28,6) | No | C |
| 30 | `HOPEVTA` | bigint | No | C |
| 31 | `HSALVTA` | decimal(28,6) | No | C |
| 32 | `HOPECANPRE` | bigint | No | C |
| 33 | `HSALCANPRE` | decimal(28,6) | No | C |
| 34 | `HOPECANCON` | bigint | No | C |
| 35 | `HSALCANCON` | decimal(28,6) | No | C |

Restricciones: `CK_HTABSEG002_HTIPCOD` y `CK_HTABSEG003_HTIPCOD` (niveles 1, 17–20).

## 5. HTABSEG004 — detalle

Una fila por crédito lógico (HCODOPE + HTIPOPE) presente en t−1, en t o desembolsado en el mes. Sufijo `ANT` = cierre t−1, `ACT` = corte t, `SAL` = titular a la salida. No guarda saldos medios ni tasas ponderadas (esas son de los agregados). Sirve para el "ver detalle" del tablero.

| # | Columna | Tipo | Nulo | Carga | Descripción |
|---:|---|---|:-:|:-:|---|
| 1 | `HFECPRO` | date | No | C | Corte efectivo t. |
| 2 | `HFECANT` | date | No | C | Cierre anterior t−1 (cie_ant). |
| 3 | `HCODOPE` | int | No | C | Código de operación. |
| 4 | `HTIPOPE` | smallint | No | C | Tipo de operación; con HCODOPE forma el crédito lógico (dos tipos hipotecarios son dos filas). |
| 5 | `HCODPAIANT` | smallint | Sí | C | País del cliente en t−1 (−1 si la identidad está incompleta). |
| 6 | `HTIPDOCANT` | smallint | Sí | C | Tipo de documento en t−1 (−1 si incompleta). |
| 7 | `HNUMDOCANT` | varchar(20) | Sí | C | Documento en t−1 ('' si incompleta). |
| 8 | `HCODPAIACT` | smallint | Sí | C | País del cliente en t. |
| 9 | `HTIPDOCACT` | smallint | Sí | C | Tipo de documento en t. |
| 10 | `HNUMDOCACT` | varchar(20) | Sí | C | Documento en t. |
| 11 | `HCODSECANT` | varchar(10) | Sí | C | Asesor en t−1. En un desembolso de t, asesor al desembolsar solo si HINDTRA = 1 (si no, NULL). Vacío = ''. |
| 12 | `HCODSECACT` | varchar(10) | Sí | C | Asesor en t. Vacío = ''. |
| 13 | `HCODMODANT` | smallint | Sí | C | Módulo en t−1. |
| 14 | `HCODMODACT` | smallint | Sí | C | Módulo en t. |
| 15 | `HINDPREANT` | bit | No | C | 1 = presente en la cartera de t−1. |
| 16 | `HINDPREACT` | bit | No | C | 1 = presente en la cartera de t. |
| 17 | `HINDTFCANT` | bit | Sí | C | Trabajador FC en t−1 (HCODMOD = 103 y HTIPOPE 20/100/105); informativo, no excluye. |
| 18 | `HINDTFCACT` | bit | Sí | C | Trabajador FC en t. |
| 19 | `HINDCARANT` | varchar(20) | Sí | C | Estado consolidado en t−1 (prioridad VIGENTE < REFINANCIADO < VENCIDO < JUDICIAL). |
| 20 | `HINDCARACT` | varchar(20) | Sí | C | Estado consolidado en t. |
| 21 | `HSALCAPANT` | decimal(28,6) | Sí | C | Capital en t−1 (PEN). |
| 22 | `HSALCAPACT` | decimal(28,6) | Sí | C | Capital en t (PEN). |
| 23 | `HSALVENANT` | decimal(28,6) | Sí | C | Vencido en t−1 (PEN). |
| 24 | `HSALVENACT` | decimal(28,6) | Sí | C | Vencido en t (PEN). |
| 25 | `HDIAATRANT` | smallint | Sí | C | Días de atraso en t−1 (máximo entre rubros). |
| 26 | `HDIAATRACT` | smallint | Sí | C | Días de atraso en t. |
| 27 | `HCUOPENANT` | smallint | Sí | C | Cuotas pendientes en t−1 (máximo entre rubros). |
| 28 | `HCUOPENACT` | smallint | Sí | C | Cuotas pendientes en t. |
| 29 | `HFECMORANT` | date | Sí | C | Fecha de mora en t−1 (la menor entre rubros). |
| 30 | `HFECMORACT` | date | Sí | C | Fecha de mora en t. |
| 31 | `HFECVENANT` | date | Sí | C | Vencimiento en t−1 (clasifica cancelaciones anticipadas/contractuales). |
| 32 | `HFECVENACT` | date | Sí | C | Vencimiento en t. |
| 33 | `HTASCREANT` | decimal(19,10) | Sí | C | Tasa del crédito en t−1, fracción. |
| 34 | `HTASCREACT` | decimal(19,10) | Sí | C | Tasa del crédito en t, fracción. |
| 35 | `HINDRECPRO` | bit | No | C | 1 = pertenece a la recuperación programada del mes. |
| 36 | `HSALRECPRO` | decimal(28,6) | No | C | Importe programado: capital t−1 / cuotas pendientes t−1 (0 si no es programado). |
| 37 | `HCODUCOANT` | varchar(30) | Sí | C | Coordinación en t−1 (o de origen del desembolso con HINDTRA = 1). |
| 38 | `HCODUNIANT` | varchar(30) | Sí | C | Unidad en t−1 (ídem). |
| 39 | `HCODCORANT` | varchar(30) | Sí | C | Corredor en t−1 (ídem). |
| 40 | `HCODTERANT` | varchar(30) | Sí | C | Territorio en t−1 (ídem). |
| 41 | `HCODUCOACT` | varchar(30) | Sí | C | Coordinación en t. |
| 42 | `HCODUNIACT` | varchar(30) | Sí | C | Unidad en t. |
| 43 | `HCODCORACT` | varchar(30) | Sí | C | Corredor en t. |
| 44 | `HCODTERACT` | varchar(30) | Sí | C | Territorio en t. |
| 45 | `HFECDES` | date | Sí | C | Fecha de desembolso corregida (RFOC001); NULL si no es desembolso del mes. |
| 46 | `HSALDES` | decimal(28,6) | Sí | C | Monto desembolsado en PEN. |
| 47 | `HTASDES` | decimal(19,10) | Sí | C | Tasa del desembolso, fracción. |
| 48 | `HTASMIN` | decimal(19,10) | Sí | C | Tasa mínima aplicable (HGAT001), fracción. |
| 49 | `HINDDES` | bit | No | C | 1 = desembolso del mes hasta t. |
| 50 | `HINDTRA` | bit | No | C | 1 = genera traslado en origen y heredado en destino en algún nivel; filtro de "ver detalle" de movimientos. |
| 51 | `HINDSEG` | bit | Sí | S | Desembolso con al menos un optativo: 1/0 en desembolsos, NULL en el resto. NULL en todas las filas hasta la carga de seguros. |
| 52 | `HINDNUE` | bit | No | C | 1 = cliente nuevo real. |
| 53 | `HINDFEN` | bit | Sí | C | Marca FEN del SP de incentivos; hoy queda NULL (informativo). |
| 54 | `HINDFID` | bit | Sí | C | Desembolso mayor de 70 000 PEN según el SP de incentivos (informativo; no excluye). |
| 55 | `HINDMET` | bit | No | C | 1 = el asesor tiene meta en VDMCOM01 (informativo; no filtra). |
| 56 | `HINDENR` | bit | Sí | C | Cliente de t enrolado; NULL si el crédito no está en t. |
| 57 | `HINDTRX` | bit | Sí | C | Cliente de t transaccional; NULL si no está en t. |
| 58 | `HINDPAGDIG` | bit | Sí | C | Cliente de t con pago de crédito digital en el mes; NULL si no está en t. |
| 59 | `HMOTSAL` | varchar(20) | No | C | PRESENTE, CASTIGO, VENTA o CANCELACION. |
| 60 | `HFECSAL` | date | Sí | C | Fecha de castigo/venta; NULL en cancelación (no se inventa). |
| 61 | `HTIPCAN` | varchar(20) | Sí | C | ANTICIPADA o CONTRACTUAL en cancelaciones; NULL en el resto o sin vencimiento en t−1. |
| 62 | `HFECULTPRE` | date | Sí | C | Última fecha del mes en que el crédito aparece en cartera (t−1 si no aparece en el mes). |
| 63 | `HSALSAL` | decimal(28,6) | Sí | C | Importe de la salida: el de la fuente en castigo/venta, el capital del último snapshot en cancelación. |
| 64 | `HCODSECSAL` | varchar(10) | Sí | C | Titular a la salida: asesor de la fuente (castigo/venta) o del último snapshot. |
| 65 | `HCODUCOSAL` | varchar(30) | Sí | C | Coordinación del titular a la salida en HFECULTPRE. |
| 66 | `HCODUNISAL` | varchar(30) | Sí | C | Unidad del titular a la salida. |
| 67 | `HCODCORSAL` | varchar(30) | Sí | C | Corredor del titular a la salida. |
| 68 | `HCODTERSAL` | varchar(30) | Sí | C | Territorio del titular a la salida. |
| 69 | `HINDRECEFE` | bit | No | C | 1 = cumplió la recuperación efectiva (castigo/venta no califican). |
| 70 | `HTRAEFEANT` | tinyint | Sí | C | Tramo de efectividad en t−1. |
| 71 | `HTRAEFEACT` | tinyint | Sí | C | Tramo de efectividad en t. |
| 72 | `HSALEFEINI` | decimal(28,6) | No | C | Capital inicial de la efectividad. |
| 73 | `HSALEFEREC` | decimal(28,6) | No | C | Capital reconocido por mejora de tramo o salida. |
| 74 | `HSALEFEMAN` | decimal(28,6) | No | C | Capital reconocido por mantenimiento del tramo. |

Restricciones: `CK_HTABSEG004_HMOTSAL`, `CK_HTABSEG004_HTIPCAN` (solo en cancelaciones), `CK_HTABSEG004_PRESENCIA` (presente en t−1 o en t) y `CK_HTABSEG004_TRAMOS` (tramos ≤ 9).
Índices: `NCI_HTABSEG004_SECACT` (HFECPRO, HCODSECACT) para base, heredados e ingresos a mora; `NCI_HTABSEG004_SECANT` (HFECPRO, HCODSECANT) para trasladados, recuperación y salidas.

**Filtros típicos del "ver detalle" de un asesor A en el corte t:**

| Vista | Filtro |
|---|---|
| Cartera de hoy | `HINDPREACT = 1 AND HCODSECACT = A` |
| Desembolsos del mes | `HINDDES = 1 AND HCODSECACT = A` (con `HINDSEG` para penetración) |
| Movimientos | `HINDTRA = 1`; heredado si A es el destino (asesor de t o titular a la salida) y el origen (`HCODSECANT`) es otro; trasladado si A es el origen y el destino es otro |
| Recuperación | `HINDRECPRO = 1 AND HCODSECANT = A` (efectiva: `HINDRECEFE = 1`) |
| Salidas | `HMOTSAL <> 'PRESENTE' AND HCODSECSAL = A` |
| Mora | `HINDPREACT = 1 AND HCODSECACT = A AND (HDIAATRACT > 0 OR HINDCARACT = 'JUDICIAL')` |

En niveles superiores se filtra por la columna de jerarquía del mismo sufijo (`HCODUNIACT`, `HCODUNIANT`, `HCODUNISAL`…).
