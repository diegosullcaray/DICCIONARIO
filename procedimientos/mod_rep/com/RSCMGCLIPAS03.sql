-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-04-16 14:21:43.987000
--EXEC MOD_REP.[com].[RSCMGCLIPAS03] 7,'231','20240413','Clientes','Nuevo'
--@agru = Clientes  ,   Cuentas  , Saldo
CREATE procedure [com].[RSCMGCLIPAS03]                   
@tip_cod int, @cod_rel varchar(10),@fec date ,@agru varchar(250), @grupo varchar(250)
---------------------------------
as                    
begin                    
SET NOCOUNT ON;  
--declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20240413' , @agru varchar(250)='Clientes',@grupo varchar(250)='Anual'--'Nuevo','Anual'   

---> OBTIENE FECHAS PARA CMG                  
declare @fecs varchar(max)                      
 select *                      
 into #FECS     -- drop table #FECS    select * from   #FECS             
 from storage.util.FVECFEC01(@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')              
select @fecs=string_agg(convert(varchar(10),RFEC,112),',') from #FECS           
         
declare @fecs1 varchar(max)   

 declare @fecha1 as date, @fecha2 as date, @fecha3 as date, @fecha4 as date, @fecha5 as date , @fecha6 as date                
 select @fecha1 = RFEC from  #FECS  where RORD=1              
 select @fecha2 = RFEC from  #FECS  where RORD=2              
 select @fecha3 = RFEC from  #FECS  where RORD=3              
 select @fecha4 = RFEC from  #FECS  where RORD=4              
 select @fecha5 = RFEC from  #FECS  where RORD=5              
 select @fecha6 = RFEC from  #FECS  where RORD=6   

declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF    
declare @jer varchar(100) 

declare @defs as rep.TTHCOLDEF; 
insert into @defs                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN)  values                 
              
 (0,1,1,'descripcion','Variable (en miles PEN, %, y número)',NULL,2,1,'string',null,null),               
 (1,null,1,'2021',format(@fecha1,'yyyy'),3,1,NULL,NULL,null,null),    
  (2,null,1,'2022',format(@fecha6,'yyyy'),3,1,NULL,NULL,null,null),                 
     
 (9,8,1,'TMM','TMM',2,2,NULL,'number',null,null),                            
 (10,9,1,'TAM','TAM',2,2,NULL,'number',null,null),             
              
 (3,2,2,'1',format(@fecha1,'dd-MMM'),null,null,null,'number',null,null),                         
 (4,3,2,'2',format(@fecha2,'dd-MMM'),null,null,null,'number',null,null),               
 (5,4,2,'3',format(@fecha3,'dd-MMM'),null,null,null,'number',null,null),               
 (6,5,2,'4',format(@fecha4,'dd-MMM'),null,null,null,'number',null,null),  
 (7,6,2,'4',format(@fecha5,'dd-MMM'),null,null,null,'number',null,null),
 (8,7,2,'4',format(@fecha6,'dd-MMM'),null,null,null,'number',null,null)            
              
   select rep.FFTHCOLDEF(@defs) result;   

create table #RTD(
style int null,vars varchar(250)null,descripcion varchar(250)null 
)
insert into #RTD values(1,'HFEMTD','Mujer')
insert into #RTD values(0,'mig_rur_cli_fem_Ahorro Comúm','- Ahorro Comúm')
insert into #RTD values(0,'mig_rur_cli_fem_Ahorro Digital','- Ahorro Digital')
insert into #RTD values(0,'mig_rur_cli_fem_Ahorro Programado','- Ahorro Programado')
insert into #RTD values(0,'mig_rur_cli_fem_CTS','- CTS')
insert into #RTD values(0,'mig_rur_cli_fem_DPF','- DPF')
insert into #RTD values(0,'mig_rur_cli_fem_Otros','- Otros')
--------------------------------------------------------------------------
insert into #RTD values(1,'HRURTD','Rural')
insert into #RTD values(0,'mig_rur_cli_rur_Ahorro Comúm','- Ahorro Comúm')
insert into #RTD values(0,'mig_rur_cli_rur_Ahorro Digital','- Ahorro Digital')
insert into #RTD values(0,'mig_rur_cli_rur_Ahorro Programado','- Ahorro Programado')
insert into #RTD values(0,'mig_rur_cli_rur_CTS','- CTS')
insert into #RTD values(0,'mig_rur_cli_rur_DPF','- DPF')
insert into #RTD values(0,'mig_rur_cli_rur_Otros','- Otros')
--------------------------------------------------------------------------
insert into #RTD values(1,'HMIGTD','Migrante')
insert into #RTD values(0,'mig_rur_cli_mig_Ahorro Comúm','- Ahorro Comúm')
insert into #RTD values(0,'mig_rur_cli_mig_Ahorro Digital','- Ahorro Digital')
insert into #RTD values(0,'mig_rur_cli_mig_Ahorro Programado','- Ahorro Programado')
insert into #RTD values(0,'mig_rur_cli_mig_CTS','- CTS')
insert into #RTD values(0,'mig_rur_cli_mig_DPF','- DPF')
insert into #RTD values(0,'mig_rur_cli_mig_Otros','- Otros')

if @grupo='Nuevo'
begin
select @fecs1=string_agg(convert(varchar(10),RFEC,112),',')                           
from #FECS  
  

 if @agru='Clientes'              
 begin           
insert into @tvars                
values ('mig_rur_cli_mig',null,null,null,null,null)   ,  
       ('mig_rur_cli_rur',null,null,null,null,null) ,  
    ('mig_rur_cli_fem',null,null,null,null,null) ,  
    ('mig_rur_total',null,null,null,null,null)   
  end  
if @agru='Cuentas'              
 begin  
 insert into @tvars                
values ('mig_rur_cta_mig',null,'mig_rur_cli_mig',null,null,null)   ,  
       ('mig_rur_cta_rur',null,'mig_rur_cli_rur',null,null,null) ,  
    ('mig_rur_cta_fem',null,'mig_rur_cli_fem',null,null,null) ,  
    ('mig_rur_cta_total',null,'mig_rur_total',null,null,null)   
 end  
  
if @agru='Saldo'              
 begin  
  insert into @tvars    
values ('mig_rur_SAL_mig',null,'mig_rur_cli_mig',null,null,null)   ,  
       ('mig_rur_SAL_rur',null,'mig_rur_cli_rur',null,null,null) ,  
    ('mig_rur_SAL_fem',null,'mig_rur_cli_fem',null,null,null) ,  
    ('mig_rur_SAL_total',null,'mig_rur_total',null,null,null)   
 end  
                
insert into @tfil                
values                        
('todos','fec',@fecs1)                
               
insert into @tconf                
values                
('level_alias','style') ,('fec_corr','true')  ,  ('insert_to','#TD')
   
               
insert into @tfil                 
exec [piv].[GPIVLEV03] @tip_cod,@cod_rel,@jer output       
   
create table #TD (  
fila int null,vars varchar(250)null,cod_prod_capt_mig varchar(250) null, style int null,descripcion varchar(250) null,  
[1] float null,[2] float null,[3] float null,[4] float null,[5] float null,[6] float null
)  
    
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"vars","prod_capt_mig"',@columns='"fec_corr"',@config=@tconf--,@show_query=1   



;with cte_a as (
select 'HFEMTD' vars,sum([1])[1],sum([2])[2],sum([3])[3],sum([4])[4],sum([5])[5],sum([6])[6]
from #TD
where vars='mig_rur_cli_fem'
union all
select 'HMIGTD',sum([1])[1],sum([2])[2],sum([3])[3],sum([4])[4],sum([5])[5],sum([6])[6]
from #TD
where vars='mig_rur_cli_mig'
union all
select 'HRURTD',sum([1])[1],sum([2])[2],sum([3])[3],sum([4])[4],sum([5])[5],sum([6])[6]
from #TD
where vars='mig_rur_cli_rur'
union all
select vars+'_'+cod_prod_capt_mig as vars,[1],[2],[3],[4],[5],[6] from  #TD
),
cte_b as (
select a.*,[1],[2],[3],[4],[5],[6] 
from #RTD a
left join (select * from cte_a) b
on a.vars=b.vars
)
select  * , [6]-[4] TMM,[6] - [1] TAM
from cte_b
  
--drop table #FECS,#TD,#RTD--,#FECS1,#F_P

end
if @grupo='Anual'
begin

 CREATE TABLE #F_P (rord int null,RFEC date null,RFECPRO date null,rord2 int null) 
 DECLARE @II INT=1,@FF INT,@FECC DATE  
 SET @FF=(SELECT MAX(RORD) FROM #FECS) 

 WHILE @II<=@FF
 BEGIN
	SET @FECC=(SELECT RFEC FROM #FECS WHERE RORD=@II)
	
	;with cte_a as (  
		select  RFEC   from storage.[util].[FVECFEC01](@FECC,'cmg_4,cmg_6')                  
		union all  
		select RFEC from storage.ref.RCALEN001 where RCIEBT=1 and rfec between cast(DATEADD(yy, DATEDIFF(yy, 0, @FECC), 0) as date) and eomonth(@FECC,-1)  
	),
	cte_b as (  
		select distinct rfec from cte_a   
	) 
	insert into #F_P  
	select @II,rfec,@FECC fec_proc,@II    
	from cte_b   
  
    SET @II=@II+1     
 END  
  
  select @fecs1=string_agg(convert(varchar(10),RFEC,112),',')                           
  from #F_P  
   
  if @agru='Clientes'              
  begin           
	insert into @tvars                
	values ('mig_rur_cli_mig',null,null,null,null,null)   ,  
		   ('mig_rur_cli_rur',null,null,null,null,null) ,  
		   ('mig_rur_cli_fem',null,null,null,null,null) ,  
		   ('mig_rur_total',null,null,null,null,null)   
  end  
  if @agru='Cuentas'              
  begin  
	insert into @tvars                
	values ('mig_rur_cta_mig',null,'mig_rur_cli_mig',null,null,null)   ,  
		   ('mig_rur_cta_rur',null,'mig_rur_cli_rur',null,null,null) ,  
		   ('mig_rur_cta_fem',null,'mig_rur_cli_fem',null,null,null) ,  
		   ('mig_rur_cta_total',null,'mig_rur_total',null,null,null)   
 end  
  
 if @agru='Saldo'              
 begin  
  insert into @tvars    
	values ('mig_rur_SAL_mig',null,'mig_rur_cli_mig',null,null,null)   ,  
		   ('mig_rur_SAL_rur',null,'mig_rur_cli_rur',null,null,null) ,  
		   ('mig_rur_SAL_fem',null,'mig_rur_cli_fem',null,null,null) ,  
		   ('mig_rur_SAL_total',null,'mig_rur_total',null,null,null)   
 end  
                
insert into @tfil                
values                        
('todos','fec',@fecs1)                
               
insert into @tconf                
values                
('level_alias','style') ,('fec_corr','true') ,  ('insert_to','#TA')
   
               
insert into @tfil                 
exec [piv].[GPIVLEV03] @tip_cod,@cod_rel,@jer output       
    
create table  #TA (
fila int null,cod_prod_capt_mig varchar(250)null,cod_fec varchar(250)null,style int null,descripcion varchar(250)null,mig_rur_cli_mig float null,mig_rur_cli_rur float null,mig_rur_cli_fem float null,mig_rur_total float null
)   
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"prod_capt_mig","fec"',@columns='"vars"',@config=@tconf--,@show_query=1   

;with cte_a as (
select a.rord,a.RFECPRO,b.cod_prod_capt_mig,b.mig_rur_cli_fem,b.mig_rur_cli_mig,b.mig_rur_cli_rur 
from #F_P a 
inner join #TA b
on a.rfec=b.cod_fec 
),
cte_b as (
select rord,cod_prod_capt_mig,sum(mig_rur_cli_fem)mig_rur_cli_fem,sum(mig_rur_cli_mig)mig_rur_cli_mig,sum(mig_rur_cli_rur)mig_rur_cli_rur
from cte_a
group by rord,cod_prod_capt_mig
),
cte_c as (
select rord,cod_prod_capt_mig,des_column, valor
from
(
  select rord,cod_prod_capt_mig,mig_rur_cli_fem,mig_rur_cli_mig,mig_rur_cli_rur 
  from cte_b ) s
  unpivot
  (
   valor FOR des_column in(mig_rur_cli_fem,mig_rur_cli_mig,mig_rur_cli_rur)
  ) as mrks
),
cte_d as (
select cod_prod_capt_mig,des_column,[1],[2],[3],[4],[5],[6] 
from 
(
	select cod_prod_capt_mig,des_column,valor, rord
	from cte_c 
) as SourceTable
pivot
(
 sum(valor)
 for rord in([1],[2],[3],[4],[5],[6])
)AS PivotTable
),
cte_e as (
select 'HFEMTD' vars,sum([1])[1],sum([2])[2],sum([3])[3],sum([4])[4],sum([5])[5],sum([6])[6]
from cte_d
where des_column='mig_rur_cli_fem'
union all
select 'HMIGTD',sum([1])[1],sum([2])[2],sum([3])[3],sum([4])[4],sum([5])[5],sum([6])[6]
from cte_d
where des_column='mig_rur_cli_mig'
union all
select 'HRURTD',sum([1])[1],sum([2])[2],sum([3])[3],sum([4])[4],sum([5])[5],sum([6])[6]
from cte_d
where des_column='mig_rur_cli_rur'
union all
select des_column+'_'+cod_prod_capt_mig as vars,[1],[2],[3],[4],[5],[6] from  cte_d
),
cte_f as (
select a.*,[1],[2],[3],[4],[5],[6] 
from #RTD a
left join (select * from cte_e) b
on a.vars=b.vars
)
select  * , [6]-[4] TMM,[6] - [1] TAM
from cte_f

 
 -- drop table #F_P,#FECS ,#TA,#RTD
end
 


END
