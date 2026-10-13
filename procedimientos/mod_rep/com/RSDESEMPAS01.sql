-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-03-14 15:39:45.743000
 
CREATE procedure [com].[RSDESEMPAS01]               
@tip_cod int, @cod_rel varchar(10),@fec date                
----------------------------------------------------------------------------------                
as                
begin                
SET NOCOUNT ON;          
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20220917'               
      
      
---> OBTIENE FECHAS PARA CMG            
declare @fecs varchar(max)                
 select *                
 into #FECS     -- drop table #FECS    select * from   #FECS       
 from storage.util.FVECFEC01(@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')                
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
          
 (0,1,1,'DESVAL','Variable (en miles PEN, %, y número)',NULL,2,1,'string',null,null),           
 (1,null,1,'2021',format(@fecha1,'yyyy'),1,1,NULL,NULL,null,null),           
 (2,null,1,'2022',format(@fecha6,'yyyy'),3,1,NULL,NULL,null,null),           
 --(3,8,1,'col_7','META',1,2,NULL,'number',null,null),           
 (4,9,1,'col_8',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),           
 (5,10,1,'col_9','TMM',2,2,NULL,'number',null,null),          
 (6,11,1,'col_10',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),           
 (7,12,1,'col_11','TAM',2,2,NULL,'number',null,null),           
 --(8,13,1,'col_12',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),           
 --(9,14,1,'col_13','Distancia Meta',2,2,NULL,'number',null,null),           
          
 (10,2,2,'col_1',format(@fecha1,'dd-MMM'),null,null,null,'number',null,null),           
 --(11,3,2,'col_2',format(@fecha2,'dd-MMM'),null,null,null,'number',null,null),           
 --(12,4,2,'col_3',format(@fecha3,'dd-MMM'),null,null,null,'number',null,null),           
 (13,5,2,'col_4',format(@fecha4,'dd-MMM'),null,null,null,'number',null,null),           
 (14,6,2,'col_5',format(@fecha5,'dd-MMM'),null,null,null,'number',null,null),           
 (15,7,2,'col_6',format(@fecha6,'dd-MMM'),null,null,null,'number',null,null)          
          
   select rep.FFTHCOLDEF(@defs) result;              
      

/*resultados sin API*/                
;with                
 cte_a as(    
 -- select top 10 * from storage.com_act.WJAS001  
 -- select top 10 * from storage.com_pas.Wacli007    
          
  select B.RORD fila, B.RFEC descripcion,               
   cast(A.HTOTCLI as float) [10100],  
   cast(A.HFEMCLI as float) [10101], 
   cast(A.HRURCLI as float) [10102], 
   cast(A.HMIGCLI as float) [10103], 
   case when (A.HFEMCLI) > 0 then A.HFEMCLI/cast((A.HTOTCLI) as float) else 0 end [10104], --% Clientes Mujer    
   case when (A.HRURCLI) > 0 then A.HRURCLI/cast((A.HTOTCLI) as float) else 0 end [10105], --% Clientes Rural    
   case when (A.HMIGCLI) > 0 then A.HMIGCLI/cast((A.HTOTCLI) as float) else 0 end [10106] --% Clientes Migrante           
  from storage.com_pas.Wacli007  A     --where HFECPRO = '2021-04-22' and  HTIPCOD=7 and HCODREL = '231'    
  join #FECS B               
     on  A.HFECPRO=B.RFEC                
     where A.HTIPCOD=@tip_cod and A.HCODREL=@cod_rel   --select * from #FECS            
    )    
-->LA DATA DE CLIENTE LA CRUZA POR LAS FECHAS PARA EL CMG    
select *  into    #ACUM000     --SELECT * FROM #ACUM000            
    from    #FECS A                
    left join cte_a B                
    on   A.RORD=B.fila and A.RFEC=B.descripcion      
    
--pivotea el resultado por las variables de meta    
select * into #ACUM00 from #ACUM000 unpivot (valores for variables in( [10100],[10101],[10102],[10103],[10104],[10105],[10106])) UNPVT         


-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20220917'                
-->COLOCANDO LOS RESULTADOS DE LAS METAS               
select  RORD,variables,valores                
    into    #RESULTPRE     -- select * from #RESULTPRE     drop table #RESULTPRE          
    from    #ACUM00                
    UNION                
    select 7 FORD, B.HCODVAR, B.HVALVAR                
    FROM    #ACUM00 A                
        LEFT join [storage].[com].[VDMCOM01] B     --SELECT* FROM [storage].[com].[VDMCOM01]            
        on A.variables= B.HCODVAR                
            and B.HTIPMETA = 1                
            and B.HFECPRO = eomonth(@fec)                
            and B.HTIPCOD = @tip_cod                
            and B.HCODREL = @cod_rel                
    

select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                
    into #AAA                
    from #RESULTPRE -- select*from    #AAA       drop table   #AAA        
    UNION ALL                
  select  case when concat(A.RORD,'-',B.RORD) = '6-4' then 9                
        when concat(A.RORD,'-',B.RORD) = '6-1' then 11                
        when concat(A.RORD,'-',B.RORD) = '6-7' then 13 end RORD                
        ,A.variables,     
  util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(10104,10105,10106),1,null)) SVALOR                 
  from #RESULTPRE A --select*from #RESULTPRE                
        join #RESULTPRE B                
        on A.variables=B.variables                
  where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')             
        UNION ALL                
   select  case when concat(A.RORD,'-',B.RORD) ='6-4' then 8                
            when concat(A.RORD,'-',B.RORD) ='6-1' then 10                
            when concat(A.RORD,'-',B.RORD) ='6-7' then 12 end RORD                
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR    
   from #RESULTPRE A                
   join #RESULTPRE B                
   on A.variables=B.variables                
   where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                
 
--pivotenado los resultados              
select *                
 into #RES  --drop table #RES  select*from #RES                           
 from #AAA pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])) PVT                
    
    
-->CREAMOS LA TABLA A PUBLICAR           
create table #CMG      --drop table   #CMG          
(   RDESVAR varchar(250),                
    RCODVAR int                
)            
insert into #CMG             
values     
 ('Clientes Nuevos del Pasivo (Nro)', 10100),             
 ('  Mujer', 10101), 
 ('  Rural', 10102),  
 ('  Migrante', 10103),    
 ('  % Clientes Mujer',10104), 
 ('  % Clientes Rural ',10105),                      
 ('  % Clientes Migrante ',10106)   



select     
 CASE      
  WHEN A.RCODVAR in (10100)     
  THEN 1 ELSE     
   CASE WHEN A.RCODVAR in (10104,10105,10106)     
   THEN 5 ELSE    
   0 END     
  END AS STYLE,    
 A.RDESVAR as DESVAL, [1] as col_1, [2] as col_2, [3] as col_3, [4] as col_4, [5] as col_5, [6] as col_6, [7] as col_7, [8] as col_8, [9] as col_9, [10] as col_10, [11] as col_11, [12] as col_12, [13] as col_13          
 into #RESULTADO               
 from #CMG A                
    left join #RES B                 
    on A.RCODVAR=B.variables           
         
 select style,DESVAL,         
 col_1, col_2, col_3, col_4, col_5, col_6, col_7, col_8, col_9, col_10, col_11, col_12, col_13         
 from #RESULTADO             
   
 
	drop table #FECS
	drop table #ACUM000
	drop table #ACUM00
	drop table #AAA
	drop table #RESULTPRE
	drop table #RES
	drop table #CMG     

end
