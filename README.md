# DICCIONARIO — reportes MIS

Diccionario de datos de los reportes del MIS de Financiera Confianza: para cada reporte (`RCODREP`),
**qué procedimiento almacenado ejecuta, qué tablas usa y qué columnas de cada una**.

| Empezar por | |
|---|---|
| El diccionario: avance, reportes, procedimientos, tablas | [diccionario/README.md](diccionario/README.md) |
| Qué está mal hoy, agrupado por quién lo corrige | [hallazgos](governance/docs/evidence/quality/hallazgos.md) |
| Cómo se trabaja: docs, agentes, skills, scripts | [governance/readme.md](governance/readme.md) |
| Reglas para personas y agentes | [AGENTS.md](AGENTS.md) |

## Estructura

```text
DICCIONARIO/
├── fuente/            entradas: catálogo de reportes, resultados del motor, estructura real, consumo del front
├── procedimientos/    cuerpo de cada SP, tal cual sale de la base: <base>/<esquema>/<SP>.sql
├── sql/               todo lo que se ejecuta en SQL Server (solo lectura)
├── diccionario/       el producto: fichas por SP y por tabla, índices y diccionario.json
├── herramientas/      Python: conexión a SQL Server (extraer, dependencias, estructura, mapa)
├── governance/        docs, agentes, skills, scripts Node y línea base
└── .claude/           copia de agentes y skills para Claude Code (generada)
```

Qué hay en cada carpeta y qué se edita a mano: [visión general](governance/docs/architecture/system-overview.md).

## Comandos

Requiere Node 20+ (sin dependencias) y, para conectarse a la base, Python con
[`herramientas/requirements.txt`](herramientas/requirements.txt).

```bash
# Con la base (mismo .env que REPORTES-AUTOMATIZADOS)
python herramientas/bd.py --env ../REPORTES-AUTOMATIZADOS/backend/.env todo   # extrae, valida y regenera
python herramientas/bd.py mapa --reporte SEL_EFEC_01                          # qué tablas y columnas usa

# Sin la base
npm run generar      # regenera SQL, diccionario y copias de agentes
npm run verificar    # falla ante errores nuevos o algo viejo, roto o inconsistente
npm run hallazgos    # todos los hallazgos, incluidos los conocidos
npm test             # analizador T-SQL
npm run test:py      # herramientas Python (sin servidor)
```

Paso a paso, con y sin Python: [flujo de trabajo](governance/docs/development/workflow.md).
Todos los comandos de Python: [herramientas/README.md](herramientas/README.md).
