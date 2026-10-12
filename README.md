# DICCIONARIO — reportes MIS

Diccionario de datos de los reportes del MIS de Financiera Confianza: para cada reporte (`RCODREP`),
**qué procedimiento almacenado ejecuta, qué tablas usa y qué columnas de cada una**.

## Estructura

```text
DICCIONARIO/
├── fuente/                    entradas: lo que viene de afuera
│   ├── reportes.json          catálogo RCODREP → SP → parámetros (export del backend)
│   ├── dependencias/          resultados del motor, uno por base (<base>.csv)
│   └── consumo-front.json     qué RCODREP usa MIS-angular-front (foto)
├── procedimientos/            cuerpo de cada SP: <base>/<esquema>/<SP>.sql
├── sql/                       todo lo que se ejecuta en SQL Server
│   ├── 01-extraccion/         sp_helptext por SP, lotes por base y manifiesto   (generado)
│   ├── 02-dependencias/       tablas y columnas según el motor, por base         (generado)
│   ├── 03-tablas/             estructura, muestra y perfil de cada tabla usada   (generado)
│   └── 04-consultas/          consultas utilitarias                              (a mano)
├── diccionario/               el producto: fichas, índices y JSON               (generado + prosa)
├── governance/                cómo se trabaja: docs, agentes, skills y scripts
├── .claude/                   copia de agentes y skills para Claude Code         (generado)
├── AGENTS.md                  reglas para personas y agentes
└── package.json               comandos
```

## Arranque

Requiere Node 20 o superior. No hay dependencias que instalar.

```bash
npm run generar      # regenera SQL de extracción, diccionario y copias de agentes
npm run verificar    # falla si algo quedó viejo, roto o inconsistente
npm test             # pruebas del analizador T-SQL
npm run hallazgos    # lista completa de problemas de calidad
```

## Documentar un reporte en 4 pasos

1. Buscar el SP del reporte en [diccionario/reportes.md](diccionario/reportes.md).
2. Ejecutar en SSMS su `sql/01-extraccion/<base>/<esquema>/<SP>.sql` y pegar el resultado en
   `procedimientos/<base>/<esquema>/<SP>.sql` (o bajar todos con `governance/scripts/extraer-definiciones.ps1`).
3. `npm run generar`: aparece la ficha con tablas, columnas, firma y salida.
4. Opcional, para pasar de 🔎 extraído a ✅ validado: ejecutar `sql/02-dependencias/<base>.sql`,
   guardar el resultado como `fuente/dependencias/<base>.csv` y volver a generar.

Guía completa: [flujo de trabajo](governance/docs/development/workflow.md).

## Documentación

- [Diccionario: avance e índice](diccionario/README.md)
- [Marco de gobernanza](governance/readme.md)
- [Onboarding](governance/docs/onboarding.md)
- [Glosario](governance/docs/data/glossary.md)
- [Hallazgos de calidad](governance/docs/evidence/quality/hallazgos.md)
- [Agentes](governance/agents/README.md)
