-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:04.703000
 --EXEC   mod_rep.com.RRANKM02 7,'231','20241111' 
 CREATE procedure com.RRANKM02
 @tip_cod INT,@cod_rel VARCHAR(250),@fec DATE
 AS
 BEGIN
  set nocount on;  

  
 declare @head as nvarchar(max)  
 set @head = '[{ "label":"Territorio","key":"rdester","cellStyle":{"min-width":"250px"}},   
			   { "label":"Corredor","key":"rdescor","cellStyle":{"min-width":"250px"}},  
			   { "label":"Unidad","key":"rdesuni","cellStyle":{"min-width":"250px"}},  
			   { "label":"% Clientas Mujeres Nuevos","key":"PERCENT_M","cellStyle":{"min-width":"250px"},"format":{"type":"percent"}},   
			   { "label":"N° Clientas Mujeres Nuevos","key":"HNUMCLIMUJ","cellStyle":{"min-width":"250px"},"type":"number"},   
			   { "label":"Total Clientes Nuevos","key":"HNUMCLITOTAL","cellStyle":{"min-width":"250px"} ,"type":"number"}   
			  ]'  

select @head

--declare @tip_cod int=7, @cod_rel varchar(250)='231' , @fec date='20241111'

;with cte_a as (
select hfecpro,haseoper,count(distinct concat_ws('-',hpais,hnumdoc,htipdoc)) HNUMCLITOTAL,
count(distinct case when HGENPER='F' then   concat_ws('-',hpais,hnumdoc,htipdoc) else null end) HNUMCLIMUJ
from storage.com_act.hcda001 where hfecpro=@FEC
group by hfecpro,haseoper
),
cte_b as (
select isnull(b.rdester,'SIN ASIGNAR') rdester,ISNULL(b.rdescor,'SIN ASIGNAR') rdescor,ISNULL(b.rdesuni,'SIN ASIGNAR')rdesuni,
SUM(HNUMCLITOTAL) HNUMCLITOTAL , SUM(HNUMCLIMUJ)HNUMCLIMUJ  , CAST(SUM(HNUMCLIMUJ) AS FLOAT)/ SUM(HNUMCLITOTAL) PERCENT_M   from cte_a a
left join (
		select * 
			 from storage.ref.wjercor03 
			 where rfecpro=@FEC and rindfec='actual'
			 and case when @tip_cod=7 then '1'            
                      when @tip_cod=21 then cast(RCODGRU as varchar(250))            
					  when @tip_cod=20 then cast(RCODTER as varchar(250))            
					  when @tip_cod=19 then cast(RCODCOR as varchar(250))            
					  when @tip_cod=18 then cast(RCODUNI as varchar(250)) 
				      when @tip_cod=17 then cast(RCODUCO as varchar(250)) end = case when @tip_cod=7 then '1' else @cod_rel end      
	
)b
on a.haseoper=b.rcodsec
GROUP BY b.rdester,b.rdescor,b.rdesuni
)
select * from cte_b order by  PERCENT_M desc

end
