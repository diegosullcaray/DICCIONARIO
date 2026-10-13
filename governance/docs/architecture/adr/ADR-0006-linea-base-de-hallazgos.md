# ADR-0006 — Línea base: producción se documenta, no bloquea

**Estado**: aceptada · **Fecha**: 2026-10-13

## Contexto

La primera extracción completa (225 SP de `mod_rep`, más `strategos`, `mod_sec` y `storage`) encontró
errores que **no son de este repositorio**: 33 SP del catálogo que no existen en la base, tablas y
columnas que los SP usan y ya no están, reportes que envían una cantidad de parámetros distinta a la
que declara su SP. Son hallazgos valiosos, pero si bloquean `npm run verificar`, el pipeline queda rojo
para siempre y deja de avisar cuando aparece un problema nuevo.

## Decisión

1. Cada regla declara su **origen** (`catalogo`, `produccion`, `repositorio`, `analisis`) en `REGLAS`
   (`governance/scripts/lib/modelo.mjs`), y el informe de hallazgos se agrupa por origen: quien lo lee
   sabe a quién escalarlo.
2. Los hallazgos conocidos se congelan en `governance/linea-base.json`, igual que
   `gobernanza.linea-base.json` en MIS-angular-front. `npm run verificar` falla solo por los **nuevos**.
3. Si un hallazgo congelado deja de aparecer (se corrigió), `verificar` también falla hasta regenerar la
   línea base: una entrada vencida escondería la misma regresión si volviera.

## Consecuencias

- Los errores de producción siguen visibles en [errores/](../../../../errores/README.md), marcados
  como línea base, para entregarlos a sus dueños.
- **Regenerar la línea base para destrabar un pipeline rojo es esconder deuda.** Se hace solo en un
  commit propio, con el porqué en el mensaje.
