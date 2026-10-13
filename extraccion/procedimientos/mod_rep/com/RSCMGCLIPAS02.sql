-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-04-11 12:04:49.580000
--EXEC MOD_REP.[com].[RSCMGCLIPAS02] 7,'231','20240410','Clientes'
--@agru = Clientes  ,   Cuentas  , Saldo
CREATE procedure [com].[RSCMGCLIPAS02]                   
@tip_cod int, @cod_rel varchar(10),@fec date --,@agru varchar(250)                   
----------------------------------------------------------------------------------                    
as                    
begin                    
SET NOCOUNT ON;              
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20240313'                   
          
          
---> OBTIENE FECHAS PARA CMG                
declare @fecs varchar(max)                    
 select *                    
 into #FECS        
 from storage.util.FVECFEC01(@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')                 
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
          
     
   select * into #FECR from  --select * from #FECR
   storage.util.FVECFEC01(@fec,'cmg_1,cmg_4,cmg_5,cmg_6') 

 ;with cte_a as (
 select b.RORD,a.* 
 from storage.com_pas.WJAS002 a
 inner join #FECR b  --select * from #FECR
 on a.HFECPRO=b.RFEC
 where a.HTIPCOD=7 and a.HCODREL='231'
 ),
 cte_b as (
 select RORD,HFECPRO,HTIPCOD,HCODREL,valColumn,variables
 from cte_a
 unpivot(
 variables
 for valColumn in(HTOTCLI,HNUMCLIFEME,HNUMCLIRUR,HNUMCLIINMI)
 )u
 ) 
 ,
 cte_c as (
 select RORD,HFECPRO,HTIPCOD,HCODREL,
 case when valColumn='HTOTCLI' then 1 
	  when valColumn='HNUMCLIFEME' then 2 
	  when valColumn='HNUMCLIINMI' then 3
	  when valColumn='HNUMCLIRUR' then 4
  end ord_column,valColumn
  ,variables
 from cte_b
 union all
 select a.RORD,a.HFECPRO,a.HTIPCOD,a.HCODREL,5,'percent_'+a.valColumn ,cast(a.variables as float)/b.variables
 from cte_b a
 inner join (select * from cte_b where valColumn='HTOTCLI')b
 on a.HTIPCOD=b.HTIPCOD and a.RORD=b.RORD
 where a.valColumn<>'HTOTCLI'
 )
 select * into #Preresult from cte_c
  order by 1 asc,ord_column  asc
   
  ;WITH CTE_A AS (
  select ord_column,valColumn, [1],[2],[3],[4] 
  from 
  (
  select ord_column,valColumn,VARIABLES,rord
  from #Preresult
  ) as s
  PIVOT
  (
   SUM(VARIABLES)
   FOR RORD IN([1],[2],[3],[4])
  ) AS P 
 )
 SELECT 
	case when ord_column=1 then 1 else 0 end style, 
 ord_column , 
    case when valColumn='HTOTCLI' then 'Total Clientes'
		 when valColumn='HNUMCLIFEME' then 'Mujeres'
		 when valColumn='HNUMCLIINMI' then 'Migrantes'
		 when valColumn='HNUMCLIRUR' then 'Rural'
		 when valColumn='percent_HNUMCLIFEME' then '% Mujeres'
		 when valColumn='percent_HNUMCLIINMI' then '% Migrantes'
		 when valColumn='percent_HNUMCLIRUR' then '% Rural'
	end descripcion
    ,
    CASE WHEN valColumn IN('HTOTCLI','HNUMCLIFEME','HNUMCLIINMI','HNUMCLIRUR') THEN FORMAT([1],'N0') ELSE FORMAT([1],'P') END [1],
    CASE WHEN valColumn IN('HTOTCLI','HNUMCLIFEME','HNUMCLIINMI','HNUMCLIRUR') THEN FORMAT([2],'N0') ELSE FORMAT([2],'P') END [2],
    CASE WHEN valColumn IN('HTOTCLI','HNUMCLIFEME','HNUMCLIINMI','HNUMCLIRUR') THEN FORMAT([3],'N0') ELSE FORMAT([3],'P') END[3],
    CASE WHEN valColumn IN('HTOTCLI','HNUMCLIFEME','HNUMCLIINMI','HNUMCLIRUR') THEN FORMAT([4],'N0') ELSE FORMAT([4],'P') END[4],
    CASE WHEN valColumn IN('HTOTCLI','HNUMCLIFEME','HNUMCLIINMI','HNUMCLIRUR') THEN FORMAT(([4]-[2]),'N0') ELSE FORMAT(([4]-[2])*10000,'N0') END  TMM, 
    CASE WHEN valColumn IN('HTOTCLI','HNUMCLIFEME','HNUMCLIINMI','HNUMCLIRUR') THEN FORMAT(([4]-[1]),'N0') ELSE FORMAT(([4]-[1])*10000,'N0') END  TAM
  
 FROM CTE_A ORDER BY ord_column ASC
    
end
