# ADR-0002 — El diccionario se deriva

**Estado**: aceptada · **Fecha**: 2026-10-12

## Contexto

Un diccionario escrito a mano envejece en cuanto alguien modifica un SP. Pero hay conocimiento que no
se puede derivar: qué significa una columna o por qué un filtro excluye ciertos productos.

## Decisión

Lo derivable (tablas, columnas, firma, reportes, consumo) se **genera** entre marcadores
`<!-- generado:inicio … -->` / `<!-- generado:fin -->`. Lo no derivable se escribe **debajo** del bloque,
y el generador nunca lo toca. Las descripciones de columna escritas como `` - `COL`: texto `` en la
ficha de tabla se copian a la tabla generada.

## Consecuencias

- `npm run verificar` puede exigir que todo lo derivado esté al día.
- Si un SP cambia, su ficha se actualiza sola; la prosa puede quedar desfasada y es responsabilidad del
  [auditor de calidad](../../../agents/04-auditor-calidad-dato.md) revisarla.
- Las fichas no se borran solas: un SP retirado del catálogo deja su ficha, que se borra a mano.
