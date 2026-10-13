# ADR-0004 — Extracción por SP, no por reporte

**Estado**: aceptada · **Fecha**: 2026-10-12

## Contexto

El repositorio empezó con un archivo por RCODREP (`scripts_reportes/SPS/SEL_JEFE_01.sql` con
`USE mod_rep; GO; EXEC sp_helptext 'com.GSELREP002';`, y `SEL_EFEC_01.sql` con el cuerpo pegado).
Pero 324 reportes ejecutan 271 SP: `GSREVA01`, por ejemplo, lo usan varios RCODREP con distintos parámetros.

## Decisión

Se conserva el patrón del script original (`USE` + `GO` + `EXEC sp_helptext`), pero **un archivo por SP**
en `extraccion/sql/01-extraccion/<base>/<esquema>/<SP>.sql`, que lista en su cabecera todos los RCODREP que lo usan.
El cuerpo se guarda separado, en `extraccion/procedimientos/`, con el mismo árbol. Los archivos originales se migraron:
`SEL_EFEC_01.sql` → `extraccion/procedimientos/mod_rep/com/GSELREP001.sql`; `SEL_JEFE_01.sql` lo reemplaza el generado
`extraccion/sql/01-extraccion/mod_rep/com/GSELREP002.sql`; `data.json` → `extraccion/fuente/reportes.json`.

## Consecuencias

- Un SP se extrae y documenta una vez, sin importar cuántos reportes lo usen.
- La relación RCODREP → SP sigue visible en la cabecera del SQL, en la ficha y en `reportes.md`.
