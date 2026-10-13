-- MOD-0001 · Verificación antes y después de modificar mod_rep.com.GDCGEST_ACTIVAST01
-- Solo lectura: metadatos y ejecuciones del SP de reporte (que solo usa tablas #temporales).

USE mod_rep;
GO

------------------------------------------------------------------------------------------------
-- PASO 1 (ANTES): ¿el SP de producción es el mismo que se usó para preparar el script?
------------------------------------------------------------------------------------------------
-- modificado esperado: 2024-07-04 04:29:22. Si es posterior, NO ejecutar 03-…alter.sql completo.
-- con_tilde > 0  → producción tiene "División"/"Mínima": NO ejecutar 03-…alter.sql completo
--                  (borraría las tildes); aplicar a mano los 2 cambios "MOD-0001" en SSMS.
-- sin_tilde > 0 y con_tilde = 0 → producción está igual que la copia: se puede ejecutar 03-…alter.sql.
SELECT  o.modify_date                                              AS modificado,
        CHARINDEX(N'Gte. Divisi n Comercial', OBJECT_DEFINITION(o.object_id)) AS sin_tilde,
        CHARINDEX(N'Gte. División Comercial', OBJECT_DEFINITION(o.object_id)) AS con_tilde
FROM    sys.objects o
WHERE   o.object_id = OBJECT_ID(N'com.GDCGEST_ACTIVAST01');

-- Los nombres de columna del PIVOT final deben coincidir con estos valores (ver 02-analisis.md):
SELECT DISTINCT HUCAP_FIN FROM storage.com_act.WGATH002 WITH (NOLOCK);

------------------------------------------------------------------------------------------------
-- PASO 2 (ANTES y DESPUÉS): resultado de las dos tablas involucradas
------------------------------------------------------------------------------------------------
-- Evolución de TAPP Mes. Después del cambio: la cabecera (1er resultado) trae TM y DT, y el
-- 2do resultado trae valores en TM y DT para cada fecha; vacíos en la fila "Var Abs (pbs)".
EXEC com.GDCGEST_ACTIVAST01 @tip_cod = '7', @cod_rel = '231', @var = 6, @fec = '20240319', @diario = 1;

-- TAPP Mes por producto (@var=3): debe quedar IGUAL antes y después (control de no regresión).
EXEC com.GDCGEST_ACTIVAST01 @tip_cod = '7', @cod_rel = '231', @var = 3, @fec = '20240319', @diario = 1;

------------------------------------------------------------------------------------------------
-- PASO 3 (DESPUÉS): cuadre de una fecha, recalculando TM y DT desde la tabla base
------------------------------------------------------------------------------------------------
-- Para la última fecha de la evolución, TAPP Mínima y Distancia del total (nivel 7 = toda la empresa)
-- deben coincidir con las columnas TM y DT de la fila de esa fecha en el PASO 2.
DECLARE @ORD int = (SELECT MAX(ORD) FROM storage.com_act.WGATH002 WITH (NOLOCK) WHERE ORD <= 31);
DECLARE @fec date = (SELECT MAX(HFECPRO) FROM storage.com_act.WGATH002 WITH (NOLOCK) WHERE ORD = @ORD AND RFEC <= '20240319');
SELECT  @fec                                                                         AS fecha,
        SUM(CONVERT(float, HMDES) * CONVERT(float, HTMIN) / 100) / NULLIF(SUM(CONVERT(float, HMDES)), 0) AS tapp_minima,
        ROUND((SUM(CONVERT(float, HMDES) * CONVERT(float, HTDES) / 100)
             - SUM(CONVERT(float, HMDES) * CONVERT(float, HTMIN) / 100)) / NULLIF(SUM(CONVERT(float, HMDES)), 0) * 10000, 0) AS distancia_pbs
FROM    storage.com_act.WGATH002 WITH (NOLOCK)
WHERE   ORD = @ORD AND HFECPRO = @fec;
