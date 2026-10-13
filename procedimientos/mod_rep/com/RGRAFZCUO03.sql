-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 17:23:11.850000
--exec  com.RGRAFZCUO03 7,'231','20260817'
CREATE procedure [com].[RGRAFZCUO03]
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE
as
begin
SET NOCOUNT ON;
--declare @tip_cod varchar(5)=7, @cod_rel varchar(25)='231', @Fecha DATE ='20260817'  
	--select *  from storage.com_act.Rpte_PEDC029_cerocuotas 
 
 IF OBJECT_ID('tempdb..#graf3') IS NOT NULL DROP TABLE #graf3
 select  anio_des,CAST( 0 AS VARCHAR(10)) HTIPCOD,CAST(0 AS VARCHAR(50)) HCODREL 
 , ISNULL(  cast( SUM(case when TRAMO = '2. 1-30'   then HSALCAPMN  end) /1000 as numeric(17,2)) ,0) T2_1_30
 , ISNULL(  cast( SUM(case when TRAMO = '3. 31-60'  then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) T3_31_60 
 , ISNULL(  cast( SUM(case when TRAMO = '4. 61-90'  then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) T4_61_90 
 , ISNULL(  cast( SUM(case when TRAMO = '5. 91-120' then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) T5_91_120 
 , ISNULL(  cast( SUM(case when TRAMO = '6. 121-150'then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) T6_121_150 
 , ISNULL(  cast( SUM(case when TRAMO = '7. 151-180'then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) T7_151_180 
 , ISNULL(  cast( SUM(case when TRAMO = '8. >180'   then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) T8_M180
 , ISNULL(  cast( SUM(case when TRAMO = '9. Judicial' then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) T9_JUD
 into #graf3
 from   storage.com_act.WZCUO001 
 where HFECPRO = @Fecha and CASE 
            WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
            WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
            WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
            WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
          END = @cod_rel and anio_des >= 2023
 group by anio_des
  
-- Declaramos variables para construir los arreglos del JSON
DECLARE @categories NVARCHAR(MAX);
DECLARE @T2_1_30 NVARCHAR(MAX);
DECLARE @T3_31_60 NVARCHAR(MAX);
DECLARE @T4_61_90 NVARCHAR(MAX);
DECLARE @T5_91_120 NVARCHAR(MAX);
DECLARE @T6_121_150 NVARCHAR(MAX);
DECLARE @T7_151_180 NVARCHAR(MAX);
DECLARE @T8_M180 NVARCHAR(MAX);
DECLARE @T9_JUD NVARCHAR(MAX);

-- 1. Agrupamos las fechas (anio_des) formateadas
-- Usamos FORMAT para que en el eje X se vea "30 ago 2025" directamente
SELECT @categories = '[' + STRING_AGG('"' + CAST(anio_des as varchar(4)) + '"', ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;

-- 2. Agrupamos los valores por tramos
SELECT @T2_1_30 = '[' + STRING_AGG(CAST(T2_1_30 AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3; 
SELECT @T3_31_60 = '[' + STRING_AGG(CAST(T3_31_60 AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @T4_61_90 = '[' + STRING_AGG(CAST(T4_61_90 AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @T5_91_120 = '[' + STRING_AGG(CAST(T5_91_120 AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @T6_121_150 = '[' + STRING_AGG(CAST(T6_121_150 AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @T7_151_180 = '[' + STRING_AGG(CAST(T7_151_180 AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @T8_M180 = '[' + STRING_AGG(CAST(T8_M180 AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @T9_JUD = '[' + STRING_AGG(CAST(T9_JUD AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;  
-- 4. Construimos el JSON final combinando las partes
SELECT 
    JSON_QUERY(@categories) AS categories,
    JSON_QUERY('[
        {
            "name": "2. 1-30",
            "data": ' + @T2_1_30 + '
        },
        {
            "name": "3. 31-60",
            "data": ' + @T3_31_60 + '
        },
        {
            "name": "4. 61-90",
            "data": ' + @T4_61_90 + '
        },
        {
            "name": "5. 91-120",
            "data": ' + @T5_91_120 + '
        },
        {
            "name": "6. 121-150",
            "data": ' + @T6_121_150 + '
        },
        {
            "name": "7. 151-180",
            "data": ' + @T7_151_180 + '
        },
        {
            "name": "8. Mas 180",
            "data": ' + @T8_M180 + '
        },
        {
            "name": "9. Judicial",
            "data": ' + @T9_JUD + '
        }
    ]') AS series
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;

drop table #graf3
end
