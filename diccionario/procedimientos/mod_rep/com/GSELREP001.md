# mod_rep.com.GSELREP001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | 🔎 extraído |
| Cuerpo | [procedimientos/mod_rep/com/GSELREP001.sql](../../../../procedimientos/mod_rep/com/GSELREP001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GSELREP001.sql](../../../../sql/01-extraccion/mod_rep/com/GSELREP001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEL_EFEC_01` | Filtro Detalle Efectividad | — | reportes / actividad-diaria / Cartera en Mora<br>reportes / actividad-diaria / Portafolio Reasignado<br>reportes / actividad-mensual |

### Firma

Sin parámetros.

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCED001](../../../tablas/storage/com_act/WCED001.md) | lee | `HFCRES`≈ | estatico |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'SEL_EFEC_01' | no |

### Columnas que devuelve

`id`, `desc`

### Observaciones del análisis

- CTE: `cte_e`, `cte_f`, `cte_r`
<!-- generado:fin -->

## Propósito

Devuelve las opciones del filtro "Detalle Efectividad" (`SEL_EFEC_01`): los valores distintos y no nulos
de `HFCRES` en `storage.com_act.WCED001`, precedidos por `TODO` y seguidos por `VACÍO`.
En MIS-angular-front, `SEL_EFEC_01` es la constante `opcionesUltimaGestion` de Cartera en Mora,
Portafolio Reasignado y Actividad Mensual (foto de `fuente/consumo-front.json`).

## Reglas de negocio

- Orden fijo: `TODO` (clave 0), luego los valores de `HFCRES` en orden alfabético (`ROW_NUMBER() over(order by HFCRES)` + 1), y `VACÍO` (clave 999999) al final.
- Excluye nulos (`where HFCRES is not null`); la opción `VACÍO` es la que los representa en el filtro.
- `id` y `desc` devuelven el mismo texto: el valor seleccionado viaja como texto, no como código.

## Notas del analista

- Invoca `mod_rep.rep.FTHEACOLS01 'SEL_EFEC_01'` antes del SELECT. Ese SP no está en `reportes.json`;
  su función está por confirmar (extraerlo con `USE mod_rep; EXEC sp_helptext 'rep.FTHEACOLS01';`).
- `SET NOCOUNT ON` aparece dos veces en el cuerpo; no tiene efecto, se documenta tal cual.
- El significado de `HFCRES` está _por documentar_ en la ficha de la tabla: no se deduce del nombre.
