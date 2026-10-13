# mod_rep.com.RPROSCORR005

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RPROSCORR005.sql](../../../../procedimientos/mod_rep/com/RPROSCORR005.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RPROSCORR005.sql](../../../../sql/01-extraccion/mod_rep/com/RPROSCORR005.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RPROSCORR005.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RPROSCORR005.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GREPROSPCORRE_06` | Meta_PROSPECTO_Corresponsales | `tip_cod`, `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (7)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [STORAGE.com_act.HCMC002](../../../tablas/STORAGE/com_act/HCMC002.md) | lee | `HDESAGE`, `HFECINSTAL`, `HINSTALAD` | estatico + motor |
| [storage.com.metas_saldos](../../../tablas/storage/com/metas_saldos.md) | lee | `hcodvar`≈, `hfecpro`≈, `HTIPCOD`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `rfec` | estatico + motor |
| [storage.ref.vjercor03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODAGE`, `RCODCOR`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`result`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#Cab`, `#Da`, `#MetSeg`, `#Real`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.ref.vjercor03?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
