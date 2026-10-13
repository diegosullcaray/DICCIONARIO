-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-02 08:58:55.700000
  
CREATE PROCEDURE [com].[RSMONEFEREPRO01]    
               
@tip_cod int,@cod_rel varchar(20), @fecha date = null    
     
AS            
BEGIN            
 SET NOCOUNT ON;     
   
 --declare @fecha date='20210227'--  
 declare @fec varchar(8);      
 select @fec='20220531'--(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)      
      
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
 (0,null,'Tramo (En días de Atraso)',null),(1,null,'-30 a 0',10),(2,null,'1 a 30',14)      
      
 insert into @defs       
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)       
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,null,IIF(ord=0,1,0)      
 from @head      
  
 --select * from  #goal      
 --select * from @defs order by TLEV,TORDER      
      
 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values      
 (1,1,4,'descripcion','Descripción',null,2,1,'string',null),      
 (2,2,4,'repro_efec_m30_0','% Avance Efectividad',null,2,null,'percent','.2-2'),      
 (3,3,4,'repro_sal_ini_m30_0','Saldo Inicial S/.',null,2,null,'number','.0-0'),      
 (4,4,4,'repro_nope_ini_m30_0','# Operaciones Inicio',null,2,null,'number','.0-0'),      
 (5,5,4,'repro_num_ope_ges_m30_0','# Operaciones Gestionadas',null,2,null,'number','.0-0'),      
 (6,null,4,'1','Deterioro de la cartera',6,null,null,null,null),      
       
 (7,12,4,'repro_efec_1_30','% Avance Efectividad',null,2,null,'percent','.2-2'),      
 (8,13,4,'repro_sal_ini_1_30','Saldo Inicial S/.',null,2,null,'number','.0-0'),      
 (9,14,4,'repro_nope_ini_1_30','# Operaciones Inicio',null,2,null,'number','.0-0'),      
 (10,15,4,'repro_recu_1_30','Saldo Recuperado S/.',null,2,null,'number','.0-0'),      
 (11,null,4,'6','Deterioro de la cartera',6,null,null,null,null)  
      
 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values      
 (1,6,5,'repro_num_ope_man_ven_m30_0','# Operaciones Por Vencer','number','.0-0'),      
 (2,7,5,'repro_saldo_man_ven_m30_0','Saldo Por Vencer S/','number','.0-0'),      
 (3,8,5,'repro_num_ope_det_m30_0','# Operaciones Deterioradas','number','.0-0'),      
 (4,9,5,'repro_sal_det_m30_0','Saldo Deteriorado S/.','number','.0-0'),      
 (5,10,5,'repro_cob_g_m30_0','% Cobertura de Gestión','percent','.2-2'),      
 (6,11,5,'repro_int_g_m30_0','Intensidad de Gestión','number','.2-2'),      
      
 (7,16,5,'repro_num_ope_man_ven_1_30','# Operaciones por Deteriorar','number','.0-0'),      
 (8,17,5,'repro_saldo_man_ven_1_30','Saldo por Deteriorar S/','number','.0-0'),      
 (9,18,5,'repro_num_ope_det_1_30','# Operaciones Deterioradas','number','.0-0'),      
 (10,19,5,'repro_saldo_det_1_30','Saldo Deteriorado S/.','number','.0-0'),      
 (11,20,5,'repro_cob_g_1_30','% Cobertura de Gestión','percent','.2-2'),      
 (12,21,5,'repro_int_g_1_30','Intensidad de Gestión','number','.2-2')  
  
 --select * from @defs      
 select rep.FFTHCOLDEF(@defs) result;      
      
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF      
  
  
insert into @tvars      
values       
--clave,formula,alias,tipo(cal/reg),ejecucion(ap/dp),tipo dato      
--cal:calculado,reg:regular      
--ap:antes del pivo,dp: despues del pivot      
('repro_efec_m30_0',null,null,null,null,null),      
('style_efec_m30_0','case when 1=1 then ''#FFF'' when 2=1 then ''#FFA'' end','style_efec_m30_0','cal','dp','varchar(250)'),      
('repro_sal_ini_m30_0',null,null,null,null,null),      
('repro_nope_ini_m30_0',null,null,null,null,null),      
('repro_num_ope_ges_m30_0',null,null,null,null,null),      
('repro_num_ope_man_ven_m30_0',null,null,null,null,null),      
('repro_saldo_man_ven_m30_0',null,null,null,null,null),      
('repro_num_ope_det_m30_0',null,null,null,null,null),      
('repro_sal_det_m30_0',null,null,null,null,null),      
('repro_cob_g_m30_0',null,null,null,null,null),      
('repro_int_g_m30_0',null,null,null,null,null),      
      
('repro_efec_1_30',null,null,null,null,null),      
('repro_sal_ini_1_30',null,null,null,null,null),      
('repro_nope_ini_1_30',null,null,null,null,null),      
('repro_recu_1_30',null,null,null,null,null),      
('repro_num_ope_man_ven_1_30',null,null,null,null,null),      
('repro_saldo_man_ven_1_30',null,null,null,null,null),      
('repro_num_ope_det_1_30',null,null,null,null,null),      
('repro_saldo_det_1_30',null,null,null,null,null),      
('repro_cob_g_1_30',null,null,null,null,null),       
('repro_int_g_1_30',null,null,null,null,null)   
        
--declare @fec varchar(8)='20210315'      
insert into @tfil      
values      
--tabla,clave,valores (usar la doble comilla para valores texto/fecha)      
('todos','fec',''+@fec+'')--,      
--('todos','prod_com','16')--,      
--('todos','reg','1')      
      
--declare @tip_cod int=7,@cod_rel varchar(100)='231'      
declare @jer varchar(100);      
insert into @tfil      
exec piv.GPIVLEV04 @tip_cod,@cod_rel,@jer output      
      
insert into @tconf      
values      
('level_alias','style')      
      
--los valores rows y columnas van separados por comas y cada valor entre doble comilla      
--'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion      
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1      
  
END
