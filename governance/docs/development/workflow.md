# Flujo de trabajo

De `reportes.json` a una ficha validada y documentada. Hay dos caminos para hablar con la base:
**Python** (recomendado, sin pasos manuales) y **SSMS** (para quien no tiene Python o el driver ODBC).
Los dos dejan los mismos archivos; lo que sigue después es igual.

```text
reportes.json ─► npm run generar ─► sql/01, 02 ─►  [Python bd.py | SSMS]  ─► procedimientos/, fuente/
                                                                                   │
                                     npm run generar ◄─────────────────────────────┘
                                            │
                       diccionario/ + hallazgos ─► documentar prosa ─► npm run verificar ─► commit
```

## 0. Actualizar el catálogo (cuando cambian los reportes)

Reemplazar `fuente/reportes.json` por el export nuevo y correr `npm run generar`: aparecen o desaparecen
los SQL de extracción de los SP nuevos o retirados.

## 1. Extraer, validar y perfilar → 🔎 extraído / ✅ validado

**Con Python** (configuración en la skill [dic-conexiones-bd](../../skills/dic-conexiones-bd/SKILL.md)):

```bash
python herramientas/bd.py --env <ruta al .env> todo [--base mod_rep]
```

Hace extraer → generar → dependencias → generar → estructura → generar. Cada paso por separado y sus
opciones: [herramientas/README.md](../../../herramientas/README.md).

**Con SSMS**, por SP o por base:

| Paso | Ejecutar | Guardar el resultado en |
|---|---|---|
| Cuerpo de un SP | `sql/01-extraccion/<base>/<esquema>/<SP>.sql` | `procedimientos/<base>/<esquema>/<SP>.sql` |
| Cuerpos de una base | `sql/01-extraccion/_lotes/<base>.sql` (además dice qué SP no existen) | un archivo por fila, igual que arriba |
| Dependencias del motor | `sql/02-dependencias/<base>.sql` | `fuente/dependencias/<base>.csv`, **con encabezados** |

`sp_helptext` corta las líneas de más de 255 caracteres: si el SP las tiene, usar `OBJECT_DEFINITION`
(comentado al final de cada SQL de extracción) con "Conservar CR/LF al copiar" activado en SSMS.
Sin Python pero con `sqlcmd`: `governance/scripts/extraer-definiciones.ps1 -Servidor <servidor>`.

Después de cualquiera de los dos caminos: `npm run generar`.

## 2. Revisar lo generado

- La ficha de cada SP (`diccionario/procedimientos/…`) contra su cuerpo: skill
  [dic-analisis-dependencias](../../skills/dic-analisis-dependencias/SKILL.md).
- Los hallazgos nuevos: `npm run verificar` los lista; el informe completo por origen está en
  [hallazgos](../evidence/quality/hallazgos.md). Qué hacer con cada regla: [calidad](../data/quality.md).
- Para ver una tabla con datos reales: `sql/03-tablas/<base>/<esquema>/<tabla>.sql`; para las tablas de un SP
  con solo las columnas que usa: `sql/05-por-procedimiento/<base>/<esquema>/<SP>.sql`.

## 3. Documentar el significado

Debajo de `<!-- generado:fin -->` en cada ficha: propósito, reglas de negocio y descripción de columnas.
Cómo, sin que la regeneración lo pise: skill [dic-fichas](../../skills/dic-fichas/SKILL.md).

## 4. Cerrar

```bash
npm run generar && npm run verificar && npm test && npm run test:py
```

Commit con los cuerpos, las fichas y lo regenerado juntos ([convenciones](./conventions.md)).
