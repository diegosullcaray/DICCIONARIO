# Onboarding

Ruta de lectura para el primer día, en orden:

1. [README](../../README.md) — qué es, estructura y comandos.
2. [AGENTS.md](../../AGENTS.md) — las reglas que no se negocian.
3. [Visión general](./architecture/system-overview.md) — fuentes, derivados y qué se edita a mano.
4. [Glosario](./data/glossary.md) — `RCODREP`, `tip_cod`, estados de un SP y confianza de una columna.
5. [Flujo de trabajo](./development/workflow.md) — de la base a la ficha.
6. Una ficha real: [mod_rep.com.GSELREP001](../../diccionario/procedimientos/mod_rep/com/GSELREP001.md) y su
   [cuerpo](../../extraccion/procedimientos/mod_rep/com/GSELREP001.sql). Compararlos es la mejor forma de entender qué
   hace el analizador.

## Primer ejercicio

Elegí un SP con *Front* = sí en [procedimientos.md](../../diccionario/procedimientos.md), leé su ficha contra
su cuerpo y completá su *Propósito* con la skill [dic-fichas](../skills/dic-fichas/SKILL.md). Si el analizador
se equivocó, el arreglo empieza por un caso en `governance/scripts/tests/tsql.test.mjs`.

## Herramientas

Node 20+, Python 3.11+ con «ODBC Driver 17 for SQL Server» (para hablar con la base), SSMS como alternativa,
y opcionalmente un clon de MIS-angular-front al lado para `npm run trazar:front`.
