---
name: dic-extraccion-sp
description: Cómo sacar el cuerpo de un procedimiento almacenado de SQL Server y dejarlo donde el diccionario lo lee. Usar al extraer uno o muchos SP del catálogo, al pegar un resultado de sp_helptext, o cuando un SP aparece como pendiente, huérfano o incompleto.
---

# Extracción de procedimientos

El diccionario solo puede describir lo que tiene: un SP sin cuerpo en `procedimientos/` queda ⏳ pendiente.

## 1. Dónde está todo

| Necesito | Archivo |
|---|---|
| El SQL para un SP | `sql/01-extraccion/<base>/<esquema>/<SP>.sql` |
| Todos los de una base | `sql/01-extraccion/_lotes/<base>.sql` |
| Dónde pegar el resultado | `procedimientos/<base>/<esquema>/<SP>.sql` (lo dice la cabecera del SQL) |
| Qué falta | `diccionario/procedimientos.md` (⏳) o `sql/01-extraccion/manifiesto.json` (`"extraido": false`) |

## 2. Tres formas, de menor a mayor volumen

**Uno, en SSMS** — el patrón original del repositorio:

```sql
USE mod_rep;
GO
EXEC sp_helptext 'com.GSELREP002';
```

Copiar todas las filas del resultado y pegarlas en el archivo de destino.
⚠️ `sp_helptext` corta líneas de más de 255 caracteres: si el SP tiene líneas largas (listas de columnas,
CASE extensos), el texto pegado puede partir un identificador. Usar entonces la línea comentada
`OBJECT_DEFINITION` del mismo archivo, con "Conservar CR/LF al copiar" activado en SSMS.

**Una base, en SSMS** — `_lotes/<base>.sql` devuelve una fila por SP con `existe`, `modificado` y
`definicion`. Sirve también para detectar SP del catálogo que ya no existen.

**Todo, por consola (Windows)**:

```powershell
./governance/scripts/extraer-definiciones.ps1 -Servidor <servidor>
./governance/scripts/extraer-definiciones.ps1 -Servidor <servidor> -Base strategos
```

## 3. Reglas

- Pegar **tal cual**. No formatear, no corregir, no quitar código comentado: el diccionario describe producción.
- El archivo tiene que contener `CREATE PROCEDURE` (o `ALTER`); si no, el validador lo marca `cuerpo-incompleto`.
- Si el CREATE nombra otro SP, es `cuerpo-de-otro-sp`: se pegó en el archivo equivocado.
- No versionar el nombre del servidor ni credenciales.

## 4. Cerrar

```bash
npm run generar     # crea la ficha
npm run verificar
```

Revisar la ficha generada contra el cuerpo antes de commitear (ver skill `dic-analisis-dependencias`).
