# DICCIONARIO — reportes MIS

Diccionario de datos de los reportes del MIS de Financiera Confianza: para cada reporte (`RCODREP`),
**qué procedimiento almacenado ejecuta, qué tablas usa y qué columnas de cada una**.

| Empezar por | |
|---|---|
| El diccionario: avance, reportes, procedimientos, tablas | [diccionario/README.md](diccionario/README.md) |
| Qué está mal y qué falta, al detalle | [errores/](errores/README.md) |
| Todas las tablas: para qué sirven y qué columnas se usan | [diccionario/diccionario-tablas.xlsx](diccionario/diccionario-tablas.xlsx) |
| Cómo se trabaja: docs, agentes, skills, scripts | [governance/readme.md](governance/readme.md) |
| Reglas para personas y agentes | [AGENTS.md](AGENTS.md) |

## Estructura

```text
DICCIONARIO/
├── diccionario/   el producto: fichas por SP y por tabla, índices y diccionario.json
├── governance/    cómo se trabaja: docs, agentes, skills, scripts Node y línea base
├── extraccion/    el proceso que trae los datos de SQL Server: herramientas, sql, procedimientos y fuentes
├── errores/      qué está mal y qué falta: producción, catálogo, análisis y pendientes (generado)
├── modificaciones/ cambios pedidos a los SP: petición, análisis, SP _NEW, verificación y rollback
└── .claude/       copia de agentes y skills para Claude Code (generada)
```

Qué hay dentro de `extraccion/`: [extraccion/README.md](extraccion/README.md). Qué es fuente, qué es derivado
y qué se edita a mano: [visión general](governance/docs/architecture/system-overview.md).

## Comandos

Requiere Node 20+ (sin dependencias) y, para conectarse a la base, Python con
[`extraccion/herramientas/requirements.txt`](extraccion/herramientas/requirements.txt).

```bash
# Con la base (mismo .env que REPORTES-AUTOMATIZADOS)
python extraccion/herramientas/bd.py --env ../REPORTES-AUTOMATIZADOS/backend/.env todo   # extrae, valida y regenera
python extraccion/herramientas/bd.py mapa --reporte SEL_EFEC_01                          # qué tablas y columnas usa

# Sin la base
npm run generar      # regenera SQL, diccionario y copias de agentes
npm run excel        # diccionario/diccionario-tablas.xlsx (requiere openpyxl)
npm run verificar    # falla ante errores nuevos o algo viejo, roto o inconsistente
npm run hallazgos    # todos los hallazgos, incluidos los conocidos
npm test             # analizador T-SQL
npm run test:py      # herramientas Python (sin servidor)
```

Paso a paso, con y sin Python: [flujo de trabajo](governance/docs/development/workflow.md).
Todos los comandos de Python: [extraccion/herramientas/README.md](extraccion/herramientas/README.md).
