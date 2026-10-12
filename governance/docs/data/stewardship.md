# Responsabilidades

Quién decide sobre cada pieza. Los nombres de personas no se versionan acá; se nombran roles.

| Pieza | Rol responsable | Decide |
|---|---|---|
| `fuente/reportes.json` | dueño del backend Ant | qué reportes existen y qué SP ejecutan |
| Cuerpo de un SP | dueño del SP en la base | qué hace; el diccionario solo lo describe |
| Ficha de SP: propósito y reglas | analista de datos del dominio | qué significa la cifra |
| Ficha de tabla: descripción de columnas | dueño funcional de la tabla | qué significa cada columna |
| Analizador y scripts | mantenedor de este repositorio | cómo se deriva el diccionario |
| Consumo del front | mantenedor de MIS-angular-front | qué pantalla usa qué reporte |

> El propietario funcional de cada dominio está **por confirmar**, igual que en el catálogo del front.
> Sin él, una descripción de columna dudosa no tiene a quién escalarse: mientras tanto se deja
> `_por documentar_` en vez de suponer.
