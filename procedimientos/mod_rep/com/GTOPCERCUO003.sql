-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-15 15:38:37.073000
--EXEC [com].[GTOPCERCUO003] '7','11','231', 1 ,'20211025'      
CREATE PROCEDURE [com].[GTOPCERCUO003](        
 @tip_cod varchar(5),@tip_cod2 varchar(50),@cod_rel varchar(25), @tipcuota int,@fec date)            
AS              
BEGIN            
 SET NOCOUNT ON;          
--declare @tip_cod nvarchar(10)=7,@tip_cod2 nvarchar(10)='14',@cod_rel varchar(50) ='231',@tipcuota int=1        
------------- --drop table #Temp1 drop table #FECS   drop table #Temp2      
      
declare @fecs nvarchar(max)      
      
 declare @fecs2 varchar(250)=(select max(HFECPRO) from [storage].[com_act].[HCDA001]  where HFECPRO<=@fec );             
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF               
      
select *            
into #FECS    --drop table #FECS  select * from #FECS        
from storage.util.FVECFEC01(@fecs2,'cmg_5,cmg_6')          
      
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')            
from #FECS        
                
      
if @tipcuota=1         
begin        
insert into @tvars            
values  ('sal_cero', null, '118', null, null, null)--,--Cero cuotas nuevas saldo        
        --('num_cero', null, '120', null, null, null)--Cero Cuotas (Nro)           
end        
if @tipcuota=2        
begin        
        
insert into @tvars            
values  ('sal_cero_nuevas', null, '118', null, null, null)--,--Cero cuotas nuevas saldo        
        --('num_cero_nuevas', null, '120', null, null, null)--Cero Cuotas (Nro)           
end        
        
      
if @tipcuota=3        
begin        
insert into @tvars            
values  ('sal_cero', null, '118', null, null, null),--Cero cuotas nuevas saldo        
        --('num_cero', null, '120', null, null, null),--Cero Cuotas (Nro),      
  ('sal_cero_nuevas', null, '119', null, null, null)--,--Cero cuotas nuevas saldo        
        --('num_cero_nuevas', null, '121', null, null, null)      
end      
                
      
if @tipcuota in(1,2)      
begin      
insert into @tfil values ('todos', 'fec', '"'+cast(@fecs2 as varchar(250))+'"')            
insert into @tconf values ('level_alias', 'style'),('insert_to', '#Temp1')    --drop table #RESULTPIV drop table #FECS        
end      
if @tipcuota=3      
begin      
insert into @tfil values  ('todos', 'fec', '"'+cast(@fecs2 as varchar(250))+'"')            
insert into @tconf values ('level_alias', 'style'),('insert_to', '#Temp2')    --drop table #Temp1 drop table #FECS   drop table #Temp2      
insert into @tconf values ('fec_corr','true')        
end      
                 
                
 insert into @tconf                
 values                
 ('level_alias','style')                
                
 declare @jer varchar(100)                
 insert into @tfil                 
  exec [piv].[GPIVLEV07] @tip_cod,@tip_cod2,@cod_rel,@jer output            
                
  --select @jer=@jer+',"prod_com"'               
         -- drop table #FECS      
--exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1       
      
 create table #Temp1 (      
 fila int null,cod_fc varchar(250)null,cod_ccor_m  varchar(250)null,style int null,descripcion  varchar(250)null,      
 --[120_1] float null,Hipo float null,CFAE FLOAT NULL, CREACT FLOAT NULL, INIOFIC FLOAT NULL, INICNEG FLOAT NULL,      
 --CC FLOAT NULL, INCFAMUJER FLOAT NULL, NGFAEMUJER FLOAT NULL,CEDUCA FLOAT NULL, EMPCON FLOAT NULL, INCICONPYME FLOAT NULL, PMUJER FLOAT NULL, CONSUMO FLOAT NULL, GLIQUIDA FLOAT NULL, TFC FLOAT NULL       
 [118_1] float null,[118_11] float null,[118_16] float null,[118_17] float null,[118_18] float null,      
[118_19] float null,[118_2] float null,[118_20] float null,[118_21] float null,[118_3] float null,      
[118_4] float null,[118_5] float null,[118_6] float null,[118_7] float null,[118_8] float null,[118_9] float null      
 ) -- select * from #Temp1      
       
 create table #Temp2 (      
 fila int null,cod_fc varchar(250)null,cod_ccor_m  varchar(250)null,style int null,descripcion  varchar(250)null,      
 --Agro float null,Hipo float null,CFAE FLOAT NULL, CREACT FLOAT NULL, INIOFIC FLOAT NULL, INICNEG FLOAT NULL,      
 --CC FLOAT NULL, INCFAMUJER FLOAT NULL, NGFAEMUJER FLOAT NULL,CEDUCA FLOAT NULL, EMPCON FLOAT NULL, INCICONPYME FLOAT NULL, PMUJER FLOAT NULL, CONSUMO FLOAT NULL,       
 --GLIQUIDA FLOAT NULL, TFC FLOAT NULL,       
       
-- AgroN float null,HipoN float null,CFAEN FLOAT NULL, CREACTN FLOAT NULL, INIOFICN FLOAT NULL, INICNEGN FLOAT NULL,      
 --CCN FLOAT NULL, INCFAMUJERN FLOAT NULL, NGFAEMUJERN FLOAT NULL,CEDUCAN FLOAT NULL, EMPCONN FLOAT NULL, INCICONPYMEN FLOAT NULL, PMUJERN FLOAT NULL, CONSUMON FLOAT NULL, GLIQUIDAN FLOAT NULL, TFCN FLOAT NULL       
 [118_1] float null,[118_11] float null,[118_16] float null,[118_17] float null,[118_18] float null,      
[118_19] float null,[118_2] float null,[118_20] float null,[118_21] float null,[118_3] float null,      
[118_4] float null,[118_5] float null,[118_6] float null,[118_7] float null,[118_8] float null,[118_9] float null,      
[119_1] float null,[119_11] float null,[119_16] float null,[119_17] float null,[119_18] float null,      
[119_19] float null,[119_2] float null,[119_20] float null,[119_21] float null,[119_3] float null,      
[119_4] float null,[119_5] float null,[119_6] float null,[119_7] float null,[119_8] float null,[119_9] float null      
      
 )      
       
 -- select * from #Temp2      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","prod_com"',@config=@tconf--,@show_query=1       
      
      
  if @tipcuota=3      
begin      
      
INSERT INTO #Temp1 --drop table #Temp1      
SELECT fila,cod_fc,cod_ccor_m,style,descripcion,      
[118_1] - [119_1],[118_11] - [119_11],[118_16] - [119_16] ,[118_17] - [119_17] ,[118_18] - [119_18],      
[118_19] - [119_19] ,[118_2] - [119_2] ,[118_20] - [119_20] ,[118_21] - [119_21] ,[118_3] - [119_3] ,      
[118_4] - [119_4] ,[118_5] - [119_5] ,[118_6] - [119_6],[118_7] - [119_7] ,[118_8] - [119_8] ,[118_9] - [119_9]       
FROM #Temp2      
end      
      
alter table #Temp1      
add total float null      
      
update #Temp1 set total= isnull([118_1],0)  + isnull([118_11],0) + isnull([118_16],0) + isnull([118_17],0) + isnull([118_18],0) +       
isnull([118_19],0) + isnull([118_2],0)  + isnull([118_20],0) + isnull([118_21],0) + isnull([118_3] ,0)+       
isnull([118_4],0)  + isnull([118_5],0)  + isnull([118_6],0)  + isnull([118_7],0)  + isnull([118_8],0) +       
isnull([118_9],0)       
      
declare @defs as rep.TTHCOLDEF;       
insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values        
 (1,1,1,'descripcion','Corredor','string',1)        
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values        
 (2,2,1,'descr2','Territorio','string',null),        
 (3,3,1,'118_1','AGROPECUARIO','number','.0-0'),        
 (4,4,1,'118_11','HIPOTECARIO','number','.0-0'),        
 (5,5,1,'118_16','CREDITOS FAE','number','.0-0'),        
 (6,6,1,'118_17','CREDITOS REACTIVA','number','.0-0'),        
 (7,7,1,'118_18','INICIANDO OFICIOS','number','.0-0'),       
 (8,8,1,'118_19','INICIANDO NEGOCIOS','number','.0-0'),       
 (9,9,1,'118_2','CONSTRUYENDO CONFIANZA','number','.0-0'),       
 (10,10,1,'118_20','INCLUSION FAE MUJER','number','.0-0'),       
 (11,11,1,'118_21','NEGOCIOS FAE MUJER','number','.0-0'),       
 (12,12,1,'118_3','CREDITO EDUCATIVO','number','.0-0'),       
 (13,13,1,'118_4','EMPRENDIENDO CONFIANZA','number','.0-0'),        
 (14,14,1,'118_5','INICIANDO CONFIANZA PYME','number','.0-0'),        
 (15,15,1,'118_6','PALABRA DE MUJER','number','.0-0'),        
 (16,16,1,'118_7','CONSUMO','number','.0-0'),        
 (17,17,1,'118_8','GARANTIA LIQUIDA','number','.0-0'),        
 (18,18,1,'118_9','TRABAJADORES FC','number','.0-0'),        
 (19,19,1,'total','TOTAL','number','.0-0')        
      
      
 select rep.FFTHCOLDEF(@defs) result;       
      
 ;with cte_a as (      
 --select top 5 * from #Temp1 where style not in(1) --order by sal_cero_2 desc      
 select   * from #Temp1 where style not in(1) --order by sal_cero_2 desc      
 )      
  select  distinct top 5  case when @tip_cod in(7,21) then b.RDESGRU else a.descripcion end descr2,a.descripcion,      
  [118_1]  , [118_11] , [118_16] , [118_17] , [118_18] ,       
[118_19] , [118_2]  , [118_20] , [118_21] , [118_3] ,       
[118_4]  , [118_5]  , [118_6]  , [118_7]  , [118_8] ,       
[118_9] ,total      
  from cte_a a       
  left join (select distinct RDESCOR,RDESTER,RDESGRU,RDESUNI from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' and rfecpro=@fecs2) b       
  on a.descripcion= case when @tip_cod in(7,21) and @tip_cod2=20 then b.RDESTER      
      when @tip_cod in(7,21) and @tip_cod2=18 then b.RDESUNI end      
  order by a.total  desc      
      
end
