# Tablero de seguimiento comercial — design reference

This is a design mockup created in a visual design tool (an appifact
design canvas), exported as a standalone page. It shows the advisor's
commercial follow-up dashboard (Tablero de Seguimiento Comercial) inside
the MIS system interface. Treat it as a REFERENCE MOCKUP, not production
code: the markup and inline styles carry the design's precise values —
colors, font sizes, spacing, radii, shadows, layout — which an
implementation should replicate faithfully in its own components and
styling system rather than copy wholesale. All figures are sample data.

## Contents

- `Main.dc.html` — the artboard (a Design Component: an `<x-dc>`
  template + a small logic class). The values to replicate live in its
  inline `style="…"` attributes and the `<helmet><style>` block. The
  cards are static: clicking them opens no detail view. The Digital card
  replaces the former Desempeño card; its variables are DIG01–DIG19
  in `querys/tablero_seguimiento/variables.md` §5.4.
- `ranking.js`, `ranking.css` — the Ranking de productividad panel, opened
  with the Rankings button: it replaces the window content and has a
  button back to the dashboard. Definitions and rules come from
  `querys/tablero_seguimiento/ranking_productividad.md`; open points
  A2–A7 use the provisional option, marked in `ranking.js`. The data is
  sample data generated with a fixed seed from the advisor upwards, so
  the five levels add up. `Main.dc.html#ranking/<nivel>` opens it
  directly (`asesor`, `coordinacion`, `unidad`, `corredor`, `territorio`).
- `system-shell.css` — styling for the surrounding system interface
  (sidebar, user header, report window) and for the Cartera and
  Clientes cards, including compact layouts for short screens.
- `preview-system.png` — render of the full page at 1366×700.
- `reference/captura.png` — the dashboard cards as they stood before
  Digital replaced Desempeño; the source of truth for the other five cards.
- `reference/card.png` — close-up of the former Desempeño card, kept for
  history only.
- `reference/html/` — a saved page of the real MIS system, from which the
  system interface measurements and tokens were taken; the sidebar logo
  is loaded from here.
- `support.js`, `vendor/react*.js` — the runtime that renders the
  component in a browser; not part of the design.

## Viewing

Serve the folder (e.g. `python3 -m http.server`) and open `Main.dc.html`;
some browsers block the scripts over file://.
