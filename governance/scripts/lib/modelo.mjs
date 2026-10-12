// Modelo del diccionario: une las cuatro fuentes en una sola estructura.
//
//   fuente/reportes.json         qué reporte ejecuta qué SP y con qué parámetros
//   procedimientos/**.sql        el cuerpo de cada SP → analizador estático
//   fuente/dependencias/*.csv    lo que SQL Server registra (autoritativo, misma base)
//   fuente/consumo-front.json    qué códigos usa el frontend MIS
//
// Y deriva los hallazgos de calidad. Lo usan generar-diccionario y validar.

import { readFileSync } from 'node:fs';
import { cargarCatalogo, esCuerpoReal, leerJsonOpcional, listarArchivos, partesNombre, rel, RUTAS } from './catalogo.mjs';
import { cargarDependenciasMotor } from './dependencias.mjs';
import { analizarProcedimiento } from './tsql.mjs';

export const NIVELES = { error: 'error', aviso: 'aviso', info: 'info' };

// Variantes de un mismo parámetro de contrato (ver glosario).
export const SINONIMOS_PARAMETRO = {
  tip_cod: ['tip_cod', 'tipcod'],
  cod_rel: ['cod_rel', 'codrel'],
  fecha: ['fecha'], // `fec` es otro parámetro (formato compacto): no es sinónimo
};

const norm = (s) => String(s ?? '').replace(/^@/, '').toLowerCase();

export function construirModelo() {
  const { reportes, sps } = cargarCatalogo();
  const motor = cargarDependenciasMotor();
  const consumo = leerJsonOpcional(RUTAS.consumoFront, { codigos: {} });
  const hallazgos = [];
  const hallazgo = (nivel, regla, objeto, detalle) => hallazgos.push({ nivel, regla, objeto, detalle });

  // ── Reportes
  const porCodigo = new Map();
  for (const r of reportes) {
    r.front = consumo.codigos?.[r.codigo] ?? null;
    if (!porCodigo.has(r.codigo)) porCodigo.set(r.codigo, []);
    porCodigo.get(r.codigo).push(r);
  }
  for (const [codigo, lista] of porCodigo) {
    if (lista.length < 2) continue;
    const mismos = new Set(lista.map((r) => JSON.stringify([r.sp.clave, r.params]))).size === 1;
    hallazgo(mismos ? NIVELES.aviso : NIVELES.error, 'codigo-duplicado', codigo,
      `aparece ${lista.length} veces en reportes.json${mismos ? ' (entradas idénticas)' : ' con SP o parámetros distintos: el backend toma una sola'}`);
  }
  // Los corchetes son SQL válido; lo que se señala es lo que rompe una comparación de texto.
  for (const sp of sps.values()) {
    const sinCorchetes = new Set();
    for (const g of sp.grafias) {
      const partes = partesNombre(g);
      sinCorchetes.add(partes.join('.'));
      if (g !== g.trim()) hallazgo(NIVELES.aviso, 'nombre-con-espacios', sp.completo, `escrito como ${JSON.stringify(g)}: los espacios rompen búsquedas y comparaciones`);
      if (partes.length !== 3) hallazgo(NIVELES.aviso, 'nombre-incompleto', sp.completo, `escrito como ${JSON.stringify(g)}: se espera base.esquema.procedimiento`);
    }
    if (sinCorchetes.size > 1) hallazgo(NIVELES.info, 'nombre-con-grafias', sp.completo, `se escribe de ${sinCorchetes.size} formas: ${[...sinCorchetes].map((x) => `\`${x}\``).join(', ')}`);
  }
  const variantes = new Map();
  for (const r of reportes) for (const p of r.params) {
    for (const [canon, lista] of Object.entries(SINONIMOS_PARAMETRO)) {
      if (lista.includes(p.nombre.toLowerCase())) {
        if (!variantes.has(canon)) variantes.set(canon, new Map());
        const m = variantes.get(canon);
        m.set(p.nombre, (m.get(p.nombre) ?? 0) + 1);
      }
    }
  }
  for (const [canon, m] of variantes) {
    if (m.size > 1) hallazgo(NIVELES.info, 'parametro-con-variantes', canon,
      `se escribe de ${m.size} formas: ${[...m].map(([k, v]) => `\`${k}\` (${v})`).join(', ')}`);
  }

  // ── Procedimientos
  for (const sp of sps.values()) {
    sp.cuerpo = sp.tieneCuerpo ? readFileSync(sp.archivoCuerpo, 'utf8') : null;
    sp.analisis = sp.cuerpo ? analizarProcedimiento(sp.cuerpo, { base: sp.base, esquema: sp.esquema }) : null;
    sp.motor = motor.get(sp.clave) ?? null;
    sp.estado = sp.motor && !sp.motor.errores.length ? 'validado' : sp.analisis ? 'extraido' : 'pendiente';
    sp.front = sp.reportes.some((r) => r.front);

    const a = sp.analisis;
    if (a) {
      const declarado = a.procedimiento;
      if (declarado?.nombre && declarado.nombre.toLowerCase() !== sp.nombre.toLowerCase()) {
        hallazgo(NIVELES.error, 'cuerpo-de-otro-sp', sp.completo, `el archivo contiene CREATE PROCEDURE ${declarado.esquema ?? ''}.${declarado.nombre}`);
      }
      if (declarado?.esquema && sp.esquema && declarado.esquema.toLowerCase() !== sp.esquema.toLowerCase()) {
        hallazgo(NIVELES.aviso, 'esquema-distinto', sp.completo, `el CREATE declara el esquema ${declarado.esquema}`);
      }
      const firma = declarado?.parametros ?? [];
      for (const r of sp.reportes) {
        if (r.params.length > firma.length) {
          hallazgo(NIVELES.error, 'parametros-de-mas', r.codigo,
            `reportes.json envía ${r.params.length} parámetro(s) y ${sp.completo} declara ${firma.length}`);
        } else {
          const obligatorios = firma.filter((p) => p.porDefecto === null && !p.salida).length;
          if (r.params.length < obligatorios) {
            hallazgo(NIVELES.error, 'parametros-faltantes', r.codigo,
              `reportes.json envía ${r.params.length} y ${sp.completo} exige ${obligatorios} sin valor por defecto`);
          }
          r.params.forEach((p, i) => {
            const f = firma[i];
            if (f && norm(f.nombre) !== norm(p.nombre)) {
              hallazgo(NIVELES.info, 'parametro-nombre-distinto', r.codigo,
                `posición ${p.orden}: \`${p.nombre}\` en reportes.json, \`${f.nombre}\` en el SP (si el backend pasa por posición, no afecta)`);
            }
          });
        }
      }
      if (a.sqlDinamico) hallazgo(NIVELES.aviso, 'sql-dinamico', sp.completo, 'usa EXEC(@sql) o sp_executesql: sus tablas no se ven ni en el análisis ni en el motor');
      for (const s of a.sinResolver) {
        hallazgo(NIVELES.aviso, 'columna-sin-resolver', sp.completo,
          `\`${s.columna}\`${s.candidatas.length ? ` podría ser de ${s.candidatas.join(' o ')}` : ''}: calificarla con alias o confirmar con el motor`);
      }
      for (const adv of a.advertencias) hallazgo(NIVELES.info, 'analisis-aproximado', sp.completo, adv);
      if (a.resultados.length > 1) hallazgo(NIVELES.info, 'varios-resultados', sp.completo, `devuelve ${a.resultados.length} conjuntos de resultados`);
    }
    if (sp.motor) for (const e of new Set(sp.motor.errores)) hallazgo(NIVELES.aviso, 'motor-con-error', sp.completo, e);
  }

  // Archivos en procedimientos/ que el catálogo no conoce.
  const esperados = new Set([...sps.values()].map((s) => s.archivoCuerpo));
  for (const f of listarArchivos(RUTAS.procedimientos, (r) => r.endsWith('.sql'))) {
    if (!esperados.has(f)) hallazgo(NIVELES.aviso, 'cuerpo-huerfano', rel(f), 'no corresponde a ningún SP de reportes.json');
    else if (!esCuerpoReal(readFileSync(f, 'utf8'))) hallazgo(NIVELES.aviso, 'cuerpo-incompleto', rel(f), 'no contiene CREATE/ALTER PROCEDURE: no se analiza');
  }

  // ── Dependencias combinadas por SP y agregado por tabla
  const clavesSp = new Set(sps.keys());
  const tablas = new Map();
  for (const sp of sps.values()) {
    const deps = new Map();
    const invocados = new Set((sp.analisis?.invocaciones ?? []).map((i) => i.nombre.toLowerCase().split('.').at(-1)));
    const tomar = (clave, base) => {
      if (!deps.has(clave)) deps.set(clave, { ...base, usos: new Set(), columnas: new Map(), fuentes: new Set() });
      return deps.get(clave);
    };
    for (const t of sp.analisis?.tablas ?? []) {
      const d = tomar(t.clave, { completo: t.completo, base: t.base, esquema: t.esquema, nombre: t.nombre, esquemaImplicito: t.esquemaImplicito });
      d.fuentes.add('estatico');
      for (const u of t.usos) d.usos.add(u);
      for (const c of t.columnas) d.columnas.set(c.nombre.toLowerCase(), { nombre: c.nombre, fuentes: new Set([c.confianza]) });
    }
    for (const [clave, t] of sp.motor?.tablas ?? []) {
      const partes = t.completo.split('.');
      const nombre = partes.at(-1);
      // El motor lista también los SP y funciones invocados: no son tablas.
      if (invocados.has(nombre.toLowerCase()) || clavesSp.has(clave)) continue;
      const d = tomar(clave, { completo: t.completo, base: partes.at(-3) ?? sp.base, esquema: partes.at(-2), nombre, esquemaImplicito: false });
      d.fuentes.add('motor');
      if (t.lectura) d.usos.add('lee');
      if (t.escritura) d.usos.add('escribe');
      for (const c of t.columnas) {
        const k = c.toLowerCase();
        if (!d.columnas.has(k)) d.columnas.set(k, { nombre: c, fuentes: new Set() });
        d.columnas.get(k).fuentes.add('motor');
      }
    }
    if (sp.analisis && sp.motor && !sp.motor.errores.length) {
      for (const d of deps.values()) {
        if (d.fuentes.size === 1 && d.fuentes.has('estatico') && d.base?.toLowerCase() === sp.base?.toLowerCase()) {
          hallazgo(NIVELES.aviso, 'discrepancia-motor', sp.completo, `${d.completo} aparece en el análisis estático pero no en el motor`);
        }
      }
    }
    sp.dependencias = [...deps.values()].sort((a, b) => a.completo.localeCompare(b.completo));

    for (const d of sp.dependencias) {
      const k = d.completo.toLowerCase();
      if (!tablas.has(k)) tablas.set(k, { completo: d.completo, base: d.base, esquema: d.esquema, nombre: d.nombre, columnas: new Map(), sps: new Map() });
      const t = tablas.get(k);
      t.sps.set(sp.clave, { sp, usos: d.usos });
      for (const [ck, c] of d.columnas) {
        if (!t.columnas.has(ck)) t.columnas.set(ck, { nombre: c.nombre, fuentes: new Set(), sps: new Set() });
        const tc = t.columnas.get(ck);
        for (const f of c.fuentes) tc.fuentes.add(f);
        tc.sps.add(sp.completo);
      }
    }
  }

  const orden = { error: 0, aviso: 1, info: 2 };
  hallazgos.sort((a, b) => orden[a.nivel] - orden[b.nivel] || a.regla.localeCompare(b.regla) || a.objeto.localeCompare(b.objeto));

  return {
    reportes,
    sps,
    tablas: new Map([...tablas].sort(([a], [b]) => a.localeCompare(b))),
    hallazgos,
    consumo,
  };
}

/** Mejor confianza conocida de una columna, para mostrar. */
export function confianza(fuentes) {
  if (fuentes.has('motor') && (fuentes.has('exacta') || fuentes.has('inferida'))) return 'confirmada';
  if (fuentes.has('motor')) return 'motor';
  if (fuentes.has('exacta')) return 'exacta';
  return 'inferida';
}
