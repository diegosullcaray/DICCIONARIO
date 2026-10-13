# mod_rep.com.GSELJERAR001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GSELJERAR001.sql](../../../../procedimientos/mod_rep/com/GSELJERAR001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GSELJERAR001.sql](../../../../sql/01-extraccion/mod_rep/com/GSELJERAR001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GSELJERAR001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GSELJERAR001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEL_JER_01` | Filtro Territorio,Corred,agencia | — | — |

### Firma

Sin parámetros.

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.HCMC001](../../../tablas/storage/com_act/HCMC001.md) | lee | `HESTADOTX`≈, `HFECPRO`≈, `HNOMBREPTO`≈, `HNOMTITCB`≈ | estatico + motor |
| [storage.ref.REGCIIU003](../../../tablas/storage/ref/REGCIIU003.md) | lee | `RCODCIIU`≈, `RDESCIIU`≈ | estatico + motor |
| [storage.ref.REUBI01](../../../tablas/storage/ref/REUBI01.md) | lee | `RDESDEP`≈, `RDESDIS`≈, `RDESPRO`≈ | estatico + motor |
| [storage.ref.vjercor03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RDESAGE`≈, `RDESCOR`≈, `RDESMAT`≈, `RDESTER`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`desc`, `id`, `sec_eco`

### Observaciones del análisis

- Temporales: `#ESTCORRES`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
