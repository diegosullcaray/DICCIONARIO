-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:21:55.267000
--exec mod_rep.[com].[RAGROMIX] 7,'231','20250930'       
CREATE PROCEDURE [com].[RAGROMIX]          
@tip_cod int,@cod_rel varchar(20),@fec date             
AS                
BEGIN            
 SET NOCOUNT ON; 
--declare @tip_cod int=21,@cod_rel varchar(250)='1',@fec date='20250930'
--------------------------------------------------------------------------------------------------

declare @headers varchar(max)                      --,"cursor": "pointer","text-decoration": "underline"
select @headers  ='[                       
   { "label":"Descripción","key":"rdesjer","sticky": "true","cellStyle":{"text-align":"left","max-width":"190px","min-width":"190px","width":"190px"}},    
    { "label":"Saldo Capital","key":"HSALCAPMN","format":{ "type": "integer" }, "cellStyle":{"text-align":"right","max-width":"100px","min-width":"100px","width":"100px"}},
	 { "label":"Saldo Vencido","key":"HSALVEMN","format":{ "type": "integer" }, "cellStyle":{"text-align":"right","max-width":"100px","min-width":"100px","width":"100px"}},
  { "label":"N° Clientes","key":"HCCLI","format":{ "type": "integer" },"cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"}},
   { "label":"Extensión","key":"EXTE","format":{ "type": "integer" }, "cellStyle":{"text-align":"right","max-width":"100px","min-width":"100px","width":"100px"}},
	  { "label":"% Saldo Vencido","key":"percet_saldoven","format":{ "type": "percent" }, "cellStyle":{"text-align":"right","max-width":"100px","min-width":"100px","width":"100px"}}
   ] '                          
                 
                
select @headers    

declare @fecAnt date
set @fecAnt =(select top 1 RFEC from storage.ref.RCALEN001 where rfec<@fec and RCIEBT=1 order by 1 desc)


    
-- El CTE sigue igual, calcula TODOS los detalles posibles, incluyendo "SIN ASIGNAR"
;WITH cte_detalles_calculados AS (
    SELECT 
        b.htipcod,
        a.hfecpro,
        b.rcodjer,
        b.rcodjer AS cod_rel,
        ISNULL(b.rdesjer, 'SIN ASIGNAR') AS rdesjer,
        SUM(a.HCAPMON) AS HSALCAPMN,
        SUM(a.HVENMON) AS HSALVEMN,
        COUNT(DISTINCT a.HCTACLI) AS HCCLI,
        SUM(a.HEXTENS) AS EXTE
    FROM storage.com_act.WCMAG001 a
    LEFT JOIN (
        SELECT 
            CASE WHEN @tip_cod = 7  THEN cast('20' as varchar(50))--THEN '21' 
			     WHEN @tip_cod = 21 THEN cast('20' as varchar(50)) 
				 WHEN @tip_cod = 20 THEN cast('19' as varchar(50)) 
				 WHEN @tip_cod = 19 THEN cast('18' as varchar(50)) 
				 WHEN @tip_cod = 18 THEN cast('17' as varchar(50)) 
				 WHEN @tip_cod = 17 THEN cast('2' as varchar(50))  END AS htipcod,
            CASE WHEN @tip_cod = 7 THEN CAST(rcodter AS VARCHAR) --THEN CAST(rcodgru AS VARCHAR) 
				 WHEN @tip_cod = 21 THEN CAST(rcodter AS VARCHAR) 
				 WHEN @tip_cod = 20 THEN CAST(rcodcor AS VARCHAR) 
				 WHEN @tip_cod = 19 THEN CAST(rcoduni AS VARCHAR) 
				 WHEN @tip_cod = 18 THEN CAST(RcodUCO AS VARCHAR) 
				 WHEN @tip_cod = 17 THEN CAST(rcodsec AS VARCHAR) END AS rcodjer,
            CASE WHEN @tip_cod = 7 THEN ISNULL(rdester, 'SIN ASIGNAR') --THEN ISNULL(rdesgru, 'SIN ASIGNAR') 
			     WHEN @tip_cod = 21 THEN ISNULL(rdester, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 20 THEN ISNULL(rdescor, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 19 THEN ISNULL(rdesuni, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 18 THEN ISNULL(RdesUCO, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 17 THEN ISNULL(rdessec, 'SIN ASIGNAR') 
		 END AS rdesjer,
            rcodsec
        FROM storage.ref.wjercor03 
        WHERE rfecpro = @fec AND rindfec = 'actual'
          AND CASE WHEN @tip_cod = 7 THEN '1' 
		           WHEN @tip_cod = 21 THEN CAST(rcodgru AS VARCHAR) 
				   WHEN @tip_cod = 20 THEN CAST(rcodter AS VARCHAR) 
				   WHEN @tip_cod = 19 THEN CAST(rcodcor AS VARCHAR) 
				   WHEN @tip_cod = 18 THEN CAST(rcoduni AS VARCHAR) 
				   WHEN @tip_cod = 17 THEN CAST(RCODUCO AS VARCHAR) END = CASE WHEN @tip_cod = 7 THEN '1' ELSE @cod_rel END
    ) b ON a.haseoper = b.rcodsec
    WHERE a.hfecpro = @fec
    GROUP BY a.hfecpro, b.htipcod, b.rcodjer, ISNULL(b.rdesjer, 'SIN ASIGNAR')
),
cte_b as(

-- Construimos el resultado final...
-- Fila de TOTAL (STYLE = 1)
SELECT 
    1 AS STYLE,
    @tip_cod AS htipcod,
    @fec AS hfecpro,
    @cod_rel AS rcodjer,
    @cod_rel AS cod_rel,
    (SELECT TOP 1 CASE WHEN @tip_cod = 7 THEN ISNULL(RDESFC, 'SIN ASIGNAR') WHEN @tip_cod = 21 THEN ISNULL(RDESGRU, 'SIN ASIGNAR') WHEN @tip_cod = 20 THEN ISNULL(RDESTER, 'SIN ASIGNAR') WHEN @tip_cod = 19 THEN ISNULL(RDESCOR, 'SIN ASIGNAR') WHEN @tip_cod = 18 THEN ISNULL(RDESUNI, 'SIN ASIGNAR') WHEN @tip_cod = 17 THEN ISNULL(RDESUCO, 'SIN ASIGNAR') END FROM storage.ref.wjercor03 WHERE rfecpro = @fec AND rindfec = 'actual' AND CASE WHEN @tip_cod = 7  THEN CAST(RCODFC as varchar) WHEN @tip_cod = 21 THEN cast(rcodgru as varchar) WHEN @tip_cod = 20 THEN cast(rcodter as varchar) WHEN @tip_cod = 19 THEN cast(rcodcor as varchar) WHEN @tip_cod = 18 THEN cast(rcoduni as varchar) WHEN @tip_cod = 17 THEN cast(RcodUCO as varchar) END = @cod_rel) AS rdesjer,
    SUM(HSALCAPMN) AS HSALCAPMN,
    SUM(HSALVEMN) AS HSALVEMN,
    SUM(HCCLI) AS HCCLI,
    SUM(EXTE) AS EXTE,
    CASE WHEN SUM(HSALCAPMN) > 0 THEN SUM(HSALVEMN) / SUM(HSALCAPMN) ELSE 0 END AS percet_saldoven
FROM cte_detalles_calculados
-- ...aplicando el filtro condicional aquí para la suma.
WHERE (@tip_cod = 7 OR rdesjer <> 'SIN ASIGNAR')

UNION ALL

-- Filas de DETALLE (STYLE = 0)
SELECT 
    0 AS STYLE, isnull(htipcod,'999') htipcod, hfecpro, rcodjer, cod_rel, rdesjer, HSALCAPMN, HSALVEMN, HCCLI, EXTE,
    CASE WHEN HSALCAPMN > 0 THEN HSALVEMN / HSALCAPMN ELSE 0 END AS percet_saldoven
FROM cte_detalles_calculados
-- ...y aplicando el mismo filtro aquí para mostrar las filas.
WHERE (@tip_cod = 7 OR rdesjer <> 'SIN ASIGNAR')
)
select * from cte_b
order by 1 desc,4 desc

-------------------

    
-- El CTE sigue igual, calcula TODOS los detalles posibles, incluyendo "SIN ASIGNAR"
;WITH cte_detalles_calculados AS (
    SELECT 
        b.htipcod,
        a.hfecpro,
        b.rcodjer,
        b.rcodjer AS cod_rel,
        ISNULL(b.rdesjer, 'SIN ASIGNAR') AS rdesjer,
        SUM(a.HCAPMON) AS HSALCAPMN,
        SUM(a.HVENMON) AS HSALVEMN,
        COUNT(DISTINCT a.HCTACLI) AS HCCLI,
        SUM(a.HEXTENS) AS EXTE
    FROM storage.com_act.WCMAG001 a
    LEFT JOIN (
        SELECT 
            CASE WHEN @tip_cod = 7  THEN '20'--THEN '21' 
			     WHEN @tip_cod = 21 THEN '20' 
				 WHEN @tip_cod = 20 THEN '19' 
				 WHEN @tip_cod = 19 THEN '18' 
				 WHEN @tip_cod = 18 THEN '17' 
				 WHEN @tip_cod = 17 THEN '2' END AS htipcod,
            CASE WHEN @tip_cod = 7 THEN CAST(rcodter AS VARCHAR) --THEN CAST(rcodgru AS VARCHAR) 
				 WHEN @tip_cod = 21 THEN CAST(rcodter AS VARCHAR) 
				 WHEN @tip_cod = 20 THEN CAST(rcodcor AS VARCHAR) 
				 WHEN @tip_cod = 19 THEN CAST(rcoduni AS VARCHAR) 
				 WHEN @tip_cod = 18 THEN CAST(RcodUCO AS VARCHAR) 
				 WHEN @tip_cod = 17 THEN CAST(rcodsec AS VARCHAR) END AS rcodjer,
            CASE WHEN @tip_cod = 7 THEN ISNULL(rdester, 'SIN ASIGNAR') --THEN ISNULL(rdesgru, 'SIN ASIGNAR') 
			     WHEN @tip_cod = 21 THEN ISNULL(rdester, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 20 THEN ISNULL(rdescor, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 19 THEN ISNULL(rdesuni, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 18 THEN ISNULL(RdesUCO, 'SIN ASIGNAR') 
				 WHEN @tip_cod = 17 THEN ISNULL(rdessec, 'SIN ASIGNAR') 
		 END AS rdesjer,
            rcodsec
        FROM storage.ref.wjercor03 
        WHERE rfecpro = @fecAnt AND rindfec = 'actual'
          AND CASE WHEN @tip_cod = 7 THEN '1' 
		           WHEN @tip_cod = 21 THEN CAST(rcodgru AS VARCHAR) 
				   WHEN @tip_cod = 20 THEN CAST(rcodter AS VARCHAR) 
				   WHEN @tip_cod = 19 THEN CAST(rcodcor AS VARCHAR) 
				   WHEN @tip_cod = 18 THEN CAST(rcoduni AS VARCHAR) 
				   WHEN @tip_cod = 17 THEN CAST(RCODUCO AS VARCHAR) END = CASE WHEN @tip_cod = 7 THEN '1' ELSE @cod_rel END
    ) b ON a.haseoper = b.rcodsec
    WHERE a.hfecpro = @fecAnt
    GROUP BY a.hfecpro, b.htipcod, b.rcodjer, ISNULL(b.rdesjer, 'SIN ASIGNAR')
),
cte_b as(

-- Construimos el resultado final...
-- Fila de TOTAL (STYLE = 1)
SELECT 
    1 AS STYLE,
    @tip_cod AS htipcod,
    @fec AS hfecpro,
    @cod_rel AS rcodjer,
    @cod_rel AS cod_rel,
    (SELECT TOP 1 CASE WHEN @tip_cod = 7 THEN ISNULL(RDESFC, 'SIN ASIGNAR') WHEN @tip_cod = 21 THEN ISNULL(RDESGRU, 'SIN ASIGNAR') WHEN @tip_cod = 20 THEN ISNULL(RDESTER, 'SIN ASIGNAR') WHEN @tip_cod = 19 THEN ISNULL(RDESCOR, 'SIN ASIGNAR') WHEN @tip_cod = 18 THEN ISNULL(RDESUNI, 'SIN ASIGNAR') WHEN @tip_cod = 17 THEN ISNULL(RDESUCO, 'SIN ASIGNAR') END FROM storage.ref.wjercor03 WHERE rfecpro = @fec AND rindfec = 'actual' AND CASE WHEN @tip_cod = 7  THEN CAST(RCODFC as varchar) WHEN @tip_cod = 21 THEN cast(rcodgru as varchar) WHEN @tip_cod = 20 THEN cast(rcodter as varchar) WHEN @tip_cod = 19 THEN cast(rcodcor as varchar) WHEN @tip_cod = 18 THEN cast(rcoduni as varchar) WHEN @tip_cod = 17 THEN cast(RcodUCO as varchar) END = @cod_rel) AS rdesjer,
    SUM(HSALCAPMN) AS HSALCAPMN,
    SUM(HSALVEMN) AS HSALVEMN,
    SUM(HCCLI) AS HCCLI,
    SUM(EXTE) AS EXTE,
    CASE WHEN SUM(HSALCAPMN) > 0 THEN SUM(HSALVEMN) / SUM(HSALCAPMN) ELSE 0 END AS percet_saldoven
FROM cte_detalles_calculados
-- ...aplicando el filtro condicional aquí para la suma.
WHERE (@tip_cod = 7 OR rdesjer <> 'SIN ASIGNAR')
)
select * from cte_b

end
