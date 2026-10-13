# mod_rep.com.RCARDZCUO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RCARDZCUO01.sql](../../../../procedimientos/mod_rep/com/RCARDZCUO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RCARDZCUO01.sql](../../../../sql/01-extraccion/mod_rep/com/RCARDZCUO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RCARDZCUO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RCARDZCUO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_CARD_ZCUO_01` | Card reporte cero cuotas | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@Fecha` | DATE | — |  | `fecha` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WZCUO001](../../../tablas/storage/com_act/WZCUO001.md) | lee | `HDIAATR`, `HFECPRO`, `HSALCAPMN`, `nuevo_ingreso`, `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODTER`, `RCODUCO`, `RCODUNI` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

1. `JSON`
2. `htipcod`, `hcodrel`, `Style`, `saldo_act`, `saldo_ant`, `dif_saldo`, `zcuonuevo_act`, `zcuonuevo_ant`, `dif_zcuonuevo`, `may60_act`, `may60_ant`, `dif_may60`, `men60_act`, `men60_ant`, `dif_men60`

### Observaciones del análisis

- CTE: `m_act`, `m_ant`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
