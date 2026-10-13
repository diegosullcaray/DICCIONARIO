# mod_rep.com.GRESCLIREP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESCLIREP01.sql](../../../../procedimientos/mod_rep/com/GRESCLIREP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESCLIREP01.sql](../../../../sql/01-extraccion/mod_rep/com/GRESCLIREP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESCLIREP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESCLIREP01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RES_SEC_REP_01` | Lista Clientes Reprogramados | `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HBAR001](../../../tablas/storage/com_act/HBAR001.md) | lee | `HCODOPE`, `HMONCUO`, `HPREG01`, `HPREG02`, `HPREG03`, `HPREG04`, `HTIPCUO` | estatico + motor |
| [storage.com_act.WBCR001](../../../tablas/storage/com_act/WBCR001.md) | lee | `HBGCTACLI`, `HBGNOMCLI`, `HCODOPE`, `HCODSEC`, `HCTACLI`, `HCUOPEN`, `HDESCLI`, `HFECDES`, `HFECMOR`, `HFLAGREAC`, `HGRUPROD`, `HNOMG`, `HNUMDOC`, `HPAIS`, `HSALCAPMN`, `HTIPDOC`, `RDESPROD` | estatico + motor |
| [storage.gpr.HDETPER01](../../../tablas/storage/gpr/HDETPER01.md) | lee | `HNUMDOC`, `HNUMTELE`, `HPAIS`, `HTIPDOC` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'RES_SEC_REP_01' | no |

### Columnas que devuelve

`num_doc_sec`, `cta_cli`, `nom_cli`, `telefono`, `nombre_gru_pdm`, `background_cta_cli`, `background_nom_cli`, `producto`, `base_reactivados`, `grupo_prod`, `tipo_cuo`, `background_tipo_cuo`, `operacion`, `fec_desem`, `saldo_capital_mn`, `mon_cuo`, `fec_sgt_cuo_rep`, `cuo_pend`, `preg_01`, `preg_02`, `preg_03`, `preg_04`

### Observaciones del análisis

- CTE: `a`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
