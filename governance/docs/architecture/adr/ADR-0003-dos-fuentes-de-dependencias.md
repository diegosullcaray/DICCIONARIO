# ADR-0003 — Dos fuentes de dependencias, con confianza explícita

**Estado**: aceptada · **Fecha**: 2026-10-12

## Contexto

Para saber qué columnas usa un SP hay dos caminos, y ninguno alcanza solo:

| | Analizador estático (`lib/tsql.mjs`) | Motor (`sys.dm_sql_referenced_entities`) |
|---|---|---|
| Necesita conexión | no | sí |
| Columnas de otra base | sí | **no** (solo la tabla) |
| Columna sin calificar con varias tablas | no puede decidir | sí |
| SQL dinámico | no | no |
| SP que no compila | lo analiza igual | falla |

Los SP de reportes leen casi siempre de **otra base** (`storage`, `strategos`), justo donde el motor
no da columnas.

## Decisión

Usar las dos y mostrar de dónde sale cada dato: cada columna lleva su confianza
(`confirmada`, `motor`, `exacta`, `inferida`) y cada tabla su fuente (`estatico`, `motor`).
El analizador no adivina: lo ambiguo va a `columna-sin-resolver`.

## Consecuencias

- El diccionario es útil desde el primer cuerpo pegado, sin esperar acceso a metadatos.
- `inferida` es una advertencia visible, no un dato confirmado.
- Cada error del analizador se corrige agregando primero el caso a `tests/tsql.test.mjs`.
