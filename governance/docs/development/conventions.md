# Convenciones

## Carpetas y nombres

| Qué | Ruta |
|---|---|
| Cuerpo de SP | `extraccion/procedimientos/<base>/<esquema>/<SP>.sql` |
| SQL de extracción | `extraccion/sql/01-extraccion/<base>/<esquema>/<SP>.sql` |
| SQL de dependencias | `extraccion/sql/02-dependencias/<base>.sql` |
| SQL de tabla | `extraccion/sql/03-tablas/<base>/<esquema>/<tabla>.sql` |
| Resultado del motor | `extraccion/fuente/dependencias/<base>.csv` |
| Ficha de SP | `diccionario/procedimientos/<base>/<esquema>/<SP>.md` |
| Ficha de tabla | `diccionario/tablas/<base>/<esquema>/<tabla>.md` |
| Consulta utilitaria | `extraccion/sql/04-consultas/NN-<verbo>-<objeto>.sql` |

- `<base>`, `<esquema>` y `<SP>` **sin corchetes ni espacios**, con la grafía del catálogo.
- Scripts en español, `kebab-case.mjs`. Funciones y variables en español, `camelCase`.
- Skills con prefijo `dic-`. Agentes numerados `NN-<rol>.md`.

## Cuerpos de SP

- Se pegan **tal cual** salen de la base. No se formatean ni se corrigen: el diccionario describe lo que
  corre en producción. Un comentario de cabecera (`-- Extraído de …`) es lo único que se agrega.
- Si el SP cambia en la base, se reemplaza el archivo completo.

## Commits

```text
<tipo>(<ámbito>): <qué>

tipos: extraer · documentar · validar · catalogo · analizador · gobernanza
ámbito: base/esquema/SP, o la pieza de gobernanza

extraer(mod_rep/com): cuerpos de GSELREP002 y GSREVA01
documentar(storage/com_act/WCED001): descripción de HFCRES
analizador: resolver alias en UPDATE … FROM
```

Un commit deja `npm run verificar` en verde.
