-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-11-07 08:26:49.683000
--exec [com].[RSMONEFETRC01] 7,'231','20240127'
--exec [com].[RSMONEFETRC01] 7,'231', 'TODO','TODO','TODO','TODO','TODO','%%','TODO','TODO',1,'TODO'
--drop table #b_goal,#goal
CREATE PROCEDURE [com].[RSMONEFETRC01]  
--monitor efectividades reasignado
@tip_cod int,@cod_rel varchar(20), @fecha date = null          
AS              
BEGIN              
 SET NOCOUNT ON;            
      
 --declare @tip_cod int=7,@cod_rel varchar(20)='231', @fecha date = '20241106'          
 declare @fec varchar(8), @numSemanal int,@fecATime DATETIME= @fecha,@FecSemanal date   ,@grupo smallint      
 --select max(SFECPRO) from storage.[com_act].[SDAE002] where SCODAGR in ('3') and SFECPRO        
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)        
        
------------------ METAS TITULOS ------------------------  
---------------------------------------------------------  
set @numSemanal =(select datediff(ww, dateadd( dd, day(@fecATime) * -1, @fecATime) + 1, @fecATime) + 1)      
     
 SELECT RFEC,ROW_NUMBER() OVER(ORDER BY RFEC ASC) AS RORD into #FecSemanal    
 FROM storage.ref.RCALEN001    
 where RDIASEM=6 and RFEC between dateadd(day, 1, eomonth(@fecha, -1)) and eomonth(@fecha)    
           
 set @FecSemanal=(select RFEC from #FecSemanal where RORD=@numSemanal)    
 
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
  select 1,eomonth(@fecha), 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0        
  union all         
  select 2,@fecha, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,0         
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
 (0,null,'Tramo (En días de Atraso)',null),(1,null,'-30 a 0',13)
 
      
 insert into @defs         
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)         
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,null,IIF(ord=0,1,0)        
 from @head        
 union         
 select ord,2,'h2_'+CAST(ord as varchar(10)),ISNULL(CAST(cast(b.ind*100.00 as  DECIMAL(16,2)) as varchar(20))+' %','Meta del Mes'),cols,'green',IIF(ord=0,1,0)        
 from @head a left join  #goal b on a.ord=b.row_num and b.goal=1        
 union         
 select ord,3,'h3_'+CAST(ord as varchar(10)),ISNULL(CAST(cast(b.ind*100.00 as  DECIMAL(16,2)) as varchar(20))+' %','Meta del Día'),cols,'#22ad22',IIF(ord=0,1,0)        
 from @head a left join  #goal b on a.ord=b.row_num and b.goal=2   
         

 
  insert into @defs            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values 
 
 (1,1,5,'descripcion','Descripción',null,3,1,'string',null),   
 

 (2,2,5,'sal_ini_m30_0','Saldo Inicial S/.',null,3,null,'number','.0-0'),    
 (3,null,5,'1','Avance Efectividad',2,null,null,null,null),              
     
 (6,null,5,'2','Saldo Recuperado por días de atraso',6,null,null,null,null), 
 (7,null,5,'3','Saldo por Vencer',2,null,null,null,null), 
 (8,null,5,'4','Saldo por Deteriorado',2,null,null,null,null)  

  insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TFORTYP,TFORMOD,TSTBACKGROUND)  values   
 (1,3,6,'efec_num_ope_m30_0','# Operaciones',null,2,'percent','.2-2',NULL),            
 (2,4,6,'efec_m30_0','% Saldo',null,2,'percent','.2-2','#EA705D'),    
 


 (6,null,6,'600','Pago Puntual',2,null,null,null,NULL),--0 días
 (7,null,6,'700','1 A 8 días',2,null,null,null,NULL),
 (8,null,6,'800','9 A más',2,null,null,null,NULL), 

 (66,10,7,'sal_pag_m0','S/ Saldo',null,null,'number','.0-0',NULL),
 (67,11,7,'efec_sal_pag_m0','% Saldo',null,null,'percent','.2-2',NULL),
 (68,12,7,'sal_pag_1_8','S/ Saldo',null,null,'number','.0-0',NULL),
 (69,13,7,'efec_sal_pag_1_8','% Saldo',null,null,'percent','.2-2',NULL), 
 (70,14,7,'sal_pag_9_m30','S/ Saldo',null,null,'number','.0-0',NULL),
 (71,15,7,'efec_sal_pag_9_m30','% Saldo',null,null,'percent','.2-2',NULL), 

 (72,16,6,'saldo_man_ven_m30_0','S/ Saldo',null,2,'number','.0-0',NULL),       
 (73,17,6,'porc_saldo_man_ven_m30_0','% Saldo',null,2,'percent','.2-2',NULL),
 (74,18,6,'sal_det_m30_0','S/ Saldo',null,2,'number','.0-0',null),
 (74,19,6,'porc_sal_det_m30_0','% Saldo',null,2,'percent','.2-2',null) 

 --select * from @defs        
 select rep.FFTHCOLDEF(@defs) result;        
        
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF        
        
insert into @tvars        
values         
('efec_num_ope_m30_0',null,null,null,null,null),            
('efec_m30_0',null,null,null,null,null),            
('style_efec_m30_0','case when 1=1 then ''#FFF'' when 2=1 then ''#FFA'' end','style_efec_m30_0','cal','dp','varchar(250)'),            
('sal_ini_m30_0',null,null,null,null,null), 
('sal_det_m30_0',null,null,null,null,null),         
('sal_pag_m0',null,null,null,null,null), 
('efec_sal_pag_m0',null,null,null,null,null), 
('sal_pag_1_8',null,null,null,null,null), 
('efec_sal_pag_1_8',null,null,null,null,null), 
('sal_pag_9_m30',null,null,null,null,null), 
('saldo_man_ven_m30_0',null,null,null,null,null),
('porc_saldo_man_ven_m30_0','cast(saldo_man_ven_m30_0  as float)/(sal_ini_m30_0)','porc_saldo_man_ven_m30_0','cal','dp','float'),
('efec_sal_pag_9_m30',null,null,null,null,null),
('porc_sal_det_m30_0','cast(sal_det_m30_0  as float)/(sal_ini_m30_0)','porc_sal_det_m30_0','cal','dp','float')
--,('cob_g_m30_0',null,null,null,null,null),            
--('int_g_m30_0',null,null,null,null,null)  

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
