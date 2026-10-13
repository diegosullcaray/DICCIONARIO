# Calidad del dato

Qué controla `npm run verificar`, cómo se lee un hallazgo y qué hacer con él. El estado actual, por
origen, está en [hallazgos](../evidence/quality/hallazgos.md).

## Niveles y origen

Cada hallazgo tiene un **nivel** (qué tan grave) y un **origen** (dónde se corrige):

| Nivel | Efecto en `npm run verificar` |
|---|---|
| **error** | falla, salvo que esté en la línea base |
| **aviso** | se informa; falla con `--estricto` si es nuevo |
| **info** | solo con `--detalle` |

| Origen | Dónde se corrige |
|---|---|
| `catalogo` | en la tabla de reportes del backend; luego se reexporta `fuente/reportes.json` |
| `produccion` | en el SP o en la base, por su dueño. Este repositorio lo **detecta y documenta**, no lo corrige |
| `repositorio` | acá: archivos mal ubicados o incompletos |
| `analisis` | límite del analizador: se revisa a mano y se anota en la ficha, o se mejora el analizador con un caso de prueba |

## Línea base

Los hallazgos de producción y catálogo existían antes de documentarlos y no se arreglan desde este
repositorio. Para que no tapen los nuevos, se congelan en `governance/linea-base.json`
([ADR-0006](../architecture/adr/ADR-0006-linea-base-de-hallazgos.md)):

```bash
npm run verificar                           # falla solo por errores nuevos
npm run hallazgos                           # todo, incluido lo congelado
node governance/scripts/validar.mjs --guardar-linea-base   # congelar (deliberado, en un commit propio)
```

Cuando un hallazgo congelado se corrige en producción, `verificar` avisa que la línea base quedó
vencida: se regenera para que no esconda una regresión futura.

## Reglas

Se derivan de `REGLAS` en `governance/scripts/lib/modelo.mjs`: para cambiar una regla se edita ahí.

<!-- generado:inicio reglas -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Regla | Nivel | Origen | Qué detecta |
|---|---|---|---|
| `codigo-duplicado` | aviso | catalogo | un RCODREP aparece más de una vez (error si las entradas difieren) |
| `nombre-con-espacios` | aviso | catalogo | nombre de SP con espacios al inicio o al final |
| `nombre-incompleto` | aviso | catalogo | nombre de SP sin base o sin esquema |
| `nombre-con-grafias` | info | catalogo | el mismo SP escrito con mayúsculas distintas |
| `parametro-con-variantes` | info | catalogo | `tip_cod`/`tipcod`, `cod_rel`/`codrel`, `fecha`/`Fecha`: registrar en el glosario, no "normalizar" el contrato |
| `sp-inexistente` | error | produccion | el SP del catálogo no existe en la base: el reporte falla al ejecutarse |
| `parametros-de-mas` | error | produccion | el reporte envía más parámetros que los que declara el SP |
| `parametros-faltantes` | error | produccion | el reporte envía menos parámetros que los obligatorios del SP |
| `tabla-inexistente` | error | produccion | el SP lee una tabla que no está en la base (borrada, renombrada o sin permiso) |
| `columna-inexistente` | error | produccion | el SP usa, calificada, una columna que la tabla real no tiene |
| `motor-con-error` | aviso | produccion | SQL Server no pudo resolver las dependencias del SP (no compila contra el esquema actual) |
| `esquema-distinto` | aviso | produccion | el CREATE declara otro esquema que el catálogo |
| `cuerpo-de-otro-sp` | error | repositorio | el archivo de `procedimientos/` contiene el CREATE de otro SP |
| `cuerpo-huerfano` | aviso | repositorio | archivo en `procedimientos/` sin SP en el catálogo |
| `cuerpo-incompleto` | aviso | repositorio | archivo sin CREATE/ALTER PROCEDURE: no se analiza |
| `sql-dinamico` | aviso | analisis | `EXEC(@sql)` o `sp_executesql`: sus tablas no las ve ni el análisis ni el motor |
| `columna-sin-resolver` | aviso | analisis | columna sin calificar con varias tablas posibles que la estructura real no pudo desempatar |
| `columna-inferida-inexistente` | aviso | analisis | columna inferida que no existe en la tabla: el analizador la atribuyó mal (alias o columna de otra tabla) |
| `discrepancia-motor` | aviso | analisis | tabla de la misma base que ve el analizador y no el motor |
| `tabla-de-trabajo` | info | analisis | tabla permanente que el propio SP crea y borra en cada ejecución |
| `parametro-nombre-distinto` | info | analisis | en la misma posición, otro nombre: solo importa si el backend pasa parámetros por nombre |
| `analisis-aproximado` | info | analisis | MERGE o PIVOT: revisar columnas a mano |
| `varios-resultados` | info | analisis | el SP devuelve más de un conjunto de filas: confirmar cuál consume el reporte |
<!-- generado:fin -->

## Compuertas

| Comando | Qué verifica | Falla si… |
|---|---|---|
| `npm run verificar` | hallazgos · generados al día · enlaces internos · rutas con choque de mayúsculas · línea base vigente | hay un error nuevo o cualquier falla estructural |
| `npm run verificar:estricto` | lo anterior | además, hay un aviso nuevo |
| `npm run hallazgos` | lista completa, con informativos y los de la línea base | nunca (informe) |
| `npm test` | el analizador T-SQL contra casos fijos y el SP real `GSELREP001` | una prueba roja |
| `npm run test:py` | herramientas Python con conexión simulada; `pyodbc.connect` solo en `db.py` | una prueba roja |

- No se edita un generado para que pase `verificar`: se corrige la fuente y se regenera.
- No se relaja una regla para destrabar: se cambia en `REGLAS` con su porqué, en un commit propio.
- No cubre que la prosa escrita a mano sea correcta: eso lo revisa el
  [auditor de calidad](../../agents/04-auditor-calidad-dato.md).
