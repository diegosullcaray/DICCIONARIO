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

## 2. Enfoque: SP nuevo, el original no se toca

Se crea **`mod_rep.com.GDCGEST_ACTIVAST01_NEW`**, copia exacta del original con los dos cambios de abajo.

| | Modificar el original (`ALTER`) | **SP nuevo `_NEW`** (elegido) |
|---|---|---|
| Riesgo para el reporte en producción | lo cambia al instante | ninguno hasta apuntar el reporte |
| Prueba | antes/después, sobre el mismo objeto | original y nuevo lado a lado, mismos parámetros |
| Vuelta atrás | volver a ejecutar la versión anterior | reapuntar el reporte; el original sigue intacto |
| Costo | — | un paso más: apuntar `GST_ACTIVAS_06` al nuevo SP; y dos SP casi iguales hasta retirar uno |

## 3. Cambios

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

**Lo que no cambia**: los cálculos, las tablas que lee, los parámetros y las variantes 1 a 5 (el SP nuevo es
una copia exacta salvo estos dos cambios). **El front no necesita cambios**: las columnas salen de la cabecera.

### Resultado esperado de la tabla *Evolución de TAPP Mes*

| Fecha | Encima Tasa Mínima | A la Tasa Mínima | Administrador | … | TAPP Total Autonomías | TAPP Final | Ticket Promedio | **TAPP Mínima** | **Distancia (en pbs)** |
|---|---|---|---|---|---|---|---|---|---|
| 2024-03-01 | … | … | … | … | … | 38,12 % | 4 850 | **36,90 %** | **122** |
| … | | | | | | | | | |
| 2024-03-19 (%) | … | … | … | … | … | … | … | **…** | **…** |
| Var Abs (pbs) | … | … | … | … | … | 45 | | *(vacío)* | *(vacío)* |

(Los números son ilustrativos.)

## 4. Riesgos y cómo se cubren

### Riesgo de tildes

En la copia extraída, los textos con tilde aparecen con un espacio: `"TAPP M nima"`, `"Autonom as"`,
`[Gte. Divisi n Comercial]`. No hay forma de saber desde acá si el original en producción está así o si las
tildes se perdieron al extraer. Importa porque `[Gte. Divisi n Comercial]` no es solo un texto: es nombre
de columna del `PIVOT` sobre `HUCAP_FIN` y tiene que coincidir con los datos.

Con el SP nuevo este riesgo **ya no puede romper el reporte vigente**, pero sí el nuevo:

- `04-verificacion.sql` paso 1 lo detecta antes de crearlo (`con_tilde > 0`): en ese caso se corrigen esos
  textos en `03-…_NEW.create.sql` antes de ejecutarlo.
- El paso 2 lo detectaría igual después: la columna *Gte. División Comercial* saldría en cero solo en el nuevo.
- Hallazgo para el repositorio: revisar por qué la extracción dejó espacios en lugar de tildes antes de usar
  cualquier cuerpo de `extraccion/procedimientos/` como base de un SP.

### Versión vigente

El SP nuevo parte de la versión del original modificada el **2024-07-04 04:29:22**. Si el paso 1 muestra una
fecha posterior, alguien cambió el original después: volver a extraerlo y rehacer el `_NEW` desde esa versión,
para que el nuevo no pierda ese cambio.

### Qué reportes pasan al nuevo

Solo `GST_ACTIVAS_06` y `GST_ACTIVAS_M_06` (por el nombre, la versión mensual): los dos piden `@var = 6`. Los
`GST_ACTIVAS_01…05` y `_M_01…05` siguen con el original, que no cambia.

## 5. Pasos

1. `04-verificacion.sql` **paso 1**: confirmar fecha de modificación y tildes del original.
2. Ejecutar `03-GDCGEST_ACTIVAST01_NEW.create.sql` (crea el SP nuevo; el original no cambia).
3. `04-verificacion.sql` **paso 2**: original y nuevo lado a lado — `@var=6` igual más TM y DT; `@var=1…5` idénticos.
4. `04-verificacion.sql` **paso 3**: TM y DT de la última fecha cuadran con el recálculo desde `WGATH002`.
5. `06-activacion.sql`: apunta los reportes **`GST_ACTIVAS_06`** y **`GST_ACTIVAS_M_06`** a
   `mod_rep.com.GDCGEST_ACTIVAST01_NEW` en el catálogo del backend, `[mod_rep].[rep].[RREGREP01]` (campo
   `RTPREP`; los parámetros no cambian). Solo esos dos: el resto de `GST_ACTIVAS_*` sigue con el original.
   Deja la transacción abierta para revisar antes del `COMMIT`.
6. Revisar en el front la pestaña *Evolutivo* de Autonomía de Tasas: la tabla *Evolución de TAPP Mes* muestra
   *TAPP Mínima* y *Distancia (en pbs)*. El front no se modifica.
7. Reexportar `extraccion/fuente/reportes.json`, extraer el SP nuevo
   (`python extraccion/herramientas/bd.py extraer --sp GDCGEST_ACTIVAST01_NEW`) y `npm run generar`, para que
   el diccionario lo documente. Marcar esta modificación como *aplicada*.

Para volver atrás: `05-rollback.sql` (reapuntar en `RREGREP01` los dos reportes al original y borrar el nuevo).

### Después: no dejar dos SP para siempre

Mientras convivan, un arreglo futuro en uno no llega al otro. Cuando el nuevo esté validado en producción,
conviene decidir entre: (a) apuntar también `GST_ACTIVAS_01…05` y `_M_01…05` al nuevo y retirar el original,
o (b) pasar los dos cambios al original y retirar el nuevo.
