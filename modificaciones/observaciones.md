El código del reporte Cuenta de Resultados es TAB_CUE_RES_01. Lo ejecuta mod_rep.rep.RTABCUERES01 y recibe los parámetros fecha, tip_cod y cod_rel, según el catálogo de reportes.

 se rqueire modificar el sp donde se quiere nereer lo siguienete  tabla D:\FINANCIERA CONFIANZA\04 SISTEMAS\01 MIS\03 DICCIONARIO\GITHUB\modificaciones\image.png 

 con los filtro adciones 

 Buenos dias Diego

te envio la info que revisamos para el reporte de PyG 


-- Tabla de datos
SELECT * FROM dbo.WREPPYG001

-- Equivalencia entre codigo y descripcion de campos
SELECT * FROM dbo.REVARPYG

-- Valores del WCODREL
-- 1: FC
-- 3: Asesor
-- 4: Producto
-- 5: Asesor y Producto


-- Columnas y formulas
WVALACT           Mes Actual
WVALANT           Mes Anterior
WVALAA              Mismo Mes Año Anterior
WACUMACT        Acumulado mes actual
WACUMAA           Acumulado mismo mes año anterior

Formulas
Jun26 vs May26              WVALACT - WVALANT
Jun26 vs Jun25               WVALACT - WVALAA
Jun26 vs Jun25 %           ((WVALACT - WVALAA) / WVALAA) * 100


-- PRODUCTOS
-- En MIS
select ISNULL(_P3.RDESPROD, 'SIN ASIGNAR')
from #REPPYG  _TS_1
left join storage.[com_act].RETP002 _P2 on _TS_1.WCODMOD=_P2.RCODMOD
and _TS_1.WTIPOPE=_P2.RTIPOPE
and _TS_1.WSUBTIP=_P2.RSUBTIP
left join storage.[com_act].RETP001 _P1 on _TS_1.WCODMOD=_P1.RCODMOD
and _TS_1.WTIPOPE=_P1.RTIPOPE
left join storage.[com_act].RETP003 _P3 on isnull(_P2.RCODPROD,_P1.RCODPROD)=_P3.RCODPROD


-- En dwh
select distinct ISNULL(t3.RDESPROD, 'SIN ASIGNAR')
from #REPPYG  _TS_1
LEFT JOIN [dwh].[dbo].[RTIPCRE001] AS t1 ON  _TS_1.WCODMOD = t1.RCODMOD
AND _TS_1.WTIPOPE = t1.RTIPOPE
LEFT JOIN [dwh].[dbo].[RTIPCRE002] AS t2 ON  _TS_1.WCODMOD = t2.RCODMOD
AND _TS_1.WTIPOPE = t2.RTIPOPE
AND _TS_1.WSUBTIP = t2.RSUBTIP
LEFT JOIN [dwh].[dbo].[RTIPCRE003] AS t3 ON t3.RCODPROD = CASE WHEN t2.RCODPROD IS NULL
THEN t1.RCODPROD
ELSE t2.RCODPROD END

dame el nuevo sp adicionando los rpertes los filtros correspodninetes 