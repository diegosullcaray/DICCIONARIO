// Pruebas del analizador T-SQL. Cada caso es un patrón que aparece en los SP de reportes.
// Correr: npm test

import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { test } from 'node:test';
import { RAIZ } from '../lib/catalogo.mjs';
import { analizarProcedimiento, tokenizar } from '../lib/tsql.mjs';

const ctx = { base: 'mod_rep', esquema: 'rep' };
const tabla = (r, nombre) => r.tablas.find((t) => t.completo === nombre);
const columnas = (r, nombre) => tabla(r, nombre)?.columnas.map((c) => `${c.nombre}:${c.confianza}`) ?? [];

test('GSELREP001 real: CTE encadenadas, tabla de otra base, EXEC de cabecera y salida', () => {
  const texto = readFileSync(join(RAIZ, 'procedimientos', 'mod_rep', 'com', 'GSELREP001.sql'), 'utf8');
  const r = analizarProcedimiento(texto, { base: 'mod_rep', esquema: 'com' });
  assert.equal(r.procedimiento.nombre, 'GSELREP001');
  assert.deepEqual(r.procedimiento.parametros, []);
  assert.deepEqual(r.tablas.map((t) => t.completo), ['storage.com_act.WCED001']);
  assert.deepEqual(columnas(r, 'storage.com_act.WCED001'), ['HFCRES:inferida']);
  assert.deepEqual(r.ctes, ['cte_e', 'cte_f', 'cte_r']);
  assert.deepEqual(r.invocaciones.map((i) => i.nombre), ['mod_rep.rep.FTHEACOLS01']);
  assert.deepEqual(r.resultados, [['id', 'desc']]);
  assert.equal(r.sinResolver.length, 0);
});

test('comentarios y cadenas no generan referencias', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X AS
    -- SELECT FALSA FROM dbo.NO_EXISTE
    /* SELECT OTRA FROM dbo.TAMPOCO /* anidado */ */
    SELECT 'FROM dbo.EN_CADENA' AS txt, a.COL FROM dbo.REAL a`, ctx);
  assert.deepEqual(r.tablas.map((t) => t.completo), ['mod_rep.dbo.REAL']);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.REAL'), ['COL:exacta']);
});

test('firma: tipos con largo, valores por defecto y OUTPUT', () => {
  const r = analizarProcedimiento(`CREATE PROCEDURE [rep].[GSREVA01]
    @Fecha varchar(8), @tipcod int = 1, @codrel varchar(20) = NULL, @total decimal(18,2) OUTPUT
    AS SELECT 1 x`, ctx);
  assert.deepEqual(r.procedimiento.parametros.map((p) => [p.nombre, p.tipo, p.porDefecto, p.salida]), [
    ['@Fecha', 'varchar(8)', null, false],
    ['@tipcod', 'int', '1', false],
    ['@codrel', 'varchar(20)', 'NULL', false],
    ['@total', 'decimal(18,2)', null, true],
  ]);
});

test('JOIN con alias: columnas exactas por tabla, base y esquema implícitos', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X @f date AS
    SELECT m.CODAGE, a.NOMAGE, SUM(m.SALDO) saldo
    FROM storage.com_act.MAESTRO m WITH (NOLOCK)
    INNER JOIN dbo.AGENCIA AS a ON a.CODAGE = m.CODAGE
    LEFT JOIN CLIENTE c ON c.CODCLI = m.CODCLI
    WHERE m.FECHA = @f
    GROUP BY m.CODAGE, a.NOMAGE`, ctx);
  assert.deepEqual(columnas(r, 'storage.com_act.MAESTRO'), ['CODAGE:exacta', 'CODCLI:exacta', 'FECHA:exacta', 'SALDO:exacta']);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.AGENCIA'), ['CODAGE:exacta', 'NOMAGE:exacta']);
  assert.equal(tabla(r, 'mod_rep.rep.CLIENTE').esquemaImplicito, true);
  assert.deepEqual(r.resultados, [['CODAGE', 'NOMAGE', 'saldo']]);
});

test('columna sin calificar con varias tablas queda sin resolver, con candidatas', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X AS
    SELECT AMBIGUA FROM dbo.A a JOIN dbo.B b ON a.ID = b.ID`, ctx);
  assert.deepEqual(r.sinResolver, [{ columna: 'AMBIGUA', candidatas: ['mod_rep.dbo.A', 'mod_rep.dbo.B'] }]);
});

test('CASE ... END alias no se confunde con columna ni corta la sentencia', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X AS
    SELECT CASE WHEN t.DIAS > 30 THEN 'MORA' ELSE 'AL DIA' END AS estado, t.SALDO
    FROM dbo.CARTERA t`, ctx);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.CARTERA'), ['DIAS:exacta', 'SALDO:exacta']);
  assert.deepEqual(r.resultados, [['estado', 'SALDO']]);
  assert.equal(r.sinResolver.length, 0);
});

test('subconsultas: derivada, EXISTS correlacionado y escalar en DECLARE', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X @t int AS
    DECLARE @f date = (SELECT MAX(c.FECCIE) FROM dbo.CIERRE c);
    SELECT m.COD FROM dbo.MAESTRO m
    JOIN (SELECT CODCLI, COUNT(*) n FROM dbo.CLIENTE GROUP BY CODCLI) cl ON cl.CODCLI = m.CODCLI
    WHERE EXISTS (SELECT 1 FROM dbo.JERARQUIA j WHERE j.COD = m.COD AND j.TIP = @t)`, ctx);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.CIERRE'), ['FECCIE:exacta']);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.CLIENTE'), ['CODCLI:inferida']);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.JERARQUIA'), ['COD:exacta', 'TIP:exacta']);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.MAESTRO'), ['COD:exacta', 'CODCLI:exacta']);
});

test('escrituras: INSERT con lista, UPDATE por alias, DELETE, SELECT INTO temporal', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X AS
    SELECT a.COD INTO #tmp FROM dbo.ORIGEN a;
    UPDATE t SET t.MARCA = 1 FROM dbo.DESTINO t JOIN #tmp x ON x.COD = t.COD;
    INSERT INTO dbo.BITACORA (CODREP, FECHA) VALUES ('X', GETDATE());
    DELETE FROM dbo.VIEJOS WHERE FECHA < '20200101';
    SELECT COD FROM #tmp;`, ctx);
  assert.deepEqual(tabla(r, 'mod_rep.dbo.DESTINO').usos, ['actualiza', 'lee']);
  assert.deepEqual(tabla(r, 'mod_rep.dbo.BITACORA').usos, ['inserta']);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.BITACORA'), ['CODREP:exacta', 'FECHA:exacta']);
  assert.deepEqual(tabla(r, 'mod_rep.dbo.VIEJOS').usos, ['elimina']);
  assert.deepEqual(r.temporales, ['#tmp']);
  assert.ok(!r.tablas.some((t) => t.nombre.startsWith('#')));
  // El SELECT ... INTO no es un resultado; el último SELECT sí.
  assert.deepEqual(r.resultados, [['COD']]);
});

test('SQL dinámico se marca; SELECT de asignación no es resultado', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X AS
    DECLARE @n int; DECLARE @sql nvarchar(max) = N'SELECT * FROM dbo.Y';
    SELECT @n = COUNT(*) FROM dbo.Z;
    EXEC sp_executesql @sql;`, ctx);
  assert.equal(r.sqlDinamico, true);
  assert.deepEqual(r.resultados, []);
  assert.deepEqual(r.tablas.map((t) => t.completo), ['mod_rep.dbo.Z']);
});

test('UNION: un solo conjunto de resultados con los nombres del primer SELECT', () => {
  const r = analizarProcedimiento(`CREATE PROC rep.X AS
    SELECT 0 id, 'TODO' descr UNION ALL SELECT COD, NOM FROM dbo.CAT ORDER BY id`, ctx);
  assert.deepEqual(r.resultados, [['id', 'descr']]);
  assert.deepEqual(columnas(r, 'mod_rep.dbo.CAT'), ['COD:inferida', 'NOM:inferida']);
});

test('tokenizador: identificadores multiparte con corchetes y base..tabla', () => {
  const ids = tokenizar('SELECT * FROM [mod_rep].[com].[T 1] JOIN storage..X').filter((t) => t.t === 'id').map((t) => t.partes);
  assert.deepEqual(ids, [['SELECT'], ['FROM'], ['mod_rep', 'com', 'T 1'], ['JOIN'], ['storage', '', 'X']]);
});
