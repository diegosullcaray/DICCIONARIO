# Modificaciones

Cambios pedidos a los procedimientos de reportes: análisis y scripts listos para ejecutar en SQL Server.
Este repositorio **no ejecuta** nada en la base: el script lo corre quien tenga permiso, después de verificarlo.

## Convención

Una carpeta por pedido, numerada: `NNNN-<tema-corto>/`, con los archivos en este orden:

| Archivo | Contenido |
|---|---|
| `01-peticion.md` | el pedido tal como llegó, cómo se interpretó y qué se entrega |
| `02-analisis.md` | cómo funciona hoy el SP, qué cambia y por qué, riesgos, pasos |
| `03-<SP>_NEW.create.sql` | el SP nuevo (`CREATE PROCEDURE … _NEW`): copia del original con los cambios marcados `MOD-NNNN` |
| `04-verificacion.sql` | chequeo previo, prueba antes/después y cuadre |
| `05-rollback.sql` | volver atrás: reapuntar el reporte al original y borrar el `_NEW` |

Reglas:

- **El original no se modifica**: se crea `<SP>_NEW` y se prueba lado a lado con el original. El reporte pasa
  al nuevo cuando se lo apunta en la tabla de reportes del backend; volver atrás es reapuntarlo.
- El `_NEW` parte de la copia en `extraccion/procedimientos/`, con la fecha de modificación anotada; la
  verificación previa confirma que producción no cambió desde entonces.
- Dos SP casi iguales no se dejan para siempre: una vez validado, se decide cuál se retira.
- Una vez aplicado: volver a extraer el SP, `npm run generar`, y pasar el estado a **aplicado** en `01-peticion.md`.

## Registro

| N.º | Tema | SP | Reporte | Estado |
|---|---|---|---|---|
| [0001](./0001-evolucion-tapp-minima-distancia/01-peticion.md) | TAPP Mínima y Distancia en Evolución de TAPP Mes | `mod_rep.com.GDCGEST_ACTIVAST01_NEW` | `GST_ACTIVAS_06` | propuesto |
