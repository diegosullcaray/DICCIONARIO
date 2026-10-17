# MOD-0003 · Petición

**Fecha**: 2026-10-17 · **Solicita**: Michael Palacios (correo) · **Estado**: propuesto (script listo, sin ejecutar)

**Insumos**: [nueva tarea](../nueva%20tarea/) (nota del correo, `diccionario_tablas.md`, `diccionario_reporte.md`,
`variables.md`, borrador `07_sp_reporte.sql`, demo del panel v2).

## Pedido, tal como llegó

> Las tablas creadas son `storage.com_act.HTABSEG001` a `HTABSEG004`. Con las 3 primeras se creó un SP reporte
> de forma preliminar; termina de adaptarlo (`mod_rep.com.RTABSEG01`). También regístralo y adáptalo para que lo
> consuma el front del tablero. […] Hay datos para el 14/10/26 y el 30/09/26. Algunas variables no vienen porque
> aún no se tienen datos: avanza y coloca cero si corresponde.

## Se divide en cuatro entregas

| # | Entrega | Dónde | Estado |
|---|---|---|---|
| 1 | SP `mod_rep.com.RTABSEG01` sobre HTABSEG001–003 | este repositorio (`03`) | hecho |
| 2 | Registro del reporte en el catálogo (`RREGREP01`) | este repositorio (`06`) | hecho, sin ejecutar |
| 3 | Tablero del front con el diseño nuevo (incluye Digital) | MIS-angular-front | pendiente |
| 4 | Ranking y Comparativa: no van en la primera versión; Ranking como módulo aparte | MIS-angular-front | pendiente |

Ver [02-analisis.md](./02-analisis.md).
