-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-09-14 09:38:40.610000
--exec [com].[GLIMOVRO01]  2,'77678715','20220912'
 CREATE  PROCEDURE [com].[GLIMOVRO01]  
  @tip_cod int,                                        
 @cod_rel varchar(20),                                    
 @fec date      
 as
 begin
-----------------
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
                       
                                     
                                                   
  select rep.FFTHCOLDEF(@defs) result;  
 
declare @FecMax date      
set @FecMax=(SELECT max(HFECPRO) FROM STORAGE.[com_act].[HBMOV001] )
         
declare  @codbt as varchar (10),@mail as varchar (250),@es_rec as int=0  
select @codbt = HCODBT, @mail = HMAILPER from [storage].[gpr].[VPPH001] where HNUMDOC= @cod_rel  
select @es_rec = count (*) from mod_sys_admin.[dbo].[SUSEPROF01]  where SCODPROFN = 'PROF_RECUPERADOR' and SCODUSE = @mail  
--select * from mod_sys_admin.[dbo].[SUSEPROF01]  where SCODPROFN = 'PROF_RECUPERADOR'
--select * from [storage].[gpr].[VPPH001] where HMAILPER='yanela.cabreras@confianza.pe'
if (@es_rec='0')  
begin
select top 1000*   into #HBMOV001    --select * from STORAGE.[com_act].[HBMOV001] where hfecpro='2022-09-05' and  hcodsec='TYCAA005'
from  STORAGE.[com_act].[HBMOV001]  --select count(*) from STORAGE.[com_act].[HBMOV001] where hfecpro='2022-09-05'    
where hfecpro=@FecMax

SELECT 0 nivel,A.HFECREG,A.HCODSEC,A.HNUMREG,A.HMOTIV,                
       CASE                
        WHEN A.HMOTIV = 'Plan de datos' THEN ''                
       ELSE                
       case
        WHEN B.hdescli is NULL or B.hdescli ='' then 'NO ENCONTRADO' else B.hdescli end                
       END AS HDESCLI                
       ,A.HDISTR, A.HDISTR_LLEGADA,A.HCODGEOR,A.HDISTREC,A.HMONTDIS,A.HPROV, A.HDPT ,A.HCTACLI                        
FROM #HBMOV001 A                
left join  storage.[com_act].VCAH001  B                  
on A.hctacli = b.hctacli  
where   a.HMOTIV not in('TOTAL')                                        
UNION ALL        
SELECT 1 nivel,null,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,cast(SUM(HMONTDIS) as decimal(18,2)) HMONTDIS,null,null,null                                  
FROM #HBMOV001  
where HMOTIV='TOTAL'                                        
     
select top 1 HFECEMI as HFECEMI,'blue-text' as style_HFECEMI ,DATENAME(mm, HFECPRO) + ' ' + DATENAME(yyyy, HFECPRO) AS Fecha                              
from #HBMOV001                              
where  hfecpro=@FecMax

end  
else
begin
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
   WHERE A.HCODSEC=@codbt  and A.hfecpro=@FecMax  and        HMOTIV not in('TOTAL')                  
   UNION ALL                                    
   SELECT 1 nivel,null,NULL,NULL,NULL,NULL,NULL,NULL,null,'TOTAL: S/',cast(SUM(isnull(HMONTDIS,0)) as decimal(18,2)) HMONTDIS ,null,null,null                            
   FROM STORAGE.[com_act].[HBMOV001]                              
   WHERE HCODSEC=@codbt   and hfecpro=@FecMax and HMOTIV='TOTAL'     --  order by   nivel, HFECREG asc                    
                                   
   SET LANGUAGE spanish;                                  
   select top 1 max(HFECREG) as HFECEMI,'blue-text' as style_HFECEMI,DATENAME(mm, max(HFECREG)) + ' ' + DATENAME(yyyy, max(HFECREG)) AS Fecha                                  
   from STORAGE.[com_act].[HBMOV001]   --select*from STORAGE.[com_act].[HBMOV001]                                  
   WHERE HCODSEC=@codbt  and hfecpro=@FecMax  
 
end
 
end
