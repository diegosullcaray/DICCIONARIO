-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-04-15 15:19:39.830000
--EXEC MOD_REP.[com].[RSCMGCLIPAS01] 7,'231','20240318','Clientes'
--@agru = Clientes  ,   Cuentas  , Saldo
CREATE procedure [com].[RSCMGCLIPAS01]                   
@tip_cod int, @cod_rel varchar(10),@fec date ,@agru varchar(250)                   
----------------------------------------------------------------------------------                    
as                    
begin                    
SET NOCOUNT ON;              
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20240313'                   
          
          
---> OBTIENE FECHAS PARA CMG                
declare @fecs varchar(max)                    
 select *                    
 into #FECS     -- drop table #FECS    select * from   #FECS           
 from storage.util.FVECFEC01(@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')     
 --from storage.util.FVECFEC01(@fec,'cmg_1,cmg_4,cmg_5,cmg_6')                    
--concatena las fechas en 1 registro separado por (,)                
select @fecs=string_agg(convert(varchar(10),RFEC,112),',') from #FECS         
     
     
 declare @fecha1 as date, @fecha2 as date, @fecha3 as date, @fecha4 as date, @fecha5 as date , @fecha6 as date                
 select @fecha1 = RFEC from  #FECS  where RORD=1              
 select @fecha2 = RFEC from  #FECS  where RORD=2              
 select @fecha3 = RFEC from  #FECS  where RORD=3              
 select @fecha4 = RFEC from  #FECS  where RORD=4              
 select @fecha5 = RFEC from  #FECS  where RORD=5              
 select @fecha6 = RFEC from  #FECS  where RORD=6     
    
 declare @defs as rep.TTHCOLDEF;                
                
  insert into @defs                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN)  values                 
              
 (0,1,1,'descripcion','Variable (en miles PEN, %, y número)',NULL,2,1,'string',null,null),               
 (1,null,1,'2021',format(@fecha1,'yyyy'),1,1,NULL,NULL,null,null),    
  (2,null,1,'2022',format(@fecha6,'yyyy'),3,1,NULL,NULL,null,null),                 
    
 --(3,8,1,'col_7','META',1,2,NULL,'number',null,null),               
 (4,9,1,'col_8',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),               
 (5,10,1,'TMM','TMM',2,2,NULL,'number',null,null),              
 (6,11,1,'col_10',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),               
 (7,12,1,'TAM','TAM',2,2,NULL,'number',null,null),               
 --(8,13,1,'col_12',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),               
 --(9,14,1,'col_13','Distancia Meta',2,2,NULL,'number',null,null),               
              
 (10,2,2,'1',format(@fecha1,'dd-MMM'),null,null,null,'number',null,null),               
 --(11,3,2,'col_2',format(@fecha2,'dd-MMM'),null,null,null,'number',null,null),               
 --(12,4,2,'col_3',format(@fecha3,'dd-MMM'),null,null,null,'number',null,null),               
 (13,5,2,'2',format(@fecha4,'dd-MMM'),null,null,null,'number',null,null),               
 (14,6,2,'3',format(@fecha5,'dd-MMM'),null,null,null,'number',null,null),               
 (15,7,2,'4',format(@fecha6,'dd-MMM'),null,null,null,'number',null,null)              
              
   select rep.FFTHCOLDEF(@defs) result;                  
          
    
 select * ,ROW_NUMBER() OVER(ORDER BY rfec ASC) AS RORD2 INTO    #FECS1               -- drop table #FECS1 ,#F_P  select * from  #FECS1
 --from storage.util.FVECFEC01(@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')   
 from storage.util.FVECFEC01(@fec,'cmg_1,cmg_4,cmg_5,cmg_6') 
   
 CREATE TABLE #F_P (rord int null,RFEC date null,RFECPRO date null,rord2 int null)

 update #FECS1 set RORD2=6 where rord=4
 update #FECS1 set RORD2=4 where rord=2
 update #FECS1 set RORD2=5 where rord=3

 DECLARE @II INT=1,@FF INT,@FECC DATE
  SET @FF=(SELECT MAX(RORD) FROM #FECS1)
  WHILE @II<=@FF
  BEGIN
   SET @FECC=(SELECT RFEC FROM #FECS1 WHERE RORD=@II)

   ;with cte_a as (
	select  RFEC   from storage.[util].[FVECFEC01](@FECC,'cmg_4,cmg_6')                
	union all
	select RFEC from storage.ref.RCALEN001 where RCIEBT=1 and rfec between cast(DATEADD(yy, DATEDIFF(yy, 0, @FECC), 0) as date) and eomonth(@FECC,-1)
	) 
	,
	cte_b as (
	select distinct rfec from cte_a 
	)
	insert into #F_P
	select  
	@II,rfec,@FECC fec_proc,@II  
	from cte_b   --drop table #f  

    SET @II=@II+1
  END


   update #F_P set RORD2=6 where rord=4
   update #F_P set RORD2=4 where rord=2
   update #F_P set RORD2=5 where rord=3

  


    
	declare @fecs1 varchar(max) 
	select @fecs1=string_agg(convert(varchar(10),RFEC,112),',')                         
	from #F_P

	declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF       
	
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
values ('mig_rur_cta_mig',null,null,null,null,null)   ,
       ('mig_rur_cta_rur',null,null,null,null,null) ,
	   ('mig_rur_cta_fem',null,null,null,null,null) ,
	   ('mig_rur_cta_total',null,null,null,null,null) 
 end

if @agru='Saldo'            
 begin
  insert into @tvars  
values ('mig_rur_SAL_mig',null,null,null,null,null)   ,
       ('mig_rur_SAL_rur',null,null,null,null,null) ,
	   ('mig_rur_SAL_fem',null,null,null,null,null) ,
	   ('mig_rur_SAL_total',null,null,null,null,null) 
 end
              
insert into @tfil              
values                      
('todos','fec',@fecs1)              
             
insert into @tconf              
values              
('level_alias','style') ,('fec_corr','true') 

 
       
	    
   
declare @jer varchar(100)              
insert into @tfil               
exec [piv].[GPIVLEV03] @tip_cod,@cod_rel,@jer output     
 
create table #Pre (
fila int null,cod_fec varchar(250)null,style int null,descripcion date null,
mig_rur_cli_mig float null,mig_rur_cli_rur float null,mig_rur_cli_fem float null,mig_rur_total float null)
 
insert into #Pre
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf--,@show_query=1    
--exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1     

 select b.*,a.RFECPRO,a.rord 
 into #Base --drop table #Base
 from #F_P a  --select * from #F_P
 left join #Pre b
 on a.RFEC=b.descripcion 
 
 ;WITH CTE_F AS (
 SELECT DISTINCT rord,RFECPRO FROM #F_P
 ),
 CTE_B AS (
 SELECT DISTINCT 'Clientes Nuevos del Pasivo (Nro)' descr, B.rord,DESCRIPCION,
 mig_rur_cli_mig,mig_rur_cli_rur,mig_rur_cli_fem,mig_rur_total,
 mig_rur_cli_mig/mig_rur_total Percent_Mig,mig_rur_cli_rur/mig_rur_total Percent_Rur,mig_rur_cli_fem/mig_rur_total  Percent_Muj
 FROM #BASE A 
 INNER JOIN CTE_F B 
 ON  A.descripcion=B.RFECPRO 
 ),
 cte_final_ as (
 SELECT * FROM CTE_B
 UNION ALL
 select 'Clientes Nuevos del Año' descr,rord,rfecpro,
 sum(mig_rur_cli_mig)mig_rur_cli_mig,sum(mig_rur_cli_rur)mig_rur_cli_rur,sum(mig_rur_cli_fem)mig_rur_cli_fem,sum(mig_rur_total)mig_rur_total, 
 sum(mig_rur_cli_mig)/sum(mig_rur_total) Percent_Mig,sum(mig_rur_cli_rur) /sum(mig_rur_total)Percent_Rur,
 sum(mig_rur_cli_fem) /sum(mig_rur_total)Percent_Muj 
 from #Base
 group by rord,rfecpro
  ),
 cte_final__ as (
  SELECT descr,rord, des_column, valor
FROM
(SELECT descr,rord,
mig_rur_cli_mig, mig_rur_cli_rur, mig_rur_cli_fem,mig_rur_total,Percent_Mig,Percent_Rur,Percent_Muj
FROM cte_final_) stu
UNPIVOT
(valor FOR des_column IN (mig_rur_cli_mig, mig_rur_cli_rur, mig_rur_cli_fem,mig_rur_total,Percent_Mig,Percent_Rur,Percent_Muj)
) AS mrks
),
cte_bb as (
----------
SELECT style,descr, des_column,  
    [1], [2], [3], [4]  
FROM  
(
  SELECT 
  case when descr='Clientes Nuevos del Pasivo (Nro)' and des_column='mig_rur_total' then 1 
	          when descr='Clientes Nuevos del Año'  and des_column='mig_rur_total' then 1 else 0 end style,
  descr,
  case when descr='Clientes Nuevos del Pasivo (Nro)' and des_column='mig_rur_total' then '0_Clientes Nuevos del Pasivo (Nro)'
	   when descr='Clientes Nuevos del Año' and des_column='mig_rur_total' then '0_Clientes Nuevos del Año'
	   when des_column='mig_rur_cli_fem' then '1_Mujer'
	   when des_column='mig_rur_cli_rur' then '2_Rural'
	   when des_column='mig_rur_cli_mig' then '3_Migrante'
	   
	   when des_column='Percent_Muj' then '4_% Clientes Mujer'
	   when des_column='Percent_Rur' then '5_% Clientes Rural'
	   when des_column='Percent_Mig' then '6_% Clientes Migrante'
	   end des_column  ,
  valor, rord   
  FROM cte_final__
) AS SourceTable  
PIVOT  
(  
  sum(valor)  
  FOR rord IN ( [1], [2], [3], [4])  
) AS PivotTable
)
select * into #T__ from cte_bb order by descr desc
  

select style, REPLACE(des_column,left(des_column,2),'') descripcion,des_column,
case when des_column like '%_[%] Clientes%' then format([1],'P') else  format([1],'N0') end  [1],
case when des_column like '%_[%] Clientes%' then format([2],'P') else  format([2],'N0') end [2],
case when des_column like '%_[%] Clientes%' then format([3],'P') else  format([3],'N0') end [3],
case when des_column like '%_[%] Clientes%' then format([4],'P') else  format([4],'N0') end [4],
case when des_column like '%_[%] Clientes%' then concat(format(([4] - [2])*10000,'N0'),' pbs') else  format(([4] - [2]),'N0') end TMM , 
case when des_column like '%_[%] Clientes%' then concat(format(([4] - [1])*10000,'N0'),' pbs') else  format(([4] - [1]),'N0') end TAM
from #T__ 
order by descr desc,des_column  asc   --select * from #T__
    
    
end
