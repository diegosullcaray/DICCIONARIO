# Fuentes

Entradas del diccionario: lo que viene de afuera. Nada de esta carpeta se edita a mano.

| Archivo | Qué es | Cómo se actualiza |
|---|---|---|
| `reportes.json` | catálogo `RCODREP` → SP (`RTPREP.name`) → parámetros (`RTPREP.params`) | reemplazar por un export nuevo de la tabla de reportes del backend |
| `dependencias/<base>.csv` | lo que SQL Server registra de cada SP (tablas, columnas, tipo de objeto) | `python herramientas/bd.py dependencias` |
| `estructura/<base>.csv` | columnas, tipos y nulabilidad reales de las tablas usadas | `python herramientas/bd.py estructura` |
| `consumo-front.json` | qué RCODREP usa MIS-angular-front, con el commit leído | `npm run trazar:front` |

Los CSV solo contienen **metadatos** (nombres de objetos y columnas), nunca datos de las tablas. Si se
generan desde SSMS en lugar de Python, deben incluir la fila de encabezados. Después de actualizar
cualquiera: `npm run generar`.
