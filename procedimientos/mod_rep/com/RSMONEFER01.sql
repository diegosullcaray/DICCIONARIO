-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-08-23 10:21:01.350000
--exec [com].[RSMONEFER01] 7,'231','20230821'
--exec [com].[RSMONEFER02] 7,'231', 'TODO','TODO','TODO','TODO','TODO','%%','TODO','TODO',1,'TODO'
--drop table #b_goal,#goal
CREATE PROCEDURE [com].[RSMONEFER01]  
--monitor efectividades reasignado
@tip_cod int,@cod_rel varchar(20), @fecha date = null          
AS              
BEGIN              
 SET NOCOUNT ON;            
      
 --declare @tip_cod int=7,@cod_rel varchar(20)='231', @fecha date = '20230819'          
 declare @fec varchar(8);        
 --select max(SFECPRO) from storage.[com_act].[SDAE002] where SCODAGR in ('3') and SFECPRO        
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)        
        
 select x.*        
 into #b_goal        
 from (        
 select 1 HGOAL,* from [storage].[com_act].[HMMEF001] A where A.HFECPRO=eomonth(@fecha)        
 union all        
 select 2 HGOAL,* from [storage].[com_act].[HMMEF001] A where A.HFECPRO=@fecha        
 ) x        
           
 if(not exists(select * from #b_goal))          
 begin        
  insert into #b_goal        
  select 1,eomonth(@fecha), 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0         
  union all         
  select 2,@fecha, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0          
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
 select ord,3,'h3_'+CAST(ord as varchar(10)),ISNULL(CAST(cast(b.ind*100.00 as float) as varchar(20))+' %','Meta del Día'),cols,'#22ad22',IIF(ord=0,1,0)        
 from @head a left join  #goal b on a.ord=b.row_num and b.goal=2   
         

 
        
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values        
 (1,1,4,'descripcion','Descripción',null,3,1,'string',null),        
 --(2,2,4,'efec_m30_0','% Avance Efectividad',null,2,null,'percent','.2-2'),     
 (2,null,4,'1','Avance Efectividad',2,null,null,null,null),          
 (3,4,4,'reasig_sal_ini_m30_0','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (4,5,4,'reasig_nope_ini_m30_0','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (5,6,4,'reasig_num_ope_ges_m30_0','# Operaciones Gestionadas',null,3,null,'number','.0-0'),        
 (6,null,4,'2','Deterioro de la cartera',8,null,null,null,null),       ------------------------------        
         
 --(7,13,4,'efec_1_30','% Avance Efectividad',null,3,null,'percent','.2-2'),     
 (7,null,4,'3','Avance Efectividad',2,null,null,null,null),      
 (8,17,4,'reasig_sal_ini_1_30','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (9,18,4,'reasig_nope_ini_1_30','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (10,19,4,'reasig_recu_1_30','Saldo Recuperado S/.',null,3,null,'number','.0-0'),        
 (11,null,4,'6','Deterioro de la cartera',6,null,null,null,null), 
 (12,null,4,'7','Compromisos del Dia',2,null,null,null,null),        
 (13,null,4,'8','Compromisos Rotos',2,null,null,null,null),        
        
 (14,30,4,'reasig_efec_31_60','% Avance Efectividad',null,3,null,'percent','.2-2'),        
 (15,31,4,'reasig_sal_ini_31_60','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (16,32,4,'reasig_nope_ini_31_60','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (17,33,4,'reasig_recu_31_60','Saldo Recuperado S/.',null,3,null,'number','.0-0'),        
 (18,null,4,'13','',3,null,null,null,null),        
        
 (19,37,4,'reasig_efec_61_90','% Avance Efectividad',null,3,null,'percent','.2-2'),        
 (20,38,4,'reasig_saldo_ini_5','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (21,39,4,'reasig_num_ope_ini_5','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (22,40,4,'reasig_recu_5','Saldo Recuperado S/.',null,3,null,'number','.0-0'),        
 (23,null,4,'18','',3,null,null,null,null),        
        
 (24,44,4,'reasig_efec_91_120','% Avance Efectividad',null,3,null,'percent','.2-2'),        
 (25,45,4,'reasig_saldo_ini_6','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (26,46,4,'reasig_num_ope_ini_6','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (27,47,4,'reasig_recu_6','Saldo Recuperado S/.',null,3,null,'number','.0-0'),        
 (28,null,4,'23','',3,null,null,null,null),        
        
 (29,51,4,'reasig_efec_121_150','% Avance Efectividad',null,3,null,'percent','.2-2'),        
 (30,52,4,'reasig_saldo_ini_7','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (31,53,4,'reasig_num_ope_ini_7','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (32,54,4,'reasig_saldo_det_7','Saldo Deteriorado S/.',null,3,null,'number','.0-0'),        
        
 (33,55,4,'reasig_efec_151_180','% Avance Efectividad',null,3,null,'percent','.2-2'),        
 (34,56,4,'reasig_saldo_ini_8','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (35,57,4,'reasig_num_ope_ini_8','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (36,58,4,'reasig_saldo_det_8','Saldo Deteriorado S/.',null,3,null,'number','.0-0'),        
        
 (37,59,4,'reasig_efec_180','% Avance Efectividad',null,3,null,'percent','.2-2'),        
 (38,60,4,'reasig_saldo_ini_9','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (39,61,4,'reasig_num_ope_ini_9','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (40,62,4,'reasig_recu_9','Saldo Cobrado S/.',null,3,null,'number','.0-0'),        
        
 (41,63,4,'reasig_efec_jud','% Avance Efectividad',null,3,null,'percent','.2-2'),        
 (42,64,4,'reasig_saldo_ini_10','Saldo Inicial S/.',null,3,null,'number','.0-0'),        
 (43,65,4,'reasig_num_ope_ini_10','# Operaciones Inicio',null,3,null,'number','.0-0'),        
 (44,66,4,'reasig_recu_10','Saldo Cobrado S/.',null,3,null,'number','.0-0')        
        
 insert into @defs    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TFORTYP,TFORMOD)  values      
 (1,2,5,'reasig_efec_num_ope_m30_0','# Operaciones',null,2,'percent','.2-2'),        
 (2,3,5,'reasig_efec_m30_0','% Saldo',null,2,'percent','.2-2'),      
    
 (3,7,5,'reasig_num_ope_man_ven_m30_0','# Operaciones Por Vencer',null,2,'number','.0-0'),        
 (4,8,5,'reasig_saldo_man_ven_m30_0','Saldo Por Vencer S/',null,2,'number','.0-0'),        
 (5,9,5,'reasig_num_ope_det_m30_0','# Operaciones Deterioradas',null,2,'number','.0-0'),        
 (6,null,5,'600','Saldo Deteriorado',3,null,null,null), 
 (66,10,6,'reasig_sal_det_m1_8','1 A 8',null,null,'number','.0-0'),    
 (67,11,6,'reasig_sal_det_m9_30','9 A 30',null,null,'number','.0-0'),    
 (68,12,6,'reasig_sal_det_m30_0','Total',null,null,'number','.0-0'),    

 (7,13,5,'reasig_cob_g_m30_0','% Cobertura de Gestión',null,2,'percent','.2-2'),        
 (8,14,5,'reasig_int_g_m30_0','Intensidad de Gestión',null,2,'number','.2-2'),     
    
 (9,15,5,'reasig_efec_num_ope_1_30','# Operaciones',null,2,'percent','.2-2'), 
 (10,16,5,'reasig_efec_1_30','% Saldo',null,2,'percent','.2-2'), 
        
 (11,20,5,'reasig_num_ope_man_ven_1_30','# Operaciones por Deteriorar',null,2,'number','.0-0'),        
 (12,21,5,'reasig_saldo_man_ven_1_30','Saldo por Deteriorar S/',null,2,'number','.0-0'),        
 (13,22,5,'reasig_num_ope_det_1_30','# Operaciones Deterioradas',null,2,'number','.0-0'),        
 (14,23,5,'reasig_saldo_det_1_30','Saldo Deteriorado S/.',null,2,'number','.0-0'),        
 (15,24,5,'reasig_cob_g_1_30','% Cobertura de Gestión',null,2,'percent','.2-2'),        
 (16,25,5,'reasig_int_g_1_30','Intensidad de Gestión',null,2,'number','.2-2'),        
      
 (17,26,5,'reasig_ope_pp_1_30','# Operaciones',null,2,'number','.0-0'),        
 (18,27,5,'reasig_mon_pp_1_30','Monto S/.',null,2,'number','.0-0'),        
 (19,28,5,'reasig_ope_pr_1_30','# Operaciones',null,2,'number','.0-0'),        
 (20,29,5,'reasig_mon_pr_1_30','Monto S/.',null,2,'number','.0-0'),     
        
 (21,34,5,'reasig_saldo_det_4','Saldo Deteriorado S/.',null,2,'number','.0-0'),        
 (22,35,5,'reasig_cob_g_4','% Cobertura de Gestión',null,2,'percent','.2-2'),        
 (23,36,5,'reasig_int_g_4','Intensidad de Gestión',null,2,'number','.2-2'),   
        
 (24,41,5,'reasig_saldo_det_5','Saldo Deteriorado S/.',null,2,'number','.0-0'),        
 (25,42,5,'reasig_cob_g_5','% Cobertura de Gestión',null,2,'percent','.2-2'),        
 (26,43,5,'reasig_int_g_5','Intensidad de Gestión',null,2,'number','.2-2'),        
        
 (27,48,5,'reasig_saldo_det_6','Saldo Deteriorado S/.',null,2,'number','.0-0'),        
 (28,49,5,'reasig_cob_g_6','% Cobertura de Gestión',null,2,'percent','.2-2'),        
 (29,50,5,'reasig_int_g_6','Intensidad de Gestión',null,2,'number','.2-2')    
 


     
 --select * from @defs        
 select rep.FFTHCOLDEF(@defs) result;        
        
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF        
        
insert into @tvars        
values         
--clave,formula,alias,tipo(cal/reg),ejecucion(ap/dp),tipo dato        
--cal:calculado,reg:regular        
--ap:antes del pivo,dp: despues del pivot     
('reasig_efec_num_ope_m30_0',null,null,null,null,null),        
('reasig_efec_m30_0',null,null,null,null,null),        
('reasig_style_efec_m30_0','case when 1=1 then ''#FFF'' when 2=1 then ''#FFA'' end','style_efec_m30_0','cal','dp','varchar(250)'),        
('reasig_sal_ini_m30_0',null,null,null,null,null),        
('reasig_nope_ini_m30_0',null,null,null,null,null),        
('reasig_num_ope_ges_m30_0',null,null,null,null,null),        
('reasig_num_ope_man_ven_m30_0',null,null,null,null,null),        
('reasig_saldo_man_ven_m30_0',null,null,null,null,null),        
('reasig_num_ope_det_m30_0',null,null,null,null,null),      
('reasig_sal_det_m1_8',null,null,null,null,null),
('reasig_sal_det_m9_30',null,null,null,null,null), 
('reasig_sal_det_m30_0',null,null,null,null,null),         
('reasig_cob_g_m30_0',null,null,null,null,null),        
('reasig_int_g_m30_0',null,null,null,null,null),        
    
('reasig_efec_num_ope_1_30',null,null,null,null,null),        
('reasig_efec_1_30',null,null,null,null,null),        
('reasig_sal_ini_1_30',null,null,null,null,null),        
('reasig_nope_ini_1_30',null,null,null,null,null),        
('reasig_recu_1_30',null,null,null,null,null),        
('reasig_num_ope_man_ven_1_30',null,null,null,null,null),        
('reasig_saldo_man_ven_1_30',null,null,null,null,null),        
('reasig_num_ope_det_1_30',null,null,null,null,null),        
('reasig_saldo_det_1_30',null,null,null,null,null),        
('reasig_cob_g_1_30',null,null,null,null,null),         
('reasig_int_g_1_30',null,null,null,null,null),        
('reasig_ope_pp_1_30',null,null,null,null,null),        
('reasig_mon_pp_1_30',null,null,null,null,null),        
('reasig_ope_pr_1_30',null,null,null,null,null),        
('reasig_mon_pr_1_30',null,null,null,null,null),        
        
('reasig_efec_31_60',null,null,null,null,null),        
('reasig_sal_ini_31_60',null,null,null,null,null),        
('reasig_nope_ini_31_60',null,null,null,null,null),        
('reasig_recu_31_60',null,null,null,null,null),        
('reasig_saldo_det_4',null,null,null,null,null),        
('reasig_cob_g_4',null,null,null,null,null),        
('reasig_int_g_4',null,null,null,null,null),        
        
('reasig_efec_61_90',null,null,null,null,null),        
('reasig_saldo_ini_5',null,null,null,null,null),        
('reasig_num_ope_ini_5',null,null,null,null,null),        
('reasig_recu_5',null,null,null,null,null),        
('reasig_saldo_det_5',null,null,null,null,null),        
('reasig_cob_g_5',null,null,null,null,null),        
('reasig_int_g_5',null,null,null,null,null),        
        
('reasig_efec_91_120',null,null,null,null,null),        
('reasig_saldo_ini_6',null,null,null,null,null),        
('reasig_num_ope_ini_6',null,null,null,null,null),        
('reasig_recu_6',null,null,null,null,null),        
('reasig_saldo_det_6',null,null,null,null,null),        
('reasig_cob_g_6',null,null,null,null,null),        
('reasig_int_g_6',null,null,null,null,null),        
        
('reasig_efec_121_150',null,null,null,null,null),        
('reasig_saldo_ini_7',null,null,null,null,null),        
('reasig_num_ope_ini_7',null,null,null,null,null),        
('reasig_saldo_det_7',null,null,null,null,null),        
        
('reasig_efec_151_180',null,null,null,null,null),        
('reasig_saldo_ini_8',null,null,null,null,null),        
('reasig_num_ope_ini_8',null,null,null,null,null),        
('reasig_saldo_det_8',null,null,null,null,null),        
        
('reasig_efec_180',null,null,null,null,null),        
('reasig_saldo_ini_9',null,null,null,null,null),        
('reasig_num_ope_ini_9',null,null,null,null,null),        
('reasig_recu_9',null,null,null,null,null),        
        
('reasig_efec_jud',null,null,null,null,null),        
('reasig_saldo_ini_10',null,null,null,null,null),        
('reasig_num_ope_ini_10',null,null,null,null,null),        
('reasig_recu_10',null,null,null,null,null)        

insert into @tfil        
values        
--tabla,clave,valores (usar la doble comilla para valores texto/fecha)        
('todos','fec',''+@fec+'')--, 

        
--declare @tip_cod int=7,@cod_rel varchar(100)='231'        
declare @jer varchar(100);        
insert into @tfil        
exec piv.GPIVLEV04 @tip_cod,@cod_rel,@jer output        
      
insert into @tconf        
values        
('level_alias','style')        
       
--los valores rows y columnas van separados por comas y cada valor entre doble comilla        
--'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion  
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf  --,@show_query=1        
        
        
END
