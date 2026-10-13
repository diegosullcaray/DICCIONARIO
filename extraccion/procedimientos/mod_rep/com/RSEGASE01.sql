-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:13.487000
--exec mod_rep.com.RSEGASE01      'TKQUS101','2025-11-10',1  
CREATE PROCEDURE com.RSEGASE01      
@cod_rel varchar(25),@Fecha date,@tip_cod varchar(5)  
as  
begin  
 SET NOCOUNT ON;    
--declare @cod_rel varchar(25)='TLRUP100', @Fecha date='20251110', @tip_cod varchar(5)=1  
----------------------------  
   
select *    
into #FECS    
from storage.util.FVECFEC01(@Fecha,'cmg_5,cmg_6')  --select * from #FECS    
   
select '[{"label":"Descripción","key":"Seguros","cellStyle":{"text-align":"left","max-width":"60px","min-width":"60px","width":"60px"}},{"label":"Cierre Anterior","key":"1","cellStyle":{"text-align":"left","max-width":"10px","min-width":"10px","width":"10px"},"style":{"min-width":"20px","width":"20px"}},{"label":"Ejecutado","key":"2","cellStyle":{"text-align":"left","max-width":"10px","min-width":"10px","width":"10px"}},{"label":"Variación","key":"vari","cellStyle":{"text-align":"left","max-width":"10px","min-width":"10px","width":"10px"}}]'    
     
        
  
;with cte_a as (  
select CASE WHEN scodseg in(802,824) THEN 'Seguro Protección Cuota'                      
     WHEN SCODSEG in(806,815,825) THEN 'Seguro Agro'   --nuevo: 815                   
     WHEN SCODSEG in(803,817) THEN 'Seguro Multiple Crédito'                      
     WHEN SCODSEG in(200,220,230) THEN 'Seguro Multiple Riesgo'          
     when SCODSEG=814 then 'Seguro Oncologico'           
  when scodseg=822 then 'Seguro Protección Total'      
     END SEG,*                      
from storage.[com_seg].[SDSF001]                      
where sfecpro in(select rfec from #FECS)   and scodsec=@cod_rel          
and scodagr=6           
),  
cte_b as (  
select sfecpro,seg,sum(SNUMPLZ)SNUMPLZ  from cte_a where seg is not null group by sfecpro,seg  
),  
cte_c as (  
select a.*,b.RORD   
from cte_b a  
inner join #FECS b  
on a.sfecpro=b.rfec  
),  
PivotedData AS (  
    SELECT  
        seg,  
        [1],  -- Columna para RORD = 1  
        [2]   -- Columna para RORD = 2  
        -- Si tuvieras más valores (ej. 3, 4), agrégalos aquí: ,[3], [4]  
    FROM  
        cte_c  
    PIVOT (  
        SUM(SNUMPLZ)          -- La función de agregación (qué hacer si hay duplicados)  
        FOR RORD IN ([1], [2]) -- Lista de valores de RORD que se volverán columnas  
    ) AS PivotTable  
)  
SELECT  
    CASE  
        WHEN GROUPING(seg) = 1 THEN 'Total general' -- Etiqueta para la fila total  
        ELSE seg  
    END AS [Seguros],  
  
    SUM([1]) AS [1], -- Suma la columna [1]  
    SUM([2]) AS [2]  -- Suma la columna [2]  
    -- ,SUM([3]) AS [3] -- No olvides agregar los totales para las nuevas columnas  
into #R  
FROM  
    PivotedData  
GROUP BY  
    GROUPING SETS (  
        (seg),  -- Agrupa por cada 'seg'  
        ()      -- Agrega el Gran Total  
    )  
ORDER BY  
    GROUPING(seg), [Seguros]; -- Ordena los totales al final  
--drop table #FECS , #R  
  
create table #RR  
(  
ORD INT IDENTITY(1,1) NOT NULL,  
style int null,
Seguros VARCHAR(250) NULL   
)  
INSERT INTO #RR VALUES(0,'Seguro Protección Cuota')  
INSERT INTO #RR VALUES(0,'Seguro Agro')  
INSERT INTO #RR VALUES(0,'Seguro Multiple Crédito')  
INSERT INTO #RR VALUES(0,'Seguro Multiple Riesgo')  
INSERT INTO #RR VALUES(0,'Seguro Oncologico')  
INSERT INTO #RR VALUES(0,'Seguro Protección Total')  
INSERT INTO #RR VALUES(1,'Total general')  
  
SELECT A.ORD,A.style,A.Seguros,B.[1],B.[2],B.vari   
FROM #RR A  
LEFT JOIN (select  Seguros,[1],[2],[2]-[1] vari from #R )B  
ON A.Seguros=B.Seguros  
ORDER BY ORD ASC  
  
end
