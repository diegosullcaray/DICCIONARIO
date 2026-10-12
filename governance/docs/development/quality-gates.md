# Compuertas de calidad

| Comando | Qué verifica | Bloquea |
|---|---|---|
| `npm test` | el analizador T-SQL contra casos fijos y el SP real `GSELREP001` | cualquier prueba roja |
| `npm run test:py` | herramientas Python con conexión simulada; `pyodbc.connect` solo en `db.py` | cualquier prueba roja |
| `npm run verificar` | hallazgos de nivel error · generados al día · enlaces internos · índice de skills | sí |
| `npm run verificar:estricto` | lo anterior + hallazgos de nivel aviso | sí, para cerrar una base completa |
| `npm run hallazgos` | lista completa, con los informativos | no (informe) |

## Qué hace cada rol con la compuerta

- **Antes de commitear**: `npm run generar && npm run verificar && npm test`.
- **No** se edita un archivo generado para que pase `verificar`: se corrige la fuente y se regenera.
- **No** se baja el nivel de una regla para destrabar: si la regla está mal, se cambia en
  `lib/modelo.mjs` con su porqué en [calidad del dato](../data/quality.md), en un commit propio.

## Qué no cubre

- Que la descripción escrita a mano sea correcta: eso lo revisa el
  [auditor de calidad](../../agents/04-auditor-calidad-dato.md).
- Que el cuerpo extraído sea la versión vigente en producción: comparar `modificado` en el lote de la base.
