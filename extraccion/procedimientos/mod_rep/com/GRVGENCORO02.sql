-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-02-27 13:15:00.373000

--insert into mod_rep.[rep].[RREGREP01] values('RVIUWGCORE_02','Reporte Vista Gestión Corresponsal','{"name":"mod_rep.[com].[GRVGENCORO02]","params":[{"order":1,"name":"tip_cod"},{"order":2,"name":"cod_rel"},{"order":3,"name":"fec"},{"order":4,"name":"tip_age"}]}')

--EXEC MOD_REP.[com].[GRVGENCORO02] 7,'231','20240226','TODOS'
CREATE  PROCEDURE [com].[GRVGENCORO02]  
 @tip_cod int,                                                                                        
 @cod_rel varchar(20),                                                                                    
 @fec date ,
 @tip_age VARCHAR(250)   
AS
BEGIN
  SET NOCOUNT ON;    
  /*
declare
 @tip_cod int=7,                                                                                        
 @cod_rel varchar(20)='231',                                                                                    
 @fec date='20240226' ,
 @tip_age VARCHAR(250) ='TODOS'
 */
declare @defs as rep.TTHCOLDEF                                                                          
 insert into @defs                                                                            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,TROWS,TCOLS)  values                                                                           
 (1,1,1,'descripcion','Descripción','string',null,'20px',2,0),                                                                            
 (2,2,1,'Agent_insta','Agentes Instalados','number','.0-0',null,2,0),                                                                            
 (3,null,1,'Age','Agentes','number',null,null,1,4),                                                                            
 (4,null,1,'Trx','Transacciones','number',null,null,1,7),     
 (5,null,1,'TRX_','Transacciones','number',null,null,1,7),  
                                            
 (6,3,2,'num_ag_esta_1','# Agentes Vigentes','number','.0-0',null,null,null),                                             
 (7,4,2,'num_ag_esta_0','# Agentes Cancelados','number','.0-0',null,null,null),   
 (8,5,2,'agent_c_trx','# Agentes con transaccionar','number','.0-0',null,null,null),                                             
 (9,6,2,'agent_s_trx','# Agentes sin transaccionar','number','.0-0',null,null,null),   
                                           
 (10,7,2,'trx_mes','# Transacciones Mes','number','.0-0',null,null,null),                                             
 (11,8,2,'num_trx_1','Pago Crédito','number','.0-0',null,null,null),                                              
 (12,9,2,'num_trx_2','Retiro','number','.0-0',null,null,null),                                                                                       
 (13,10,2,'num_trx_3','Deposito','number','.0-0',null,null,null),
 (14,11,2,'num_trx_4','Pago Servicio','number','.0-0',null,null,null),        
 (15,12,2,'num_trx_5','Giros','number','.0-0',null,null,null),        
 (16,13,2,'num_trx_6','Rendición Asesor','number','.0-0',null,null,null), 

 (17,14,2,'mont_mes','Monto Transacciones Mes','number','.0-0',null,null,null),                                             
 (18,15,2,'mont_trx_1','Pago Crédito','number','.0-0',null,null,null),                                              
 (19,16,2,'mont_trx_2','Retiro','number','.0-0',null,null,null),                                                                                       
 (20,17,2,'mont_trx_3','Deposito','number','.0-0',null,null,null),
 (21,18,2,'mont_trx_4','Pago Servicio','number','.0-0',null,null,null),        
 (22,19,2,'mont_trx_5','Giros','number','.0-0',null,null,null),        
 (23,20,2,'mont_trx_6','Rendición Asesor','number','.0-0',null,null,null)

  select rep.FFTHCOLDEF(@defs) result;    


declare @fecs varchar(max) 
 

declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF              

insert into @tvars              
values ('mont_trx',null,null,null,null,null),
       ('num_trx',null,null,null,null,null) 
	   
             
insert into @tfil              
values                      
('todos','fec','"'+cast(@fec as varchar)+'"')              
             
insert into @tconf              
values              
('level_alias','style') ,('fec_corr','true')  ,('insert_to', '#R1')        

 if @tip_age<>'TODOS'            
 begin  
 insert into @tfil              
 values('TODOS','tip_agen','"'+@tip_age+'"')
 end
            
   
declare @jer varchar(100)              
insert into @tfil               
exec [piv].GPIVLEV06 @tip_cod,@cod_rel,@jer output     
 
create table #R1   ( --drop table #R1
fila int null,
cod_fc varchar(250)null, 
cod_cter_capt_m  varchar(250) null,
cod_ccor_capt_m varchar(250)null,
style int null,
descripcion varchar(250)null,
mont_trx_1 float null,mont_trx_2 float null,mont_trx_3 float null,mont_trx_4 float null,mont_trx_5 float null,mont_trx_6 float null,
num_trx_1 float null,num_trx_2 float null,num_trx_3 float null,num_trx_4 float null,num_trx_5 float null,num_trx_6  float null
)
 
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","agr_trx"',@config=@tconf--,@show_query=1    
--exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","esta_corr"',@config=@tconf,@show_query=1  
--esta_corr

select *, isnull(num_trx_1,0)+isnull(num_trx_2,0)+isnull(num_trx_3,0)+isnull(num_trx_4,0)+isnull(num_trx_5,0)+isnull(num_trx_6,0)   trx_mes ,
isnull(mont_trx_1,0)+isnull(mont_trx_2,0)+isnull(mont_trx_3,0)+isnull(mont_trx_4,0)+isnull(mont_trx_5,0)+isnull(mont_trx_6,0)  mont_mes
into #R1_1
from #R1


DELETE FROM  @tvars WHERE TKEYVAR IN('mont_trx','num_trx')
DELETE FROM @tconf WHERE TKEYPROP='insert_to'

insert into @tvars              
values ('num_ag_esta',null,null,null,null,null),
('num_age_trx',null,null,null,null,null) 


create table #R2   ( --drop table #R1
fila int null,
cod_fc varchar(250)null, 
cod_cter_capt_m  varchar(250) null,
cod_ccor_capt_m varchar(250)null,
style int null,
descripcion varchar(250)null,
num_ag_esta_0 float null,num_ag_esta_1 float null,num_age_trx_0	 float null,num_age_trx_1  float null
)
 insert into @tconf              
values ('insert_to','#R2')     

exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","esta_corr"',@config=@tconf--,@show_query=1  

-- select 1096+2589+5+1717

select *,isnull(num_ag_esta_0,0)+isnull(num_ag_esta_1,0)  Agent_insta,isnull(num_age_trx_0,0) + isnull(num_age_trx_1,0) agent_c_trx , isnull(num_ag_esta_1,0) - ( isnull(num_age_trx_0,0) + isnull(num_age_trx_1,0)) agent_s_trx
into #R2_2
from #R2

select a.*, 
num_ag_esta_0,num_ag_esta_1,num_age_trx_0,num_age_trx_1,Agent_insta,agent_c_trx,agent_s_trx 
from #R1_1 a 
left join #R2_2 b
on a.style=b.style and a.descripcion=b.descripcion
 

drop table #R1_1,#R1,#R2,#R2_2

--insert into mod_rep.[piv].[RETJCPIV01] values(10136,10026,10002)
--insert into mod_rep.[piv].[RETJCPIV01] values(10137,10026,10002)


--select 27983855+2816433+2435129+32196+7535+612448
--select 82001+11373+8987+421+34+1277
end
