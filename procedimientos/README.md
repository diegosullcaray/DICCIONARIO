# Procedimientos

El cuerpo de cada SP del catálogo, **tal cual sale de la base**: `<base>/<esquema>/<SP>.sql`.

- Se obtiene con `sql/01-extraccion/<base>/<esquema>/<SP>.sql`, con el lote de la base o con
  `governance/scripts/extraer-definiciones.ps1`. Ver la skill
  [dic-extraccion-sp](../governance/skills/dic-extraccion-sp/SKILL.md).
- No se formatea ni se corrige. La única edición permitida es redactar una credencial embebida.
- Un archivo sin `CREATE PROCEDURE` no se analiza (`cuerpo-incompleto`); uno que no está en el catálogo
  es `cuerpo-huerfano`.
