---
name: diccionario-rules
description: Reglas base del repositorio DICCIONARIO (diccionario de datos de los reportes MIS).
always_on: true
---

# Reglas base de DICCIONARIO

Este repositorio responde, para cada reporte del MIS: **qué SP ejecuta, qué tablas usa y qué columnas
de cada una**. Es el complemento de datos de MIS-angular-front (que sabe qué `cod_rep` pide cada pantalla)
y usa la conexión de REPORTES-AUTOMATIZADOS.

Antes de cambiar algo, leer la [visión general](governance/docs/architecture/system-overview.md): dice qué
es fuente, qué es derivado y qué se edita a mano.

## Reglas que no se negocian

1. **Gana la fuente.** Cuando un documento y la fuente (el SP en la base, luego `extraccion/fuente/reportes.json`)
   discrepan, se corrige el documento.
2. **Lo que se deriva no se escribe.** Si un dato del diccionario está mal, se corrige su fuente o el
   analizador y se corre `npm run generar`. Editar dentro de `<!-- generado:… -->` o en `.claude/` es trabajo perdido.
3. **Los cuerpos de SP no se tocan.** Se guardan tal cual salen de la base; la única edición permitida es
   redactar una credencial embebida.
4. **Nada de credenciales ni servidores versionados.** Viven solo en `.env` (no versionado). Ver la skill `dic-conexiones-bd`.
5. **Solo lectura contra la base.** Metadatos, definiciones y muestras con `NOLOCK`; nunca DML ni `EXEC` de un SP de reporte.
6. **No se inventa semántica.** Sin evidencia (código, dato perfilado o dueño funcional) una columna queda
   `_por documentar_`. El nombre de una columna no es su significado.
7. **`inferida` no es `confirmada`.** El analizador estático es una heurística ([ADR-0003](governance/docs/architecture/adr/ADR-0003-dos-fuentes-de-dependencias.md)).
8. **Los parámetros de contrato no se renombran** (`tip_cod`, `cod_rel`, `fec`, `fecha`): ver el [glosario](governance/docs/data/glossary.md).
9. **La línea base no se regenera para destrabar** ([ADR-0006](governance/docs/architecture/adr/ADR-0006-linea-base-de-hallazgos.md)).

## Agentes, skills y cómo se trabaja

Todo indexado en [governance/readme.md](governance/readme.md): agentes (checklists con prompt de sistema,
también disponibles como subagentes en `.claude/agents/`), skills y documentación.

## Antes de commitear

```bash
npm run generar && npm run verificar && npm test && npm run test:py
```
