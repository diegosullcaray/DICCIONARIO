-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-09-19 18:47:06.493000
--exec [com].[GLIMOVO01]  7,'231','20220621'              
 CREATE  PROCEDURE [com].[GLIMOVO01]                                  
           
  @tip_cod int,                                        
 @cod_rel varchar(20),                                    
 @fec date                                   
 as                                    
begin                                    
  SET NOCOUNT ON;                                       
                                    
  declare @defs as rep.TTHCOLDEF;                            
  SET LANGUAGE spanish;                                                        
  insert into @defs                                        
  (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TSTBACKGROUND)  values                                          
  (1,1,2,1,'HFECREG','Fecha','string',NULL,1,NULL),                                    
  (3,3,2,1,'HMOTIV','Motivo de Desplazamiento','string',NULL,1,NULL),                                    
  (4,4,2,1,'HCTACLI','Cta Cliente','number',NULL,1,NULL),                                    
  (5,5,2,1,'HDESCLI','Nombre Cliente','string',NULL,1,NULL),                            
  (6,6,2,1,'HDISTR','Distrito inicio','string',NULL,1,NULL),                         
  (7,7,2,1,'HDISTR_LLEGADA','Distrito llegada','string',NULL,1,NULL),                                 
  (9,9,2,1,'HDISTREC','Distancia Recorrida (KM)','string',NULL,1,NULL),                                                     
  (10,10,2,1,'HMONTDIS','','string',NULL,1,'#164d90')                    
                       
                                      
   SET LANGUAGE english;                                                          
  select rep.FFTHCOLDEF(@defs) result;           
        
  declare @FecMax date      
set @FecMax=(SELECT max(HFECPRO) FROM STORAGE.[com_act].[HBMOV001] )        
     
if  @tip_cod<>2    
begin    
select *  into #WJERCOR3   --select * from #WJERCOR3                
 from  storage.[ref].WJERCOR03                 
 where RINDFEC='ACTUAL' and RFECPRO=@fec                
 and case when @tip_cod=7 then '1'                  
          when @tip_cod=21 then cast(RCODGRU as varchar(250))                  
          when @tip_cod=20 then cast(RCODTER as varchar(250))                  
          when @tip_cod=19 then cast(RCODCOR as varchar(250))                  
          when @tip_cod=18 then cast(RCODUNI as varchar(250))      
    when @tip_cod=2 then RCODSEC end = case when @tip_cod=7 then '1' else @cod_rel end                  
                 
      
;with cte_a as (      
select *      
from  STORAGE.[com_act].[HBMOV001]      
where hfecpro=@FecMax --and HMOTIV not in('TOTAL')          
)      
       
select a.* into #HBMOV001      
from cte_a a      
INNER join #WJERCOR3 b      
on a.hcodsec=b.RCODSEC        
       
SELECT 0 nivel,A.HFECREG,A.HCODSEC,A.HNUMREG,A.HMOTIV,                
       CASE                
        WHEN A.HMOTIV = 'Plan de datos' THEN ''                
       ELSE                 
       case WHEN B.hdescli is NULL or B.hdescli ='' then 'NO ENCONTRADO' else B.hdescli end                
       END AS HDESCLI                
       ,A.HDISTR, A.HDISTR_LLEGADA,A.HCODGEOR,A.HDISTREC,A.HMONTDIS,A.HPROV, A.HDPT ,A.HCTACLI                         
FROM #HBMOV001 A --SELECT*FROM  STORAGE.[com_act].[HBMOV001]  order by hfecpro desc                
left join  storage.[com_act].VCAH001  B                   
on A.hctacli = b.hctacli --SELECT*FROM  STORAGE.[com_act].[HBMOV001]        
where   a.HMOTIV not in('TOTAL')                                     
 --  where  A.hfecpro=@FecMax     and  HMOTIV not in('TOTAL')          
UNION ALL         
SELECT 1 nivel,null,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,cast(SUM(isnull(HMONTDIS,0)) as decimal(18,2)) HMONTDIS,null,null,null                                   
FROM #HBMOV001-- STORAGE.[com_act].[HBMOV001]          
where HMOTIV='TOTAL'                                     
--where  hfecpro=@FecMax and HMOTIV='TOTAL'                 
      
select top 1 HFECEMI as HFECEMI,'blue-text' as style_HFECEMI ,DATENAME(mm, HFECPRO) + ' ' + DATENAME(yyyy, HFECPRO) AS Fecha                              
from #HBMOV001                              
where  hfecpro=@FecMax       
end    
    
if (@tip_cod=2)                  
  --por defaul en la plantilla le esta mandando el tip_cod =2                                  
  BEGIN                  
   SELECT 0 nivel,A.HFECREG,A.HCODSEC,A.HNUMREG,A.HMOTIV,                
   CASE                
    WHEN A.HMOTIV = 'Plan de datos' THEN ''                
    ELSE                 
 case WHEN B.hdescli is NULL or B.hdescli ='' then 'NO ENCONTRADO' else B.hdescli end                
   END AS HDESCLI,                   
   A.HDISTR, A.HDISTR_LLEGADA,A.HCODGEOR,A.HDISTREC,A.HMONTDIS,A.HPROV, A.HDPT ,A.HCTACLI                         
   FROM STORAGE.[com_act].[HBMOV001] A --SELECT*FROM  STORAGE.[com_act].[HBMOV001]                  
   left join   (select distinct hctacli,hdescli  from storage.[com_act].VCAH001 )  B                   
   on A.hctacli = b.hctacli                                      
   WHERE A.HNUMDOC=@cod_rel  and A.hfecpro=@FecMax  and        HMOTIV not in('TOTAL')                   
   UNION ALL                                    
   SELECT 1 nivel,null,NULL,NULL,NULL,NULL,NULL,NULL,null,'TOTAL: S/',cast(SUM(isnull(HMONTDIS,0)) as decimal(18,2)) HMONTDIS ,null,null,null                             
   FROM STORAGE.[com_act].[HBMOV001]                              
   WHERE HNUMDOC=@cod_rel   and hfecpro=@FecMax and HMOTIV='TOTAL'     --  order by   nivel, HFECREG asc                     
                                    
   SET LANGUAGE spanish;                                  
   select top 1 max(HFECREG) as HFECEMI,'blue-text' as style_HFECEMI,DATENAME(mm, max(HFECREG)) + ' ' + DATENAME(yyyy, max(HFECREG)) AS Fecha                                  
   from STORAGE.[com_act].[HBMOV001]   --select*from STORAGE.[com_act].[HBMOV001]                                  
   WHERE HNUMDOC=@cod_rel  and hfecpro=@FecMax                                                    
  END     
                                    
                                    
  /*declare @tabla Nvarchar(max),@union varchar(250),@condicion varchar(250)='',@rcodjer varchar(50) ,@FecMax date                                   
  declare @sql Nvarchar(max)                                    
 if @tip_cod=21                                    
  begin                                    
   set @tabla='storage.ref.RECTFC001'                                    
   set @union='b.RUSUADM'                                    
   select @cod_rel= rusuadm from storage.ref.RECTFC001 where rcodter=@cod_rel                                    
  end                                    
 if @tip_cod=14                                    
  begin                                    
    set @tabla='storage.ref.RECCT001'                                    
 set @union='b.RUSUADM'                                    
 select @cod_rel= rusuadm from storage.ref.RECCT001 where RCODCOR=@cod_rel                                    
  end                                    
  if @tip_cod=11                                    
  begin                                    
    set @tabla='storage.[ref].WJERCOR01'                                    
 set @union='b.rcodadm'                                    
 set @condicion=' and B.RFECPRO='+''''+cast(@fec as varchar(250))+''''                                    
  end                                    
                                  
  set @FecMax=(SELECT max(HFECPRO) FROM STORAGE.[com_act].[HBMOV001] )                                     
                                      
  if (@tip_cod=2)                  
  --por defaul en la plantilla le esta mandando el tip_cod =2                                  
  BEGIN                  
   SELECT 0 nivel,A.HFECREG,A.HCODSEC,A.HNUMREG,A.HMOTIV,                
   CASE                
    WHEN A.HMOTIV = 'Plan de datos' THEN ''                
    ELSE      
 case WHEN B.hdescli is NULL or B.hdescli ='' then 'NO ENCONTRADO' else B.hdescli end                
   END AS HDESCLI,                   
   A.HDISTR, A.HDISTR_LLEGADA,A.HCODGEOR,A.HDISTREC,A.HMONTDIS,A.HPROV, A.HDPT ,A.HCTACLI                         
   FROM STORAGE.[com_act].[HBMOV001] A --SELECT*FROM  STORAGE.[com_act].[HBMOV001]                  
   left join  storage.[com_act].VCAH001  B                   
   on A.hctacli = b.hctacli                                      
   WHERE A.HNUMDOC=@cod_rel  and A.hfecpro=@FecMax  and        HMOTIV not in('TOTAL')                   
   UNION ALL                                    
   SELECT 1 nivel,null,NULL,NULL,NULL,NULL,NULL,NULL,null,'TOTAL: S/',cast(SUM(HMONTDIS) as decimal(18,2)) HMONTDIS ,null,null,null                             
   FROM STORAGE.[com_act].[HBMOV001]                              
   WHERE HNUMDOC=@cod_rel   and hfecpro=@FecMax and HMOTIV='TOTAL'       order by   nivel, HFECREG asc                     
                                    
   SET LANGUAGE spanish;                                  
   select top 1 max(HFECREG) as HFECEMI,'blue-text' as style_HFECEMI,DATENAME(mm, max(HFECREG)) + ' ' + DATENAME(yyyy, max(HFECREG)) AS Fecha                                  
   from STORAGE.[com_act].[HBMOV001]   --select*from STORAGE.[com_act].[HBMOV001]                                  
   WHERE HNUMDOC=@cod_rel  and hfecpro=@FecMax                                                    
  END                                    
                
  if (@tip_cod=7)                   
  BEGIN                                    
   SELECT 0 nivel,A.HFECREG,A.HCODSEC,A.HNUMREG,A.HMOTIV,                
   CASE                
    WHEN A.HMOTIV = 'Plan de datos' THEN ''                
    ELSE                 
 case WHEN B.hdescli is NULL or B.hdescli ='' then 'NO ENCONTRADO' else B.hdescli end                
   END AS HDESCLI                
   ,A.HDISTR, A.HDISTR_LLEGADA,A.HCODGEOR,A.HDISTREC,A.HMONTDIS,A.HPROV, A.HDPT ,A.HCTACLI                         
   FROM STORAGE.[com_act].[HBMOV001] A --SELECT*FROM  STORAGE.[com_act].[HBMOV001]  order by hfecpro desc                
   left join  storage.[com_act].VCAH001  B                   
   on A.hctacli = b.hctacli --SELECT*FROM  STORAGE.[com_act].[HBMOV001]                                    
   where  A.hfecpro=@FecMax     and  HMOTIV not in('TOTAL')                              
   UNION ALL                            
   SELECT 1 nivel,null,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,cast(SUM(HMONTDIS) as decimal(18,2)) HMONTDIS,null,null,null                                   
   FROM STORAGE.[com_act].[HBMOV001]                                    
   where  hfecpro=@FecMax and HMOTIV='TOTAL'                                 
                                    
   select top 1 HFECEMI as HFECEMI,'blue-text' as style_HFECEMI ,DATENAME(mm, HFECPRO) + ' ' + DATENAME(yyyy, HFECPRO) AS Fecha                                  
   from STORAGE.[com_act].[HBMOV001]                                    
   where  hfecpro=@FecMax                                               
  END                 
                                     
  ELSE                 
                                     
  BEGIN                                    
    SET @sql =' ;with a as (                                    
    SELECT A.HCODSEC,A.HNUMREG,A.HFECREG,A.HMOTIV,CASE                
    WHEN A.HMOTIV = ''Plan de datos'' THEN ''''                
    ELSE                 
 case WHEN B.hdescli is NULL or B.hdescli ='''' then ''NO ENCONTRADO'' else B.hdescli end                
   END AS HDESCLI,A.HDISTR, A.HDISTR_LLEGADA,A.HCODGEOR,A.HDISTREC,A.HMONTDIS,A.HPROV, A.HDPT ,A.HCTACLI                              
   FROM STORAGE.[com_act].[HBMOV001] A --SELECT*FROM  STORAGE.[com_act].[HBMOV001]                  
   left join  storage.[com_act].VCAH001  B                   
   on A.hctacli = b.hctacli                                   
   where A.HCODSEC='+''''+@cod_rel+'''  and A.hfecpro='''+cast(@FecMax as varchar(50))+'''  and        HMOTIV not in(''TOTAL'')                                 
  )                                    
   SELECT distinct HCODSEC,HNUMREG,HFECREG,HMOTIV,HDESCLI,HDISTR,HCODGEOR,HDISTREC,HMONTDIS,HPROV, HDPT ,HCTACLI                                    
   FROM a a                                    
   left join '+@tabla+' b on a.hcodsec='+@union+''+@condicion+'               
   union all                                    
   SELECT null,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CAST(cast(SUM(HMONTDIS) as decimal(18,2)) AS VARCHAR(MAX)) HMONTDIS ,null,null                                  
   FROM STORAGE.[com_act].[HBMOV001]                                    
   WHERE HCODSEC='+''''+@cod_rel+'''  and hfecpro='''+cast(@FecMax as varchar(50))+''' and HMOTIV=''TOTAL''                                       
   order by HFECREG desc                                    
                   
   select top 1 HFECEMI as HFECEMI,''blue-text'' as style_HFECEMI,DATENAME(mm, HFECREG) + '' '' + DATENAME(yyyy, HFECREG) AS Fecha                                    
   from STORAGE.[com_act].[HBMOV001]                                    
   WHERE HCODSEC='+''''+@cod_rel+'''  and hfecpro='''+cast(@FecMax as varchar(50))+'''                             
   '                                    
   EXECUTE sp_executesql @sql                              
  --Print @sql                 
                                
  END        
  */                                  
  end
