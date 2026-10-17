# MOD-0003 · Análisis

## 1. Qué había

El borrador `07_sp_reporte.sql` devuelve **una fila por entidad** (159 columnas, `diccionario_reporte.md`):
`HTABSEG001` (base, t) ⟕ `HTABSEG001` (t−1, `cie_ant`) ⟕ `HTABSEG002` (trasladados) ⟕ `HTABSEG003` (heredados).
No lee `HTABSEG004` (detalle: es del "ver detalle", otra pantalla).

## 2. Verificación contra el diccionario de tablas

| Chequeo | Resultado |
|---|---|
| Columnas `B.`/`A.` usadas ∈ las 84 de HTABSEG001 | todas existen |
| Columnas `T.`/`H.` usadas ∈ las 35 de HTABSEG002/003 | todas existen |
| 159 alias del SELECT = 159 filas de `diccionario_reporte.md` | coinciden |
| Firma `(tip_cod, cod_rel, fec)` | igual a `RSTABCOMER` (`RS_TAB_COM_01`): el front ya sabe mandarla |
| Nivel 7: 002/003 no tienen fila | cubierto con `LEFT JOIN` + `ISNULL(…, 0)` |

## 3. Qué cambió respecto al borrador

La lógica no: ya cuadra con las tablas. Se agregó el empaquetado (`01`–`06`) y el registro del reporte.

## 4. Decisiones para el dueño funcional

| Tema | Hoy | Alternativa |
|---|---|---|
| "Pon cero si no hay datos" | Seguros pendiente → bloque `seg_*` NULL + `ind_seg_pendiente = 1` (un cero afirmaría "no se vendió ninguna póliza"). Sin t−1, los comparativos van NULL. | `ISNULL(…, 0)` en el SELECT; el front pierde cómo distinguir "pendiente". |
| Código del reporte | `TAB_SEG_01` (propuesto, sigue a `TAB_CUE_RES_01`) | El que indique backend. |
| Metas de usabilidad | fijas 0,205 y 0,09 (P09) | Activar VDMCOM01 10251/10252. |

## 5. Riesgos

- `FVECFEC01(@Referencia,'hoy,cie_ant')` con `RORD` 1/2 viene de la carga: confirmarlo con el paso 1 de `04` antes de crear.
- El esquema de `rep.RREGREP01` no está en el repositorio: `06` inserta solo `RCODREP`, `RDESREP`, `RTPREP`.
- Hay datos solo para 30/09/26 y 14/10/26; otras fechas dan el error 51400 (esperado).

## 6. Front (fuera de este repositorio)

El SP entrega las columnas ya nombradas para el tablero (`diccionario_reporte.md`). Falta construir las tarjetas
Cartera, Desembolsos, Recuperaciones y Mora, Clientes, **Digital** y Seguros del `demo panel v2`, sin los botones
Ranking y Comparativa en la primera versión. Ranking va como módulo aparte (se revisa con Víctor Blas).
