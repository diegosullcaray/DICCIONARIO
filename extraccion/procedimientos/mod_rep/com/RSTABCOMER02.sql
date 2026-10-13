-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:36.217000
  
--modificar    
--exec mod_rep.com.RSTABCOMER02 'TECOT100'      
CREATE PROCEDURE com.RSTABCOMER02        
@usuariobt varchar(250),    
@Fecha date    
AS              
BEGIN          
 SET NOCOUNT ON;         
--declare @usuariobt varchar(250)='TECOT100'      
----------------------------------------------------------      
      
     
declare @fec date      
set @fec =( select max(rfec) from storage.ref.rcalen001 where rfec<=@fecha and RDIAFER=0)--(select max(hfecpro) from storage.[com_act].WACLI008    )      
      
select distinct HDESCLI ,CONCAT(HTIPDOC,HNUMDOC)HTIPNUM ,hfecpro      
into #CRED  --drop table #CRED      
from storage.com_act.hcda001       
where hfecpro=@fec and haseoper=@usuariobt      
      
;with cte_a as (        
select distinct hfecpro,HTIPNUMDOC        
from storage.[com_act].WAPPCLI001          
where hfecpro=@FEC       
) ,        
cte_b as (        
select a.*       
from cte_a a        
inner join #CRED b        
on a.hfecpro=b.hfecpro and a.HTIPNUMDOC=b.HTIPNUM        
)        
select * into #Enrolado_Activos from  cte_b  --select * from #Enrolado_Activos        
      
select distinct hfecpro,concat(HTIPDOC,HNUMDOC) HTIPNUM          
into #Usabilidad        
from storage.[com_act].[HTDA001]         
where hfecpro=@fec and HFEC between dateadd(day, 1, eomonth(@fec, -1)) and @FEC        
      
select a.hfecpro,A.HTIPNUM into #Usa_Cartera        
from #Usabilidad a        
inner join #CRED b        
on a.hfecpro=b.hfecpro and a.HTIPNUM=b.HTIPNUM        
      
select 
'[{"label":"Descripción","key":"hdescli","cellStyle":{"text-align":"left","max-width":"100px","min-width":"100px","width":"100px"}},{"label":"Cartera","key":"cartera","cellStyle":{"text-align":"left","max-width":"10px","min-width":"10px","width":"10px"}},{"label":"Enrolado","key":"enrolado","cellStyle":{"text-align":"left","max-width":"10px","min-width":"10px","width":"10px"}},{"label":"Usabilidad","key":"usabilidad","cellStyle":{"text-align":"right","max-width":"10px","min-width":"10px","width":"10px"}}]'       
      
select a.hdescli,      
case when a.hdescli is null then 'NO' else 'SI' end cartera,      
case when b.HTIPNUMDOC is null then 'NO' else 'SI' end enrolado,      
case when c.HTIPNUM is null then 'NO' else 'SI' end usabilidad      
into #Tb  
from #cred a       
left join #Enrolado_Activos b      
on a.hfecpro=b.hfecpro and a.HTIPNUM=b.HTIPNUMDOC       
left join #Usa_Cartera c      
on a.hfecpro=c.hfecpro and a.HTIPNUM=c.HTIPNUM      
      
select * from #Tb  
  
select '20.50%' meta,--count(distinct hdescli) cli,  
sum(case when cartera='SI' then 1 else null end) carteraCount,  
sum(case when enrolado='SI' then 1 else null end) enroladoCount,  
sum(case when usabilidad='SI' then 1 else null end) usabilidadCount  
from #Tb  
  
end
