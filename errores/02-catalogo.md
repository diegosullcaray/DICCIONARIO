# Errores del catálogo

<!-- generado:inicio errores -->
<!-- Generado por governance/scripts/generar-errores.mjs. No editar dentro de este bloque: se regenera. -->

Problemas en `extraccion/fuente/reportes.json`. Se corrigen en la tabla de reportes del backend y se reexporta el archivo.

| Nivel | Regla | Objeto | Detalle | Línea base |
|---|---|---|---|---|
| aviso | `codigo-duplicado` | `CLI_VULNERABLE_01` | aparece 2 veces en reportes.json (entradas idénticas) | sí |
| aviso | `codigo-duplicado` | `PANEL_SUP_02` | aparece 2 veces en reportes.json (entradas idénticas) | sí |
| aviso | `nombre-con-espacios` | `strategos.mod_rep_com_act.GDDESEMDIA` | escrito como "strategos.mod_rep_com_act.GDDESEMDIA  " | sí |
| info | `parametro-con-variantes` | `cod_rel` | `codrel` (6), `cod_rel` (298) | **nuevo** |
| info | `parametro-con-variantes` | `fecha` | `Fecha` (7), `fecha` (69) | **nuevo** |
| info | `parametro-con-variantes` | `tip_cod` | `tipcod` (8), `tip_cod` (289) | **nuevo** |
<!-- generado:fin -->
