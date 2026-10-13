# MOD-0001 · Análisis

SP: [`mod_rep.com.GDCGEST_ACTIVAST01`](../../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.sql) ·
ficha: [diccionario](../../diccionario/procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md) ·
reportes: `GST_ACTIVAS_01…06` (diario) y `GST_ACTIVAS_M_01…06` (mensual), todos con parámetros
`tip_cod, cod_rel, var, fec, diario`.

## 1. Cómo funciona el SP hoy

Un solo SP arma seis tablas distintas según `@var`:

| `@var` | Tabla (título en el front) | Filas |
|---:|---|---|
| 1 | Número de operaciones por producto y nivel de tasas | productos + TOTAL |
| 2 | % operaciones con autonomía por producto | productos + TOTAL |
| **3** | **TAPP Mes por producto y nivel de tasas** | productos + TOTAL |
| 4 | Evolución de operaciones | fechas + "(%)" + "Var Abs (pbs)" |
| 5 | Evolución de monto desembolsado | fechas + "(%)" + "Var Abs (pbs)" |
| **6** | **Evolución de TAPP Mes** | fechas + "(%)" + "Var Abs (pbs)" |

Devuelve **dos resultados**: (1) una cabecera JSON con las columnas a mostrar (`columnDef`, `header`, `isdata`
= orden), y (2) los datos. El front (`tabla-reporte.component.ts`) dibuja **solo las columnas que declara la
cabecera**, ordenadas por `isdata`.

### Datos (comunes a las seis variantes)

Fuente: `storage.com_act.WGATH002` (operaciones desembolsadas), unida a `RETP001/002/003` para el producto.

| Columna de salida | Cálculo | Viene de |
|---|---|---|
| `A1`, `A2`, `A3` | métrica `@calc` para nivel de tasa 1 (encima de la mínima), 2 (a la mínima), 3 (autonomías) | `HGESTTAS` |
| `B1…B4` | métrica por nivel de autonomía (Administrador … Gte. División Comercial) | `HUCAP_FIN` |
| `A10` | métrica total | `HGESTTAS = 10` (total del `CUBE`) |
| `TP` | ticket promedio = `SUM(HMDES)/COUNT(*)` | — |
| **`TM`** | **TAPP mínima = Σ(monto × `HTMIN`) / Σ monto** (`HTAPPMIN`) | `HTMIN` |
| **`DT`** | **distancia = (TAPP − TAPP mínima) × 10 000, en pbs** (`HDIFTAPPMM`) | `HTDES`, `HTMIN` |

`TAPP` = Σ(monto × `HTDES`) / Σ monto, ponderado por monto desembolsado (`HMDES`).

### Por qué `@var=3` muestra TM y DT y `@var=6` no

**El SP ya calcula `TM` y `DT` para todas las variantes**, también para la 6: en el SELECT final, los joins
`E` (`HTAPPMIN`) y `F` (`HDIFTAPPMM`) emparejan por producto y fecha, sin mirar `@var`. En `@var=6` las filas
son una por fecha con `RDESPROD = 'TOTAL'`, y `#C` tiene `HTAPPMIN` y `HDIFTAPPMM` para cada fecha: el dato
existe y viaja al front.

La diferencia está **solo en la cabecera JSON**: la de `@var=3` declara `TM` ("TAPP Mínima", isdata 9) y `DT`
("Distancia (en pbs)", isdata 11); la de `@var=6` termina en `TP` ("Ticket Promedio", isdata 10). Como el front
dibuja únicamente lo declarado, TM y DT llegan pero no se ven.

## 2. Cambios

**Cambio 1 — cabecera de `@var=6`.** Agregar después de `TP`:

| columnDef | header | isdata | formato |
|---|---|---:|---|
| `TM` | TAPP Mínima | 11 | number (el SP ya lo entrega como `%` con `format(…,'P')`) |
| `DT` | Distancia (en pbs) | 12 | number (`format(…,'N0')`) |

Se usa el mismo `columnDef`, texto y formato que en `@var=3`, para que se lea igual en las dos tablas.
No se copia la columna `FF` (semáforo oculto) de `@var=3`: el pedido es solo por TAPP Mínima y Distancia.

**Cambio 2 — fila "Var Abs (pbs)".** En la tabla de evolución, esa fila muestra en *TAPP Final* la variación
en pbs contra el período base (dic-2020 a jun-2021). Sin ajuste, `TM` y `DT` repetirían ahí los valores de la
última fecha, lo que confunde. Se dejan **vacíos**, igual que ya pasa con *Ticket Promedio*. En `@var=3` esa
fila no existe, así que no cambia nada.

**Lo que no cambia**: los cálculos, las tablas que lee, los parámetros y las variantes 1 a 5. **El front no
necesita cambios**: las columnas salen de la cabecera.

### Resultado esperado de la tabla *Evolución de TAPP Mes*

| Fecha | Encima Tasa Mínima | A la Tasa Mínima | Administrador | … | TAPP Total Autonomías | TAPP Final | Ticket Promedio | **TAPP Mínima** | **Distancia (en pbs)** |
|---|---|---|---|---|---|---|---|---|---|
| 2024-03-01 | … | … | … | … | … | 38,12 % | 4 850 | **36,90 %** | **122** |
| … | | | | | | | | | |
| 2024-03-19 (%) | … | … | … | … | … | … | … | **…** | **…** |
| Var Abs (pbs) | … | … | … | … | … | 45 | | *(vacío)* | *(vacío)* |

(Los números son ilustrativos.)

## 3. Riesgos y cómo se cubren

### Riesgo de tildes

En la copia extraída, los textos con tilde aparecen con un espacio: `"TAPP M nima"`, `"Autonom as"`,
`[Gte. Divisi n Comercial]`. No hay forma de saber desde acá si **producción** está así o si las tildes se
perdieron al extraer. Importa porque `[Gte. Divisi n Comercial]` no es solo un texto: es nombre de columna
del `PIVOT` sobre `HUCAP_FIN` y tiene que coincidir con los datos.

- Si producción **tiene las tildes** y se ejecuta el script completo, se reemplazarían por espacios: los
  títulos se verían mal y la columna *Gte. División Comercial* podría quedar en cero.
- Por eso `04-verificacion.sql` (paso 1) compara el SP de producción con la copia **antes** de ejecutar.
  Si no coinciden, se aplican a mano solo los dos cambios marcados `MOD-0001` sobre el script que da SSMS
  (clic derecho › Modificar), sin tocar el resto.
- Hallazgo para el repositorio: revisar por qué la extracción dejó espacios en lugar de tildes antes de usar
  cualquier cuerpo de `extraccion/procedimientos/` para generar un `ALTER`.

### Versión vigente

El script parte de la versión modificada en la base el **2024-07-04 04:29:22**. Si el paso 1 muestra una fecha
posterior, alguien cambió el SP después: aplicar los cambios a mano sobre la versión actual.

### Otros consumidores

El mismo SP atiende `GST_ACTIVAS_M_06` (por el nombre, la versión mensual del reporte): también mostrará las
dos columnas, que es lo coherente. Ningún otro reporte del catálogo ejecuta este SP.

## 4. Pasos

1. Respaldar el SP actual (SSMS › clic derecho › *Generar script como › ALTER*) o usar `05-…rollback.sql`.
2. `04-verificacion.sql` paso 1 → decidir si se ejecuta `03-…alter.sql` completo o los cambios a mano.
3. `04-verificacion.sql` paso 2 antes del cambio (guardar resultado).
4. Ejecutar el cambio.
5. `04-verificacion.sql` pasos 2 y 3: `@var=6` trae TM y DT y cuadran con el recálculo; `@var=3` idéntico al de antes.
6. Revisar en el front la pestaña *Evolutivo* de Autonomía de Tasas.
7. Volver a extraer el SP (`python extraccion/herramientas/bd.py extraer --sp GDCGEST_ACTIVAST01 --sobrescribir`)
   y `npm run generar`, para que el diccionario refleje la versión nueva. Marcar esta modificación como *aplicada*.
