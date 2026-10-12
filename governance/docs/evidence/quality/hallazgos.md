# Hallazgos de calidad

Lo que el validador encuentra en las fuentes del diccionario. Se **deriva**: corregir la causa
(en `fuente/reportes.json`, en el SP o en el cuerpo extraído) y regenerar; no se borra un renglón a mano.

Qué significa cada regla y cómo se resuelve: [calidad del dato](../../data/quality.md).

<!-- generado:inicio hallazgos -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Nivel | Regla | Cantidad |
|---|---|---:|
| aviso | `codigo-duplicado` | 2 |
| aviso | `nombre-con-espacios` | 1 |
| info | `parametro-con-variantes` | 3 |

| Nivel | Regla | Objeto | Detalle |
|---|---|---|---|
| aviso | `codigo-duplicado` | `CLI_VULNERABLE_01` | aparece 2 veces en reportes.json (entradas idénticas) |
| aviso | `codigo-duplicado` | `PANEL_SUP_02` | aparece 2 veces en reportes.json (entradas idénticas) |
| aviso | `nombre-con-espacios` | `strategos.mod_rep_com_act.GDDESEMDIA` | escrito como "strategos.mod_rep_com_act.GDDESEMDIA  ": los espacios rompen búsquedas y comparaciones |
| info | `parametro-con-variantes` | `cod_rel` | se escribe de 2 formas: `codrel` (6), `cod_rel` (298) |
| info | `parametro-con-variantes` | `fecha` | se escribe de 2 formas: `Fecha` (7), `fecha` (69) |
| info | `parametro-con-variantes` | `tip_cod` | se escribe de 2 formas: `tipcod` (8), `tip_cod` (289) |
<!-- generado:fin -->
