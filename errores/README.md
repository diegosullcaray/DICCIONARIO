# Errores encontrados

Qué está mal y qué falta, ubicado al detalle: en qué SP y en qué línea, qué reportes lo ejecutan y en
qué pantalla del front se ve. **Se genera** con `npm run generar`: para que algo salga de esta lista se
corrige la causa (en la base, en el catálogo o en una ficha) y se vuelve a extraer y generar.

<!-- generado:inicio resumen -->
<!-- Generado por governance/scripts/generar-errores.mjs. No editar dentro de este bloque: se regenera. -->

| Origen | Dónde se corrige | Errores | Avisos | Nuevos | Detalle |
|---|---|---:|---:|---:|---|
| catalogo | corregir en la tabla de reportes del backend y reexportar | 0 | 3 | 0 | [02-catalogo.md](./02-catalogo.md) |
| produccion | reportar al dueño del SP; acá no se corrige | 27 | 0 | 0 | [01-produccion.md](./01-produccion.md) |
| repositorio | corregir en este repo | 0 | 0 | 0 | — |
| analisis | revisar a mano y anotar en la ficha | 0 | 70 | 0 | [03-analisis.md](./03-analisis.md) |

| Producción, al detalle | Cantidad |
|---|---:|
| SP del catálogo que no existen | 0 |
| Tablas que no existen | 19 |
| Columnas que no existen | 6 |
| Reportes con parámetros que no cuadran | 2 |

Lo que falta para completar el diccionario: [04-pendientes.md](./04-pendientes.md) — 2 SP sin extraer, 4 sin validar, 268 SP y 202 tablas sin documentar.
<!-- generado:fin -->

## Cómo leerlo

- **Origen** dice quién lo corrige; las reglas y su significado están en [calidad del dato](../governance/docs/data/quality.md).
- **Nuevos** son los que no están en la línea base: aparecieron en la última extracción y hacen fallar `npm run verificar`.
  Los conocidos se congelan en `governance/linea-base.json` ([ADR-0006](../governance/docs/architecture/adr/ADR-0006-linea-base-de-hallazgos.md)).
