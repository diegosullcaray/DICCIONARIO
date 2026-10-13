-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.447000
            
--EXEC [com].[GCOSEMAF002]  7,'231','TODO','AGROPECUARIO CUOTAS','3','Saldo'                                     
CREATE procedure [com].[GCOSEMAF002]                                            
@tip_cod int,@cod_rel varchar(250),@prod varchar(250),@subpro varchar(250),@madu varchar(20),@op varchar(250)                                        
AS                                             
BEGIN                                          
SET NOCOUNT ON;                                            
declare @fecha date=dateadd(day,-1,GETDATE());                                          
declare @fec_vigente date=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)                                          
declare @count int=1,@factor float=0.001                                      
DECLARE @cols AS NVARCHAR(MAX),                                          
       @query  AS NVARCHAR(MAX);                                          
declare @defs as rep.TTHCOLDEF;                    
Declare @FechaCosechas varchar(max)                                          
                       
 ;with Fechas as(                  
 select distinct cast(SFECPRO as varchar(max)) as SFECBAS from storage.[com_act].SDAS013  --SELECT*FROM storage.[com_act].SDAS013                  
 where  CASE WHEN @madu='TODO' THEN '1' else cast(SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                         
 and scodagr=3                  
 )                    
                  
 select @FechaCosechas = STUFF((SELECT  ',' + QUOTENAME(cast(c.SFECBAS as varchar(max)))                                        
 FROM Fechas c                     
 FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)') ,1,1,'')                   
                  
 set  @FechaCosechas=replace(replace(replace(@FechaCosechas,'-',''),'[',''),']','')                  
           
   if @subpro <>'TODO'        
   begin        
 SELECT RCODMOD,RTIPOPE into #SubProducto FROM [storage].[com_act].[RETP009] WHERE RDESSUBPROD=@subpro        
   end        
                  
  IF (@prod='TODO'  and @subpro='TODO')        
 BEGIN                
 ;WITH Datos as (                                    
     SELECT TS.sfecbas AS cod_fec_base_r,                      
    CASE                       
     WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @tip_cod=15 THEN RDESTER                       
     WHEN @tip_cod=14 THEN RDESCOR                       
     when @tip_cod=13 then RDESGRU                      
     when @tip_cod=11 then RDESADM                      
   END AS des_,                       
    case                        
     when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
     else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT))                       
    end as ratio,                         
    1 style                      
 FROM storage.[com_act].SDAS013 TS     --SELECT*FROM storage.[com_act].SDAS013                     
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                       
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC     ANd TS.SFECPRO=JER.RFECPRO                
 WHERE case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   when @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   when @tip_cod=13 then CAST(JER.RCODGRU AS VARCHAR(250))                       
   when @tip_cod=11 then CAST(JER.RCODADM AS VARCHAR(250))                       
    end = @cod_rel AND /*TS.sfecpro=@fec AND*/ TS.SCOSECHA IN(3,6,9,12)                      
   and  TS.SCOSECHA=@madu   --CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                     
 GROUP BY  CASE                      
    WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @TIP_COD=15 THEN JER.RDESTER                      
      WHEN @TIP_COD=14 THEN JER.RDESCOR                      
      when @tip_cod=13 then JER.RDESGRU                      
      when @tip_cod=11 then JER.RDESADM                      
     END,TS.sfecbas                      
                      
 UNION ALL                      
                      
 --Obtenemos la desagregación del combo                      
 SELECT TS.sfecbas,case                       
      WHEN @TIP_COD=7 THEN JER.RDESTER                      
      when @tip_cod=15 then JER.RDESCOR                      
      WHEN @TIP_COD=14 THEN JER.RDESGRU                      
      WHEN @TIP_COD=13 THEN JER.RDESADM                      
      WHEN @TIP_COD=11 THEN JER.RDESSEC                      
      end s,                      
   case when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
      else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT)) end as ratio,                         
    0 style                      
 from storage.[com_act].SDAS013 TS                         
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                     
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC         ANd TS.SFECPRO=JER.RFECPRO               
 where case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   WHEN @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   WHEN @TIP_COD=13 THEN CAST(JER.RCODGRU AS VARCHAR(250))                      
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/ AND TS.SCOSECHA IN(3,6,9,12)                        
   and  TS.SCOSECHA=@madu   --CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                           
 GROUP BY  CASE                      
     WHEN @TIP_COD=7 THEN JER.RDESTER                      
     WHEN @TIP_COD=15 THEN JER.RDESCOR                      
     WHEN @TIP_COD=14 THEN JER.RDESGRU                       
     WHEN @TIP_COD=13 THEN JER.RDESADM                      
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                            
   )                  
   select * into #Datos from Datos  where des_ is not null                        
                         
                                      
   select  ROW_NUMBER() OVER(ORDER BY style desc) as row,* into #FCROWS  from #Datos --drop table #admrows                                          
                                            
   select distinct  style,des_ description into #temp from #FCROWS order by style desc                                        
                                      
   insert into #Datos                                      
   select  cod_fec_base_r,des_,ratio,'-1' from #Datos  where style=0                               
                          
   update a                                      
   set a.ratio=b.SEM                                      
   FROM #Datos A inner join (select a.cod_fec_base_r,a.des_,a.ratio,            
         case when a.ratio >=b.ratio+@factor then -1                                      
           when a.ratio >=b.ratio then 0                                      
           when a.ratio <b.ratio  then 1             
          end SEM                                      
         from #Datos a                                      
         inner join (select cod_fec_base_r,ratio from #Datos where style=1 )b                                      
         ON A.cod_fec_base_r=B.cod_fec_base_r                                               where a.style=0                                      
        )b                                      
   on a.cod_fec_base_r=b.cod_fec_base_r                                      
   and a.des_=b.des_                                      
   where a.style=-1              
                                      
    update a                                      
    set a.des_=b.description2                                      
    from #Datos a inner join (select cod_fec_base_r,des_ ,'X_'+''+des_ as description2 from #Datos)b                                      
    on a.cod_fec_base_r=b.cod_fec_base_r                                      
    and a.des_=b.des_                                      
    where a.style=-1                                       
                                      
    select ROW_NUMBER() OVER(ORDER BY style asc) as row,description into #FCROWSJSON from #temp                                          
                                           
     select distinct style,description into #tempFC from #temp order by 1 desc                                      
                                      
    select ROW_NUMBER() OVER(ORDER BY style desc) as orden,             
    style,description into #temp1FC from #tempFC                                        
                                      
                                      
                                          
    select orden,style,description,0 as hidden,'percent' as typess,'.2-2' as 'MOD' into #FinJSON from #temp1FC                                      
  where style not in(1)                                      
    union all                                      
    select orden,style,'X'+'_'+description,1 as hidden,'traffic-light' as typess,null as 'MOD' from #temp1FC                                      
    where style not in(1)                                      
    order by orden,style,description desc  --drop table #FinJSON  select*from #FinJSON                                      
                                      
    select ROW_NUMBER() OVER(ORDER BY style desc) orden2,* into #gg from #FinJSON order by orden asc                                      
                                      
                                    
                                    
    SET LANGUAGE spanish;                                        
    insert into @defs                                          
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TSTDEWIDTH)  values                                          
    (1,1,1,'cod_fec_base_r','FECHA','string',1,'75px')                                        
                                      
    insert into @defs                                          
      (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTDEWIDTH)                                        
      select orden+1,orden+1,1,description,description,'percent','.2-2',0,0,'100px'                                     
      from #temp1FC where style=1                                      
      union all                                         
      select orden2+2,orden2+2,1,description,description,typess,MOD,hidden,2,null                                      
      from #gg where style=0                                       
                                      
     SET LANGUAGE english;                                          
     select rep.FFTHCOLDEF(@defs) result;                                          
                                          
                                          
    select @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.des_)                                           
       FROM #Datos c                                         
       FOR XML PATH(''), TYPE                                          
       ).value('.', 'NVARCHAR(MAX)')                                           
      ,1,1,'')                                          
                                        
    set @query = 'SELECT cod_fec_base_r, ' + @cols + ' from                                           
       (                                        
     select cod_fec_base_r, des_, ratio                                          
     from #Datos                                         
      ) x                                          
       pivot                                           
       (                                    
      SUM(ratio)                                          
     for des_ in (' + @cols + ')                                          
       ) p '                                 
                                          
                                          
     EXECUTE sp_executesql @query                   
 END                   
  IF (@prod<>'TODO'  and @subpro='TODO')              
  BEGIN                
 ;WITH Datos as (                                    
     SELECT TS.sfecbas AS cod_fec_base_r,                      
    CASE                       
     WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @tip_cod=15 THEN RDESTER                       
     WHEN @tip_cod=14 THEN RDESCOR                       
     when @tip_cod=13 then RDESGRU                      
     when @tip_cod=11 then RDESADM              
   END AS des_,                       
    case                        
     when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
     else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT))                       
    end as ratio,                         
    1 style                      
 FROM storage.[com_act].SDAS013 TS                         
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC             
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC        ANd TS.SFECPRO=JER.RFECPRO           
 left join storage.[com_act].[RETP001] B                
on TS.SCODMOD=B.RCODMOD and TS.STIPOPE=B.RTIPOPE                
left join storage.[com_act].[RETP002] c                
on TS.SCODMOD=C.RCODMOD and TS.STIPOPE=C.RTIPOPE and TS.SSUBTIP=C.RSUBTIP                
left join storage.[com_act].[RETP003] E                
on isnull(C.RCODPROD,B.RCODPROD)=E.RCODPROD                
WHERE RDESPROD=@prod AND TS.SCODAGR=6                  
 AND case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   when @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   when @tip_cod=13 then CAST(JER.RCODGRU AS VARCHAR(250))                       
   when @tip_cod=11 then CAST(JER.RCODADM AS VARCHAR(250))                       
    end = @cod_rel AND /*TS.sfecpro=@fec AND*/ TS.SCOSECHA IN(3,6,9,12)                      
   and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                     
 GROUP BY  CASE                      
    WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @TIP_COD=15 THEN JER.RDESTER                      
      WHEN @TIP_COD=14 THEN JER.RDESCOR                      
      when @tip_cod=13 then JER.RDESGRU                      
      when @tip_cod=11 then JER.RDESADM                      
     END,TS.sfecbas                      
                      
 UNION ALL                      
                      
 --Obtenemos la desagregación del combo                      
 SELECT TS.sfecbas,case                       
      WHEN @TIP_COD=7 THEN JER.RDESTER                      
      when @tip_cod=15 then JER.RDESCOR                      
      WHEN @TIP_COD=14 THEN JER.RDESGRU                      
      WHEN @TIP_COD=13 THEN JER.RDESADM                      
      WHEN @TIP_COD=11 THEN JER.RDESSEC                      
      end s,                      
   case when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
      else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT)) end as ratio,                         
    0 style                      
 from storage.[com_act].SDAS013 TS                         
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                     
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC     ANd TS.SFECPRO=JER.RFECPRO                
 left join storage.[com_act].[RETP001] B                
on TS.SCODMOD=B.RCODMOD and TS.STIPOPE=B.RTIPOPE                
left join storage.[com_act].[RETP002] c                
on TS.SCODMOD=C.RCODMOD and TS.STIPOPE=C.RTIPOPE and TS.SSUBTIP=C.RSUBTIP                
left join storage.[com_act].[RETP003] E                
on isnull(C.RCODPROD,B.RCODPROD)=E.RCODPROD                
WHERE RDESPROD=@prod AND TS.SCODAGR=6                   
 AND case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   WHEN @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   WHEN @TIP_COD=13 THEN CAST(JER.RCODGRU AS VARCHAR(250))                      
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/ AND TS.SCOSECHA IN(3,6,9,12)                        
   and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                           
 GROUP BY  CASE                      
     WHEN @TIP_COD=7 THEN JER.RDESTER                      
     WHEN @TIP_COD=15 THEN JER.RDESCOR                      
     WHEN @TIP_COD=14 THEN JER.RDESGRU                       
     WHEN @TIP_COD=13 THEN JER.RDESADM                      
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                            
   )                  
   select * into #Datos1 from Datos  where des_ is not null                        
                         
                                      
   select  ROW_NUMBER() OVER(ORDER BY style desc) as row,* into #FCROWS1  from #Datos1 --drop table #admrows           
                                            
   select distinct  style,des_ description into #temp1 from #FCROWS1 order by style desc                                        
                                      
   insert into #Datos1                                      
   select  cod_fec_base_r,des_,ratio,'-1' from #Datos1 where style=0                                
                                      
   update a                                      
    set a.ratio=b.SEM                                      
    FROM #Datos1 A inner join (select a.cod_fec_base_r,a.des_,a.ratio,            
           case            
             when a.ratio >=b.ratio+@factor then -1                                      
          when a.ratio >=b.ratio then 0                                      
          when a.ratio <b.ratio  then 1 end SEM                                      
          from #Datos1 a                                      
          inner join (select cod_fec_base_r,ratio from #Datos1 where style=1)b                                      
             ON A.cod_fec_base_r=B.cod_fec_base_r                                      
             where a.style=0                                      
      )b                                      
   on a.cod_fec_base_r=b.cod_fec_base_r                                      
    and a.des_=b.des_                                      
    where a.style=-1                                      
                                      
    update a                          
    set a.des_=b.description2                                      
    from #Datos1 a inner join (select cod_fec_base_r,des_ ,'X_'+''+des_ as description2 from #Datos1)b                                      
    on a.cod_fec_base_r=b.cod_fec_base_r                                      
    and a.des_=b.des_                                      
    where a.style=-1                                       
                                      
    select ROW_NUMBER() OVER(ORDER BY style asc) as row,description into #FCROWSJSON1 from #temp1                                          
                                           
     select distinct style,description into #tempFC1 from #temp1 order by 1 desc                                      
               
    select ROW_NUMBER() OVER(ORDER BY style desc) as orden,                                      
    style,description into #temp1FC1 from #tempFC1                                        
                                      
                                      
                                          
    select orden,style,description,0 as hidden,'percent' as typess,'.2-2' as 'MOD' into #FinJSON1 from #temp1FC1                                      
    where style not in(1)                                      
    union all                                      
    select orden,style,'X'+'_'+description,1 as hidden,'traffic-light' as typess,null as 'MOD' from #temp1FC1                                      
    where style not in(1)                                      
    order by orden,style,description desc  --drop table #FinJSON1  select*from #FinJSON1                                      
                                      
    select ROW_NUMBER() OVER(ORDER BY style desc) orden2,* into #gg1 from #FinJSON1 order by orden asc                                      
                                      
                                    
                                    
    SET LANGUAGE spanish;                                        
    insert into @defs                                          
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TSTDEWIDTH) values                                          
    (1,1,1,'cod_fec_base_r','FECHA','string',1,'75px')                                        
                                      
    insert into @defs                                          
      (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTDEWIDTH)                                        
      select orden+1,orden+1,1,description,description,'percent','.2-2',0,0,'100px'                                      
      from #temp1FC1 where style=1                                      
      union all                                         
      select orden2+2,orden2+2,1,description,description,typess,MOD,hidden,2,null                                      
      from #gg1 where style=0                                       
                                      
     SET LANGUAGE english;                                          
     select rep.FFTHCOLDEF(@defs) result;                                          
                                          
                                          
    select @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.des_)                                           
       FROM #Datos1 c                                         
       FOR XML PATH(''), TYPE                                          
       ).value('.', 'NVARCHAR(MAX)')                                           
      ,1,1,'')                                          
                                        
    set @query = 'SELECT cod_fec_base_r, ' + @cols + ' from                                           
       (                                        
     select cod_fec_base_r, des_, ratio                                          
     from #Datos1                                         
      ) x                                          
       pivot                                           
       (                                          
      SUM(ratio)                                          
  for des_ in (' + @cols + ')                                          
       ) p '                                 
                                          
                                          
     EXECUTE sp_executesql @query                   
 END                               
          
  IF (@prod='TODO' and @subpro<>'TODO')        
  BEGIN        
 ;WITH Datos as (                                    
     SELECT TS.sfecbas AS cod_fec_base_r,                      
    CASE                       
     WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @tip_cod=15 THEN RDESTER                       
     WHEN @tip_cod=14 THEN RDESCOR                       
     when @tip_cod=13 then RDESGRU              
     when @tip_cod=11 then RDESADM                      
   END AS des_,                       
    case                        
     when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
     else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT))                       
    end as ratio,                         
    1 style                      
 FROM storage.[com_act].SDAS013 TS                      
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC             
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC                 ANd TS.SFECPRO=JER.RFECPRO  
 LEFT JOIN #SubProducto SUBPRO        
 ON TS.SCODMOD=SUBPRO.RCODMOD   AND  TS.STIPOPE= SUBPRO.RTIPOPE AND TS.SCODAGR=6            
 AND case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   when @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   when @tip_cod=13 then CAST(JER.RCODGRU AS VARCHAR(250))                       
   when @tip_cod=11 then CAST(JER.RCODADM AS VARCHAR(250))                       
    end = @cod_rel AND /*TS.sfecpro=@fec AND*/ TS.SCOSECHA IN(3,6,9,12)                      
   and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                     
 GROUP BY  CASE                      
    WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @TIP_COD=15 THEN JER.RDESTER                  
      WHEN @TIP_COD=14 THEN JER.RDESCOR                      
      when @tip_cod=13 then JER.RDESGRU                      
      when @tip_cod=11 then JER.RDESADM                      
     END,TS.sfecbas                      
                      
 UNION ALL                      
                      
 --Obtenemos la desagregación del combo                      
 SELECT TS.sfecbas,case                       
      WHEN @TIP_COD=7 THEN JER.RDESTER                      
      when @tip_cod=15 then JER.RDESCOR                      
      WHEN @TIP_COD=14 THEN JER.RDESGRU                      
      WHEN @TIP_COD=13 THEN JER.RDESADM                      
      WHEN @TIP_COD=11 THEN JER.RDESSEC                      
      end s,                      
   case when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
      else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT)) end as ratio,                         
    0 style                      
 from storage.[com_act].SDAS013 TS                         
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                     
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC               ANd TS.SFECPRO=JER.RFECPRO      
 LEFT JOIN #SubProducto SUBPRO        
 ON TS.SCODMOD=SUBPRO.RCODMOD   AND  TS.STIPOPE= SUBPRO.RTIPOPE AND TS.SCODAGR=6                   
 AND case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   WHEN @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   WHEN @TIP_COD=13 THEN CAST(JER.RCODGRU AS VARCHAR(250))                      
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/ AND TS.SCOSECHA IN(3,6,9,12)                        
   and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                           
 GROUP BY  CASE                      
     WHEN @TIP_COD=7 THEN JER.RDESTER                      
     WHEN @TIP_COD=15 THEN JER.RDESCOR                      
     WHEN @TIP_COD=14 THEN JER.RDESGRU                       
     WHEN @TIP_COD=13 THEN JER.RDESADM                      
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                            
   )                  
   select * into #Datos2 from Datos  where des_ is not null                        
                         
                                      
   select  ROW_NUMBER() OVER(ORDER BY style desc) as row,* into #FCROWS2  from #Datos2 --drop table #admrows           
                                            
   select distinct  style,des_ description into #temp2 from #FCROWS2 order by style desc                                        
                                      
   insert into #Datos2                                      
   select  cod_fec_base_r,des_,ratio,'-1' from #Datos2 where style=0                                
                                      
   update a                                      
    set a.ratio=b.SEM                                      
    FROM #Datos2 A inner join (select a.cod_fec_base_r,a.des_,a.ratio,            
           case            
             when a.ratio >=b.ratio+@factor then -1                                      
          when a.ratio >=b.ratio then 0                                      
          when a.ratio <b.ratio  then 1 end SEM                                      
          from #Datos2 a                                      
          inner join (select cod_fec_base_r,ratio from #Datos2 where style=1)b                                      
             ON A.cod_fec_base_r=B.cod_fec_base_r                                      
             where a.style=0                                      
      )b                                      
   on a.cod_fec_base_r=b.cod_fec_base_r                                      
    and a.des_=b.des_                                      
    where a.style=-1                                      
                                      
    update a                          
    set a.des_=b.description2                                      
    from #Datos2 a inner join (select cod_fec_base_r,des_ ,'X_'+''+des_ as description2 from #Datos2)b                                      
    on a.cod_fec_base_r=b.cod_fec_base_r                                      
    and a.des_=b.des_                                      
    where a.style=-1                                       
                                      
    select ROW_NUMBER() OVER(ORDER BY style asc) as row,description into #FCROWSJSON2 from #temp2                                          
                                           
     select distinct style,description into #tempFC2 from #temp2 order by 1 desc                                      
                                      
    select ROW_NUMBER() OVER(ORDER BY style desc) as orden,                                      
    style,description into #temp1FC2 from #tempFC2                                        
                                      
                                      
                                          
    select orden,style,description,0 as hidden,'percent' as typess,'.2-2' as 'MOD' into #FinJSON2 from #temp1FC2                                      
  where style not in(1)                                      
    union all                                      
    select orden,style,'X'+'_'+description,1 as hidden,'traffic-light' as typess,null as 'MOD' from #temp1FC2                                      
    where style not in(1)                                      
    order by orden,style,description desc  --drop table #FinJSON2  select*from #FinJSON2                                      
                                      
    select ROW_NUMBER() OVER(ORDER BY style desc) orden2,* into #gg2 from #FinJSON2 order by orden asc                                      
                                      
                                    
                                    
    SET LANGUAGE spanish;                                        
    insert into @defs                                          
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TSTDEWIDTH)  values             
    (1,1,1,'cod_fec_base_r','FECHA','string',1,'75px')                                        
                                      
    insert into @defs                                          
      (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTDEWIDTH)                                        
      select orden+1,orden+1,1,description,description,'percent','.2-2',0,0,'100px'                                      
      from #temp1FC2 where style=1                                      
      union all                                         
      select orden2+2,orden2+2,1,description,description,typess,MOD,hidden,2,null                                      
      from #gg2 where style=0                                       
                                      
     SET LANGUAGE english;                                          
     select rep.FFTHCOLDEF(@defs) result;                                          
                                          
                                          
    select @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.des_)                                           
       FROM #Datos2 c                                         
       FOR XML PATH(''), TYPE                                          
       ).value('.', 'NVARCHAR(MAX)')                                           
      ,1,1,'')                                          
                                        
    set @query = 'SELECT cod_fec_base_r, ' + @cols + ' from                                           
       (                                        
     select cod_fec_base_r, des_, ratio                                          
     from #Datos2                                         
      ) x                                          
       pivot                                           
       (                                          
      SUM(ratio)                                          
     for des_ in (' + @cols + ')                                          
       ) p '                                 
                                          
                                          
     EXECUTE sp_executesql @query          
  END                                   
          
  IF (@PROD<>'TODO' AND @subpro<>'TODO')        
  BEGIN        
 ;WITH Datos as (                                    
     SELECT TS.sfecbas AS cod_fec_base_r,                      
    CASE                       
     WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @tip_cod=15 THEN RDESTER                       
     WHEN @tip_cod=14 THEN RDESCOR                       
     when @tip_cod=13 then RDESGRU                      
     when @tip_cod=11 then RDESADM                      
   END AS des_,                       
    case                        
     when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
     else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT))                       
    end as ratio,                         
    1 style                      
 FROM storage.[com_act].SDAS013 TS                         
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC             
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC                ANd TS.SFECPRO=JER.RFECPRO   
 left join storage.[com_act].[RETP001] B                
on TS.SCODMOD=B.RCODMOD and TS.STIPOPE=B.RTIPOPE                
left join storage.[com_act].[RETP002] c                
on TS.SCODMOD=C.RCODMOD and TS.STIPOPE=C.RTIPOPE and TS.SSUBTIP=C.RSUBTIP                
left join storage.[com_act].[RETP003] E                
on isnull(C.RCODPROD,B.RCODPROD)=E.RCODPROD            
LEFT JOIN #SubProducto SUBPRO        
ON TS.SCODMOD=SUBPRO.RCODMOD   AND  TS.STIPOPE= SUBPRO.RTIPOPE            
WHERE RDESPROD=@prod AND TS.SCODAGR=6                  
 AND case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   when @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   when @tip_cod=13 then CAST(JER.RCODGRU AS VARCHAR(250))                       
   when @tip_cod=11 then CAST(JER.RCODADM AS VARCHAR(250))                       
    end = @cod_rel AND /*TS.sfecpro=@fec AND*/ TS.SCOSECHA IN(3,6,9,12)                      
   and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                     
 GROUP BY  CASE                      
    WHEN @TIP_COD=7 THEN 'FINANCIERA CONFIANZA'                      
     WHEN @TIP_COD=15 THEN JER.RDESTER                      
      WHEN @TIP_COD=14 THEN JER.RDESCOR                      
      when @tip_cod=13 then JER.RDESGRU                      
      when @tip_cod=11 then JER.RDESADM                      
     END,TS.sfecbas                      
                      
 UNION ALL                      
                      
 --Obtenemos la desagregación del combo                      
 SELECT TS.sfecbas,case                       
      WHEN @TIP_COD=7 THEN JER.RDESTER                      
      when @tip_cod=15 then JER.RDESCOR                      
      WHEN @TIP_COD=14 THEN JER.RDESGRU                      
      WHEN @TIP_COD=13 THEN JER.RDESADM                      
      WHEN @TIP_COD=11 THEN JER.RDESSEC                      
      end s,                      
   case when @op='Saldo' then sum(CAST(ISNULL(TS.SSALCAPMORH,0) AS FLOAT))/SUM(CAST(ISNULL(TS.SSALCAPBAS,0) AS FLOAT))                      
      else sum(CAST(TS.SNUMOPEMORH AS FLOAT))/SUM(CAST(TS.SNUMOPEBAS AS FLOAT)) end as ratio,                         
    0 style                      
 from storage.[com_act].SDAS013 TS                         
 --left join  storage.[ref].WJERCOR01 JER                      
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                     
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER                   
 on  TS.SCODSEC=JER.RCODSEC               ANd TS.SFECPRO=JER.RFECPRO      
 left join storage.[com_act].[RETP001] B                
on TS.SCODMOD=B.RCODMOD and TS.STIPOPE=B.RTIPOPE                
left join storage.[com_act].[RETP002] c                
on TS.SCODMOD=C.RCODMOD and TS.STIPOPE=C.RTIPOPE and TS.SSUBTIP=C.RSUBTIP                
left join storage.[com_act].[RETP003] E                
on isnull(C.RCODPROD,B.RCODPROD)=E.RCODPROD          
LEFT JOIN #SubProducto SUBPRO        
ON TS.SCODMOD=SUBPRO.RCODMOD   AND  TS.STIPOPE= SUBPRO.RTIPOPE                  
WHERE RDESPROD=@prod AND TS.SCODAGR=6                  
 AND case                       
   when @tip_cod=7 then '231'                      
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                       
   WHEN @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                       
   WHEN @TIP_COD=13 THEN CAST(JER.RCODGRU AS VARCHAR(250))                      
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/ AND TS.SCOSECHA IN(3,6,9,12)                        
   and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                           
 GROUP BY  CASE                      
     WHEN @TIP_COD=7 THEN JER.RDESTER                      
     WHEN @TIP_COD=15 THEN JER.RDESCOR                      
     WHEN @TIP_COD=14 THEN JER.RDESGRU                       
     WHEN @TIP_COD=13 THEN JER.RDESADM                      
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                            
   )                  
   select * into #Datos3 from Datos  where des_ is not null                        
                         
                                      
   select  ROW_NUMBER() OVER(ORDER BY style desc) as row,* into #FCROWS3  from #Datos3 --drop table #admrows           
                                            
   select distinct  style,des_ description into #temp3 from #FCROWS3 order by style desc                                        
         
   insert into #Datos3                                      
   select  cod_fec_base_r,des_,ratio,'-1' from #Datos3 where style=0                                
                                      
   update a                                      
    set a.ratio=b.SEM                                      
    FROM #Datos3 A inner join (select a.cod_fec_base_r,a.des_,a.ratio,            
           case            
             when a.ratio >=b.ratio+@factor then -1                                      
          when a.ratio >=b.ratio then 0                                      
          when a.ratio <b.ratio  then 1 end SEM                                      
          from #Datos3 a                                      
          inner join (select cod_fec_base_r,ratio from #Datos3 where style=1)b                                      
             ON A.cod_fec_base_r=B.cod_fec_base_r                                      
             where a.style=0                                      
      )b                                      
   on a.cod_fec_base_r=b.cod_fec_base_r                                      
    and a.des_=b.des_                                      
    where a.style=-1                                      
                                      
    update a                          
    set a.des_=b.description2                                      
    from #Datos3 a inner join (select cod_fec_base_r,des_ ,'X_'+''+des_ as description2 from #Datos3)b                                      
    on a.cod_fec_base_r=b.cod_fec_base_r                                      
    and a.des_=b.des_                                      
    where a.style=-1                                       
                                      
    select ROW_NUMBER() OVER(ORDER BY style asc) as row,description into #FCROWSJSON3 from #temp3                                          
                                           
     select distinct style,description into #tempFC3 from #temp3 order by 1 desc                                      
                                      
    select ROW_NUMBER() OVER(ORDER BY style desc) as orden,                                      
    style,description into #temp1FC3 from #tempFC3                                        
                                      
                                      
                                          
    select orden,style,description,0 as hidden,'percent' as typess,'.2-2' as 'MOD' into #FinJSON3 from #temp1FC3                                      
    where style not in(1)                                      
    union all                                      
    select orden,style,'X'+'_'+description,1 as hidden,'traffic-light' as typess,null as 'MOD' from #temp1FC3                                      
    where style not in(1)                                      
    order by orden,style,description desc  --drop table #FinJSON3  select*from #FinJSON3                                      
                                      
    select ROW_NUMBER() OVER(ORDER BY style desc) orden2,* into #gg3 from #FinJSON3 order by orden asc                                      
                                      
                                    
                                    
    SET LANGUAGE spanish;                                        
    insert into @defs                                          
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TSTDEWIDTH)  values                                          
    (1,1,1,'cod_fec_base_r','FECHA','string',1,'75px')                                        
                                      
    insert into @defs                                          
      (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTDEWIDTH)                                        
      select orden+1,orden+1,1,description,description,'percent','.2-2',0,0,'100px'                                      
      from #temp1FC3 where style=1                                      
      union all                                         
      select orden2+2,orden2+2,1,description,description,typess,MOD,hidden,2,null                                      
      from #gg3 where style=0                                       
                                      
     SET LANGUAGE english;                                          
     select rep.FFTHCOLDEF(@defs) result;                                          
                                          
                                          
    select @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.des_)                                           
       FROM #Datos3 c                                         
       FOR XML PATH(''), TYPE                                          
       ).value('.', 'NVARCHAR(MAX)')                                           
      ,1,1,'')                                          
                                        
    set @query = 'SELECT cod_fec_base_r, ' + @cols + ' from                                           
       (                                        
     select cod_fec_base_r, des_, ratio                                          
     from #Datos3                                         
      ) x                                          
       pivot                                           
       (                                          
      SUM(ratio)                                          
     for des_ in (' + @cols + ')                                          
       ) p '                                 
                                          
                                          
     EXECUTE sp_executesql @query          
  END                              
END
