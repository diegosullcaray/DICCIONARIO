# Marco de gobernanza — DICCIONARIO

Centro de gobernanza, automatización y estándares del diccionario de datos de los reportes MIS.
Sigue la misma organización que la gobernanza de MIS-angular-front, con el dato —y no la pantalla— como eje.

```text
governance/
  ├── scripts/      automatización: generación, análisis T-SQL, validación, traza con el front
  ├── skills/       guías operativas para personas y agentes
  ├── agents/       pipeline de 5 agentes + 2 transversales
  ├── docs/         documentación canónica
  └── readme.md
```

**Regla que gobierna todo lo demás: cuando el documento y la fuente discrepan, gana la fuente.**
La fuente es el cuerpo del SP en la base; después `fuente/reportes.json`. El documento se corrige.

---

## 1. Verificación

```bash
npm run generar       # SQL de extracción + diccionario + copias de agentes (segundos, sin base de datos)
npm run verificar     # hallazgos, generados al día, enlaces, índice de skills
npm test              # pruebas del analizador T-SQL
```

Qué verifica cada compuerta y qué bloquea: [compuertas de calidad](./docs/development/quality-gates.md).

## 2. Scripts (`governance/scripts/`)

| Script | Para qué |
|---|---|
| [`generar-extraccion.mjs`](./scripts/generar-extraccion.mjs) | un SQL de extracción por SP, lotes por base, manifiesto y SQL de dependencias |
| [`generar-diccionario.mjs`](./scripts/generar-diccionario.mjs) | fichas de SP y tabla, índices, JSON, SQL por tabla y bloques de docs |
| [`validar.mjs`](./scripts/validar.mjs) | hallazgos de calidad, generados al día, enlaces y skills |
| [`trazar-front.mjs`](./scripts/trazar-front.mjs) | qué RCODREP consume MIS-angular-front |
| [`sincronizar-agentes.mjs`](./scripts/sincronizar-agentes.mjs) | copia agentes y skills a `.claude/` |
| [`extraer-definiciones.ps1`](./scripts/extraer-definiciones.ps1) | baja en lote los cuerpos de SP con `sqlcmd` (Windows) |

Manual completo: [`scripts/README.md`](./scripts/README.md).

## 3. Skills (`governance/skills/`)

| Skill | Qué resuelve |
|---|---|
| [`dic-extraccion-sp`](./skills/dic-extraccion-sp/SKILL.md) | sacar el cuerpo de un SP de la base y dejarlo donde el diccionario lo lee |
| [`dic-analisis-dependencias`](./skills/dic-analisis-dependencias/SKILL.md) | qué tablas y columnas usa un SP: analizador, motor y sus límites |
| [`dic-lectura-tsql`](./skills/dic-lectura-tsql/SKILL.md) | patrones de los SP de reportes y cómo leerlos sin equivocarse |
| [`dic-fichas`](./skills/dic-fichas/SKILL.md) | documentar propósito, reglas y columnas sin pisar lo generado |
| [`dic-trazabilidad-front`](./skills/dic-trazabilidad-front/SKILL.md) | unir un RCODREP con su pantalla del MIS y con su tabla de origen |

## 4. Agentes (`governance/agents/`)

Pipeline de cinco fases, cada una con criterio de rechazo explícito:

1. [Extractor de procedimientos](./agents/01-extractor-procedimientos.md) — trae el cuerpo fiel del SP
2. [Analista de dependencias](./agents/02-analista-dependencias.md) — tablas y columnas, con su confianza
3. [Documentador del diccionario](./agents/03-documentador-diccionario.md) — propósito, reglas y columnas
4. [Auditor de calidad del dato](./agents/04-auditor-calidad-dato.md) — que el diccionario no mienta
5. [Revisor de seguridad y acceso](./agents/05-revisor-seguridad.md) — última compuerta antes del commit

Y dos transversales:

- [Curador de gobernanza](./agents/06-curador-gobernanza.md) — persigue la deriva entre fuente, diccionario y docs
- [Trazador del front](./agents/07-trazador-front.md) — conecta cada RCODREP con su pantalla en MIS-angular-front

Detalle del flujo: [`agents/README.md`](./agents/README.md).

## 5. Documentación (`governance/docs/`)

| Área | Qué contiene |
|---|---|
| [`data/`](./docs/data/README.md) | glosario, catálogo, linaje, calidad y responsabilidades |
| [`architecture/`](./docs/architecture/README.md) | cómo está armado el repositorio y sus ADR |
| [`development/`](./docs/development/README.md) | flujo de trabajo, convenciones y compuertas |
| [`templates/`](./docs/templates/README.md) | ficha de SP, ficha de tabla, hallazgo y PR |
| [`evidence/`](./docs/evidence/README.md) | hallazgos de calidad derivados |

Entradas frecuentes: [índice general](./docs/README.md) · [onboarding](./docs/onboarding.md) · [flujo de trabajo](./docs/development/workflow.md) · [glosario](./docs/data/glossary.md)
