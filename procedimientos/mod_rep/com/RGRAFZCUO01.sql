-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 17:22:36.613000
--exec mod_rep.[com].[RGRAFZCUO01] 21,'2','20260824'
CREATE PROCEDURE [com].[RGRAFZCUO01]    
@tip_cod int, @cod_rel varchar(20), @Fecha varchar(10)   
AS  
BEGIN  
    SET NOCOUNT ON; 

	--declare @tip_cod varchar(5)=21, @cod_rel varchar(25)='2', @Fecha DATE ='20260817'  
	--select *  from storage.com_act.Rpte_PEDC029_cerocuotas 
	IF OBJECT_ID('tempdb..#DataFinal') IS NOT NULL DROP TABLE #DataFinal
	
	select RDESPROD Producto, ISNULL(SUM (HSALCAPMN), 0)  Saldo
	,CAST( @tip_cod AS VARCHAR(10)) HTIPCOD,CAST(@cod_rel AS VARCHAR(50)) HCODREL
	into #DataFinal
	from storage.com_act.WZCUO001
	where HFECPRO = @Fecha and CASE 
            WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
            WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
            WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
            WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
          END = @cod_rel  
	group by RDESPROD

 
	  
 
    -- 2. Construir las variables JSON
    DECLARE @categories NVARCHAR(MAX);
    DECLARE @dataCliStock NVARCHAR(MAX);

    -- Genera: ["SUR 1", "LIMA", ...]
    SELECT @categories = '[' + STRING_AGG('"' + Producto + '"', ',') WITHIN GROUP (ORDER BY Producto) + ']'
    FROM #DataFinal;

    -- Genera: [{"y": 150, "HTIPCOD": 20, "HCODREL": "1_10", "HDESREL": "SUR 1"}, ...]
    SELECT @dataCliStock = '[' + STRING_AGG(
        '{"y":' + CAST(Saldo AS VARCHAR(50)) + 
        ',"HTIPCOD":' + CAST(HTIPCOD AS VARCHAR(10)) + 
        ',"HCODREL":"' + CAST(HCODREL AS VARCHAR(50)) + '"' +
        ',"HDESREL":"' + Producto + '"}', 
        ','
    ) WITHIN GROUP (ORDER BY Producto) + ']'
    FROM #DataFinal;



    -- 3. Retornar el JSON estructurado para Angular
    SELECT 
        JSON_QUERY(ISNULL(@categories, '[]')) AS categories,
        JSON_QUERY('[
            {"name": "Datos por producto", "data": ' + ISNULL(@dataCliStock, '[]') + '}
        ]') AS series
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
    
    -- 4. Limpiar 
    DROP TABLE #DataFinal;
END
