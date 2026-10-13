-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-10 16:57:44.717000
--EXEC mod_rep.[com].[GRMENTOR001] '7',231,'20220809', 'TODO'       
--EXEC [mod_rep].[com].[GRMENTOR001] '7','231','20220809','TEAPZ100'

   
CREATE PROCEDURE [com].[GRMENTOR001](          
@tip_cod varchar(5),@cod_rel varchar(25), @fec date,@resp varchar(250))              
AS                
BEGIN              
 SET NOCOUNT ON;              
--declare @tip_cod varchar(5)='15',@cod_rel varchar(25)='1', @Fecha date='20210928'          
-------------          
--declare @fec date =(select MAX(hfecpro) from storage.[com_act].WCLIRETE001)
declare @defs as rep.TTHCOLDEF;          
          
insert into @defs          
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH)  values          
 (1,1,1,'descrip','Descripción',null,null,null,'string',null,null),          
 (2,1,2,'100','Saldo de Cartera (miles PEN)',null,null,null,'string',null,null),          
 (3,1,3,'165','Clientes del Activo (Nro)',null,null,null,'string',null,null),          
 (4,1,4,'5006','Ope. Desembolsadas (Nro)',null,null,null,'string',null,null),          
 (5,1,5,'5001','Seguro',null,null,null,'string',null,null), --          
 --(6,1,6,'202','Captaciones',null,null,null,null,null,null),           
 (6,1,6,'126','Efectividad -30-0d',null,null,null,'string',null,null),          
 (7,1,7,'122','Efectividad 1-30d',null,null,null,'string',null,null),          
 (8,1,8,'0001','Enrolamiento App',null,null,null,'string',null,null),          
 --(10,1,10,'0003','Corresponsal',null,null,null,null,null,null),          
 (9,1,9,'0002','Contratación Electronica',null,null,null,'string',null,null),
 (10,1,10,'0003','Clientes Nuevos',null,null,null,'string',null,null),
 (11,1,11,'5003','% Retención',null,null,null,'string',null,null)           
            
 select rep.FFTHCOLDEF(@defs) result;     
 
 declare @fec1 date,@fec2 date
 
 
 
 select * into #FECS from   storage.util.FVECFEC01(@fec,'cmg_5,cmg_6') 
declare @fecacumu varchar(max)
select @fecacumu=string_agg(format(RFEC,'yyyyMMdd'),',') 
from #FECS
  
  set @fec1=(select rfec from #fecs where rord=1)
 set @fec2=(select rfec from #fecs where rord=2)  --select * from #fecs
  
 IF @resp='TODO'
BEGIN 
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)            
          
insert into @tvars            
values  ('sal_cap', null, '100', null, null, null),          
     ('num_cli_stock', null, '166', null, null, null),          
  ('num_ope_sf2', null, '5006', null, null, null),          
  ('efec_m30_0', null, '126', null, null, null),--Efectividad -30-0d              
   ('efec_1_30', null, '122', null, null, null),--Efectividad 1-30d                  
  ('num_ope_ce01',null,'0002',null,null,null)   ,  
  ('cli_nuev',null,'0003',null,null,null)        
  --('Num_Pol_Seg',null,'5001',null,null,null) --,          
  --('num_pol_seg_ince',null,'5001',null,null,null) --,          
  --('Sal_Cap_red',null,'202',null,null,null)            
            
insert into @tfil values ('todos', 'fec', @fecacumu)            
insert into @tconf values ('level_alias', 'style')       
          
insert into @tfil            
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output            
 
create table #DES         
(fila int,cod_ varchar(250)null,style int null,descripcion varchar(250)null,[100] float null,            
 [165] float null,[5006] float null,[126] float null,[122] float null,[0002] float null,[0003]float null  --,        
 ---[202] float null        
)   
insert into #DES 
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf--,@show_query=1              
  
alter table #DES add [0001] float null,[5001] float null,[5003] float null

update a
set a.[5001]=b.NumSeg
from #DES a 
inner join (select a.SFECPRO,SUM(SNUMPLZ) NumSeg
			from storage.[com_seg].[SDSF001] a
			left join storage.ref.WJERCOR03 b 
			on a.SCODSEC=b.RCODSEC and b.RFECPRO in(select RFEC from #FECS)
			where              
				case            
					when @tip_cod=20 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')            
					when @tip_cod=19 then cast(B.RCODCOR as nvarchar(10))          
					when @tip_cod=21 then cast(B.RCODGRU as nvarchar(5))                
					when @tip_cod=18 then cast(B.RCODUNI as varchar(50)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)
		    and  a.SFECPRO in(select RFEC from #FECS) and a.scodseg in(200,802,803,806) and a.scodagr=8 
			GROUP BY a.SFECPRO)b
on A.descripcion=b.SFECPRO

--select * from #DES
 
update a
set a.[0001]=b.HNUMENROLADOS
from #DES a 
inner join (select a.HFECPRO,COUNT(distinct a.htipnumdoc) HNUMENROLADOS
			from storage.[com_act].WAPPCLI001 a
			left join storage.ref.WJERCOR03 b 
			on a.HAGUSER=b.RCODSEC and b.RFECPRO=@fec
			where              
				case            
					when @tip_cod=20 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')            
					when @tip_cod=19 then cast(B.RCODCOR as nvarchar(10))          
					when @tip_cod=21 then cast(B.RCODGRU as nvarchar(5))                
					when @tip_cod=18 then cast(B.RCODUNI as varchar(50)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)
			group by a.HFECPRO
			)b
on a.descripcion=b.HFECPRO
  
update a
set a.[5003]=b.P_Retencion
from #DES a 
inner join (select a.HFECPRO, cast(SUM(HNUMRETENCION)as float)/SUM(HNUMCLISTOCK) P_Retencion
			from storage.[com_act].WCLIRETE001 a --SELECT * FROM Storage.[com_act].WCLIRETE001
			left join storage.ref.WJERCOR03 b 
			on a.SCODSEC=b.RCODSEC and b.RFECPRO in(select RFEC from #FECS)
			where              
				case            
					when @tip_cod=20 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')            
					when @tip_cod=19 then cast(B.RCODCOR as nvarchar(10))          
					when @tip_cod=21 then cast(B.RCODGRU as nvarchar(5))                
					when @tip_cod=18 then cast(B.RCODUNI as varchar(50)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)
		    and  a.HFECPRO in(select RFEC from #FECS) 
			GROUP BY a.HFECPRO)b
on A.descripcion=b.HFECPRO
 
;with cte_m as ( 
select b.rfec HFECPRO, 
a.HCODVAR,a.HTIPCOD,a.HCODREL,a.HVALVAR
--into #Metas 
from  [storage].[com].[VDMCOM01] a
inner join (select* from #FECS)b
on a.HFECPRO=eomonth(b.rfec)
where HCODVAR in(100,166,5006,5001,126,122)   
and HTIPCOD= @tip_cod 
and case when @tip_cod=7 then '1' else @cod_rel end=case when @tip_cod=7 then '1' else HCODREL end
),
--100 SaldoCartera ,166 Clientes, 5006 operaciones,5001 Seguros,126 30a0,122 1a30
cte_metas as (
SELECT   HFECPRO, 
  [100],[166],[5006],[5001],[126],[122]
 
FROM  
(
  SELECT HVALVAR, HCODVAR,HFECPRO   
  FROM cte_m
) AS SourceTable  
PIVOT  
(  
  sum(HVALVAR )  
  FOR HCODVAR  IN ([100],[166],[5006],[5001],[126],[122])  
) AS PivotTable  
),
cte_into as (
select   ROW_NUMBER() OVER(ORDER BY hfecpro ASC) AS fila,* from cte_metas 
)
select *  into #Metas from cte_into 
  
;with cte_a as (
select 'Avance mes anterior' descrip,descripcion hfecpro, 
 [100],[165],[5006],[126],[122],[0002],[0003],[0001],[5001],[5003] 
from #DES 
where fila=1
),
cte_m as (
select 'Meta mes anterior'descrip, HFECPRO, 
[100],[166] AS [165], [5006],[126],[122],NULL [0002],NULL [0003],NULL [0001],[5001],NULL [5003] 
from #Metas
where fila=1
),
cte_b as (
select 'Avance actual' descrip ,descripcion hfecpro, 
[100],[165],[5006],[126],[122],[0002],[0003],[0001],[5001],[5003] 
from #DES 
where fila=2
),
cte_mm as (
select 'Meta actual'descrip,HFECPRO, 
[100],[166] AS [165], [5006],[126],[122],NULL [0002],NULL [0003],NULL [0001],[5001],NULL [5003]
from #Metas
where fila=2
) 
select descrip,  hfecpro, 
FORMAT([100],'N0')[100],FORMAT([165],'N0')[165],FORMAT([5006],'N0')[5006],
FORMAT([126],'P')[126],FORMAT([122],'P')[122],FORMAT([0002],'N0')[0002],
FORMAT([0003],'N0')[0003],FORMAT([0001],'N0')[0001],FORMAT([5001],'N0')[5001],FORMAT([5003],'P')[5003] 
from cte_b 
union all
select descrip,HFECPRO,
FORMAT([100],'N0') [100],FORMAT([165],'N0') AS [165], FORMAT([5006],'N0') [5006],
FORMAT([126],'P'),FORMAT([122],'P'),CAST(NULL AS VARCHAR(250)) [0002],CAST(NULL AS VARCHAR(250)) [0003],CAST(NULL AS VARCHAR(250)) [0001],
FORMAT([5001],'N0'),CAST(NULL AS VARCHAR(250)) [5003] 
from cte_mm 
union all
select '% Avance' ,a.hfecpro, 
	  FORMAT( (a.[100]/b.[100]),'P'),FORMAT( (a.[165]/b.[165]),'P'),
	  FORMAT( (a.[5006]/b.[5006]  ),'P'), FORMAT( (a.[126]/b.[126]  ),'P'),
	  FORMAT( (a.[122]/b.[122]  ),'P'), FORMAT( (a.[0002]/b.[0002]  ),'P'),
	  FORMAT( (a.[0003]/b.[0003]  ),'P'),FORMAT( (a.[0001]/b.[0001]  ),'P'),
	  FORMAT( (a.[5001]/b.[5001]  ),'P'),FORMAT( (a.[5003]/b.[5003]  ),'P')
from cte_b a
left join cte_mm b on a.hfecpro=b.hfecpro
union all
select   descrip,  hfecpro, 
FORMAT([100],'N0')[100],FORMAT([165],'N0')[165],FORMAT([5006],'N0')[5006],
FORMAT([126],'P')[126],FORMAT([122],'P')[122],FORMAT([0002],'N0')[0002],
FORMAT([0003],'N0')[0003],FORMAT([0001],'N0')[0001],FORMAT([5001],'N0')[5001],FORMAT([5003],'P')[5003] 
from cte_a
union all
select descrip,HFECPRO,
FORMAT([100],'N0') [100],FORMAT([165],'N0') AS [165], FORMAT([5006],'N0') [5006],
FORMAT([126],'P'),FORMAT([122],'P'),CAST(NULL AS VARCHAR(250)) [0002],CAST(NULL AS VARCHAR(250)) [0003],CAST(NULL AS VARCHAR(250)) [0001],
FORMAT([5001],'N0'),CAST(NULL AS VARCHAR(250)) [5003] 
from cte_m 
union all
select '% Avance' ,a.hfecpro, 
	    FORMAT( (a.[100]/b.[100]),'P'),FORMAT( (a.[165]/b.[165]),'P'),
	  FORMAT( (a.[5006]/b.[5006]  ),'P'), FORMAT( (a.[126]/b.[126]  ),'P'),
	  FORMAT( (a.[122]/b.[122]  ),'P'), FORMAT( (a.[0002]/b.[0002]  ),'P'),
	  FORMAT( (a.[0003]/b.[0003]  ),'P'),FORMAT( (a.[0001]/b.[0001]  ),'P'),
	  FORMAT( (a.[5001]/b.[5001]  ),'P'),FORMAT( (a.[5003]/b.[5003]  ),'P')
from cte_a a
left join cte_m b on a.hfecpro=b.hfecpro
 
END 
else
begin 

;with cte_desembolsos as (
select scodsec,SNUMOPE from storage.[com_act].[SDAF002]
where sfecpro=@fec2 and SCODAGR=3 and scodsec=@resp-- in(select  RCODSEC from #WJERCOR03 where RCODSEC=@resp)
),
cte_cartera as (
select scodsec,SSALCAPMN from storage.[com_act].[SDAS001]
where sfecpro=@fec2 and SCODAGR=3  and scodsec=@resp
),
cte_clientes as (
select hcodrel,HNUMCLI from storage.com_act.WJAS001  where hfecpro=@fec2 and htipcod=1 and hcodrel=@resp
),
cte_seguros as (
select SCODSEC,sum(SNUMPLZ) SNUMPLZ       
from storage.[com_seg].[SDSF001]          
where sfecpro=@fec2 and SCODSEC=@resp
and SCODSEG in(802,806,803,200)          
and scodagr=8
group by SCODSEC
/* 802: PC ,  806: AGR , 803: MC , 200: MR */
),
cte_mora_30a0 as (
select SCODSEC,sum(isnull(SSALRECMN,0)+isnull(SSALMAN01MN,0))/sum(SSALINIMN) dat_efec_m30_0
from storage.[com_act].[SDAE002]
where sfecpro=@fec2 and scodsec=@resp
and scodagr=3 and scodsec=@resp
group by SCODSEC
),
cte_mora_1a30 as (
select SCODSEC,sum(isnull(SSALRECMN,0)+isnull(SSALMAN01MN,0))/sum(SSALINIMN) dat_efec_1_30
from storage.[com_act].[SDAE003]
where sfecpro=@fec2 and scodsec=@resp
and scodagr=3 and scodsec=@resp
group by SCODSEC
),
cte_enrolamiento as (
select HAGUSER,COUNT(*)Num_enrolados from storage.[com_act].WAPPCLI001
where HFECPRO=@fec2 and HAGUSER=@resp
group by HAGUSER
),
cte_CE as (
select HCODSEC,COUNT(distinct HCODOPE)HCODOPE from storage.com_act.WCDCE001
where hfecpro=@fec2 and HCODSEC=@resp
group by HCODSEC
),
cte_clientesnuevos as (
SELECT  HCODSEC,Count(DISTINCT CASE WHEN hinddes = 1 AND hclinue = 1 THEN hconcli ELSE NULL END) HNUMCLIN
  FROM   [storage].[com_act].wacli001
  WHERE  hfecpro =@fec2   and HCODSEC=@resp
  group by HCODSEC
),
/*cte_corresponsal as (
select @resp HCOSEC,COUNT(distinct HTXBANTOTAL) Num_Transac from storage.com_act.HCMC001  --select * from storage.com_act.HCMC001 
where HESTADOTX='VIGENTE' and HFECPRO=@fec
and HCTACLIE in(select distinct  HCTACLI  from #VCAH001  union all  select distinct  HSBCTA from #VCPH003)
),*/
 
cte_retencion as (
select scodsec, cast(SUM(HNUMRETENCION)as float)/SUM(HNUMCLISTOCK) retencion 
from storage.[com_act].WCLIRETE001  where scodsec=@resp
and hfecpro=@fec2
group by scodsec
),
cte_union  as(
select * from cte_cartera union all
select * from cte_clientes union all
select * from cte_desembolsos union all
select * from cte_seguros union all
select * from cte_mora_30a0 union all
select * from cte_mora_1a30 union all
select * from cte_enrolamiento union all
--select * from cte_corresponsal union all
select * from cte_CE union all
select * from cte_retencion  union all
select * from cte_clientesnuevos
)
select distinct @fec2 hfecpro, a.SCODSEC,a.SSALCAPMN [100],b.HNUMCLI [165],c.SNUMOPE [5006],d.SNUMPLZ [5001],e.dat_efec_m30_0 [126],
f.dat_efec_1_30 [122],g.Num_enrolados [0001],
/*h.Num_Transac,*/i.HCODOPE [0002],j.retencion [5003],k.HNUMCLIN as [0003]
into #Diario
from cte_cartera a 
left join cte_clientes b 
on a.SCODSEC=b.HCODREL
left join cte_desembolsos c
on a.SCODSEC=c.SCODSEC
left join cte_seguros d
on a.SCODSEC=d.SCODSEC
left join cte_mora_30a0 e
on a.SCODSEC=e.SCODSEC
left join cte_mora_1a30 f
on a.SCODSEC=f.SCODSEC
left join cte_enrolamiento g
on a.SCODSEC=g.HAGUSER
/*left join cte_corresponsal h
on a.SCODSEC=h.HCOSEC*/
left join cte_CE i
on a.SCODSEC=i.HCODSEC
left join cte_retencion j
on a.SCODSEC=j.SCODSEC
left join cte_clientesnuevos k
on a.SCODSEC=k.HCODSEC
--select RCODSEC,nro_clientes_stock from cte_ratio_rete where RCODSEC=@resp
--select * from cte_corresponsal

-----------------------------

 
;with cte_desembolsos as (
select scodsec,SNUMOPE from storage.[com_act].[SDAF002]
where sfecpro=@fec1 and SCODAGR=3 and scodsec=@resp-- in(select  RCODSEC from #WJERCOR03 where RCODSEC=@resp)
),
cte_cartera as (
select scodsec,SSALCAPMN from storage.[com_act].[SDAS001]
where sfecpro=@fec1 and SCODAGR=3  and scodsec=@resp
),
cte_clientes as (
select hcodrel,HNUMCLI from storage.com_act.WJAS001  where hfecpro=@fec1 and htipcod=1 and hcodrel=@resp
),
cte_seguros as (
select SCODSEC,sum(SNUMPLZ)SNUMPLZ         
from storage.[com_seg].[SDSF001]          
where sfecpro=@fec1 and SCODSEC=@resp
and SCODSEG in(802,806,803,200)          
and scodagr=8
group by SCODSEC
/* 802: PC ,  806: AGR , 803: MC , 200: MR */
),
cte_mora_30a0 as (
select SCODSEC,sum(isnull(SSALRECMN,0)+isnull(SSALMAN01MN,0))/sum(SSALINIMN) dat_efec_m30_0
from storage.[com_act].[SDAE002]
where sfecpro=@fec1 and scodsec=@resp
and scodagr=3 and scodsec=@resp
group by SCODSEC
),
cte_mora_1a30 as (
select SCODSEC,sum(isnull(SSALRECMN,0)+isnull(SSALMAN01MN,0))/sum(SSALINIMN) dat_efec_1_30
from storage.[com_act].[SDAE003]
where sfecpro=@fec1 and scodsec=@resp
and scodagr=3 and scodsec=@resp
group by SCODSEC
),
cte_enrolamiento as (
select HAGUSER,COUNT(*)Num_enrolados from storage.[com_act].WAPPCLI001
where HFECPRO=@fec1 and HAGUSER=@resp
group by HAGUSER
),
cte_CE as (
select HCODSEC,COUNT(distinct HCODOPE)HCODOPE from storage.com_act.WCDCE001
where hfecpro=@fec1 and HCODSEC=@resp
group by HCODSEC
),
/*cte_corresponsal as (
select @resp HCOSEC,COUNT(distinct HTXBANTOTAL) Num_Transac from storage.com_act.HCMC001  --select * from storage.com_act.HCMC001 
where HESTADOTX='VIGENTE' and HFECPRO=@fec
and HCTACLIE in(select distinct  HCTACLI  from #VCAH001  union all  select distinct  HSBCTA from #VCPH003)
),*/
 
cte_retencion as (
select scodsec, cast(SUM(HNUMRETENCION)as float)/SUM(HNUMCLISTOCK) retencion from storage.[com_act].WCLIRETE001  where scodsec=@resp
and hfecpro=@fec1
group by scodsec
),
cte_clientesnuevos as (
SELECT  HCODSEC,Count(DISTINCT CASE WHEN hinddes = 1 AND hclinue = 1 THEN hconcli ELSE NULL END) HNUMCLIN
  FROM   [storage].[com_act].wacli001
  WHERE  hfecpro =@fec1   and HCODSEC=@resp
  group by HCODSEC
),
cte_union  as(
select * from cte_cartera union all
select * from cte_clientes union all
select * from cte_desembolsos union all
select * from cte_seguros union all
select * from cte_mora_30a0 union all
select * from cte_mora_1a30 union all
select * from cte_enrolamiento union all
--select * from cte_corresponsal union all
select * from cte_CE union all
select * from cte_retencion  union all
select * from cte_clientesnuevos
)
select distinct @fec1 hfecpro, a.SCODSEC, 
a.SSALCAPMN [100],b.HNUMCLI [165],c.SNUMOPE [5006],d.SNUMPLZ [5001],e.dat_efec_m30_0 [126],
f.dat_efec_1_30 [122],g.Num_enrolados [0001],
/*h.Num_Transac,*/i.HCODOPE [0002],j.retencion [5003],k.HNUMCLIN as [0003]
into #MAnterior
from cte_cartera a 
left join cte_clientes b 
on a.SCODSEC=b.HCODREL
left join cte_desembolsos c
on a.SCODSEC=c.SCODSEC
left join cte_seguros d
on a.SCODSEC=d.SCODSEC
left join cte_mora_30a0 e
on a.SCODSEC=e.SCODSEC
left join cte_mora_1a30 f
on a.SCODSEC=f.SCODSEC
left join cte_enrolamiento g
on a.SCODSEC=g.HAGUSER
/*left join cte_corresponsal h
on a.SCODSEC=h.HCOSEC*/
left join cte_CE i
on a.SCODSEC=i.HCODSEC
left join cte_retencion j
on a.SCODSEC=j.SCODSEC
left join cte_clientesnuevos k
on a.SCODSEC=k.HCODSEC
--select RCODSEC,nro_clientes_stock from cte_ratio_rete where RCODSEC=@resp
--select * from cte_corresponsal

;with cte_m as ( 
select b.rfec HFECPRO, 
a.HCODVAR,a.HTIPCOD,a.HCODREL,a.HVALVAR
--into #Metas 
from  [storage].[com].[VDMCOM01] a --select *  from  [storage].[com].[VDMCOM01] where hcodrel='TGQUS100' and htipcod=1
inner join (select* from #FECS)b
on a.HFECPRO=eomonth(b.rfec)
where HCODVAR in(100,166,5006,5001,126,122)   
and HTIPCOD= 1 and HCODREL=@resp 
and case when @tip_cod=7 then '1' else @cod_rel end=case when @tip_cod=7 then '1' else HCODREL end
),
--100 SaldoCartera ,166 Clientes, 5006 operaciones,5001 Seguros,126 30a0,122 1a30
cte_metas as (
SELECT   HFECPRO, 
  [100],[166],[5006],[5001],[126],[122]
 
FROM  
(
  SELECT HVALVAR, HCODVAR,HFECPRO   
  FROM cte_m
) AS SourceTable  
PIVOT  
(  
  sum(HVALVAR )  
  FOR HCODVAR  IN ([100],[166],[5006],[5001],[126],[122])  
) AS PivotTable  
),
cte_into as (
select   ROW_NUMBER() OVER(ORDER BY hfecpro ASC) AS fila,* from cte_metas 
)
select *  into #Metas2 from cte_into 


;with cte_a as (
select 'Avance mes anterior' descrip,  hfecpro, 
 [100],[165],[5006],[126],[122],[0002],[0003], [0001],[5001],[5003] 
from #MAnterior  --select * from #MAnterior
),
cte_m as (
select 'Meta mes anterior'descrip, HFECPRO, 
[100],[166] AS [165], [5006],[126],[122],NULL [0002],NULL [0003],NULL [0001],[5001],NULL [5003] 
from #Metas2
where fila=1
),
cte_b as (
select 'Avance actual' descrip ,  hfecpro, 
[100],[165],[5006],[126],[122],[0002],[0003], [0001],[5001],[5003] 
from #Diario  
),
cte_mm as (
select 'Meta actual'descrip,HFECPRO, 
[100],[166] AS [165], [5006],[126],[122],NULL [0002],NULL [0003],NULL [0001],[5001],NULL [5003]
from #Metas2
where fila=2
) 
select descrip,  hfecpro, 
FORMAT([100],'N0')[100],FORMAT([165],'N0')[165],FORMAT([5006],'N0')[5006],
FORMAT([126],'P')[126],FORMAT([122],'P')[122],FORMAT([0002],'N0')[0002],
FORMAT([0003],'N0')[0003],FORMAT([0001],'N0')[0001],FORMAT([5001],'N0')[5001],FORMAT([5003],'P')[5003] 
from cte_b 
union all
select descrip,HFECPRO,
FORMAT([100],'N0') [100],FORMAT([165],'N0') AS [165], FORMAT([5006],'N0') [5006],
FORMAT([126],'P'),FORMAT([122],'P'),CAST(NULL AS VARCHAR(250)) [0002],CAST(NULL AS VARCHAR(250)) [0003],CAST(NULL AS VARCHAR(250)) [0001],
FORMAT([5001],'N0'),CAST(NULL AS VARCHAR(250)) [5003] 
from cte_mm 
union all
select '% Avance' ,a.hfecpro, 
	  FORMAT( (a.[100]/b.[100]),'P'),FORMAT( (a.[165]/b.[165]),'P'),
	  FORMAT( (a.[5006]/b.[5006]  ),'P'), FORMAT( (a.[126]/b.[126]  ),'P'),
	  FORMAT( (a.[122]/b.[122]  ),'P'), FORMAT( (a.[0002]/b.[0002]  ),'P'),
	  FORMAT( (a.[0003]/b.[0003]  ),'P'),FORMAT( (a.[0001]/b.[0001]  ),'P'),
	  FORMAT( (a.[5001]/b.[5001]  ),'P'),FORMAT( (a.[5003]/b.[5003]  ),'P')
from cte_b a
left join cte_mm b on a.hfecpro=b.hfecpro
union all
select   descrip,  hfecpro, 
FORMAT([100],'N0')[100],FORMAT([165],'N0')[165],FORMAT([5006],'N0')[5006],
FORMAT([126],'P')[126],FORMAT([122],'P')[122],FORMAT([0002],'N0')[0002],
FORMAT([0003],'N0')[0003],FORMAT([0001],'N0')[0001],FORMAT([5001],'N0')[5001],FORMAT([5003],'P')[5003] 
from cte_a
union all
select descrip,HFECPRO,
FORMAT([100],'N0') [100],FORMAT([165],'N0') AS [165], FORMAT([5006],'N0') [5006],
FORMAT([126],'P'),FORMAT([122],'P'),CAST(NULL AS VARCHAR(250)) [0002],CAST(NULL AS VARCHAR(250)) [0003],CAST(NULL AS VARCHAR(250)) [0001],
FORMAT([5001],'N0'),CAST(NULL AS VARCHAR(250)) [5003] 
from cte_m 
union all
select '% Avance' ,a.hfecpro, 
	    FORMAT( (a.[100]/b.[100]),'P'),FORMAT( (a.[165]/b.[165]),'P'),
	  FORMAT( (a.[5006]/b.[5006]  ),'P'), FORMAT( (a.[126]/b.[126]  ),'P'),
	  FORMAT( (a.[122]/b.[122]  ),'P'), FORMAT( (a.[0002]/b.[0002]  ),'P'),
	  FORMAT( (a.[0003]/b.[0003]  ),'P'),FORMAT( (a.[0001]/b.[0001]  ),'P'),
	  FORMAT( (a.[5001]/b.[5001]  ),'P'),FORMAT( (a.[5003]/b.[5003]  ),'P')
from cte_a a
left join cte_m b on a.hfecpro=b.hfecpro
 

end
          
 end
