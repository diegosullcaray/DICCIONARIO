# Onboarding

Ruta de lectura para el primer día, en orden.

1. [README del repositorio](../../README.md) — qué es y la estructura de carpetas.
2. [AGENTS.md](../../AGENTS.md) — las reglas que no se negocian.
3. [Glosario](./data/glossary.md) — `RCODREP`, `tip_cod`, `cod_rel`, estados y confianza.
4. [Flujo de trabajo](./development/workflow.md) — de `reportes.json` a la ficha validada.
5. Una ficha real: [mod_rep.com.GSELREP001](../../diccionario/procedimientos/mod_rep/com/GSELREP001.md)
   y su [cuerpo](../../procedimientos/mod_rep/com/GSELREP001.sql). Comparar los dos es la mejor forma
   de entender qué hace el analizador.
6. [Skill de lectura T-SQL](../skills/dic-lectura-tsql/SKILL.md) — los patrones de los SP de reportes.

## Primer ejercicio

Elegí un SP ⏳ pendiente de [procedimientos.md](../../diccionario/procedimientos.md) que el front consuma,
y llevalo a 🔎 extraído:

```bash
# 1. abrir sql/01-extraccion/<base>/<esquema>/<SP>.sql en SSMS y ejecutarlo
# 2. pegar el resultado en procedimientos/<base>/<esquema>/<SP>.sql
npm run generar
npm run verificar
npm test
```

Revisá la ficha generada contra el cuerpo: ¿falta alguna tabla? ¿alguna columna `≈ inferida` es en
realidad de otra tabla? Si el analizador se equivocó, el arreglo empieza por un caso en
`governance/scripts/tests/tsql.test.mjs`.

## Herramientas

- Node 20+ (no hay `npm install`).
- SQL Server Management Studio o `sqlcmd`, con acceso de lectura a las bases `mod_rep`, `strategos`,
  `mod_gpa`, `mod_sec` y `storage`.
- Opcional: un clon de MIS-angular-front al lado de este repositorio, para `npm run trazar:front`.
