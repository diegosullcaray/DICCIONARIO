---
name: diccionario-rules
description: Reglas base del repositorio DICCIONARIO (diccionario de datos de los reportes MIS).
always_on: true
---

# Gobernanza y reglas base de DICCIONARIO

Este repositorio responde tres preguntas sobre cada reporte del MIS (Financiera Confianza):
**qué procedimiento almacenado ejecuta, qué tablas usa y qué columnas de cada una.**
Es el complemento de datos de [MIS-angular-front](https://github.com/diegosullcaray/MIS-angular-front):
el front sabe qué `cod_rep` pide; este repositorio sabe de dónde sale cada cifra.

Cuando la documentación y la fuente discrepan, **gana la fuente** (el cuerpo del SP en la base,
y después `fuente/reportes.json`). El documento se corrige; la discrepancia se registra como hallazgo.

## 1. Fuentes y derivados (el "idioma local")

| Qué | Dónde | Se edita a mano |
|---|---|---|
| Catálogo RCODREP → SP → parámetros | `fuente/reportes.json` | solo reemplazándolo por un export nuevo |
| Cuerpo de cada SP | `procedimientos/<base>/<esquema>/<SP>.sql` | se pega tal cual sale de la base, sin "arreglarlo" |
| Dependencias según el motor | `fuente/dependencias/<base>.csv` | no: es el resultado de `sql/02-dependencias/<base>.sql` |
| Consumo del front | `fuente/consumo-front.json` | no: `npm run trazar:front` |
| SQL de extracción, dependencias y tablas | `sql/01-*`, `sql/02-*`, `sql/03-*` | **no**: se generan |
| Consultas utilitarias | `sql/04-consultas/` | sí |
| Fichas, índices y JSON del diccionario | `diccionario/` | solo la prosa **debajo** de `<!-- generado:fin -->` |

Regla de oro: **lo que se deriva no se escribe**. Si un dato del diccionario está mal, se corrige
su fuente y se corre `npm run generar`. Editar dentro de un bloque `generado` es trabajo perdido.

## 2. Flujo de trabajo

```text
reportes.json ─► npm run generar ─► sql/01-extraccion/…/<SP>.sql ─► (SSMS) ─► procedimientos/…/<SP>.sql
                                                                                  │
                     sql/02-dependencias/<base>.sql ─► (SSMS) ─► fuente/dependencias/<base>.csv
                                                                                  │
                                         npm run generar ─► diccionario/ + hallazgos
```

Detalle: [flujo de trabajo](governance/docs/development/workflow.md).

## 3. Reglas que no se negocian

- **Nada de credenciales**: ni servidor, ni usuario, ni contraseña en archivos versionados. Los scripts
  piden el servidor por parámetro y usan autenticación integrada.
- **No se inventa semántica**: una columna sin descripción confirmada queda `_por documentar_`.
  El nombre de una columna no es su significado.
- **El analizador estático es una heurística**: `inferida` no es `confirmada`. Ver
  [ADR-0003](governance/docs/architecture/adr/ADR-0003-dos-fuentes-de-dependencias.md).
- **Los parámetros de contrato no se renombran**: `tip_cod`, `cod_rel`, `fec`, `fecha` se escriben como
  el backend (ver [glosario](governance/docs/data/glossary.md)).
- **Solo lectura contra la base**: los SQL de este repositorio consultan metadatos y muestras con
  `NOLOCK`. Nunca `ALTER`, `DROP`, `INSERT` ni `EXEC` de un SP de reporte.

## 4. Agentes y skills

- **Agentes**: [pipeline y roles](governance/agents/README.md). Son checklists con prompt de sistema;
  se pueden usar como subagentes (`.claude/agents/`), pegar como prompt o seguir a mano.
- **Skills**: en `governance/skills/`, una carpeta por skill. Contienen el "cómo se hace" de este repo.
  `.claude/` es una copia: editar en `governance/` y correr `npm run generar`.

## 5. Verificar antes de commitear

```bash
npm run generar     # regenera SQL, diccionario y copias de agentes
npm run verificar   # hallazgos + generados al día + enlaces + índice de skills
npm test            # pruebas del analizador T-SQL
```
