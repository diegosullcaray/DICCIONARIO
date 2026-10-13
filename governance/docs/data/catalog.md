# Catálogo de datos

Qué consultan los reportes, agrupado por base de datos. Es la vista resumida; el detalle
navegable (una ficha por SP y por tabla) vive en [`diccionario/`](../../../diccionario/README.md).

`fuente/reportes.json` es la **fuente de verdad del inventario**: un SP que no figura ahí no se documenta,
y un archivo de `procedimientos/` sin entrada en el catálogo es un hallazgo (`cuerpo-huerfano`). De dónde
sale cada fuente y cómo se actualiza: [visión general](../architecture/system-overview.md).

## Procedimientos por base

**No editar a mano**: `npm run generar` regenera, `npm run verificar` comprueba que esté al día.

<!-- generado:inicio catalogo -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Base | Esquemas | Procedimientos | Reportes | Extraídos | Validados | No existen |
|---|---|---:|---:|---:|---:|---:|
| `mod_gpa` | `vac` | 2 | 2 | 0 | 0 | 0 |
| `mod_rep` | `com`, `dbo`, `rep` | 258 | 310 | 225 | 222 | 33 |
| `mod_sec` | `dbo` | 1 | 1 | 1 | 1 | 0 |
| `storage` | `com` | 1 | 1 | 1 | 1 | 0 |
| `strategos` | `mod_rep_com_act` | 9 | 10 | 9 | 9 | 0 |
<!-- generado:fin -->

## Ver también

- [Glosario](./glossary.md) — qué significan `tip_cod`, `cod_rel`, `fec`, los estados y la confianza
- [Linaje](./lineage.md) — de la tabla a la pantalla
- [Calidad](./quality.md) — reglas y hallazgos
