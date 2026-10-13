# mod_rep.com.RSRPD001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRPD001.sql](../../../../procedimientos/mod_rep/com/RSRPD001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRPD001.sql](../../../../sql/01-extraccion/mod_rep/com/RSRPD001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRPD001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRPD001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_MON_CAR_01` | Control Cargas Prod | `opt` | reportes / control-cargas |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@Opt` | char(1) | '1' |  | `opt` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [LS_FCMIS_REP.FCMIS_REP.dbo.ControlCargaData](../../../tablas/FCMIS_REP/dbo/ControlCargaData.md) | lee | `BitAct`≈, `descripcion`≈, `fechaAct`≈, `FechaRep`≈, `FechaRepAnt`≈, `id`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |
| [strategos.etl.ABPCONF01](../../../tablas/strategos/etl/ABPCONF01.md) | lee | `HCODPRO`, `HDESLOG`, `HDESPRO`, `HSTATUS`, `HTIPPRO` | estatico + motor |
| [strategos.etl.ABPEVLOG01](../../../tablas/strategos/etl/ABPEVLOG01.md) | lee | `dd`≈, `HCODPRO`, `HDESPRO`, `HDESTAD`, `HFECLOG`, `HFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `@json`
2. `fec_pro`, `cod_pro`, `nom_pro`, `fec_ini`, `fec_fin`, `dif_min`, `est_pro`, `sem_est`, `ind_ejec`, `ind_retraso`
3. `@json1`
4. `id`, `des_pro`, `fec_act`, `fec_rep`, `fec_rep_ant`, `BitAct`, `est_pro`, `sem_fec`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
