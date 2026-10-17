# Catálogo de variables del tablero de seguimiento

Actualización: **2026-10-17**. Inventario por tarjeta de los valores, metas,
variaciones, ratios y componentes visibles en [captura.png](captura.png), con los
cambios acordados en la conversación. Incluye variables adicionales necesarias
para el diseño. **Desempeño está excluido y su lugar lo ocupa el panel Digital
(§5.4); en Seguros, ingresos y ticket prima siguen diferidos (§6).**

Este documento es la referencia para localizar la definición de cada variable.
Las reglas transversales, filtros y contrato de las consultas están en
[consideraciones.md](consideraciones.md). Las [consultas v0.3](README.md)
incorporan las últimas precisiones de identidad, conteos, tipo de cambio,
arquitectura, filtros, salidas (castigos, ventas y cancelaciones con titular a la
salida), recuperación sobre la base de t−1 y saldo medio por asesor operativo.
No se han validado resultados contra serv30.
Los importes de la captura no se usan como prueba ni para inferir fórmulas.
La ejecución de detalle y agregados está fusionada en [01_tablero.sql](01_tablero.sql),
con @Fecha al inicio, preparación compartida y cuatro salidas al final. Seguros es un
segundo paso ([05_seguros.sql](05_seguros.sql), R40) que completa su bloque sobre esas salidas.

## Índice

1. [Cómo leer el catálogo](#1-cómo-leer-el-catálogo).
2. [Desembolsos](#2-desembolsos).
3. [Recuperaciones y Mora](#3-recuperaciones-y-mora).
4. [Cartera](#4-cartera).
5. [Clientes](#5-clientes).
6. [Seguros](#6-seguros).
7. [Cobertura visual y cambios de etiquetas](#7-cobertura-visual-y-cambios-de-etiquetas).
8. [Pendientes vinculados a variables](#8-pendientes-vinculados-a-variables) (trasladados a [pendientes.md](pendientes.md)).
9. [Fuentes de referencia](#9-fuentes-de-referencia).
10. [Mapeo al detalle y al agregado](#10-mapeo-al-detalle-y-al-agregado).

## 1. Cómo leer el catálogo

### 1.1. Identificadores, nombres y estados

- Los IDs DES, REC, SAL, CAR, CLI y SEG son **identificadores documentales**; no
  son códigos de metas ni nombres de columnas SQL.
- Los nombres de columnas son los del DDL v0.3 ([03_tablas_destino.sql](03_tablas_destino.sql),
  [diccionario_tablas.md](diccionario_tablas.md)); los nombres de tabla siguen
  pendientes (P10). El resultset del tablero lo entrega el SP de reporte
  RTABSEG01 ([07_sp_reporte.sql](07_sp_reporte.sql)), documentado en [diccionario_reporte.md](diccionario_reporte.md).
  Las referencias a campos de SP existentes son evidencia de origen, no aprobación
  automática de nombres o filtros para el tablero.
- **Confirmado:** definición acordada. Una ficha puede tener fórmula confirmada
  y mapeo técnico pendiente; se indica la parte concreta que falta.
- **Pendiente:** requiere definición o contraste; una fórmula marcada como
  propuesta no constituye regla aprobada.
- **Diferido:** desarrollo expresamente pospuesto.
- Una fila es un resultado lógico. No implica una columna física independiente:
  una referencia anterior, una presentación o un alias pueden reutilizar datos.
  El [mapeo de las 117 entradas](#10-mapeo-al-detalle-y-al-agregado) identifica el
  destino de cada resultado y sus dependencias antes de definir el esquema físico.
- Las tablas origen son **detalle, base, traslados y heredados**. El SP de reporte
  RTABSEG01 genera el resultset: lee los valores ya registrados en t−1 para
  comparaciones y metas de stock, sin recalcular esos indicadores en los orígenes.
- Fuentes y auxiliares compartidos alimentan **ramas independientes** de detalle
  explicativo y agregados. Las dependencias del mapeo no obligan a consultar la
  salida final del detalle. Saldo medio/tasas ponderadas son cálculos de agregados,
  no campos del detalle; sí se conservan tasas individuales y flags explicativos.
- Nombres nuevos: **H + bloques de tres letras**, sin guiones bajos. Los ejemplos
  `HTASSTKTOT`, `HTASSTKVIG`, `HMETVARVIG`, `HMETVARCLI`, `HDIAHABTOT` y
  `HDIAHABAVA` son propuestas de destino. Las citas de campos existentes en las
  fuentes conservan su nombre original.

Cada bloque de fichas hereda su **población, fuentes, filtros, temporalidad y
tratamiento de grupos** de la subsección que lo precede. La fila documenta sus
excepciones. Los pendientes se identifican por V01–V12 en
[pendientes.md](pendientes.md#22-por-variable).

### 1.2. Convenciones comunes

| Concepto | Definición aplicable a las fichas |
|---|---|
| t | Corte efectivo almacenado en HFECPRO. Sin fecha/NOW: referencia ayer; fecha explícita: usarla sin restar un día. En ambos casos, último RCALEN001.RDIAFER=0 menor o igual a la referencia. No almacenar otra fecha de ejecución. |
| t−1 | Cierre Bantotal del mes anterior: `cie_ant` de util.FVECFEC01 (último hábil del mes anterior), equivalente a RCALEN001.RCIEBT=1 por confirmación del usuario. |
| Clave lógica de crédito | HCODOPE + HTIPOPE en las carteras; conservar ambos para hipotecarios tratados como créditos separados. Por fecha/clave, SUM de capital/vencido, estado con prioridad VIGENTE < REFINANCIADO < VENCIDO < JUDICIAL, MIN de fecha de mora y MAX de los demás atributos, incluso si difieren entre rubros. Las demás fuentes se cruzan solo por HCODOPE. |
| Operación reportada | COUNT(DISTINCT HCODOPE), después de filtrar la población de claves lógicas por entidad/nivel/grupo. Dos tipos hipotecarios del mismo HCODOPE cuentan una operación, aunque aporten ambos al monto. |
| Cliente distinto | País + tipo de documento + documento; unicidad dentro de cada entidad y nivel. |
| Entidad | HCODREL dentro del nivel HTIPCOD. No sumar conteos de clientes de niveles inferiores. |
| Grupos | Tres tablas: base, traslados y heredados; clave HFECPRO + HTIPCOD + HCODREL en cada una. Sin HGRUREG ni Grupo en salidas. Base incluye heredados; trasladados están fuera de la base del origen. Grupo 0/1/2/3 (3 = población ajustada) autorizado solo en auxiliares para compartir cálculos y resolver netos (R26). Recuperación y efectividad solo existen en base (entidad de t−1). |
| Ajustado/neto aditivo | X(base) + X(trasladado) − X(heredado). No equivale al stock actual de la entidad. |
| Conteos de operaciones ajustados | Ajustar la población por claves lógicas y luego contar HCODOPE distintos. Los conteos de base/trasladados/heredados pueden superponerse; no sumarlos/restarlos como si fueran aditivos. Recalcular también por nivel superior. |
| Tasas/ratios ajustados | Recalcular desde numerador y denominador de la población ajustada; no sumar/restar tasas finales. |
| Clientes ajustados | Contar distintos por entidad y grupo para las vistas acordadas. Churn requiere conjuntos de clientes, no aritmética de conteos superpuestos. |
| PEN | Soles. Saldos ya en moneda nacional; desembolsos no soles se convierten con RTCM001.RVALCA del último RFECCIE <= t, como @tc de HRESINC003. No HTIPCMB intrames. |
| Porcentajes | Se documenta la razón matemática; escala física, decimales, redondeo y formato final pendientes V01. |
| Comparaciones | Resultset (RTABSEG01): leer el valor ya registrado en t−1, sin recalcularlo ni persistir columnas comparativas en las tablas origen. Mantener población/elección base o ajustada según cada ficha. |
| Metas de variación | Cartera vigente: 9000; clientes: 10062. Solo en base. Meta de stock, si se necesita en resultset = valor registrado al cierre t−1 + meta de variación. |

Trabajadores FC, identificados por HCODMOD=103 y HTIPOPE IN (20,100,105):
**conservar flag en detalle, sin excluirlos de ninguna medida agregada.** No excluir por
FEN, HINDFID ni ausencia de meta. No reintegrar cartera vendida/castigada al stock.
Normalizar NULL, '--' y '' como un asesor vacío; cuenta como uno en productividad
cuando participa en sus desembolsos. No perder sus créditos ni su origen.
Metas: mantener HTIPMETA=1 y selección mensual, sin restringir la población de
créditos a asesores con meta. Las metas van solo en base, sin columnas equivalentes
en traslados/heredados. Completar correspondencia de niveles, especialmente 17, V02.

No rellenar una meta faltante como si fuera una meta cero. El resultado ante
denominadores cero/nulos sigue pendiente solo donde no se ha acordado una regla:
ticket 0 si operaciones 0; tasa mes 0 sin desembolsos; asesor sin cartera de inicio
y sin programación, ratios de recuperación de monto/operaciones 100 %. Cero
clientes en t−1 define **asesor sin cartera de inicio**, no asesor nuevo: puede
haber tenido cartera en t−2 o antes, sin que sea necesario consultar esa historia
para esta clasificación. Sin cohorte heredada, retención 100 % y churn 0 %; con
cohorte heredada, evaluación regular. No mantener ese caso como preliminar.
El usuario confirma denominador disponible para TAPP stock.

## 2. Desembolsos

### 2.1. Población y fuente comunes

**Población D:** desembolsos del mes de t al corte t, calculados desde las tablas
fuente mediante la lógica de [F01](#f01--desembolsos). HCMA001 contiene solo cierres
mensuales y no se usa como dependencia de cortes intrames.

- HCDA001 al corte, HINDCAR='VIGENTE'; excluir reprogramados de HCDR001 con estado
  VIGENTE y HCDR002 al corte. Refinanciados no son desembolsos.
- Fecha corregida ISNULL(RFOC001.ROPEFEC,HFECDES), respetando las condiciones de
  cruce del productor; debe pertenecer al mes del corte.
- Monto por crédito lógico m: HMONDES si HCODMON=0; en otro caso HMONDES × RVALCA
  de RTCM001, registro con mayor RFECCIE <= t. En intrames corresponde al cierre
  anterior; al cierre, a ese cierre si está registrado. No usar HTIPCMB de HCDA001
  para esta conversión. Evidencia: PSLHRESINC003 líneas 63–64 y 465, F02.
- Tasa r: HNUMTAS. Tasa mínima rmin: lógica HGAT001 del SP de referencia. Si falta
  o es cero usar la tasa del crédito; para (HCODMOD,HTIPOPE) (101,40)/(104,40),
  también usar tasa del crédito.
- Origen de atribución: asesor al desembolsar; destino: responsable en t. No se
  busca el desembolso de t en t−1. La jerarquía del asesor de origen se consulta
  en t−1 y la del destino en t, como HRESINC003 (R24). Fuente exacta del asesor: V03.
- Anulaciones/reversos y cobertura de eventos que no sobreviven al corte: V04;
  no presentar cobertura completa como ya contrastada.

**Grupos D:** calcular variables sobre cada grupo y su población. Para el neto,
restituir al origen y retirar del destino. Los montos son aditivos; las operaciones
se cuentan por HCODOPE después de ajustar la población, no mediante aritmética
de conteos que pueden superponerse. Los ratios usan esos componentes. Asesores se cuentan distintos sobre los
desembolsos atribuidos, no sumando conteos de grupos.

### 2.2. Operaciones, productividad y metas

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| DES01 | Operaciones desembolsadas | COUNT(DISTINCT HCODOPE) sobre D, cuya elegibilidad se evalúa por clave lógica. | Operaciones | Confirmado. Un hipotecario con dos tipos cuenta uno. Grupos D; no heredar las exclusiones de variantes N del SP. |
| DES02 | Productividad | Nivel asesor: DES01. Niveles superiores: DES01 / DES03. | Operaciones por asesor | Confirmado. No confundir con conteo total; elección de qué se rotula como “Operaciones” en niveles superiores pendiente V05. |
| DES03 | Asesores que desembolsaron | Conteo distinto de asesores con los créditos incluidos en DES01, con la misma regla que la entidad: base y heredados cuentan al asesor en t (en el asesor vale 1); trasladados y población ajustada, al asesor al desembolsar. | Asesores | Confirmado (2026-10-17: base por asesor en t); auxiliar de DES02, no visible en captura. No usar planilla, asesores sin desembolso ni filtro de meta. Asesor vacío normalizado cuenta como uno. |
| DES04 | Meta de operaciones / productividad | Meta de productividad aplicable al nivel y entidad; a nivel asesor se contrasta con DES01, arriba con DES02. | Misma unidad que DES02 | Confirmado; solo base. Referencia HCODVAR=8070 en F02; verificar mapeo/escala por nivel, V02. |
| DES05 | Avance contra meta de operaciones | Razón entre el resultado comparable con DES04 y esa meta. | % | Fórmula de presentación propuesta; confirmar selección DES01/DES02, límites y cero/nulo, V01/V05. La barra no acredita reglas de truncamiento. |

En DES04, la referencia técnica es **HCODVAR=8070** en VDMCOM01. No usar la meta
de productividad como si fuera una meta de conteo total en niveles superiores.

### 2.3. Monto, calendario, ticket y tasas

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| DES06 | Monto desembolsado | SUM(m) sobre D. | PEN | Confirmado. Grupos D; conversión según F01, no tipo de cambio actual. |
| DES07 | Meta de monto desembolsado | Importe objetivo del mes, entidad y nivel para DES06. | PEN | **Diferido:** falta código de meta. No confundir con productividad ni meta de cartera. |
| DES08 | Avance contra meta de monto | DES06 comparable / DES07. | % | **Diferido**, depende de DES07; cálculo y población comparables por confirmar V01/V02. |
| DES09 | Días hábiles del mes | Conteo de fechas del mes de t en RCALEN001 con RDIAFER=0. | Días | Confirmado. En base como HDIAHABTOT; no aditivo entre entidades, no va en movimientos. F03/V06. |
| DES10 | Días hábiles transcurridos | Conteo de fechas hábiles desde inicio del mes hasta t inclusive. | Días | Confirmado el corte efectivo y su inclusión. En base como HDIAHABAVA, no en traslados/heredados. |
| DES11 | Avance de días hábiles | DES10 / DES09. | % | Cálculo del resultset; los contadores se refieren al corte efectivo, no al día de ejecución. Marcador temporal común, no meta monetaria. |
| DES12 | Ticket promedio | DES06 / DES01; si DES01=0, resultado 0. | PEN por operación | Confirmado. Cálculo de presentación; misma población y neto desde componentes. |
| DES13 | TAPP mes | SUM(m × r) / SUM(m) sobre D; sin desembolsos, 0. | Tasa, presentada en % | Confirmado. Grupos D; sin FEN/HINDFID. Escala/redondeo final V01; no queda pendiente la regla sin desembolsos. |
| DES14 | TAPP mínima | SUM(m × rmin) / SUM(m) sobre D; sin desembolsos, 0 según consumidor F02. | Tasa, presentada en % | Misma ponderación y lógica de mínima descrita en 2.1; evidencia GRESINC08 líneas 246–247. Historicidad HGAT001 V03. |

## 3. Recuperaciones y Mora

### 3.1. Recuperación programada y efectiva

**Población R:** stock t−1, después de consolidar rubros y aplicar filtros generales,
con HINDCAR='VIGENTE', HDIAATR<=0, HCUOPEN>0 y HFECMOR dentro del mes completo de t.
Se descarta HCUOPEN cero/nulo. No incluye desembolsos de t. Fuente: HCDA001 en
ambos cortes y fuentes de salidas; [F04](#f04--recuperación-y-efectividades).

Para cada crédito lógico o=(HCODOPE,HTIPOPE), **p(o)=HSALCAPMN(t−1)/HCUOPEN(t−1)**. Es capital promedio
por cuota pendiente, no el capital exacto del cronograma. No requiere t−2.

**Subconjunto E:** operaciones de R que cumplen uno de dos caminos:

1. Presentes en t: HINDCAR='VIGENTE', HDIAATR<=0, HCUOPEN menor que en t−1 **y**
   HSALCAPMN menor que en t−1.
2. Salidas: descartar castigos (HCCA001) y ventas (HRVC001), fuentes de HRESINC003,
   cruzadas por HCODOPE; las restantes son cancelaciones. No exigir presencia,
   vigente ni atraso en t para esta excepción. Exclusión de condonaciones diferida; V07.

**Grupos R:** se mide sobre la base de t−1, por eso se atribuye a la **entidad de
t−1** y existe **solo en base**: sin trasladados, heredados ni versión NET.
Programación fija desde t−1; evaluación efectiva hasta t, sin volver a valorar
p(o) con el saldo actual. Recalcular ratios desde sus componentes.

| ID | Nombre visible / nombre técnico confirmado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| REC01 | Saldo para recuperación programada — HSALRECPRO | SUM(p(o)) sobre R. | PEN | Confirmado. Denominador de todo el mes, aunque t sea día 10. Reemplaza “monto exigible”. |
| REC02 | Saldo de recuperación efectiva — HSALRECEFE | SUM(p(o)) sobre E. | PEN | Confirmado. No suma delta de capital, pagos monetarios ni capital completo de cancelados; reconoce el importe programado una vez. V07. |
| REC03 | Porcentaje de saldo recuperado | REC02 / REC01; entidad sin cartera de inicio (HINDSININI) y sin importe programado: 100 %; programación 0 con cartera de inicio: NULL (P21). | % | Confirmado. Los importes origen quedan en 0; ratio en RTABSEG01. No extender excepción a cualquier población vacía. |
| REC04 | Operaciones para recuperación programada — HOPERECPRO | COUNT(DISTINCT HCODOPE) sobre R, filtrada por clave lógica. | Operaciones | Confirmado. Tipos de un mismo HCODOPE cuentan uno; los importes programados de ambos siguen sumándose. |
| REC05 | Operaciones de recuperación efectiva — HOPERECEFE | COUNT(DISTINCT HCODOPE) sobre E, evaluada por clave lógica. | Operaciones | Confirmado. No contar varias veces por tipos, pagos o rubros. Basta pertenencia de alguna clave lógica a E para que su HCODOPE aparezca en este conjunto; no se añade condición de cumplimiento de todos los tipos. |
| REC06 | Porcentaje de operaciones recuperadas | REC05 / REC04; entidad sin cartera de inicio y sin operaciones programadas: 100 %; programación 0 con cartera de inicio: NULL (P21). | % | Confirmado. Los conteos origen quedan en 0; ratio en RTABSEG01. No usar REC03 como sustituto. |

Cancelaciones cuentan solo si pertenecían a R, tras descartar castigo y venta.
No se requiere otra fuente de cancelación. No identificar pagos parciales para el camino 1:
se evalúan las dos disminuciones y se reconoce p(o). Las fórmulas antiguas por
capital completo o delta t−2/t−1 están sustituidas.

### 3.2. Efectividades por tramo y sus metas

**Población EFE:** bases de efectividad por tramo. SDAE002: −30 a 0 días de atraso;
SDAE003: 1 a 30; SDAE004: 31 a 60. Selección SCODAGR=3 del productor de referencia.
Fórmula común **(saldo recuperado + mantenido efectivo) / saldo inicial**. Fuente
[F04](#f04--recuperación-y-efectividades); metas [F06](#f06--metas-y-reportes).

**Temporalidad:** corte t de las bases, con saldo inicial de su población de
referencia en t−1. Se parametriza la lógica de PSLSDAE002/003/004 por crédito.
**Grupos:** solo base, entidad de t−1 (como la recuperación). No sumar tasas.

Alineación con SDAE: población sin los productos (101,40)/(104,40); recuperado si
sale, si el tramo final es nulo o si mejora de tramo; mantenido efectivo si
conserva el tramo salvo «por vencer» (mismas cuotas y mayor atraso). Castigo no
recupera. **Alerta: la venta tampoco se reconoce en el tablero, mientras que
SDAE002/003/004 sí la reconocen como recuperada**; para la recuperación, venta y
castigo son lo mismo, un crédito perdido. No se copian las operaciones judiciales
fijas de VCEI001/VCEF001. Diferencia residual aceptada: SDAE evalúa por rubro
(HSUBOPE); el tablero, por crédito consolidado.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| REC07 | Efectividad −30 a 0 días | Fórmula EFE para SDAE002. | % | Confirmado. No equivale a REC03 ni a proporción de pagos monetarios. |
| REC08 | Meta de efectividad −30 a 0 | Meta mensual de REC07 para entidad/nivel. | % | Solo base. Referencia HCODVAR=126 observada en F02/F06; mapeo por nivel/escala V02. |
| REC09 | Efectividad 1 a 30 días | Fórmula EFE para SDAE003. | % | Confirmado. Mantener identidad de tramo. |
| REC10 | Meta de efectividad 1 a 30 | Meta mensual de REC09 para entidad/nivel. | % | Solo base. Referencia HCODVAR=122; mapeo por nivel/escala V02. |
| REC11 | Efectividad 31 a 60 días | Fórmula EFE para SDAE004. | % | Definición confirmada; **adicional, no visible en captura**. Inclusión visual pendiente V12. |
| REC12 | Meta de efectividad 31 a 60 | Meta mensual de REC11 para entidad/nivel. | % | Solo base. Referencia HCODVAR=124; adicional no visible; V02/V12. |

Las barras muestran efectividad y meta: no se deduce de ellas un indicador
adicional de cumplimiento/meta, salvo que se solicite. Las convenciones de
incentivos para poblaciones vacías no quedan aprobadas por observar GRESINC08.

### 3.3. Stock en mora, variaciones e ingresos

**Población M(s):** créditos del corte s con HDIAATR>0 **o** HINDCAR='JUDICIAL',
dentro de los filtros generales. Fuente HCDA001, [F05](#f05--cartera-y-clientes).
Los clientes se cuentan distintos por entidad; el saldo incluye únicamente los
créditos en mora, no los créditos al día de esos mismos clientes.

**Grupos M:** disponibles por población/clasificación donde corresponda. Las
variaciones REC14 y REC16 comparan la **base actual sin neteo** en cada corte,
por regla explícita; no trasladarles la fórmula de crecimiento neto de cartera.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| REC13 | Clientes en mora | Clientes distintos con al menos una operación de M(t). | Clientes | Confirmado. No contar operaciones como clientes. |
| REC14 | Variación de clientes en mora | Conteo M(t) − conteo M(t−1), ambos a nivel cliente y entidad. | Clientes | Confirmado: t−1/t, sin netear traslados. |
| REC15 | Saldo en mora | SUM(HSALCAPMN) sobre M(t). | PEN | Confirmado. No sustituir por SUM(HSALVENMN). |
| REC16 | Variación de saldo en mora | Saldo M(t) − saldo M(t−1). | PEN | Confirmado: t−1/t, sin netear traslados. |
| REC17 | Ingresos a mora — operaciones — HOPEINGMOR | Sobre el stock de t, COUNT(DISTINCT HCODOPE) después de evaluar por HCODOPE + HTIPOPE presencia en ambos cortes, HDIAATR(t−1)<=0 y HDIAATR(t)>0. | Operaciones | Confirmado. Base en el asesor de t; heredado en destino y trasladado en origen si cambió de entidad. No es diferencia de stocks ni conteo de claves compuestas; no agregar condición judicial no acordada. |
| REC18 | Ingresos a mora — monto — HSALINGMOR | SUM(HSALCAPMN(t)) de todas las claves lógicas que cumplen la transición de REC17. | PEN | No eliminar el saldo de un tipo porque comparta HCODOPE. Valoración t; mismos grupos que REC17. |

### 3.4. Salidas: castigos, ventas y cancelaciones

**Población S:** créditos presentes en t−1 y ausentes en t. Motivo con precedencia
castigo (HCCA001), venta (HRVC001) y cancelación residual. Se atribuyen al
**titular a la salida**: asesor de la fuente en castigo/venta (si no es válido, el
del último snapshot del mes en que aparece el crédito) y asesor del último snapshot
en cancelación. Si difiere del asesor de t−1: base y heredado en el titular,
trasladado en el origen. Variables **adicionales**, no visibles en la captura; el
total de salidas se calcula en el reporte final.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| SAL01 | Operaciones castigadas — HOPECAS | COUNT(DISTINCT HCODOPE) de S con motivo castigo. | Operaciones | Confirmado. NET en base: HOPECASNET. |
| SAL02 | Monto castigado — HSALCAS | SUM(HSALCAS de HCCA001), convertido con RTCM001 si no es PEN; una vez por HCODOPE. | PEN | Confirmado. Importe de la fuente por cuadre con el área. |
| SAL03 | Operaciones vendidas — HOPEVTA | COUNT(DISTINCT HCODOPE) de S con motivo venta. | Operaciones | Confirmado. NET en base: HOPEVTANET. |
| SAL04 | Monto vendido — HSALVTA | SUM(HSALCAPMN de HRVC001); una vez por HCODOPE. | PEN | Confirmado. Importe de la fuente. |
| SAL05 | Cancelaciones anticipadas — HOPECANPRE | COUNT(DISTINCT HCODOPE) de cancelaciones con año-mes de t < año-mes de HFECVENANT (C10). | Operaciones | Confirmado. «PRE» = precancelación. NET en base: HOPECANPRENET. |
| SAL06 | Monto de cancelaciones anticipadas — HSALCANPRE | SUM del capital del último snapshot de esas cancelaciones. | PEN | Confirmado. |
| SAL07 | Cancelaciones contractuales — HOPECANCON | COUNT(DISTINCT HCODOPE) de cancelaciones con año-mes de t >= año-mes de HFECVENANT (C10). | Operaciones | Confirmado. NET en base: HOPECANCONNET. |
| SAL08 | Monto de cancelaciones contractuales — HSALCANCON | SUM del capital del último snapshot de esas cancelaciones. | PEN | Confirmado. Sin vencimiento en t−1 no se clasifica (incidencia). |

## 4. Cartera

### 4.1. Población, grupos y saldos de corte

**Población C(s):** créditos de HCDA001 al corte s, consolidados por operación y
con filtros generales. Sin reincorporar saldos de cartera vendida/castigada.
**Población CV(s):** subconjunto de C(s) con HINDCAR='VIGENTE'. Fuente
[F05](#f05--cartera-y-clientes).

**Grupos C:** para valores de t, base/trasladado/heredado por entidad y nivel;
heredado se incluye en base. El neto se calcula con métricas aditivas. El stock
de referencia t−1 es el propio de ese corte, no una etiqueta permanente de grupo.
La correspondencia entre valores base/ajustados y elementos gráficos sigue V09.

| ID | Nombre visible / nombre técnico confirmado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| CAR01 | Saldo capital total al corte — HSALCIE | SUM(HSALCAPMN) sobre C(t). | PEN | Confirmado. Campo común aplicable en las tres tablas; la cifra base es el stock actual. |
| CAR02 | Saldo capital vigente al corte — HSALCIEVIG | SUM(HSALCAPMN − HSALVENMN) de los rubros con HINDCAR='VIGENTE' en C(t). | PEN | Confirmado. Por rubro: un crédito partido vigente/vencido aporta solo su rubro vigente, igual que CAR13. No incluir refinanciados como vigente. |
| CAR03 | Saldo total al cierre anterior | Misma definición CAR01, sobre C(t−1). | PEN | Confirmado. Referencia temporal, no requiere un nuevo nombre SQL ni sumar grupos actuales. |
| CAR04 | Saldo vigente al cierre anterior | Misma definición CAR02, sobre CV(t−1). | PEN | Confirmado. Referencia de la barra de saldo vigente. |
| CAR05 | Saldo total ajustado | CAR01(base) + CAR01(trasladado) − CAR01(heredado). | PEN | Confirmado; no confundir con CAR01 base. |
| CAR06 | Saldo vigente ajustado | CAR02(base) + CAR02(trasladado) − CAR02(heredado). | PEN | Confirmado por neteo aditivo. |
| CAR07 | Operaciones de cartera al corte | COUNT(DISTINCT HCODOPE) de C(t), por entidad/nivel/grupo. | Operaciones | Confirmado; si el gráfico debe restringirse a CV(t), elección visual pendiente V09. Los importes de distintos HTIPOPE no se descartan. |
| CAR08 | Operaciones al cierre anterior | Conteo distinto de la misma población de CAR07, al corte t−1. | Operaciones | Confirmado el conteo; mantener población comparable V09. |
| CAR09 | Operaciones ajustadas | COUNT(DISTINCT HCODOPE) sobre la población ajustada: claves base sin claves heredadas, más claves trasladadas al origen. | Operaciones | Sustituye la suma/resta de CAR07 por grupos: tipos de un mismo HCODOPE pueden superponerse. Resultado a resolver desde población antes de perder las identidades. |
| CAR10 | Meta de variación de saldo vigente | Meta mensual de variación de capital vigente para entidad/nivel; HCODVAR=9000. | PEN | Confirmado; solo base. Columna HMETVARVIG. Si se necesita meta stock, resultset suma CAR04 registrado en t−1 + CAR10, sin persistir otra meta. Mapeo por nivel V02. |
| CAR11 | Faltante de saldo contra meta | Meta de stock vigente derivada (CAR04 + CAR10) menos saldo vigente comparable; equivalente a meta de variación menos variación con la misma población. | PEN | RTABSEG01: (CAR04 + CAR10) − saldo vigente base de t, con signo (negativo = excedente; P21). No comparar CAR10 directamente con un stock. |
| CAR20 | Saldo “Propia” del gráfico | La captura usa Propia junto a Heredada y Trasladada. Propuesta: base − heredada para representar un segmento disjunto. | PEN | **Presentación pendiente V09**; total/vigente y apilamiento por confirmar. No es otra tabla de grupo. |
| CAR21 | Operaciones “Propia” del gráfico | Si se adopta esa presentación, COUNT(DISTINCT HCODOPE) de claves base no heredadas; no restar conteos finales. | Operaciones | **Presentación pendiente V09**. Un HCODOPE puede tener un tipo propio y otro heredado: los segmentos de operaciones pueden superponerse aunque los créditos lógicos no lo hagan. |

La captura muestra barras y totales cuya aritmética no se toma como definición.
Hasta cerrar V09, no sumar “Propia + Heredada + Trasladada” y llamarlo base actual.

### 4.2. Saldos medios diarios

**Población CM:** historia de las operaciones desde día 1 del mes hasta t,
incluyendo las que salieron durante el período. Saldo total según CAR01 y saldo
vigente según CAR02 **en cada fecha diaria**. Fuente HCDA001 y calendario F03.

- Denominador: días **calendario** transcurridos desde día 1 hasta t, inclusive.
- Feriados: saldo del último día vigente. Si día 1 es feriado, usar el último hábil
  del mes previo (cierre t−1).
- No arrastrar saldos de una salida real como si fuera una falta de proceso por
  feriado. No limitar el universo diario a operaciones supervivientes en t.
- **CM por entidad, sin pasar por la operación:** cada fila del snapshot se asigna
  a su asesor operativo y a la jerarquía de ese día; desde ahí se agregan los
  niveles. Un crédito partido aporta al vigente solo sus rubros VIGENTE. Sin fijar
  la historia al grupo de t ni a una última asignación; sin ajustes de movimientos.
- Solo en base; la versión para trasladados/heredados está diferida (DIF04).
- No es saldo por cliente ni ticket promedio. v0.3 lee los snapshots del mes una
  vez, agrupa por fecha y asesor, aplica la jerarquía y pondera por el calendario
  reducido a snapshots.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| CAR12 | Saldo medio total | Suma de saldos capitales diarios de CM / días calendario transcurridos. | PEN | Confirmado. Por entidad de cada fecha; solo en base, sin filtro de vigente para este saldo. |
| CAR13 | Saldo medio vigente | Suma de saldos diarios capital menos vencido, solo vigente, / mismos días calendario. | PEN | Confirmado. Por entidad de cada fecha; solo en base, excluir refinanciados de la población vigente cada día. |
| CAR14 | Variación del saldo medio total | CAR12 − saldo medio total ya registrado en t−1. | PEN | Comparación definida; RTABSEG01, sin recalcular el período anterior ni agregar columna de referencia al origen. |
| CAR15 | Variación del saldo medio vigente | CAR13 − saldo medio vigente ya registrado en t−1. | PEN | Comparación definida; usar el indicador registrado, no el saldo puntual de ese cierre. RTABSEG01. |

Ambos saldos medios se calcularán por acuerdo; elegir cuál ocupará la posición
“Saldo promedio” de la captura es presentación pendiente V09. La etiqueta correcta
es **Saldo medio**, no se conservará la denominación equivocada de la imagen.

### 4.3. Tasa y crecimiento

| ID | Nombre visible / resultado | Definición y fórmula | Población / unidad | Estado y consideraciones |
|---|---|---|---|---|
| CAR16 | TAPP stock total | SUM(HSALCAPMN × HNUMTAS) / SUM(HSALCAPMN) sobre C(t). | Capital total; tasa en % | Confirmado. Columna HTASSTKTOT; sin filtros FEN/HINDFID. Neto desde componentes internos. Usuario confirma denominador disponible. |
| CAR17 | Variación TAPP stock total | CAR16 − TAPP total ya registrada en t−1, en pbs. | Misma medida; pbs | RTABSEG01: tasas en fracción, diferencia × 10 000 (`_var_pbs`). Selección visual total/vigente V09. |
| CAR22 | TAPP stock vigente | SUM((HSALCAPMN − HSALVENMN) × HNUMTAS) / SUM(HSALCAPMN − HSALVENMN), por rubro y solo rubros VIGENTE, en conjunto con CAR02. | Capital menos vencido solo vigente; tasa en % | Confirmado. HTASSTKVIG. No incluir refinanciados ni copiar filtros de incentivos. Usuario confirma denominador disponible. |
| CAR23 | Variación TAPP stock vigente | CAR22 − TAPP vigente ya registrada en t−1, en pbs. | Misma medida; pbs | RTABSEG01, misma conversión que CAR17. Adicional para documentar ambas tasas; no aprueba otra posición visual. |
| CAR18 | Crecimiento neto de cartera | (CAR05 − CAR03) / CAR03. | Capital total; % | **Aprobado provisionalmente** como reemplazo de concentración. Cero/nulo V01. Numerador usa saldo ajustado, denominador stock anterior. |
| CAR19 | Variación neta del saldo total | CAR05 − CAR03. | Capital total; PEN | Componente derivado de CAR18; adicional para trazabilidad, no una nueva posición visual aprobada. |

No se incluyen concentración top 10 ni ratio de mora como reemplazo: ambos fueron
descartados para esta posición. CAR18, y no un indicador de mora, es el sustituto.

## 5. Clientes

### 5.1. Stock y movimientos

**Población L(s):** clientes de créditos elegibles de HCDA001 en s. Unicidad por
país/tipo/documento dentro de cada entidad y nivel, con filtros generales.
Si un cliente tiene créditos en varias entidades, pertenece a cada universo;
recalcular unicidad al subir de nivel. Fuente [F05](#f05--cartera-y-clientes).

**Grupos L:** base/trasladado/heredado se cuentan distintos dentro de cada grupo y
entidad. Un traslado de un crédito no retira al cliente del origen si conserva
otro allí. Las filas heredado/trasladado de la captura son ajustes y no categorías
disjuntas del stock actual. La conciliación exacta del movimiento visual, con
ingresos/salidas por pertenencia, requiere V09 para evitar doble neteo.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| CLI01 | Clientes al corte — “Hoy” | Clientes distintos de L(t), por entidad. | Clientes | Confirmado. La base actual incluye heredados; resultado ajustado no es sinónimo de stock. |
| CLI02 | Clientes al cierre anterior | Clientes distintos de L(t−1), por entidad. | Clientes | Confirmado; no planilla, cuentas ni operaciones. |
| CLI03 | Ingresos del mes | Clientes que no pertenecían a la entidad en t−1 y pertenecen en t. | Clientes | Confirmado. Reemplaza “Altas”. Puede incluir cambio de asignación: no equiparar con cliente nuevo financiero. Presentación y signos V09. |
| CLI04 | Salidas del mes | Clientes que pertenecían a la entidad en t−1 y no pertenecen en t. | Clientes | Confirmado. Reemplaza “Bajas”. No deducir salida si conserva otro crédito en la entidad. |
| CLI05 | Clientes heredados | Clientes distintos con créditos recibidos de otra entidad para el par de cortes; pueden estar ya en la entidad por otros créditos. | Clientes | Pertenencia múltiple confirmada. Conteo por grupo; el signo negativo del ajuste no vuelve negativo el conteo almacenado. V09 para movimiento visual. |
| CLI06 | Clientes trasladados | Clientes distintos asociados a créditos enviados a otra entidad; pueden conservar créditos con origen. | Clientes | Confirmado el conteo por grupo. Fuera del stock de créditos base del origen, pero no necesariamente fuera de su stock de clientes. V09. |
| CLI07 | Crecimiento neto de clientes | Clientes distintos de la población ajustada en t (HCLICARNET) − CLI02 registrado en t−1. | Clientes | Concepto acordado. La única resta es la variación t vs t−1; no sumar/restar conteos de grupos superpuestos (CLI01 + CLI06 − CLI05 sustituido por HCLICARNET). Renglones de movimientos V09. No usar este cálculo para retención. |
| CLI08 | Meta de variación de clientes | Objetivo mensual de variación para entidad/nivel; HCODVAR=10062. | Clientes | Confirmado; solo base. Columna HMETVARCLI. Meta stock en resultset = CLI02 registrado en t−1 + CLI08, no otra columna almacenada. Mapeo por nivel V02. |
| CLI09 | Avance absoluto de clientes | Resultado de crecimiento utilizado para contrastar CLI08. | Clientes | Reutiliza CLI07 si se confirma ese contraste; no contar como otra métrica física por mostrarla dos veces. V02/V09. |
| CLI10 | Avance porcentual contra meta de clientes | CLI09 / CLI08. | % | Propuesta de presentación; cerrar comparabilidad, cero/nulo y límites, V01/V02. No es porcentaje de crecimiento sobre stock inicial. |
| CLI11 | Faltante de clientes | CLI08 − CLI09. | Clientes | Diferencia contra meta; V01/V02 para si se recorta a cero o se muestra excedente. |

### 5.2. Nuevos y bancarizados

**Población N:** nuevos preliminares de HBCN001 frente al histórico HBCA001,
cruzados con desembolsos para obtener nuevos reales. No confundir con entradas
CLI03 ni con operación solo presente en t. Tipología del productor de referencia
incluye repetidos/recuperados, pero no crea nuevas posiciones visuales por sí sola.

**Población B:** mantener cálculo de bancarizados de HRESINC003 con RCC y desfase
t−2; no sustituirlo por información del corte actual. Mapeo completo de fechas y
relación entre HBCB001 y la preparación bancaria: V03. Fuentes F02/F05.

**Grupos N/B:** respetar atribución de los créditos y clientes distintos por nivel;
las variantes de incentivos no aprueban filtros adicionales. Neteo de vistas según
reglas comunes; comparaciones deben usar población equivalente.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| CLI12 | Clientes nuevos | Clientes nuevos reales de N del período, distintos por entidad/nivel. | Clientes | Concepto confirmado; completar mapeo histórico y cruce exacto F05, V03. Sin filtro redundante CA/CC de HBCA001. |
| CLI13 | Variación de clientes nuevos | CLI12 − clientes nuevos ya registrados en t−1. | Clientes | Definido. RTABSEG01; no recalcular acumulados de otro período. |
| CLI14 | Clientes bancarizados | Conteo distinto de B atribuido a la entidad, siguiendo cálculo de HRESINC003. | Clientes | Cálculo de referencia/desfase confirmados, no definir como todo cliente con crédito ni confundir corte RCC con fecha de presentación. V03. |
| CLI15 | Variación de bancarizados | CLI14 − bancarizados ya registrados en t−1. | Clientes | Comparación definida en resultset. V03 se limita al mapeo fuente/histórico del indicador, no al período de comparación. |

### 5.3. Retención y churn

**Población K:** clientes del stock t−1 con pertenencia ajustada por movimientos
en t: retirar los que dejaron la entidad por traslado e incorporar heredados de
ese mismo stock inicial. Resolver conjuntos por identidad y créditos, no restar
conteos superpuestos. Un cliente puede pertenecer a varias entidades. Los
desembolsos de t no participan en K hasta pasar al stock inicial del mes
siguiente (tampoco mantienen en el origen a un cliente cuyo crédito se trasladó);
sí cuentan para retenidos, como stock de clientes en t. Un crédito que sale lleva
al cliente a la entidad del titular a la salida.

**Grupos K:** el ajuste por traslados se aplica a la cohorte, después se calcula la
razón por entidad. No netear porcentajes de las tres tablas. Los nuevos clientes
del mes no compensan pérdidas de esta cohorte. Fuente HCDA001 y asignaciones, F05.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| CLI16 | Retención | CLI19 / CLI18; equivale a 1 − CLI20. Entidad sin cartera de inicio ni cohorte heredada: 100 %; cohorte vacía con cartera de inicio: NULL. | % | Confirmado. Cero clientes en t−1 no acredita que sea nuevo; puede tener cartera en t−2. Con cohorte heredada aplicar lógica regular. Excepción de ratio en RTABSEG01; conteos reales en origen. |
| CLI17 | Variación de retención | Retención actual − retención correspondiente a los valores ya registrados en t−1. | Puntos porcentuales | RTABSEG01; no reconstruir la cohorte del período anterior. Si razones son fracciones, diferencia ×100 para pp. |
| CLI18 | Base inicial de retención — HCLIRETINI | Número de clientes distintos del conjunto K de la entidad. | Clientes | Confirmado; auxiliar, no visible en captura. Sustituye HCLICOHAJU. No incluir desembolsos del mes ni usar stock final como denominador. |
| CLI19 | Clientes retenidos — HCLIRETFIN | Clientes de K que siguen perteneciendo a la cartera de la entidad en t, también por créditos desembolsados en el mes. | Clientes | Confirmado; auxiliar, no visible. Sustituye HCLIRET. No cuenta ingresos ajenos a K. |
| CLI20 | Churn | (CLI18 − CLI19) / CLI18; entidad sin cartera de inicio ni cohorte heredada: 0 %. | % | Confirmado por complemento de retención; auxiliar, no nueva posición visual aprobada. Con heredados evaluar normalmente, según CLI16. |

Ejemplo sintético sin movimientos: 100 iniciales, 20 pérdidas y 40 nuevos dan
120 finales, 80 retenidos, retención 80 % y churn 20 %. No 120 % de retención.

### 5.4. Digital: enrolamiento y usabilidad (reemplaza Desempeño)

Panel propio del reporte, en el lugar de Desempeño. Se cataloga junto a Clientes
porque comparte población (L(t)), identidad, asignación y denominador (CLI01).
Reglas de CWWAPPCLI001/CWWACLI008 y del reporte RSTABCOMER (F08), recalculadas
sobre los clientes distintos del tablero en lugar de leer WACLI008, que se vacía
en cada ejecución y solo guarda siete fechas.

- **Enrolado:** cliente de L(t) cuyo primer registro en HISLOGAPP001 (vista
  VLCAPP001; HFETRX texto YYYY-MM-dd) es ≤ t. Acumulado: no hay desenrolamiento.
- **Transaccional:** cliente enrolado con al menos una transacción en HTDA001 del
  snapshot HFECPRO = t con HFEC entre el día 1 y t. Cada snapshot acumula el mes
  e incorpora transacciones tardías de días previos. Canales app y homebanking y
  HEMPLEAD S/N sin filtrar, como el productor. En el tablero visual el conteo se
  llama "Transaccionales" y sus porcentajes, "Usabilidad", el término de la red
  (`num_usab`, `percent_usa`, `percen_usa_cart` de RSTABCOMER).
- **Nombres visibles (acordados 2026-10-17):** DIG05 Transaccionales; DIG07
  Usab. enrolados; DIG08 Var. usab. enrol.; DIG09 Usab. cartera; DIG10 Var. usab.
  cart.; DIG11 Cumpl. usab. enrol. / Cumpl. usab. cart. En tooltip o encabezado se
  repite el denominador ("sobre enrolados" / "sobre cartera") y la meta.
- **Llave:** las fuentes digitales no traen país (HISLOGAPP001 solo
  CONCAT(tipo, documento)); un mismo documento con dos países recibe la misma marca.
- **Monetario y pago digital:** solo filas `HTIPTRAX = 'S'`; las monetarias se
  replican como `N` y sumar ambas duplica. El pago de crédito exige `HTIPTRAX =
  'S'` y `HCODPROC = 5`, porque HCODPROC repite códigos entre S y N con otro
  significado ([VD03](pendientes.md#7-validaciones-con-datos-realizadas)).
- **Subconjuntos:** toda marca exige enrolamiento a t: pago digital ⊆ monetario ⊆
  transaccional ⊆ enrolado ⊆ cartera; nuevos ⊆ enrolados.
- **Grupos:** base, traslados y heredados, como CLI01: el cliente trasladado lleva
  su marca a origen y destino. Sin columnas NET.
- **Limitaciones y alertas:** sin país (L01), transacciones tardías entre meses
  (L02), colisión de la llave (L03), transaccional amplio (L04) y diferencias
  con RSTABCOMER y otros reportes (A02–A07) en [pendientes.md](pendientes.md).

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado y consideraciones |
|---|---|---|---|---|
| DIG01 | Clientes enrolados — HCLIENR | Clientes distintos de L(t) enrolados a t, por entidad/nivel/grupo. | Clientes | Confirmado. Lectura de HISLOGAPP001 completa: pendiente tabla de únicos (cliente, primera fecha). |
| DIG02 | Variación de enrolados | DIG01 − DIG01 registrado en el cierre t−1. | Clientes | Resultset, como RSTABCOMER (cmg_6 frente a cmg_5 = cie_ant). |
| DIG03 | % enrolamiento | DIG01 / CLI01 (HCLICAR). | % | Confirmado con denominador propio, no WJAS001.HNUMCLI del reporte actual. Cero clientes: 0. |
| DIG04 | Variación de % enrolamiento | DIG03 actual − DIG03 de los conteos registrados en t−1. | pp | Resultset. |
| DIG05 | Transaccionales — HCLITRX | Clientes de DIG01 con transacción en el mes según el snapshot de t. | Clientes | Confirmado. Transacción del mes anterior que llegue ya en el mes nuevo no cuenta en ninguno. |
| DIG06 | Variación de transaccionales | DIG05 − DIG05 registrado en t−1. | Clientes | Resultset. |
| DIG07 | Usab. enrolados (usabilidad sobre enrolados) | DIG05 / DIG01. | % | Meta HMETTRXENR = 20,5 % fija (RSTABCOMER). Cero enrolados: 0. |
| DIG08 | Var. usab. enrol. | DIG07 actual − DIG07 de t−1. | pp | Resultset. |
| DIG09 | Usab. cartera (usabilidad sobre cartera) | DIG05 / CLI01. | % | Meta HMETTRXCAR = 9 % fija (RSTABCOMER). Cero clientes: 0. |
| DIG10 | Var. usab. cart. | DIG09 actual − DIG09 de t−1. | pp | Resultset. |
| DIG11 | Cumpl. usab. enrol. / Cumpl. usab. cart. (semáforo) | % / meta para DIG07 y DIG09; ≥ 1 verde, < 0,9 rojo, resto ámbar. | % | Regla de RSTABCOMER; meta 0 o NULL → cumplimiento 0. En RTABSEG01. Metas VDMCOM01 10251/10252 documentadas, pendientes de activar (P09). |
| DIG12 | Nuevos enrolados — HCLIENRNUE | Clientes de DIG01 cuya primera fecha de enrolamiento está entre el día 1 y t. | Clientes | Confirmado. Equivale a "altas" de GRTABAPPO01. |
| DIG13 | % nuevos enrolados | DIG12 / CLI01. | % | Resultset. Cero clientes: 0. |
| DIG14 | Transaccionales monetarios — HCLITRXMON | Clientes de DIG05 con al menos una transacción `HTIPTRAX = 'S'` en el mes. | Clientes | Confirmado. Equivale a HNUMUSMO de CWWACLI008; medida estricta frente a L04. |
| DIG15 | % monetarios sobre enrolados | DIG14 / DIG01. | % | Resultset. Sin meta. |
| DIG16 | Clientes con pago de crédito digital — HCLIPAGDIG | Clientes de DIG14 con `HTIPTRAX = 'S'` y `HCODPROC = 5` (PAGO DE CREDITO) en el mes. | Clientes | Confirmado. Sin filtro de canal; hoy solo app (A07). Detalle: HINDPAGDIG. |
| DIG17 | % pago digital sobre cartera | DIG16 / CLI01. | % | Resultset. Sin meta. |
| DIG18 | Transacciones monetarias — HNUMTRXMON | Suma de `HTOTINTE` de filas `S` del mes de los clientes de DIG14, una vez por cliente y entidad. | Transacciones | Confirmado. No es aditiva entre traslados y heredados: el cliente movido aporta a ambos. |
| DIG19 | Transacciones monetarias por cliente | DIG18 / DIG14. | Transacciones | Resultset, como PROMETRANSMONE de GRTABAPPO01. Cero monetarios: 0. |

## 6. Seguros

Pólizas, productos, meta, penetración de optativos y sin venta de optativos definidos con el usuario el
2026-10-16 sobre la fuente de los reportes "Seguro Optativo" (GRESREPSEG_01) y
"Tablero Seguros Asesor" (RSEGASE01), [F07](#f07--seguros). Ingresos y ticket
prima siguen **diferidos**: no hay prima ni comisión utilizable
([VD08](pendientes.md#7-validaciones-con-datos-realizadas)).

- **Fuente:** solo la foto diaria de pólizas `com_seg.HCDS001` del corte; no se
  lee ninguna tabla resumida. Se replica la lógica del productor de SDSF001
  (PSLSDSF001 sobre VCSH001/VCSH002) para su nivel asesor + seguro.
- **Carga:** segundo paso, después de la cartera, porque HCDS001 llega más tarde
  ([05_seguros.sql](05_seguros.sql), [README §1.3](README.md#13-carga-de-seguros-segundo-paso), R40).
  Hasta entonces todas las columnas de seguros (incluida HMETPLZ y HINDSEG) son
  NULL: el resultset debe mostrarlas como pendientes, no como cero. Seguros solo
  actualiza filas de cartera; no crea entidades (L13).
- **Población:** pólizas **optativas** con estado VIGENTE/ACTIVO, emitidas
  (`HFEMI`) desde el día 1 del mes y, si su operación tiene corrección en
  RFOC001, con alguna fecha corregida en el mes; sin corrección o sin operación,
  se incluyen. Conteo: pólizas distintas (`HNROPLZ`) por fecha de emisión,
  vendedor, seguro e indicador de cuota pagada, sumadas después. Desgravamen
  (813, 819, 820, 821) no es optativo; otros códigos sin producto en ningún
  reporte se excluyen con incidencia `SEGURO_SIN_PRODUCTO` (alerta A09).
- **Atribución:** asesor que vendió (`HUSCOL` → `SCODSEC`) y su jerarquía del
  corte; '0', '--' y vacío = ''. Sin jerarquía, -999. **Solo base**: no hay
  traslados ni heredados de pólizas (L09).
- **Productos (códigos de "Seguro Optativo", con 828 en Oncológico):**
  Multirriesgo 200/220/230; Protección de cuota 802/824; Vida Segura 803/817
  (RSEGASE01 lo llama "Múltiple Crédito"); Oncológico 814/828; Agropecuario
  806/815/825; Protección total 822.

| ID | Nombre visible / resultado | Definición y fórmula | Unidad | Estado / consideración |
|---|---|---|---|---|
| SEG01 | Ingresos | Prima, comisión o ingreso reconocido; período y conversión. | PEN | **Diferido** (DIF01). HCDS001 trae prima casi siempre vacía y comisión 0 (VD08). |
| SEG02 | Meta de ingresos | Objetivo comparable con SEG01. | PEN | **Diferido**, depende de SEG01. |
| SEG03 | Avance de ingresos | SEG01 / SEG02. | % | **Diferido**. |
| SEG04 | Pólizas totales — HNUMPLZ | Suma de pólizas optativas del mes por entidad (población de arriba). | Pólizas | Confirmado. Igual a la suma SEG07–SEG12. |
| SEG05 | Meta de pólizas — HMETPLZ | VDMCOM01 HCODVAR = 5001, HTIPMETA = 1: publicada para asesor (2→1) y coordinación (17); en niveles sin meta publicada, suma de metas de asesor por la jerarquía del corte. | Pólizas | Confirmado; suma provisional (P16), como GRESREPSEG_01. Una meta publicada prevalece sobre la suma. |
| SEG06 | Avance de pólizas | SEG04 / SEG05. | % | Resultset. Meta NULL → sin avance. |
| SEG07 | Multirriesgo — HPLZMUL | SEG04 de códigos 200/220/230. | Pólizas | Confirmado. |
| SEG08 | Protección de Cuota — HPLZPCU | SEG04 de códigos 802/824. | Pólizas | Confirmado. |
| SEG09 | Vida Segura — HPLZVID | SEG04 de códigos 803/817. | Pólizas | Confirmado. |
| SEG10 | Oncológico — HPLZONC | SEG04 de códigos 814/828. | Pólizas | Confirmado. RSEGASE01 omite 828 (A08). |
| SEG11 | Agropecuario — HPLZAGR | SEG04 de códigos 806/815/825. | Pólizas | Confirmado. |
| SEG12 | Protección Total — HPLZPTO | SEG04 de código 822. | Pólizas | Confirmado. |
| SEG13 | Penetración de optativos | HOPEDESSEG / HOPEDES: operaciones desembolsadas en t con al menos una póliza optativa vigente/activa en la foto HCDS001 del corte, sobre operaciones desembolsadas. | % | Confirmado (opción C, P15). Máximo 100 %. Población y grupos de desembolsos (con traslado/heredado). Detalle: HINDSEG. Cero desembolsos: NULL (P21). |
| SEG14 | Sin venta de optativos — HASESINVTA | Asesores con cartera en t (base de la entidad) sin pólizas optativas en el mes. | Asesores | Confirmado (P17). En el asesor vale 0/1; el asesor vacío no cuenta. |
| SEG15 | Ticket prima | Prima / póliza. | PEN por unidad | **Diferido** (DIF01): sin prima utilizable (VD08). |

## 7. Cobertura visual y cambios de etiquetas

Cada elemento de datos de la captura tiene un destino documental. Un grupo
base/trasladado/heredado identifica la tabla agregada correspondiente; no se
triplican fichas idénticas ni se inventan columnas con sufijos por cada grupo.

| Tarjeta / elemento visual | Fichas | Cambio o precisión |
|---|---|---|
| Desembolsos: operaciones, meta y barra | DES01–DES05 | Distinguir conteo y productividad a niveles superiores. |
| Desembolsos: monto, meta y barra | DES06–DES08 | Meta y su avance diferidos. |
| Marcador “Días hábiles” | DES09–DES11 | RDIAFER=0; avance hasta corte efectivo inclusive. Los dos contadores se guardan solo en base (HDIAHABTOT/HDIAHABAVA). |
| Ticket, TAPP mes y mínima | DES12–DES14 | Ponderar montos; no sumar tasas por grupo. |
| Recuperación: monto efectivo/programado/% | REC01–REC03 | Sustituir denominación “exigible” por programado. |
| Recuperación: operaciones efectivas/programadas/% | REC04–REC06 | Elegibilidad por clave lógica; reporte COUNT(DISTINCT HCODOPE) sobre cada población. |
| Dos efectividades y sus metas | REC07–REC10 | REC11/REC12 son adicionales, no visibles. |
| Clientes y saldo en mora, con variaciones | REC13–REC16 | Variaciones base t−1/t sin neteo. |
| Ingresos a mora: operaciones y monto | REC17/REC18 | Transición por operación, no diferencia de stocks. |
| Castigos, ventas y cancelaciones | SAL01–SAL08 | Adicionales, no visibles en la captura. Titular a la salida con traslado/heredado; total de salidas en el reporte. |
| Cartera: saldo actual, anterior y grupos | CAR01–CAR06, CAR20 | La captura rotula saldo vigente; se calcula también total. “Propia” no es la base completa. |
| Cartera: operaciones actuales, anteriores y grupos | CAR07–CAR09, CAR21 | Población/apilamiento por cerrar V09. |
| Cartera: meta y faltante | CAR10/CAR11 | Meta de variación vigente 9000; meta stock = vigente t−1 + meta variación, calculada en resultset. |
| “Saldo promedio” y su variación | CAR12–CAR15 | Renombrar a saldo medio; calcular total y vigente. |
| TAPP stock y variación pbs | CAR16/CAR17, CAR22/CAR23 | Calcular total y vigente; comparar valores registrados en t−1 en RTABSEG01. Elección de presentación V09. |
| “Concentración / Top 10” | CAR18; CAR19 auxiliar | Reemplazada por crecimiento neto de cartera. Sin nuevo ratio de mora. |
| Clientes: hoy y cierre anterior | CLI01/CLI02 | Stock distinto por entidad. |
| Clientes: “Altas”, “Bajas”, heredados y trasladados | CLI03–CLI06 | Renombrar Ingresos/Salidas; no doble netear movimientos. |
| Crecimiento neto, avance, meta y faltante | CLI07–CLI11 | Separar resultado absoluto de cumplimiento porcentual. |
| Nuevos y variación | CLI12/CLI13 | Nuevos reales, no ingresos de entidad. |
| Bancarizados y variación | CLI14/CLI15 | Mantener desfase RCC. |
| Retención y variación pp | CLI16/CLI17; CLI18–CLI20 auxiliares | Cohorte t−1 ajustada, no stock final/inicial. |
| Seguros: ingresos, meta y barra | SEG01–SEG03 | Diferido (sin fuente de ingreso). |
| Seguros: total, meta, barra y seis productos | SEG04–SEG12 | Pólizas optativas del asesor vendedor; solo base. |
| Seguros: penetración, sin venta y ticket prima | SEG13–SEG15 | Se rotulan "Penetración de optativos" y "Sin venta de optativos" (excluyen desgravamen); confirmados; ticket prima diferido. |
| Desempeño | Fuera del catálogo activo | Excluido del alcance; su lugar lo ocupa Digital. |
| Digital: enrolados, nuevos, transaccionales, monetarios, pago digital, transacciones, % y semáforos | DIG01–DIG19 | Reemplaza Desempeño; denominador CLI01. |

Leyendas, títulos y enlaces “Ver detalle” no son variables numéricas. La identidad
del asesor en Desempeño tampoco incorpora esa tarjeta al alcance. Los signos y
colores de variaciones requieren reglas de presentación; no se infieren de los
valores de ejemplo.

## 8. Pendientes vinculados a variables

La tabla V01–V12 se trasladó a [pendientes.md](pendientes.md#22-por-variable),
junto con diferidos (DIF), pendientes generales (P), limitaciones aceptadas (L),
alertas de cuadre (A), incidencias y validaciones con datos. Los IDs no cambian.

**Diferidos explícitos:** SEG01–SEG03 y SEG15 (DIF01), DES07/08 (DIF02), identificación de
condonaciones para REC02/05 (DIF03) y Desempeño (DIF06); resto en
[pendientes.md](pendientes.md) §1 (DIF04, DIF05, DIF07–DIF09). No diferir por extensión
los indicadores de monto desembolsado ni las recuperaciones que sí tienen
definición vigente.

## 9. Fuentes de referencia

### F01 — Desembolsos

- [PSLHCMA001](../../serv_models/serv30/objects/storage/procedures/com_act.PSLHCMA001.sql):
  filtros, fecha corregida, monto y alcance mensual de HCMA001.
- [PSLHCTC001](../../serv_models/serv30/objects/storage/procedures/com_act.PSLHCTC001.sql):
  referencia de asesor al desembolsar/corte y movimientos; no copiar excepciones
  de fechas fijas ni normalización incompleta.

### F02 — Productor y consumidor de incentivos

- [PSLHRESINC003](../../serv_models/serv30/objects/storage/procedures/com_act.PSLHRESINC003.sql).
- [GRESINC08](../../serv_models/serv30/objects/mod_app/procedures/inc.GRESINC08.sql).
- Sus columnas/formulaciones son referencias; no heredar FEN, HINDFID, población
  con meta ni nombres de variantes N sin contrastarlos con las reglas del tablero.

### F03 — Calendario

- [RCALEN001: metadata](../../serv_models/serv30/objects/storage/tables/ref.RCALEN001/metadata.md).
- [FVECFEC01](../../serv_models/serv30/objects/storage/functions/util.FVECFEC01.sql):
  último hábil <= referencia (líneas 88–96). PSLHRESINC003 líneas 19–30 resuelve
  ayer solo en NOW/omisión; no restar un día a una fecha explícita. Guardar solo t.
- El tablero resuelve t, t−1, t−2 y t−3 con FVECFEC01('hoy,cie_ant,cie_ant+2,cie_ant+3'),
  como PSLHRESINC003; `cie_ant` coincide con RCIEBT=1. RDIAFER para hábiles/feriados.
  Días calendario para saldo medio y días hábiles para el marcador de avance son
  denominadores distintos.

### F04 — Recuperación y efectividades

- HCDA001 t−1/t y fuentes de salidas para recuperación programada/efectiva.
- [PSLSDAE002](../../serv_models/serv30/objects/storage/procedures/com_act.PSLSDAE002.sql),
  SDAE002/003/004, VCEI001/VCEF001 y F02 para efectividades. Parametrizar sus
  fuentes históricas; no depender de vistas con cortes actuales/fijos.
- Castigos: HCCA001 (fuente de VCCH001/PSLSDAS002). Ventas: HRVC001 (#RCV de
  PSLHRESINC003). Ambos con importe y asesor propios.

### F05 — Cartera y clientes

- [HCDA001: metadata](../../serv_models/serv30/objects/storage/tables/com_act.HCDA001/metadata.md).
- [PSLHBCN001](../../serv_models/serv30/objects/storage/procedures/com_act.PSLHBCN001.sql),
  HBCN001, HBCA001, HBCB001 y F02: nuevos y bancarización.
- Jerarquías: FJERCOR02 como fuente oficial, igual que WJERCOR03. Sus reglas de
  fecha resuelven los movimientos inferiores; corredor/territorio vigentes
  recomponen la lectura histórica. Criterio confirmado R23 en consideraciones.md.
  Se carga la salida completa por fecha. Para desembolsos: origen en cierre
  anterior/destino en corte; para bancarizados t−2: origen t−3/destino t−2 (R24).
  Faltantes comunes -999 por nivel agregado, sin entidades artificiales por asesor
  (R27). Vencimientos del detalle separados ANT/ACT, sin COALESCE (R25).

### F06 — Metas y reportes

- VDMCOM01 y sus fuentes; HTIPMETA=1 y mes de referencia. HCODVAR 9000 es meta
  de variación vigente; 10062, variación de clientes. HCODVAR 8070,
  126, 122 y 124 son referencias identificadas para las fichas respectivas.
- PSLHRESINC003 líneas 1309–1318 y GRESINC08 líneas 33–56: extracción de las
  dos metas de variación y comparación. No convertirlas en stock sin sumar el
  valor de t−1 en el resultset. Falta correspondencia del nivel 17 en la extracción.
- [RSSALCAR03](../../serv_models/serv30/objects/mod_rep/procedures/com.RSSALCAR03.sql):
  niveles y referencias de metas.
- [GCMGCARTAS001](../../serv_models/serv30/objects/mod_rep/procedures/com.GCMGCARTAS001.sql):
  saldos y saldos medios total/vigente.
- [RSCMGFCA001](../../serv_models/serv30/objects/mod_rep/procedures/com.RSCMGFCA001.sql):
  variación mensual, productividad y otras referencias; los códigos no acreditan
  por sí solos selección de metas ni fórmulas del nuevo tablero.

### F07 — Seguros

- [GRESREPSEG_01](../../serv_models/serv30/objects/mod_rep/procedures/com.GRESREPSEG_01.sql)
  ("Seguro Optativo"): códigos por producto, meta 5001 sumada desde niveles
  inferiores y penetración del reporte por operaciones (SDAF002, RETP003; distinta de SEG13).
- [RSEGASE01](../../serv_models/serv30/objects/mod_rep/procedures/com.RSEGASE01.sql)
  ("Tablero Seguros Asesor"): pólizas por producto del asesor; omite 828.
- [PSLSDSF001](../../serv_models/serv30/objects/storage/procedures/com_seg.PSLSDSF001.sql)
  → SDSF001: cubo de pólizas vigentes/activas emitidas en el mes (VCSH001/VCSH002
  sobre la foto diaria HCDS001). **No se lee**: el tablero replica su lógica de
  `SCODAGR = 6` (asesor + seguro) directamente sobre HCDS001.
- HCDS001: foto diaria de pólizas por operación (HOPER), vendedor (HUSCOL),
  estado, emisión, código, cuotas pagadas y prima; **única fuente** de Seguros;
  base de la penetración de optativos por desembolso.
- ext.PEDC013: desgravamen Premium (819/813) y Plus (820/821).
- Documentación general de [storage](../../serv_models/serv30/objects/storage/docs/README.md).

### F08 — Digital

- [CWWACLI008](../../serv_models/serv30/objects/storage/procedures/com_act.CWWACLI008.sql)
  → WACLI008 (vaciada en cada ejecución; hoy, cierre anterior y cinco cierres):
  marcas por cliente/asesor HNUMENRO, HNUMUSAB, HNUMUSMO, HNUMUSNO.
- [CWWAPPCLI001](../../serv_models/serv30/objects/storage/procedures/com_act.CWWAPPCLI001.sql)
  → WAPPCLI001: enrolados acumulados desde VLCAPP001/HISLOGAPP001.
- HTDA001: transacciones de app y homebanking; partición mensual, PK
  (HFECPRO, HROWID); cada HFECPRO acumula el mes. HTIPTRAX S/N (monetaria /
  no monetaria), HCODPROC/HDESPROC, HTOTINTE (número) y HMONTO. Catálogo
  observado en [referencias/respuesta_a.csv](referencias/respuesta_a.csv).
- Otros consumidores revisados: [CWWJAS004](../../serv_models/serv30/objects/storage/procedures/com.CWWJAS004.sql)
  y [CWWJAS005](../../serv_models/serv30/objects/storage/procedures/com.CWWJAS005.sql)
  (pago de crédito y Plin por app),
  [CWWTRXMON001](../../serv_models/serv30/objects/storage/procedures/com_act.CWWTRXMON001.sql)
  (monetarias y recurrencia),
  [CWWRCOMPASDIG01](../../serv_models/serv30/objects/storage/procedures/com_act.CWWRCOMPASDIG01.sql)
  y [GRTABAPPO01](../../serv_models/serv30/objects/mod_rep/procedures/com.GRTABAPPO01.sql).
  Diferencias en [pendientes.md](pendientes.md#4-alertas-de-cuadre-con-otros-reportes-y-productores).
- [RSTABCOMER](../../serv_models/serv30/objects/mod_rep/procedures/com.RSTABCOMER.sql)
  (panel, vía piv.GPIVRES01) y
  [RSTABCOMER02](../../serv_models/serv30/objects/mod_rep/procedures/com.RSTABCOMER02.sql)
  (detalle por asesor; su usabilidad no exige enrolamiento, a diferencia del panel).
  Denominador WJAS001.HNUMCLI; metas fijas 0,205/0,09 con VDMCOM01 10251/10252 sin usar.

## 10. Mapeo al detalle y al agregado

Este mapeo organiza las **117 entradas documentales** (98 + DIG01–DIG19). CAR22 y CAR23 completan
la documentación de la segunda TAPP stock y su comparación; SAL01–SAL08 añaden
castigos, ventas y cancelaciones (v0.3). Se conservan los IDs anteriores para
mantener trazabilidad. Son conceptos, no 117 columnas. Esta etapa produce detalle y
tres tablas agregadas; la presentación/comparación va en el SP de reporte RTABSEG01. El esquema
v0.3 del [README](README.md) documenta las columnas generadas y distingue las
medidas de entidad de las medidas de movimientos.

### 10.1. Destinos y granularidad

| Destino | Significado | Implicación física |
|---|---|---|
| A | Medida agregada calculada desde poblaciones de créditos, clientes o historia. | No depende de la salida física de detalle. Candidata a campo del agregado; los auxiliares se identifican expresamente. |
| C | Cálculo/referencia/reutilización para presentación. | Comparativos desde t−1 registrado y cocientes desde componentes disponibles. No incluye conteos que necesitan identidades perdidas al agregar: CAR09 y la propuesta CAR21 pasan a A. |
| M | Meta mensual, solo base. | Obtener por fecha, nivel, entidad y concepto; mapeo por nivel V02. No sumarla por crédito ni crear sus columnas en movimientos. |
| F | Diferido. | No incorporar como campo implementado en esta etapa. |

**Los insumos son fuentes y auxiliares compartidos, no necesariamente columnas
de la tabla final de detalle.** Un monto individual alimenta DES06 y puede estar
en detalle para explicarlo; DES06 es su suma por entidad/grupo. La historia diaria
alimenta saldos medios sin exigir saldo medio por operación en detalle. El mapeo
D01–D09 organiza dependencias lógicas, no una cadena obligatoria detalle → agregado.

- Detalle: una fila por HCODOPE + HTIPOPE para t, con datos anteriores/actuales
  y flags explicativos. No saldos medios ni tasas ponderadas/productos ponderados;
  conservar las tasas individuales. Dos tipos hipotecarios pueden ser dos filas
  y una sola operación reportada.
- Agregados: **base, traslados y heredados**, cada tabla con clave HFECPRO +
  HTIPCOD + HCODREL. Sin HGRUREG físico ni familias de columnas O/D. Clasificar
  los movimientos en cada nivel; no crear filas de movimiento sin población.
- Referencias/comparaciones t−1: el SP de reporte RTABSEG01 **lee los agregados ya
  registrados**. No almacenar seis columnas anteriores ni recalcular historia
  comparativa en las tablas origen. Sí mantener los insumos anteriores del detalle
  necesarios para operaciones, recuperación y conjuntos de clientes.
- Clientes: deduplicar por identidad y entidad/nivel antes de contar. Para
  ingresos, salidas y cohorte, resolver pertenencia por conjuntos de créditos.
- Operaciones: filtrar/evaluar por clave lógica, después COUNT(DISTINCT HCODOPE).
  Para netos y niveles superiores, volver a contar sobre sus poblaciones, no
  sumar/restar conteos de grupos o entidades inferiores. Registrar esa medida
  de salida si el resultset no dispone de identidades; no reconstruirla allí
  mediante aritmética insuficiente de los tres conteos.
- Los cálculos ajustados de presentación combinan las tres tablas. No crear otra
  tabla/grupo de netos sin definición expresa ni confundir neto con stock actual.
- Metas solo en base. Ingresos/salidas por pertenencia y cohortes son medidas de
  entidad en base; no repartirlas mecánicamente por créditos de movimiento. Los
  conteos heredados/trasladados reutilizan clientes distintos en su tabla respectiva.
- Los contadores DES09/10 están en base (HDIAHABTOT/HDIAHABAVA); el porcentaje
  DES11 se calcula en RTABSEG01.

### 10.2. Insumos compartidos y detalle explicativo

Los códigos D01-D09 son referencias documentales de este mapeo, no nombres de
columnas ni tablas nuevas. Un bloque puede requerir varios campos físicos.

| Bloque | Insumos necesarios | Uso y reducción previa |
|---|---|---|
| D01: identidad y presencia | t efectivo, cierre t−1, HCODOPE, HTIPOPE, identidad del cliente, presencia en ambos cortes. | Una fila por clave lógica en detalle; reporte de operaciones solo por HCODOPE distinto. Sin otra fecha de ejecución almacenada. Conservar identidad por corte; no completar ausencias arbitrariamente. |
| D02: atribución | Asesor y jerarquía t−1/t; asesor al desembolsar con jerarquía del cierre anterior; asesor vacío normalizado. | Derivar entidades y grupos en cada nivel. La operación no se duplica en el detalle por cada nivel de reporte. FJERCOR02 completo por fecha, recomposición superior y faltantes -999 (R23/R24/R27); restantes contrastes históricos V03. |
| D03: filtros informativos | HINDTFC y atributos para FEN, HINDFID y presencia de meta según contrato. | Conservar en detalle sin excluir por ninguno de esos flags al agregar. Una marca de meta no sustituye el valor de la meta mensual. |
| D04: stock y mora | HSALCAPMN, HSALVENMN, HINDCAR, HDIAATR, HCUOPEN, HFECMOR y HNUMTAS aplicables; datos de ambos cortes y fechas necesarias para salidas. | Sumar saldos por operación antes del cruce; no sumar cuotas por rubro ni escoger estados/tasas arbitrariamente. Tasas stock total/vigente según fichas. |
| D05: desembolso | Elegibilidad, fecha corregida, monto convertido con RTCM001, tasa individual y mínima, asesor al desembolsar de D02. | Fuentes/auxiliares reducidos al grano necesario; alimentan agregados y detalle. No usar HTIPCMB intrames ni deducir desembolso de mera presencia solo en t. V04. |
| D06: recuperación y salidas | Pertenencia a R, importe p(o), pertenencia a E, motivo de salida, titular e importe a la salida, tipo C10 y exclusiones. | Derivar desde D04, la lectura intrames y fuentes de salidas reducidas por HCODOPE. Una operación reconoce p(o) una vez; condonaciones diferidas según V07. |
| D07: historia diaria | Filas de los snapshots del mes (asesor operativo, capital y vigente por rubro) y calendario. | Agregar por fecha/asesor y aplicar la jerarquía del día, sin pasar por la operación ni fijar atribución en t. Rama independiente del detalle final. Incluye operaciones solo intermedias; no forzarlas al FULL JOIN ni guardar saldo medio por operación en detalle. |
| D08: nuevos y bancarización | Identidad y elegibilidad de nuevo real; cruce con desembolso; resultado de bancarización con RCC t−2. | Relaciones reducidas por cliente y período antes de cruzar con créditos; contar cliente distinto al agregar. No sumar un flag por cada crédito del mismo cliente. |
| D09: efectividades | Bases operativas por tramo, saldo inicial, recuperado y mantenido efectivo según SCODAGR=3. | Reconstruir el grano operativo/atribución antes de agregar. Una tasa SDAE de entidad no se distribuye a sus créditos. Mapeo pendiente V08. |

Relaciones externas al grano operación: **calendario**, **metas mensuales** y
**pertenencias de clientes por entidad/nivel**. Se pueden resolver como conjuntos
intermedios de la consulta; esta clasificación no exige tablas persistentes nuevas.
Los flags de cohorte por crédito no sustituyen la construcción del conjunto K.

### 10.3. Desembolsos

| ID | Destino | Dependencia y operación de mapeo |
|---|---|---|
| DES01 | A | Fuentes D01/D02/D03/D05: COUNT(DISTINCT HCODOPE) de créditos elegibles por entidad/grupo. No depender de materializar el detalle. |
| DES02 | C | Asesor: reutilizar DES01. Arriba: DES01 / DES03; mismo universo atribuido. |
| DES03 | A | Auxiliar: asesores distintos de D02 sobre DES01 (asesor en t en base y heredado; al desembolsar en traslado y ajustada); no sumar conteos inferiores ni de grupos. Asesor vacío cuenta uno, sin filtro de meta. |
| DES04 | M | Solo base: meta mensual de productividad, referencia 8070; correspondencia nivel/entidad V02. |
| DES05 | C | RTABSEG01: asesor DES01 / DES04, arriba DES02 / DES04; meta 0 o NULL → NULL. Rótulo V05. |
| DES06 | A | D05: sumar monto elegible en PEN, con atribución D02 y filtros D03. |
| DES07 | F | Meta de monto; código pospuesto. |
| DES08 | F | Avance dependiente de DES07. |
| DES09 | A | Calendario: total hábiles del mes. Campo HDIAHABTOT en base, no aditivo entre entidades. |
| DES10 | A | Calendario: hábiles desde inicio del mes hasta t efectivo inclusive. Campo HDIAHABAVA en base. |
| DES11 | C | DES10 / DES09; marcador común, no suma por entidad/grupo. |
| DES12 | C | DES06 / DES01; si operaciones 0, ticket 0. Para neto, monto ajustado y HCODOPE distintos de la población ajustada, no suma/resta de conteos. |
| DES13 | A | D05: calcular tasa ponderada al agregar; sin desembolsos 0. Componentes internos no persistidos; no sumar tasas finales. |
| DES14 | A | D05: mínima ponderada con sus excepciones; sin desembolsos 0 según F02. Componentes internos como DES13. |

### 10.4. Recuperaciones y Mora

| ID | Destino | Dependencia y operación de mapeo |
|---|---|---|
| REC01 | A | D06: sumar p(o) de R, fija para todo el mes; HSALRECPRO. |
| REC02 | A | D06: sumar el mismo p(o) solo en E, una vez; HSALRECEFE. Salidas V07. |
| REC03 | C | REC02 / REC01; asesor sin cartera de inicio y sin importe programado: 100 %. Importes origen 0. |
| REC04 | A | Auxiliares D01/D06: COUNT(DISTINCT HCODOPE) en R; HOPERECPRO. |
| REC05 | A | Auxiliares D01/D06: COUNT(DISTINCT HCODOPE) en E; HOPERECEFE. |
| REC06 | C | REC05 / REC04; asesor sin cartera de inicio y sin operaciones programadas: 100 %. Conteos origen 0. |
| REC07 | A | D09: razón de componentes de efectividad del tramo -30 a 0. No derivar de REC01/02. |
| REC08 | M | Solo base: meta mensual de REC07, referencia 126; mapeo por nivel V02. |
| REC09 | A | D09: razón de componentes del tramo 1 a 30. |
| REC10 | M | Solo base: meta mensual de REC09, referencia 122; mapeo por nivel V02. |
| REC11 | A | D09: razón de componentes del tramo 31 a 60; inclusión visual V12, no diferido por defecto. |
| REC12 | M | Solo base: meta mensual de REC11, referencia 124; V02/V12. |
| REC13 | A | D01/D02/D03/D04: clientes distintos con crédito en M(t), por entidad/nivel/grupo. |
| REC14 | C | REC13 base t menos su equivalente base t−1; sin neteo. No sumar clientes de grupos. |
| REC15 | A | D04: sumar capital completo solo de operaciones de M(t). |
| REC16 | C | REC15 base t menos su equivalente base t−1; sin neteo. |
| REC17 | A | Auxiliar D01/D04: transición por clave lógica; después COUNT(DISTINCT HCODOPE) de créditos que cumplen. Asesor de t con traslado/heredado. |
| REC18 | A | D04: sumar capital t de las mismas operaciones de REC17. |
| SAL01 | A | D06: COUNT(DISTINCT HCODOPE) de salidas con motivo castigo, en el titular a la salida; NET en base. |
| SAL02 | A | D06: suma del importe HCCA001 convertido, una vez por HCODOPE. |
| SAL03 | A | D06: COUNT(DISTINCT HCODOPE) de salidas con motivo venta; NET en base. |
| SAL04 | A | D06: suma del importe HRVC001, una vez por HCODOPE. |
| SAL05 | A | D06: COUNT(DISTINCT HCODOPE) de cancelaciones anticipadas (C10); NET en base. |
| SAL06 | A | D06: suma del capital del último snapshot de SAL05. |
| SAL07 | A | D06: COUNT(DISTINCT HCODOPE) de cancelaciones contractuales (C10); NET en base. |
| SAL08 | A | D06: suma del capital del último snapshot de SAL07. |

REC07/09/11 son medidas agregadas, aunque matemáticamente sean cocientes:
sus componentes no son otras fichas del catálogo. Deben calcularse internamente
en la consulta; van solo en base, con la entidad de t−1. No sumar las tasas de
grupos ni persistir sus componentes como variables finales por este mapeo.

### 10.5. Cartera y Clientes

| ID | Destino | Dependencia y operación de mapeo |
|---|---|---|
| CAR01 | A | D04: suma capital en C(t); HSALCIE. |
| CAR02 | A | D04: suma capital menos vencido de los rubros vigentes en C(t); HSALCIEVIG. |
| CAR03 | C | Resultset: leer CAR01 ya registrado en base t−1, sin reconstruirlo ni almacenarlo otra vez. |
| CAR04 | C | Resultset: leer CAR02 ya registrado en base t−1; también se usa para meta stock vigente derivada. |
| CAR05 | C | CAR01 base + trasladado - heredado; no otro campo de saldo fuente. |
| CAR06 | C | CAR02 base + trasladado - heredado. |
| CAR07 | A | Fuentes D01/D04: COUNT(DISTINCT HCODOPE) del stock elegido; población visual V09. |
| CAR08 | C | Resultset: leer CAR07 ya registrado en t−1, sin otra columna anterior en base. |
| CAR09 | A | Contar HCODOPE distintos tras ajustar claves lógicas. Resolver desde auxiliares para exponer al resultset, no restar conteos CAR07. |
| CAR10 | M | Solo base: meta de variación vigente 9000; HMETVARVIG. No almacenar meta de stock. |
| CAR11 | C | RTABSEG01: (CAR04 registrado en t−1 + CAR10) menos saldo vigente base de t, con signo (negativo = excedente; P21). |
| CAR12 | A | D07: sumar aportes diarios de capital por asesor operativo / días calendario transcurridos; no promedio simple de operaciones. |
| CAR13 | A | D07: sumar aportes diarios de capital menos vencido de rubros vigentes / mismo denominador. |
| CAR14 | C | Resultset: CAR12 menos CAR12 ya registrado en t−1. No recalcular historia anterior. |
| CAR15 | C | Resultset: CAR13 menos CAR13 ya registrado en t−1. |
| CAR16 | A | D04: ponderar tasa por capital total sobre C(t); HTASSTKTOT. Componentes internos no persistidos. |
| CAR17 | C | Resultset: CAR16 menos CAR16 registrado en t−1, conversión a pbs; escala V01. |
| CAR18 | C | (CAR05 - CAR03) / CAR03; aprobación provisional vigente. |
| CAR19 | C | CAR05 - CAR03; reutilizar numerador de CAR18. |
| CAR20 | C | Presentación propuesta CAR01 base - heredado, o equivalente vigente si se define así; V09. No nuevo grupo. |
| CAR21 | A | Candidata si se adopta la presentación V09: contar HCODOPE distintos de claves base no heredadas; no CAR07 base - heredado. Clasificación técnica no implica aprobación visual. |
| CAR22 | A | D04: ponderar tasa por capital menos vencido de los rubros vigentes; HTASSTKVIG. Componentes internos no persistidos. |
| CAR23 | C | Resultset: CAR22 menos CAR22 registrado en t−1, conversión a pbs; escala V01. |
| CLI01 | A | D01/D02/D03: clientes distintos de L(t) por entidad/nivel/grupo. |
| CLI02 | C | Resultset: leer clientes de base t−1 ya registrados; también para meta stock de clientes derivada. |
| CLI03 | A | Conjuntos de pertenencia D01/D02: L(t) menos L(t−1) por entidad; cardinalidad, no diferencia de conteos. |
| CLI04 | A | Conjuntos de pertenencia: L(t−1) menos L(t) por entidad. |
| CLI05 | C | Reutilizar CLI01 de tabla heredados: clientes distintos de créditos recibidos; no otra columna en base. |
| CLI06 | C | Reutilizar CLI01 de tabla traslados: clientes distintos de créditos enviados; no otra columna en base. |
| CLI07 | C | HCLICARNET de base t − CLI02 registrado en t−1; conciliación visual V09. No sustituye el cálculo de retención. |
| CLI08 | M | Solo base: meta de variación de clientes 10062; HMETVARCLI. Meta stock se deriva con CLI02 en resultset. |
| CLI09 | C | Reutilización de CLI07 si se confirma que es el resultado comparable con CLI08. |
| CLI10 | C | CLI09 / CLI08; no porcentaje sobre stock inicial. |
| CLI11 | C | CLI08 - CLI09; tratamiento de excedente V01/V02. |
| CLI12 | A | D08 con D05: clientes nuevos reales distintos por entidad/nivel; no sumar flags de sus créditos. |
| CLI13 | C | Resultset: CLI12 menos CLI12 ya registrado en t−1. |
| CLI14 | A | D08: clientes bancarizados distintos atribuidos, conservando desfase RCC t−2. |
| CLI15 | C | Resultset: CLI14 menos CLI14 ya registrado en t−1, sin reconstruir ese indicador. V03 solo para fuente del cálculo actual. |
| CLI16 | C | CLI19 / CLI18. Cero clientes t−1 define asesor sin cartera de inicio, no su antigüedad; sin cohorte heredada 100 %, con heredados evaluación regular. |
| CLI17 | C | Resultset: CLI16 actual menos retención derivada de los conteos ya registrados en t−1, en pp. No reconstruir la cohorte anterior. |
| CLI18 | A | Auxiliar HCLIRETINI: cardinalidad de K tras resolver identidad y pertenencia ajustada del stock inicial. No netear conteos superpuestos. |
| CLI19 | A | Auxiliar HCLIRETFIN: cardinalidad de los clientes de K retenidos en la entidad en t. |
| CLI20 | C | (CLI18 - CLI19) / CLI18; complemento de CLI16. Asesor sin cartera de inicio ni cohorte heredada: 0 %. |
| DIG01 | A | Bit Enrolado del cliente en CAR; clientes distintos por entidad/nivel/grupo (HCLIENR). Detalle: HINDENR. |
| DIG02 | C | Resultset: DIG01 menos DIG01 registrado en t−1. |
| DIG03 | C | HCLIENR / HCLICAR. |
| DIG04 | C | Resultset: diferencia de DIG03 con t−1 en pp. |
| DIG05 | A | Bit Transaccional del cliente en CAR (HCLITRX). Detalle: HINDTRX. |
| DIG06 | C | Resultset: DIG05 menos DIG05 registrado en t−1. |
| DIG07 | C | HCLITRX / HCLIENR; meta HMETTRXENR solo en base. |
| DIG08 | C | Resultset: diferencia de DIG07 con t−1 en pp. |
| DIG09 | C | HCLITRX / HCLICAR; meta HMETTRXCAR solo en base. |
| DIG10 | C | Resultset: diferencia de DIG09 con t−1 en pp. |
| DIG11 | C | Resultset: cumplimiento y semáforo con las metas de base. |
| DIG12 | A | Bit EnroladoNuevo del cliente en CAR (HCLIENRNUE). |
| DIG13 | C | HCLIENRNUE / HCLICAR. |
| DIG14 | A | Bit Monetario del cliente en CAR (HCLITRXMON). |
| DIG15 | C | HCLITRXMON / HCLIENR. |
| DIG16 | A | Bit PagoDigital del cliente en CAR (HCLIPAGDIG). Detalle: HINDPAGDIG. |
| DIG17 | C | HCLIPAGDIG / HCLICAR. |
| DIG18 | A | TransaccionesMonetarias del cliente en CAR; MAX por cliente y entidad, luego SUM (HNUMTRXMON). |
| DIG19 | C | HNUMTRXMON / HCLITRXMON. |

### 10.6. Diferidos, cobertura y consecuencias de diseño

| ID | Destino | Dependencia y operación de mapeo |
|---|---|---|
| SEG01 | F | Ingresos: concepto monetario por resolver. |
| SEG02 | F | Meta de ingresos: depende de SEG01. |
| SEG03 | F | Avance de ingresos: depende de SEG01/02. |
| SEG04 | A | Pólizas optativas distintas de HCDS001 del corte con la lógica de PSLSDSF001 (`SCODAGR = 6`), por jerarquía del vendedor (HNUMPLZ); solo base. |
| SEG05 | M | Meta 5001 publicada o suma de asesores por jerarquía del corte (HMETPLZ); solo base. |
| SEG06 | C | HNUMPLZ / HMETPLZ. |
| SEG07 | A | HPLZMUL: códigos 200/220/230. |
| SEG08 | A | HPLZPCU: códigos 802/824. |
| SEG09 | A | HPLZVID: códigos 803/817. |
| SEG10 | A | HPLZONC: códigos 814/828. |
| SEG11 | A | HPLZAGR: códigos 806/815/825. |
| SEG12 | A | HPLZPTO: código 822. |
| SEG13 | C | HOPEDESSEG / HOPEDES; HOPEDESSEG es medida A común que calcula 05_seguros.sql: desembolsos de t con optativo (`#TSSeguroOperacion`) sobre la atribución reconstruida desde el detalle (`#TSSegConteos`), COUNT(DISTINCT HCODOPE) por grupo 0/1/2. Detalle: HINDSEG. |
| SEG14 | A | HASESINVTA: asesores distintos de CAR base sin pólizas optativas; solo base. |
| SEG15 | F | Ticket prima: sin prima utilizable (VD08). |

Resumen del mapeo:

| Destino | Entradas | Lectura correcta |
|---|---:|---|
| A: medidas agregadas | 56 | Incluye 3 auxiliares, 2 contadores hábiles, conteos CAR09/CAR21 desde identidades, las 8 salidas SAL01–SAL08 y 6 medidas DIG; CAR21 sigue pendiente de presentación. |
| C: cálculos/referencias/reutilizaciones | 48 | Comparativos y ratios en RTABSEG01 leyendo t−1; clientes heredados/trasladados reutilizan la medida de su tabla. |
| M: metas | 7 | Conceptos mensuales solo en base. Vigente y clientes son metas de variación; pólizas 5001. |
| F: diferidos | 6 | DES07/08, SEG01–SEG03 y SEG15. |
| **Total** | **117** | Entradas del catálogo, no anchura de tabla. |

**Historia diaria y comparación son universos distintos.** Por confirmación del
usuario, los créditos presentes solo en días intermedios aportan al saldo medio
durante su permanencia y no participan en la comparación t−1/t. Es normal que
no estén en el FULL JOIN. Integrar sus aportes desde D07 sin duplicarlos ni crear
presencia ficticia en los cortes. No es un hallazgo comprobado de datos omitidos
ni un pendiente de definición de negocio. El mapeo técnico de eventos y salidas
mantiene V04/V08 en su alcance real.

**No todo se reconstruye desde una tabla agregada persistida.** Para tasas netas,
mantener componentes internos hasta calcular la salida; las tasas finales de los
tres grupos no bastan. Para clientes y cohorte, conservar conjuntos internos hasta
resolver las pertenencias necesarias. Las referencias y variaciones se generan
en RTABSEG01 desde los valores ya registrados en t−1; V10 está cerrado. El
procesamiento no debe persistir comparativos ni componentes ponderados finales
solo para suplir la lógica de presentación. La v0.3 resuelve los netos desde una
población ajustada exacta en temporales y conserva en base tasas, operaciones,
clientes y asesores netos, además del conteo de operaciones propias. Véanse
los campos NET en el [README](README.md#3-esquemas-de-agregados).

**Esquema físico v0.3:** 74/84/35/35 columnas en detalle/base/traslados/heredados.
HFECVENANT/HFECVENACT sustituyen el vencimiento único del detalle (R25).
El [registro del README](README.md#7-registro-de-versiones) documenta los cambios
aplicados. Los saldos medios son medidas de base calculadas desde las filas de
los snapshots por asesor operativo, sin columnas por operación ni reatribución
histórica. Las 117 entradas documentales siguen siendo el catálogo lógico, no el número de
columnas SQL.
