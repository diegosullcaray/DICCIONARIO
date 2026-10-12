---
name: dic-lectura-tsql
description: Patrones de los procedimientos de reportes MIS y cómo leerlos sin equivocarse — CTE encadenadas, filtros con TODO/VACÍO, parámetros de jerarquía y fecha, invocación de FTHEACOLS01, bases cruzadas. Usar al documentar el propósito y las reglas de un SP o al interpretar una columna que devuelve.
---

# Lectura de SP de reportes

## 1. Anatomía observada (GSELREP001)

```sql
CREATE PROCEDURE [com].[GSELREP001] AS BEGIN
SET NOCOUNT ON;
exec mod_rep.rep.[FTHEACOLS01] 'SEL_EFEC_01';        -- (a) invoca otro SP con su propio RCODREP
with cte_e as (select distinct HFCRES                 -- (b) lee de OTRA base: storage
               from storage.[com_act].[WCED001] where HFCRES is not null),
     cte_r as (select ROW_NUMBER() over(order by HFCRES) row, * from cte_e),
     cte_f as (select 0 a, cast('TODO' as varchar(250)) r      -- (c) opción "TODO" primero
               UNION select 999999, cast('VACÍO' as varchar(250)) r  --     "VACÍO" al final
               UNION select row + 1, HFCRES from cte_r)
select r id, r [desc] from cte_f order by a          -- (d) contrato de salida: id, desc
END
```

| Marca | Patrón | Qué documentar |
|---|---|---|
| (a) | `EXEC FTHEACOLS01 '<RCODREP>'` | su función está por confirmar; no inventarla |
| (b) | tabla en `storage` / `strategos` | el motor no da sus columnas: confiar en el analizador y confirmar leyendo |
| (c) | `TODO` / `VACÍO` como filas sintéticas | es un SP de **opciones de filtro**: el front lo usa para poblar un selector |
| (d) | `id` y `desc` con el mismo valor | el valor elegido viaja como texto, no como código |

Hipótesis a confirmar al extraerlos: los otros RCODREP `SEL_*` (`SEL_JEFE_01`, `SEL_CIU_01`, `SEL_CIU_02`, `SEL_JER_01`, `SEL_JER_MENTORING_01`, todos "Filtro …" en el catálogo y con SP `GSEL*`) seguirían el mismo patrón de selector. Hasta extraerlos, no documentarlo como hecho.

## 2. Parámetros

- El orden de `RTPREP.params` es el orden en que el backend los pasa. Comparar con la **Firma** de la ficha.
- `tip_cod` + `cod_rel`: nodo de jerarquía. Buscar en el cuerpo cómo filtran (por agencia, región, asesor).
- `fec` vs `fecha`: formatos distintos. Anotar el `CONVERT`/`CAST` que el SP aplica.

## 3. Trampas al leer

- `SET NOCOUNT ON` repetido o código comentado: se documenta tal cual, no se "limpia".
- Columnas `*` en una CTE o derivada: las columnas reales salen de la tabla de la CTE de origen.
- `NOLOCK`: lecturas sucias posibles; relevante si el reporte cuadra contra otro.
- `ORDER BY` de un `UNION` usa los alias del primer SELECT.
- Una columna devuelta con alias (`r id`) no es una columna de tabla: el diccionario lista ambas cosas por separado
  (*Tablas y columnas* vs *Columnas que devuelve*).

## 4. Regla de oro

El nombre de una columna no es su significado. `HFCRES` puede sugerir algo; se escribe solo lo que
confirma el código, el dato perfilado (`sql/03-tablas`) o el dueño funcional.
