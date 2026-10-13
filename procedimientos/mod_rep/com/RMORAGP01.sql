-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-10-28 07:45:33.087000
--EXEC [com].[RMORAGP01] 7,'231','20220727'
CREATE PROCEDURE [com].[RMORAGP01]
@tip_cod int,@cod_rel varchar(20),@fec DATE
AS
BEGIN 
SET NOCOUNT ON;   
--declare @tip_cod int=7,@cod_rel varchar(50)='231',@fec varchar(50)='20220726'
------------------------------

declare @defs as rep.TTHCOLDEF;          
       
  insert into @defs                
       
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values          
 (1,1,1,'HTRAM','Tramo','string',null,null,null,null),        
 (2,2,1,'saldoMoraA','Saldo Mora Mes A.','number','.0-0',null,null,null),            
 (3,3,1,'num_grupA','# Grupos Mes A.','number','.0-0',null,null,null),        
 (4,4,1,'num_clieA','# Clientes Mes A.','number','.0-0',null,null,null),              
 (5,5,1,'saldoMora','Saldo Mora','number','.0-0',null,'#A72C12',null),        
 (6,6,1,'num_grup','# Grupos','number','.0-0',null,'#A72C12',null),        
 (7,7,1,'num_clie','# Clientes','number','.0-0',null,'#A72C12',null),        
 (8,8,1,'P_SALMORA','% Saldo Mora','percent','.0-0',null,'#A72C12',null),  
 (9,9,1,'P_CLIMORA','% Cliente Mora','percent','.0-0',null,'#A72C12',null),  
 (10,10,1,'P_GRUMORA','% Grupo Mora','percent','.0-0',null,'#A72C12',null)  

 select rep.FFTHCOLDEF(@defs) result;      

declare @FecAntes date
set @FecAntes =(select DATEADD(MM,-1,convert(date,@fec)))

SELECT *
into #FECS --DROP TABLE #FECS   select * from #FECS
from storage.util.FVECFEC01(@fec,'cmg_5,cmg_6')

declare @fec1 date,@fec2 date
set @fec1=(select rfec from #FECS where rord=1)
set @fec2=(select rfec from #FECS where rord=2)

 
declare @fecacumu varchar(max)
select @fecacumu=string_agg(format(RFEC,'yyyyMMdd'),',') 
from #FECS 
--select*into #FJERCOR02 from storage.ref.FJERCOR02(@fecacumu) --drop table #FJERCOR02,#FECS,#report
  
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF    
    
  insert into @tvars values     
  ('sal_cap',null,null,null,null,null),   
  ('cli_cre_stock',null,null,null,null,null)  
    
  insert into @tfil values    
  ('todos','fec',@fecacumu) 
  --('todos','fec','"'+concat_ws('","',@fec,@fec_a)+'"')  
  
  --declare @tip_cod int=7,@cod_rel varchar(100)='231'  
  declare @jer varchar(100);  
  insert into @tfil  
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output  
    
 select @jer='"prod_tipo","prod_com","fec"'  
  insert into @tconf    
  values    
  ('level_alias','style'),
 -- ('insert_to','#report'), 
  ('fec_corr','true')
 
  create table #report (fila int,cod_prod_tipo varchar(100),cod_prod_com int,cod_fec varchar(50) null,style int,descripcion varchar(100),sal_cap_1 float,cli_cre_stock_1 int)
  insert into #report  --drop table #report
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1
  
  delete from #report where style<>0   
  delete from #report where cod_prod_com<>'6' --select * from #report
  
  alter table  #report add ord int null
  update a
  set a.ord=b.rord
  from #report a inner join #FECS b  --select * from #report  update #report set cod_fec='20220727',descripcion='2022-07-27' where cod_fec='20220726'
  on a.descripcion=b.RFEC
   
  
;with cte_a as (
select * from storage.com_act.WCED001
),
cte_b as (
select a.*,@fec2 hfecpro from storage.com_act.WCED001 a
left join (select * from #FJERCOR02 where RCODGRU=2)  b on a.hcodsec=b.rcodsec and b.rfecpro=@fec2
) 
,
cte_c as (
select a.*,@fec1 hfecpro from storage.[com_act].WCEM001 a 
left join (select * from #FJERCOR02 where RCODGRU=2)  b on a.hcodsec=b.rcodsec and b.rfecpro=@fec1
),
cte_u as (
select * from cte_b union all select * from cte_c
) 
,
cte_base as ( 
select  a.*,b.HNROG 
from cte_u   a
inner join (select *  from storage.com_act.HDGP001 a 
            inner join #FECS b on a.HFECPRO=b.RFEC  --select * from #FECS  update #FECS set rfec='2022-07-27' where rord=2
		    where HESTG='ACTIVO' and HESTI='ACTIVO' 
		   )b
on A.HCODOPE=B.HOPER  and a.hfecpro=b.hfecpro
) 
,
cte_grupos as (
select hfecpro,count(distinct HNROG) NumGrupoTotal
from storage.com_act.HDGP001 a 
inner join #FECS b on a.HFECPRO=b.RFEC
where HESTG='ACTIVO' and HESTI='ACTIVO' 
group by hfecpro
) 
,
cte_d as (  
select HFECPRO,HTRAM, SUM(isnull(HFCMPP,0)) SaldoMora,count(distinct HNROG) Num_Grup, COUNT(distinct hctacli) Num_Clie
from cte_base 
group by HFECPRO,HTRAM
)  
select a.*,SaldoMora/b.sal_cap_1 as '% saldo de mora',
		   cast(Num_Clie as float)/b.cli_cre_stock_1 as '% Cliente en mora',
		   cast(a.Num_Grup as float)/c.NumGrupoTotal as '% Grupos en Mora'	 
into #Resultado  --drop table #Resultado
from cte_d a
inner join #report b  --select * from #Resultado  select * from #report
on a.HFECPRO=b.descripcion
inner join cte_grupos c
on a.HFECPRO=c.HFECPRO

 

select a.HTRAM,b.saldoMora AS saldoMoraA ,b.num_grup as num_grupA,b.Num_Clie as num_clieA,
	   a.saldoMora,a.num_grup,a.Num_Clie,A.[% saldo de mora] as 'P_SALMORA',A.[% Cliente en mora] AS 'P_CLIMORA',A.[% Grupos en Mora]  AS 'P_GRUMORA' 
from #Resultado a
inner join (select  * from #Resultado where hfecpro=@fec1) b 
on a.HTRAM=b.HTRAM
where a.hfecpro=@fec2
 
end
