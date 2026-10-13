-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-15 15:40:40.697000
--EXEC [com].[GTOPCERCUO005] '7','11','231', 3 ,'20211023'    
CREATE PROCEDURE [com].[GTOPCERCUO005](      
 @tip_cod varchar(5),@tip_cod2 varchar(50),@cod_rel varchar(25), @tipcuota int,@fec date)          
AS            
BEGIN          
 SET NOCOUNT ON;     
-------------    
declare @fecs nvarchar(max)      
      
 declare @fecs2 varchar(250)=(select max(HFECPRO) from [storage].[com_act].[HCDA001] where HFECPRO<=@fec );             
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF               
      
select *            
into #FECS    --drop table #FECS  drop table #Temp1 drop table #Temp2      
from storage.util.FVECFEC01(@fecs2,'cmg_5,cmg_6')          
      
      
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')            
from #FECS        
                
declare @fecCab1 varchar(50), @fecCab2 varchar(50)      
      
set @fecCab1=(select rfec from #FECS where rord=1)      
set @fecCab2=(select rfec from #FECS where rord=2)      
      
declare @defs as rep.TTHCOLDEF;       
insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS)  values        
 (1,1,1,'descr2','','string',1,2)        
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TROWS,TCOLS)  values        
 (2,2,1,'descripcion','Descripción','string',null,1,null),        
 (3,3,1,'num_ccn_ref','Refinanciado','number','.0-0',null,1),        
 (4,4,1,'num_ccn_repro','Repro','number','.0-0',null,1),      
 (5,5,1,'num_ccn_norepro','No Repro','number','.0-0',null,1),      
 (6,6,1,'total','Total','number','.0-0',null,1)      
          
 select rep.FFTHCOLDEF(@defs) result;       
      
if @tipcuota=1         
begin        
insert into @tvars            
values  ('num_ccn_N_ref', null, '118', null, null, null),--Cero cuotas nuevas saldo        
        ('num_ccn_N_repro', null, '120', null, null, null),      
  ('num_ccn_N_norepro', null, '121', null, null, null)        
end        
if @tipcuota=2        
begin        
        
insert into @tvars            
values  ('num_ccn_ref', null, '118', null, null, null),--Cero cuotas nuevas saldo        
        ('num_ccn_repro', null, '120', null, null, null),      
  ('num_ccn_norepro', null, '121', null, null, null)           
end        
        
      
if @tipcuota=3        
begin        
insert into @tvars            
values  ('num_ccn_N_ref', null, '118', null, null, null),--Cero cuotas nuevas saldo        
        ('num_ccn_N_repro', null, '120', null, null, null),--Cero Cuotas (Nro),      
  ('num_ccn_ref', null, '119', null, null, null),--Cero cuotas nuevas saldo        
        ('num_ccn_repro', null, '121', null, null, null),      
  ('num_ccn_N_norepro', null, '122', null, null, null),--Cero cuotas nuevas saldo        
        ('num_ccn_norepro', null, '123', null, null, null)      
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
              
 declare @jer varchar(100)                
 insert into @tfil                 
  exec [piv].[GPIVLEV07] @tip_cod,@tip_cod2,@cod_rel,@jer output            
                
               
               
 create table #Temp1       
 (      
 fila int null, cod_fc varchar(250)null,cod_ccor_m varchar(250)null,style int null,      
 --descripcion varchar(250)null,num_cero_1 float null,num_cero_2 float null,sal_cero_1 float null,sal_cero_2 float null      
 descripcion varchar(250)null,num_ccn_ref float null, num_ccn_repro float null, num_ccn_norepro float null       
 )      
   create table #Temp2       
 (      
 fila int null, cod_fc varchar(250)null,cod_ccor_m varchar(250)null,style int null,      
 descripcion varchar(250)null,      
 NORMALREF float null,NORMALREPRO float null,NREF float null,NREPRO float null, NORMALNOREPRO float,NNOREPRO float       
 )           
      
      
 if @tipcuota in(1,2)      
begin      
 insert into #Temp1  -- select * from #Temp1      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1        
end      
      
 if @tipcuota=3      
begin      
INSERT INTO #Temp2      
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1         
      
INSERT INTO #Temp1      
SELECT fila,cod_fc,cod_ccor_m,style,descripcion,NORMALREF - NREF ,NORMALREPRO - NREPRO , NORMALNOREPRO - NNOREPRO      
FROM #Temp2      
end  -- select  * from #Temp1      
      
              
       
       
 ;with cte_a as (      
 select  * from #Temp1 where style=0 --order by sal_cero_2 desc      
 ),      
 cte_result as (      
  select  distinct case when @tip_cod in(7,21) then b.RDESGRU else a.descripcion end descr2,      
  a.descripcion,a.num_ccn_ref,a.num_ccn_repro,a.num_ccn_norepro , a.num_ccn_ref + a.num_ccn_repro + a.num_ccn_norepro  as total      
  from cte_a a       
  left join (select distinct RDESCOR,RDESTER,RDESGRU,RDESUNI from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' and rfecpro=@fecs2) b       
  on a.descripcion=case when @tip_cod in(7,21) and @tip_cod2=20 then b.RDESTER      
      when @tip_cod in(7,21) and @tip_cod2=18 then b.RDESUNI end      
      
 )      
 select top 5 * from cte_result order by total desc      
    
     
END
