-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-12-28 08:50:15.543000
--EXEC [com].[GCMCNUE001] '13','1_1', '20211104', 0,1                
CREATE PROCEDURE [com].[GCMCNUE001](            
 @tip_cod varchar(5),@cod_rel varchar(25), @fec date,@prod varchar(50),@tipcuota int)                
AS                  
BEGIN                
 SET NOCOUNT ON;                
--declare @cod_rel varchar(25)='231', @fec date='20210909', @tip_cod varchar(5)='7',@prod varchar(50)='1',@tipcuota int = 2            
--tipcuota 1 =  Total          
--tipcuota 2 =  Cuotas nuevas            
--tipcuota 3 =  Cuotas Mantiene            
-------------------------------            
            
DECLARE @fecs VARCHAR(MAX)                
            
select *                
into #FECS    --drop table #FECS  select * from #FECS            
from storage.util.FVECFEC01(@fec,'cmg_2,cmg_5,cmg_6')                
            
            
/*Cabeceras*/            
declare @fec1 date,@fec2 date,@fec3 date            
set @fec1=(select rfec from  #FECS where rord=1)            
set @fec2=(select rfec from  #FECS where rord=2)            
set @fec3=(select rfec from  #FECS where rord=3)            
            
 declare @defs as rep.TTHCOLDEF;            
            
insert into @defs            
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH)  values            
 (1,1,1,'descripcion','Descripción',null,2,1,'string',null,null),            
 (2,1,null,'nrocuotasnuevas','Nro Cero Cuotas',3,null,null,null,null,null),            
 (3,1,null,'salcuotasnuevas','Saldo S/. Cero Cuotas',3,null,null,null,null,null),            
            
 (4,1,8,'part2','% Part '+format(cast(eomonth(@fec2,-1) as date),'dd-MMM')+'',null,2,null,'percent','.0-0','100px'),            
 (5,1,9,'part3','% Part '+format(cast(@fec3 as date),'dd-MMM')+'',null,2,null,'percent','.0-0','100px'),            
 (6,1,10,'varnum','Var. Nro',null,2,null,'number','.0-0','100px'),            
 (7,1,11,'varsaldo','Var. Saldo',null,2,null,'number','.0-0','100px'),            
 (8,1,12,'MetaNro','Meta Nuevo Ingreso (N°)',null,2,null,'number','.0-0','100px'),            
 (9,1,13,'MetaSaldo','Meta Nuevo Ingreso (S/.)',null,2,null,'number','.0-0','100px'),            
            
            
 (10,2,2,'1num',''+format(cast(@fec1 as date),'dd-MMM-yy')+'',null,null,null,'number','.0-0','100px'),            
 (11,2,3,'2num',''+format(cast(@fec2 as date),'dd-MMM-yy')+'',null,null,null,'number','.0-0','100px'),            
 (11,2,4,'3num',''+format(cast(@fec3 as date),'dd-MMM-yy')+'',null,null,null,'number','.0-0','100px'),            
 (11,2,5,'1sald',''+format(cast(@fec1 as date),'dd-MMM-yy')+'',null,null,null,'number','.0-0','100px'),            
 (11,2,6,'2sald',''+format(cast(@fec2 as date),'dd-MMM-yy')+'',null,null,null,'number','.0-0','100px'),            
 (11,2,7,'3sald',''+format(cast(@fec3 as date),'dd-MMM-yy')+'',null,null,null,'number','.0-0','100px')            
            
 --select * from @defs            
 select rep.FFTHCOLDEF(@defs) result;            
/**/            
            
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                
from #FECS                
            
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)                
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL                
            
if @tipcuota=1             
begin            
insert into @tvars                
values  ('sal_cero', null, '118', null, null, null),--Cero cuotas nuevas saldo            
        ('num_cero', null, '120', null, null, null)--Cero Cuotas (Nro)               
end            
if @tipcuota=2            
begin            
            
insert into @tvars                
values  ('sal_cero_nuevas', null, '118', null, null, null),--Cero cuotas nuevas saldo            
        ('num_cero_nuevas', null, '120', null, null, null)--Cero Cuotas (Nro)               
end            
            
          
if @tipcuota=3            
begin            
insert into @tvars                
values  ('sal_cero', null, '118', null, null, null),--Cero cuotas nuevas saldo            
        ('num_cero', null, '120', null, null, null),--Cero Cuotas (Nro),          
        ('sal_cero_nuevas', null, '119', null, null, null),--Cero cuotas nuevas saldo            
        ('num_cero_nuevas', null, '121', null, null, null)          
end          
        
if @tipcuota in(1,2)          
begin          
insert into @tfil values ('todos', 'fec', @fecs)                
insert into @tconf values ('level_alias', 'style')--,('insert_to', '#RESULTPIV')    --drop table #RESULTPIV drop table #FECS            
end          
if @tipcuota=3          
begin          
insert into @tfil values  ('todos', 'fec', @fecs)                
insert into @tconf values ('level_alias', 'style')--,('insert_to', '#RESULTPIV')    --drop table #RESULTPIV drop table #FECS            
insert into @tconf values ('fec_corr','true')            
end          
            
            
if(@prod<>'0')                          
 begin                          
  insert into @tfil values                          
  ('TODOS','prod_com','"'+@prod+'"')             
 end            
                
insert into @tfil                
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output             
            
          
create table #RESULTPIV( --select  * from #RESULTPIV            
fila int null,cod_fc varchar(250) null,cod_cter varchar(250)null,style int null,descripcion varchar(250)null,[1sald] float null,[2sald] float null,[3sald] float null,[1num] float null,[2num] float null,[3num] float null             
)            
          
create table #RESULTPIVM( --select  * from #RESULTPIV            
fila int null,cod_fc varchar(250) null,cod_cter varchar(250)null,style int null,descripcion varchar(250)null,[1sald] float null,[2sald] float null,[3sald] float null,               
[1saldN] float null,[2saldN] float null,[3saldN] float null,          
[1num] float null,[2num] float null,[3num] float null,             
[1numN] float null,[2numN] float null,[3numN] float null             
)            
if @tipcuota in(1,2)          
begin          
insert into #RESULTPIV             
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars","fec"',@config=@tconf--,@show_query=1              
end          
          
if @tipcuota=3          
begin          
INSERT INTO #RESULTPIVM          
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1             
          
INSERT INTO #RESULTPIV          
SELECT fila,cod_fc,cod_cter,style,descripcion,[1sald] - [1saldN] ,[2sald] - [2saldN] , [3sald] - [3saldN] , [1num] - [1numN] , [2num] - [2numN] , [3num] - [3numN]          
FROM #RESULTPIVM          
end           
----------            
  ;with cte_idx1 as (            
select  a.cod_fc,a.cod_cter,a.style,a.descripcion ,            
     a.[1sald],a.[2sald],a.[3sald],a.[1num],a.[2num],a.[3num],            
    null [part2], null [part3]             
from #RESULTPIV a            
where style=1            
),            
cte_a as (            
select  a.cod_fc,a.cod_cter,a.style, a.descripcion,            
  a.[1sald],a.[2sald],a.[3sald],a.[1num],a.[2num],a.[3num],            
CASE WHEN b.[2num]=0 THEN 0 ELSE isnull(a.[2num],0)  / isnull(b.[2num],0) END [part2], 
CASE WHEN b.[3num]=0 THEN 0 ELSE isnull(a.[2num],0)  / isnull(b.[3num],0) END [part3]             
from #RESULTPIV a            
inner join cte_idx1 b on a.style=0            
where a.style=0            
)            
select * into #Te from cte_idx1 union all            
select * from cte_a            
            
;with a as (            
select * from [storage].[com].[VDMCOM01]             
where HTIPMETA=1 and HCODVAR  in(118,120)and hfecpro=eomonth(@fec)            
),            
cte_b as (            
select * from a            
pivot(MAX(HVALVAR) for HCODVAR in([118],[120])) b            
) ,        
cte_c as (           
select a.* , isnull([3sald],0) - isnull([2sald],0)  varsaldo , isnull([3num],0) - isnull([2num],0)  varnum,b.[118] as MetaSaldo,b.[120] as MetaNro            
from #Te a             
left join cte_b b                  
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel              
where style=1            
union all            
select a.* , isnull([3sald],0) - isnull([2sald],0)  varsaldo , isnull([3num],0) - isnull([2num],0)  varnum,b.[118],b.[120]             
from #Te a             
left join cte_b b            
on case when @tip_cod=7 then '15'                
  when @tip_cod=15 then '14'                
  when @tip_cod=13 then '11'                 
  when @tip_cod=11 then '2' end=b.HTIPCOD and isnull(a.cod_cter,'231')=b.hcodrel                
where style<>1            
  )        
  select * from cte_c order by  [3sald] desc        
END
