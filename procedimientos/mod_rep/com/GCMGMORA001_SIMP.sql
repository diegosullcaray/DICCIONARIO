-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-06-30 16:40:58.613000
--exec mod_rep.[com].[GCMGMORA001_SIMP] '231','20240521',7,1
CREATE PROCEDURE [com].[GCMGMORA001_SIMP](@cod_rel varchar(25), @fec date, @tip_cod varchar(5), @tipmeta int = 1)
AS
BEGIN
 SET NOCOUNT ON;
 
--DECLARE @fec date = '20240521', @tip_cod int = 7, @cod_rel VARCHAR(10)= '231', @tipmeta int = 1

---------------------------------------------------------  CABECERA DEL SP  ---------------------------------------------------------------------------- 
 SELECT * INTO #tabla 
 FROM [storage].[com].[FCMGCAB](@fec,1)A 
 pivot(MAX(VAL)
 for FORD in
 ([DESVAL],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15]))B 
  
 Declare @obtenerDesVal0 varchar(250),@obtenerAnioAnterior varchar(10),@obtenerAnioActual varchar(50), 
@obtenerNombreMeta varchar(250),@obtenerSema int, @obtenerNombreTMM varchar(50), 
 @obtenerNivel2_1anioanterior varchar(50),@obtenerNivel2_2anioanterior varchar(50),@obtenerNivel2_3anioanterior varchar(50), 
 @obtenerNivel2_1anioactual varchar(50), @obtenerNivel2_2anioactual varchar(50),@obtenerNivel2_3anioactual varchar(50)
 
 set @obtenerDesVal0 =(select desval from #tabla where fila=0)
 set @obtenerAnioAnterior=(select [2] from #tabla where fila=-1)
 set @obtenerAnioActual =(select [5] from #tabla where fila=-1)
 set @obtenerNombreMeta =(select [7] from #tabla where fila=-1)
 set @obtenerSema=(select [8] from #tabla where fila=0)
 set @obtenerNombreTMM =(select [9] from #tabla where fila=0)
 set @obtenerNivel2_1anioanterior=(select [1] from  #tabla where fila=0)
 set @obtenerNivel2_2anioanterior=(select [2] from #tabla where fila=0)
 set @obtenerNivel2_3anioanterior=(select [3] from #tabla where fila=0)
 set @obtenerNivel2_1anioactual=(select [4]  from #tabla where fila=0)
 set @obtenerNivel2_2anioactual=(select [5]  from #tabla where fila=0)
 set @obtenerNivel2_3anioactual=(select [6]  from #tabla where fila=0)
 
 DECLARE @json NVARCHAR(Max)= N'[{ 
"level": 1, 
"columns":[ 
{ 
"columnDef":"RDESVAR", 
"header": "'+@obtenerDesVal0+'", 
"isdata": 1, 
"sticky":true, 
"format":{ 
"type":"string" 
}, 
"rows":2 
}, 
{ 
"columnDef":"'+@obtenerAnioAnterior+'", 
"header": "'+@obtenerAnioAnterior+'", 
"cols":3 
}, 
{ 
"columnDef":"'+@obtenerAnioActual+'", 
"header": "'+@obtenerAnioActual+'", 
"cols":3 
}, 
{ 
"columnDef":7, 
"header": "META", 
"isdata": 8, 
"format":{ 
"type":"number" 
}, 
"rows":2 
}, 
{ 
"columnDef":12, 
"header": "", 
"isdata": 9, 
"hidden":true, 
"format":{ 
"type":"traffic-light" 
} 
}, 
{ 
"columnDef":13, 
"header": "Distancia Meta", 
"cols":2, 
"rows":2, 
"isdata": 10, 
"format":{ 
"type":"number" 
} 
} , 
{ 
"columnDef":8, 
"header": "", 
"isdata": 11, 
"hidden":true, 
"format":{ 
"type":"traffic-light" 
} 
}, 
{ 
"columnDef":9, 
"header": "'+@obtenerNombreTMM+'", 
"cols":2, 
"rows":2, 
"isdata": 12, 
"format":{ 
"type":"number" 
} 
}, 
{ 
"columnDef":10, 
"header": "", 
"isdata": 13, 
"hidden":true, 
"format":{ 
"type":"traffic-light" 
} 
}, 
{ 
"columnDef":11, 
"header": "TAM", 
"cols":2, 
"rows":2, 
"isdata": 12, 
"format":{ 
"type":"number" 
} 
}
] 
  }, 
  { 
"level":2, 
"columns":[ 
{ 
"columnDef":"1", 
"header":"'+@obtenerNivel2_1anioanterior+'",  
"isdata":2, 
"format":{ 
"type":"number" 
} 
}, 
{ 
"columnDef":"2", 
"header":"'+@obtenerNivel2_2anioanterior+'",  
"isdata":3, 
"format":{ 
"type":"number" 
} 
}, 
{ 
"columnDef":"3", 
"header":"'+@obtenerNivel2_3anioanterior+'",  
"isdata":4, 
"format":{ 
"type":"number" 
} 
}, 
{ 
"columnDef":"4", 
"header":"'+@obtenerNivel2_1anioactual+'",  
"isdata":5, 
"format":{ 
"type":"number" 
} 
}, 
{ 
"columnDef":"5", 
"header":"'+@obtenerNivel2_2anioactual+'",  
"isdata":6, 
"format":{ 
"type":"number" 
} 
}, 
{ 
"columnDef":"6", 
"header":"'+@obtenerNivel2_3anioactual+'",  
"isdata":7, 
"format":{ 
"type":"number" 
} 
} 
  
]  
  } 
  ]' 
 SELECT  LTRIM(RTRIM(@json)) 

DECLARE @fecs VARCHAR(MAX)
declare @fec11 date  

 
  
 
select * 
into #FECS 
from storage.util.FVECFEC01(@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')
--DECLARE @fec date = '20230630', @tip_cod int = 7, @cod_rel VARCHAR(10)= '231', @tipmeta int = 1,  @fecs VARCHAR(MAX)

 set @fec11=(select RFEC from #FECS where RORD=6)
  

select @fecs=string_agg(convert(varchar(10),RFEC,112),',')
from #FECS 
 
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL 
 
insert into @tvars 
values ('sal_cap_simp', null, '100', null, null, null),--Saldo Cartera (miles PEN)
  --('sal_cas_ss2', null, '116', null, null, null),--Castigo mes ----------
  ('sal_prov_ss7_simp', null, '148', null, null, null),--Gasto provision 
  ('sal_cero_simp', null, '1125', null, null, null),--Cero cuotas 
  ('num_cero_simp', null, '1126', null, null, null),--Cero Cuotas (Nro) 
  ('sal_ven_simp', null, '1003000', null, null, null),--Ratio de Mora Real REVA 
  ('rat_car_simp', null, '10040', null, null, null),--Ratio Car 
  ('sal_ref_simp', null, '119', null, null, null),--Cartera Refinanciada 
  /*('efec_m30_0', null, '126', null, null, null),--Efectividad -30-0d 
  ('efec_1_30', null, '122', null, null, null),--Efectividad 1-30d 
  ('efec_31_60', null, '124', null, null, null),--Efectividad 31-60d 
  ('efec_61_90', null, '127', null, null, null),--Efectividad 61-90d 
  ('efec_91_120', null, '128', null, null, null), --Efectividad 91-120d 
  ('efec_121_150', null, '129', null, null, null),--Efectividad 121-150d 
  ('efec_151_180', null, '130', null, null, null),--Efectividad 151-180d 
  ('efec_180', null, '131', null, null, null), --Efectividad 181d a mas 
  ('efec_jud', null, '132', null, null, null), --Efectividad Judicial 
  */
  ('sal_mor_30_simp', null, '9015', null, null, null)--Cartera Mora > 30 

insert into @tfil values ('todos', 'fec', @fecs)
insert into @tconf values ('level_alias', 'style'),('insert_to', '#RESULTPIV')
 
insert into @tfil 
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output 
 
 --drop table #RESULTPIV
 
create table #RESULTPIV --select*from #RESULTPIV 
(fila int, 
 cod_fec varchar(250)null, 
 style int null, 
 descripcion varchar(250)null, 
 [100] float, 
 [116] float, 
 [148] float, 
 [1125] float, 
 [1126] float, 
 [117] float, 
 [1003000] float, 
 [10040] float, 
 [119] float, 
 [126] float, 
 [122] float, 
 [124] float, 
 [127] float, 
 [128] float, 
 [129] float, 
 [130] float, 
 [131] float, 
 [132] float, 
 [9015] float 
)
 
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf --,@show_query=1 

delete from @tvars 
delete from @tfil   
insert into @tfil values ('todos', 'fec', @fecs)   

delete from @tconf where TKEYPROP='insert_to'
insert into @tconf values ('insert_to', '#RESULTPIV1')  

insert into @tvars   
values('efec_m30_0', null, '126', null, null, null),--Efectividad -30-0d        efec_m30_0 
('efec_1_30', null, '122', null, null, null),--Efectividad 1-30d 
  ('efec_31_60', null, '124', null, null, null),--Efectividad 31-60d 
  ('efec_61_90', null, '127', null, null, null),--Efectividad 61-90d 
  ('efec_91_120', null, '128', null, null, null), --Efectividad 91-120d 
  ('efec_121_150', null, '129', null, null, null),--Efectividad 121-150d 
  ('efec_151_180', null, '130', null, null, null),--Efectividad 151-180d 
  ('efec_180', null, '131', null, null, null), --Efectividad 181d a mas 
  ('efec_jud', null, '132', null, null, null) --Efectividad Judicial 

  
insert into @tfil                
exec piv.GPIVLEV04 @tip_cod,@cod_rel,@jerar output         
create table #RESULTPIV1 --select*from #RESULTPIV   
(fila int,   
 cod_fec varchar(250)null,   
 style int null,  
  descripcion varchar(250)null, [126] float,[9030] float,[122] FLOAT,[124] FLOAT,[127]FLOAT,[128]FLOAT,[129] FLOAT,[130] FLOAT,
  [131] FLOAT,[132] FLOAT)  
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf --,@show_query=1   
   

update a
set a.[126]=b.[126],A.[122]=B.[122],A.[124]=B.[124],A.[127]=B.[127],A.[128]=B.[128],A.[129]=B.[129],A.[130]=B.[130],
A.[131]=B.[131],A.[132]=B.[132]
from #RESULTPIV a
inner join #RESULTPIV1 b
on a.cod_fec=b.cod_fec and a.descripcion=b.descripcion


/*CALCULOS DIRECTO API*/ 
 ;with  cte_a  as( 
  select fila, cod_fec, style, descripcion, ISNULL([116], 0)[116], ISNULL([148], 0)[148], ISNULL([1125], 0)[1125], ISNULL([1126], 0)[1126] 
  ,([1003000] + ISNULL([116], 0))/ ([100] + ISNULL([116], 0))[10030] 
  , ISNULL([10040], 0)[10040], ISNULL([119], 0)[119], ISNULL([122], 0)[122], ISNULL([124], 0)[124], ISNULL([126], 0)[126] 
  , ISNULL([127], 0)[127], ISNULL([128], 0)[128], ISNULL([129], 0)[129], ISNULL([130], 0)[130], ISNULL([131], 0)[131], ISNULL([132], 0)[132] 
  , ISNULL([117], 0)[117], ISNULL([100], 0)[100] 
  , [1003000] [9015] 
  from #RESULTPIV 
 )
 select * 
 into #PROD00 
 from #FECS A 
 left join cte_a B 
 on  A.RFEC=B.descripcion 
unpivot(valores for variables in([116],[148],[1125],[1126],[10030], [10040],[119] 
--unpivot(valores for variables in([116],[1125],[120],[10030], [10040],[119] 
  ,[126],[122],[124],[127],[128],[129],[130],[131],[132],[117],[100],[9015]))UNPVT
  
 --REALIZAR AJUSTE MANUAL PARA EL DATO MENSUAL
--SELECT * FROM #PROD00 WHERE variables = 117 AND RFEC = '20220630'
UPDATE #PROD00 SET valores = valores + (-54111) WHERE variables = 117 AND RFEC = '20210630'
UPDATE #PROD00 SET valores = valores + (-1185.69999999995) WHERE variables = 117 AND RFEC = '20220531'
UPDATE #PROD00 SET valores = valores + (-7900) WHERE variables = 117 AND RFEC = '20220630'

 select  RORD, variables, valores 
 into #RESULT00 
 from #PROD00 
 UNION 
 select 7 FORD, B.HCODVAR, B.HVALVAR 
 FROM #PROD00 A 
  join [storage].[com].[VDMCOM01] B 
  on A.variables= B.HCODVAR 
and B.HTIPMETA = @tipmeta 
and B.HFECPRO = eomonth(@fec11)
and B.HTIPCOD = @tip_cod 
and B.HCODREL = @cod_rel 

 

/*resultados sin API*/
SELECT *
INTO #WJAS002
FROM storage.com_act.WJAS002_SIMP A  --select top 10 * from storage.com_act.WJAS002 where HFECPRO = '20210229' AND HCODREL = '231'
JOIN #FECS B ON a.HFECPRO = B.RFEC
--SELECT TOP 5 * FROM #WJAS002
 
UPDATE #WJAS002 SET HCAST12M = HCAST12M + 112.077079996466 WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20210227'
UPDATE #WJAS002 SET HCAST12M = HCAST12M + 267.84645999968 WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20210430'
UPDATE #WJAS002 SET HCAST12M = HCAST12M + (46.5804099887609) WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20220531'
UPDATE #WJAS002 SET HCAST12M = HCAST12M + (46.580410093069) WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20220630'

;with 
 cte_a as( 
 --SELECT B.RORD fila, B.RFEC descripcion 
 SELECT A.RORD fila, A.RFEC descripcion 
-- , CAST(A.HMORRNET as float)[10000] 
 , CAST(A.HVARMORRNET as float)[10010] 
 --, CAST(A.HGASPROV12M as float)[8120] --Gasto de Provisiones 12 Meses (miles PEN)
 , CAST(A.HVARCARREF as float)[8190] 
 , CAST(A.HCAST12M as float)[8160]  --Castigos 12 Mes (miles PEN)
-- , CAST(A.HRATMORR as float)[10020] 
 , CAST(A.HCARPROM12M as float)[9013] --Cartera Promedio 12 Meses (miles PEN)  
 , CAST(HNUMOPEZCNUE as float)[120] --operaciones cero cuota nuevos
 ,CAST(HSALZCMNNUE as float)[118]  --saldo cero cuota nuevos
 --FROM storage.com_act.WJAS002 A  --select top 10 * from storage.com_act.WJAS002 where HFECPRO = '20211231' AND HCODREL = '231' 
 FROM #WJAS002 A 
 --JOIN #FECS B ON a.HFECPRO = B.RFEC 
 WHERE A.HTIPCOD = @tip_cod and A.HCODREL = @cod_rel 
 --where A.HTIPCOD=7 and A.HCODREL='231' 
 )
 SELECT *
 INTO #ACUM01 
 FROM #FECS A
 LEFT JOIN cte_a B
  --onA.RORD=B.fila and A.RFEC=B.descripcion
  on A.RFEC=B.descripcion 
  unpivot (valores for variables in(/*[10000],*/ [10010], [8190], [8160], /*[10020],*/ [9013],[120],[118]))UNPVT 
  
   
 SELECT  RORD,variables,valores 
 INTO #RESULT01 
 FROM #ACUM01 
 UNION 
 SELECT 7 FORD, B.HCODVAR, B.HVALVAR 
 FROM #ACUM01 A 
  join [storage].[com].[VDMCOM01] B 
  on A.variables= B.HCODVAR 
and B.HTIPMETA = @tipmeta 
and B.HFECPRO = eomonth(@fec11)
and B.HTIPCOD = @tip_cod 
and B.HCODREL = @cod_rel 
 UNION 
 SELECT 6, 10020, 0.086231 
 --SELECT * FROM #RESULT01 WHERE variables IN (9013)
  
 -------- Mora Real Bruta (miles PEN)
SELECT A.RORD, SUM(A.[valores])[VAR02_MORARB] INTO #VAR02_MORARB FROM #RESULT01 A WHERE A.variables IN ('8160')GROUP BY A.RORD

-------- Mora Real Neta (miles PEN)
 SELECT A.RORD, SUM(A.[valores])[VAR01A] INTO #VAR01A_MORAREALNETA FROM #RESULT01 A WHERE A.variables IN ('10000')GROUP BY A.RORD 
 
create table #CMG
(RDESVAR varchar(250),
 RCODVAR int
)

insert into #CMG
values
('Cartera Total (miles PEN)',100),
('Cartera Promedio 12 Meses (miles PEN)',9013),
('Mora Contable (miles PEN)',9015),
('Var. Mora Real (miles PEN)',10010),
('Cartera Refinanciada (miles PEN)',119),
('Var. Cartera Refinanciada (miles PEN)',8190),
('Castigos Mes (miles PEN)',116),
('Castigos 12 Mes (miles PEN)',8160),

('Cero Cuotas (miles PEN)',1125),
('Cero Cuotas (Nro)',1126),
('Cero Cuotas nuevas (miles PEN)',118),
('Cero Cuotas nuevas (Nro)',120),

('Mora Real Bruta (miles PEN)',9016),
('Mora Real Neta (miles PEN)',10000),
('Venta de cartera (miles PEN)',10031),
('Venta de cartera 12 Meses (miles PEN)',10032),
('Ratio CAR (%)',10040),
--('Ratio de Mora Real (%)',10020),
--('RatioMoraReal(%)',9017),
--('RatiodeMoraRealREVA(%)',10030),
('Gasto Provisiones Bruto (miles PEN)',9018),
--('GastodeProvisionGenericayEspecifica(miles PEN)',148),
('Gasto de Provision Generica y Especifica (miles PEN)',9023),
--('GastodeProvisionGenericayEspecifica(miles PEN)',9024),
('Gasto Provisiones OM3155 (miles PEN)',9021),
('Gasto Prov. Voluntarias (miles PEN)',9010),
('Gasto Provisiones Neto (miles PEN)',9019),
('Gasto de Provisiones Bruto 12 Meses (miles PEN)',9025),
--('StockProvisiones(miles PEN)',9027),
('Cobertura Cartera Atrasada (%)',9028),
('Cobertura CAR (%)',9026),
('Prima Riesgo Neto (%)',9020),
('Monto de Recaudo (miles PEN)',9011),
('Tasa de Recaudo (%)',9012),
--('Recuperacion Castigos (miles PEN)',117),
--('Recuperacion Castigos 12 Meses (miles PEN)',9014),
('Efectividad -30-0d (%)',126),
('Efectividad 1-30d (%)',122),
('Efectividad 31-60d (%)',124),
('Efectividad 61-90d (%)',127),
('Efectividad 91-120d (%)',128),
('Efectividad 121-150d (%)',129),
('Efectividad 151-180d (%)',130),
('Efectividad 181d a mas (%)',131),
('Efectividad Judicial (%)',132)

SELECT *
 INTO #RESULTPRE
 FROM #RESULT00
 UNION ALL SELECT * FROM #RESULT01

/*Comparativos, formatos y presentacion*/
 select RORD, variables, util.FFMTVAR(variables,valores,null)SVALOR
 INTO #PARTE01
 from #RESULTPRE


select  case when concat(A.RORD,'-',B.RORD)= '6-4' then 9
when concat(A.RORD,'-',B.RORD)= '6-1' then 11
when concat(A.RORD,'-',B.RORD)= '6-7' then 13 end RORD
,A.variables
, util.FFMTVAR(A.variables,(ISNULL(A.valores, 0)-ISNULL(B.valores, 0)),iif(A.variables in(10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028),1,null))SVALOR
INTO #PARTE02_NUMEROS
	from #RESULTPRE A
  join #RESULTPRE B
  on A.variables=B.variables
 where concat(A.RORD,'-',B.RORD)in('6-4','6-1','6-7') 
 
 
SELECT  case when concat(A.RORD,'-',B.RORD)='6-4' then 8
when concat(A.RORD,'-',B.RORD)='6-1' then 10
when concat(A.RORD,'-',B.RORD)='6-7' then 12 end RORD
	, A.variables
 	, cast(util.FSEMVAR(A.variables, iif(A.variables in(10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028), 1, 0), iif(A.variables in (10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028), (ISNULL(A.valores, 0)-ISNULL(B.valores, 0))*10000, CASE WHEN ISNULL(B.valores, 0) = 0 THEN A.valores/1 ELSE ISNULL(A.valores, 0)/ISNULL(B.valores, 0)-1 END ))as varchar) SVALOR
  INTO #PARTE03_RATIOS  --SELECT * FROM #PARTE03_RATIOS
	FROM #RESULTPRE A
 JOIN #RESULTPRE B ON A.variables=B.variables
 WHERE concat(A.RORD,'-',B.RORD)in('6-4','6-1','6-7')
 
UPDATE #PARTE03_RATIOS SET SVALOR = NULL WHERE variables IN ('9021') AND RORD IN (8, 10, 12)
UPDATE #PARTE03_RATIOS SET SVALOR = NULL WHERE variables IN ('9010') AND RORD IN (8, 10, 12)

SELECT *
INTO #AAA
FROM #PARTE01
UNION ALL SELECT * FROM #PARTE02_NUMEROS
UNION ALL SELECT * FROM #PARTE03_RATIOS


--AA WHERE variables IN ('9021') AND RORD IN (8, 10, 12) ORDER BY RORD

 SELECT * 
INTO #RES 
FROM #AAA pivot (max(SVALOR)for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13]))PVT

SELECT A.RDESVAR, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13] 
FROM #CMG A 
inner JOIN #RES B ON A.RCODVAR = B.variables 
 
end
