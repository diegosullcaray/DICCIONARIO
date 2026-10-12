# Calidad del dato

Reglas que `npm run verificar` aplica y cómo se resuelve cada hallazgo. El estado actual está en
[hallazgos](../evidence/quality/hallazgos.md).

## Niveles

| Nivel | Qué hace | Ejemplo |
|---|---|---|
| **error** | `npm run verificar` falla | el reporte envía más parámetros de los que el SP declara |
| **aviso** | se informa; falla con `--estricto` | columna sin resolver |
| **info** | solo con `--detalle` | un parámetro escrito de dos formas |

## Reglas

| Regla | Nivel | Qué detecta | Cómo se resuelve |
|---|---|---|---|
| `codigo-duplicado` | aviso / error | un RCODREP aparece más de una vez; error si las entradas difieren | corregir la tabla de reportes en el backend y reexportar |
| `nombre-con-espacios` | aviso | nombre de SP con espacios al inicio o al final | idem |
| `nombre-incompleto` | aviso | nombre de SP sin base o sin esquema | idem |
| `nombre-con-grafias` | info | el mismo SP escrito con mayúsculas distintas | idem (SQL Server no distingue, una búsqueda de texto sí) |
| `parametro-con-variantes` | info | `tip_cod`/`tipcod`, `cod_rel`/`codrel`, `fecha`/`Fecha` | registrar en el glosario; no "normalizar" el contrato |
| `parametros-de-mas` | error | el reporte envía más parámetros que la firma del SP | el reporte fallaría al ejecutarse: confirmar con el backend |
| `parametros-faltantes` | error | el reporte envía menos que los obligatorios del SP | idem |
| `parametro-nombre-distinto` | info | en la misma posición, otro nombre | solo importa si el backend pasa parámetros por nombre |
| `cuerpo-de-otro-sp` | error | el archivo de `procedimientos/` contiene otro CREATE | se pegó en el archivo equivocado |
| `esquema-distinto` | aviso | el CREATE declara otro esquema que el catálogo | confirmar cuál es el real |
| `cuerpo-huerfano` | aviso | archivo en `procedimientos/` sin SP en el catálogo | moverlo o borrarlo |
| `cuerpo-incompleto` | aviso | archivo sin CREATE/ALTER PROCEDURE | volver a extraer |
| `sql-dinamico` | aviso | `EXEC(@sql)` o `sp_executesql` | documentar a mano las tablas del texto dinámico |
| `columna-sin-resolver` | aviso | columna sin calificar con varias tablas posibles | validar con el motor o leer el SP y anotarlo en la ficha |
| `discrepancia-motor` | aviso | tabla de la misma base que ve el analizador y no el motor | revisar: suele ser un alias mal leído o un objeto que ya no existe |
| `motor-con-error` | aviso | `dm_sql_referenced_entities` falló para el SP | el SP no compila contra el esquema actual: hallazgo para el dueño del SP |
| `tabla-inexistente` | error | la tabla no está en `fuente/estructura/<base>.csv` aunque esa base se consultó | SP roto o tabla renombrada: avisar al dueño del SP |
| `columna-inexistente` | error / aviso | la columna no existe en la tabla real; error si era exacta o del motor, aviso si era inferida | si era inferida, el analizador la atribuyó mal: anotarlo o agregar un caso de prueba |
| `analisis-aproximado` | info | MERGE o PIVOT | revisar columnas a mano |
| `varios-resultados` | info | el SP devuelve más de un conjunto de filas | confirmar cuál consume el reporte |

## Además de los hallazgos

`npm run verificar` también falla si un archivo generado quedó viejo (`npm run generar`), si un enlace
Markdown interno no apunta a nada, o si `.agents/skills.json` no coincide con las skills.
