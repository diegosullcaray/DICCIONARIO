-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-12-09 15:27:45.570000

    
CREATE PROCEDURE [com].[RSMONEFE01]                  
@tip_cod int,@cod_rel varchar(20), @fecha date =  null                
AS                    
BEGIN                    
 SET NOCOUNT ON;                  
           --set @fecha = '20231031'  
 --declare @tip_cod int=7,@cod_rel varchar(20)='231', @fecha date = '20241102'                
 declare @fec varchar(8), @numSemanal int,@fecATime DATETIME= @fecha,@FecSemanal date   ,@grupo smallint          
 --select max(SFECPRO) from storage.[com_act].[SDAE002] where SCODAGR in ('3') and SFECPRO              
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)              
 set @numSemanal =(select datediff(ww, dateadd( dd, day(@fecATime) * -1, @fecATime) + 1, @fecATime) + 1)      
     
 SELECT RFEC,ROW_NUMBER() OVER(ORDER BY RFEC ASC) AS RORD into #FecSemanal    
 FROM storage.ref.RCALEN001    
 where RDIASEM=6 and RFEC between dateadd(day, 1, eomonth(@fecha, -1)) and eomonth(@fecha)    
           
 set @FecSemanal=(select RFEC from #FecSemanal where RORD=@numSemanal)    
     
  
------------------ METAS TITULOS ------------------------  
---------------------------------------------------------  
  
   --declare @tip_cod int=21,@cod_rel varchar(20) ='2',@fecha date ='20241011' ,@grupo smallint     
  
   select  top 1 @grupo= IIF(@tip_cod=7,'1',IIF(@cod_rel='9999','1',RCODGRU )  )   
    from storage.ref.WJERCOR03         
    where rfecpro=@fec and RINDFEC='actual'        
    AND case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                               
    when @tip_cod=20 then cast(RCODTER as nvarchar(10))                            
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                                 
    when @tip_cod=18 then cast(RCODUNI as varchar(250))        
    when @tip_cod=17 then cast(RCODUCO as varchar(250))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)    
   
 select x.*              
 into #b_goal              
 from (                
 select 1 HGOAL,* from [storage].[com_act].[HMMEF001] A where A.HFECPRO=eomonth(@fecha)  and RCODGRU  = @grupo            
 union all              
 select 2 HGOAL,* from [storage].[com_act].[HMMEF001] A where  a.hfecpro=@FecSemanal   and RCODGRU = @grupo  
 union all    
 select 3 HGOAL,* from [storage].[com_act].[HMMEF001] A where A.HFECPRO=@fecha     and RCODGRU = @grupo          
) x          
---------------------------------------------------------  
---------------------------------------------------------  
   
     
                  
 if(not exists(select * from #b_goal))                
 begin              
  insert into #b_goal              
  select 1,eomonth(@fecha), 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0  ,0            
  union all              
  /*select 2,@fecha, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0          
  union all              
  select 3,@FecSemanal, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0     
  */              
                 
  select 2,@FecSemanal, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0    ,0  
  union all    
  select 3,@fecha, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0     ,0  
 end              
             
 select              
 ROW_NUMBER() OVER (partition by HGOAL order by HFECPRO) row_num,              
 HGOAL goal,              
 ind,tram              
 into #goal -- drop table #goal              
 from #b_goal p              
 UNPIVOT (ind for tram IN (HTR30TO0,HTR1TO30,HTR31TO60,HTR61TO90,HTR91TO120,HTR121TO150,HTR151TO180,HTR180TO,HTRJUDI))              
 as unpvt              
               
             
 declare @defs as rep.TTHCOLDEF              
 declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int)              
 insert into @head values              
 (0,null,'Tramo (En días de Atraso)',null),(1,null,'-30 a 0',13),(2,null,'1 a 30',15),(3,null,'31 a 60',7),(4,null,'61 a 90',7),              
 (5,null,'91 a 120',7),(6,null,'121 a 150',4),(7,null,'151 a 180',4),(8,null,'> a 180',4),(9,null,'Judicial',4)              
           
             
 insert into @defs    
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)              
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,null,IIF(ord=0,1,0)              
 from @head              
 union              
 select ord,2,'h2_'+CAST(ord as varchar(10)),ISNULL(CAST(cast(b.ind*100.00 as float) as varchar(20))+' %','Meta del Mes'),cols,'green',IIF(ord=0,1,0)              
 from @head a left join  #goal b on a.ord=b.row_num and b.goal=1              
 union          
 select ord,3,'h3_'+CAST(ord as varchar(10)),ISNULL(CAST(cast(b.ind*100.00 as float) as varchar(20))+' %','Meta Semanal'),cols,'#EA705D',IIF(ord=0,1,0)              
 from @head a left join  #goal b on a.ord=b.row_num and b.goal=2        
 union all        
 select ord,4,'h4_'+CAST(ord as varchar(10)),ISNULL(CAST(cast(b.ind*100.00 as float) as varchar(20))+' %','Meta del Día'),cols,'#47C447',IIF(ord=0,1,0)              
 from @head a left join  #goal b on a.ord=b.row_num and b.goal=3    
      
 --select * from  #goal              
 --select * from @defs order by TLEV,TORDER              
             
 insert into @defs              
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values              
 (1,1,5,'descripcion','Descripción',null,3,1,'string',null),              
 --(2,2,4,'efec_m30_0','% Avance Efectividad',null,2,null,'percent','.2-2'),          
 (2,null,5,'1','Avance Efectividad',2,null,null,null,null),                
 (3,4,5,'sal_ini_m30_0','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (4,5,5,'nope_ini_m30_0','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (5,6,5,'num_ope_ges_m30_0','# Operaciones Gestionadas',null,3,null,'number','.0-0'),              
 (6,null,5,'2','Deterioro de la cartera',8,null,null,null,null),       ------------------------------              
               
 --(7,13,4,'efec_1_30','% Avance Efectividad',null,3,null,'percent','.2-2'),          
 (7,null,5,'3','Avance Efectividad',2,null,null,null,null),            
 (8,17,5,'sal_ini_1_30','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (9,18,5,'nope_ini_1_30','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (10,19,5,'recu_1_30','Saldo Recuperado S/.',null,3,null,'number','.0-0'),              
 (11,null,5,'6','Deterioro de la cartera',6,null,null,null,null),      
 (12,null,5,'7','Compromisos del Dia',2,null,null,null,null),              
 (13,null,5,'8','Compromisos Rotos',2,null,null,null,null),              
             
 (14,30,5,'efec_31_60','% Avance Efectividad',null,3,null,'percent','.2-2'),              
 (15,31,5,'sal_ini_31_60','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (16,32,5,'nope_ini_31_60','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (17,33,5,'recu_31_60','Saldo Recuperado S/.',null,3,null,'number','.0-0'),              
 (18,null,5,'13','',3,null,null,null,null),              
             
 (19,37,5,'efec_61_90','% Avance Efectividad',null,3,null,'percent','.2-2'),              
 (20,38,5,'saldo_ini_5','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (21,39,5,'num_ope_ini_5','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (22,40,5,'recu_5','Saldo Recuperado S/.',null,3,null,'number','.0-0'),              
 (23,null,5,'18','',3,null,null,null,null),              
             
 (24,44,5,'efec_91_120','% Avance Efectividad',null,3,null,'percent','.2-2'),              
 (25,45,5,'saldo_ini_6','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (26,46,5,'num_ope_ini_6','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (27,47,5,'recu_6','Saldo Recuperado S/.',null,3,null,'number','.0-0'),              
 (28,null,5,'23','',3,null,null,null,null),              
             
 (29,51,5,'efec_121_150','% Avance Efectividad',null,3,null,'percent','.2-2'),              
 (30,52,5,'saldo_ini_7','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (31,53,5,'num_ope_ini_7','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (32,54,5,'saldo_det_7','Saldo Deteriorado S/.',null,3,null,'number','.0-0'),              
             
 (33,55,5,'efec_151_180','% Avance Efectividad',null,3,null,'percent','.2-2'),              
 (34,56,5,'saldo_ini_8','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (35,57,5,'num_ope_ini_8','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (36,58,5,'saldo_det_8','Saldo Deteriorado S/.',null,3,null,'number','.0-0'),              
             
 (37,59,5,'efec_180','% Avance Efectividad',null,3,null,'percent','.2-2'),              
 (38,60,5,'saldo_ini_9','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (39,61,5,'num_ope_ini_9','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (40,62,5,'recu_9','Saldo Cobrado S/.',null,3,null,'number','.0-0'),              
             
 (41,63,5,'efec_jud','% Avance Efectividad',null,3,null,'percent','.2-2'),              
 (42,64,5,'saldo_ini_10','Saldo Inicial S/.',null,3,null,'number','.0-0'),              
 (43,65,5,'num_ope_ini_10','# Operaciones Inicio',null,3,null,'number','.0-0'),              
 (44,66,5,'recu_10','Saldo Cobrado S/.',null,3,null,'number','.0-0')              
             
 insert into @defs          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TFORTYP,TFORMOD,TSTBACKGROUND)  values      
 (1,2,6,'efec_num_ope_m30_0','# Operaciones',null,2,'percent','.2-2',NULL),              
 (2,3,6,'efec_m30_0','% Saldo',null,2,'percent','.2-2','#EA705D'),            
         
 (3,7,6,'num_ope_man_ven_m30_0','# Operaciones Por Vencer',null,2,'number','.0-0',NULL),              
 (4,8,6,'saldo_man_ven_m30_0','Saldo Por Vencer S/',null,2,'number','.0-0',NULL),              
 (5,9,6,'num_ope_det_m30_0','# Operaciones Deterioradas',null,2,'number','.0-0',NULL),              
 (6,null,6,'600','Saldo Deteriorado',3,null,null,null,NULL),      
 (66,10,7,'sal_det_m1_8','1 A 8',null,null,'number','.0-0',NULL),          
 (67,11,7,'sal_det_m9_30','9 A 30',null,null,'number','.0-0',NULL),          
 (68,12,7,'sal_det_m30_0','Total',null,null,'number','.0-0',NULL),          
     
 (7,13,6,'cob_g_m30_0','% Cobertura de Gestión',null,2,'percent','.2-2',NULL),              
 (8,14,6,'int_g_m30_0','Intensidad de Gestión',null,2,'number','.2-2',NULL),          
         
 (9,15,6,'efec_num_ope_1_30','# Operaciones',null,2,'percent','.2-2',NULL),      
 (10,16,6,'efec_1_30','% Saldo',null,2,'percent','.2-2','#EA705D'),      
             
 (11,20,6,'num_ope_man_ven_1_30','# Operaciones por Deteriorar',null,2,'number','.0-0',NULL),              
 (12,21,6,'saldo_man_ven_1_30','Saldo por Deteriorar S/',null,2,'number','.0-0',NULL),              
 (13,22,6,'num_ope_det_1_30','# Operaciones Deterioradas',null,2,'number','.0-0',NULL),              
 (14,23,6,'saldo_det_1_30','Saldo Deteriorado S/.',null,2,'number','.0-0',NULL),              
 (15,24,6,'cob_g_1_30','% Cobertura de Gestión',null,2,'percent','.2-2',NULL),              
 (16,25,6,'int_g_1_30','Intensidad de Gestión',null,2,'number','.2-2',NULL),              
           
 (17,26,6,'ope_pp_1_30','# Operaciones',null,2,'number','.0-0',NULL),              
 (18,27,6,'mon_pp_1_30','Monto S/.',null,2,'number','.0-0',NULL),              
 (19,28,6,'ope_pr_1_30','# Operaciones',null,2,'number','.0-0',NULL),              
 (20,29,6,'mon_pr_1_30','Monto S/.',null,2,'number','.0-0',NULL),          
             
 (21,34,6,'saldo_det_4','Saldo Deteriorado S/.',null,2,'number','.0-0',NULL),              
 (22,35,6,'cob_g_4','% Cobertura de Gestión',null,2,'percent','.2-2',NULL),              
 (23,36,6,'int_g_4','Intensidad de Gestión',null,2,'number','.2-2',NULL),        
             
 (24,41,6,'saldo_det_5','Saldo Deteriorado S/.',null,2,'number','.0-0',NULL),              
 (25,42,6,'cob_g_5','% Cobertura de Gestión',null,2,'percent','.2-2',NULL),              
 (26,43,6,'int_g_5','Intensidad de Gestión',null,2,'number','.2-2',NULL),              
             
 (27,48,6,'saldo_det_6','Saldo Deteriorado S/.',null,2,'number','.0-0',NULL),              
 (28,49,6,'cob_g_6','% Cobertura de Gestión',null,2,'percent','.2-2',NULL),              
 (29,50,6,'int_g_6','Intensidad de Gestión',null,2,'number','.2-2',NULL)          
       
 --insert into @defs              
 --(TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values            
 --(1,10,6,'100','1 A 8','number','.0-0'),            
 --(2,11,6,'101','9 A 30','number','.0-0'),      
 --(3,12,6,'sal_det_m30_0','1 A 30','number','.0-0') --      
           
 --select * from @defs              
 select rep.FFTHCOLDEF(@defs) result;                  
             
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF              
             
insert into @tvars              
values              
--clave,formula,alias,tipo(cal/reg),ejecucion(ap/dp),tipo dato              
--cal:calculado,reg:regular              
--ap:antes del pivo,dp: despues del pivot          
('efec_num_ope_m30_0',null,null,null,null,null),              
('efec_m30_0',null,null,null,null,null),              
('style_efec_m30_0','case when 1=1 then ''#FFF'' when 2=1 then ''#FFA'' end','style_efec_m30_0','cal','dp','varchar(250)'),              
('sal_ini_m30_0',null,null,null,null,null),              
('nope_ini_m30_0',null,null,null,null,null),              
('num_ope_ges_m30_0',null,null,null,null,null),              
('num_ope_man_ven_m30_0',null,null,null,null,null),              
('saldo_man_ven_m30_0',null,null,null,null,null),              
('num_ope_det_m30_0',null,null,null,null,null),            
('sal_det_m1_8',null,null,null,null,null),      
('sal_det_m9_30',null,null,null,null,null),      
('sal_det_m30_0',null,null,null,null,null),              
('cob_g_m30_0',null,null,null,null,null),              
('int_g_m30_0',null,null,null,null,null),              
         
('efec_num_ope_1_30',null,null,null,null,null),              
('efec_1_30',null,null,null,null,null),              
('sal_ini_1_30',null,null,null,null,null),              
('nope_ini_1_30',null,null,null,null,null),              
('recu_1_30',null,null,null,null,null),              
('num_ope_man_ven_1_30',null,null,null,null,null),              
('saldo_man_ven_1_30',null,null,null,null,null),              
('num_ope_det_1_30',null,null,null,null,null),              
('saldo_det_1_30',null,null,null,null,null),              
('cob_g_1_30',null,null,null,null,null),              
('int_g_1_30',null,null,null,null,null),              
('ope_pp_1_30',null,null,null,null,null),              
('mon_pp_1_30',null,null,null,null,null),              
('ope_pr_1_30',null,null,null,null,null),              
('mon_pr_1_30',null,null,null,null,null),              
             
('efec_31_60',null,null,null,null,null),              
('sal_ini_31_60',null,null,null,null,null),              
('nope_ini_31_60',null,null,null,null,null),              
('recu_31_60',null,null,null,null,null),              
('saldo_det_4',null,null,null,null,null),              
('cob_g_4',null,null,null,null,null),              
('int_g_4',null,null,null,null,null),              
             
('efec_61_90',null,null,null,null,null),              
('saldo_ini_5',null,null,null,null,null),              
('num_ope_ini_5',null,null,null,null,null),              
('recu_5',null,null,null,null,null),              
('saldo_det_5',null,null,null,null,null),              
('cob_g_5',null,null,null,null,null),              
('int_g_5',null,null,null,null,null),              
             
('efec_91_120',null,null,null,null,null),              
('saldo_ini_6',null,null,null,null,null),              
('num_ope_ini_6',null,null,null,null,null),              
('recu_6',null,null,null,null,null),              
('saldo_det_6',null,null,null,null,null),              
('cob_g_6',null,null,null,null,null),              
('int_g_6',null,null,null,null,null),              
             
('efec_121_150',null,null,null,null,null),              
('saldo_ini_7',null,null,null,null,null),              
('num_ope_ini_7',null,null,null,null,null),              
('saldo_det_7',null,null,null,null,null),              
             
('efec_151_180',null,null,null,null,null),              
('saldo_ini_8',null,null,null,null,null),              
('num_ope_ini_8',null,null,null,null,null),              
('saldo_det_8',null,null,null,null,null),              
             
('efec_180',null,null,null,null,null),              
('saldo_ini_9',null,null,null,null,null),              
('num_ope_ini_9',null,null,null,null,null),              
('recu_9',null,null,null,null,null),              
             
('efec_jud',null,null,null,null,null),              
('saldo_ini_10',null,null,null,null,null),              
('num_ope_ini_10',null,null,null,null,null),              
('recu_10',null,null,null,null,null)              
--declare @fec varchar(8)='20200801'              
insert into @tfil              
values              
--tabla,clave,valores (usar la doble comilla para valores texto/fecha)              
('todos','fec',''+@fec+'')--,              
--('todos','prod_com','16')--,              
--('todos','reg','1')              
             
--declare @tip_cod int=15,@cod_rel varchar(100)='2'              
declare @jer varchar(100);              
insert into @tfil              
exec piv.GPIVLEV04 @tip_cod,@cod_rel,@jer output              
             
insert into @tconf              
values              
('level_alias','style')              
             
--los valores rows y columnas van separados por comas y cada valor entre doble comilla              
--'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion        
     
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf  -- ,@show_query=1              
             
             
END
