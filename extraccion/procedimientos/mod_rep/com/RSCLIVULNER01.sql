-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-09-22 12:41:13.460000
--exec com.RSCLIVULNER01 2,'TAAGA002','20220920'                
CREATE procedure [com].[RSCLIVULNER01]            
@tip_cod int,                                                
@cod_rel varchar(20),                                            
@fec date/*,            
@pagen int */                                          
 as                                            
begin                                            
  SET NOCOUNT ON;            
/*            
  declare @defs as rep.TTHCOLDEF;                                    
  SET LANGUAGE spanish;                                                                
  insert into @defs                                                
  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TSTBACKGROUND)  values                                                  
  (1,1,1,'HTIPDOC','Tip. documento','string',NULL,1,NULL),                                            
  (2,2,1,'HNUMDOC','Num. documento','string',NULL,1,NULL),                                            
  (3,3,1,'HPAIS','Pais','number',NULL,1,NULL),                                            
  (4,4,1,'HDESCLI','Nombre Cliente','string',NULL,1,NULL),                                    
  (5,5,1,'HSITCRE','Situación Crédito','string',NULL,1,NULL),                                
  (6,6,1,'HINDCAR','Ind.Cartera','string',NULL,1,NULL),                                        
  (7,7,1,'HCTACLI','Cta Cliente','string',NULL,1,NULL),                                                            
  (8,8,1,'HVULNERABILIDAD','Vulnerabilidad','string',NULL,1,'#164d90')                
             
    select rep.FFTHCOLDEF(@defs) result;                  
    */            
    select '[ {"label":"Tip. documento","key":"col_1"},{"label":"Num. documento","key":"col_2"},{"label":"Pais","key":"col_3"},{"label":"Nombre Cliente","key":"col_4"},{"label":"Cta Cliente","key":"col_5"},{"label":"Vulnerabilidad","key":"col_6"}]' hdefs 
   
   select  * from storage.[com_act].[WHBECA001] where HASEINI=@cod_rel
   
   /*
   select top 12 rfec into #Fec from storage.ref.RCALEN001  where RCIEBT=1 and RFEC<=eomonth(GETDATE(),-1)  order by RFEC desc    
    
  declare @FechaMaxVulnerable DATE            
  set @FechaMaxVulnerable=(select max(hfecpro) from storage.com_act.HCVF001)            
            
  select ISNULL(HVULNERABILIDAD,'Sin Segmento')HVULNERABILIDAD, HNUMCON INTO #HCVF001 from storage.com_act.HCVF001 where hfecpro=@FechaMaxVulnerable           
             
  ;with cte_a as (            
  select distinct HASEOPER,HTIPDOC,HNUMDOC,HPAIS,HDESCLI,HSITCRE,HINDCAR,HCTACLI,HDOCCON,HFECDES,HCODOPE              
  from [storage].[com_act].[VCAH001]         
  where    HINDCAR='VIGENTE' and HDIAATR<=0    AND HASEOPER=@cod_rel     
  ) ,  
  cte_cruce as (    
  select a.* from cte_a a    
  inner join ( select distinct HFECPRO,concat_ws('-',HNUMDOC,HTIPDOC,HCODPAI)  HDOCCON     
      from storage.[com_act].HBCA001    
      where HFECPRO in(select rfec from #Fec)  
     ) b     
  on a.HDOCCON=b.HDOCCON    
  ),        
  cte_b as (            
  select DISTINCT A.HASEOPER,A.HTIPDOC,A.HNUMDOC,A.HPAIS,A.HDESCLI,A.HSITCRE,A.HINDCAR,A.HCTACLI,isnull(B.HVULNERABILIDAD,'Vacío') HVULNERABILIDAD            
  from cte_cruce A            
  left join (select HVULNERABILIDAD, HNUMCON from #HCVF001 where   HVULNERABILIDAD in('Extrema Pobreza','Pobreza','Vulnerabilidad','Sin Segmento'))B            
  ON A.HDOCCON=B.HNUMCON            
  ),     
  cte_d as (         
  select  1 gru,HASEOPER as des,b.RDTIPDOC col_1,HNUMDOC col_2,HPAIS col_3,HDESCLI col_4,HCTACLI col_5,          
  case when HVULNERABILIDAD='Extrema Pobreza' then 'Luchador(a)'          
       when HVULNERABILIDAD='Pobreza' then 'Tenaz'          
       when HVULNERABILIDAD='Vulnerabilidad' then 'Perseverante'          
       when HVULNERABILIDAD='Otros' then 'Constante'          
       when HVULNERABILIDAD='Vacío' then 'Vacío'      
       when HVULNERABILIDAD='Sin Segmento' then 'Sin Segmento' end col_6,            
  case when HVULNERABILIDAD='Extrema Pobreza' then 0 else 0 end bold            
  from cte_b   a         
  left join [storage].[ref].[RDTD001] b        
  on a.HTIPDOC=b.RTIPDOC        
  )      
  SELECT distinct * FROM cte_d where col_6 in('Luchador(a)','Tenaz','Perseverante','Sin Segmento')   
  */     
            
END
