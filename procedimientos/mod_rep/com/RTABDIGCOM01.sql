-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-01-16 10:00:36.297000
--exec com.RTABDIGCOM01 7,'231'
create procedure com.RTABDIGCOM01 ---DROP PROCEDURE com_TABDIGCOM01
@tip_cod int, @cod_rel varchar(20) 
--declare @tip_cod int =7, @cod_rel varchar(20) = '231' 
-------------------------------------------------------------
AS
BEGIN
SET NOCOUNT ON;    
declare @fecs varchar(max)declare @fec_a varchar(8);      
      
    
select @fecs=(select replace(cast(max(hfecpro) as varchar(250)),'-','') from [storage].[com_act].WACLI001)    
     
select top 1    
 @fec_a=max(RFECTXT)     
 from storage.ref.RCALEN001    
 where RFEC<=cast(eomonth(@fecs,-1) as date) and RDIAFER=0   

 create table #fec (ORD int identity(1,1)not null, rfec date null)
 insert into #fec values(@fec_a)  insert into #fec values(@fecs) 

declare @head nvarchar(max)
set @head = '[{"label":"Descripción","key":"descripcion","cellStyle":{"min-width":"250px"}},   
 {"label":"Data Digital", "subs":[
 {"label":"Stock de Clientes","key":"166CLI","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}, 
 {"label":"Cliente Neto","key":"HNUMCLICLINET","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}, 
 {"label":"Cliente Enrolado","key":"clienroladocredito","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}, 
 {"label":"Cliente Usabilidad","key":"cliusabilidad","format":{"type":"integer"},"cellStyle":{"text-align":"right"}} ,
 {"label":"% Enrolado","key":"Percent_Enrolado","cellStyle":{"text-align":"right"}} ,
 {"label":"% Usabildidad","key":"percent_usabilidad","cellStyle":{"text-align":"right"}} 
]},
 {"label":"PAGO APP CLIENTE", "subs":[
 {"label":"Mes Anterior","key":"HNUMCLIPAGOCRE_MANT","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}, 
 {"label":"# Cliente","key":"HNUMCLIPAGOCRE","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}, 
 {"label":"Variación","key":"varclipagocre","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}
 ]},
 {"label":"PLIN", "subs":[
 {"label":"Mes Anterior","key":"HNUMCLIPAGOPLIN_MANT","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}, 
 {"label":"# Cliente","key":"HNUMCLIPAGOPLIN","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}, 
 {"label":"Variación","key":"varclipagoplin","format":{"type":"integer"},"cellStyle":{"text-align":"right"}} 
 ]
}]' 
    

 select @head

declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)    
     
insert into @tvars    
values ('num_cli_stock', null, '166', null, null, null) 
    
    
insert into @tfil values ('todos', 'fec', ''+@fecs+'')    
insert into @tconf values ('level_alias', 'style')    
    
insert into @tfil    
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output     
       
    
create table #DES(fila int null, cod_fc varchar(250)null,cod_cter varchar(250)null,style int null,descripcion varchar(max)null,[166CLI] float null)    
insert into #DES    
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf-- ,@show_query=1    
    
;with cte_a as (
select * from storage.[com].[WJAS005]
where hfecpro in(select rfec from #fec where ord=1)
),
cte_aa as (
select hfecpro,htipcod,hcodrel,htipcred,hnumcli,hnumclipagocre,hnumclipagoplin,hnumcliclinet,
format((cast(htipcred as float)/ hnumcliclinet),'P') Percent_Enrolado,
format((cast(hnumcli as float)/hnumcliclinet),'P') percent_usabilidad
from storage.[com].[WJAS005]
where hfecpro in(select rfec from #fec where ord=2)
)
,
cte_b as (
select a.hfecpro,a.htipcod,a.hcodrel,a.HNUMCLICLINET,a.htipcred clienroladocredito, a.hnumcli cliusabilidad ,a.Percent_Enrolado,a.percent_usabilidad,
a.HNUMCLIPAGOCRE,a.HNUMCLIPAGOPLIN,b.HNUMCLIPAGOCRE HNUMCLIPAGOCRE_MANT,b.HNUMCLIPAGOPLIN HNUMCLIPAGOPLIN_MANT,
a.HNUMCLIPAGOCRE - b.HNUMCLIPAGOCRE varclipagocre,
a.HNUMCLIPAGOPLIN - b.HNUMCLIPAGOPLIN varclipagoplin
from cte_aa a
left join cte_a b 
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel
) 
select * into #Result from cte_b
 
alter table #DES  add
HNUMCLICLINET int null,Percent_Enrolado varchar(250)null,percent_usabilidad varchar(250)null,
HNUMCLIPAGOCRE int null,HNUMCLIPAGOPLIN int null,HNUMCLIPAGOCRE_MANT int null,HNUMCLIPAGOPLIN_MANT int null,
varclipagocre varchar(250)null,varclipagoplin  varchar(250)null,
clienroladocredito int null,cliusabilidad int null
 


update a set 
a.HNUMCLICLINET=b.HNUMCLICLINET,
a.Percent_Enrolado=b.Percent_Enrolado,
a.percent_usabilidad=b.percent_usabilidad,
a.HNUMCLIPAGOCRE=b.HNUMCLIPAGOCRE,
a.HNUMCLIPAGOPLIN=b.HNUMCLIPAGOPLIN,
a.HNUMCLIPAGOCRE_MANT=b.HNUMCLIPAGOCRE_MANT,
a.HNUMCLIPAGOPLIN_MANT=b.HNUMCLIPAGOPLIN_MANT,
a.varclipagocre=b.varclipagocre,
a.varclipagoplin=b.varclipagoplin,
a.clienroladocredito=b.clienroladocredito,
a.cliusabilidad=b.cliusabilidad
from #Des a left join (select* from  #Result where hfecpro=cast(@fecs as date)) b          
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel        
where style=1
 
update a set 
a.HNUMCLICLINET=b.HNUMCLICLINET,
a.Percent_Enrolado=b.Percent_Enrolado,
a.percent_usabilidad=b.percent_usabilidad,
a.HNUMCLIPAGOCRE=b.HNUMCLIPAGOCRE,
a.HNUMCLIPAGOPLIN=b.HNUMCLIPAGOPLIN,
a.HNUMCLIPAGOCRE_MANT=b.HNUMCLIPAGOCRE_MANT,
a.HNUMCLIPAGOPLIN_MANT=b.HNUMCLIPAGOPLIN_MANT,
a.varclipagocre=b.varclipagocre,
a.varclipagoplin=b.varclipagoplin,
a.clienroladocredito=b.clienroladocredito,
a.cliusabilidad=b.cliusabilidad
from #Des a  left join (select* from #Result where hfecpro=cast(@fecs as date)) b   
on case when @tip_cod=7 then '21'  
  when @tip_cod=21 then '20'  
  when @tip_cod=20 then '19'  
  when @tip_cod=19 then '18'
  when @tip_cod=18 then '17'
  when @tip_cod=17  then '1' end=b.HTIPCOD and isnull(a.cod_cter,'231')=b.hcodrel         
where a.style=0        


select * from #Des
  
END
