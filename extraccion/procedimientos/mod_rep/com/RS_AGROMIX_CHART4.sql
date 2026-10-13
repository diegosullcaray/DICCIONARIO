-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:40.283000
--exec com.RS_AGROMIX_CHART4  7,'231','20250930'
CREATE PROCEDURE [com].[RS_AGROMIX_CHART4] 
    @tip_cod INT,
    @cod_rel VARCHAR(250),
    @fec DATE
AS
BEGIN
    SET NOCOUNT ON;
	declare @f varchar(max)
	select rfec into #f_ from   storage.util.FVECFEC01(@fec,'cmg_1,cmg_3,cmg_6') -- storage.util.FVECFEC01(@fec,'hoy,cie_ant,cie_ant+2,cie_ant+3,cie_ant+4,cie_ant+5,cie_ant+6,cie_ant+7,cie_ant+8,cie_ant+9,cie_ant+10,cie_ant+11') --(@fec,'cmg_1,cmg_3,cmg_6')	
	set @f=(select string_agg(format(rfec,'yyyyMMdd'),',') from #f_)
    -- ====================================================================
    -- PASO 1: CREAR LA TABLA #HBase (Tu código original, sin cambios)
    -- ====================================================================
    SELECT DISTINCT 
        rfecpro, 
        ISNULL(rcodsec, '0') rcodsec 
    INTO #Asesor
    FROM storage.ref.fjercor02(@f)
    WHERE 
        CASE 
            WHEN @tip_cod = 7 THEN CAST('1' AS VARCHAR)
            WHEN @tip_cod = 21 THEN CAST(rcodgru AS VARCHAR)
            WHEN @tip_cod = 20 THEN CAST(rcodter AS VARCHAR)
            WHEN @tip_cod = 19 THEN CAST(rcodcor AS VARCHAR)
            WHEN @tip_cod = 18 THEN CAST(rcoduni AS VARCHAR)
            WHEN @tip_cod = 17 THEN CAST(RCODUCO AS VARCHAR) 
			 when @tip_cod=2 then cast(RCODSEC as varchar)
        END = CASE WHEN @tip_cod = 7 THEN '1' ELSE @cod_rel END;

	;with cte_a as (
	select * from storage.com_act.WCMAG001
	where hfecpro in(select rfec from #f_)
	)
    SELECT 
        a.HFECPRO, 
        a.HCAPMON, 
        a.HVENMON, 
        a.HCTACLI, 
        a.HDESCUL,
        A.HCODOPE,
        CASE WHEN a.HASEOPER IN ('', '--') THEN '0' ELSE a.HASEOPER END AS HASEOPER,
        b.rcodsec
    INTO #HBase
    FROM cte_a a
    LEFT JOIN #Asesor b ON a.hfecpro = b.rfecpro 
        AND CASE WHEN a.HASEOPER IN ('', '--') THEN '0' ELSE a.HASEOPER END = b.rcodsec
    WHERE @tip_cod = 7 OR b.rfecpro IS NOT NULL;

    -- ====================================================================
    -- PASO 2: REALIZAR LAS CONSULTAS FINALES
    -- ====================================================================

    ;WITH ConsultaResumen AS (
        SELECT 
            a.hfecpro,
            SUM(a.HCAPMON) AS HCAPMON,
            SUM(a.HVENMON) AS HVENMON,
            -- Evitar división por cero
            CASE 
                WHEN SUM(a.HCAPMON) = 0 THEN 0 
                ELSE (SUM(a.HVENMON) / SUM(a.HCAPMON))  * 100
            END AS PERVENC 
        FROM #HBase a
        GROUP BY a.hfecpro 
    )
    -- Finalmente, construimos el objeto JSON
    SELECT
        -- 1. Creamos el array de 'categories' usando las fechas
        JSON_QUERY(
            '[' + 
            -- CORRECCIÓN 1: Convertimos la fecha a texto (formato YYYY-MM-DD) antes de concatenar.
            -- CORRECCIÓN 2: Ordenamos por la columna 'hfecpro' que sí existe.
            STRING_AGG(CONVERT(NVARCHAR(MAX), '"' + FORMAT(hfecpro, 'yyyy-MM-dd') + '"'), ',') WITHIN GROUP (ORDER BY hfecpro ASC) + 
            ']'
        ) AS categories,

        -- 2. Creamos el array de 'series'
        JSON_QUERY(
            '[{
                "name": "Saldo",
                "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), HCAPMON), ',') WITHIN GROUP (ORDER BY hfecpro ASC) + ']
            },{
                "name": "Saldo Vencido",
                "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), HVENMON), ',') WITHIN GROUP (ORDER BY hfecpro ASC) + ']
            },{
                "name": "%Saldo Vencido",
                "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), PERVENC), ',') WITHIN GROUP (ORDER BY hfecpro ASC) + ']
            }]'
        ) AS series
    FROM ConsultaResumen
    -- FOR JSON PATH: Construye objetos JSON anidados.
    -- WITHOUT_ARRAY_WRAPPER: Devuelve un único objeto JSON en lugar de un array con un objeto.
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;

END
