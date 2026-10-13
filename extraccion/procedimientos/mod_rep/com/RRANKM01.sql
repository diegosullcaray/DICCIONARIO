-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-06-12 15:52:49.957000
 --EXEC   mod_rep.com.RRANKM01 7,'231','20241111' 
 CREATE procedure [com].[RRANKM01]
 @tip_cod INT,@cod_rel VARCHAR(250),@fec DATE
 AS
 BEGIN
  set nocount on;  
 --declare @tip_cod int=7, @cod_rel varchar(250)='231' , @fec date='20241111'
 ------------------------------------------------------------------------------------

 declare @head as nvarchar(max)  
 set @head = '[{ "label":"Territorio","key":"rdester","cellStyle":{"min-width":"250px"}},   
			   { "label":"Corredor","key":"rdescor","cellStyle":{"min-width":"250px"}},  
			   { "label":"Unidad","key":"rdesuni","cellStyle":{"min-width":"250px"}},  
			   { "label":"% Clientas Mujeres Nuevos","key":"PERCENT_MUJER","cellStyle":{"min-width":"250px"},"format":{"type":"percent"}},   
			   { "label":"N° Clientas Mujeres Nuevos","key":"HCODPERMUJ","cellStyle":{"min-width":"250px"},"type":"number"},   
			   { "label":"Total Clientes Nuevos","key":"HCODPERTOT","cellStyle":{"min-width":"250px"} ,"type":"number"}   
			  ]'  

select @head

;with cte_a as (
select hfecpro,hcodsec, 
count(DISTINCT CASE  WHEN HINDGEN=1 THEN HCODPER else null end) HCODPERMUJ , 
       count(distinct HCODPER) HCODPERTOT
from storage.com_act.WACLI007
WHERE HFECPRO IN (@fec)
GROUP BY  hfecpro,hcodsec
),
cte_b as (
select isnull(b.rdester,'SIN ASIGNAR') rdester,ISNULL(b.rdescor,'SIN ASIGNAR') rdescor,ISNULL(b.rdesuni,'SIN ASIGNAR')rdesuni,
       SUM(HCODPERMUJ) HCODPERMUJ, SUM(HCODPERTOT) HCODPERTOT , CAST(SUM(HCODPERMUJ) AS FLOAT) / SUM(HCODPERTOT) 'PERCENT_MUJER' 
from cte_a a 
left join (
			 select * 
			 from storage.ref.wjercor03 
			 where rfecpro=@fec and rindfec='actual'
			 and case when @tip_cod=7 then '1'            
                      when @tip_cod=21 then cast(RCODGRU as varchar(250))            
					  when @tip_cod=20 then cast(RCODTER as varchar(250))            
					  when @tip_cod=19 then cast(RCODCOR as varchar(250))            
					  when @tip_cod=18 then cast(RCODUNI as varchar(250)) 
				      when @tip_cod=17 then cast(RCODUCO as varchar(250)) end = case when @tip_cod=7 then '1' else @cod_rel end      
	      )b
on a.hfecpro=b.rfecpro and a.hcodsec=b.rcodsec
GROUP BY b.rdester,b.rdescor,b.rdesuni
)
select * from cte_b order by percent_mujer desc

END
