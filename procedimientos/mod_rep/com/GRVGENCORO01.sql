-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-02-29 12:37:39.153000
--EXEC MOD_REP.[com].[GRVGENCORO01] 7,'231','20240219','TODOS'  
CREATE  PROCEDURE [com].[GRVGENCORO01]    
 @tip_cod int,                                                                                          
 @cod_rel varchar(20),                                                                                      
 @fec date ,  
 @tip_age VARCHAR(250)     
AS  
BEGIN  
  SET NOCOUNT ON;        
--SCODAGR=7  
--SCODAGR=4  
--declare  @tip_cod int=7,@cod_rel varchar(250)='231',@fec varchar(250)='20240210',@tip_age varchar(250)='TODOS'  
--declare  @tip_cod int=15,@cod_rel varchar(250)='1',@fec varchar(250)='20240210',@tip_age varchar(250)='1'  
  
--drop table #FECS ,#R,#F,#R2,#F2  
   
  
declare @Fecha date    
set @Fecha=(SELECT  max(rfec) FROM [storage].[ref].[RCALEN001] WHERE (RFEC)<=@fec and RDIAFER=0)    
                        
select *  into #FECS  --drop table #FECS  select * from  #FECS                                   
from storage.util.FVECFEC01(@Fecha,'cmg_2,cie_ant+6,cie_ant+5,cie_ant+4,cie_ant+3,cie_ant+2,cie_ant,hoy')    
  
insert into #FECS    
select max(RFEC) from [storage].[ref].[RCALEN001] where rfec<=cast(DATEADD(MM, -1,@Fecha) as date) and RDIAFER=0    
    
alter table #FECS add RORDD int null    
    
update #FECS set RORDD=RORD    
update #FECS set RORDD=10 where RORDD=8      
update #FECS set RORDD=8 where RORDD=9       
update #FECS set RORDD=9 where RORDD=10     
  
  
update #FECS set RORDD=RORD    
  
  
  
declare @defs as rep.TTHCOLDEF                                                                            
 insert into @defs                                                                              
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values                                                                             
 (1,1,1,'DESCR','Descripción','string',null,'20px'),                                                                              
 (2,2,1,'1',(select cast(rfec as varchar(10)) from #FECS where RORDD=1),'number',null,null),                                                                              
 (3,3,1,'2',(select cast(rfec as varchar(10)) from #FECS where RORDD=2),'number',null,null),                                                                              
 (4,4,1,'3',(select cast(rfec as varchar(10)) from #FECS where RORDD=3),'number',null,null),                                     
                                 
 (5,5,1,'4',(select cast(rfec as varchar(10)) from #FECS where RORDD=4),'number',null,null),                                               
 (6,6,1,'5',(select cast(rfec as varchar(10)) from #FECS where RORDD=5),'number',null,null),                                               
 (7,7,1,'6',(select cast(rfec as varchar(10)) from #FECS where RORDD=6),'number',null,null),                                               
 (8,8,1,'7',(select cast(rfec as varchar(10)) from #FECS where RORDD=7),'number',null,null),                                               
 (9,9,1,'8',(select cast(rfec as varchar(10)) from #FECS where RORDD=8),'number',null,null),                                                
 (10,10,1,'9',(select cast(rfec as varchar(10)) from #FECS where RORDD=9),'number',null,null),                               
                                                                                        
 (11,11,1,'TFM','TFM','number',NULL,null),  
 (12,12,1,'TMM','TMM','number',NULL,null)          
  
    select rep.FFTHCOLDEF(@defs) result;           
   
declare @fecs varchar(max)   
 select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                           
from #FECS  
  
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                
  
insert into @tvars                
values ('mont_trx',null,null,null,null,null),  
       ('num_trx',null,null,null,null,null)             
               
insert into @tfil                
values                        
('todos','fec',@fecs)                
               
insert into @tconf                
values               
('level_alias','style') ,('fec_corr','true'),('insert_to','#R')              
  
 if @tip_age<>'TODOS'              
 begin    
 insert into @tfil                
 values('TODOS','tip_agen','"'+@tip_age+'"')  
 end  
              
     
declare @jer varchar(100)                
insert into @tfil                 
exec [piv].[GPIVLEV03] @tip_cod,@cod_rel,@jer output       
  
create table #R (fila int null,vars varchar(250)null,  
cod_agr_trx varchar(250)null,style int null,descripcion varchar(250)null,  
[1] float null,[2] float null,[3] float null ,  
[4] float null,[5] float null,   
[6] float null,[7] float null,[8] float null,[9] float null   
)  
  
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"vars","agr_trx"',@columns='"fec_corr"',@config=@tconf--,@show_query=1       
  
declare @var1Num float,@var2Num float,@var3Num float,@var4Num float,@var5Num float,@var6Num float,@var7Num float,@var8Num float,@var9Num float  
declare @var1Mont float,@var2Mont float,@var3Mont float,@var4Mont float,@var5Mont float,@var6Mont float,@var7Mont float,@var8Mont float,@var9Mont float  
  
select @var1Num=sum([1]),@var2Num=sum([2]),@var3Num=sum([3]),@var4Num=sum([4]),@var5Num=sum([5]),@var6Num=sum([6]),@var7Num=sum([7]),@var8Num=sum([8]),@var9Num=sum([9])    
from #R  
where vars='num_trx'  
  
select @var1Mont=sum([1]),@var2Mont=sum([2]),@var3Mont=sum([3]),@var4Mont=sum([4]),@var5Mont=sum([5]),@var6Mont=sum([6]),@var7Mont=sum([7]),@var8Mont=sum([8]),@var9Mont=sum([9])   
from #R  
where vars='mont_trx'  
  
;with cte_a as (  
select 'Num_trans_T' vars,0 cod_agr_trx,'N° Transacciones' descripcion,sum([1]) [1],sum([2]) [2],sum([3]) [3],sum([4]) [4],sum([5]) [5],sum([6])[6],sum([7])[7],sum([8])[8],sum([9])[9]  
from #R  
where vars='num_trx'  
union all  
select vars,cod_agr_trx,descripcion,[1],[2],[3],[4],[5],[6],[7],[8],[9]  
from #R  
where vars='num_trx'    
union all  
select vars,cod_agr_trx,'% '+descripcion descripcion,[1] / @var1Num ,[2]/@var2Num,[3]/@var3Num,[4]/@var4Num,[5]/@var5Num, [6] / @var6Num [6],[7]/ @var7Num [7],[8] / @var8Num [8],  
[9] / @var9Num [9]  
from #R  
where vars='num_trx'   
union all  
select 'Mont_trans_T' vars,0 cod_agr_trx,'Mto Transacciones' descripcion,sum([1]) [1],sum([2]) [2],sum([3]) [3],sum([4]) [4],sum([5]) [5],sum([6])[6],sum([7])[7],sum([8])[8],sum([9])[9]  
from #R  
where vars='mont_trx'  
union all  
select vars,cod_agr_trx,descripcion,[1],[2],[3],[4],[5],[6],[7],[8],[9]  
from #R  
where vars='mont_trx'   
union all  
select vars,cod_agr_trx,'% '+descripcion descripcion,[1] / @var1Mont ,[2]/@var2Mont,[3]/@var3Mont,[4]/@var4Mont,[5]/@var5Mont, [6] / @var6Mont [6],[7]/ @var7Mont [7],[8] / @var8Mont [8],  
[9] / @var9Mont [9]  
from #R  
where vars='mont_trx'   
union all  
select 'ticprom' vars,'999' cod_agr_trx,'Ticket Promedio por Transaccion' descripcion , @var1Num/@var1Mont , @var2Num /@var2Mont , @var3Num  /@var3Mont ,   
@var4Num  /@var4Mont, @var5Num / @var5Mont ,@var6Num / @var6Mont ,@var7Num /@var7Mont,@var8Num  /@var8Mont,@var9Num  /@var9Mont  
)   
select * into #F from cte_a  
    
   
DELETE FROM  @tvars WHERE TKEYVAR IN('mont_trx','num_trx')  
DELETE FROM @tconf WHERE TKEYPROP='insert_to'  
   
 insert into @tvars                
values ('num_ag_esta',null,null,null,null,null),  
('num_age_trx',null,null,null,null,null),  
('co_may_15',null,null,null,null,null)

 CREATE TABLE #R2  
 (  
 fila int null,  
 vars varchar(250)null,  
 cod_esta_corr varchar(250)null,  
 style int null,  
 descripcion varchar(250)null,  
 [1] float null,[2] float null,[3] float null ,  
[4] float null,[5] float null,   
[6] float null,[7] float null,[8] float null ,[9] float null   
 )  
  
 insert into @tconf                
values ('insert_to','#R2')            
   
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"vars","esta_corr"',@columns='"fec_corr"',@config=@tconf--,@show_query=1      
--drop table #FECS ,#R,#F,#R2,#F2  
   
  
;with cte_a as (  
select 'CI' cod_desc,'888' COD,'Corresponsales Instalados' DESCR,sum([1]) [1],sum([2])[2],sum([3])[3],sum([4])[4],sum([5])[5],sum([6])[6],sum([7])[7],sum([8])[8],sum([9])[9]  
from #R2   
where vars='num_ag_esta'  
union all  
select 'AACT','888','Agentes Activos',sum([1]),sum([2]),sum([3]),sum([4]),sum([5]),sum([6])[6],sum([7])[7],sum([8])[8],sum([9])[9]  
from #R2  
where descripcion='ACTIVO' and vars='num_ag_esta'  
UNION ALL  
SELECT 'ACTRX','888','Agentes con trx',sum([1]),sum([2]),sum([3]),sum([4]),sum([5]),sum([6])[6],sum([7])[7],sum([8])[8],sum([9])[9]  
from #R2  
where  vars='num_age_trx'  
),  
cte_b as (  
select 'ASTRX' cod_desc,'888' cod,'Agentes sin trx' DESCR ,sum(a.[1]) - sum(b.[1]) [1] ,sum(a.[2])- sum(b.[2]) [2],sum(a.[3]) - sum(b.[3]) [3],  
 sum(a.[4]) - sum(b.[4]) [4],sum(a.[5])- sum(b.[5]) [5],sum(a.[6]) - sum(b.[6]) [6],sum(a.[7])- sum(b.[7]) [7],sum(a.[8]) - sum(b.[8]) [8],  
 sum(a.[9]) - sum(b.[9]) [9]  
from cte_a a  
left join (select * from cte_a where cod_desc='ACTRX') b  
on 1=1  
where a.cod_desc='AACT'  
),  
cte_c as (  
select * from cte_a   
union all  
select * from cte_b  
union all  
select 'ACAN', '888','Agentes Cancelados',sum([1]),sum([2]),sum([3]),sum([4]),sum([5]),sum([6])[6],sum([7])[7],sum([8])[8],sum([9])[9]  
from #R2  
where descripcion='CANCELADO' and vars='num_ag_esta'  
union all
select 'AM15C','889','N° Agentes>=15',sum([1]),sum([2]),sum([3]),sum([4]),sum([5]),sum([6])[6],sum([7])[7],sum([8])[8],sum([9])[9]  
from #R2
where descripcion='ACTIVO' and vars='co_may_15'  
)  
select * into #F2 from cte_c  
  
;with cte_a as (  
select* from #F2   
union all  
select * from #F  
),  
cte_b as (  
select *,[9]-[7] 'TFM',[9]-[8] 'TMM' from cte_a  
)    
select    
 cod_desc,COD,DESCR,   
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([1],'P') else format([1],'N0') end [1],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([2],'P') else format([2],'N0') end [2],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([3],'P') else format([3],'N0') end [3],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([4],'P') else format([4],'N0') end [4],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([5],'P') else format([5],'N0') end [5],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([6],'P') else format([6],'N0') end [6],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([7],'P') else format([7],'N0') end [7],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([8],'P') else format([8],'N0') end [8],  
 case when DESCR in('% Pago Crédito','% Retiro','% Deposito','% Pago Servicio','% Giros','% Rendición Asesor')then format([9],'P') else format([9],'N0') end [9],  
 TFM,TMM,  
CASE WHEN cod_desc='CI' THEN 2   
     WHEN cod_desc='Num_trans_T' THEN 2  
  WHEN cod_desc='Mont_trans_T' THEN 2  
  when cod_desc='ticprom' then 2  
  ELSE NULL END style  
  
  
from cte_b  
  
--drop table #FECS ,#R,#F,#R2,#F2  
   
END
