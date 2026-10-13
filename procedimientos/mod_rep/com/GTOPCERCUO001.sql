-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-07-20 16:48:25.057000
--EXEC [com].[GTOPCERCUO001] '7','11','231', 3 ,'20211024'      
CREATE PROCEDURE [com].[GTOPCERCUO001](        
 @tip_cod varchar(5),@tip_cod2 varchar(50),@cod_rel varchar(25), @tipcuota int,@fec date)            
AS              
BEGIN            
 SET NOCOUNT ON;          
--declare @tip_cod nvarchar(10)=7,@tip_cod2 nvarchar(10)='11',@cod_rel varchar(50) ='231',@tipcuota int=3        
--declare @tip_cod nvarchar(10)='7',@tip_cod2 nvarchar(10)='11',@cod_rel varchar(50) ='231',@tipcuota int=3  ,@fec date='20211024'      
-------------      
declare @fecs nvarchar(max)      
      
 declare @fecs2 varchar(250)=(select max(HFECPRO) from [storage].[com_act].[HCDA001] where HFECPRO<=@fec );             
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF               
      
select *            
into #FECS    --drop table #FECS  select * from #FECS        
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
 (2,2,1,'descripcion','Descripción','string',null,2,null),        
 (3,null,1,'nro','Nro Cero Cuotas','string',null,null,2),        
 (4,null,1,'sal','Saldo Cero Cuotas','string',null,null,2),        
      
 (4,3,2,'num_cero_1',@fecCab1,'number','.0-0',null,null),        
 (5,4,2,'num_cero_2',@fecCab2,'number','.0-0',null,null),        
 (6,5,2,'sal_cero_1',@fecCab1,'number','.0-0',null,null),        
 (7,6,2,'sal_cero_2',@fecCab2,'number','.0-0',null,null)      
      
          
 select rep.FFTHCOLDEF(@defs) result;       
      
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
          /*      
 insert into @tfil                
 values                       
 ('todos','fec',@fecs)              
                
 insert into @tconf                
 values                
 ('level_alias','style')      
 */                
                
 declare @jer varchar(100)                
 insert into @tfil                 
  exec [piv].[GPIVLEV07] @tip_cod,@tip_cod2,@cod_rel,@jer output            
                
               
               
 create table #Temp1       
 (      
 fila int null, cod_fc varchar(250)null,cod_ccor_m varchar(250)null,style int null,      
 --descripcion varchar(250)null,num_cero_1 float null,num_cero_2 float null,sal_cero_1 float null,sal_cero_2 float null      
 descripcion varchar(250)null,sal_cero_1 float null,sal_cero_2 float null,num_cero_1 float null,num_cero_2 float null      
 )      
   create table #Temp2       
 (      
 fila int null, cod_fc varchar(250)null,cod_ccor_m varchar(250)null,style int null,      
 descripcion varchar(250)null,Saldo_1 float null,Saldo_2 float null,SaldoN_1 float null,SaldoN_2 float null, Num_1 float,Num_2 float , NumN_1 float , NumN_2 float      
 )           
      
 if @tipcuota in(1,2)      
begin      
 insert into #Temp1      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1        
end      
      
 if @tipcuota=3      
begin      
INSERT INTO #Temp2      
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1         
      
INSERT INTO #Temp1      
SELECT fila,cod_fc,cod_ccor_m,style,descripcion,Saldo_1 - SaldoN_1 ,Saldo_2 - SaldoN_2 , Num_1 - NumN_1 , Num_2 - NumN_2      
FROM #Temp2      
end  -- select  * from #Temp1      
      
              
       
      
 ;with cte_a as (      
 select top 10 * from #Temp1 where style=0 --order by sal_cero_2 desc      
 )      
  select  distinct case when @tip_cod in(7,21) then b.RDESGRU else a.descripcion end descr2,a.descripcion,a.num_cero_1,a.num_cero_2,a.sal_cero_1,a.sal_cero_2       
  from cte_a a       
  left join (select distinct RDESCOR,RDESTER,RDESGRU,RDESUNI from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' and rfecpro=@fecs2) b       
  on a.descripcion=case when @tip_cod in(7,21) and @tip_cod2=20 then b.RDESTER      
      when @tip_cod in(7,21) and @tip_cod2=18 then b.RDESUNI end      
  order by a.sal_cero_2  desc      
      
    --SELECT TOP 5 * FROM storage.[ref].WJERCOR03  
END      
  --drop table #FECS  drop table #Temp1  drop table #Temp2      
  --select * from storage.[ref].WJERCOR01 where RINDFEC='ACTUAL' and rfecpro='20211023'
