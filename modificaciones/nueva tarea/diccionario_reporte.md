# Diccionario del resultset del reporte (RTABSEG01)

Columnas que devuelve `mod_rep.com.RTABSEG01` ([07_sp_reporte.sql](07_sp_reporte.sql), README §1.4),
en el orden del resultset, con su ubicación en el tablero visual (maqueta `demo_panel_asesor`).
Se genera del SP; `verificar_sql.py` comprueba que la lista coincida. Columnas de origen:
[diccionario_tablas.md](diccionario_tablas.md); definiciones: [variables.md](variables.md).

## 1. Llamada y convenciones

```sql
EXEC mod_rep.com.RTABSEG01 @tip_cod = 18, @cod_rel = '45', @fec = '20261014';
```

- **Una fila** por llamada: la entidad (`@tip_cod`, `@cod_rel`) en el corte de `@fec` (NULL = ayer; corte = último hábil ≤ fecha). En nivel 7 el código es `'231'`.
- **Fuentes:** base del corte (sin sufijo), base del cierre anterior (`(t−1)`), trasladados (`(tra)`) y heredados (`(her)`) del corte. No recalcula fuentes.
- **Sufijos:** `_ant` valor registrado en el cierre anterior; `_var` corte − cierre anterior; `_var_pp` diferencia de fracciones × 100 (puntos porcentuales); `_var_pbs` × 10 000 (puntos básicos); `_aju`/`_net` población ajustada (base + trasladado − heredado); `_met` meta; `_ava`/`_cum` avance o cumplimiento frente a la meta; `_fal` faltante.
- **Formatos:** ratios como fracción (0,1912 → 19,12 %); importes en PEN; el redondeo y el formato son del front (V01).
- **NULL:** sin cierre anterior (`ind_cierre_ant = 0`) todos los comparativos; meta inexistente (no es cero); seguros pendiente (`ind_seg_pendiente = 1`); ratios sin regla acordada para denominador cero.
- **No se envían:** descripción de la entidad (la da el componente de jerarquía), ingresos y ticket prima de seguros y meta de monto desembolsado (diferidos).
- **Nombre en el tablero:** rótulo de la maqueta; `—` = dato auxiliar o adicional sin posición visual. Reglas provisionales: [P21](pendientes.md#p21).
- **Errores:** 51400 corte no cargado, 51401 entidad sin fila en el corte, 51402 nivel inválido.

## 2. Columnas por tarjeta

### 2.1. Encabezado

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 1 | `fec_corte` | Corte al dd/mm/aaaa | HFECPRO | Fecha |  | Corte efectivo resuelto desde @fec. |
| 2 | `fec_cierre_ant` | Cierre Anterior (referencia) | cie_ant de FVECFEC01 | Fecha |  | Fecha de la fila con la que se comparan todos los `_ant`. |
| 3 | `tip_cod` | — | HTIPCOD | Código |  | Nivel; la descripción la da el componente de jerarquía. |
| 4 | `cod_rel` | — | HCODREL | Código |  | Entidad; `''` asesor vacío, `-999` SIN ASIGNAR. |
| 5 | `ind_cierre_ant` | — | CASE WHEN HFECPRO(t−1) IS NULL THEN 0 ELSE 1 END | Bit |  | 0 = no hay fila del cierre anterior: todos los comparativos vienen NULL. |
| 6 | `ind_seg_pendiente` | Seguros: pendiente | CASE WHEN HNUMPLZ IS NULL THEN 1 ELSE 0 END | Bit |  | 1 = la carga de seguros no corrió; el bloque `seg_` viene NULL y debe mostrarse como pendiente, no como cero. |

### 2.2. Desembolsos

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 7 | `dias_hab_ava` | Días hábiles (marcador) | HDIAHABAVA | Días | DES10 | Transcurridos hasta el corte inclusive. |
| 8 | `dias_hab_tot` | Días hábiles (marcador) | HDIAHABTOT | Días | DES09 | Total del mes. |
| 9 | `dias_hab_por` | Días hábiles (80%) | HDIAHABAVA / HDIAHABTOT | Fracción | DES11 | Posición del marcador sobre las barras de operaciones y monto. |
| 44 | `des_ope` | Operaciones (barra) | HOPEDES | Operaciones | DES01 | En el asesor es lo que se compara con la meta. |
| 45 | `des_ase` | — | HASEDES | Asesores | DES03 | Asesores en t con desembolsos del mes (vacío cuenta uno); en el asesor vale 1. |
| 46 | `des_pro` | Operaciones / Productividad (barra) | asesor: HOPEDES; arriba: HOPEDES / HASEDES (0 sin asesores) | Ops. o ops./asesor | DES02 | Asesor: operaciones; niveles superiores: productividad. Rotulado en V05. |
| 47 | `des_met_pro` | Meta (operaciones) | HMETPRO | Ops. o ops./asesor | DES04 | 8070; NULL = sin meta. |
| 48 | `des_ava_pro` | % avance operaciones | des_pro / HMETPRO | Fracción | DES05 | NULL sin meta. |
| 49 | `des_mon` | Monto (barra) | HSALDES | PEN | DES06 | Meta de monto diferida (DIF02): no se envía. |
| 50 | `des_tic` | Ticket Promedio | CASE WHEN HOPEDES = 0 THEN 0 ELSE HSALDES / HOPEDES END | PEN | DES12 | 0 sin operaciones. |
| 51 | `des_tas` | TAPP Mes | HTASDES | Fracción | DES13 |  |
| 52 | `des_tas_min` | TAPP Mínima | HTASMIN | Fracción | DES14 |  |
| 53 | `des_ope_net` | — | HOPEDESNET | Operaciones | DES01 | Población ajustada. |
| 54 | `des_ase_net` | — | HASEDESNET | Asesores | DES03 | Población ajustada. |
| 55 | `des_mon_net` | — | HSALDES + HSALDES(tra) − HSALDES(her) | PEN | DES06 | Población ajustada. |
| 56 | `des_tic_net` | — | CASE WHEN HOPEDESNET = 0 THEN 0 ELSE des_mon_net / HOPEDESNET END | PEN | DES12 | Población ajustada. |
| 57 | `des_tas_net` | — | HTASDESNET | Fracción | DES13 | Población ajustada. |
| 58 | `des_tas_min_net` | — | HTASMINNET | Fracción | DES14 | Población ajustada. |

### 2.3. Cartera

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 10 | `car_sal_vig` | Saldo vigente · Hoy | HSALCIEVIG | PEN | CAR02 | Stock de base (incluye heredada). |
| 11 | `car_sal_vig_pro` | Saldo vigente · Propia | HSALCIEVIG - HSALCIEVIG(her) | PEN | CAR20 | Hoy − heredada (presentación provisional, V09). |
| 12 | `car_sal_vig_her` | Saldo vigente · Heredada | HSALCIEVIG(her) | PEN | CAR02 | Segmento de Hoy recibido de otra entidad. |
| 13 | `car_sal_vig_tra` | Saldo vigente · Trasladada | HSALCIEVIG(tra) | PEN | CAR02 | Fuera de Hoy; se dibuja rayada encima y no suma a Hoy ni a la meta. |
| 14 | `car_sal_vig_ant` | Saldo vigente · Cierre Anterior | HSALCIEVIG(t−1) | PEN | CAR04 | Valor registrado en t−1. |
| 15 | `car_sal_vig_aju` | — | HSALCIEVIG + HSALCIEVIG(tra) - HSALCIEVIG(her) | PEN | CAR06 | Saldo vigente ajustado (base + trasladado − heredado). |
| 16 | `car_met_var_vig` | — | HMETVARVIG | PEN | CAR10 | Meta de variación (9000); base de la meta de stock. |
| 17 | `car_met_sal_vig` | Saldo vigente · Meta | HSALCIEVIG(t−1) + HMETVARVIG | PEN | CAR10 | Meta de stock = cierre anterior + meta de variación. |
| 18 | `car_fal_sal_vig` | Faltan | HSALCIEVIG(t−1) + HMETVARVIG - HSALCIEVIG | PEN | CAR11 | Negativo = excedente (P21). |
| 19 | `car_ope` | Operaciones · Hoy | HOPECAR | Operaciones | CAR07 | Todo el stock, no solo vigentes (P21/V09). |
| 20 | `car_ope_pro` | Operaciones · Propia | HOPECARPRO | Operaciones | CAR21 | Base sin claves heredadas; no es Hoy − Heredada. |
| 21 | `car_ope_her` | Operaciones · Heredada | HOPECAR(her) | Operaciones | CAR07 | Puede superponerse con Propia (un HCODOPE con dos tipos). |
| 22 | `car_ope_tra` | Operaciones · Trasladada | HOPECAR(tra) | Operaciones | CAR07 | No suma a Hoy. |
| 23 | `car_ope_ant` | Operaciones · Cierre Anterior | HOPECAR(t−1) | Operaciones | CAR08 |  |
| 24 | `car_ope_aju` | — | HOPECARNET | Operaciones | CAR09 | Operaciones de la población ajustada. |
| 25 | `car_sal_tot` | — | HSALCIE | PEN | CAR01 | Saldo capital total de base. |
| 26 | `car_sal_tot_ant` | — | HSALCIE(t−1) | PEN | CAR03 | Denominador del crecimiento neto. |
| 27 | `car_sal_tot_aju` | — | HSALCIE + HSALCIE(tra) − HSALCIE(her) | PEN | CAR05 | Saldo total ajustado. |
| 28 | `car_var_net` | Crecimiento neto · variación | car_sal_tot_aju - HSALCIE(t−1) | PEN | CAR19 | Se muestra bajo el porcentaje. |
| 29 | `car_cre_net` | Crecimiento neto | (car_sal_tot_aju - HSALCIE(t−1)) / HSALCIE(t−1) | Fracción | CAR18 | NULL si el saldo anterior es 0 o no hay t−1. |
| 30 | `car_sal_med_tot` | Saldo medio (total) | HSALMEDTOT | PEN | CAR12 | La tarjeta muestra un solo saldo medio: total o vigente por decidir (V09). |
| 31 | `car_sal_med_tot_ant` | — | HSALMEDTOT(t−1) | PEN | CAR12 |  |
| 32 | `car_sal_med_tot_var` | Saldo medio · variación | HSALMEDTOT - HSALMEDTOT(t−1) | PEN | CAR14 |  |
| 33 | `car_sal_med_vig` | Saldo medio (vigente) | HSALMEDVIG | PEN | CAR13 | Alternativa a la total (V09). |
| 34 | `car_sal_med_vig_ant` | — | HSALMEDVIG(t−1) | PEN | CAR13 |  |
| 35 | `car_sal_med_vig_var` | Saldo medio · variación | HSALMEDVIG - HSALMEDVIG(t−1) | PEN | CAR15 |  |
| 36 | `car_tas_stk_tot` | TAPP stock (total) | HTASSTKTOT | Fracción | CAR16 | Total o vigente por decidir (V09). |
| 37 | `car_tas_stk_tot_ant` | — | HTASSTKTOT(t−1) | Fracción | CAR16 |  |
| 38 | `car_tas_stk_tot_var_pbs` | TAPP stock · ± pbs | (HTASSTKTOT - HTASSTKTOT(t−1)) * 10000 | pbs | CAR17 |  |
| 39 | `car_tas_stk_vig` | TAPP stock (vigente) | HTASSTKVIG | Fracción | CAR22 |  |
| 40 | `car_tas_stk_vig_ant` | — | HTASSTKVIG(t−1) | Fracción | CAR22 |  |
| 41 | `car_tas_stk_vig_var_pbs` | TAPP stock · ± pbs | (HTASSTKVIG - HTASSTKVIG(t−1)) * 10000 | pbs | CAR23 |  |
| 42 | `car_tas_stk_tot_net` | — | HTASSTKTOTNET | Fracción | CAR16 | Población ajustada. |
| 43 | `car_tas_stk_vig_net` | — | HTASSTKVIGNET | Fracción | CAR22 | Población ajustada. |

### 2.4. Recuperaciones y Mora

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 59 | `rec_sal_pro` | Monto recuperado · de N | HSALRECPRO | PEN | REC01 | Programado del mes completo. |
| 60 | `rec_sal_efe` | Monto recuperado | HSALRECEFE | PEN | REC02 |  |
| 61 | `rec_por_sal` | % recuperado (monto) | CASE WHEN HSALRECPRO = 0 THEN CASE WHEN HINDSININI = 1 THEN 1 END ELSE HSALRECEFE / HSALRECPRO END | Fracción | REC03 | Sin cartera de inicio y sin programado: 1; programado 0 con cartera de inicio: NULL (P21). |
| 62 | `rec_ope_pro` | Operaciones recuperadas · de N | HOPERECPRO | Operaciones | REC04 |  |
| 63 | `rec_ope_efe` | Operaciones recuperadas | HOPERECEFE | Operaciones | REC05 |  |
| 64 | `rec_por_ope` | % recuperado (operaciones) | CASE WHEN HOPERECPRO = 0 THEN CASE WHEN HINDSININI = 1 THEN 1 END ELSE HOPERECEFE / HOPERECPRO END | Fracción | REC06 | Misma regla que el monto. |
| 65 | `rec_efe_uno` | Efectividad −30 a 0 días | HEFETRAUNO | Fracción | REC07 |  |
| 66 | `rec_met_efe_uno` | Meta (−30 a 0) | HMETEFEUNO | Escala de la fuente | REC08 | Sin cumplimiento hasta confirmar la escala (V02). |
| 67 | `rec_efe_dos` | Efectividad 1 a 30 días | HEFETRADOS | Fracción | REC09 |  |
| 68 | `rec_met_efe_dos` | Meta (1 a 30) | HMETEFEDOS | Escala de la fuente | REC10 |  |
| 69 | `rec_efe_tre` | — | HEFETRATRE | Fracción | REC11 | 31 a 60 días; adicional, no visible (V12). |
| 70 | `rec_met_efe_tre` | — | HMETEFETRE | Escala de la fuente | REC12 |  |
| 71 | `rec_cli_mor` | Clientes en mora | HCLIMOR | Clientes | REC13 |  |
| 72 | `rec_cli_mor_ant` | — | HCLIMOR(t−1) | Clientes | REC13 |  |
| 73 | `rec_cli_mor_var` | Clientes en mora · ± | HCLIMOR - HCLIMOR(t−1) | Clientes | REC14 | Sin netear traslados. |
| 74 | `rec_sal_mor` | Saldo en mora | HSALMOR | PEN | REC15 |  |
| 75 | `rec_sal_mor_ant` | — | HSALMOR(t−1) | PEN | REC15 |  |
| 76 | `rec_sal_mor_var` | Saldo en mora · ± | HSALMOR - HSALMOR(t−1) | PEN | REC16 |  |
| 77 | `rec_ope_ing_mor` | Ingresos a mora (ops) | HOPEINGMOR | Operaciones | REC17 |  |
| 78 | `rec_sal_ing_mor` | Ingresos a mora (monto) | HSALINGMOR | PEN | REC18 |  |

### 2.5. Salidas (no visible)

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 79 | `sal_ope_cas` | — | HOPECAS | Operaciones | SAL01 | Al titular a la salida. |
| 80 | `sal_sal_cas` | — | HSALCAS | PEN | SAL02 |  |
| 81 | `sal_ope_vta` | — | HOPEVTA | Operaciones | SAL03 |  |
| 82 | `sal_sal_vta` | — | HSALVTA | PEN | SAL04 |  |
| 83 | `sal_ope_can_pre` | — | HOPECANPRE | Operaciones | SAL05 |  |
| 84 | `sal_sal_can_pre` | — | HSALCANPRE | PEN | SAL06 |  |
| 85 | `sal_ope_can_con` | — | HOPECANCON | Operaciones | SAL07 |  |
| 86 | `sal_sal_can_con` | — | HSALCANCON | PEN | SAL08 |  |
| 87 | `sal_ope_tot` | — | HOPECAS + HOPEVTA + HOPECANPRE + HOPECANCON | Operaciones |  | Total de salidas (cada operación tiene un solo motivo). |
| 88 | `sal_sal_tot` | — | HSALCAS + HSALVTA + HSALCANPRE + HSALCANCON | PEN |  | Total de salidas. |

### 2.6. Clientes

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 89 | `cli_car` | Hoy | HCLICAR | Clientes | CLI01 |  |
| 90 | `cli_car_ant` | Cierre Anterior | HCLICAR(t−1) | Clientes | CLI02 |  |
| 91 | `cli_ing` | Movimiento · Ingresos | HCLIING | Clientes | CLI03 |  |
| 92 | `cli_sal` | Movimiento · Salidas | HCLISAL | Clientes | CLI04 | El front lo muestra con signo negativo. |
| 93 | `cli_her` | Movimiento · Heredados | HCLICAR(her) | Clientes | CLI05 | Conteo positivo; el signo del movimiento es de presentación (V09). |
| 94 | `cli_tra` | Movimiento · Trasladados | HCLICAR(tra) | Clientes | CLI06 | Ídem. |
| 95 | `cli_car_aju` | — | HCLICARNET | Clientes | CLI07 | Clientes de la población ajustada. |
| 96 | `cli_cre_net` | Movimiento · Crecimiento neto / Avance | HCLICARNET − HCLICAR(t−1) | Clientes | CLI07 | No es Ingresos − Salidas ± movimientos (conteos superpuestos). |
| 97 | `cli_met_var` | Meta de variación | HMETVARCLI | Clientes | CLI08 | 10062. |
| 98 | `cli_met_car` | — | HCLICAR(t−1) + HMETVARCLI | Clientes | CLI08 | Meta de stock = cierre anterior + meta de variación. |
| 99 | `cli_ava_met` | Avance · % | cli_cre_net / HMETVARCLI | Fracción | CLI10 | NULL sin meta. |
| 100 | `cli_fal_met` | Faltan N clientes | HMETVARCLI - cli_cre_net | Clientes | CLI11 | Negativo = excedente. |
| 101 | `cli_nue` | Nuevos | HCLINUE | Clientes | CLI12 |  |
| 102 | `cli_nue_ant` | — | HCLINUE(t−1) | Clientes | CLI12 |  |
| 103 | `cli_nue_var` | Nuevos · ± | HCLINUE - HCLINUE(t−1) | Clientes | CLI13 |  |
| 104 | `cli_ban` | Bancarizados | HCLIBAN | Clientes | CLI14 |  |
| 105 | `cli_ban_ant` | — | HCLIBAN(t−1) | Clientes | CLI14 |  |
| 106 | `cli_ban_var` | Bancarizados · ± | HCLIBAN - HCLIBAN(t−1) | Clientes | CLI15 |  |
| 107 | `cli_ret_ini` | — | HCLIRETINI | Clientes | CLI18 | Denominador de la retención. |
| 108 | `cli_ret_fin` | — | HCLIRETFIN | Clientes | CLI19 |  |
| 109 | `cli_ret` | Retención | HCLIRETFIN / HCLIRETINI; sin cohorte y HINDSININI = 1: 1 | Fracción | CLI16 | Sin cohorte y sin cartera de inicio: 1. |
| 110 | `cli_ret_ant` | — | ídem con la fila de t−1 | Fracción | CLI16 |  |
| 111 | `cli_ret_var_pp` | Retención · ± pp | (cli_ret - cli_ret_ant) * 100 | pp | CLI17 |  |
| 112 | `cli_churn` | — | 1 - cli_ret | Fracción | CLI20 | Complemento de la retención. |

### 2.7. Digital

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 113 | `dig_enr` | Enrolamiento · numerador (68 de 143) | HCLIENR | Clientes | DIG01 |  |
| 114 | `dig_enr_ant` | — | HCLIENR(t−1) | Clientes | DIG01 |  |
| 115 | `dig_enr_var` | — | HCLIENR - HCLIENR(t−1) | Clientes | DIG02 |  |
| 116 | `dig_por_enr` | Enrolamiento (anillo, Sin meta) | HCLIENR / HCLICAR (0 sin clientes) | Fracción | DIG03 | Denominador cli_car. |
| 117 | `dig_por_enr_ant` | — | ídem en t−1 | Fracción | DIG03 |  |
| 118 | `dig_por_enr_var_pp` | Enrolamiento · ± pp | (dig_por_enr - dig_por_enr_ant) * 100 | pp | DIG04 |  |
| 119 | `dig_trx` | Transaccionales (13 de 68 / 13 de 143) | HCLITRX | Clientes | DIG05 | Numerador de las dos usabilidades. |
| 120 | `dig_trx_ant` | — | HCLITRX(t−1) | Clientes | DIG05 |  |
| 121 | `dig_trx_var` | — | HCLITRX - HCLITRX(t−1) | Clientes | DIG06 |  |
| 122 | `dig_usa_enr` | Usab. enrolados (anillo) | HCLITRX / HCLIENR (0 sin enrolados) | Fracción | DIG07 | Denominador dig_enr. |
| 123 | `dig_usa_enr_ant` | — | ídem en t−1 | Fracción | DIG07 |  |
| 124 | `dig_usa_enr_var_pp` | Var. usab. enrol. | (dig_usa_enr - dig_usa_enr_ant) * 100 | pp | DIG08 |  |
| 125 | `dig_met_usa_enr` | Meta (Usab. enrolados) | HMETTRXENR | Fracción | DIG07 | 0,205 fija. |
| 126 | `dig_cum_usa_enr` | Cumpl. usab. enrol. | dig_usa_enr / HMETTRXENR (0 sin meta) | Fracción | DIG11 |  |
| 127 | `dig_sem_usa_enr` | Semáforo (chip de meta) | CASE WHEN dig_cum_usa_enr >= 1 THEN 1 WHEN dig_cum_usa_enr < 0.9 THEN -1 ELSE 0 END | 1 / 0 / −1 | DIG11 | 1 verde (≥ 1), 0 ámbar, −1 rojo (< 0,9), como RSTABCOMER. |
| 128 | `dig_usa_car` | Usab. cartera (anillo) | HCLITRX / HCLICAR (0 sin clientes) | Fracción | DIG09 | Denominador cli_car. |
| 129 | `dig_usa_car_ant` | — | ídem en t−1 | Fracción | DIG09 |  |
| 130 | `dig_usa_car_var_pp` | Var. usab. cart. | (dig_usa_car - dig_usa_car_ant) * 100 | pp | DIG10 |  |
| 131 | `dig_met_usa_car` | Meta (Usab. cartera) | HMETTRXCAR | Fracción | DIG09 | 0,09 fija. |
| 132 | `dig_cum_usa_car` | Cumpl. usab. cart. | dig_usa_car / HMETTRXCAR (0 sin meta) | Fracción | DIG11 |  |
| 133 | `dig_sem_usa_car` | Semáforo (chip de meta) | CASE WHEN dig_cum_usa_car >= 1 THEN 1 WHEN dig_cum_usa_car < 0.9 THEN -1 ELSE 0 END | 1 / 0 / −1 | DIG11 | Misma regla. |
| 134 | `dig_enr_nue` | Nuevos enrolados | HCLIENRNUE | Clientes | DIG12 |  |
| 135 | `dig_enr_nue_ant` | — | HCLIENRNUE(t−1) | Clientes | DIG12 |  |
| 136 | `dig_enr_nue_var` | Nuevos enrolados · ± | HCLIENRNUE - HCLIENRNUE(t−1) | Clientes | DIG12 |  |
| 137 | `dig_por_enr_nue` | — | CASE WHEN HCLICAR = 0 THEN 0 ELSE HCLIENRNUE / HCLICAR END | Fracción | DIG13 | Nuevos enrolados / clientes; 0 sin clientes. |
| 138 | `dig_trx_mon` | Trx. monetarias | HCLITRXMON | Clientes | DIG14 | Clientes con transacción monetaria (no número de transacciones). |
| 139 | `dig_trx_mon_ant` | — | HCLITRXMON(t−1) | Clientes | DIG14 |  |
| 140 | `dig_trx_mon_var` | Trx. monetarias · ± | HCLITRXMON - HCLITRXMON(t−1) | Clientes | DIG14 |  |
| 141 | `dig_por_trx_mon` | — | CASE WHEN HCLIENR = 0 THEN 0 ELSE HCLITRXMON / HCLIENR END | Fracción | DIG15 | Monetarios / enrolados; 0 sin enrolados. |
| 142 | `dig_pag_dig` | Pago digital | HCLIPAGDIG | Clientes | DIG16 | Hoy solo app (A07). |
| 143 | `dig_pag_dig_ant` | — | HCLIPAGDIG(t−1) | Clientes | DIG16 |  |
| 144 | `dig_pag_dig_var` | Pago digital · ± | HCLIPAGDIG - HCLIPAGDIG(t−1) | Clientes | DIG16 |  |
| 145 | `dig_por_pag_dig` | — | CASE WHEN HCLICAR = 0 THEN 0 ELSE HCLIPAGDIG / HCLICAR END | Fracción | DIG17 | Pago digital / clientes; 0 sin clientes. |
| 146 | `dig_num_trx_mon` | — | HNUMTRXMON | Transacciones | DIG18 | Número de transacciones monetarias. |
| 147 | `dig_trx_mon_cli` | — | CASE WHEN HCLITRXMON = 0 THEN 0 ELSE HNUMTRXMON / HCLITRXMON END | Transacciones | DIG19 | Por cliente monetario; 0 sin monetarios. |

### 2.8. Seguros

| # | Columna | Nombre en el tablero | Fórmula (tablas HTABSEG) | Unidad | Variable | Notas |
|---:|---|---|---|---|---|---|
| 148 | `seg_plz` | Pólizas Totales | HNUMPLZ | Pólizas | SEG04 | Optativas, sin desgravamen. |
| 149 | `seg_met_plz` | Meta (pólizas) | HMETPLZ | Pólizas | SEG05 | 5001; NULL sin meta. |
| 150 | `seg_ava_plz` | % avance pólizas | HNUMPLZ / HMETPLZ | Fracción | SEG06 | NULL sin meta. |
| 151 | `seg_plz_mul` | Multiriesgo | HPLZMUL | Pólizas | SEG07 | Segmento de la barra apilada. |
| 152 | `seg_plz_pcu` | Prot. Cuota | HPLZPCU | Pólizas | SEG08 |  |
| 153 | `seg_plz_vid` | Vida Segura | HPLZVID | Pólizas | SEG09 |  |
| 154 | `seg_plz_onc` | Oncológico | HPLZONC | Pólizas | SEG10 |  |
| 155 | `seg_plz_agr` | Agropecuario | HPLZAGR | Pólizas | SEG11 |  |
| 156 | `seg_plz_pto` | Prot. Total | HPLZPTO | Pólizas | SEG12 |  |
| 157 | `seg_ope_des_seg` | — | HOPEDESSEG | Operaciones | SEG13 | Numerador de la penetración. |
| 158 | `seg_pen` | Penetración Opt. | HOPEDESSEG / HOPEDES | Fracción | SEG13 | NULL sin desembolsos (V01). |
| 159 | `seg_ase_sin_vta` | Sin Venta Opt. | HASESINVTA | Asesores | SEG14 | En el asesor vale 0/1; tiene sentido en niveles superiores. |
