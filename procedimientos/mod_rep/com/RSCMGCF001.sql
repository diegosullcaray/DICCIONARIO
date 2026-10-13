-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-09-14 18:53:37.583000
--exec [com].[RSCMGCF001] 7,'231','20230831'  

CREATE  procedure [com].[RSCMGCF001]                    
@tip_cod int, @cod_rel varchar(10),@fec date             
----------------------------------------------------------------------------------                    
as                    
begin                    
SET NOCOUNT ON;          
           
 -- declare @tip_cod int =7,@cod_rel nvarchar(10) ='231' ,@fec date ='20230913'        
 --select  @fec = MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())            
              
        
 /* drop table #fechas,#base,#f,#f2,#F3  */        
                                      
  -- FECHAS DE LA TABLA PARA HACER EL FILTRO --        
                                 
 declare @fecx varchar(8)         
 set @fecx = format(dateadd(day,-1,getdate()),'yyyyMMdd')         
        
 select RORD, format(RFEC,'yyyy-MM-dd') F, format(RFEC,'yyyyMMdd') F2 into #F  from storage.[util].[FVECFEC01](@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')              
 select RFEC F, RFECTXT F2  into #F2  from storage.ref.RCALEN001 where rciebt = 1 and year(rfec) >= year(getdate())-1 and rfec <= getdate()        
 
  select RFEC F, RFECTXT F2  into #F3  from storage.ref.RCALEN001 where rciebt = 1 and year(rfec) >= year(getdate())-1 and rfec <= eomonth(getdate())     

  

         
 create table #fechas (R int IDENTITY(1,1) NOT NULL, F varchar(10)null, F2 varchar(10)null, F3 varchar(10)null, CMG smallint, CIEBT smallint)                  
  insert into #fechas   -- drop table #fechas  select * from #fechas        
 ----    select F,F2,1,0  from #F        
 --union select *,1,0  from #F2  
 
  select a.F,a.F2, b.F2 F3 ,1,0 
		 from #F a  left join #F3 b on EOMONTH(a.F) = EOMONTH(b.F)
union select a.F,a.F2, b.F2  F3,1,0
		 from #F2 a left join #F3 b on EOMONTH(a.F) = EOMONTH(b.F)
 order by 1        
 update #fechas set CMG = 2 where f2 in (select f2 from #f)         
 update #fechas set CIEBT = 1 where f2 in (select f2 from #f2)        
   
   

-- select * from #F        
-- select * from #F2          
 -- declare @tip_cod int =7,@cod_rel nvarchar(10) ='231'          
        
 declare @fecs varchar(250);         
 select @fecs=string_agg(F2,',') from #fechas 

 declare @fecs2 varchar(250);         
 select @fecs2=string_agg(F3,',') from #fechas 
 
 declare @fecha1 as date, @fecha2 as date, @fecha3 as date, @fecha4 as date, @fecha5 as date , @fecha6 as date          
 select @fecha1 = f from #F where RORD=1        
 select @fecha2 = f from #F where RORD=2        
 select @fecha3 = f from #F where RORD=3        
 select @fecha4 = f from #F where RORD=4        
 select @fecha5 = f from #F where RORD=5        
 select @fecha6 = f from #F where RORD=6        
         
 declare @defs as rep.TTHCOLDEF;          
          
  insert into @defs              
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN)  values           
        
 (0,1,1,'DESVAL','Variable (en miles PEN, %, y número)',NULL,2,1,'string',null,null),         
 (1,null,1,'2021',format(@fecha1,'yyyy'),3,1,NULL,NULL,null,null),         
 (2,null,1,'2022',format(@fecha6,'yyyy'),3,1,NULL,NULL,null,null),         
 (3,8,1,'col_7','META',1,2,NULL,'number',null,null),         
 (4,9,1,'col_8',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),         
 (5,10,1,'col_9','TMM',2,2,NULL,'number',null,null),        
 (6,11,1,'col_10',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),         
 (7,12,1,'col_11','TAM',2,2,NULL,'number',null,null),         
 (8,13,1,'col_12',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),         
 (9,14,1,'col_13','Distancia Meta',2,2,NULL,'number',null,null),         
        
 (10,2,2,'col_1',format(@fecha1,'dd-MMM'),null,null,null,'number',null,null),         
 (11,3,2,'col_2',format(@fecha2,'dd-MMM'),null,null,null,'number',null,null),         
 (12,4,2,'col_3',format(@fecha3,'dd-MMM'),null,null,null,'number',null,null),         
 (13,5,2,'col_4',format(@fecha4,'dd-MMM'),null,null,null,'number',null,null),         
 (14,6,2,'col_5',format(@fecha5,'dd-MMM'),null,null,null,'number',null,null),         
 (15,7,2,'col_6',format(@fecha6,'dd-MMM'),null,null,null,'number',null,null)        
        
   select rep.FFTHCOLDEF(@defs) result;            
           
                                          
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF,@tfil2 as piv.TPIVFIL                   
            
          
          
        
insert into @tvars                
values                     
('ds_num_bancarizado',null,null,null,null,null),        
('ds_cont_banca_ex',null,null,null,null,null),                 
('ds_num_mujeres',null,null,null,null,null),                  
('ds_num_rural',null,null,null,null,null),                
('ds_num_migrantes',null,null,null,null,null),        
('ds_tot_cli',null,null,null,null,null),         
('ds_num_vulnerables',null,null,null,null,null),         
('ds_num_vulnerablesN',null,null,null,null,null),         
        
('ds_porc_bancarizado',null,null,null,null,null),         
('ds_porc_banca_ex',null,null,null,null,null),         
('ds_porc_mujeres',null,null,null,null,null),         
('ds_porc_rural',null,null,null,null,null),         
('ds_porc_migrantes',null,null,null,null,null),        
('ds_porc_vulnerables',null,null,null,null,null)      
         
declare @tvars2 as piv.TPIVVAR        
insert into @tvars2                
values                 
('cli_castigo',null,null,null,null,null)         
        
           
--declare @fec varchar(8)='20210315'                
insert into @tfil               
 values                
 ('todos','fec',''+@fecs+'')           
                
declare @jer varchar(100);                
insert into @tfil                
exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output                
                
insert into @tconf                
 values                
 ('level_alias','style')                
        
select @jer = CONCAT ('"fec",',@jer)        
        
        
--select*from mod_rep.[piv].[RREGVPIV01] where ralivpiv='ds_num_vulnerables'
----2.copiamos la llave de la columna ralivpiv para saber de que tabla sumarizada o otra tabla esta haciendo consulta
--select*from mod_rep.[piv].[RREGTPIV01] where RALITPIV='Desem_soc'

--insert into mod_rep.[piv].[RREGVPIV01] values (10659,'Conteo de VulnerablesNULL','ds_num_vulnerablesN','Desem_soc','count(distinct CASE WHEN HINDVULN =4  THEN HCODPER ELSE null END)')
 
 --delete mod_rep.[piv].[RREGVPIV01] where RCODVPIV = 10659



create table #base (fila int, cod_fec varchar(10)null, cod_prim varchar(50)null, cod_sec varchar(50)null,style int, descripcion varchar(250)null,          
ds_num_bancarizado int null, ds_cont_banca_ex int null, ds_num_mujeres int null, ds_num_rural int null, ds_num_migrantes int null, ds_tot_cli int null, ds_num_vulnerables int null, ds_num_vulnerablesN int null,          
ds_porc_bancarizado float null, ds_porc_banca_ex float null, ds_porc_mujeres float null, ds_porc_rural float null, ds_porc_migrantes float null, ds_porc_vulnerables float null)                    
 insert into #base   -- drop table   #base        select * from #base   
        
--los valores rows y columnas van separados por comas y cada valor entre doble comilla                
--'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion                
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf   -- ,@show_query=1           
        
 
 
 insert into @tfil2               
 values                
 ('todos','fec',''+@fecs2+'') 
 
create table #castigo (fila int,cod_fec varchar(10)null,cod_prim varchar(50)null,cod_sec varchar(50)null,style int,descripcion varchar(250)null,tot_castigo int)        
 insert into #castigo   -- drop table   #castigo         
exec piv.GPIVRES01 @variables=@tvars2,@filters=@tfil2,@rows=@jer,@columns='"vars"',@config=@tconf   --   ,@show_query=1           
        
--select * from #base select * from #castigo        
        
         
 ----------------------------------------------------------------------------        
------------------CLIENTES NUEVOS DEL MES ----------------------------------        
----------------------------------------------------------------------------        
        
         
        
 --Tomando solo la información necesaria del resultado del pivot -- drop table #base_2        
  create table #base_2 (Id int IDENTITY(1,1) NOT NULL,cod_fec varchar(10)null,[10054] float null, [10055] float null,[10056] float null,[10057] float null,        
[10070] float null,[10071] float null,[10072] float null,[10073] float null,[10074] float null,[10075] float null, [166] float null, [10088] float null, [10089] float null)                  
  insert into #base_2          
  select   F , isnull(sum(ds_num_bancarizado),0), isnull(sum(ds_num_mujeres),0), isnull(sum(ds_num_rural),0), isnull(sum (ds_num_migrantes),0), isnull(sum (ds_num_vulnerables),0)        
  , isnull(sum (ds_porc_bancarizado),0), isnull(sum (ds_porc_mujeres),0), isnull(sum (ds_porc_rural),0), isnull(sum (ds_porc_migrantes),0), isnull(sum (ds_porc_vulnerables),0), isnull(sum (ds_tot_cli),0)        
  , isnull(sum(ds_cont_banca_ex),0), isnull(sum (ds_porc_banca_ex),0)        
  from #fechas A  left join (select * from #base where style =1) B        
  on cast (A.F as date) = B.cod_fec where A.CMG=2 group by R,F         
  --select * from #base_2        
        
       select  RORD ID, F cod_fec, [10054],[10055],[10056],[10057],[10070],[10071],[10072],[10073],[10074],[10075],[166],[10088],[10089]  into #base_22  
  from #f A  left join #base_2 b on A.F = b.cod_fec  
   
    
--unpivot para darle forma al pivoteo posterior pasamos las columnas ds como una fila        
  select id RORD, descripcion variables,  resultado   valores  into #base_3 --select * from  #base_3   drop table #base_3        
   from #base_22        
   unpivot        
   (        
   resultado        
   for descripcion in ([10054],[10055],[10056],[10057],[10070],[10071],[10072],[10073],[10074],[10075],[166],[10088],[10089]) ) as b        
   order by id asc        
            
        
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20220521'                    
-->COLOCANDO LOS RESULTADOS DE LAS METAS         
              
select  RORD,variables,valores                    
    into    #RESULTPRE     -- select * from #RESULTPRE where rord=7    drop table #RESULTPRE              
    from    #base_3                   
    UNION                    
    select 7 FORD, B.HCODVAR, B.HVALVAR                    
    FROM    #base_3 A                    
        LEFT join [storage].[com].[VDMCOM01] B     --SELECT* FROM [storage].[com].[VDMCOM01]                
        on A.variables= B.HCODVAR                    
            and B.HTIPMETA = 1                    
            and B.HFECPRO = eomonth(@fec)                    
            and B.HTIPCOD = @tip_cod                    
            and B.HCODREL = @cod_rel      
      
--metas porc      
declare @meta1 float,@meta2 float,@meta3 float,@meta4 float,@meta5 float,@meta6 float,@meta7 float      
select @meta1=valores from #RESULTPRE where rord = 7 and variables = 166 --nuevos mes      
select @meta2=valores from #RESULTPRE where rord = 7 and variables = 10054 --mes num_bancarizado      
select @meta3=valores from #RESULTPRE where rord = 7 and variables = 10055 --mes num_mujeres      
select @meta4=valores from #RESULTPRE where rord = 7 and variables = 10056 --mes num_rural      
select @meta5=valores from #RESULTPRE where rord = 7 and variables = 10057 --mes num_migrantes      
select @meta6=valores from #RESULTPRE where rord = 7 and variables = 10070 --mes num_vulnerables      
select @meta7=valores from #RESULTPRE where rord = 7 and variables = 10088 --mes  Exclusivos Mes      
      
insert into  #RESULTPRE values (7,10071,(@meta2/@meta1))     --mes % Nuevos Bancarizados             
insert into  #RESULTPRE values (7,10072,(@meta3/@meta1))   --mes % Nuevos Mujeres      
insert into  #RESULTPRE values (7,10073,(@meta4/@meta1))    --mes % Nuevos Rurales      
insert into  #RESULTPRE values (7,10074,(@meta5/@meta1))   --mes % Nuevos Migrantes      
insert into  #RESULTPRE values (7,10075,(@meta6/@meta1))    --mes % Nuevos Vulnerables      
insert into  #RESULTPRE values (7,10089,(@meta7/@meta1))    --mes % Exclusivos Mes      
      
      
 select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                    
    into #AAA                    
    from #RESULTPRE -- select*from    #AAA       drop table   #AAA            
    UNION ALL                    
  select  case when concat(A.RORD,'-',B.RORD) = '6-4' then 9                    
        when concat(A.RORD,'-',B.RORD) = '6-1' then 11                    
        when concat(A.RORD,'-',B.RORD) = '6-7' then 13 end RORD                    
        ,A.variables,         
  util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(10071,10072,10073,10074,10075,10089),1,null)) SVALOR      --in(165,166,8680,8670/*,10055,10056*/),1,null)) SVALOR              
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
 into #RES  --  select*from #RES        drop table #RES                       
 from #AAA pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])) PVT                    
        
        
        
        
----------------------------------------------------------------------------        
------------------CLIENTES NUEVOS DEL AÑO ----------------------------------        
----------------------------------------------------------------------------        
         
        
-- select * from #fechas      select * from #base  where style =1        
 --Tomando solo la información necesaria del resultado del pivot -- drop table #base_2_1        
  create table #base_2_1 (Id int IDENTITY(1,1) NOT NULL,cod_fec varchar(10)null,[10076] float null, [10077] float null,[10078] float null,[10079] float null,        
  [10080] float null, [10080_] float null,[10081] float null,[10082] float null,[10083] float null,[10084] float null,[10085] float null, [167] float null, [10090] float null, [10091] float null)                  
  insert into #base_2_1          
  select   F ,isnull(sum(ds_num_bancarizado),0), isnull(sum(ds_num_mujeres),0), isnull(sum(ds_num_rural),0), isnull(sum (ds_num_migrantes),0), isnull(sum (ds_num_vulnerables),0) , isnull(sum (ds_num_vulnerablesN),0)       
  , isnull(sum(ds_porc_bancarizado),0) , isnull(sum (ds_porc_mujeres),0), isnull(sum (ds_porc_rural),0), isnull(sum (ds_porc_migrantes),0), isnull(sum (ds_porc_vulnerables),0), isnull(sum (ds_tot_cli),0)        
  , isnull(sum(ds_cont_banca_ex),0), isnull(sum (ds_porc_banca_ex),0)        
  from #fechas A  left join (select * from #base where style =1) B        
  on cast (A.F as date) = B.cod_fec    group by R,F         
  --select * from #base_2_1        
        
        
  create table #base_2_1A (Id int IDENTITY(1,1) NOT NULL,cod_fec varchar(10)null,[10076] float null, [10077] float null,[10078] float null,[10079] float null,        
  [10080] float null,[10081] float null,[10082] float null,[10083] float null,[10084] float null,[10085] float null, [167] float null, [10090] float null, [10091] float null)                  
           
   -- drop table #base_2_1A         select * from #base_2_1A    select * from #fechas        
        
 declare @i int,@f int        
 select @i=1,@f=max(RORD) from #f   --select F from #fechas where f <= '2022-04-30' and CIEBT =1  union select '2022-04-30'         
              
 while(@i<=@f)          
 begin          
  declare @fectemp  date           
  select @fectemp = f from #f where rord = @i        
        
  insert into  #base_2_1A        
   select  @fectemp,        
   sum([10076]) [10076],sum([10077]) [10077],sum([10078]) [10078],sum([10079]) [10079],sum([10080]) [10080],        
   case when sum([167]) > 0 then sum([10076])/ cast(sum([167]) as float) else 0 end [10081],        
   case when sum([167]) > 0 then sum([10077])/ cast(sum([167]) as float) else 0 end [10082],        
   case when sum([167]) > 0 then sum([10078])/ cast(sum([167]) as float) else 0 end [10083],        
   case when sum([167]) > 0 then sum([10079])/ cast(sum([167]) as float) else 0 end [10084],        
   case when sum([167]) > 0  and sum([10080]) >0 then sum([10080])/ cast(sum([167])-sum([10080_]) as float) else 0 end [10085],        
   sum([167]) [167],        
   sum([10090]) [10090],        
   case when sum([167]) > 0 then sum([10091])/ cast(sum([167]) as float) else 0 end [10091]        
   from  #base_2_1         
   where cod_fec in (select F from #fechas where f <= @fectemp and CIEBT =1 union select @fectemp) and year(cod_fec) = year(@fectemp)        
        
         
  set @i=@i+1              
  end           
    
	


------------------------------------------------------------------
------------------------------------------------------------------
 --Adecuación para que no calcule la suma en los meses que no hay carga de bancarizados

	UPDATE 
    #base_2_1A
SET  
    [10076] = null,
	[10081] = null
FROM  
    #base_2_1A c
    LEFT JOIN (select cod_fec, [10076] Banc, [10081] PorcBanc  from #base_2_1)  t 
        ON c.cod_fec = t.cod_fec where Banc =0

	UPDATE 
    #base_2_1A
SET  
    [10080] = null,
	[10085] = null
FROM  
    #base_2_1A c
    LEFT JOIN (select cod_fec, [10080] Vuln, [10085] PorcVuln  from #base_2_1)  t 
        ON c.cod_fec = t.cod_fec where Vuln =0
------------------------------------------------------------------
------------------------------------------------------------------

   
   --select  *from #base_2_1 where   variables in (10076,10081)
     
        
--unpivot para darle forma al pivoteo posterior pasamos las columnas ds como una fila        
  select id RORD, descripcion variables,  resultado   valores,       
   CASE      
 WHEN descripcion = 10076 THEN 10054      
 WHEN descripcion = 10077 THEN 10055      
 WHEN descripcion = 10078 THEN 10056      
 WHEN descripcion = 10079 THEN 10057      
 WHEN descripcion = 10080 THEN 10070      
 WHEN descripcion = 10081 THEN 10071      
 WHEN descripcion = 10082 THEN 10072      
 WHEN descripcion = 10083 THEN 10073      
 WHEN descripcion = 10084 THEN 10074      
 WHEN descripcion = 10085 THEN 10075      
 WHEN descripcion = 167 THEN 166      
 WHEN descripcion = 10090 THEN 10088      
 WHEN descripcion = 10091 THEN 10089      
 END  as var2   into #base_3_1 --select * from  #base_3_1   drop table #base_3_1        
   from #base_2_1A        
   unpivot        
   (        
   resultado        
   for descripcion in ([10076],[10077],[10078],[10079],[10080],[10081],[10082],[10083],[10084],[10085],[167],[10090],[10091]) ) as b        
   order by id asc        
            
       
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20220521'  declare @fecha6 as date    select @fecha6 = f from #F where RORD=6                
-->COLOCANDO LOS RESULTADOS DE LAS METAS         
              
select  RORD, variables,valores                    
    into    #RESULTPRE_1     -- select * from #RESULTPRE_1     drop table #RESULTPRE_1              
    from    #base_3_1                   
    UNION                    
    select 7 FORD, B.HCODVAR, B.HVALVAR                    
    FROM    #base_3_1 A                    
        LEFT join (      
  -- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20220521'  declare @fecha6 as date   select @fecha6 = f from #F where RORD=6     declare @fecha4 as date  select @fecha4 = f from #F where RORD=4            
      
    SELECT       
    CASE      
    WHEN HCODVAR = 10054  THEN 10076      
    WHEN HCODVAR = 10055  THEN 10077      
    WHEN HCODVAR = 10056  THEN 10078      
    WHEN HCODVAR = 10057  THEN 10079      
    WHEN HCODVAR = 10070  THEN 10080      
    WHEN HCODVAR = 10071  THEN 10081      
    WHEN HCODVAR = 10072  THEN 10082      
    WHEN HCODVAR = 10073  THEN 10083      
    WHEN HCODVAR = 10074  THEN 10084      
    WHEN HCODVAR = 10075  THEN 10085      
    WHEN HCODVAR = 166  THEN 167      
    WHEN HCODVAR = 10088  THEN 10090      
    WHEN HCODVAR = 10089  THEN 10091      
    END  as HCODVAR,      
          
    SUM(HVALVAR) HVALVAR FROM [storage].[com].[VDMCOM01] where       
    year(hfecpro) in (select format(@fecha6,'yyyy') )       
    and hfecpro <= EOMONTH (@fecha6)      
    and HTIPMETA = 1        
    and HTIPCOD = @tip_cod           
    and HCODREL =  @cod_rel       
    and HCODVAR in (166,10054,10055,10056,10057)      
    group by HCODVAR      
    ) B     --    select distinct hcodvar FROM [storage].[com].[VDMCOM01] where hfecpro = '2022-05-31' order by 1      
        on A.variables= B.HCODVAR          
        
        
	  --select  *from  #RESULTPRE_1  where RORD=6 and variables in (10076,10081)
      
        
--metas porc      
declare @meta1_1 float,@meta2_1 float,@meta3_1 float,@meta4_1 float,@meta5_1 float,@meta6_1 float,@meta7_1 float      
select @meta1_1=valores from #RESULTPRE_1 where rord = 7 and variables = 167 --nuevos año      
select @meta2_1=valores from #RESULTPRE_1 where rord = 7 and variables = 10076 --mes num_bancarizado      
select @meta3_1=valores from #RESULTPRE_1 where rord = 7 and variables = 10077 --mes num_mujeres      
select @meta4_1=valores from #RESULTPRE_1 where rord = 7 and variables = 10078 --mes num_rural      
select @meta5_1=valores from #RESULTPRE_1 where rord = 7 and variables = 10079 --mes num_migrantes      
select @meta6_1=valores from #RESULTPRE_1 where rord = 7 and variables = 10080 --mes num_vulnerables      
select @meta7_1=valores from #RESULTPRE_1 where rord = 7 and variables = 10090 --mes  Exclusivos Mes      
      
insert into  #RESULTPRE_1 values (7,10081,(@meta2_1/@meta1_1))     --mes % Nuevos Bancarizados             
insert into  #RESULTPRE_1 values (7,10082,(@meta3_1/@meta1_1))   --mes % Nuevos Mujeres      
insert into  #RESULTPRE_1 values (7,10083,(@meta4_1/@meta1_1))    --mes % Nuevos Rurales      
insert into  #RESULTPRE_1 values (7,10084,(@meta5_1/@meta1_1))   --mes % Nuevos Migrantes      
insert into  #RESULTPRE_1 values (7,10085,(@meta6_1/@meta1_1))    --mes % Nuevos Vulnerables      
insert into  #RESULTPRE_1 values (7,10091,(@meta7_1/@meta1_1))    --mes % Exclusivos Mes      
      
      
      
 select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                    
    into #AAA_1                    
    from #RESULTPRE_1 -- select*from    #AAA_1       drop table   #AAA_1            
    UNION ALL                    
  select  case when concat(A.RORD,'-',B.RORD) = '6-4' then 9                    
        when concat(A.RORD,'-',B.RORD) = '6-1' then 11                    
        when concat(A.RORD,'-',B.RORD) = '6-7' then 13 end RORD                    
        ,A.variables,         
  util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(10081,10082,10083,10084,10085,10091),1,null)) SVALOR      --in(165,166,8680,8670/*,10055,10056*/),1,null)) SVALOR                   
  from #RESULTPRE_1 A --select*from #RESULTPRE                    
        join #RESULTPRE_1 B                    
   on A.variables=B.variables                    
  where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                 
        UNION ALL                    
   select  case when concat(A.RORD,'-',B.RORD) ='6-4' then 8                    
            when concat(A.RORD,'-',B.RORD) ='6-1' then 10                    
            when concat(A.RORD,'-',B.RORD) ='6-7' then 12 end RORD                    
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR        
   from #RESULTPRE_1 A                    
   join #RESULTPRE_1 B                    
   on A.variables=B.variables                    
   where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                    
        
--pivotenado los resultados                  
 select *                    
 into #RES_1  --  select*from #RES_1        drop table #RES_1                       
 from #AAA_1 pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])) PVT                    
      
	  
	    
    
	
	    
        
  --select * from  storage.com_act.HCcA001        
        
----------------------------------------------------------------------------        
--------------------CASTIGOS DEL MES ----------------------------------        
----------------------------------------------------------------------------        
         
          
 --Tomando solo la información necesaria del resultado del pivot -- drop table #base_2_2        
  create table #base_2_3 (Id int IDENTITY(1,1) NOT NULL,cod_fec varchar(10)null, [10086] float null)                  
  insert into #base_2_3 -- select * from #base_2_2          
  select   F , isnull(sum(tot_castigo),0)    
  from #fechas A  left join (select * from #castigo where style =1) B        
  on 
  CASE WHEN  cast (A.F as date)    = CAST (GETDATE()-1 as date)  THEN cast (A.F3 as date) ELSE cast (A.F as date) END
  --cast (A.F as date)  
  = B.cod_fec where A.CMG=2 group by R,F   
  
  select  RORD ID, F cod_fec, [10086]  into #base_2_31 --select * from #base_2_31
  from #f A  left join #base_2_3 b on A.F = b.cod_fec  
   

--unpivot para darle forma al pivoteo posterior pasamos las columnas ds como una fila        
  select id RORD, descripcion variables,  resultado   valores  into #base_3_3 --select * from  #base_3_3   drop table #base_3_3        
   from #base_2_31       
   unpivot        
   (        
   resultado        
   for descripcion in ([10086]) ) as b        
   order by id asc        
            
        
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20220512'                    
-->COLOCANDO LOS RESULTADOS DE LAS METAS         
              
select  RORD,variables,valores                    
    into    #RESULTPRE_3     -- select * from #RESULTPRE_3    drop table #RESULTPRE_3              
    from    #base_3_3                   
    UNION                    
    select 7 FORD, B.HCODVAR, B.HVALVAR                    
    FROM    #base_3_3 A                    
        LEFT join [storage].[com].[VDMCOM01] B     --SELECT* FROM [storage].[com].[VDMCOM01]                
        on A.variables= B.HCODVAR                    
            and B.HTIPMETA = 1                    
            and B.HFECPRO = eomonth(@fec)                    
            and B.HTIPCOD = @tip_cod                    
            and B.HCODREL = @cod_rel                    
                  
        
        
 select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                    
    into #AAA_3                  
    from #RESULTPRE_3 -- select*from    #AAA_3       drop table   #AAA_3            
    UNION ALL                    
  select  case when concat(A.RORD,'-',B.RORD) = '6-4' then 9                    
        when concat(A.RORD,'-',B.RORD) = '6-1' then 11                    
        when concat(A.RORD,'-',B.RORD) = '6-7' then 13 end RORD                    
        ,A.variables,         
  util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(10071,10072,10073,10074,10075),1,null)) SVALOR      --in(165,166,8680,8670/*,10055,10056*/),1,null)) SVALOR                   
  from #RESULTPRE_3 A --select*from #RESULTPRE_3               
        join #RESULTPRE_3 B                    
        on A.variables=B.variables                    
  where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                 
        UNION ALL                    
   select  case when concat(A.RORD,'-',B.RORD) ='6-4' then 8                    
            when concat(A.RORD,'-',B.RORD) ='6-1' then 10                    
            when concat(A.RORD,'-',B.RORD) ='6-7' then 12 end RORD                    
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR        
   from #RESULTPRE_3 A                    
   join #RESULTPRE_3 B                    
   on A.variables=B.variables                    
   where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                    
        
--pivotenado los resultados                  
select *                    
 into #RES_3  --  select*from #RES_3        drop table #RES                       
 from #AAA_3 pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])) PVT                    
        
        
----------------------------------------------------------------------------        
--------------------CASTIGOS DEL AÑO      ----------------------------------        
----------------------------------------------------------------------------        
        
         
 --Tomando solo la información necesaria del resultado del pivot -- drop table #base_2_1        
  create table #base_2_4 (Id int IDENTITY(1,1) NOT NULL,cod_fec varchar(10)null, [10087] float null)            
  insert into #base_2_4          
  select   F , isnull(sum(tot_castigo),0)        
  from #fechas A  left join (select * from #castigo where style =1) B        
  --on cast (A.F as date) =  B.cod_fec 
  ON CASE WHEN  cast (A.F as date)    = CAST (GETDATE()-1 as date)  THEN cast (A.F3 as date) ELSE cast (A.F as date) END =  B.cod_fec 
  group by R,F         
  --select * from #base_2_4        
        
        
  create table #base_2_4A (Id int IDENTITY(1,1) NOT NULL,cod_fec varchar(10)null,[10087] float null)                   
           
   -- drop table #base_2_4A        select * from #base_2_4A        
        
 declare @i1 int,@f1 int        
 select @i1=1,@f1=max(RORD) from #f              
              
 while(@i1<=@f1)          
 begin          
  declare @fectemp1  date           
  select @fectemp1 = f from #f where rord = @i1        
      
  insert into  #base_2_4A        
   select  @fectemp1, sum([10087]) [10087]        
   from  #base_2_4         
   --where cod_fec in (select F from #fechas where f <= @fectemp1 and CIEBT =1) and year(cod_fec) = year(@fectemp1)        
   where cod_fec in (select F from #fechas where f <= @fectemp1  ) and year(cod_fec) = year(@fectemp1)             
  set @i1=@i1+1              
  end           
      
   
        
--unpivot para darle forma al pivoteo posterior pasamos las columnas ds como una fila        
  select id RORD, descripcion variables,  resultado   valores  into #base_3_4 --select * from  #base_3_4   drop table #base_3_4        
   from #base_2_4A        
   unpivot        
   (        
   resultado        
   for descripcion in ([10087]) ) as b        
   order by id asc        
            
        
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20220512'                    
-->COLOCANDO LOS RESULTADOS DE LAS METAS         
              
select  RORD,variables,valores                    
    into    #RESULTPRE_4     -- select * from #RESULTPRE_4    drop table #RESULTPRE_1              
    from    #base_3_4                   
    UNION                    
    select 7 FORD, B.HCODVAR, B.HVALVAR                    
    FROM    #base_3_4 A                    
        LEFT join [storage].[com].[VDMCOM01] B     --SELECT* FROM [storage].[com].[VDMCOM01]                
        on A.variables= B.HCODVAR                    
            and B.HTIPMETA = 1                    
            and B.HFECPRO = eomonth(@fec)                    
            and B.HTIPCOD = @tip_cod                    
            and B.HCODREL = @cod_rel                    
        
        
 select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                    
    into #AAA_4                   
    from #RESULTPRE_4 -- select*from    #AAA_4      drop table   #AAA_1            
    UNION ALL                    
  select  case when concat(A.RORD,'-',B.RORD) = '6-4' then 9                    
        when concat(A.RORD,'-',B.RORD) = '6-1' then 11                    
        when concat(A.RORD,'-',B.RORD) = '6-7' then 13 end RORD                    
        ,A.variables,         
  util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(10081,10082,10083,10084,10085),1,null)) SVALOR      --in(165,166,8680,8670/*,10055,10056*/),1,null)) SVALOR                   
  from #RESULTPRE_4 A --select*from #RESULTPRE                    
        join #RESULTPRE_4 B                    
        on A.variables=B.variables                    
  where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                 
        UNION ALL                    
   select  case when concat(A.RORD,'-',B.RORD) ='6-4' then 8                    
            when concat(A.RORD,'-',B.RORD) ='6-1' then 10                    
            when concat(A.RORD,'-',B.RORD) ='6-7' then 12 end RORD                    
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR        
   from #RESULTPRE_4 A                    
   join #RESULTPRE_4 B                    
   on A.variables=B.variables                    
   where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                    
        
--pivotenado los resultados                  
 select *                    
 into #RES_4  --  select*from #RES_4        drop table #RES_4                    
 from #AAA_4 pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])) PVT                    
        
        
        
 -------------------------------        
           
        
          
-->CREAMOS LA TABLA A PUBLICAR               
create table #CMG      --drop table   #CMG              
(   RDESVAR varchar(250),                    
    RCODVAR int                    
)                    
insert into #CMG                 
values         
 ('Clientes Nuevos del Mes', 166),                            
 ('  Nuevos Bancarizados por FC (1/.)', 10054),        
 --('  Nuevos Exclusivos', 10088),                    
 ('  Nuevos Mujeres', 10055),             
 ('  Nuevos Rurales',10056),          
 ('  Nuevos Migrantes', 10057),                
 ('  Nuevos Vulnerables', 10070),        
 ('  % Nuevos Bancarizados', 10071),        
 ('  % Nuevos Exclusivos', 10089),        
 ('  % Nuevos Mujeres',10072),              
 ('  % Nuevos Rurales', 10073),         
 ('  % Nuevos Migrantes', 10074)  ,        
 ('  % Nuevos Vulnerables ',10075),        
        
 ('Clientes Nuevos del Año', 167),   --*******            
 ('  Nuevos Bancarizados por FC (1/.)', 10076),          
 --('  Nuevos Exclusivos', 10090),                  
 ('  Nuevos Mujeres', 10077),             
 ('  Nuevos Rurales',10078),          
 ('  Nuevos Migrantes', 10079),                
 ('  Nuevos Vulnerables', 10080),        
 ('  % Nuevos Bancarizados', 10081),        
 --('  % Nuevos Exclusivos', 10091),        
 ('  % Nuevos Mujeres',10082),              
 ('  % Nuevos Rurales', 10083),         
 ('  % Nuevos Migrantes', 10084)  ,        
 ('  % Nuevos Vulnerables ',10085),         
        
 ('  Clientes Castigados en el Mes', 10086),                    
 ('  Clientes Castigados en el Año', 10087)          
         
         
 select         
 CASE          
  WHEN A.RCODVAR in (166,167,10086,10087)         
  THEN 1 ELSE         
   CASE WHEN A.RCODVAR in (10071,10072,10073,10074,10075,10081,10082,10083,10084,10085,10089,10091)         
   THEN 5 ELSE        
   0 END         
  END AS style,        
 A.RDESVAR as DESVAL, [1] as col_1, [2] as col_2, [3] as col_3, [4] as col_4, [5] as col_5, [6] as col_6, [7] as col_7, [8] as col_8, [9] as col_9, [10] as col_10, [11] as col_11, [12] as col_12, [13] as col_13              
  into #RESULTADO                   
 from #CMG A                    
    left join         
 (Select * from #RES union        
 select * from #RES_1 union        
 select * from #RES_3 union        
 select * from #RES_4) B                     
    on A.RCODVAR=B.variables               
             
 select  *        
 --style,DESVAL,isnull(col_1,0) col_1,isnull(col_2,0) col_2,isnull(col_3,0) col_3,isnull(col_3,0) col_3,isnull(col_3,0)col_3,        
 --isnull(col_6,0)col_6,isnull(col_7,0)col_7,isnull(col_8,0)col_8,isnull(col_9,0)col_9,isnull(col_10,0)col_10,isnull(col_11,0)col_11,isnull(col_12,0)col_12,isnull(col_13,0)col_13        
          
 from #RESULTADO          
        
        
END
