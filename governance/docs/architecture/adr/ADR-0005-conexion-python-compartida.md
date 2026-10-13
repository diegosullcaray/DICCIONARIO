# ADR-0005 — Conexión desde Python con el contrato de REPORTES-AUTOMATIZADOS

**Estado**: aceptada · **Fecha**: 2026-10-12

## Contexto

Extraer 271 SP y sus dependencias desde SSMS es manual y propenso a errores (`sp_helptext` corta líneas,
el CSV se guarda sin encabezados). REPORTES-AUTOMATIZADOS ya resolvió cómo conectarse a los 3 servidores
del MIS: `.env` con `MISH_*`, `SLC_*`, `RCC_*`, un mapa base → servidor y un único módulo que abre conexiones.

## Decisión

`extraccion/herramientas/` replica ese contrato en Python (`config.py`, `db.py`) y acepta el mismo `.env` (`--env`).
Dos diferencias deliberadas: **sin hosts por defecto en el código** (este repositorio no versiona servidores)
y conexiones con `ApplicationIntent=ReadOnly`. Python solo **lee de la base y escribe en `extraccion/fuente/` y
`extraccion/procedimientos/`**; el análisis y la generación siguen en Node, para tener un único analizador.

## Consecuencias

- `python extraccion/herramientas/bd.py todo` reemplaza los pasos manuales de SSMS; los SQL generados siguen sirviendo
  para quien no tenga Python o el driver.
- `BASES_DE` está duplicado con REPORTES-AUTOMATIZADOS: si cambia allá, actualizarlo acá.
- La estructura real de las tablas habilita las reglas `tabla-inexistente` y `columna-inexistente`.
