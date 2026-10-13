-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-08-23 10:21:32.483000
--exec [com].[RSMONEFER02] 7,'231', 'TODO','TODO','TODO','TODO','TODO','%%','TODO','TODO',1,'TODO'


CREATE PROCEDURE [com].[RSMONEFER02]                            
@tip_cod int,@cod_rel nvarchar(100),@tramof varchar(20),@prod varchar(50),@comp_r varchar(20),@zcuo varchar(20),@ucuo varchar(20),@nom varchar(150),                  
@resp varchar(250),@tdcr varchar(50),@pagen int,@fcompro varchar(50)                    
AS                            
BEGIN                      
  SET NOCOUNT ON;               
DECLARE @fecComproFormat varchar(50)            
set @fecComproFormat=( SELECT case when @fcompro='TODO' then 'TODO' else CONVERT(varchar(10), CONVERT(date, @fcompro, 103), 120) end)             
set @fecComproFormat = (select replace(@fecComproFormat,'-',''))            
            
 declare @fecha date=dateadd(day,-1,GETDATE());              
 declare @fec date=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)              
 declare @defs as rep.TTHCOLDEF                
 insert into @defs              
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values              
 (1,1,1,'ter','Territorio','string',null,null),              
 (2,2,1,'cor','Corredor','string',null,null),              
 (3,3,1,'subcor','Sub Corredor','string',null,null),              
 (4,4,1,'adm','Unidad','string',null,null),              
 (5,5,1,'prod','Producto','string',null,null),              
 (6,6,1,'ase','Asesor','string',null,null),              
 (7,7,1,'cta','Cta. Cliente','string',null,null),              
 (8,8,1,'cli','Cliente','string',null,null),              
 (9,9,1,'ope','Operación','string',null,null),              
 (10,10,1,'fec_desem','Fecha Desembolso','string',null,null),              
 (11,11,1,'mon_desem','Monto Desembolso','number','.0-0',null),              
 (12,12,1,'moneda','Moneda','number','.0-0','30px'),              
 (13,13,1,'saldo','Saldo','number','.0-0',null),              
 (14,14,1,'tram_ini','Tramo Inicio','string',null,null),              
 (15,15,1,'dia_act','Días Actual','number','.0-0','30px'),              
 (16,16,1,'reg_ges','Con registro de Gestión','string',null,null),              
 (17,17,1,'num_ges','Número de Gestiones','number','.0-0','30px'),              
 (18,18,1,'fec_ult_ges','Fecha Última Gestión','string',null,null),              
 (19,19,1,'res_ult_ges','Resultado última Gestión','string',null,null),              
 (20,20,1,'prob_rec','Probabilidad Rec.','string',null,null),              
 (21,21,1,'estr_cob','Estrategía Cob.','string',null,null),              
 (22,22,1,'niv_sob','Nivel Sob.','string',null,null),              
 (23,23,1,'niv_rie_bt','Nivel de Riesgo (homologado)','string',null,null),              
 (24,24,1,'mont_prom_pa','Monto Promesa Pago','number','.0-0',null),              
 (25,25,1,'fec_ven_prom','Fecha Ven. Promesa Pago','string',null,null),              
 (26,26,1,'cuot_zero','0 Cuotas','string',null,null),              
 (27,27,1,'cuot_one','1 Cuotas','string',null,null),              
 (28,28,1,'dia_ven_prom','Días Ven.Promesa Pago','number','.0-0',null),              
 (29,29,1,'reac_cyb','Reacción','string',null,null),              
 (30,30,1,'user_ges','Usuario Gestión','string',null,null),      
 (28,28,1,'HINDCART','Refinanciado','string',null,null),         
 (28,28,1,'HINDREPR','Reprogramado','string',null,null),         
 (28,28,1,'HINDEXCP','Excepciones','string',null,null),         
 (28,28,1,'HNUMCOND','# Condonaciones','number','.0-0',null),    
 (28,28,1,'cod_grup','Cod.Grupo','string',null,null),    
 (28,28,1,'nom_grup','Grupo','string',null,null)          
        
           --HCODGRUP=b.HNROG, a.HDESGRUP=b.HNOMG    
 select rep.FFTHCOLDEF(@defs) result;            
 declare @Fechas date        
 select * into #VCAM001 from storage.[com_act].VCAM001         
 select *,'NO' HINDCART,'NO' HINDREPR,'NO' HINDEXCP,0 HNUMCOND,null HCODGRUP,cast('' as varchar(250)) HDESGRUP into #WCED002 from storage.[com_act].WCED002      
       
 set @Fechas =(select top 1 hfecpro from #VCAM001 )       

 select distinct HOPER,HNROG,HNOMG into #HDGP001 from storage.[com_act].[HDGP001] where hfecpro=@Fechas 
 
;with cte_condonados as (
	 select distinct HCODOPE,HFECEJC, HNUM_CONDONADO,
	 row_number() over (partition by HCODOPE order by HFECEJC desc)x 
	 from storage.[com_act].hbac002 -- where HFECPRO=@fecMaxCond 
)
select HCODOPE,HFECEJC,HNUM_CONDONADO + 1 HNUMCOND  into #condonados 
from cte_condonados where x=1

 /*Se coloco el indicador refinanciado*/          
update a          
set a.HINDCART='SI'          
from #WCED002 a           
inner join (select  hcodope from #VCAM001 where HINDCAR='REFINANCIADO')  b           
on a.hcodope=b.hcodope      
      
/*Se coloco el indicador reprogramado*/          
update a          
set a.HINDREPR='SI'          
from #WCED002 a           
inner join (  select HCODOPE from storage.com_act.HCDR001 where HFECPRO=@Fechas      
     UNION          
     select HCODOPE from storage.com_act.HCDR002 where HFECPRO=@Fechas      
     )  b           
on a.hcodope=b.hcodope           
      
declare @FecMaxExcep date,@fecMaxCond date        
--set @FecMaxExcep=(select max(hfecpro) from storage.[com_act].hbae001)        
set @fecMaxCond=(select  max(hfecpro) from storage.[com_act].hbac002)        
/*Se coloco el indicador Excepciones*/        
update a          
set a.HINDEXCP='SI'          
from #WCED002 a           
inner join (select  hcodope from storage.[com_act].hbae001 /*where HFECPRO=@FecMaxExcep*/)  b           
on a.hcodope=b.hcodope          
      
/*Se coloco el numero de condonaciones*/          
/*update a          
set a.HNUMCOND=b.HNUMCOND          
from #WCED002 a           
inner join (select  HCODOPE,MAX(HNUM_CONDONADO) HNUMCOND from storage.[com_act].hbac002 where HFECPRO=@fecMaxCond GROUP BY HCODOPE)  b           
on a.hcodope=b.hcodope   
*/
/*Se coloco el numero de condonaciones*/      
update a     
set a.HNUMCOND=isnull(b.HNUMCOND,0)      
from #WCED002 a       
inner join (select * from #condonados)b     
on a.hcodope=b.hcodope;     
    
/* Se agrego el código de grupo y nombre de Grupo */    
update a    
set a.HCODGRUP=b.HNROG, a.HDESGRUP=b.HNOMG    
from  #WCED002 a     
inner join (select cast(HOPER  as varchar) HOPER,HNROG,cast(HNOMG as varchar(250))HNOMG from #HDGP001)b    
on a.HCODOPE=b.HOPER  
      
--select * into dbo.WCED002 from #WCED002      
               
--declare @tip_cod int=15,@cod_rel nvarchar(100)='3'              
--declare @tramof varchar(20)='TODO',@prod varchar(50)='TODO',@comp_r varchar(20)='TODO',@zcuo varchar(20)='TODO',@ucuo varchar(20)='TODO',@nom varchar(150)='%%',                  
--@resp varchar(250)='TODO',@tdcr varchar(50)='TODO',@pagen int=1                  
                   
 DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT                 
 SET @PageNumber = @pagen                  
 SET @RowspPage = 30;                
              
 declare @result as table([row] int,              
 ter varchar(100),cor varchar(100),subcor varchar(100),adm varchar(100),prod varchar(100),ase varchar(100)              
 ,cta varchar(100),cli varchar(100),ope varchar(100),fec_desem varchar(100),mon_desem varchar(100)              
 ,moneda varchar(100),saldo varchar(100),tram_ini varchar(100),dia_act varchar(100),reg_ges varchar(100)              
 ,num_ges varchar(100),fec_ult_ges varchar(100),res_ult_ges varchar(100),prob_rec varchar(100),estr_cob varchar(100)              
 ,niv_sob varchar(100),niv_rie_bt varchar(100),mont_prom_pa varchar(100),fec_ven_prom varchar(100),cuot_zero varchar(100),cuot_one varchar(100)              
 ,dia_ven_prom varchar(100),reac_cyb varchar(500),user_ges varchar(100),HINDCART varchar(100), HINDREPR varchar(100),HINDEXCP varchar(100),      
  HNUMCOND varchar(100),cod_grup varchar(100),nom_grup varchar(100)              
 )              
              
 ;with a as (              
  select B.RDESTER ter,              
  B.RDESCOR cor,              
  null /*B.RDESSUBC*/ subcor,              
  B.RDESUNI adm               
      ,A.[RDESPROD]  prod                 
      ,A.[HDCODSEC]  ase                
      ,A.[HCTACLI]   cta              
   ,A.[HDESCLI]      cli              
      ,A.[HCODOPE]   ope               
      ,A.[HFECDES]   fec_desem               
      ,A.[HMONDES]   mon_desem               
      ,A.[HCODMON]   moneda               
      ,A.[HSALCAPMN] saldo                 
      ,A.[HTRAM]    tram_ini              
      ,A.[HDIAATR]  dia_act                
      ,A.[HREGG]    reg_ges              
      ,A.[HREGN]    num_ges              
      ,A.[HFCFGEST] fec_ult_ges                 
      ,A.[HFCRES]   res_ult_ges               
      ,A.[HPROBR]   prob_rec               
      ,A.[HESTC]    estr_cob              
      ,A.[HNIVSOB]  niv_sob            
      ,A.[HNIVRIEBT]  niv_rie_bt                
      ,A.[HFCMPP]   mont_prom_pa               
      ,A.[HFCFVPP]  fec_ven_prom                
   ,A.[HINDZCUO]    cuot_zero              
      ,A.[HINDUCUO] cuot_one               
   ,A.[HFDGPR]      dia_ven_prom     
      ,A.[HFCCOM] reac_cyb              
   ,A.[HFCRSPB] user_ges,      
   A.HINDCART,      
   a.HINDREPR,      
   a.HINDEXCP,      
   a.HNUMCOND,    
   a.HCODGRUP,    
   a.HDESGRUP              
 from  #WCED002 A-- storage.[com_act].WCED002 A    --select top 10 * from  storage.[ref].WJERCOR03            
 left join storage.[ref].WJERCOR03 B ON A.HCODSEC=B.RCODSEC and B.RFECPRO=@fec              
 where            
 case           
 when @tip_cod=20 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')          
 when @tip_cod=19 then cast(B.RCODCOR as nvarchar(10))        
 when @tip_cod=21 then cast(B.RCODGRU as nvarchar(5))              
 when @tip_cod=18 then cast(B.RCODUNI as varchar(50)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)              
       
  and case when @tramof='TODO' then '1' else A.HTRAM end =case when @tramof='TODO' then '1' else @tramof end                  
  and case when @prod='TODO' then '1' else A.RDESPROD end =case when @prod='TODO' then '1' else @prod end                  
  and case when @comp_r='TODO' then '1' else A.HFGPR end =case when @comp_r='TODO' then '1' else @comp_r end                  
  and case when @zcuo='TODO' then '1' else A.HINDZCUO end =case when @zcuo='TODO' then '1' else @zcuo end                  
  and case when @ucuo='TODO' then '1' else A.HINDUCUO end =case when @ucuo='TODO' then '1' else @ucuo end                  
  and case when @resp='TODO' then '1' else isnull(A.HFCRES,'VACÍO') end =case when @resp='TODO' then '1' else @resp end                  
  and case when @tdcr='TODO' then '1' else A.HFTVEN end =case when @tdcr='TODO' then '1' else @tdcr end                  
  and case when @fcompro='TODO' then '9999-12-31' else A.[HFCFVPP] end =case when @fcompro='TODO' then '9999-12-31' else @fecComproFormat end                  
  and A.HDCODSEC like @nom                   
               
 )insert into @result              
   select               
   row_number() over(order by saldo desc) AS [row],              
   *               
   from a              
                  
         
                
     select * from @result ORDER BY [row] asc              
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS                  
  FETCH NEXT @RowspPage ROWS ONLY;              
              
  select count(*) as Total from @result         
   --drop table dbo.WCED002      
            
              
END
