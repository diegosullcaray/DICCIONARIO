-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.890000
        
--EXEC [com].[GPRECOSCUAD001]   7,'231','20201130','TODO','TODO','1'                             
CREATE procedure [com].[GPRECOSCUAD001]                                        
@tip_cod int,@cod_rel varchar(20),@fec varchar(50),@prod varchar(250),@subpro varchar(250)                               
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
 select distinct cast(SFECBAS as varchar(max)) as SFECBAS from storage.[com_act].SDAS014                   
 WHERE scodagr=3              
 )                
              
 select @FechaCosechas = STUFF((SELECT  ',' + QUOTENAME(cast(c.SFECBAS as varchar(max)))                                    
 FROM Fechas c                 
 FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)') ,1,1,'')               
              
 set  @FechaCosechas=replace(replace(replace(@FechaCosechas,'-',''),'[',''),']','')       
   
 SET LANGUAGE spanish;    
  insert into @defs      
  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values      
  (1,1,1,'des_','Descripción','string',1),  
  (2,2,1,'SNUMOPEBAS','Nro Operaciones','string',0),  
  (3,3,1,'SSALCAPBAS','Monto Desembolsado','string',0)      
    
  SET LANGUAGE english;      
  select rep.FFTHCOLDEF(@defs) result;      
          
       
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
   END AS des_,SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,                    
    1 style                  
 FROM storage.[com_act].SDAS014 TS     --SELECT*FROM storage.[com_act].SDAS014                 
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                   
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC               
 WHERE case                   
   when @tip_cod=7 then '231'                  
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                   
   when @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                   
   when @tip_cod=13 then CAST(JER.RCODGRU AS VARCHAR(250))                   
   when @tip_cod=11 then CAST(JER.RCODADM AS VARCHAR(250))                   
    end = @cod_rel         
  -- and  TS.SCOSECHA=@madu   --CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                 
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
      end s, SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,                    
    0 style                  
 from storage.[com_act].SDAS014 TS                     
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                 
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC                  
 where case                   
   when @tip_cod=7 then '231'                  
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                   
   WHEN @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                   
   WHEN @TIP_COD=13 THEN CAST(JER.RCODGRU AS VARCHAR(250))                  
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/                
   --and  TS.SCOSECHA=@madu   --CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                       
 GROUP BY  CASE                  
     WHEN @TIP_COD=7 THEN JER.RDESTER                  
     WHEN @TIP_COD=15 THEN JER.RDESCOR                  
     WHEN @TIP_COD=14 THEN JER.RDESGRU                   
     WHEN @TIP_COD=13 THEN JER.RDESADM                  
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                        
   )    
   select*from  Datos where des_ is not null        
          
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
   END AS des_,SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,                   
    1 style                  
 FROM storage.[com_act].SDAS014 TS                     
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC         
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC             
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
    end = @cod_rel              
   --and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                 
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
      end s,  SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,                     
    0 style                  
 from storage.[com_act].SDAS014 TS                     
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                 
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC               
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
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/                   
  -- and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                       
 GROUP BY  CASE                  
     WHEN @TIP_COD=7 THEN JER.RDESTER                  
     WHEN @TIP_COD=15 THEN JER.RDESCOR                  
     WHEN @TIP_COD=14 THEN JER.RDESGRU                   
     WHEN @TIP_COD=13 THEN JER.RDESADM                  
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                        
   )              
   select*from  Datos where des_ is not null      
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
   END AS des_,  SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,    
    1 style                  
 FROM storage.[com_act].SDAS014 TS                  
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC         
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC             
 LEFT JOIN #SubProducto SUBPRO    
 ON TS.SCODMOD=SUBPRO.RCODMOD   AND  TS.STIPOPE= SUBPRO.RTIPOPE AND TS.SCODAGR=6        
 AND case                   
   when @tip_cod=7 then '231'                  
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                   
   when @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                   
   when @tip_cod=13 then CAST(JER.RCODGRU AS VARCHAR(250))                   
   when @tip_cod=11 then CAST(JER.RCODADM AS VARCHAR(250))                   
    end = @cod_rel         
   --and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                 
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
   SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,                  
    0 style                  
 from storage.[com_act].SDAS014 TS                     
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                 
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC               
 LEFT JOIN #SubProducto SUBPRO    
 ON TS.SCODMOD=SUBPRO.RCODMOD   AND  TS.STIPOPE= SUBPRO.RTIPOPE AND TS.SCODAGR=6               
 AND case                   
   when @tip_cod=7 then '231'                  
   when @tip_cod=15 then CAST(JER.RCODTER AS VARCHAR(250))                   
   WHEN @tip_cod=14 then CAST(JER.RCODCOR AS VARCHAR(250))                   
   WHEN @TIP_COD=13 THEN CAST(JER.RCODGRU AS VARCHAR(250))                  
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/                
 --  and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                       
 GROUP BY  CASE                  
     WHEN @TIP_COD=7 THEN JER.RDESTER                  
     WHEN @TIP_COD=15 THEN JER.RDESCOR                  
     WHEN @TIP_COD=14 THEN JER.RDESGRU                   
     WHEN @TIP_COD=13 THEN JER.RDESADM                  
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                        
   )              
    select*from  Datos where des_ is not null      
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
    SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,    
    1 style                  
 FROM storage.[com_act].SDAS014 TS                     
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC         
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC             
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
    end = @cod_rel         
  -- and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                                 
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
   SUM(TS.SNUMOPEBAS) AS SNUMOPEBAS,SUM(TS.SSALCAPBAS) SSALCAPBAS,                      
    0 style                  
 from storage.[com_act].SDAS014 TS                     
 --left join  storage.[ref].WJERCOR01 JER                  
 --ON TS.SFECPRO=JER.RFECPRO and JER.RCODSEC=TS.SCODSEC                 
 left join storage.ref.FJERCOR01_(@FechaCosechas) JER               
 on  TS.SCODSEC=JER.RCODSEC               
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
   WHEN @TIP_COD=11 THEN CAST(JER.RCODADM AS VARCHAR(250)) end = @cod_rel /*AND TS.sfecpro=@fec*/                
 --  and  TS.SCOSECHA=@madu--CASE WHEN @madu='TODO' THEN '1' else cast(TS.SCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                       
 GROUP BY  CASE                  
     WHEN @TIP_COD=7 THEN JER.RDESTER                  
     WHEN @TIP_COD=15 THEN JER.RDESCOR                  
     WHEN @TIP_COD=14 THEN JER.RDESGRU                   
     WHEN @TIP_COD=13 THEN JER.RDESADM                  
     WHEN @TIP_COD=11 THEN JER.RDESSEC END,TS.sfecbas                        
   )              
     select*from  Datos where des_ is not null      
  END                          
END
