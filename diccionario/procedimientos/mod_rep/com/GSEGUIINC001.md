# mod_rep.com.GSEGUIINC001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GSEGUIINC001.sql](../../../../procedimientos/mod_rep/com/GSEGUIINC001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GSEGUIINC001.sql](../../../../sql/01-extraccion/mod_rep/com/GSEGUIINC001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GSEGUIINC001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GSEGUIINC001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEGUI_INC_SEC_01` | Seguimiento Incentivos Asesores | `tip_cod`, `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(10) | 'NOW' |  | — |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HASEOPER`≈, `HFECPRO`≈ | estatico + motor |
| [storage.com_act.HRESINC001](../../../tablas/storage/com_act/HRESINC001.md) | lee | `des_gru`≈, `HCLICIEN`, `HCLICIEND`, `HCLICIENO`, `HCLIINI`, `HCLIMET`, `HCODREL`, `HEBCAS01`, `HEBCAS02`, `HEBDET01`, `HEBDET02`, `HEBINI01`, `HEBINI02`, `HEBMAE01`, `HEBMAE02`, `HEBMAV01`, `HEBMAV02`, `HEBREC01`, `HEBREC02`, `HEFEC01MET`, `HEFEC02MET`, `HFECPRO`, `HITMESN`, `HITMESND`, `HITMESNO`, `HITMINN`, `HITMINND`, `HITMINNO`, `HMDESN`, `HMDESND`, `HMDESNO`, `HSALCIEN`, `HSALCIEND`, `HSALCIENO`, `HSALINI`, `HSALMET`, `HTIPCOD` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HDESCAR` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.ref.FJERCOR02` (función) | — | no |
| `mod_sys_admin.dbo.GLEVHIER01` | @tip_cod, @cod_rel, 11, 6, @p | no |
| `mod_app.inc.FMCALCINC01` | @json, '#tbl3', @fec | no |

### Columnas que devuelve

1. `(expresión 1)`
2. `*`, `des_uni`, `des_ter`, `des_cor`, `des_sec`, `des_car`, `bot`, `dis`, `smf`

### Observaciones del análisis

- CTE: `a`, `b`, `c`, `e`
- Temporales: `#jer`, `#tbl`, `#tbl2`, `#tbl3`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
