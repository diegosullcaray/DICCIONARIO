# Gobernanza — DICCIONARIO

Índice único de cómo se trabaja en este repositorio: documentación, agentes, skills y scripts.
Misma organización que la gobernanza de MIS-angular-front, con el dato como eje.

**Regla que gobierna todo lo demás: cuando el documento y la fuente discrepan, gana la fuente**
(el cuerpo del SP en la base; después `fuente/reportes.json`). El documento se corrige.

```text
governance/
  ├── docs/           documentación canónica (índice abajo)
  ├── agents/         pipeline de 5 agentes + 2 transversales
  ├── skills/         guías operativas para personas y agentes
  ├── scripts/        generación, análisis T-SQL y validación (Node)
  ├── linea-base.json hallazgos conocidos y aceptados (ADR-0006)
  └── readme.md       este índice
```

## Documentación

Cada tema vive en un solo documento; los demás enlazan.

| Necesito… | Documento |
|---|---|
| Empezar | [Onboarding](./docs/onboarding.md) |
| Entender cómo está armado: fuentes, modelo, derivados, qué se edita a mano | [Visión general](./docs/architecture/system-overview.md) |
| Hacer el trabajo: extraer, validar, documentar | [Flujo de trabajo](./docs/development/workflow.md) |
| Saber cómo se nombra y se commitea | [Convenciones](./docs/development/conventions.md) |
| Entender un término (`tip_cod`, estados, confianza) | [Glosario](./docs/data/glossary.md) |
| Ver el inventario por base | [Catálogo](./docs/data/catalog.md) |
| Rastrear una cifra de la tabla a la pantalla | [Linaje](./docs/data/lineage.md) |
| Saber qué controla `npm run verificar` y cada regla | [Calidad](./docs/data/quality.md) |
| Saber quién decide sobre cada pieza | [Responsabilidades](./docs/data/stewardship.md) |
| Ver qué está mal hoy, por origen | [Hallazgos](./docs/evidence/quality/hallazgos.md) |

**Decisiones (ADR)**

| ADR | Decisión |
|---|---|
| [0001](./docs/architecture/adr/ADR-0001-un-archivo-por-objeto.md) | Un archivo por SP y por tabla, en carpetas `<base>/<esquema>` |
| [0002](./docs/architecture/adr/ADR-0002-diccionario-derivado.md) | El diccionario se deriva; la prosa vive debajo del bloque generado |
| [0003](./docs/architecture/adr/ADR-0003-dos-fuentes-de-dependencias.md) | Analizador estático + motor, con confianza explícita |
| [0004](./docs/architecture/adr/ADR-0004-extraccion-por-sp-no-por-reporte.md) | SQL de extracción por SP, no por RCODREP |
| [0005](./docs/architecture/adr/ADR-0005-conexion-python-compartida.md) | Conexión desde Python con el contrato de REPORTES-AUTOMATIZADOS |
| [0006](./docs/architecture/adr/ADR-0006-linea-base-de-hallazgos.md) | Línea base: producción se documenta, no bloquea |

**Plantillas** ([`docs/templates/`](./docs/templates/)): [ficha de SP](./docs/templates/ficha-procedimiento.md) ·
[ficha de tabla](./docs/templates/ficha-tabla.md) · [hallazgo manual](./docs/templates/hallazgo.md) ·
[ADR](./docs/templates/adr-template.md) · [PR](./docs/templates/pull-request.md)

## Agentes

Pipeline de cinco fases y dos transversales; detalle y criterios de rechazo en [`agents/README.md`](./agents/README.md).

1. [Extractor de procedimientos](./agents/01-extractor-procedimientos.md) — cuerpo fiel del SP
2. [Analista de dependencias](./agents/02-analista-dependencias.md) — tablas y columnas con su confianza
3. [Documentador](./agents/03-documentador-diccionario.md) — propósito, reglas y columnas
4. [Auditor de calidad](./agents/04-auditor-calidad-dato.md) — que el diccionario no mienta
5. [Revisor de seguridad](./agents/05-revisor-seguridad.md) — nada sensible en el repo
- [Curador de gobernanza](./agents/06-curador-gobernanza.md) · [Trazador del front](./agents/07-trazador-front.md)

## Skills

| Skill | Qué resuelve |
|---|---|
| [`dic-conexiones-bd`](./skills/dic-conexiones-bd/SKILL.md) | servidores, `.env` y diagnóstico de conexión |
| [`dic-extraccion-sp`](./skills/dic-extraccion-sp/SKILL.md) | sacar el cuerpo de un SP y verificarlo |
| [`dic-analisis-dependencias`](./skills/dic-analisis-dependencias/SKILL.md) | leer y corregir tablas y columnas de una ficha |
| [`dic-lectura-tsql`](./skills/dic-lectura-tsql/SKILL.md) | patrones de los SP de reportes |
| [`dic-fichas`](./skills/dic-fichas/SKILL.md) | documentar sin que la regeneración pise el trabajo |
| [`dic-trazabilidad-front`](./skills/dic-trazabilidad-front/SKILL.md) | RCODREP ↔ pantalla ↔ tabla |

## Scripts

Node en [`scripts/`](./scripts/README.md) (generar, validar, trazar el front) y Python en
[`herramientas/`](../herramientas/README.md) (conexión a SQL Server). Los comandos de uso diario están
en el [README](../README.md#comandos).
