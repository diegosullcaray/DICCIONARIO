-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-09-14 09:38:54.593000
--exec [com].[GLIMOVRO06]  2,'45424585','20220822'    
--select *  from [storage].[gpr].[VPPH001]  WHERE  HCODBT='THRAA001'      
   
CREATE  PROCEDURE [com].[GLIMOVRO06]                                    
             
 @tip_cod int,                                          
 @cod_rel varchar(20),                                      
 @fec date                                    
 as                                      
begin                                      
  SET NOCOUNT ON;                                        
                                     
  declare @defs as rep.TTHCOLDEF;                              
 -- SET LANGUAGE spanish;                                                          
  insert into @defs                                          
  (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TSTBACKGROUND)  values                                            
  (1,1,1,1,'FECHA','Fecha','string',NULL,1,NULL),                                      
  (3,3,1,1,'HORA','Hora','string',NULL,1,NULL),      
  (4,4,1,1,'Cta_Cliente','Cta_Cliente','string',NULL,1,NULL),  
  (5,5,1,1,'HDESCLI',' Cliente','string',NULL,1,NULL),  
  (6,6,1,1,'Distrito','Distrito','string',NULL,1,NULL),                                  
  --(7,7,1,1,'HLATIT','Coordenada(x)','string',NULL,1,NULL),                                      
  --(8,8,1,1,'HLONG','Coordenada(y)','string',NULL,1,NULL),                              
  (9,9,1,1,'HCOMENT','Comentario','string',NULL,1,NULL),                          
  (10,10,1,1,'FILTRO2','1','string',NULL,1,NULL),                          
  (11,11,1,1,'FILTRO3','2','string',NULL,1,NULL),                        
  (12,12,1,1,'FILTRO4','3','string',NULL,1,NULL),                        
  (13,13,1,1,'FILTRO5','4','string',NULL,1,NULL),                        
  (14,14,1,1,'FILTRO6','5','string',NULL,1,NULL),                        
  (15,15,1,1,'FILTRO7','6','string',NULL,1,NULL)  
             
                                         
   SET LANGUAGE english;                                                            
  select rep.FFTHCOLDEF(@defs) result;            
         
  declare @FecMax date,  @FecMaxBT date      
set @FecMax=(SELECT max(HFECPRO) FROM STORAGE.[com_act].[HBMOV003] )          
set @FecMaxBT=(SELECT max(RFEC) FROM STORAGE.ref.RCALEN001 where rciebt =1 and eomonth(RFEC) = eomonth(@FecMax) )  

declare  @codbt as varchar (10),@mail as varchar (250),@es_rec as int=0  
select @codbt = HCODBT, @mail = HMAILPER from [storage].[gpr].[VPPH001] where HNUMDOC= @cod_rel  
select @es_rec = count (*) from mod_sys_admin.[dbo].[SUSEPROF01]  where SCODPROFN = 'PROF_RECUPERADOR' and SCODUSE = @mail        
         
if (@es_rec='0')  
begin
;with cte_a as (  
  select  
   HFECPRO,CODIGO_BT,FECHA, HORA,HLATIT,HLONG,HCOMENT,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,Cta_Cliente,Distrito  
   from [storage].[com_act].[HBMOV003]  
  where  hfecpro=@FecMax  
  )  
  ,cte_b as (  
  select   HFECPRO,HDESCLI,HCTACLI  
   from  [storage].[com_act].HCDA001  
  where  hfecpro=@FecMaxBT    
  )  
           --   select* from cte_a    
 select top 1000 A.*, B.HDESCLI from cte_a  A  
 left join cte_b B on A.Cta_Cliente = B.HCTACLI and eomonth(a.HFECPRO) = eomonth(b.HFECPRO)  
 where FILTRO2 = 'NO' or FILTRO3 = 'NO' or FILTRO4 = 'NO' or FILTRO5 = 'NO' or FILTRO6= 'NO' or FILTRO7= 'NO'  
   
end
else                  
  --por defaul en la plantilla le esta mandando el tip_cod =2                                  
  BEGIN      
  ;with cte_a as (  
  select  
   HFECPRO,CODIGO_BT,FECHA, HORA,HLATIT,HLONG,HCOMENT,FILTRO2,FILTRO3,FILTRO4,FILTRO5,FILTRO6,FILTRO7,Cta_Cliente,Distrito  
   from [storage].[com_act].[HBMOV003]  
  where  hfecpro=@FecMax and CODIGO_BT=@codbt    
  )  
  ,cte_b as (  
  select   HFECPRO,HDESCLI,HCTACLI  
   from  [storage].[com_act].HCDA001  
  where  hfecpro=@FecMaxBT    
  )  
           --   select* from cte_a    
 select distinct A.*, B.HDESCLI from cte_a  A  
 left join cte_b B on A.Cta_Cliente = B.HCTACLI and eomonth(a.HFECPRO) = eomonth(b.HFECPRO)  
 where FILTRO2 = 'NO' or FILTRO3 = 'NO' or FILTRO4 = 'NO' or FILTRO5 = 'NO' or FILTRO6= 'NO' or FILTRO7= 'NO'  
   
                                               
  ENd      
                                     
                                         
  end
