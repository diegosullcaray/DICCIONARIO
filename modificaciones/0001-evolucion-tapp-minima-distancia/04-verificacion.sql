-- MOD-0001 · Verificación de mod_rep.com.GDCGEST_ACTIVAST01_NEW contra el original
-- Solo lectura: metadatos y ejecuciones de los SP de reporte (que solo usan tablas #temporales).
-- El original no se toca en ningún paso.

USE mod_rep;
GO

------------------------------------------------------------------------------------------------
-- PASO 1 (ANTES de crear el nuevo): ¿la copia usada sigue siendo la versión de producción?
------------------------------------------------------------------------------------------------
-- modificado esperado: 2024-07-04 04:29:22. Si es posterior, regenerar 03-…_NEW.create.sql desde la versión
-- actual (volver a extraer el SP y repetir los 2 cambios "MOD-0001").
-- con_tilde > 0 → el original tiene "División"/"Mínima" y la copia los perdió: corregir esos textos en
-- 03-…_NEW.create.sql antes de crearlo (si no, la columna "Gte. División Comercial" del nuevo saldría en cero).
SELECT  o.modify_date                                                         AS modificado,
        CHARINDEX(N'Gte. Divisi n Comercial', OBJECT_DEFINITION(o.object_id)) AS sin_tilde,
        CHARINDEX(N'Gte. División Comercial', OBJECT_DEFINITION(o.object_id)) AS con_tilde
FROM    sys.objects o
WHERE   o.object_id = OBJECT_ID(N'com.GDCGEST_ACTIVAST01');

------------------------------------------------------------------------------------------------
-- PASO 2 (DESPUÉS de crear el nuevo): original y nuevo, lado a lado, con los mismos parámetros
------------------------------------------------------------------------------------------------
-- Evolución de TAPP Mes. Esperado: el nuevo trae las mismas columnas y valores que el original, MÁS
-- "TAPP Mínima" (TM) y "Distancia (en pbs)" (DT); en la fila "Var Abs (pbs)" esas dos van vacías.
EXEC com.GDCGEST_ACTIVAST01     @tip_cod = '7', @cod_rel = '231', @var = 6, @fec = '20240319', @diario = 1;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod = '7', @cod_rel = '231', @var = 6, @fec = '20240319', @diario = 1;

-- El resto de las tablas debe salir IDÉNTICO en ambos (control de no regresión). Repetir con @var = 1..5;
-- si algún nivel de autonomía (Administrador … Gte. División Comercial) sale en cero solo en el nuevo,
-- es el problema de tildes del paso 1.
EXEC com.GDCGEST_ACTIVAST01     @tip_cod = '7', @cod_rel = '231', @var = 3, @fec = '20240319', @diario = 1;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod = '7', @cod_rel = '231', @var = 3, @fec = '20240319', @diario = 1;

-- Un nivel de jerarquía más bajo, para no probar solo el total (tip_cod 2 = sectorista, ajustar cod_rel):
-- EXEC com.GDCGEST_ACTIVAST01     @tip_cod = '2', @cod_rel = '<código>', @var = 6, @fec = '20240319', @diario = 1;
-- EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod = '2', @cod_rel = '<código>', @var = 6, @fec = '20240319', @diario = 1;

------------------------------------------------------------------------------------------------
-- PASO 3: cuadre de TM y DT recalculando desde la tabla base
------------------------------------------------------------------------------------------------
-- Para la última fecha, TAPP Mínima y Distancia del total (tip_cod 7) deben coincidir con TM y DT de esa
-- fila en el resultado del nuevo (paso 2).
DECLARE @ORD int = (SELECT MAX(ORD) FROM storage.com_act.WGATH002 WITH (NOLOCK) WHERE ORD <= 31);
DECLARE @fec date = (SELECT MAX(HFECPRO) FROM storage.com_act.WGATH002 WITH (NOLOCK) WHERE ORD = @ORD AND RFEC <= '20240319');
SELECT  @fec                                                                                             AS fecha,
        SUM(CONVERT(float, HMDES) * CONVERT(float, HTMIN) / 100) / NULLIF(SUM(CONVERT(float, HMDES)), 0) AS tapp_minima,
        ROUND((SUM(CONVERT(float, HMDES) * CONVERT(float, HTDES) / 100)
             - SUM(CONVERT(float, HMDES) * CONVERT(float, HTMIN) / 100)) / NULLIF(SUM(CONVERT(float, HMDES)), 0) * 10000, 0) AS distancia_pbs
FROM    storage.com_act.WGATH002 WITH (NOLOCK)
WHERE   ORD = @ORD AND HFECPRO = @fec;
