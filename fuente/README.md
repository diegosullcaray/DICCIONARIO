# Fuentes

Entradas del diccionario: lo que viene de afuera. Nada de esta carpeta se edita a mano.

| Archivo | Qué es | Cómo se actualiza |
|---|---|---|
| `reportes.json` | catálogo `RCODREP` → SP (`RTPREP.name`) → parámetros (`RTPREP.params`) | reemplazar por un export nuevo de la tabla de reportes del backend |
| `dependencias/<base>.csv` | resultado de `sql/02-dependencias/<base>.sql` | SSMS › *Guardar resultados como…* CSV con encabezados |
| `consumo-front.json` | qué RCODREP usa MIS-angular-front, con el commit leído | `npm run trazar:front` |

Después de actualizar cualquiera: `npm run generar && npm run verificar`.
