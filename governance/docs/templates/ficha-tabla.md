# Ficha de tabla — sección manual

Va debajo de `<!-- generado:fin -->` en `diccionario/tablas/<base>/<esquema>/<tabla>.md`.

```markdown
## Descripción

Qué representa una fila. Quién la carga (proceso, job), cada cuánto, y desde qué sistema.

## Columnas

- `COD_AGE`: código de agencia, tal como lo usa la jerarquía organizativa. Confirmado con <rol>, <fecha>.
- `OTRA`: _por documentar_
```

El generador copia cada línea `` - `COLUMNA`: descripción `` a la columna **Descripción** de la tabla
generada. Las que siguen en `_por documentar_` se muestran como `—`.
