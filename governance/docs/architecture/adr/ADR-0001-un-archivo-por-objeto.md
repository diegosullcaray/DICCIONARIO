# ADR-0001 — Un archivo por objeto

**Estado**: aceptada · **Fecha**: 2026-10-12

## Contexto

El catálogo tiene 324 reportes y 271 procedimientos distintos en cinco bases. Un único documento por
base sería ilegible y cada extracción generaría conflictos de merge.

## Decisión

Cada SP y cada tabla tiene su propio archivo, en carpetas `<base>/<esquema>/` que se repiten en
`procedimientos/`, `sql/01-extraccion/`, `sql/03-tablas/` y `diccionario/`.

## Consecuencias

- Un PR que documenta un SP toca su cuerpo y su ficha, nada más (más lo regenerado).
- Encontrar el SQL o la ficha de un objeto es cambiar el prefijo de la ruta.
- Los índices (`reportes.md`, `procedimientos.md`, `tablas.md`) son los únicos archivos grandes, y son generados.
