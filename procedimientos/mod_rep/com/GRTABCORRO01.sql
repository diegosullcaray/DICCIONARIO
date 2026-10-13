-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-02-14 14:14:35.150000
--exec [com].[GRTABCORRO01]   7,'231','20230126'                                
CREATE  PROCEDURE [com].[GRTABCORRO01]                                                    
 @tip_cod int,                                                        
 @cod_rel varchar(20),                                                    
 @fec date                                                   
 as                                                    
begin                                                    
  SET NOCOUNT ON;                              
                              
                            
declare @Fecha date                            
set @Fecha=(SELECT  max(rfec) FROM [storage].[ref].[RCALEN001] WHERE (RFEC)<=@fec and RDIAFER=0)                            
                            
/*select *  into #FECS  --drop table #FECS  select * from  #FECS                            
from storage.util.FVECFEC01(@Fecha,'cmg_2,cmg_5,cmg_6')                      
*/              
              
select --rord,case when rord in(1,2) then EOMONTH(rfec) else rfec end rfec  into #FECS  --drop table #FECS  select * from  #FECS  
rord,  rfec  into #FECS  --drop table #FECS  select * from  #FECS                            
from storage.util.FVECFEC01(/*'20220201'*/@Fecha,'cmg_2,cmg_5,cmg_6')      

SELECT DISTINCT RCODAGE into #vjercor03   --DROP TABLE #vjercor03 
			FROM storage.ref.vjercor03
			where case when @tip_cod=7 then 1                          
                     when @tip_cod=15 then RCODTER                          
                     when @tip_cod=14 then RCODCOR                          
                     when @tip_cod=4 then RCODAGE                          
                 end =case when @tip_cod=7 then 1 else @cod_rel end 
 
/* #AgentesFC Stock */
;with cte_base as (
select HFECPRO,HCODREDEXT, case when HNOMCOR  like 'SATE%' then 'SATELITAL' ELSE 'PROPIO' END TIPO,HCODSUC,HESTCORR,HFECINSTALA 
from storage.com_act.HCMC004 --select top 5 *from storage.com_act.HCMC004
where hfecpro in(select rfec from #FECS)
),
cte_base_activos as (
select HFECPRO, HESTCORR, HCODSUC,HCODREDEXT,TIPO  
from cte_base    
WHERE  HESTCORR='AC' AND  HFECINSTALA is not null  
)  
 ,
cte_base_cancelados as (
select HFECPRO,HESTCORR, HCODSUC,  HCODREDEXT,TIPO  
from cte_base
where HESTCORR='CA'  AND  HFECINSTALA is not null  
--GROUP BY HFECPRO,HESTCORR,HCODSUC
),
cte_base_stock as (
SELECT * FROM cte_base_activos
UNION ALL
SELECT * FROM cte_base_cancelados
) 
,
cte_stock_ac_can as (  
 
select a.hfecpro,'stock_ac_can' as variable,null HTIPO,a.HESTCORR,count(distinct HCODREDEXT) HNUMCBASE
from cte_base_stock a
inner join #vjercor03 b
on a.HCODSUC=b.RCODAGE   
group by  a.hfecpro,a.HESTCORR
),  
cte_tipo as (
select a.hfecpro,'stock_ac_can_tipo' as variable,a.TIPO,A.HESTCORR,count(distinct HCODREDEXT) HNUMCBASE
from cte_base_stock a
inner join #vjercor03 b
on a.HCODSUC=b.RCODAGE   
group by  a.hfecpro,a.TIPO,A.HESTCORR
),
cte_k as (
select distinct hfecpro,HCODIGOCB   
from storage.com_act.HCMC001
where hfecpro in(select rfec from  #FECS)  and HESTADOTX='VIGENTE'  
),
cte_sintra as (
select  a.hfecpro,a.TIPO, HCODREDEXT ,a.HCODSUC,a.HESTCORR
from cte_base_stock a
left join  cte_k b
on a.HCODREDEXT=b.HCODIGOCB and a.hfecpro=b.hfecpro
where a.HESTCORR='AC' and b.HCODIGOCB is null 
),
cte_sintraj as (
select a.hfecpro,'sintransacciones' as variable,a.TIPO,'AC' HESTCORR,count(distinct HCODREDEXT) HNUMCBASE
from cte_sintra a
inner join #vjercor03 b
on a.HCODSUC=b.RCODAGE   
group by  a.hfecpro,a.TIPO 

),
pre_result as (
select * from cte_stock_ac_can
union all
select * from cte_tipo
union all
select * from cte_sintraj
)
select b.RORD,hfecpro,variable +'_'+isnull(HTIPO,'')+'_'+HESTCORR variable,HESTCORR,HNUMCBASE into #StockCorresponsales 
from pre_result a
left join #FECS b
on a.hfecpro=b.RFEC
  
--update #FECS set rfec='2022-07-30' where rord=2                        
                            
declare @Fec1 varchar(50), @Fec2 varchar(50), @Fec3 varchar(50)                            
set @Fec1 =(select rfec from #FECS where RORD=1)                            
set @Fec2 =(select rfec from #FECS where RORD=2)                            
set @Fec3 =(select rfec from #FECS where RORD=3)                            
                            
;with cte_a as (                            
select a.RORD,a.rfec ,case when b.SCORRES like '%SATE%' then 'SATELITAL' ELSE 'PROPIO' END TIPO, b.*                             
from #FECS a                            
left join (                            
     select * from storage.[com_act].SDAS021                             
     inner join (select distinct case when @tip_cod=7 then '1'                                                            
                                            when @tip_cod=15 then RDESTER                                                            
                                            when @tip_cod=14 then RDESCOR         
           --when @tip_cod=20 then RDESTER                                                            
             --                               when @tip_cod=19 then RDESCOR                                                            
                                            when @tip_cod=4 then RDESMAT                                                             
                                       end RDESJER                                                              
                       from storage.ref.vjercor03                                                             
                       where case when @tip_cod=7 then 1                                                            
                         when @tip_cod=15 then RCODTER                                                            
                         when @tip_cod=14 then RCODCOR           
       --when @tip_cod=20 then RCODTER                                                            
                         --when @tip_cod=19 then RCODCOR                                                            
                         when @tip_cod=4 then RCODMAT                                                            
                       end = case when @tip_cod=7 then 1 else @cod_rel end                            
       ) B                                                            
           ON CASE WHEN @TIP_COD=7 THEN '1'                                                            
                   WHEN @tip_cod=15 then STERRIT                                                             
                   when @tip_cod=14 then SCORRED         
       --WHEN @tip_cod=20 then STERRIT                                                             
                   --when @tip_cod=19 then SCORRED                                                 
                   when @tip_cod=4 then SAGENCI end = B.RDESJER                             
     where SCORRES is not null                             
    ) b                 
on a.rfec=b.sfecpro                            
),                            
cte_b as (                            
select RORD,rfec,TIPO,STIPTRA,sum(isnull(SNUMTRANS,0)) SNUMTRANS,sum(isnull(SMONTO,0)) SMONTO                            
from cte_a                             
group by RORD,rfec,TIPO,STIPTRA                             
--order by  rfec,tipo asc                            
),                            
ct_c as (                            
select RORD,rfec,sum(isnull(SMONTO,0)) SMONTO,sum(isnull(SNUMTRANS,0))SNUMTRANS,                        
case when sum(isnull(SNUMTRANS,0))=0 then 0 else sum(isnull(SMONTO,0)) / sum(isnull(SNUMTRANS,0)) end TICPROM                            
from cte_a                            
group by RORD,rfec                            
),                          
cte_d as (                            
select 'PorcTrans_'+STIPTRA Descripcion,a.RORD,a.rfec,a.STIPTRA,                      
case when  isnull(b.SNUMTRANS,0) = 0 then  0 else sum(CAST(isnull(a.SNUMTRANS,0) AS FLOAT))/ isnull(b.SNUMTRANS,0) end 'Porc_Transac'                             
from cte_b a                             
left join ct_c  b                             
on a.RFEC=b.RFEC                             
group by a.RORD,a.rfec,a.STIPTRA ,b.SNUMTRANS                           
),                            
cte_e as (                            
select 'CS'AS descripcion,RORD,rfec,null STIPTRA ,COUNT(DISTINCT CASE WHEN  HDESTIP='PROPIO' then HCODRES else NULL end)  SCORRES                            
from cte_a               
--WHERE TIPO='PROPIO' 
group by RORD,rfec                  
)               
,              
cte_w as (              
select 'CSAT'AS descripcion,RORD,rfec,null STIPTRA ,COUNT(DISTINCT CASE WHEN  HDESTIP='SATELITAL' then HCODRES else NULL end)  SCORRES                            
from cte_a               
--WHERE TIPO='SATELITAL' 
group by RORD,rfec                
)  ,                 
cte_z as ( --CT              
select 'CT'AS descripcion,RORD,rfec,null STIPTRA ,COUNT(DISTINCT HCODRES)  SCORRES                            
from cte_a               
group by RORD,rfec                
)  ,                             
cte_f as (                            
select 'TPromed'AS descripcion,RORD,rfec,null STIPTRA,case when sum(isnull(SNUMTRANS,0))=0 then 0 else sum(isnull(SMONTO,0)) / sum(isnull(SNUMTRANS,0)) end  TICPROM                            
from cte_a                            
group by RORD,rfec                            
),                            
cte_g as (                            
select 'NumTrans'AS descripcion,RORD,rfec,null STIPTRA,sum(isnull(SNUMTRANS,0))  SNUMTRANS                            
from cte_a                            
group by RORD,rfec                            
),                            
cte_h as (                            
select 'MontoTrans'AS descripcion,RORD,rfec,null STIPTRA,sum(isnull(SMONTO,0))  SMONTO                            
from cte_a                            
group by RORD,rfec                            
),                            
cte_i as (                            
select * from cte_b                            
),              
Cte_wx as (              
select 'NTRANXTOTALPROPIO' AS descripcion,RORD,rfec,null STIPTRA,sum((SNUMTRANS))  SNUMTRANS                            
from cte_b                 
WHERE TIPO='PROPIO'              
group by RORD,rfec--,STIPTRA              
),                
Cte_wxY as (              
select 'NTRANXTOTALSAT' AS descripcion,RORD,rfec,null STIPTRA,sum((SNUMTRANS))  SNUMTRANS                            
from cte_b                 
WHERE TIPO='SATELITAL'              
group by RORD,rfec,STIPTRA              
),                          
cte_j as (                            
select 'Num_Tra_' + TIPO +'_'+ STIPTRA AS descripcion,RORD,rfec,STIPTRA,(SNUMTRANS)  SNUMTRANS                            
from cte_b                            
),                  
CTE_KL AS (              
select 'MONTOTRANXTOTALPROPIO' AS descripcion,RORD,rfec,NULL STIPTRA,SUM(SMONTO)  SMONTO         
from cte_b                
WHERE TIPO='PROPIO'              
GROUP BY RORD,rfec              
),                 
CTE_KLX AS (              
select 'MONTOTRANXTOTALSAT' AS descripcion,RORD,rfec,NULL STIPTRA,SUM(SMONTO)  SMONTO                            
from cte_b                
WHERE TIPO='SATELITAL'              
GROUP BY RORD,rfec              
),                   
cte_k as (                            
select 'Mont_Tra_' + TIPO+'_'+STIPTRA AS descripcion,RORD,rfec,STIPTRA,(SMONTO)  SMONTO                            
from cte_b                            
),          
cte_kls as (          
select 'PERCENT_TRANSACORRESPONSALPRO' descripcion,a.RORD,a.rfec,null STIPTRA,        
CASE WHEN sum(b.SNUMTRANS)=0 THEN 0 ELSE cast(sum(a.SNUMTRANS) as float)/sum(b.SNUMTRANS) END SMONTO          
from Cte_wx a          
left join cte_g b          
on a.rfec=b.rfec          
group by a.RORD,a.rfec          
)                            
                            
select * INTO #Result from cte_e union all --drop table #Result drop table #Result1  drop table #FECS                    
select * from cte_w   union all                 
select * from cte_z union all                        
select * from cte_f union all                            
select * from cte_g union all                            
select * from cte_d union all                            
select * from cte_h  union all               
select * from Cte_wx union all                   
SELECT * FROM Cte_wxY UNION ALL                      
select * from cte_j where descripcion like '%Num_Tra_PROPIO%' union all                            
select * from cte_j where descripcion like '%Num_Tra_SATELITAL%' union all               
SELECT * FROM CTE_KL    union all               
SELECT * FROM CTE_KLX UNION ALL              
select * from cte_k where descripcion like '%Mont_Tra_PROPIO%' union all                            
select * from cte_k where descripcion like '%Mont_Tra_SATELITAL%' union all          
select * from cte_kls union all
select variable,RORD,hfecpro,HESTCORR,HNUMCBASE from #StockCorresponsales              
                            
                            
create table #Result1 --drop table #Result1                            
(descripcion varchar(max),STIPTRA varchar(250)null,V1 float null,V2 float null,V3 float null )                            
                            
DECLARE @Query NVARCHAR(MAX)                                      
 --Primero ponemos las columnas sobre las cuales agruparemos                                                
 SET @Query = N'SELECT descripcion,STIPTRA' + NCHAR(10)                            
 --Después colocamos las columnas que vamos a transponer                                                
 + ( SELECT REPLACE( N',sum( CASE WHEN RORD = <<RORD>> THEN SCORRES  END) AS V<<RORD>>', N'<<RORD>>', RORD)+ NCHAR(10)                                                
                                                
    FROM  #Result                                                      
    --Eliminamos duplicados usando GROUP BY                                                
    GROUP BY RORD                                                
    --Definimos el orden de las columnas                                                
   -- ORDER BY RORD asc                                               
    --Usamos esta instrucción para concatenar los valores                                                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                                
 --Ponemos el resto de la consulta                                                
 + N'FROM  #Result                                               
 group by descripcion,STIPTRA                               
 order by      descripcion asc     
 '                                
insert into #Result1                                                  
EXEC sp_Executesql @Query;                              
                            
--drop table FormatTable drop table #Result drop table #Result1  drop table #FECS                            
create table #FormatTable (id int identity(1,1) not null, style int null,cod_vars int null,cod varchar(250)null,descripcion varchar(250) null)                     
insert into #FormatTable values(1,null,'CT','Corresponsales netos con transacciones(instalados - cancelados)')                                
insert into #FormatTable values(1,null,'CS','Corresponsales no satelitales neto con transacciones')                               
insert into #FormatTable values(1,null,'CSAT','Corresponsales satelitales neto con transacciones')   

insert into #FormatTable values(1,null,'stock_ac_can__AC','Stock Corresponsal Activo')                               
insert into #FormatTable values(1,null,'stock_ac_can__CA','Stock Corresponsal Cancelado')  
insert into #FormatTable values(1,null,'stock_ac_can_tipo_PROPIO_AC','Corresponsales Stock no Satelital Activo')                               
insert into #FormatTable values(1,null,'stock_ac_can_tipo_PROPIO_CA','Corresponsales Stock no Satelital Cancelado')  
insert into #FormatTable values(1,null,'stock_ac_can_tipo_SATELITAL_AC','Corresponsales Stock Satelital Activo')                               
insert into #FormatTable values(1,null,'stock_ac_can_tipo_SATELITAL_CA','Corresponsales Stock Satelital Cancelado')  
insert into #FormatTable values(1,null,'sintransacciones_PROPIO_AC','Corresponsal no Satelital Sin Transacción')                               
insert into #FormatTable values(1,null,'sintransacciones_SATELITAL_AC','Corresponsal Satelital Sin Transacción')      
                    
insert into #FormatTable values(4,null,'','Transacciones en el Mes')                      
insert into #FormatTable values(2,null,'PERCENT_TRANSACORRESPONSALPRO','% de transacciones corresponsales no satelitales / Total transacciones')                            
insert into #FormatTable values(1,null,'TPromed','Ticket promedio transacciones')                            
insert into #FormatTable values(1,null,'NumTrans','N° transacciones')                
                            
insert into #FormatTable values(null,null,'PorcTrans_PAGO OBLIG.','% Transacciones Pago')                            
insert into #FormatTable values(null,null,'PorcTrans_RETIRO','% Transacciones Retiro')                            
insert into #FormatTable values(null,null,'PorcTrans_DEPOSITO','% Transacciones Deposito')                            
insert into #FormatTable values(1,null,'MontoTrans','Monto transacciones')                            
                            
insert into #FormatTable values(2,null,'NTRANXTOTALPROPIO','N° transacciones - no satelitales')                            
insert into #FormatTable values(null,null,'Num_Tra_PROPIO_DEPOSITO','Depósito')                            
insert into #FormatTable values(null,null,'Num_Tra_PROPIO_PAGO OBLIG.','Pago Oblig.')                            
insert into #FormatTable values(null,null,'Num_Tra_PROPIO_RETIRO','Retiro')                            
                  
insert into #FormatTable values(2,null,'MONTOTRANXTOTALPROPIO','S/. transacciones - no satelitales')                            
insert into #FormatTable values(null,null,'Mont_Tra_PROPIO_DEPOSITO','Depósito')                            
insert into #FormatTable values(null,null,'Mont_Tra_PROPIO_PAGO OBLIG.','Pago Oblig.')                            
insert into #FormatTable values(null,null,'Mont_Tra_PROPIO_RETIRO','Retiro')                         
                           
insert into #FormatTable values(2,null,'NTRANXTOTALSAT','N° transacciones - Satelital')                            
insert into #FormatTable values(null,null,'Num_Tra_SATELITAL_DEPOSITO','Depósito')                            
insert into #FormatTable values(null,null,'Num_Tra_SATELITAL_PAGO OBLIG.','Pago Oblig.')                            
insert into #FormatTable values(null,null,'Num_Tra_SATELITAL_RETIRO','Retiro')                            
                            
insert into #FormatTable values(2,null,'MONTOTRANXTOTALSAT','S/. transacciones - Satelital')                            
insert into #FormatTable values(null,null,'Mont_Tra_SATELITAL_DEPOSITO','Depósito')                            
insert into #FormatTable values(null,null,'Mont_Tra_SATELITAL_PAGO OBLIG.','Pago Oblig.')                            
insert into #FormatTable values(null,null,'Mont_Tra_SATELITAL_RETIRO','Retiro')                            
                            
declare @defs as rep.TTHCOLDEF  
 insert into @defs                                          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values                                         
 (1,1,1,'descripcion','Descripción','string',null,'40px'),               
 (2,2,1,'V1',@Fec1,'number',null,null),                                          
 (3,3,1,'V2',@Fec2,'number',null,null),                                          
 (4,4,1,'V3',@Fec3,'number',null,null),                                         
 (5,5,1,'Porce','Variación Porcentual','number',NULL,null)                            
 /*,                            
 (6,6,1,'Meta','Meta','string','.0-0',null),                            
 (7,7,1,'DistanciaM','Distancia Meta','string','.0-0',null) */                            
    
  select rep.FFTHCOLDEF(@defs) result;                                
                            
select a.style,a.id,a.descripcion,                            
case when a.descripcion IN('% Transacciones Pago','% Transacciones Retiro','% Transacciones Deposito','% de transacciones corresponsales no satelitales / Total transacciones') then format(b.V1,'P') else format(b.V1,'N0','en-US') end V1,                  

         
   
case when a.descripcion IN('% Transacciones Pago','% Transacciones Retiro','% Transacciones Deposito','% de transacciones corresponsales no satelitales / Total transacciones') then format(b.V2,'P') else format(b.V2,'N0','en-US') end V2 ,                  

         
   
case when a.descripcion IN('% Transacciones Pago','% Transacciones Retiro','% Transacciones Deposito','% de transacciones corresponsales no satelitales / Total transacciones') then format(b.V3,'P') else format(b.V3,'N0','en-US') end V3 ,                  

         
   
case when isnull(b.V2,0)=0 then null else format((isnull(b.V3,0)  - isnull(b.V2,0)) / isnull(b.V2,0),'P')   end Porce                            
from #FormatTable a                              
left join  #Result1 b on a.cod=b.descripcion                            
order by id asc                            
                            
END
