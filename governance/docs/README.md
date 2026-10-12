# Documentación — DICCIONARIO

Diccionario de datos de los reportes MIS: qué SP ejecuta cada reporte, qué tablas usa y qué columnas.

## Estructura

Organizada por responsabilidad, igual que la gobernanza de MIS-angular-front. **[`data/`](./data/) es el eje.**

| Área | Responsabilidad |
|---|---|
| [`data/`](./data/README.md) | **Gobierno del dato**: glosario, catálogo, linaje, calidad y responsabilidades |
| [`architecture/`](./architecture/README.md) | Cómo está armado el repositorio y por qué (ADR) |
| [`development/`](./development/README.md) | Flujo de trabajo, convenciones y compuertas |
| [`templates/`](./templates/README.md) | Ficha de SP, ficha de tabla, hallazgo, PR |
| [`evidence/`](./evidence/README.md) | Evidencia derivada: hallazgos de calidad |
| [`onboarding.md`](./onboarding.md) | Primer día y ruta de lectura |

## Por dónde empezar

| Si querés… | Leé |
|---|---|
| Saber qué SP ejecuta un reporte | [diccionario/reportes.md](../../diccionario/reportes.md) |
| Saber qué reportes usan una tabla | [diccionario/tablas.md](../../diccionario/tablas.md) |
| Documentar un SP nuevo | [Flujo de trabajo](./development/workflow.md) |
| Entender un término (`tip_cod`, `inferida`, `validado`) | [Glosario](./data/glossary.md) |
| Rastrear una cifra de la pantalla a la tabla | [Linaje](./data/lineage.md) |
| Ver qué está mal en la fuente | [Hallazgos](./evidence/quality/hallazgos.md) |
| Saber qué verifica `npm run verificar` | [Compuertas de calidad](./development/quality-gates.md) |
| Entender por qué hay dos fuentes de dependencias | [ADR-0003](./architecture/adr/ADR-0003-dos-fuentes-de-dependencias.md) |

## Cómo se mantiene esta documentación

- **Cuando el documento y la fuente discrepan, gana la fuente.** El documento se corrige o se borra.
- **Lo que cambia con cada SP se deriva, no se escribe.** Catálogo, fichas, índices y hallazgos se
  generan con `npm run generar` entre marcadores `<!-- generado:inicio … -->`.
- **Lo que sí se escribe a mano**: el propósito de un SP, sus reglas de negocio, la descripción de cada
  columna y las trampas que ya costaron un error.
- **Se verifica automáticamente.** `npm run verificar` detecta enlaces rotos y generados viejos.
