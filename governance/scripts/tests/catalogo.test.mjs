// Pruebas del catálogo y de la importación de dependencias del motor.

import assert from 'node:assert/strict';
import { test } from 'node:test';
import { normalizarSp } from '../lib/catalogo.mjs';
import { parsearCsv } from '../lib/dependencias.mjs';

test('normalizarSp: corchetes y espacios no crean un SP distinto', () => {
  const a = normalizarSp('[mod_rep].[com].[GCMGMORA001]');
  const b = normalizarSp('mod_rep.com.GCMGMORA001');
  const c = normalizarSp('strategos.mod_rep_com_act.GDDESEMDIA  ');
  assert.equal(a.clave, b.clave);
  assert.equal(a.completo, 'mod_rep.com.GCMGMORA001');
  assert.equal(c.completo, 'strategos.mod_rep_com_act.GDDESEMDIA');
  assert.equal(c.irregular, true);
  assert.equal(b.irregular, false);
});

test('normalizarSp: mayúsculas distintas son el mismo SP (collation CI)', () => {
  assert.equal(normalizarSp('mod_rep.REP.gsreva01').clave, normalizarSp('mod_rep.[rep].GSREVA01').clave);
});

test('parsearCsv: separador detectado, comillas y NULL de SSMS', () => {
  const filas = parsearCsv('sp_base;sp_nombre;ref_columna;error\r\nmod_rep;X;NULL;"a; b"\r\n');
  assert.deepEqual(filas, [{ sp_base: 'mod_rep', sp_nombre: 'X', ref_columna: '', error: 'a; b' }]);
});
