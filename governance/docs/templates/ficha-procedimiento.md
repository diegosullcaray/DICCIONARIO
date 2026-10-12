# Ficha de procedimiento — sección manual

Va debajo de `<!-- generado:fin -->` en `diccionario/procedimientos/<base>/<esquema>/<SP>.md`.

```markdown
## Propósito

Qué calcula, en una o dos oraciones, en lenguaje de negocio. A qué nivel de la jerarquía
(`tip_cod`/`cod_rel`) y a qué fecha de corte responde.

## Reglas de negocio

- Filtros fijos que el SP aplica (productos, estados, tramos) y por qué, si se sabe.
- Exclusiones.
- Redondeos, conversiones de moneda, cortes por días de atraso.

## Notas del analista

- Trampas que ya costaron un error, con la línea del SP que las explica.
- Dudas abiertas, con a quién se consultó y cuándo.
```

Regla: lo que no se sabe se deja `_por documentar_`. No se deduce el significado de un nombre de columna.
