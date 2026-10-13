# mod_rep.com.RSRTOPV001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRTOPV001.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRTOPV001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRTOPV001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRTOPV001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RSRTOPV01` | Monitor de Efectividades TOP | `tip_cod`, `tip_cod2`, `level`, `cod_rel` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | nvarchar(10) | — |  | `tip_cod` |
| 2 | `@tip_cod2` | nvarchar(10) | — |  | `tip_cod2` |
| 3 | `@level` | nvarchar(10) | — |  | `level` |
| 4 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |

### Tablas y columnas (0)

No se detectaron tablas.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.com.RSRTOPTV001` | @tip_cod, @tip_cod2, @level, @cod_rel | no |
| `MOD_REP.com.RSRTOPTV002` | @tip_cod, @tip_cod2, @level, @cod_rel | no |
| `mod_rep.com.RSRTOPTV003` | @tip_cod, @tip_cod2, @level, @cod_rel | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
