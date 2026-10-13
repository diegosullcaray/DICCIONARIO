---
name: dic-fichas
description: Cómo documentar a mano las fichas del diccionario (propósito y reglas de un SP, descripción de tablas y columnas) sin que la regeneración pise el trabajo. Usar al completar una ficha, al describir columnas o al revisar que la prosa siga siendo cierta después de que un SP cambió.
---

# Fichas del diccionario

## 1. Qué se genera y qué se escribe

```markdown
# mod_rep.com.GSELREP001
<!-- generado:inicio ficha -->
… tablas, columnas, firma, reportes, salida …   ← NO editar: npm run generar lo reescribe
<!-- generado:fin -->

## Propósito                                     ← a mano
## Reglas de negocio                             ← a mano
## Notas del analista                            ← a mano
```

Si un dato del bloque generado está mal, el error está en la fuente (el cuerpo, `reportes.json`, el CSV
del motor) o en el analizador. Ver `dic-analisis-dependencias`.

## 2. Ficha de SP

Plantilla: [ficha-procedimiento](../../docs/templates/ficha-procedimiento.md).

- **Propósito**: qué calcula, para qué pantalla (la columna *Pantalla del front* ayuda), a qué nivel de
  jerarquía y fecha de corte.
- **Reglas de negocio**: filtros fijos, exclusiones, tramos. Citar la condición del SP entre backticks.
- **Notas**: trampas y dudas, con quién se consultó.

## 3. Ficha de tabla: descripciones de columna

Plantilla: [ficha-tabla](../../docs/templates/ficha-tabla.md). En la sección `## Columnas`:

```markdown
- `HFCRES`: <descripción confirmada>
```

El generador copia cada línea a la columna **Descripción** de la tabla generada. Formato exacto:
guion, nombre entre backticks, dos puntos, texto. Las que dicen `_por documentar_` se muestran como `—`.
Cuando aparece una columna nueva, su línea **no** se agrega sola en fichas existentes: agregarla.

## 4. Fuentes válidas para una descripción

1. El código del SP (un `CASE` que define tramos, un `WHERE` que excluye).
2. El dato perfilado con `extraccion/sql/03-tablas/<base>/<esquema>/<tabla>.sql`.
3. El dueño funcional (ver [responsabilidades](../../docs/data/stewardship.md)).

**No** son fuentes: el nombre de la columna, ni lo que "suele significar" en otro sistema.

## 5. Cerrar

```bash
npm run generar && npm run verificar
```
