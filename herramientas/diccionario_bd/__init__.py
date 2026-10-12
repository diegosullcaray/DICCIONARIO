"""Herramientas Python del DICCIONARIO: leen los SP y sus dependencias directo de SQL Server.

Mismo patrón de conexión que REPORTES-AUTOMATIZADOS: 3 servidores (mish, slc, rcc) definidos en `.env`,
`config.py` decide qué base vive en qué servidor y `db.py` es el único lugar que abre conexiones.
Todo es de solo lectura: metadatos, OBJECT_DEFINITION y consultas a INFORMATION_SCHEMA.
"""
