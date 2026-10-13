-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-09-11 16:29:29.190000
--EXEC [mod_rep].[com].[GCMGMORA001] '231', '20250712', 7
CREATE PROCEDURE [com].[GCMGMORA001](@cod_rel varchar(25), @fec date, @tip_cod varchar(5), @tipmeta int = 1)
AS
BEGIN
 SET NOCOUNT ON;
--DECLARE @fec date = '20250712', @tip_cod int = 7, @cod_rel VARCHAR(10)= '231', @tipmeta int = 1
DECLARE @fecs VARCHAR(MAX)
declare @fec11 date  
 
 
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
values ('sal_cap', null, '100', null, null, null),--Saldo Cartera (miles PEN)
  ('sal_cas_ss2', null, '116', null, null, null),--Castigo mes 
  ('sal_prov_ss7', null, '148', null, null, null),--Gasto provision 
  ('sal_cero', null, '1125', null, null, null),--Cero cuotas 
  ('num_cero', null, '1126', null, null, null),--Cero Cuotas (Nro)
  ('rec_cast', null, '117', null, null, null),--Recuperacion Castigos 
  ('sal_ven', null, '1003000', null, null, null),--Ratio de Mora Real REVA 
  ('rat_car', null, '10040', null, null, null),--Ratio Car 
  ('sal_ref', null, '119', null, null, null),--Cartera Refinanciada 
  --('efec_m30_0', null, '126', null, null, null),--Efectividad -30-0d 
  --('efec_1_30', null, '122', null, null, null),--Efectividad 1-30d 
  --('efec_31_60', null, '124', null, null, null),--Efectividad 31-60d 
  --('efec_61_90', null, '127', null, null, null),--Efectividad 61-90d 
  --('efec_91_120', null, '128', null, null, null), --Efectividad 91-120d 
  --('efec_121_150', null, '129', null, null, null),--Efectividad 121-150d 
  --('efec_151_180', null, '130', null, null, null),--Efectividad 151-180d 
  --('efec_180', null, '131', null, null, null), --Efectividad 181d a mas 
  --('efec_jud', null, '132', null, null, null), --Efectividad Judicial 
  ('sal_mor_30', null, '9015', null, null, null)--Cartera Mora > 30 
  --('efec_sal_pag_m0', null, '9030', null, null, null)  --efectividad_pago puntual

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
 [9015] float ,
 [9030] float
)
 
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf --,@show_query=1 

delete from @tvars 
delete from @tfil   
insert into @tfil values ('todos', 'fec', @fecs)   

delete from @tconf where TKEYPROP='insert_to'
insert into @tconf values ('insert_to', '#RESULTPIV1')  
 
insert into @tvars   
values('efec_m30_0', null, '126', null, null, null),--Efectividad -30-0d        efec_m30_0
('efec_sal_pag_m0', null, '9030', null, null, null),
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
set a.[126]=b.[126],a.[9030]=b.[9030],A.[122]=B.[122],A.[124]=B.[124],A.[127]=B.[127],A.[128]=B.[128],A.[129]=B.[129],A.[130]=B.[130],
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
  , [1003000] [9015] ,  isnull([9030],0) [9030]
  from #RESULTPIV 
 )
 select * 
 into #PROD00 
 from #FECS A 
 left join cte_a B 
 on  A.RFEC=B.descripcion 
unpivot(valores for variables in([116],[148],[1125],[1126],[10030], [10040],[119] 
--unpivot(valores for variables in([116],[1125],[120],[10030], [10040],[119] 
  ,[126],[122],[124],[127],[128],[129],[130],[131],[132],[117],[100],[9015],[9030]))UNPVT

--REALIZAR AJUSTE MANUAL PARA EL DATO MENSUAL
--SELECT * FROM #PROD00 WHERE variables = 117 AND RFEC = '20220630'
UPDATE #PROD00 SET valores = valores + (-54111) WHERE variables = 117 AND RFEC = '20210630'
UPDATE #PROD00 SET valores = valores + (-1185.69999999995) WHERE variables = 117 AND RFEC = '20220531'
UPDATE #PROD00 SET valores = valores + (-7900) WHERE variables = 117 AND RFEC = '20220630'
---- 
 

 select  RORD, variables, valores 
 into #RESULT00 
 from #PROD00   ---select RORD, variables, valores from #PROD00
 UNION 
 select 7 FORD, B.HCODVAR, B.HVALVAR 
 FROM #PROD00 A 
  join [storage].[com].[VDMCOM01] B 
  on A.variables= B.HCODVAR 
and B.HTIPMETA = @tipmeta 
and B.HFECPRO = eomonth(@fec11)
and B.HTIPCOD = @tip_cod 
and B.HCODREL = @cod_rel 
 
 -----------------aqui 
/*resultados sin API*/
SELECT *
INTO #WJAS002
FROM storage.com_act.WJAS002 A  --select top 10 * from storage.com_act.WJAS002 where HFECPRO = '20210229' AND HCODREL = '231'
JOIN #FECS B ON a.HFECPRO = B.RFEC
--SELECT TOP 5 * FROM #WJAS002

----UPDATE storage.com_act.WJAS002 SET HCAST12M = 83952481.16959 WHERE HTIPCOD = 7 AND HFECPRO = '20220531'

--SELECT * FROM storage.com_act.WJAS002 WHERE HCODREL = '231' AND HFECPRO >= '20210101' ORDER BY HFECPRO, HTIPCOD
--SELECT TOP 10 *, (HCAST12M + (6854046.18040998))HCAST12M_F FROM storage.com_act.WJAS002 WHERE HTIPCOD = 7 AND HFECPRO = '20220531'
--SELECT TOP 10 * FROM #WJAS002 WHERE HCODREL = '231' AND HTIPCOD = 7 ORDER BY HFECPRO

UPDATE #WJAS002 SET HCAST12M = HCAST12M + 112.077079996466 WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20210227'
UPDATE #WJAS002 SET HCAST12M = HCAST12M + 267.84645999968 WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20210430'
UPDATE #WJAS002 SET HCAST12M = HCAST12M + (46.5804099887609) WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20220531'
UPDATE #WJAS002 SET HCAST12M = HCAST12M + (46.580410093069) WHERE HCODREL = '231' AND HTIPCOD = 7 AND HFECPRO = '20220630'

;with 
 cte_a as( 
 --SELECT B.RORD fila, B.RFEC descripcion 
 SELECT A.RORD fila, A.RFEC descripcion 
 , CAST(A.HMORRNET as float)[10000] 
 , CAST(A.HVARMORRNET as float)[10010] 
 --, CAST(A.HGASPROV12M as float)[8120] --Gasto de Provisiones 12 Meses (miles PEN)
 , CAST(A.HVARCARREF as float)[8190] 
 , CAST(A.HCAST12M as float)[8160]  --Castigos 12 Mes (miles PEN)
 , CAST(A.HRATMORR as float)[10020] 
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
  unpivot (valores for variables in([10000], [10010], [8190], [8160], [10020], [9013],[120],[118]))UNPVT 

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
  

/*Resultados del Servidor 70*/ 
;with 
cte_a as( 
 SELECT  B.RORD fila, B.RFEC descripcion 
  , cast(ISNULL(A.[SGASPROVVOLU], 0)as float)[9010] 
  , cast(ISNULL(A.SMONREC, 0)as float)  [9011] 
  , cast(ISNULL(A.STASREC, 0)as float)  [9012] 
  , cast(ISNULL(A.[SGASPROVOM3155], 0)as float)[9021] 
  , cast(A.[SRECCAST12M] as float)[9014] --Recuperacion Castigos 12 Meses (miles PEN)
  , cast(A.[SGASPROVCART] as float)[9023] --Gasto Provisiones Cartera (miles PEN)
  , cast(A.[SGASPROVCONTA] as float)[9024] --Gasto Provisiones Contable (miles PEN)
  , cast(A.[SGASPROVBRUTO12M] as float)  [9025] --Gasto Provisiones Bruto 12 Meses (miles PEN)
  , cast(A.[SSTKPROV] as float) [9027] --Stock Provisiones (miles PEN)
 FROM storage.com_act.SBTVRIE001 A  --select top 10 * from storage.com_act.SBTVRIE001 WHERE SFECPRO = '20210508' 
 JOIN #FECS B on a.SFECPRO = B.RFEC 
 WHERE A.STIPCOD = @tip_cod and A.SCODREL = @cod_rel 
 --WHERE A.STIPCOD = 7 and A.SCODREL = '231' 
 )  
 SELECT *
 INTO #ACUM00 --drop table #ACUM00
 FROM #FECS A
 LEFT JOIN cte_a B ON A.RORD=B.fila and A.RFEC=B.descripcion
 UNPIVOT (valores for variables in([9010], [9011], [9012], [9021], [9014], [9023], [9024], [9025], [9027]))UNPVT
  
--DECLARE @fec date = '20230630', @tip_cod int = 7, @cod_rel VARCHAR(10)= '231', @tipmeta int = 1
 SELECT  RORD,variables,valores
 INTO #RESULT02
 FROM #ACUM00
 UNION
 SELECT 7 FORD, B.HCODVAR, B.HVALVAR
 FROM #ACUM00 A
 JOIN [storage].[com].[VDMCOM01] B ON A.variables = B.HCODVAR
 AND B.HTIPMETA = @tipmeta
 AND B.HFECPRO = EOMONTH(@fec11)
 AND B.HTIPCOD = @tip_cod
 AND B.HCODREL = @cod_rel
 UNION
 SELECT 7 FORD, B.HCODVAR, B.HVALVAR
 FROM [storage].[com].[VDMCOM01] B
 WHERE B.HTIPMETA = @tipmeta
 and B.HFECPRO = EOMONTH(@fec11)
 and B.HTIPCOD = @tip_cod
 and B.HCODREL = @cod_rel
 AND B.HCODVAR IN (9018, 9019, 9020, 9028, 9026)

 --drop table #RESULT02
 --SELECT TOP 10 * FROM [storage].[com].[VDMCOM01]
 --SELECT * FROM #RESULT02 WHERE variables = '9014'
  
 
 -------- Mora Real Bruta (miles PEN)
 SELECT A.RORD, SUM(A.[valores])[VAR01_MORARB] INTO #VAR01_MORARB FROM #RESULT00 A WHERE A.variables IN ('9015')GROUP BY A.RORD
 SELECT A.RORD, SUM(A.[valores])[VAR02_MORARB] INTO #VAR02_MORARB FROM #RESULT01 A WHERE A.variables IN ('8160')GROUP BY A.RORD

 --SELECT * FROM #VAR01_MORARB
 --SELECT * FROM #VAR02_MORARB
 
 SELECT A.RORD, '9016' [variables], ISNULL((A.[VAR01_MORARB] + B.[VAR02_MORARB]), 0) [valores] 
 INTO #RESULT03 
 FROM #VAR01_MORARB A 
 FULL JOIN #VAR02_MORARB B ON A.RORD = B.RORD 
 
 
 -------- Gasto Provisiones Gen ricas y Espec ficas (miles PEN)
 SELECT A.RORD, SUM(A.[valores])[VAR01A_PROVCARTEF] INTO #VAR01A_METAPROVGENE FROM #RESULT02 A WHERE A.variables IN ('9023')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01A_PROVCARTEF] INTO #VAR01A_PROVCARTEF FROM #RESULT02 A WHERE A.variables IN ('9024')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01B_PROVCARTEF] INTO #VAR01B_PROVCARTEF FROM #RESULT00 A WHERE A.variables IN ('148')GROUP BY A.RORD 
 --DROP TABLE #VAR01A_PROVCARTEF 
 --UPDATE #VAR01B_PROVCARTEF SET VAR01B_PROVCARTEF = 2 WHERE RORD = 5 
 --SELECT * FROM #VAR01A_METAPROVGENE 
 --SELECT * FROM #VAR01B_PROVCARTEF 
  
 DELETE #RESULT02 WHERE variables IN (9023)
 
 SELECT A.*, 'ES MENSUAL' [Filtro_01] INTO #FILTRO01_FECHA FROM #FECS A
 --SELECT * FROM #FECS
 
 SELECT A.RORD, '9023' [variables], ISNULL(CASE WHEN C.[Filtro_01] = 'ES MENSUAL' THEN A.[VAR01A_PROVCARTEF] ELSE B.[VAR01B_PROVCARTEF] END, 0)[valores] 
 INTO #VAR01A_PROVGENEFIN 
 FROM #VAR01A_PROVCARTEF A 
 LEFT JOIN #VAR01B_PROVCARTEF B ON A.RORD = B.RORD 
 LEFT JOIN #FILTRO01_FECHA C ON A.RORD = C.RORD AND B.RORD = C.RORD 
 
 INSERT INTO #RESULT02 
 SELECT A.RORD, '9023' [variables], CASE WHEN A.RORD IN (7)THEN ISNULL(A.[VAR01A_PROVCARTEF], 0)ELSE ISNULL(B.[valores], 0)END [valores] 
 --SELECT * 
 FROM #VAR01A_METAPROVGENE A 
 LEFT JOIN #VAR01A_PROVGENEFIN B ON A.RORD = B.RORD 
 
 
  
 -------- Gasto Provisiones Bruto (miles PEN)
 SELECT A.RORD, SUM(A.[valores])[VAR01B_PROVB] INTO #VAR01B_PROVB_MENSUAL FROM #RESULT02 A WHERE A.variables IN ('9023')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR02_PROVB] INTO #VAR02_PROVB_MENSUAL FROM #RESULT02 A WHERE A.variables IN ('9021')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR03_PROVB] INTO #VAR03_PROVB_MENSUAL FROM #RESULT02 A WHERE A.variables IN ('9010')GROUP BY A.RORD 
 --DROP TABLE #VAR01B_PROVB_MENSUAL 
 
 SELECT A.RORD, '9018' [variables], ISNULL((A.[VAR01B_PROVB] + B.[VAR02_PROVB] + [VAR03_PROVB]), 0) [valores]
 INTO #RESULT03_C_MENSUAL
 FROM #VAR01B_PROVB_MENSUAL A
 FULL JOIN #VAR02_PROVB_MENSUAL B ON A.RORD = B.RORD
 FULL JOIN #VAR03_PROVB_MENSUAL C ON A.RORD = B.RORD AND C.RORD = B.RORD
 
 SELECT A.RORD, SUM(A.[valores])[VAR01_PROVB] INTO #VAR01N_PROVB FROM #RESULT00 A WHERE A.variables IN ('148')GROUP BY A.RORD
 SELECT A.RORD, SUM(A.[valores])[VAR02_PROVB] INTO #VAR02N_PROVB FROM #RESULT02 A WHERE A.variables IN ('9021')GROUP BY A.RORD
 SELECT A.RORD, SUM(A.[valores])[VAR03_PROVB] INTO #VAR03N_PROVB FROM #RESULT02 A WHERE A.variables IN ('9010')GROUP BY A.RORD
 
 SELECT A.RORD, '9018' [variables], ISNULL((A.[VAR01_PROVB] + B.[VAR02_PROVB] + [VAR03_PROVB]), 0) [valores]
 INTO #RESULT03_C
 FROM #VAR01N_PROVB A
 FULL JOIN #VAR02N_PROVB B ON A.RORD = B.RORD
 FULL JOIN #VAR03N_PROVB C ON A.RORD = B.RORD AND C.RORD = B.RORD
 
 INSERT INTO #RESULT03
 --SELECT A.RORD, '9018' [variables], ISNULL(CASE WHEN A.RORD IN (1, 4, 6)THEN B.valores ELSE A.valores END, 0)[valores]
 SELECT A.RORD, '9018' [variables], ISNULL(CASE WHEN C.[Filtro_01] = 'ES MENSUAL' THEN A.valores ELSE B.valores END, 0)[valores]
 --SELECT *
 FROM #RESULT03_C_MENSUAL A
 LEFT JOIN #RESULT03_C  B ON A.RORD = B.RORD
 LEFT JOIN #FILTRO01_FECHA C ON A.RORD = C.RORD AND B.RORD = C.RORD
 
 
 -------- Gasto Provisiones Neto (miles PEN)
 SELECT A.RORD, '9019' [variables], ISNULL((A.[VAR01B_PROVB] + B.[VAR02_PROVB] + [VAR03_PROVB]), 0) [valores] 
 INTO #RESULT03_D_P1_MENSUAL 
 FROM #VAR01B_PROVB_MENSUAL A 
 FULL JOIN #VAR02_PROVB_MENSUAL B ON A.RORD = B.RORD 
 FULL JOIN #VAR03_PROVB_MENSUAL C ON A.RORD = B.RORD AND C.RORD = B.RORD 
 
 SELECT A.RORD, A.[variables], (A.valores - B.valores)[valores] 
 INTO #RESULT03_D_MENSUAL 
 FROM #RESULT03_D_P1_MENSUAL A 
 LEFT JOIN #RESULT00 B ON A.RORD = B.RORD 
 WHERE A.variables = '9019' AND B.variables = '117' 
 
 SELECT A.RORD, '9019' [variables], ISNULL((A.[VAR01_PROVB] + B.[VAR02_PROVB] + [VAR03_PROVB]), 0) [valores] 
 INTO #RESULT03_D_P1  
 FROM #VAR01N_PROVB A 
 FULL JOIN #VAR02N_PROVB B ON A.RORD = B.RORD 
 FULL JOIN #VAR03N_PROVB C ON A.RORD = B.RORD AND C.RORD = B.RORD
 
 
 SELECT A.RORD, '9019' [variables], ISNULL(A.valores, 0) [valores] 
 INTO #RESULT03_D_P1_FIN
 FROM #RESULT03 A
 WHERE A.variables = '9018'
 DELETE #RESULT03_D_P1_FIN WHERE RORD = 7

 --SELECT * FROM #RESULT03_D_P1
 --SELECT * FROM #RESULT03_D_P1_FIN

 
 SELECT A.RORD, A.[variables], (A.valores - B.valores)[valores] 
 INTO #RESULT03_D 
 FROM #RESULT03_D_P1 A 
 LEFT JOIN #RESULT00 B ON A.RORD = B.RORD 
 WHERE A.variables = '9019' AND B.variables = '117'

 SELECT A.RORD, A.[variables], (A.valores - B.valores)[valores] 
 INTO #RESULT03_D_FIN
 FROM #RESULT03_D_P1_FIN A 
 LEFT JOIN #RESULT00 B ON A.RORD = B.RORD 
 WHERE A.variables = '9019' AND B.variables = '117'

 --SELECT * FROM #RESULT03_D
 --SELECT * FROM #RESULT03_D_FIN
 
 INSERT INTO #RESULT03 
 SELECT A.RORD, A.variables, isnull ( ISNULL(CASE WHEN A.valores < 0 THEN B.valores ELSE A.valores END, 0),0) [valores] 
 --SELECT * 
 FROM #RESULT03_D_MENSUAL A 
 LEFT JOIN #RESULT03_D_FIN B ON A.RORD = B.RORD AND A.variables = B.variables
 
 
 -------- Recuperacion Castigos 12 Meses (miles PEN)
 SELECT A.RORD, SUM(A.[valores])[VAR01A_PROVCARTEF] INTO #VAR01A_RECUCASTI12M FROM #RESULT00 A WHERE A.variables IN ('117')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01B_PROVCARTEF] INTO #VAR01B_RECUCASTI12M FROM #RESULT02 A WHERE A.variables IN ('9014')GROUP BY A.RORD 
 --DROP TABLE #VAR01A_RECUCASTI12M 
 
 DELETE #RESULT02 WHERE variables IN (9014)
 
 INSERT INTO #RESULT02 
 SELECT A.RORD, '9014' [variables] 
  , CASE WHEN A.RORD IN (7)THEN B.[VAR01B_PROVCARTEF] 
  ELSE ISNULL(A.[VAR01A_PROVCARTEF], 0)+ ISNULL(B.[VAR01B_PROVCARTEF], 0)END [valores] 
  --SELECT * 
 FROM #VAR01A_RECUCASTI12M A 
 LEFT JOIN #VAR01B_RECUCASTI12M B ON A.RORD = B.RORD 
 where A.RORD IN (7) --se cabia la logica por la sdas005
 --select * from #RESULT02 where [variables] = 9014

  --DECLARE @fec date = '20240120', @tip_cod int = 7, @cod_rel VARCHAR(10)= '231', @tipmeta int = 1
	create table #VENTCART (RORD int  NOT NULL,VENTA12M numeric(17,2)null)
	create table #VENTCART_MES (RORD int  NOT NULL,VENTAMN numeric(17,2)null) 

declare @i int,@f int,@fec1 date, @fec2  date
select @i=1,@f=max(RORD) from #FECS    

             --select * from #FECS

			 --select * from storage.com_act.wjas002 where HTIPCOD = 7 order by 1
while(@i<=@f)            
 begin   
    
	select @fec1=RFEC from #FECS where RORD=@i 
	select  A.RFEC    
	 into #FECS12
		from storage.util.FVECFEC01(@fec1,'hoy,cie_ant,cie_ant+2,cie_ant+3,cie_ant+4,cie_ant+5,cie_ant+6,cie_ant+7,cie_ant+8,cie_ant+9,cie_ant+10,cie_ant+11') A 

	 insert into #VENTCART  --select * from #VENTCART
	 select @i, HVENTA_CARTMN12M from storage.com_act.wjas002 where hfecpro =@fec1 and htipcod =@tip_cod and hcodrel =@cod_rel

	 insert into #VENTCART_MES  --select * from #VENTCART_MES
	 select @i, HVENTA_CARTMN  from storage.com_act.wjas002 where hfecpro =@fec1 and htipcod =@tip_cod and hcodrel =@cod_rel

	 if(@tip_cod =7)
	 begin
	 insert into #RESULT02
	 select @i,'9014', sum(SSRECUMN) from storage.[com_act].[SDAS005] where SFECPRO in (select * from #FECS12) and SCODAGR in ('1')
	 end
	 drop table  #FECS12   
 set @i=@i+1   
end    
  --drop table #VENTCART,#VENTCART_MES




 -------- Gasto Provisiones Bruto 12 Meses (miles PEN)
 SELECT A.RORD, SUM(A.[valores])[VAR01A_GTOPROVI12M] INTO #VAR01A_GTOPROVI12M FROM #RESULT02 A WHERE A.variables IN ('9025')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01B_GTOPROVI12M] INTO #VAR01B_GTOPROVI12M FROM #RESULT03 A WHERE A.variables IN ('9018')GROUP BY A.RORD 


 --DROP TABLE #VAR01B_GTOPROVI12M 
 
 DELETE #RESULT02 WHERE variables IN (9025)
 
 INSERT INTO #RESULT02 
 SELECT A.RORD, '9025' [variables]--, ISNULL(A.[VAR01A_GTOPROVI12M], 0)+ ISNULL(B.[VAR01B_GTOPROVI12M], 0)[valores] 
  , CASE WHEN A.RORD IN (7)THEN ISNULL(A.[VAR01A_GTOPROVI12M], 0) + isnull(C.VENTA12M,0)
 ELSE ISNULL(A.[VAR01A_GTOPROVI12M], 0)+ ISNULL(B.[VAR01B_GTOPROVI12M], 0)+ isnull(C.VENTA12M,0) END [valores] 
 --SELECT * from #VAR01A_GTOPROVI12M
 FROM #VAR01A_GTOPROVI12M A 
 LEFT JOIN #VAR01B_GTOPROVI12M B ON A.RORD = B.RORD 
 LEFT JOIN #VENTCART C ON A.RORD = C.RORD 

  --SELECT A.RORD, SUM(A.[valores])+sum(isnull(C.VENTA12M,0))[VALOR_NOM1]  FROM #RESULT02 A
 -- LEFT JOIN #VENTCART B ON A.RORD = B.RORD 
 -- WHERE A.variables IN ('9025') GROUP BY A.RORD --provBruto12M


 --select * from #VAR01A_RECUCASTI12M where rord = 6
 --select * from #VAR01B_RECUCASTI12M where rord = 6
 --select * from #RESULT02 WHERE variables IN (9014) and rord = 6







 -------- Mora Real Neta (miles PEN)
 SELECT A.RORD, SUM(A.[valores])[VAR01A] INTO #VAR01A_MORAREALNETA FROM #RESULT01 A WHERE A.variables IN ('10000')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01B] INTO #VAR01B_MORAREALNETA FROM #RESULT03 A WHERE A.variables IN ('9016')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01C] INTO #VAR01C_MORAREALNETA FROM #RESULT02 A WHERE A.variables IN ('9014')GROUP BY A.RORD 
 --DROP TABLE #VAR01C_MORAREALNETA 
 
 DELETE #RESULT01 WHERE variables IN (10000)
  
 INSERT INTO #RESULT01 
 SELECT A.RORD, '10000' [variables] 
  , CASE WHEN A.RORD IN (7)THEN A.[VAR01A] 
 ELSE ISNULL(B.[VAR01B], 0)- ISNULL(C.[VAR01C], 0)END [valores] 
 FROM #VAR01A_MORAREALNETA A 
 LEFT JOIN #VAR01B_MORAREALNETA B ON A.RORD = B.RORD 
 LEFT JOIN #VAR01C_MORAREALNETA C ON A.RORD = C.RORD 
 --SELECT * FROM #RESULT01 WHERE [variables] IN (10000)
  
 
 -------- Ratio Mora Real (%)

 SELECT A.RORD, SUM(A.[valores])[NUMER01] INTO #NUMER01 FROM #RESULT00 A WHERE A.variables IN ('9015')GROUP BY A.RORD --VENCIDOS
 SELECT A.RORD, SUM(A.[valores])[NUMER02] INTO #NUMER02 FROM #RESULT01 A WHERE A.variables IN ('8160')GROUP BY A.RORD --CAST12M
 SELECT A.RORD, SUM(A.[valores])[NUMER03] INTO #NUMER03 FROM #RESULT02 A WHERE A.variables IN ('9014')GROUP BY A.RORD --rec CAST 12M
 SELECT A.RORD, SUM(A.[valores])[DENOM01] INTO #DENOM01 FROM #RESULT00 A WHERE A.variables IN ('100')GROUP BY A.RORD --CARTERA
 SELECT A.RORD, SUM(A.[valores])[DENOM02] INTO #DENOM02 FROM #RESULT01 A WHERE A.variables IN ('8160')GROUP BY A.RORD --CAST12M 
 SELECT A.RORD, SUM(A.[valores])[DENOM03] INTO #DENOM03 FROM #RESULT02 A WHERE A.variables IN ('9014')GROUP BY A.RORD --rec CAST 12M
 SELECT * INTO #META_RAT_MOR_REAL FROM #RESULT01 WHERE variables IN (10020)AND RORD IN (7)
 --DROP TABLE #NUMER01, #NUMER02, #NUMER03, #DENOM01, #DENOM02, #DENOM03 
 
 DELETE #RESULT01 WHERE variables IN (10020)
 --SELECT * FROM #RESULT01 WHERE variables IN (10020)
   
 --SELECT A.RORD, '10020' [variables], A.[NUMER01], B.[NUMER02], D.VENTA12M, C.[NUMER03]
 --FROM #NUMER01 A 
 --LEFT JOIN #NUMER02 B ON A.RORD = B.RORD 
 --LEFT JOIN #NUMER03 C ON A.RORD = C.RORD 
 --LEFT JOIN #VENTCART D ON A.RORD = D.RORD

 --select * from #VENTCART
 --select * from #NUMERADOR_RAT_MOR_REAL
	
 SELECT A.RORD, '10020' [variables], ISNULL(A.[NUMER01], 0)+ ISNULL(B.[NUMER02], 0) + ISNULL(D.VENTA12M,0)- ISNULL(C.[NUMER03], 0)[valores] 
 INTO #NUMERADOR_RAT_MOR_REAL 
 FROM #NUMER01 A 
 LEFT JOIN #NUMER02 B ON A.RORD = B.RORD 
 LEFT JOIN #NUMER03 C ON A.RORD = C.RORD 
 LEFT JOIN #VENTCART D ON A.RORD = D.RORD
 
 SELECT A.RORD, '10020' [variables], ISNULL(A.[DENOM01], 0)+ ISNULL(B.[DENOM02], 0) + ISNULL(D.VENTA12M,0) - ISNULL(C.[DENOM03], 0)[valores] 
 INTO #DENOMINADOR_RAT_MOR_REAL 
 FROM #DENOM01 A 
 LEFT JOIN #DENOM02 B ON A.RORD = B.RORD 
 LEFT JOIN #DENOM03 C ON A.RORD = C.RORD 
 LEFT JOIN #VENTCART D ON A.RORD = D.RORD


 INSERT INTO #RESULT01 
 SELECT A.RORD, A.[variables], CASE WHEN A.RORD IN (7)THEN C.[valores] 
 ELSE ISNULL(A.[valores] / B.[valores], 0)END [valores] 
 FROM #NUMERADOR_RAT_MOR_REAL A 
 LEFT JOIN #DENOMINADOR_RAT_MOR_REAL B ON A.RORD = B.RORD 
 LEFT JOIN #META_RAT_MOR_REAL C ON B.RORD = C.RORD 
 



-------- venta de cartera
 --venta de cartera mes   -- select * from #RESULT04
 SELECT A.RORD, '10031' [variables], ISNULL(D.VENTAMN, 0)[valores] into   #RESULT04 
 FROM #DENOM01 A  
 LEFT JOIN #VENTCART_MES D ON A.RORD = D.RORD
 UNION
 --venta de cartera 12 meses   -- select * from #VENTCART 
 SELECT A.RORD, '10032' [variables], ISNULL(D.VENTA12M , 0)[valores] 
 FROM #DENOM01 A  
 LEFT JOIN #VENTCART D ON A.RORD = D.RORD
 --drop table  #RESULT04 
 UNION
 SELECT 7 FORD, B.HCODVAR, B.HVALVAR
 FROM [storage].[com].[VDMCOM01] B
 WHERE B.HTIPMETA = @tipmeta
 and B.HFECPRO = EOMONTH(@fec11)
 and B.HTIPCOD = @tip_cod
 and B.HCODREL = @cod_rel
 AND B.HCODVAR IN (10031,10032)
  


 --select * from #RESULT02 A WHERE A.variables IN ('9025') 
  
 -------- Prima Riesgo Neto (%)
 SELECT A.RORD, SUM(A.[valores])[VALOR_NOM1] INTO #VALOR_PRIRMGO_NOM1 FROM #RESULT02 A WHERE A.variables IN ('9025')GROUP BY A.RORD --provBruto12M
 SELECT A.RORD, SUM(A.[valores])*-1 [VALOR_NOM2] INTO #VALOR_PRIRMGO_NOM2 FROM #RESULT02 A WHERE A.variables IN ('9014')GROUP BY A.RORD --recupCast
 SELECT A.RORD, SUM(A.[valores])[VALOR_DENOM1] INTO #VALOR_PRIRMGO_DENOM1 FROM #RESULT01 A WHERE A.variables IN ('9013')GROUP BY A.RORD --promCart12M
 SELECT * INTO #VALOR_PRIRMGO_META FROM #RESULT02 A WHERE A.variables IN ('9020')
  --select * from #VALOR_PRIRMGO_META
 --promCart12M 2240656515.8025
 

   --select * from #ACUM01 where variables = 9013



 INSERT INTO #RESULT03 
 SELECT A.RORD, '9020' [variables]--, ISNULL((A.[VALOR_NOM1] + B.[VALOR_NOM2])/ [VALOR_DENOM1], 0) [valores] 
  , isnull( CASE WHEN A.RORD IN (7)THEN D.valores ELSE ISNULL((A.[VALOR_NOM1] + B.[VALOR_NOM2])/ [VALOR_DENOM1], 0)END ,0) [valores] 
 --SELECT * 
 FROM #VALOR_PRIRMGO_NOM1 A 
 FULL JOIN #VALOR_PRIRMGO_NOM2 B ON A.RORD = B.RORD 
 FULL JOIN #VALOR_PRIRMGO_DENOM1 C ON A.RORD = B.RORD AND C.RORD = B.RORD 
 FULL JOIN #VALOR_PRIRMGO_META D ON A.RORD = D.RORD AND C.RORD = D.RORD AND B.RORD = D.RORD 
 --DROP TABLE #VALOR_PRIRMGO_DENOM1 
 --select * from #RESULT03 where variables = 9020
 
 -------- Cobertura CAR (%)
 SELECT A.RORD, SUM(A.[valores])[VAR01A] INTO #VAR01A_COBERCAR FROM #RESULT02 A WHERE A.variables IN ('9027')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01B] INTO #VAR01B_COBERCAR FROM #RESULT00 A WHERE A.variables IN ('9015')GROUP BY A.RORD 
 SELECT A.RORD, SUM(A.[valores])[VAR01C] INTO #VAR01C_COBERCAR FROM #RESULT00 A WHERE A.variables IN ('119')GROUP BY A.RORD 
  
 INSERT INTO #RESULT03 
 SELECT A.RORD, '9026' [variables], A.[VAR01A] / ISNULL(B.[VAR01B] + C.[VAR01C], 1)[valores] 
 --SELECT * 
 FROM #VAR01A_COBERCAR A 
 LEFT JOIN #VAR01B_COBERCAR B ON B.RORD = A.RORD 
 LEFT JOIN #VAR01C_COBERCAR C ON C.RORD = A.RORD 
  
 
 -------- Cobertura Cartera Atrasada (%)
 SELECT A.RORD, SUM(A.[valores])[VAR01A] INTO #VAR01A_COBERCATRAS FROM #RESULT02 A WHERE A.variables IN ('9027')GROUP BY A.RORD
 SELECT A.RORD, SUM(A.[valores])[VAR01B] INTO #VAR01B_COBERCATRAS FROM #RESULT00 A WHERE A.variables IN ('9015')GROUP BY A.RORD

 INSERT INTO #RESULT03
 SELECT A.RORD, '9028' [variables], A.[VAR01A] / ISNULL(B.[VAR01B], 1)[valores]
 --SELECT *
 FROM #VAR01A_COBERCATRAS A
 LEFT JOIN #VAR01B_COBERCATRAS B ON B.RORD = A.RORD
 --SELECT * FROM #RESULT03 WHERE [variables] IN (9026)
 
 
  
/*UNIFICACION  DE RESULTADOS*/
SELECT A.*
INTO #VAR_9018
FROM (
SELECT * FROM #RESULT01 WHERE variables IN ('9018') UNION ALL
SELECT * FROM #RESULT02 WHERE variables IN ('9018') UNION ALL
SELECT * FROM #RESULT03 WHERE variables IN ('9018')
) A
ORDER BY A.RORD
--SELECT * FROM #VAR_9018 ORDER BY RORD
DELETE #VAR_9018 WHERE RORD = 7 AND valores = 0

DELETE FROM #RESULT01 WHERE variables IN ('9018')
DELETE FROM #RESULT02 WHERE variables IN ('9018')
DELETE FROM #RESULT03 WHERE variables IN ('9018')

INSERT INTO #RESULT03 SELECT * FROM #VAR_9018

 SELECT *
 INTO #RESULTPRE
 FROM #RESULT00
 UNION ALL SELECT * FROM #RESULT01
 UNION ALL SELECT * FROM #RESULT02
 UNION ALL SELECT * FROM #RESULT03
 UNION ALL SELECT * FROM #RESULT04

 --SELECT * FROM #RESULT01 WHERE variables IN ('9021')
 --SELECT * FROM #RESULT02 WHERE variables IN ('9021')
 --SELECT * FROM #RESULT03 WHERE variables IN ('9021')


/*Comparativos, formatos y presentacion*/
 select RORD, variables, util.FFMTVAR(variables,valores,null)SVALOR
 --INTO #AAA
 INTO #PARTE01
 from #RESULTPRE  --SELECT * FROM #RESULTPRE WHERE VARIABLES=9030
  --UNION ALL
 select  case when concat(A.RORD,'-',B.RORD)= '6-4' then 9
when concat(A.RORD,'-',B.RORD)= '6-1' then 11
when concat(A.RORD,'-',B.RORD)= '6-7' then 13 end RORD
  ,A.variables
  , util.FFMTVAR(A.variables,(ISNULL(A.valores, 0)-ISNULL(B.valores, 0)),iif(A.variables in(10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028),1,null))SVALOR
  --,(A.valores)[Valor1],(-B.valores)[Valor2],(A.valores-B.valores)[DIF]
 INTO #PARTE02_NUMEROS
	from #RESULTPRE A
  join #RESULTPRE B
  on A.variables=B.variables
 where concat(A.RORD,'-',B.RORD)in('6-4','6-1','6-7')
  --UNION ALL
 SELECT  case when concat(A.RORD,'-',B.RORD)='6-4' then 8
when concat(A.RORD,'-',B.RORD)='6-1' then 10
when concat(A.RORD,'-',B.RORD)='6-7' then 12 end RORD
	, A.variables
	--, cast(util.FSEMVAR(A.variables,iif(A.variables in(10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028),1,0),iif(A.variables in(10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028),(ISNULL(A.valores, 0)-ISNULL(B.valores, 0))*10000, (A.valores-B.valores)))as varchar)SVALOR
	, cast(util.FSEMVAR(A.variables, iif(A.variables in(10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028), 1, 0), iif(A.variables in (10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028), (ISNULL(A.valores, 0)-ISNULL(B.valores, 0))*10000, CASE WHEN ISNULL(B.valores, 0) = 0 THEN A.valores/1 ELSE ISNULL(A.valores, 0)/ISNULL(B.valores, 0)-1 END ))as varchar) SVALOR
	--, iif(A.variables in(10020, 10030, 10040, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132,1125,1126, 9012, 9017, 9020, 9026, 9028),(A.valores-B.valores)*10000, (A.valores-B.valores))
	--, (ISNULL(A.valores, 0)-ISNULL(B.valores, 0))*10000--RATIOS
	--, CASE WHEN ISNULL(B.valores, 0) = 0 THEN A.valores/1 ELSE ISNULL(A.valores, 0)/ISNULL(B.valores, 0)-1 END--NUMEROS
 INTO #PARTE03_RATIOS
	FROM #RESULTPRE A
 JOIN #RESULTPRE B ON A.variables=B.variables
 WHERE concat(A.RORD,'-',B.RORD)in('6-4','6-1','6-7')
 --AND A.variables IN ('9012')

UPDATE #PARTE03_RATIOS SET SVALOR = NULL WHERE variables IN ('9021') AND RORD IN (8, 10, 12)
UPDATE #PARTE03_RATIOS SET SVALOR = NULL WHERE variables IN ('9010') AND RORD IN (8, 10, 12)

SELECT *
INTO #AAA
FROM #PARTE01  --SELECT * FROM #PARTE01 WHERE VARIABLES=9030
UNION ALL SELECT * FROM #PARTE02_NUMEROS
UNION ALL SELECT * FROM #PARTE03_RATIOS

 

--SELECT * FROM #PARTE01 WHERE variables IN ('9021') ORDER BY RORD
--SELECT * FROM #PARTE02_NUMEROS WHERE variables IN ('9021') ORDER BY RORD
--SELECT * FROM #PARTE03_RATIOS WHERE variables IN ('9021') ORDER BY RORD
--SELECT * FROM #AAA WHERE variables IN ('9021') AND RORD IN (8, 10, 12) ORDER BY RORD

 SELECT * 
INTO #RES 
FROM #AAA pivot (max(SVALOR)for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13]))PVT

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
('Ratio de Mora Real (%)',10020),
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
('Recuperacion Castigos (miles PEN)',117),
('Recuperacion Castigos 12 Meses (miles PEN)',9014),
('Pago Puntual -30 a 0', 9030),
('Efectividad -30-0d (%)',126),
('Efectividad 1-30d (%)',122),
('Efectividad 31-60d (%)',124),
('Efectividad 61-90d (%)',127),
('Efectividad 91-120d (%)',128),
('Efectividad 121-150d (%)',129),
('Efectividad 151-180d (%)',130),
('Efectividad 181d a mas (%)',131),
('Efectividad Judicial (%)',132)
 
--SELECT * FROM #RES WHERE variables = 126 AND LEFT([13], 1)= '-' 
--UPDATE #RES SET [12] = -1 WHERE variables = 126 AND LEFT([13], 1)= '-' 
 
SELECT A.RDESVAR, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13] 
FROM #CMG A 
LEFT JOIN #RES B ON A.RCODVAR = B.variables--SELECT * FROM #RES
 
 
drop table #FECS
drop table #AAA
drop table #CMG
drop table #RES
drop table #PROD00
drop table #RESULT00
drop table #RESULTPRE
 
------ TABLAS LOCALES
--DROP TABLE #RESULTPIV, #tabla, #RESULT01, #RESULT02, #ACUM01, #ACUM00, #RESULT03, #RESULT03_D_P1, #RESULT03_D, #RESULT03_D_P1_MENSUAL, #RESULT03_D_MENSUAL
--DROP TABLE #VAR01A_MORAREALNETA, #VAR01B_MORAREALNETA, #VAR01C_MORAREALNETA, #VALOR_PRIRMGO_NOM1, #VALOR_PRIRMGO_NOM2, #VALOR_PRIRMGO_DENOM1, #FILTRO01_FECHA
--DROP TABLE #VAR01_MORARB, #VAR02_MORARB, #VAR01A_PROVCARTEF, #VAR01B_PROVCARTEF, #VAR01A_RECUCASTI12M, #VAR01B_RECUCASTI12M, #WJAS002, #VALOR_PRIRMGO_META
--DROP TABLE #VAR01B_PROVB_MENSUAL, #VAR02_PROVB_MENSUAL, #VAR03_PROVB_MENSUAL, #RESULT03_C, #RESULT03_C_MENSUAL, #VAR01A_GTOPROVI12M, #VAR01B_GTOPROVI12M
--DROP TABLE #VAR01N_PROVB, #VAR02N_PROVB, #VAR03N_PROVB, #VAR01A_COBERCAR, #VAR01B_COBERCAR, #VAR01C_COBERCAR, #VAR01A_COBERCATRAS, #VAR01B_COBERCATRAS
--DROP TABLE #NUMER01, #NUMER02, #NUMER03, #DENOM01, #DENOM02, #DENOM03, #META_RAT_MOR_REAL, #NUMERADOR_RAT_MOR_REAL, #DENOMINADOR_RAT_MOR_REAL
--DROP TABLE #VAR01A_METAPROVGENE, #VAR01A_PROVGENEFIN, #RESULT03_D_P1_FIN, #RESULT03_D_FIN, #VAR_9018, #PARTE01, #PARTE02_NUMEROS, #PARTE03_RATIOS

 

END
