-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-08 12:29:39.107000
--exec mod_rep.com.RFECREPMEN    
CREATE PROCEDURE [com].[RFECREPMEN]             
@fec date=null    
AS                  
BEGIN              
 SET NOCOUNT ON;                
 SET LANGUAGE SPANISH    
     
select 'json' json    
    
/*  
;WITH cte_a AS (       SELECT TOP 5 rfec FROM storage.ref.RCALEN001      WHERE rfec <=  getdate() AND RCIEBT = 1       ORDER BY 1 DESC ), cte_b AS (     SELECT TOP 5           FORMAT(RFEC, 'MMMM yyyy', 'es-ES') AS label,         RFEC,         ROW_NUMBER()
  
 OVER(ORDER BY rfec desc) AS val         FROM cte_a   ) SELECT      '[' + STRING_AGG(         '{ "val": "' + CAST(RFEC AS VARCHAR(10)) +          '", "label": "' + label + '" }',          ', '     ) WITHIN GROUP (ORDER BY val ASC) + ']' AS json_result FRO
M cte_b;    
          
    
;WITH cte_a AS (       SELECT TOP 5 rfec FROM storage.ref.RCALEN001      WHERE rfec <=  getdate() AND RCIEBT = 1       ORDER BY 1 DESC ), cte_b AS (     SELECT TOP 5           FORMAT(RFEC, 'MMMM yyyy', 'es-ES') AS label,         RFEC,         ROW_NUMBER()
  
 OVER(ORDER BY rfec desc) AS val         FROM cte_a   ) SELECT      '[' + STRING_AGG(         '{ "val": "' + CAST(RFEC AS VARCHAR(10)) +          '", "label": "' + label + '" }',          ', '     ) WITHIN GROUP (ORDER BY val ASC) + ']' AS json_result FRO
M cte_b;    
*/  
  
;WITH cte_a AS (        
    -- Subconsulta 1: El 'label' será solo la fecha (Ej: 2026-06-24)        
    SELECT RFEC,        
           CAST(RFEC AS VARCHAR(10)) AS label ,1 ordd       
    FROM (        
        SELECT TOP 1 RFEC         
        FROM storage.ref.RCALEN001         
        WHERE RFEC < cast(GETDATE() as date) AND RDIAFER  = 0         
        ORDER BY RFEC DESC        
    ) AS T1        
        
 --select * from storage.ref.RCALEN001 where RFEC='20260629'    
    UNION ALL        
        
    -- Subconsulta 2: El 'label' será el mes y el año (Ej: mayo 2026)        
    SELECT rfec,        
           FORMAT(rfec, 'MMMM yyyy', 'es-ES') AS label ,ordd       
    FROM (        
        SELECT TOP 4 rfec  ,ROW_NUMBER() over(order by rfec desc) +1 ordd      
        FROM storage.ref.RCALEN001         
        WHERE rfec < CAST(GETDATE() AS DATE) AND RCIEBT = 1         
        ORDER BY rfec DESC        
    ) AS T2         
)        
, cte_b AS (             
    -- Aquí ya no formateamos, simplemente tomamos el 'label' que viene de cte_a        
    SELECT RFEC,        
           label,        
           ordd val           
    FROM cte_a           
)             
-- Generación del JSON final        
SELECT '[' + STRING_AGG( '{ "val": "' + CAST(RFEC AS VARCHAR(10)) + '", "label": "' + label + '" }', ', ')         
       WITHIN GROUP (ORDER BY val ASC) + ']' AS json_result         
FROM cte_b;          
          
;WITH cte_a AS (        
    -- Subconsulta 1: El 'label' será solo la fecha (Ej: 2026-06-24)        
    SELECT RFEC,        
           CAST(RFEC AS VARCHAR(10)) AS label ,1 ordd       
    FROM (        
        SELECT TOP 1 RFEC         
        FROM storage.ref.RCALEN001         
        WHERE RFEC < cast(GETDATE() as date) AND RDIAFER = 0         
        ORDER BY RFEC DESC        
    ) AS T1        
        
    UNION ALL        
        
    -- Subconsulta 2: El 'label' será el mes y el año (Ej: mayo 2026)        
    SELECT rfec,        
           FORMAT(rfec, 'MMMM yyyy', 'es-ES') AS label ,ordd       
    FROM (        
        SELECT TOP 4 rfec  ,ROW_NUMBER() over(order by rfec desc) +1 ordd      
        FROM storage.ref.RCALEN001         
        WHERE rfec < CAST(GETDATE() AS DATE) AND RCIEBT = 1         
        ORDER BY rfec DESC        
    ) AS T2         
)        
, cte_b AS (             
    -- Aquí ya no formateamos, simplemente tomamos el 'label' que viene de cte_a        
    SELECT RFEC,        
           label,        
           ordd val           
    FROM cte_a           
)            
-- Generación del JSON final        
SELECT '[' + STRING_AGG( '{ "val": "' + CAST(RFEC AS VARCHAR(10)) + '", "label": "' + label + '" }', ', ')         
       WITHIN GROUP (ORDER BY val ASC) + ']' AS json_result         
FROM cte_b;        
        
END
