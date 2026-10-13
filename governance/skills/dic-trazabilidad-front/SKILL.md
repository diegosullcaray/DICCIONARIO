---
name: dic-trazabilidad-front
description: Cómo unir un RCODREP con su pantalla en MIS-angular-front y con su tabla de origen, en las dos direcciones. Usar para rastrear de dónde sale una cifra de la pantalla, medir el impacto de cambiar una tabla o SP, o priorizar qué SP extraer primero.
---

# Trazabilidad con el front

## 1. Actualizar la foto

```bash
npm run trazar:front                       # asume ../MIS-angular-front
node governance/scripts/trazar-front.mjs --front=<ruta>
npm run generar
```

Busca cada RCODREP como literal en `src/app/**/*.ts` y guarda `extraccion/fuente/consumo-front.json` con el commit
del front leído. En el front, los códigos viven en `constantes/*.constantes.ts` de cada módulo
(ver su `governance/docs/data/catalog.md`).

## 2. De la pantalla a la tabla

1. En el front: constante del módulo → `cod_rep`.
2. Acá: [reportes.md](../../../diccionario/reportes.md) → SP → ficha.
3. Ficha → *Columnas que devuelve* (lo que recibe el front) y *Tablas y columnas* (de dónde sale).

## 3. De la tabla a las pantallas (impacto)

Ficha de tabla → *Procedimientos que la usan* → columna *Reportes* → `reportes.md` → *Front MIS*.
Para un cambio de columna, buscar la columna en `diccionario/diccionario.json`:

```bash
node -e "const d=require('./diccionario/diccionario.json'); for (const t of d.tablas) for (const c of t.columnas) if (c.nombre.toUpperCase()==='HFCRES') console.log(t.nombre, c.procedimientos)"
```

## 4. Priorizar

Un SP con *Front* = sí y estado ⏳ es una pantalla en producción sin linaje documentado: va primero.
`diccionario/procedimientos.md` tiene las dos columnas lado a lado.

## 5. Límites

- La búsqueda es por literal: un código armado por concatenación no se detecta.
- Un código en un `.spec.ts` solo cuenta como prueba, no como consumo.
- Es una foto: si el front cambió desde el commit registrado, volver a trazar.
