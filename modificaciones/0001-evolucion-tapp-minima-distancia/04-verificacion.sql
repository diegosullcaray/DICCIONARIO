-- MOD-0001 · Verificación de mod_rep.com.GDCGEST_ACTIVAST01_NEW contra el original
--
-- Solo lectura: metadatos, ejecuciones de los SP de reporte (que solo usan tablas #temporales) y un SELECT.
-- Se puede ejecutar completo en cualquier momento: cada paso es un lote aparte (GO) y los que necesitan el
-- SP nuevo se saltean con un aviso si todavía no existe. El original no se toca en ningún paso.
--
-- Parámetros de prueba: cambiarlos acá abajo, en cada paso, si se quiere probar otra fecha o nivel.
--   @tip_cod '7' = toda la empresa (cod_rel se ignora) · @fec = fecha de corte · @diario 1 = como lo pide el front

USE mod_rep;
GO

------------------------------------------------------------------------------------------------
-- PASO 1 (ANTES de crear el nuevo): ¿la copia usada para el _NEW sigue siendo la de producción?
------------------------------------------------------------------------------------------------
-- modificado esperado: 2024-07-04 04:29:22. Si es posterior, el original cambió: volver a extraerlo y rehacer
--   03-…_NEW.create.sql desde esa versión.
-- con_tilde > 0: el original tiene "División"/"Mínima" y la copia los perdió. Corregir esos textos en
--   03-…_NEW.create.sql antes de crearlo; si no, la columna "Gte. División Comercial" del nuevo sale en cero.
SELECT  o.modify_date                                                         AS modificado,
        CHARINDEX(N'Gte. Divisi n Comercial', OBJECT_DEFINITION(o.object_id)) AS sin_tilde,
        CHARINDEX(N'Gte. División Comercial', OBJECT_DEFINITION(o.object_id)) AS con_tilde,
        CASE WHEN o.modify_date > '2024-07-04T04:29:23' THEN 'NO: el original cambió, rehacer el _NEW'
             WHEN CHARINDEX(N'Gte. División Comercial', OBJECT_DEFINITION(o.object_id)) > 0 THEN 'NO: corregir tildes en el _NEW'
             ELSE 'OK: se puede crear el _NEW tal cual' END                    AS veredicto
FROM    sys.objects o
WHERE   o.object_id = OBJECT_ID(N'com.GDCGEST_ACTIVAST01');

-- Los valores reales de nivel de autonomía: deben coincidir con los nombres de columna del PIVOT del SP
-- ([Administrador], [Gerente Corredor / R. Negocio Grupal], [Gerente Territorial], [Gte. Divisi n Comercial]).
SELECT DISTINCT HUCAP_FIN FROM storage.com_act.WGATH002 WITH (NOLOCK) ORDER BY HUCAP_FIN;
GO

------------------------------------------------------------------------------------------------
-- PASO 2 (DESPUÉS de crear el nuevo): original y nuevo, lado a lado
------------------------------------------------------------------------------------------------
-- Cada EXEC devuelve 2 resultados: la cabecera JSON y los datos.
--   @var = 6: el nuevo debe traer lo mismo que el original MÁS las columnas TM ("TAPP Mínima") y
--             DT ("Distancia (en pbs)"), con valor en cada fecha y vacías en la fila "Var Abs (pbs)".
--   @var = 1…5: original y nuevo deben ser IDÉNTICOS (control de no regresión). Si algún nivel de
--             autonomía sale en cero solo en el nuevo, es el problema de tildes del paso 1.
IF OBJECT_ID(N'com.GDCGEST_ACTIVAST01_NEW', N'P') IS NULL
BEGIN
    PRINT 'PASO 2 omitido: todavía no existe com.GDCGEST_ACTIVAST01_NEW (ejecutar 03-…_NEW.create.sql).';
    RETURN;
END;

DECLARE @tip_cod varchar(10) = '7', @cod_rel varchar(10) = '231', @fec date = '20240319', @diario int = 1;

PRINT '--- @var = 6 · Evolución de TAPP Mes: original, luego nuevo';
EXEC com.GDCGEST_ACTIVAST01     @tip_cod, @cod_rel, 6, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod, @cod_rel, 6, @fec, @diario;

PRINT '--- @var = 1…5 · deben ser idénticos: original, luego nuevo';
EXEC com.GDCGEST_ACTIVAST01     @tip_cod, @cod_rel, 1, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod, @cod_rel, 1, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01     @tip_cod, @cod_rel, 2, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod, @cod_rel, 2, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01     @tip_cod, @cod_rel, 3, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod, @cod_rel, 3, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01     @tip_cod, @cod_rel, 4, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod, @cod_rel, 4, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01     @tip_cod, @cod_rel, 5, @fec, @diario;
EXEC com.GDCGEST_ACTIVAST01_NEW @tip_cod, @cod_rel, 5, @fec, @diario;

-- Opcional: un nivel más bajo, para no probar solo el total (completar el código de la unidad):
-- EXEC com.GDCGEST_ACTIVAST01     '18', '<cod_unidad>', 6, @fec, @diario;
-- EXEC com.GDCGEST_ACTIVAST01_NEW '18', '<cod_unidad>', 6, @fec, @diario;
GO

------------------------------------------------------------------------------------------------
-- PASO 3: cuadre de TM y DT, recalculados desde la tabla base con la misma lógica del SP
------------------------------------------------------------------------------------------------
-- Una fila por fecha de la evolución (total empresa, tip_cod 7). Deben coincidir con las columnas TM y DT
-- de esas fechas en el resultado del nuevo con @var = 6 (paso 2). TM sale en el SP con formato %, acá en
-- número: 0.3690 = 36.90 %.
-- Replica el SP: mismo @ORD, mismos JOIN a RETP001/002/003 (un JOIN que duplique filas cambia el promedio),
-- ponderado por monto desembolsado.
DECLARE @fec date = '20240319', @diario int = 1;
DECLARE @ORD int = (SELECT MAX(ORD) FROM storage.com_act.WGATH002 WITH (NOLOCK)
                    WHERE ORD <= CASE WHEN @diario = 0 THEN 100 ELSE 31 END);
DECLARE @fec_corte date = (SELECT MAX(HFECPRO) FROM storage.com_act.WGATH002 WITH (NOLOCK)
                           WHERE ORD = @ORD AND RFEC <= @fec);

SELECT  A.HFECPRO                                                                              AS fecha,
        SUM(CONVERT(float, A.HMDES) * CONVERT(float, A.HTMIN) / 100)
            / NULLIF(SUM(CONVERT(float, A.HMDES)), 0)                                          AS tapp_minima_TM,
        ROUND(( SUM(CONVERT(float, A.HMDES) * CONVERT(float, A.HTDES) / 100)
              - SUM(CONVERT(float, A.HMDES) * CONVERT(float, A.HTMIN) / 100) )
            / NULLIF(SUM(CONVERT(float, A.HMDES)), 0) * 10000, 0)                              AS distancia_pbs_DT,
        COUNT(*)                                                                               AS operaciones
FROM    storage.com_act.WGATH002 A WITH (NOLOCK)
        LEFT JOIN storage.com_act.RETP001 C WITH (NOLOCK) ON A.HMOD = C.RCODMOD AND A.HTOPE = C.RTIPOPE
        LEFT JOIN storage.com_act.RETP002 D WITH (NOLOCK) ON A.HMOD = D.RCODMOD AND A.HTOPE = D.RTIPOPE AND A.HSUBTIP = D.RSUBTIP
        LEFT JOIN storage.com_act.RETP003 E WITH (NOLOCK) ON ISNULL(D.RCODPROD, C.RCODPROD) = E.RCODPROD
WHERE   A.ORD = @ORD AND A.HFECPRO <= @fec_corte
GROUP BY A.HFECPRO
ORDER BY A.HFECPRO;

-- Control de los JOIN: si "filas_con_join" > "filas_base", algún JOIN duplica operaciones y el SP (original
-- y nuevo por igual) las cuenta dos veces. No lo introduce esta modificación, pero conviene saberlo.
SELECT  (SELECT COUNT(*) FROM storage.com_act.WGATH002 WITH (NOLOCK) WHERE ORD = @ORD AND HFECPRO <= @fec_corte) AS filas_base,
        (SELECT COUNT(*)
         FROM   storage.com_act.WGATH002 A WITH (NOLOCK)
                LEFT JOIN storage.com_act.RETP001 C WITH (NOLOCK) ON A.HMOD = C.RCODMOD AND A.HTOPE = C.RTIPOPE
                LEFT JOIN storage.com_act.RETP002 D WITH (NOLOCK) ON A.HMOD = D.RCODMOD AND A.HTOPE = D.RTIPOPE AND A.HSUBTIP = D.RSUBTIP
                LEFT JOIN storage.com_act.RETP003 E WITH (NOLOCK) ON ISNULL(D.RCODPROD, C.RCODPROD) = E.RCODPROD
         WHERE  A.ORD = @ORD AND A.HFECPRO <= @fec_corte)                                                      AS filas_con_join;
GO
