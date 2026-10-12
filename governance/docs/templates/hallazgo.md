# Hallazgo manual

Para problemas que el validador no detecta (p. ej. un SP que devuelve datos de otra fecha de corte).
Se agrega en *Notas del analista* de la ficha afectada:

```markdown
> **Hallazgo** (2026-10-12 · <rol>): <qué pasa>.
> Evidencia: <consulta de sql/03-tablas o línea del SP>.
> Impacto: <reportes afectados>. Estado: abierto | resuelto en <commit>.
```

Si el hallazgo es detectable automáticamente, la solución correcta es una regla nueva en `lib/modelo.mjs`.
