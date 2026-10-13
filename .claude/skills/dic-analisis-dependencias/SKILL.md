---
name: dic-analisis-dependencias
description: Cómo se determina qué tablas y columnas usa cada SP, combinando el analizador estático de T-SQL con las dependencias del motor de SQL Server. Usar al revisar una ficha generada, resolver columnas inferidas o sin resolver, validar un lote con sys.dm_sql_referenced_entities o corregir un error del analizador.
---
<!-- Copia de governance/skills/dic-analisis-dependencias/SKILL.md. Editar el original y correr npm run generar. -->

# Análisis de dependencias

Ver la decisión completa en [ADR-0003](../../../governance/docs/architecture/adr/ADR-0003-dos-fuentes-de-dependencias.md).

## 1. Analizador estático (`governance/scripts/lib/tsql.mjs`)

Se ejecuta solo con `npm run generar`. Para un SP puntual:

```bash
node -e "import('./governance/scripts/lib/tsql.mjs').then(async ({analizarProcedimiento}) => {
  const fs = await import('node:fs');
  const r = analizarProcedimiento(fs.readFileSync('extraccion/procedimientos/mod_rep/com/GSELREP001.sql','utf8'), {base:'mod_rep', esquema:'com'});
  console.dir(r, {depth: 5});
})"
```

| Resuelve | Cómo |
|---|---|
| Tablas en FROM, JOIN, APPLY, INTO, UPDATE, DELETE, MERGE, TRUNCATE | con su operación |
| `alias.COL` y `tabla.COL` | 🎯 exacta |
| `COL` sin calificar con **una** tabla de origen | ≈ inferida |
| `COL` sin calificar con **varias** tablas | no decide: `columna-sin-resolver` con candidatas |
| CTE, tablas derivadas, `#temporales`, `@variables` tabla | no son tablas del diccionario |
| `EXEC otro_sp` | invocación |
| `EXEC(@sql)`, `sp_executesql` | `sql-dinamico` |
| Firma (`@param tipo = defecto OUTPUT`) y columnas del SELECT final | ficha |

Base y esquema implícitos: `TABLA` → base y esquema del SP (marcado ⚠️ esquema implícito);
`esquema.TABLA` → base del SP; `base..TABLA` → esquema `dbo`.

## 2. Motor (`extraccion/sql/02-dependencias/<base>.sql`)

Por cada SP: `sys.dm_sql_referenced_entities` (columnas, misma base) dentro de `TRY/CATCH`, y
`sys.sql_expression_dependencies` (tablas, incluidas otras bases). Guardar el resultado como
`extraccion/fuente/dependencias/<base>.csv` con encabezados y regenerar.

Límites: **no da columnas de tablas de otra base**, no ve SQL dinámico ni `#temporales`, y falla si el
SP no compila contra el esquema actual (queda `motor-con-error`).

## 3. Cómo se combinan

- Una referencia del motor es **tabla** si `ref_objeto_tipo` lo dice, si el análisis también la ve o si
  existe en `extraccion/fuente/estructura`. Funciones, tipos de tabla, SP y alias sin resolver van a *Otros objetos*.
- Un nombre sin esquema (`FROM TABLA`) toma el esquema con el que el mismo SP la nombra, o el que tiene en
  la estructura real; si no hay ninguno, queda ⚠️ esquema implícito.
- Una columna sin calificar entre varias tablas se atribuye a la única que la tiene en la estructura
  (🧩 por estructura). Si ninguna la tiene es un alias; si varias, `columna-sin-resolver`.

## 4. Leer una ficha

| Ves | Hacé |
|---|---|
| `≈` en una columna | confirmarla leyendo el SP; con estructura cargada, si no existiera sería `columna-inferida-inexistente` |
| `columna-sin-resolver` | leer el SP y anotar en *Notas del analista* de qué tabla es |
| `columna-inexistente` / `tabla-inexistente` | error del SP en producción: documentarlo, no "arreglar" la ficha |
| `discrepancia-motor` | la tabla la ve el analizador y no el motor: alias mal leído, o el objeto ya no existe |
| tabla con fuente solo `motor` | la usa SQL dinámico o una vista: documentar a mano |

## 5. Corregir el analizador

1. Reducir el SP a un caso mínimo que reproduzca el error.
2. Agregarlo a `governance/scripts/tests/tsql.test.mjs` y ver que falla (`npm test`).
3. Corregir `lib/tsql.mjs` hasta verde, sin romper los otros casos.
4. `npm run generar`: el arreglo se propaga a todas las fichas.
