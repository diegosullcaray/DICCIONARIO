-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-12-14 15:19:31.127000
--EXEC mod_rep.[com].[GRMENTOR002] '7','231', '20211209'          
--drop procedure [com].[GRMENTOR002]          
CREATE PROCEDURE [com].[GRMENTOR002](          
 @tip_cod varchar(5),@cod_rel varchar(25), @Fecha date)              
AS                
BEGIN              
 SET NOCOUNT ON;              
--declare @tip_cod varchar(5)='15',@cod_rel varchar(25)='1', @Fecha date='20210928'          
-------------          
          
declare @defs as rep.TTHCOLDEF;          
          
insert into @defs          
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH)  values          
 (1,1,1,'descrip','Descripción',null,null,1,'string',null,null),          
 (2,1,2,'100','Saldo de Cartera (miles PEN)',null,null,null,null,null,null),          
 (3,1,3,'165','Clientes del Activo (Nro)',null,null,null,null,null,null),          
 (4,1,4,'5006','Ope. Desembolsadas (Nro)',null,null,null,null,null,null),          
 (5,1,5,'5001','Seguro',null,null,null,null,null,null), --          
 (6,1,6,'202','Captaciones',null,null,null,null,null,null),           
 (7,1,7,'126','Efectividad -30-0d',null,null,null,null,null,null),          
 (8,1,8,'122','Efectividad 1-30d',null,null,null,null,null,null),          
 (9,1,9,'0001','Enrolamiento App',null,null,null,null,null,null),          
 (10,1,10,'0003','Corresponsal',null,null,null,null,null,null),          
 (11,1,11,'0002','Contratación Electronica',null,null,null,null,null,null)          
          
 select rep.FFTHCOLDEF(@defs) result;          
          
declare @fec varchar(50)          
SELECT @fec=MAX(RFEC) FROM [storage].[ref].[RCALEN001] WHERE RDIAFER=0 AND RFEC<=@Fecha          
          
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)            
          
insert into @tvars            
values  ('sal_cap', null, '100', null, null, null),          
     ('num_cli_stock', null, '165', null, null, null),          
  ('num_ope_sf2', null, '5006', null, null, null),          
  ('efec_m30_0', null, '126', null, null, null),--Efectividad -30-0d              
        ('efec_1_30', null, '122', null, null, null),--Efectividad 1-30d             
  ('cart_inst_enr', null, '0001', null, null, null),          
  ('num_ope_ce01',null,'0002',null,null,null)  ,          
  ('Num_Pol_Seg',null,'5001',null,null,null)               
            
insert into @tfil values ('todos', 'fec', '"'+@fec+'"'+'')            
insert into @tconf values ('level_alias', 'style'),('insert_to', '#DES')            
          
insert into @tfil            
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output            
          
select @jerar='"prod_tipo"'   --,"prod_com"          
          
create table #DES --select*from #DES           
(   fila int,            
    grupal varchar(250)null,            
    style int null,            
    descripcion varchar(250)null,            
    [100] float null,            
 [165] float null,          
 [5006] float null,          
 [126] float null,           
 [122] float null,            
 [0001] float null,          
 [0002] float null,          
 [5001] float null        
)            
--exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf--,@show_query=1            
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf--,@show_query=1              
          
DELETE FROM #DES WHERE descripcion IS NULL        
        
UPDATE #DES SET FILA=1 WHERE descripcion='GRUPAL'        
UPDATE #DES SET FILA=2 WHERE descripcion='INDIVIDUAL'        
    
alter table #DES add [202] float null        
        
delete from @tconf where TKEYPROP='insert_to'        
delete from @tvars where TKEYVAR in('sal_cap','num_cli_stock','num_ope_sf2','efec_m30_0','efec_1_30','cart_inst_enr','num_ope_ce01','Num_Pol_Seg')        
insert into @tvars    values    ('Sal_Ahorro_Comun', null, null, null, null, null)        
        
select @jerar='"prod_tipgru"'   --,"prod_com"         
create table  #Pas(fila int null, cod_prod_tipgru varchar(250) null, style int null,descripcion varchar(250) null,Sal_Ahorro_Comun float null)        
insert into #Pas        
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf--,@show_query=1          
      
 update a  -- select * from #Pas        
set a.[202]=b.Sal_Ahorro_Comun        
from #DES a inner join #Pas b        
on a.fila=b.fila  -- select * from DROP TABLE #DES        
        
;with cte_jerar as (          
 select * from storage.[ref].WJERCOR01 where RFECPRO=@fec and RINDFEC='ACTUAL' AND RDESGRU='GRUPAL'          
),cte_meta as (          
select replace(@fec,'-','') cod_fec, a.RDESGRU , b.HCODVAR , case when HCODVAR in(122,126) then  sum(b.HVALVAR)/count(hcodrel) else  sum(b.HVALVAR) end HVALVAR          
from cte_jerar a          
left join  [storage].[com].[VDMCOM01] b  --select * from [storage].[com].[VDMCOM01] where HFECPRO = eomonth('20210929') and  HTIPMETA=1 and HTIPCOD = 2 and   HCODVAR=126          
on a.rcodsec=b.HCODREL          
where HCODVAR in(100,165,5006,126,122,202,5001)           
and HFECPRO = eomonth(@fec)            
and HTIPMETA=1 and HTIPCOD = 2          
and case when @tip_cod=7 then '0'        
   when @tip_cod=15 then cast(a.RCODTER as varchar(250))        
   when @tip_cod=14 then cast(a.RCODCOR as varchar(250))         
   when @tip_cod=13 then cast(a.RCODGRU as varchar(250))         
   when @tip_cod=11 then cast(a.RCODADM as varchar(250)) end= case when @tip_cod=7 then '0' else CAST(@cod_rel AS VARCHAR(250)) end      
group by a.RDESGRU , b.HCODVAR          
)          
          
SELECT cod_fec,RDESGRU, [100],[122],[126],[202],[165],[5006],[5001], null [0001],null [0002]  into #TabMetas FROM    --drop table #TabMetas select * from #TabMetas          
(SELECT cod_fec,RDESGRU, HCODVAR , HVALVAR FROM cte_meta )Tab1            
PIVOT            
(            
SUM(HVALVAR) FOR HCODVAR  IN ([100],[122],[126],[202],[165],[5006],[5001])) AS Tab2            
ORDER BY cod_fec          
          
select RDESGRU,'Meta Mes' as descrip, format(([100]),'N0','en-US') [100],       
format(([165]),'N0','en-US') [165], format(([5006]),'N0','en-US') [5006],      
FORMAT([126],'P')[126],FORMAT([122],'P') [122],format(([5001]),'N0','en-US') [5001],      
format(([0001]),'N0','en-US') [0001],format(([0002]),'N0','en-US') [0002],format(([202]),'N0','en-US')[202]        
from #TabMetas where RDESGRU='GRUPAL' --select * from #TabMetas          
union all          
select  descripcion,'Avance' as descrip, format(([100]),'N0','en-US') [100] ,       
format(([165]),'N0','en-US') [165],format(([5006]),'N0','en-US') [5006],FORMAT([126],'P')[126],      
FORMAT([122],'P') [122],format(([5001]),'N0','en-US') [5001],    
format(([0001]),'N0','en-US') [0001],format(([0002]),'N0','en-US') [0002] ,format(([202]),'N0','en-US') [202]    
from #DES  where descripcion='GRUPAL' --select * from #DES          
union all          
select a.descripcion,'% Avance' as descrip,           
     FORMAT((a.[100]/b.[100]),'P') as [100], cast(a.[165]/b.[165] as varchar(max)) as [165],          
    FORMAT((a.[5006]/b.[5006]),'P')  as [5006] , FORMAT((a.[126]/b.[126]),'P')  as [126] ,          
    FORMAT((a.[122]/b.[122]),'P') [122],CASE WHEN b.[5001] =0 THEN '0' ELSE FORMAT((a.[5001]/b.[5001]),'P') END as [5001],          
    cast(a.[0001]/b.[0001] as varchar(max)) [0001] ,  cast(a.[0002]/b.[0002] as varchar(max)) as [0002],          
   FORMAT((a.[202]/b.[202]),'P') as [202]         
          
from #DES a          
left join (select  * from #TabMetas  where RDESGRU='GRUPAL') b           
on a.descripcion=b.RDESGRU          
 where descripcion='GRUPAL'          
          
 end
