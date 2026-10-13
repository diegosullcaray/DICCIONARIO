#!/usr/bin/env node
// Genera los SQL para consultar los procedimientos del catálogo en SQL Server.
//
//   extraccion/sql/01-extraccion/<base>/<esquema>/<SP>.sql   un sp_helptext por SP (el patrón original)
//   extraccion/sql/01-extraccion/_lotes/<base>.sql           inventario + definición de todos los SP de una base
//   extraccion/sql/01-extraccion/manifiesto.json             lo que lee extraer-definiciones.ps1
//   extraccion/sql/02-dependencias/<base>.sql                tablas y columnas según el motor (dm_sql_referenced_entities)
//
// Uso: node governance/scripts/generar-extraccion.mjs [--check]

import { join } from 'node:path';
import { argumentos, cargarCatalogo, rel, RUTAS } from './lib/catalogo.mjs';
import { Salida } from './lib/salida.mjs';

const { flags } = argumentos();
const salida = new Salida({ check: flags.has('check') });
const { sps } = cargarCatalogo();

const DIR_EXT = join(RUTAS.sql, '01-extraccion');
const DIR_DEP = join(RUTAS.sql, '02-dependencias');
const lit = (s) => `N'${String(s).replace(/'/g, "''")}'`;

const porBase = new Map();
for (const sp of sps.values()) {
  const base = sp.base ?? '_sin_base';
  if (!porBase.has(base)) porBase.set(base, []);
  porBase.get(base).push(sp);
}

// ─── 1. Un archivo por SP ─────────────────────────────────────────────────────
const manifiesto = [];
for (const sp of sps.values()) {
  const archivo = join(DIR_EXT, sp.base ?? '_sin_base', sp.esquema ?? 'dbo', `${sp.nombre}.sql`);
  const lineasReportes = sp.reportes.map((r) => {
    const p = r.params.map((x) => x.nombre).join(', ') || '(sin parámetros)';
    return `--   ${r.codigo.padEnd(24)} ${r.descripcion ?? ''}  ·  params: ${p}`;
  });
  const grafias = [...sp.grafias].filter((g) => g !== sp.completo);
  salida.escribir(archivo, [
    `-- ${sp.completo}`,
    '-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.',
    '--',
    `-- Reportes (RCODREP) que ejecutan este SP: ${sp.reportes.length}`,
    ...lineasReportes,
    ...(grafias.length ? ['--', `-- En reportes.json aparece también como: ${grafias.map((g) => JSON.stringify(g)).join(', ')}`] : []),
    '--',
    `-- Pegar el resultado (el CREATE PROCEDURE completo) en: ${rel(sp.archivoCuerpo)}`,
    '-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas',
    '-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).',
    '',
    `USE ${sp.base ?? '<base>'};`,
    'GO',
    `EXEC sp_helptext '${sp.esquema ?? 'dbo'}.${sp.nombre}';`,
    '',
    `-- SELECT OBJECT_DEFINITION(OBJECT_ID(${lit(`${sp.esquema ?? 'dbo'}.${sp.nombre}`)})) AS definicion;`,
    '',
  ].join('\n'));
  manifiesto.push({
    base: sp.base,
    esquema: sp.esquema ?? 'dbo',
    nombre: sp.nombre,
    destino: rel(sp.archivoCuerpo),
    extraido: sp.tieneCuerpo,
  });
}

// ─── 2. Lote por base: inventario + definición ────────────────────────────────
for (const [base, lista] of porBase) {
  const valores = lista.map((sp, i) =>
    `    ${i === 0 ? ' ' : ','}(${lit(sp.esquema ?? 'dbo')}, ${lit(sp.nombre)}, ${lit(rel(sp.archivoCuerpo))}, ${sp.tieneCuerpo ? 1 : 0})`);
  salida.escribir(join(DIR_EXT, '_lotes', `${base}.sql`), [
    `-- Lote de extracción: base ${base} · ${lista.length} procedimiento(s)`,
    '-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera.',
    '--',
    '-- 1. Ejecutar en SSMS con "Resultados a cuadrícula".',
    '-- 2. `existe = 0` → el SP del catálogo ya no está en la base: registrarlo como hallazgo.',
    '-- 3. Copiar `definicion` de cada fila a su `destino` (activar en SSMS:',
    '--    Herramientas > Opciones > Resultados > Cuadrícula > "Conservar CR/LF al copiar").',
    '--    Para automatizarlo: extraccion/herramientas/extraer-definiciones.ps1',
    '',
    `USE ${base};`,
    'GO',
    'SET NOCOUNT ON;',
    '',
    'DECLARE @catalogo TABLE (esquema sysname, nombre sysname, destino nvarchar(400), extraido bit);',
    'INSERT INTO @catalogo (esquema, nombre, destino, extraido) VALUES',
    ...valores,
    ';',
    '',
    'SELECT',
    '    c.esquema,',
    '    c.nombre,',
    '    c.destino,',
    '    c.extraido,',
    '    CASE WHEN o.object_id IS NULL THEN 0 ELSE 1 END AS existe,',
    '    o.create_date AS creado,',
    '    o.modify_date AS modificado,',
    '    OBJECT_DEFINITION(o.object_id) AS definicion',
    'FROM @catalogo c',
    'LEFT JOIN sys.objects o',
    "    ON o.object_id = OBJECT_ID(QUOTENAME(c.esquema) + N'.' + QUOTENAME(c.nombre))",
    "   AND o.type IN ('P', 'PC')",
    '-- WHERE c.extraido = 0   -- descomentar para traer solo los pendientes',
    'ORDER BY c.extraido, c.esquema, c.nombre;',
    '',
  ].join('\n'));
}

// ─── 3. Dependencias según el motor, por base ─────────────────────────────────
for (const [base, lista] of porBase) {
  const valores = lista.map((sp, i) => `    ${i === 0 ? ' ' : ','}(${lit(sp.esquema ?? 'dbo')}, ${lit(sp.nombre)})`);
  salida.escribir(join(DIR_DEP, `${base}.sql`), [
    `-- Dependencias según el motor: base ${base} · ${lista.length} procedimiento(s)`,
    '-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera.',
    '--',
    '-- Qué devuelve: una fila por (SP, tabla, columna) que SQL Server tiene registrada.',
    '-- Cómo se usa: ejecutar, "Guardar resultados como…" CSV CON encabezados en',
    `--   extraccion/fuente/dependencias/${base}.csv  y correr  npm run generar.`,
    '--',
    '-- Límites del motor (ver skill dic-analisis-dependencias):',
    '--   · Las columnas de tablas de OTRA base no se resuelven (ref_columna queda vacía):',
    '--     para esas, manda el analizador estático.',
    '--   · SQL dinámico (EXEC(@sql), sp_executesql) y tablas #temporales no aparecen.',
    '--   · Si un SP no compila contra el esquema actual, `error` lo dice y se sigue con el resto.',
    '',
    `USE ${base};`,
    'GO',
    'SET NOCOUNT ON;',
    '',
    'DECLARE @catalogo TABLE (esquema sysname, nombre sysname);',
    'INSERT INTO @catalogo (esquema, nombre) VALUES',
    ...valores,
    ';',
    '',
    'DECLARE @resultado TABLE (',
    '    sp_base sysname, sp_esquema sysname, sp_nombre sysname,',
    '    ref_servidor sysname NULL, ref_base sysname NULL, ref_esquema sysname NULL,',
    '    ref_entidad sysname NULL, ref_columna sysname NULL, ref_tipo nvarchar(60) NULL, ref_objeto_tipo nvarchar(60) NULL,',
    '    es_lectura bit NULL, es_escritura bit NULL, es_select_todo bit NULL,',
    '    origen varchar(30), error nvarchar(2000) NULL);',
    '',
    'DECLARE @esquema sysname, @nombre sysname, @objeto nvarchar(520);',
    'DECLARE c CURSOR LOCAL FAST_FORWARD FOR SELECT esquema, nombre FROM @catalogo;',
    'OPEN c;',
    'FETCH NEXT FROM c INTO @esquema, @nombre;',
    'WHILE @@FETCH_STATUS = 0',
    'BEGIN',
    "    SET @objeto = QUOTENAME(@esquema) + N'.' + QUOTENAME(@nombre);",
    '    IF OBJECT_ID(@objeto) IS NULL',
    '        INSERT INTO @resultado (sp_base, sp_esquema, sp_nombre, origen, error)',
    "        VALUES (DB_NAME(), @esquema, @nombre, 'catalogo', N'El SP no existe en esta base');",
    '    ELSE',
    '    BEGIN',
    '        BEGIN TRY',
    '            -- Nivel columna (misma base). Puede fallar si el SP referencia objetos inexistentes.',
    '            INSERT INTO @resultado',
    '            SELECT DB_NAME(), @esquema, @nombre,',
    '                   r.referenced_server_name, ISNULL(r.referenced_database_name, DB_NAME()),',
    '                   r.referenced_schema_name, r.referenced_entity_name, r.referenced_minor_name,',
    '                   r.referenced_class_desc, o.type_desc, r.is_selected, r.is_updated, r.is_select_all,',
    "                   'dm_sql_referenced_entities', NULL",
    "            FROM sys.dm_sql_referenced_entities(@objeto, N'OBJECT') r",
    '            LEFT JOIN sys.objects o ON o.object_id = r.referenced_id;  -- tipo real (tabla, vista, función…); NULL si es de otra base',
    '        END TRY',
    '        BEGIN CATCH',
    '            INSERT INTO @resultado (sp_base, sp_esquema, sp_nombre, origen, error)',
    "            VALUES (DB_NAME(), @esquema, @nombre, 'dm_sql_referenced_entities', ERROR_MESSAGE());",
    '        END CATCH;',
    '',
    '        -- Nivel tabla, nunca falla e incluye referencias a otras bases.',
    '        INSERT INTO @resultado (sp_base, sp_esquema, sp_nombre, ref_servidor, ref_base, ref_esquema,',
    '                                ref_entidad, ref_tipo, ref_objeto_tipo, origen)',
    '        SELECT DB_NAME(), @esquema, @nombre, d.referenced_server_name,',
    '               ISNULL(d.referenced_database_name, DB_NAME()), d.referenced_schema_name,',
    "               d.referenced_entity_name, d.referenced_class_desc, o.type_desc, 'sql_expression_dependencies'",
    '        FROM sys.sql_expression_dependencies d',
    '        LEFT JOIN sys.objects o ON o.object_id = d.referenced_id',
    '        WHERE d.referencing_id = OBJECT_ID(@objeto);',
    '    END;',
    '    FETCH NEXT FROM c INTO @esquema, @nombre;',
    'END;',
    'CLOSE c;',
    'DEALLOCATE c;',
    '',
    'SELECT sp_base, sp_esquema, sp_nombre, ref_servidor, ref_base, ref_esquema, ref_entidad,',
    '       ref_columna, ref_tipo, ref_objeto_tipo, es_lectura, es_escritura, es_select_todo, origen, error',
    'FROM @resultado',
    'ORDER BY sp_esquema, sp_nombre, ref_base, ref_esquema, ref_entidad, ref_columna;',
    '',
  ].join('\n'));
}

salida.escribir(join(DIR_EXT, 'manifiesto.json'), `${JSON.stringify({
  nota: 'Generado por governance/scripts/generar-extraccion.mjs. Lo consume extraer-definiciones.ps1.',
  procedimientos: manifiesto,
}, null, 2)}\n`);

salida.podar(DIR_EXT, (r) => r.endsWith('.sql'));
salida.podar(DIR_DEP, (r) => r.endsWith('.sql'));
process.exitCode = salida.informe('Scripts de extracción y dependencias');
