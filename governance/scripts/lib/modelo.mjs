// Modelo del diccionario: une las fuentes en una sola estructura y deriva los hallazgos.
//
//   extraccion/fuente/reportes.json         qué reporte ejecuta qué SP y con qué parámetros
//   extraccion/procedimientos/**.sql        el cuerpo de cada SP → analizador estático
//   extraccion/fuente/dependencias/*.csv    lo que SQL Server registra de cada SP
//   extraccion/fuente/estructura/*.csv      columnas y tipos reales de cada tabla
//   extraccion/fuente/consumo-front.json    qué códigos usa el frontend MIS
//
// Lo usan generar-diccionario y validar.

import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { cargarCatalogo, esCuerpoReal, leerJsonOpcional, listarArchivos, partesNombre, RAIZ, rel, RUTAS } from './catalogo.mjs';
import { cargarDependenciasMotor } from './dependencias.mjs';
import { cargarEstructura } from './estructura.mjs';
import { analizarProcedimiento } from './tsql.mjs';

export const NIVELES = { error: 'error', aviso: 'aviso', info: 'info' };

// Dónde se corrige cada hallazgo. Ordena el informe y dice a quién escalarlo.
export const ORIGENES = {
  catalogo: 'Catálogo (`extraccion/fuente/reportes.json`): corregir en la tabla de reportes del backend y reexportar',
  produccion: 'Producción (código del SP o la base): reportar al dueño del SP; acá no se corrige',
  repositorio: 'Repositorio: corregir en este repo',
  analisis: 'Límite del análisis: revisar a mano y anotar en la ficha',
};

/**
 * Catálogo único de reglas. La documentación (docs/data/quality.md) se genera desde acá:
 * agregar o cambiar una regla es editar esta tabla.
 */
export const REGLAS = {
  'codigo-duplicado': { nivel: 'aviso', origen: 'catalogo', que: 'un RCODREP aparece más de una vez (error si las entradas difieren)' },
  'nombre-con-espacios': { nivel: 'aviso', origen: 'catalogo', que: 'nombre de SP con espacios al inicio o al final' },
  'nombre-incompleto': { nivel: 'aviso', origen: 'catalogo', que: 'nombre de SP sin base o sin esquema' },
  'nombre-con-grafias': { nivel: 'info', origen: 'catalogo', que: 'el mismo SP escrito con mayúsculas distintas' },
  'parametro-con-variantes': { nivel: 'info', origen: 'catalogo', que: '`tip_cod`/`tipcod`, `cod_rel`/`codrel`, `fecha`/`Fecha`: registrar en el glosario, no "normalizar" el contrato' },
  'sp-inexistente': { nivel: 'error', origen: 'produccion', que: 'el SP del catálogo no existe en la base: el reporte falla al ejecutarse' },
  'parametros-de-mas': { nivel: 'error', origen: 'produccion', que: 'el reporte envía más parámetros que los que declara el SP' },
  'parametros-faltantes': { nivel: 'error', origen: 'produccion', que: 'el reporte envía menos parámetros que los obligatorios del SP' },
  'tabla-inexistente': { nivel: 'error', origen: 'produccion', que: 'el SP lee una tabla que no está en la base (borrada, renombrada o sin permiso)' },
  'columna-inexistente': { nivel: 'error', origen: 'produccion', que: 'el SP usa, calificada, una columna que la tabla real no tiene' },
  'motor-con-error': { nivel: 'aviso', origen: 'produccion', que: 'SQL Server no pudo resolver las dependencias del SP (no compila contra el esquema actual)' },
  'esquema-distinto': { nivel: 'aviso', origen: 'produccion', que: 'el CREATE declara otro esquema que el catálogo' },
  'cuerpo-de-otro-sp': { nivel: 'error', origen: 'repositorio', que: 'el archivo de `extraccion/procedimientos/` contiene el CREATE de otro SP' },
  'cuerpo-huerfano': { nivel: 'aviso', origen: 'repositorio', que: 'archivo en `extraccion/procedimientos/` sin SP en el catálogo' },
  'cuerpo-incompleto': { nivel: 'aviso', origen: 'repositorio', que: 'archivo sin CREATE/ALTER PROCEDURE: no se analiza' },
  'sql-dinamico': { nivel: 'aviso', origen: 'analisis', que: '`EXEC(@sql)` o `sp_executesql`: sus tablas no las ve ni el análisis ni el motor' },
  'columna-sin-resolver': { nivel: 'aviso', origen: 'analisis', que: 'columna sin calificar con varias tablas posibles que la estructura real no pudo desempatar' },
  'columna-inferida-inexistente': { nivel: 'aviso', origen: 'analisis', que: 'columna inferida que no existe en la tabla: el analizador la atribuyó mal (alias o columna de otra tabla)' },
  'discrepancia-motor': { nivel: 'aviso', origen: 'analisis', que: 'tabla de la misma base que ve el analizador y no el motor' },
  'tabla-de-trabajo': { nivel: 'info', origen: 'analisis', que: 'tabla permanente que el propio SP crea y borra en cada ejecución' },
  'parametro-nombre-distinto': { nivel: 'info', origen: 'analisis', que: 'en la misma posición, otro nombre: solo importa si el backend pasa parámetros por nombre' },
  'analisis-aproximado': { nivel: 'info', origen: 'analisis', que: 'MERGE o PIVOT: revisar columnas a mano' },
  'varios-resultados': { nivel: 'info', origen: 'analisis', que: 'el SP devuelve más de un conjunto de filas: confirmar cuál consume el reporte' },
};

// Variantes de un mismo parámetro de contrato (ver glosario).
export const SINONIMOS_PARAMETRO = {
  tip_cod: ['tip_cod', 'tipcod'],
  cod_rel: ['cod_rel', 'codrel'],
  fecha: ['fecha'], // `fec` es otro parámetro (formato compacto): no es sinónimo
};

export const RUTA_LINEA_BASE = join(RAIZ, 'governance', 'linea-base.json');
export const claveHallazgo = (h) => `${h.regla}|${h.objeto}`;

const norm = (s) => String(s ?? '').replace(/^@/, '').toLowerCase();
const masFrecuente = (contador) => [...contador].sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))[0][0];

export function construirModelo() {
  const { reportes, sps } = cargarCatalogo();
  const motor = cargarDependenciasMotor();
  const consumo = leerJsonOpcional(RUTAS.consumoFront, { codigos: {} });
  const estructura = cargarEstructura();
  const lineaBase = new Set(leerJsonOpcional(RUTA_LINEA_BASE, { hallazgos: [] }).hallazgos);
  const hallazgos = [];
  const hallazgo = (regla, objeto, detalle, nivel = REGLAS[regla].nivel) => {
    hallazgos.push({ nivel, regla, origen: REGLAS[regla].origen, objeto, detalle });
  };

  // ── 1. Catálogo
  const porCodigo = new Map();
  for (const r of reportes) {
    r.front = consumo.codigos?.[r.codigo] ?? null;
    if (!porCodigo.has(r.codigo)) porCodigo.set(r.codigo, []);
    porCodigo.get(r.codigo).push(r);
  }
  for (const [codigo, lista] of porCodigo) {
    if (lista.length < 2) continue;
    const mismos = new Set(lista.map((r) => JSON.stringify([r.sp.clave, r.params]))).size === 1;
    hallazgo('codigo-duplicado', codigo,
      `aparece ${lista.length} veces en reportes.json${mismos ? ' (entradas idénticas)' : ' con SP o parámetros distintos: el backend toma una sola'}`,
      mismos ? NIVELES.aviso : NIVELES.error);
  }
  // Los corchetes son SQL válido; se señala lo que rompe una comparación de texto.
  for (const sp of sps.values()) {
    const sinCorchetes = new Set();
    for (const g of sp.grafias) {
      const partes = partesNombre(g);
      sinCorchetes.add(partes.join('.'));
      if (g !== g.trim()) hallazgo('nombre-con-espacios', sp.completo, `escrito como ${JSON.stringify(g)}`);
      if (partes.length !== 3) hallazgo('nombre-incompleto', sp.completo, `escrito como ${JSON.stringify(g)}`);
    }
    if (sinCorchetes.size > 1) hallazgo('nombre-con-grafias', sp.completo, [...sinCorchetes].map((x) => `\`${x}\``).join(', '));
  }
  const variantes = new Map();
  for (const r of reportes) for (const p of r.params) {
    for (const [canon, lista] of Object.entries(SINONIMOS_PARAMETRO)) {
      if (!lista.includes(p.nombre.toLowerCase())) continue;
      if (!variantes.has(canon)) variantes.set(canon, new Map());
      variantes.get(canon).set(p.nombre, (variantes.get(canon).get(p.nombre) ?? 0) + 1);
    }
  }
  for (const [canon, m] of variantes) {
    if (m.size > 1) hallazgo('parametro-con-variantes', canon, [...m].map(([k, v]) => `\`${k}\` (${v})`).join(', '));
  }

  // ── 2. Procedimientos
  for (const sp of sps.values()) {
    sp.cuerpo = sp.tieneCuerpo ? readFileSync(sp.archivoCuerpo, 'utf8') : null;
    sp.analisis = sp.cuerpo ? analizarProcedimiento(sp.cuerpo, { base: sp.base, esquema: sp.esquema }) : null;
    sp.motor = motor.get(sp.clave) ?? null;
    sp.estado = sp.motor?.noExiste && !sp.analisis ? 'inexistente'
      : sp.motor && !sp.motor.noExiste && !sp.motor.errores.length ? 'validado'
        : sp.analisis ? 'extraido' : 'pendiente';
    sp.front = sp.reportes.some((r) => r.front);
    if (sp.estado === 'inexistente') {
      hallazgo('sp-inexistente', sp.completo, `lo ejecutan ${sp.reportes.map((r) => r.codigo).join(', ')}`);
    }

    const a = sp.analisis;
    if (a) {
      const declarado = a.procedimiento;
      if (declarado?.nombre && declarado.nombre.toLowerCase() !== sp.nombre.toLowerCase()) {
        hallazgo('cuerpo-de-otro-sp', sp.completo, `el archivo contiene CREATE PROCEDURE ${declarado.esquema ?? ''}.${declarado.nombre}`);
      }
      if (declarado?.esquema && sp.esquema && declarado.esquema.toLowerCase() !== sp.esquema.toLowerCase()) {
        hallazgo('esquema-distinto', sp.completo, `el CREATE declara el esquema ${declarado.esquema}`);
      }
      const firma = declarado?.parametros ?? [];
      for (const r of sp.reportes) {
        if (r.params.length > firma.length) {
          hallazgo('parametros-de-mas', r.codigo, `reportes.json envía ${r.params.length} y ${sp.completo} declara ${firma.length}`);
          continue;
        }
        const obligatorios = firma.filter((p) => p.porDefecto === null && !p.salida).length;
        if (r.params.length < obligatorios) {
          hallazgo('parametros-faltantes', r.codigo, `reportes.json envía ${r.params.length} y ${sp.completo} exige ${obligatorios} sin valor por defecto`);
        }
        r.params.forEach((p, i) => {
          const f = firma[i];
          if (f && norm(f.nombre) !== norm(p.nombre)) {
            hallazgo('parametro-nombre-distinto', r.codigo, `posición ${p.orden}: \`${p.nombre}\` en reportes.json, \`${f.nombre}\` en el SP`);
          }
        });
      }
      if (a.sqlDinamico) hallazgo('sql-dinamico', sp.completo, 'revisar a mano las tablas del texto dinámico');
      for (const adv of a.advertencias) hallazgo('analisis-aproximado', sp.completo, adv);
      if (a.resultados.length > 1) hallazgo('varios-resultados', sp.completo, `devuelve ${a.resultados.length} conjuntos de resultados`);
    }
    if (sp.motor) for (const e of new Set(sp.motor.errores)) hallazgo('motor-con-error', sp.completo, e);
  }

  const esperados = new Set([...sps.values()].map((s) => s.archivoCuerpo));
  for (const f of listarArchivos(RUTAS.procedimientos, (r) => r.endsWith('.sql'))) {
    if (!esperados.has(f)) hallazgo('cuerpo-huerfano', rel(f), 'no corresponde a ningún SP de reportes.json');
    else if (!esCuerpoReal(readFileSync(f, 'utf8'))) hallazgo('cuerpo-incompleto', rel(f), 'no contiene CREATE/ALTER PROCEDURE');
  }

  // ── 3. Dependencias por SP: análisis estático + motor
  //
  // El motor lista, además de tablas, funciones, SP invocados y alias que no pudo resolver. Una referencia
  // del motor cuenta como tabla si el CSV dice que lo es (ref_objeto_tipo), si el análisis también la ve, o
  // si existe en la estructura real. Lo demás va a `otrosObjetos`: aparece en la ficha, no como tabla.
  const clavesSp = new Set(sps.keys());
  const basesConEstructura = estructura.bases;
  const esTablaReal = (clave) => estructura.tablas.has(clave);
  for (const sp of sps.values()) {
    const deps = new Map();
    const invocados = new Set((sp.analisis?.invocaciones ?? []).map((i) => i.nombre.toLowerCase().split('.').at(-1)));
    sp.otrosObjetos = new Set();
    sp.tiposTabla = new Set(sp.motor?.tipos ?? []);
    const tomar = (clave, datos) => {
      if (!deps.has(clave)) deps.set(clave, { ...datos, usos: new Set(), columnas: new Map(), fuentes: new Set() });
      return deps.get(clave);
    };
    // Nombre sin esquema (`FROM TABLA`): SQL Server lo resuelve en el esquema del usuario y luego en dbo, no
    // necesariamente en el del SP. Si el mismo SP la nombra con esquema, o la estructura real la tiene en
    // otro esquema de la misma base, se usa ese.
    const estaticas = sp.analisis?.tablas ?? [];
    const resolverImplicita = (t) => {
      if (!t.esquemaImplicito) return t;
      const mismoNombre = (x) => x.base?.toLowerCase() === t.base?.toLowerCase() && x.nombre.toLowerCase() === t.nombre.toLowerCase();
      const explicita = estaticas.find((x) => !x.esquemaImplicito && mismoNombre(x));
      const real = [`${t.base}.${t.esquema}.${t.nombre}`, `${t.base}.dbo.${t.nombre}`].map((k) => k.toLowerCase()).find((k) => esTablaReal(k));
      const esquema = explicita?.esquema ?? (real ? real.split('.')[1] : t.esquema);
      return { ...t, esquema, clave: `${t.base}.${esquema}.${t.nombre}`.toLowerCase(), esquemaImplicito: !explicita && !real };
    };
    for (const original of estaticas) {
      const t = resolverImplicita(original);
      const d = tomar(t.clave, { base: t.base, esquema: t.esquema, nombre: t.nombre, esquemaImplicito: t.esquemaImplicito });
      d.fuentes.add('estatico');
      for (const u of t.usos) d.usos.add(u);
      for (const c of t.columnas) d.columnas.set(c.nombre.toLowerCase(), { nombre: c.nombre, fuentes: new Set([c.confianza]) });
    }
    for (const [clave, t] of sp.motor?.tablas ?? []) {
      const partes = t.completo.split('.');
      const [base, esquema, nombre] = [partes.at(-3) ?? sp.base, partes.at(-2), partes.at(-1)];
      if (invocados.has(nombre.toLowerCase()) || clavesSp.has(clave)) continue;
      // Mismo objeto que el análisis vio con esquema implícito: se unen.
      const gemela = deps.get(clave) ?? [...deps.values()].find((d) => d.esquemaImplicito &&
        d.base?.toLowerCase() === base?.toLowerCase() && d.nombre.toLowerCase() === nombre.toLowerCase());
      const esTabla = gemela || (t.objetoTipo ? /TABLE|VIEW/i.test(t.objetoTipo)
        : !t.sinEsquema && (!basesConEstructura.has(String(base).toLowerCase()) || esTablaReal(clave)));
      if (!esTabla) { sp.otrosObjetos.add(t.completo); continue; }
      const d = gemela ?? tomar(clave, { base, esquema, nombre, esquemaImplicito: false });
      d.fuentes.add('motor');
      if (t.lectura) d.usos.add('lee');
      if (t.escritura) d.usos.add('escribe');
      for (const c of t.columnas) {
        const k = c.toLowerCase();
        if (!d.columnas.has(k)) d.columnas.set(k, { nombre: c, fuentes: new Set() });
        d.columnas.get(k).fuentes.add('motor');
      }
    }
    // Columnas sin calificar con varias tablas posibles: la estructura real decide cuando solo una la tiene.
    // Si ninguna la tiene, es un alias o una columna de CTE/derivada: no es de una tabla del diccionario.
    for (const s of sp.analisis?.sinResolver ?? []) {
      const conEstructura = s.candidatas.filter((c) => esTablaReal(c.toLowerCase()));
      const tienen = conEstructura.filter((c) => estructura.tablas.get(c.toLowerCase()).columnas.has(s.columna.toLowerCase()));
      if (tienen.length === 1) {
        const d = deps.get(tienen[0].toLowerCase()) ?? [...deps.values()].find((x) => `${x.base}.${x.esquema}.${x.nombre}`.toLowerCase() === tienen[0].toLowerCase());
        if (d) {
          const k = s.columna.toLowerCase();
          if (!d.columnas.has(k)) d.columnas.set(k, { nombre: s.columna, fuentes: new Set() });
          d.columnas.get(k).fuentes.add('estructura');
          continue;
        }
      }
      if (conEstructura.length === s.candidatas.length && tienen.length === 0) continue;
      hallazgo('columna-sin-resolver', sp.completo, `\`${s.columna}\`${s.candidatas.length ? ` podría ser de ${s.candidatas.join(' o ')}` : ''}`);
    }
    if (sp.estado === 'validado') {
      for (const d of deps.values()) {
        if (d.fuentes.size === 1 && d.fuentes.has('estatico') && d.base?.toLowerCase() === sp.base?.toLowerCase() && !d.usos.has('crea')) {
          hallazgo('discrepancia-motor', sp.completo, `${[d.base, d.esquema, d.nombre].join('.')} aparece en el análisis y no en el motor`);
        }
      }
    }
    sp.dependencias = [...deps.entries()];
  }

  // ── 4. Agregado por tabla, con nombre canónico
  //
  // Una misma tabla aparece como `storage`, `STORAGE` o `Storage`. SQL Server no distingue, pero las carpetas
  // en Windows tampoco: dos grafías generarían rutas que chocan. Manda la grafía real (estructura); si no
  // hay, la más frecuente; base y esquema se unifican por separado para que el árbol sea uno solo.
  const grafiaBase = new Map();
  const grafiaEsquema = new Map();
  const grafiaNombre = new Map();
  const contar = (m, k, v, peso = 1) => { if (!m.has(k)) m.set(k, new Map()); m.get(k).set(v, (m.get(k).get(v) ?? 0) + peso); };
  for (const real of estructura.tablas.values()) {
    contar(grafiaBase, real.base.toLowerCase(), real.base, 1000);
    contar(grafiaEsquema, `${real.base}.${real.esquema}`.toLowerCase(), real.esquema, 1000);
  }
  for (const sp of sps.values()) for (const [clave, d] of sp.dependencias) {
    contar(grafiaBase, String(d.base).toLowerCase(), d.base);
    contar(grafiaEsquema, `${d.base}.${d.esquema}`.toLowerCase(), d.esquema);
    contar(grafiaNombre, clave, d.nombre);
  }
  const canonico = (clave, d) => {
    const real = estructura.tablas.get(clave);
    const base = real?.base ?? masFrecuente(grafiaBase.get(String(d.base).toLowerCase()));
    const esquema = real?.esquema ?? masFrecuente(grafiaEsquema.get(`${d.base}.${d.esquema}`.toLowerCase()));
    const nombre = real?.nombre ?? masFrecuente(grafiaNombre.get(clave));
    return { base, esquema, nombre, completo: [base, esquema, nombre].join('.') };
  };

  const tablas = new Map();
  for (const sp of sps.values()) {
    sp.dependencias = sp.dependencias.map(([clave, d]) => Object.assign(d, canonico(clave, d), { clave }))
      .sort((a, b) => a.completo.localeCompare(b.completo));
    for (const d of sp.dependencias) {
      if (!tablas.has(d.clave)) tablas.set(d.clave, { completo: d.completo, base: d.base, esquema: d.esquema, nombre: d.nombre, columnas: new Map(), sps: new Map() });
      const t = tablas.get(d.clave);
      t.sps.set(sp.clave, { sp, usos: d.usos });
      for (const [ck, c] of d.columnas) {
        if (!t.columnas.has(ck)) t.columnas.set(ck, { nombre: c.nombre, fuentes: new Set(), sps: new Set() });
        const tc = t.columnas.get(ck);
        for (const f of c.fuentes) tc.fuentes.add(f);
        tc.sps.add(sp.completo);
      }
    }
  }

  // ── 5. Contra la estructura real (solo en bases con extraccion/fuente/estructura/<base>.csv)
  // Tabla de trabajo: algún SP la crea o la borra (a veces el SELECT INTO va dentro de SQL dinámico y solo se ve el DROP).
  const creadas = new Set([...tablas.values()]
    .filter((t) => [...t.sps.values()].some(({ usos }) => usos.has('crea') || usos.has('elimina-objeto')))
    .map((t) => `${t.base}.${t.nombre}`.toLowerCase()));
  for (const [clave, t] of tablas) {
    const usadaPor = [...t.sps.values()].map(({ sp }) => sp.completo).join(', ');
    t.real = estructura.tablas.get(clave) ?? null;
    t.trabajo = creadas.has(`${t.base}.${t.nombre}`.toLowerCase());
    if (!t.real) {
      if (t.trabajo) hallazgo('tabla-de-trabajo', t.completo, `la crea y borra ${usadaPor}`);
      else if (basesConEstructura.has(String(t.base).toLowerCase())) hallazgo('tabla-inexistente', t.completo, `la usan ${usadaPor}`);
      continue;
    }
    for (const c of t.columnas.values()) {
      c.real = t.real.columnas.get(c.nombre.toLowerCase()) ?? null;
      if (c.real || c.nombre === '*') continue;
      const calificada = [...c.fuentes].some((f) => f === 'exacta' || f === 'motor');
      hallazgo(calificada ? 'columna-inexistente' : 'columna-inferida-inexistente', `${t.completo}.${c.nombre}`, `la usa ${[...c.sps].join(', ')}`);
    }
  }

  // ── 6. Línea base: hallazgos conocidos y aceptados (ver ADR-0006)
  for (const h of hallazgos) h.enLineaBase = lineaBase.has(claveHallazgo(h));
  const orden = { error: 0, aviso: 1, info: 2 };
  const ordenOrigen = Object.keys(ORIGENES);
  hallazgos.sort((a, b) => orden[a.nivel] - orden[b.nivel] || ordenOrigen.indexOf(a.origen) - ordenOrigen.indexOf(b.origen)
    || a.regla.localeCompare(b.regla) || a.objeto.localeCompare(b.objeto));
  const vigentes = new Set(hallazgos.map(claveHallazgo));

  return {
    reportes,
    sps,
    tablas: new Map([...tablas].sort(([, a], [, b]) => a.completo.localeCompare(b.completo))),
    hallazgos,
    lineaBaseVencida: [...lineaBase].filter((k) => !vigentes.has(k)),
    consumo,
    estructura,
  };
}

/** Mejor confianza conocida de una columna, para mostrar. */
export function confianza(fuentes) {
  if (fuentes.has('motor') && fuentes.size > 1) return 'confirmada';
  if (fuentes.has('motor')) return 'motor';
  if (fuentes.has('exacta')) return 'exacta';
  if (fuentes.has('estructura')) return 'estructura';
  return 'inferida';
}
