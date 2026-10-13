# mod_rep.com.GLISDETCLI01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GLISDETCLI01.sql](../../../../extraccion/procedimientos/mod_rep/com/GLISDETCLI01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GLISDETCLI01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GLISDETCLI01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GLISDETCLI01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GLISDETCLI01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DET_CLI_01` | Lista Clientes Reprogramados  | `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VCAH001](../../../tablas/storage/com_act/VCAH001.md) | lee | `HCODSEC`, `HDESCLI`, `HNUMDOC`, `HPAIS`, `HTIPDOC` | estatico + motor |
| [storage.gpr.HDETPER01](../../../tablas/storage/gpr/HDETPER01.md) | lee | `HCIIU`, `HCIUINFO`, `HEMAIL`, `HNUMDOC`, `HNUMTELE`, `HPAIS`, `HTELEINFO`, `HTIPDOC`, `HVERCIIU`, `HVERTEL` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |
| [storage.ref.RDPAIS001](../../../tablas/storage/ref/RDPAIS001.md) | lee | `RDPAIS`, `RPAIS` | estatico + motor |
| [storage.ref.RDTD001](../../../tablas/storage/ref/RDTD001.md) | lee | `RDTIPDOC`, `RTIPDOC` | estatico + motor |
| [storage.ref.REGCIIU003](../../../tablas/storage/ref/REGCIIU003.md) | lee | `RCODCIIU`, `RDESCIIU` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'DET_CLI_01' | no |

### Columnas que devuelve

`num_doc`, `cod_tip_doc`, `des_tip_doc`, `cod_pais`, `des_pais`, `nom_cli`, `email`, `num_tele_0`, `verificador_num_tele`, `ver_num_tele`, `num_tele_1`, `num_tele_2`, `ciiu_0`, `ciiu_0_id`, `verificador_ciiu`, `ver_ciiu`, `ciiu_1`, `ciiu_2`, `ciiu_3`, `cels`, `cius`

### Observaciones del análisis

- CTE: `a`, `ciu`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
