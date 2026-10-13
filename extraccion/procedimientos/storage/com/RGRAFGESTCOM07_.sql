-- Extraído de mish/storage el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-10 01:01:07.280000
--exec storage.[com].[RGRAFGESTCOM07_] 7,'231','20260801'
CREATE PROCEDURE [com].[RGRAFGESTCOM07_]    
@tip_cod int, @cod_rel varchar(20), @Fecha varchar(10)   
AS  
BEGIN  
    SET NOCOUNT ON; 

    -- 1. Ajuste de parámetros iniciales
    SET @tip_cod = CASE WHEN @tip_cod = '7' THEN '21' ELSE @tip_cod END
    SET @cod_rel = CASE WHEN @cod_rel = '231' THEN '1' ELSE @cod_rel END

    -- 2. Obtener la jerarquía dinámica y guardarla en una tabla temporal (#Jerarquia)
    SELECT DISTINCT 
        @tip_cod AS tip_cod, 
        @cod_rel AS cod_rel,
        CASE    
            WHEN @tip_cod = 7 THEN 21   
            WHEN @tip_cod = 21 THEN 20  
            WHEN @tip_cod = 20 THEN 19  
            WHEN @tip_cod = 19 THEN 18   
            WHEN @tip_cod = 18 THEN 17 
            WHEN @tip_cod = 17 THEN 17 
        END AS HTIPCOD,  
        CASE    
            WHEN @tip_cod = 7 THEN  cast(RCODGRU as varchar(50))   
            WHEN @tip_cod = 21 THEN cast(RCODTER as varchar(50))   
            WHEN @tip_cod = 20 THEN cast(RCODCOR as varchar(50))   
            WHEN @tip_cod = 19 THEN cast(RCODUNI as varchar(50))   
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar(50))
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar(50)) 
        END AS HCODREL,  
        CASE    
            WHEN @tip_cod = 7 THEN  cast(RDESGRU as varchar(50))   
            WHEN @tip_cod = 21 THEN cast(RDESTER as varchar(50))   
            WHEN @tip_cod = 20 THEN cast(RDESCOR as varchar(50))   
            WHEN @tip_cod = 19 THEN cast(RDESUNI as varchar(50))   
            WHEN @tip_cod = 18 THEN cast(RDESUNI as varchar(50)) 
            WHEN @tip_cod = 17 THEN cast(RDESUCO as varchar(50)) 
        END AS HDESREL  
    INTO #Jerarquia
    FROM storage.ref.WJERCOR03 
    WHERE RFECPRO = @Fecha AND RINDFEC = 'ACTUAL'
      AND CASE 
            WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
            WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
            WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
            WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
          END = @cod_rel;

    -- 3. Cruzar la jerarquía con la tabla de datos
    SELECT 
        j.HTIPCOD,
        j.HCODREL,
        j.HDESREL AS Territorio,
        ISNULL(SUM(d.hnumcli), 0) AS cliStock
    INTO #DataFinal
    FROM #Jerarquia j
    -- Cambia storage.com_act.WJAS001 por tu tabla real de donde sacas 'hnumcli'
    LEFT JOIN storage.com_act.WJAS001 d 
        ON d.htipcod = j.HTIPCOD 
       AND d.hcodrel = j.HCODREL
       AND d.hfecpro = @Fecha
    GROUP BY 
        j.HTIPCOD,
        j.HCODREL,
        j.HDESREL;

    -- 4. Construir las variables JSON
    DECLARE @categories NVARCHAR(MAX);
    DECLARE @dataCliStock NVARCHAR(MAX);

    -- Genera: ["SUR 1", "LIMA", ...]
    SELECT @categories = '[' + STRING_AGG('"' + Territorio + '"', ',') WITHIN GROUP (ORDER BY Territorio) + ']'
    FROM #DataFinal;

    -- Genera: [{"y": 150, "HTIPCOD": 20, "HCODREL": "1_10", "HDESREL": "SUR 1"}, ...]
    SELECT @dataCliStock = '[' + STRING_AGG(
        '{"y":' + CAST(cliStock AS VARCHAR(50)) + 
        ',"HTIPCOD":' + CAST(HTIPCOD AS VARCHAR(10)) + 
        ',"HCODREL":"' + CAST(HCODREL AS VARCHAR(50)) + '"' +
        ',"HDESREL":"' + Territorio + '"}', 
        ','
    ) WITHIN GROUP (ORDER BY Territorio) + ']'
    FROM #DataFinal;

    -- 5. Retornar el JSON estructurado para Angular
    SELECT 
        JSON_QUERY(ISNULL(@categories, '[]')) AS categories,
        JSON_QUERY('[
            {"name": "Clientes Stock", "data": ' + ISNULL(@dataCliStock, '[]') + '}
        ]') AS series
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
    
    -- 6. Limpiar
    DROP TABLE #Jerarquia;
    DROP TABLE #DataFinal;
END
