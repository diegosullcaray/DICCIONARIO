# Catálogo de datos

Qué consultan los reportes, agrupado por base de datos. Es la vista de gobierno; el detalle
navegable vive en [`diccionario/`](../../../diccionario/README.md).

## Fuentes del catálogo

| Activo | Archivo | Quién lo produce | Cada cuánto |
|---|---|---|---|
| Catálogo de reportes (RCODREP → SP) | `fuente/reportes.json` | export de la tabla de reportes del backend Ant | cuando se agrega o cambia un reporte |
| Cuerpo de cada SP | `procedimientos/<base>/<esquema>/<SP>.sql` | `sp_helptext` / `extraer-definiciones.ps1` | cuando el SP cambia en la base |
| Dependencias según el motor | `fuente/dependencias/<base>.csv` | `sql/02-dependencias/<base>.sql` | al validar un lote de SP |
| Consumo del front | `fuente/consumo-front.json` | `npm run trazar:front` | cuando cambia MIS-angular-front |

`reportes.json` es la **fuente de verdad del inventario**: un SP que no figura ahí no se documenta,
y un archivo de `procedimientos/` sin entrada en el catálogo se reporta como huérfano.

## Procedimientos por base

**No editar a mano**: `npm run generar` regenera, `npm run verificar` comprueba que esté al día.

<!-- generado:inicio catalogo -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Base | Esquemas | Procedimientos | Reportes | Extraídos | Validados |
|---|---|---:|---:|---:|---:|
| `mod_gpa` | `vac` | 2 | 2 | 0 | 0 |
| `mod_rep` | `com`, `dbo`, `rep` | 258 | 310 | 1 | 0 |
| `mod_sec` | `dbo` | 1 | 1 | 0 | 0 |
| `storage` | `com` | 1 | 1 | 0 | 0 |
| `strategos` | `mod_rep_com_act` | 9 | 10 | 0 | 0 |
<!-- generado:fin -->

## Ver también

- [Glosario](./glossary.md) — qué significan `tip_cod`, `cod_rel`, `fec`, los estados y la confianza
- [Linaje](./lineage.md) — de la tabla a la pantalla
- [Calidad](./quality.md) — reglas y hallazgos
