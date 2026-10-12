# Flujo de trabajo

## 0. Actualizar el catálogo (cuando cambian los reportes)

Reemplazar `fuente/reportes.json` por el export nuevo y correr:

```bash
npm run generar     # aparecen/desaparecen los SQL de extracción de los SP nuevos/retirados
npm run verificar   # hallazgos de la fuente: duplicados, nombres, parámetros
```

## Atajo: todo desde Python

Con el `.env` configurado (ver skill [dic-conexiones-bd](../../skills/dic-conexiones-bd/SKILL.md)), los pasos 1, 2 y 4
se hacen solos:

```bash
python herramientas/bd.py --env <ruta al .env> todo [--base mod_rep]
```

Los pasos de abajo son lo mismo, a mano desde SSMS, para quien no tenga Python o el driver ODBC.

## 1. Extraer el cuerpo del SP → 🔎 extraído

**Uno por uno (SSMS):**

1. Abrir `sql/01-extraccion/<base>/<esquema>/<SP>.sql` y ejecutarlo.
2. Copiar el resultado completo de `sp_helptext` a `procedimientos/<base>/<esquema>/<SP>.sql`.
   Si el SP tiene líneas de más de 255 caracteres, usar la consulta `OBJECT_DEFINITION` comentada
   al final del mismo archivo.

**En lote (Windows + sqlcmd):**

```powershell
./governance/scripts/extraer-definiciones.ps1 -Servidor <servidor> -Base mod_rep
```

**En lote (SSMS, sin sqlcmd):** ejecutar `sql/01-extraccion/_lotes/<base>.sql`, que además informa qué SP
del catálogo ya no existen (`existe = 0`) y su fecha de modificación.

Después:

```bash
npm run generar
```

La ficha aparece en `diccionario/procedimientos/<base>/<esquema>/<SP>.md`.

## 2. Validar con el motor → ✅ validado

1. Ejecutar `sql/02-dependencias/<base>.sql` en SSMS.
2. *Guardar resultados como…* → `fuente/dependencias/<base>.csv`, **con encabezados**
   (Herramientas › Opciones › Resultados a cuadrícula › "Incluir encabezados de columna al copiar o guardar").
3. `npm run generar`.

Los SP sin error del motor pasan a ✅; las columnas vistas por las dos fuentes, a "confirmada".

## 3. Documentar el significado

En la ficha del SP, debajo de `<!-- generado:fin -->`: propósito, reglas de negocio, notas.
En la ficha de cada tabla: descripción y una línea por columna `` - `COLUMNA`: descripción ``.
Ver la skill [dic-fichas](../../skills/dic-fichas/SKILL.md).

## 4. Estructura y perfil de las tablas

`python herramientas/bd.py estructura` guarda tipos y columnas reales en `fuente/estructura/<base>.csv`:
la ficha de tabla muestra el tipo de cada columna y el validador marca `tabla-inexistente` y
`columna-inexistente`.

`sql/05-por-procedimiento/<base>/<esquema>/<SP>.sql` trae, para un SP, una muestra de cada tabla que usa
con solo sus columnas, y las columnas que devuelve sin ejecutarlo.

`sql/03-tablas/<base>/<esquema>/<tabla>.sql` trae, para cada tabla descubierta: estructura real, tamaño,
muestra de 100 filas y nulos/distintos de cada columna usada. Útil para escribir descripciones con datos,
no con suposiciones.

## 5. Cerrar

```bash
npm run generar && npm run verificar && npm test
```

Commit con el cuerpo, la ficha y lo regenerado juntos. Ver [convenciones](./conventions.md).
