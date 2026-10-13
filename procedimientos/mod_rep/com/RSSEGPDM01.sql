-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 06:19:02.917000
--exec [com].[RSSEGPDM01] 7,'231','20240116'  
CREATE procedure  [com].[RSSEGPDM01]             
@tip_cod int, @cod_rel varchar(10),@fec date         
----------------------------------------------------------------------------------                
as                
begin                
SET NOCOUNT ON;      
  
   
    
 declare @defs as rep.TTHCOLDEF;    
    
 declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int,background nvarchar(20) )        
 insert into @head values     
 (0,null,'',null,null),     
 (1,null,'STOCK DE CLIENTES',6,null),  
 (10,null,'STOCK DE GRUPOS',6,null),  
 (20,null,'GRUPOS NUEVOS DESEMBOLSADOS',2,null),  
 (30,null,'GRUPOS RECURRENTES DESEMBOLSADOS',2,null),  
 --(40,null,'ASISTENCIA',2,'#1f8c26'),    
 --(50,null,'PAGO PUNTUAL',2,'#1f8c26'),   
 (60,null,'SALDO DE CARTERA',6,null),   
 (70,null,'MORA 1 - 30',6,null),   
 (80,null,'MORA > 30',6,null)  
  
     
 insert into @defs         
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)       
 select ord,2,'h2_'+CAST(ord as varchar(10)),name,cols,background,IIF(ord=0,1,0)        
 from @head        
  
    
   
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTBACKGROUND)  values        
 (1,1,3,'HDESREL','Descripción',null,1,1,'string',null,null),    
     --#e3bd42 ---'#1f8c26'  
 (2,2,3,'HNUMCLI_ANT','Mes Anterior',null,2,null,'number','.0-0',null),        
 (3,3,3,'META_VARCLIE','Meta Var Stock',null,2,null,'number','.0-0',null),        
 (4,4,3,'HNUMCLI','Cierre Previo',null,2,null,'number','.0-0',null),     
 (5,5,3,'VAR_CLI','Variación',null,2,null,'number','.0-0',null),     
 (6,6,3,'DIST_CLI','Dist. Meta',null,2,null,'number','.0-0',null),     
 (7,7,3,'AVANCE_STOCK_CLI','Avance Meta',null,2,null,'percent','.2-2',null),     
  
   
 (11,11,3,'HNROG_ANT','Mes Anterior',null,2,null,'number','.0-0',null),      
 (12,12,3,'META_VARGRU','Meta Var Gr',null,2,null,'number','.0-0',null),  
 (13,13,3,'HNROG','Cierre Previo',null,2,null,'number','.0-0',null),  
 (14,14,3,'VAR_GRU','Variación',null,2,null,'number','.0-0',null),  
 (15,15,3,'DIST_GRU','Dist. Meta',null,2,null,'number','.0-0',null),  
 (16,16,3,'AVANCE_STOCK_GRU','Avance Meta',null,2,null,'percent','.2-2',null),  
  
 (21,21,3,'NUEVO_DESEM','Grupos Nuevos Desembolsados',null,2,null,'number','.0-0',null),  
 (22,22,3,'AVANCE_NUEVO_DESEM','% Efectividad Grupos Nuevos',null,2,null,'percent','.2-2',null),  
  
 (31,31,3,'HULTVEN_RECUR_DESEM','Grupos con Últ. Vcto.',null,2,null,'number','.0-0',null),  
 (32,32,3,'RECURRENTE_DESEM','Total Grupos Recurrentes Desembolsados',null,2,null,'number','.0-0',null),  
  
 (61,61,3,'HSALCAPMN_ANT','Mes Anterior',null,2,null,'number','.0-0',null),   
 (62,62,3,'META_VARSALDO','Meta Var Sld',null,2,null,'number','.0-0',null),  
 (63,63,3,'HSALCAPMN','Cierre Previo',null,2,null,'number','.0-0',null),  
 (64,64,3,'VAR_SALDO','Variación',null,2,null,'number','.0-0',null),  
 (65,65,3,'DIST_SALDO','Dist. Meta',null,2,null,'number','.0-0',null),  
 (66,66,3,'AVANCE_SALDO','Avance Meta',null,2,null,'percent','.2-2',null),  
   
 (71,71,3,'HSALCAPMN_1_30_ANT','Mes Anterior',null,2,null,'number','.0-0',null),  
 (72,72,3,'AVMOR1_30_ANT','% Mes Anterior',null,2,null,'percent','.2-2',null),  
 (73,73,3,'HSALCAPMN_1_30','Cierre Previo',null,2,null,'number','.0-0',null),  
 (74,74,3,'AVMOR1_30','Porc de Cartera',null,2,null,'percent','.2-2',null),  
 (75,75,3,'VAR_MOR1_30','Variación',null,2,null,'number','.0-0',null),  
 (76,76,3,'POC_VAR_MOR1_30','Avance Meta',null,2,null,'percent','.2-2',null),  
   
 (81,81,3,'HSALCAPMN_ma_30_ANT','Mes Anterior',null,2,null,'number','.0-0',null),  
 (82,82,3,'AVMORMA_30_ANT','% Mes Anterior',null,2,null,'percent','.2-2',null),  
 (83,83,3,'HSALCAPMN_ma_30','Cierre Previo',null,2,null,'number','.0-0',null),  
 (84,84,3,'AVMORMA_30','Porc de Cartera',null,2,null,'percent','.2-2',null),  
 (85,85,3,'VAR_MORMA_30','Variación',null,2,null,'number','.0-0',null),  
 (86,86,3,'POC_VAR_MORMA_30','Avance Meta',null,2,null,'percent','.2-2',null)  
   
  
  
  
  select rep.FFTHCOLDEF(@defs) result;      
   
  
  
  
 -- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20240116'    
 ;with jerar as (  
  
 -- declare @tip_cod int = 21, @cod_rel varchar(10) = '1',@fec date  = '20240116'    
 SELECT   
 DISTINCT  
   CASE    
        WHEN @tip_cod = 7 THEN cast(b.RDESFC as varchar (50))   
        WHEN @tip_cod = 21 THEN cast(b.RDESGRU as varchar (50))   
        WHEN @tip_cod = 20 THEN cast(b.RDESTER as varchar (50))   
        WHEN @tip_cod = 19 THEN cast(b.RDESCOR as varchar (50))   
     WHEN @tip_cod = 18 THEN cast(b.RDESUNI as varchar (50))
	  WHEN @tip_cod = 17 THEN cast(b.RDESUCO as varchar (50))
	  end HDESREL,@tip_cod HTIPCOD,@cod_rel HCODREL  
  
   from storage.ref.wjercor03 b  
   where    
CASE cast(@tip_cod as varchar (3))  
        WHEN 7 THEN cast(b.RCODFC as varchar (5))  
        WHEN 21 THEN cast(b.RCODGRU as varchar (5))  
        WHEN 20 THEN cast(b.RCODTER as varchar (5))  
        WHEN 19 THEN cast(b.RCODCOR as varchar (5))  
     WHEN 18 THEN cast(b.RCODUNI as varchar (5)) 
	 WHEN 17 THEN cast(b.RCODUCO as varchar (5)) 
    END =@cod_rel  
)  
,metas as (  
  select * from storage.com.metas_saldos   
  pivot (max(HVALVAR) for HCODVAR in  ([10062],[10044],[8000])) PVT    
  where HFECPRO = EOMONTH(@fec) and HTIPMETA = 1 and HTIPCOD=@tip_cod and HCODREL = @cod_rel    
 )   
   select 1 style, HDESREL,  
   --stock clientes  
   HNUMCLI_ANT, [10062] META_VARCLIE,HNUMCLI, HNUMCLI-HNUMCLI_ANT VAR_CLI, HNUMCLI-[10062] DIST_CLI,  
   iif([10062]>0, ((HNUMCLI-HNUMCLI_ANT) ) / [10062] ,0) AVANCE_STOCK_CLI  
  
   --stock grupo  
   ,HNROG_ANT, [10044] META_VARGRU, HNROG, HNROG - HNROG_ANT VAR_GRU, HNROG - [10044] DIST_GRU,  
   iif([10044]>0, ((HNROG-HNROG_ANT) )  / [10044] ,0) AVANCE_STOCK_GRU,  
  
   --grupos nuevos desembolsados   
   NUEVO_DESEM,  
   iif(HNROG_DESEM>0,  ((NUEVO_DESEM) )/ cast( HNROG_DESEM as float) ,0) AVANCE_NUEVO_DESEM,  
  
   --grupos recurrentes desembolsados  
   HULTVEN_RECUR_DESEM,  
   RECURRENTE_DESEM,  
  
   --Saldo de catera  
   HSALCAPMN_ANT ,[8000] META_VARSALDO,HSALCAPMN,HSALCAPMN-HSALCAPMN_ANT VAR_SALDO,HSALCAPMN-[8000] DIST_SALDO,  
   iif([8000]>0,    ((HSALCAPMN-HSALCAPMN_ANT))/[8000]  ,0) AVANCE_SALDO,  
  
   --mora 1-30  
   HSALCAPMN_1_30_ANT,  iif(HSALCAPMN>0,   (HSALCAPMN_1_30_ANT*100)/ HSALCAPMN ,0) AVMOR1_30_ANT,  
   HSALCAPMN_1_30,  iif(HSALCAPMN>0,    (HSALCAPMN_1_30*100)/ HSALCAPMN  ,0) AVMOR1_30,  
   HSALCAPMN_1_30-HSALCAPMN_1_30_ANT VAR_MOR1_30,  
   iif(HSALCAPMN>0,  ((HSALCAPMN_1_30-HSALCAPMN_1_30_ANT)*100) /HSALCAPMN  ,0)  POC_VAR_MOR1_30,  
  
   --mora >30  
   HSALCAPMN_ma_30_ANT, iif(HSALCAPMN>0,  (HSALCAPMN_ma_30_ANT *100)/ HSALCAPMN ,0) AVMORMA_30_ANT,  
   HSALCAPMN_ma_30,iif(HSALCAPMN>0,  (HSALCAPMN_ma_30 *100)/ HSALCAPMN  ,0) AVMORMA_30,  
   HSALCAPMN_ma_30-HSALCAPMN_ma_30_ANT VAR_MORMA_30,  
   iif(HSALCAPMN>0, ((HSALCAPMN_ma_30-HSALCAPMN_ma_30_ANT)*100) /HSALCAPMN  ,0) POC_VAR_MORMA_30  
   into #PRIM  
  
   from storage.com_act.WPDM001 A  
   left join metas B on eomonth(A.HFECPRO) = B.HFECPRO and A.HTIPCOD = B.HTIPCOD and  A.HCODREL = B.HCODREL  
   left join jerar C on A.HTIPCOD = C.HTIPCOD and  A.HCODREL = C.HCODREL  
   where  A.HTIPCOD =  @tip_cod and A.HCODREL = @cod_rel  
  
     
  
  
 -- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20240116'    
;with jerar as (  
  
 -- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20240116'    
  
   select distinct  
   CASE    
        WHEN @tip_cod = 7 THEN 21   
        WHEN @tip_cod = 21 THEN 20  
        WHEN @tip_cod = 20 THEN 19  
        WHEN @tip_cod = 19 THEN 18   
     WHEN @tip_cod = 18 THEN 17 
	  WHEN @tip_cod = 17 THEN 17 end HTIPCOD,  
   CASE    
        WHEN @tip_cod = 7 THEN cast(b.RCODGRU as varchar (5))   
        WHEN @tip_cod = 21 THEN cast(b.RCODTER as varchar (5))   
        WHEN @tip_cod = 20 THEN cast(b.RCODCOR as varchar (5))   
        WHEN @tip_cod = 19 THEN cast(b.RCODUNI as varchar (5))   
     WHEN @tip_cod = 18 THEN cast(b.RCODUNI as varchar (5))
	 WHEN @tip_cod = 17 THEN cast(b.RCODUCO as varchar (5)) end HCODREL,  
  
   CASE    
        WHEN @tip_cod = 7 THEN cast(b.RDESGRU as varchar (50))   
        WHEN @tip_cod = 21 THEN cast(b.RDESTER as varchar (50))   
        WHEN @tip_cod = 20 THEN cast(b.RDESCOR as varchar (50))   
        WHEN @tip_cod = 19 THEN cast(b.RDESUNI as varchar (50))   
     WHEN @tip_cod = 18 THEN cast(b.RDESUNI as varchar (50)) 
	  WHEN @tip_cod = 17 THEN cast(b.RDESUCO as varchar (50)) end HDESREL  
  
   from storage.ref.wjercor03 b  
   where    
CASE cast(@tip_cod as varchar (3))  
        WHEN 7 THEN cast(b.RCODFC as varchar (5))  
        WHEN 21 THEN cast(b.RCODGRU as varchar (5))  
        WHEN 20 THEN cast(b.RCODTER as varchar (5))  
        WHEN 19 THEN cast(b.RCODCOR as varchar (5))  
     WHEN 18 THEN cast(b.RCODUNI as varchar (5)) 
	 WHEN 17 THEN cast(b.RCODUCO as varchar (5)) 
    END =@cod_rel  
)  
,metas as (  
  select * from storage.com.metas_saldos   
  pivot (max(HVALVAR) for HCODVAR in  ([10062],[10044],[8000])) PVT    
  where HFECPRO = EOMONTH(@fec) and HTIPMETA = 1 and HTIPCOD in (select distinct(HTIPCOD) from jerar) and HCODREL in (select distinct(HCODREL) from jerar)  
 )   
   select 0 style,   HDESREL,  
   --stock clientes  
   HNUMCLI_ANT, [10062] META_VARCLIE,HNUMCLI, HNUMCLI-HNUMCLI_ANT VAR_CLI, HNUMCLI-[10062] DIST_CLI,  
   iif([10062]>0, ((HNUMCLI-HNUMCLI_ANT)) / [10062] ,0) AVANCE_STOCK_CLI  
  
   --stock grupo  
   ,HNROG_ANT, [10044] META_VARGRU, HNROG, HNROG - HNROG_ANT VAR_GRU, HNROG - [10044] DIST_GRU,  
   iif([10044]>0, ((HNROG-HNROG_ANT) )  / [10044] ,0) AVANCE_STOCK_GRU,  
  
   --grupos nuevos desembolsados   
   NUEVO_DESEM,  
   iif(HNROG_DESEM>0,  ((NUEVO_DESEM)*100 )/ cast( HNROG_DESEM as float) ,0) AVANCE_NUEVO_DESEM,  
  
   --grupos recurrentes desembolsados  
   HULTVEN_RECUR_DESEM,  
   RECURRENTE_DESEM,  
  
   --Saldo de catera  
   HSALCAPMN_ANT ,[8000] META_VARSALDO,HSALCAPMN,HSALCAPMN-HSALCAPMN_ANT VAR_SALDO,HSALCAPMN-[8000] DIST_SALDO,  
   iif([8000]>0,    ((HSALCAPMN-HSALCAPMN_ANT))/[8000]  ,0) AVANCE_SALDO,  
  
   --mora 1-30  
   HSALCAPMN_1_30_ANT,  iif(HSALCAPMN>0,   (HSALCAPMN_1_30_ANT*100)/ HSALCAPMN ,0) AVMOR1_30_ANT,  
   HSALCAPMN_1_30,  iif(HSALCAPMN>0,    (HSALCAPMN_1_30*100)/ HSALCAPMN  ,0) AVMOR1_30,  
   HSALCAPMN_1_30-HSALCAPMN_1_30_ANT VAR_MOR1_30,  
   iif(HSALCAPMN>0,  ((HSALCAPMN_1_30-HSALCAPMN_1_30_ANT)*100) /HSALCAPMN  ,0)  POC_VAR_MOR1_30,  
  
   --mora >30  
   HSALCAPMN_ma_30_ANT, iif(HSALCAPMN>0,  (HSALCAPMN_ma_30_ANT *100)/ HSALCAPMN ,0) AVMORMA_30_ANT,  
   HSALCAPMN_ma_30,iif(HSALCAPMN>0,  (HSALCAPMN_ma_30 *100)/ HSALCAPMN  ,0) AVMORMA_30,  
   HSALCAPMN_ma_30-HSALCAPMN_ma_30_ANT VAR_MORMA_30,  
   iif(HSALCAPMN>0, ((HSALCAPMN_ma_30-HSALCAPMN_ma_30_ANT)*100) /HSALCAPMN  ,0) POC_VAR_MORMA_30  
    into #SEC  
  
   from storage.com_act.WPDM001 A  
   left join metas B on eomonth(A.HFECPRO) = B.HFECPRO and A.HTIPCOD = B.HTIPCOD and  A.HCODREL = B.HCODREL  
   left join jerar C on A.HTIPCOD = C.HTIPCOD and  A.HCODREL = C.HCODREL  
   where  A.HTIPCOD in (select distinct(HTIPCOD) from jerar) and A.HCODREL in (select distinct(HCODREL) from jerar)  
  
  
  
  
   select * from #PRIM  
   union  
   select * from #SEC  
   order by style desc  
  
    
end
