---
name: dic-extraccion-sp
description: Cómo sacar el cuerpo de un procedimiento almacenado de SQL Server y dejarlo donde el diccionario lo lee. Usar al extraer uno o muchos SP del catálogo, al pegar un resultado de sp_helptext, o cuando un SP aparece como pendiente, inexistente, huérfano o incompleto.
---
<!-- Copia de governance/skills/dic-extraccion-sp/SKILL.md. Editar el original y correr npm run generar. -->

# Extracción de procedimientos

Un SP sin cuerpo en `procedimientos/<base>/<esquema>/<SP>.sql` queda ⏳ pendiente: el diccionario solo
describe lo que tiene. Los comandos están en el [flujo de trabajo](../../../governance/docs/development/workflow.md);
acá va lo que hay que verificar.

## Elegir el camino

| Situación | Usar |
|---|---|
| Hay `.env` y driver ODBC | `python herramientas/bd.py extraer [--base] [--sp] [--reporte]` |
| Un SP suelto, solo SSMS | `sql/01-extraccion/<base>/<esquema>/<SP>.sql` |
| Una base entera, solo SSMS | `sql/01-extraccion/_lotes/<base>.sql` |
| `sqlcmd` sin Python | `governance/scripts/extraer-definiciones.ps1` |

## Verificar el cuerpo

- Contiene `CREATE PROCEDURE` (o `ALTER`) completo; si no, el validador lo marca `cuerpo-incompleto`.
- El nombre del CREATE coincide con el archivo; si no, `cuerpo-de-otro-sp`.
- No hay identificadores partidos a mitad de línea (síntoma de `sp_helptext` con líneas de más de 255 caracteres).
- Se guarda **tal cual**: sin formatear, sin quitar código comentado. Lo único que se edita es una credencial
  embebida, que se reemplaza por `<redactado>`.

## Lo que la extracción informa

| Resultado | Qué hacer |
|---|---|
| No existe en la base | no inventar el cuerpo: queda ❌ y `sp-inexistente` (origen producción). Avisar al dueño de `reportes.json` |
| Sin definición | SP cifrado o sin permiso `VIEW DEFINITION`: pedir el permiso |
| Sin cambios | la versión del repo ya es la de la base |

Después: `npm run generar` y revisar la ficha con la skill `dic-analisis-dependencias`.
