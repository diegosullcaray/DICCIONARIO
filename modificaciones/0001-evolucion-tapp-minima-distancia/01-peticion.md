# MOD-0001 · Petición

**Fecha**: 2026-10-13 · **Solicita**: Diego Sullcaray · **Estado**: propuesto (script listo, sin ejecutar)

**Enfoque**: SP nuevo `GDCGEST_ACTIVAST01_NEW` en lugar de modificar el original (decisión del solicitante, 2026-10-13).

## Pedido, tal como llegó

> En base a la documentación que se tiene de los reportes, dentro de reportes diaria de autonomía de tasas:
> en GDCEST_ACTIVAS03, en las tablas se agrega dos columnas, TAPP M mínima y distancia. Ahora quiero que en
> la tabla de evolución de TAPP mes, GDCEST_ACTIVAS05, se agreguen esas columnas. Analiza la lógica dentro
> del SP y dame el SP para modificar.

## Cómo se interpretó

| En el pedido | En el sistema |
|---|---|
| Reporte diario de Autonomía de Tasas | MIS-angular-front › Reportes › Actividad diaria › Cartera › *Autonomía de Tasas* (`autonomia-tasas.component.ts`) |
| "GDCEST_ACTIVAS03" (la tabla que ya tiene las columnas) | reporte `GST_ACTIVAS_03` = SP `mod_rep.com.GDCGEST_ACTIVAST01` con `@var = 3`: *TAPP Mes de operaciones desembolsadas por producto y nivel de tasas* |
| "GDCEST_ACTIVAS05", la tabla de evolución de TAPP Mes | **`GST_ACTIVAS_06`** = el mismo SP con **`@var = 6`**: *Evolución de TAPP Mes (días hábiles)* |

> ⚠️ **Confirmar**: según el propio SP, `@var = 5` es *Evolución de monto desembolsado* y `@var = 6` es
> *Evolución de TAPP Mes*; el front muestra los mismos títulos en ese orden. Se tomó el **6** porque el pedido
> habla de la evolución de TAPP Mes. Si era la tabla de monto (`@var = 5`), avisar: el cambio es el mismo
> pero en el bloque `if @var = 5`.

Las dos tablas salen de **un solo SP** (`GDCGEST_ACTIVAST01`); no existe un `GDCGEST_ACTIVAST05`. El SP
`GDCGEST_ACTIVAST03` sí existe, pero es otro: arma las tablas de los reportes `GST_ACTIVAS_07` y `_08`.

## Qué se entrega

| Archivo | Para qué |
|---|---|
| [02-analisis.md](./02-analisis.md) | cómo calcula hoy el SP, qué cambia y por qué, riesgos |
| [03-GDCGEST_ACTIVAST01_NEW.create.sql](./03-GDCGEST_ACTIVAST01_NEW.create.sql) | crea el SP nuevo: copia del original con los 2 cambios |
| [04-verificacion.sql](./04-verificacion.sql) | chequeo previo, original y nuevo lado a lado, cuadre |
| [05-rollback.sql](./05-rollback.sql) | volver al original y borrar el nuevo |
| [06-activacion.sql](./06-activacion.sql) | apuntar `GST_ACTIVAS_06` y `GST_ACTIVAS_M_06` al nuevo en `RREGREP01`: así el front muestra las columnas |
