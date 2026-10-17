-- MOD-0003 · Verificación (solo lectura)
USE mod_rep;
GO
-- 1. Antes de crear: cortes que resuelve la función (esperado 2026-10-14 y 2026-09-30) y datos cargados.
SELECT RORD, RFEC FROM storage.util.FVECFEC01('20261014', 'hoy,cie_ant');
SELECT HFECPRO, HTIPCOD, COUNT(*) AS entidades
FROM storage.com_act.HTABSEG001 WITH (NOLOCK)
WHERE HFECPRO IN ('20261014', '20260930')
GROUP BY HFECPRO, HTIPCOD ORDER BY HFECPRO, HTIPCOD;

-- 2. Después de crear: una entidad por nivel (1 fila y 159 columnas cada una).
EXEC mod_rep.com.RTABSEG01 7, '231', '20261014';
-- EXEC mod_rep.com.RTABSEG01 18, '<unidad real>', '20261014';
-- EXEC mod_rep.com.RTABSEG01 1,  '<asesor real>', '20261014';

-- 3. Errores esperados: 51402 (nivel), 51400 (corte sin cargar), 51401 (entidad inexistente).
-- EXEC mod_rep.com.RTABSEG01 99, 'X', '20261014';
-- EXEC mod_rep.com.RTABSEG01 7, '231', '20260801';
-- EXEC mod_rep.com.RTABSEG01 1, 'NOEXISTE', '20261014';

-- 4. Cuadre: la financiera debe igualar la suma de sus unidades (saldo vigente).
SELECT
    (SELECT HSALCIEVIG FROM storage.com_act.HTABSEG001 WITH (NOLOCK) WHERE HFECPRO = '20261014' AND HTIPCOD = 7) AS financiera,
    (SELECT SUM(HSALCIEVIG) FROM storage.com_act.HTABSEG001 WITH (NOLOCK) WHERE HFECPRO = '20261014' AND HTIPCOD = 18) AS suma_unidades;
GO
