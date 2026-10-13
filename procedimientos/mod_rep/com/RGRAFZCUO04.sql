-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 17:23:25.303000
--exec  com.RGRAFZCUO04 7,'231','20260910'

 
CREATE procedure [com].[RGRAFZCUO04]
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE
as
begin
SET NOCOUNT ON;
--declare @tip_cod varchar(5)=7, @cod_rel varchar(25)='231', @Fecha DATE ='20260817'  
	--select *  from storage.com_act.Rpte_PEDC029_cerocuotas 
 
 IF OBJECT_ID('tempdb..#graf3') IS NOT NULL DROP TABLE #graf3
 select  anio_des,CAST( 0 AS VARCHAR(10)) HTIPCOD,CAST(0 AS VARCHAR(50)) HCODREL 
 , ISNULL(  cast( SUM(case when HINDCAR = 'VIGENTE'   then HSALCAPMN  end) /1000 as numeric(17,2)) ,0) HIND_VIG
 , ISNULL(  cast( SUM(case when HINDCAR = 'VENCIDO'  then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) HIND_VEN 
 , ISNULL(  cast( SUM(case when HINDCAR = 'REFINANCIADO'  then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) HIND_REF 
 , ISNULL(  cast( SUM(case when HINDCAR = 'JUDICIAL' then HSALCAPMN  end)/1000 as numeric(17,2)) ,0) HIND_JUD  
 into #graf3
 from   storage.com_act.WZCUO001 
 where HFECPRO = @Fecha and CASE 
            WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
            WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
            WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
            WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
          END = @cod_rel  and anio_des >= 2023 
 group by anio_des
  
-- Declaramos variables para construir los arreglos del JSON
DECLARE @categories NVARCHAR(MAX);
DECLARE @HIND_VIG NVARCHAR(MAX);
DECLARE @HIND_VEN NVARCHAR(MAX);
DECLARE @HIND_REF NVARCHAR(MAX);
DECLARE @HIND_JUD NVARCHAR(MAX); 

-- 1. Agrupamos las fechas (anio_des) formateadas
-- Usamos FORMAT para que en el eje X se vea "30 ago 2025" directamente
SELECT @categories = '[' + STRING_AGG('"' + CAST(anio_des as varchar(4)) + '"', ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;

-- 2. Agrupamos los valores por tramos
SELECT @HIND_VIG = '[' + STRING_AGG(CAST(HIND_VIG AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3; 
SELECT @HIND_VEN = '[' + STRING_AGG(CAST(HIND_VEN AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @HIND_REF = '[' + STRING_AGG(CAST(HIND_REF AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3;
SELECT @HIND_JUD = '[' + STRING_AGG(CAST(HIND_JUD AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY anio_des) + ']'
FROM #graf3; 
-- 4. Construimos el JSON final combinando las partes
SELECT 
    JSON_QUERY(@categories) AS categories,
    JSON_QUERY('[
        {
            "name": "1. VIGENTE",
            "data": ' + @HIND_VIG + '
        },
        {
            "name": "2. VENCIDO",
            "data": ' + @HIND_VEN + '
        },
        {
            "name": "3. REFINANCIADO",
            "data": ' + @HIND_REF + '
        },
        {
            "name": "4. JUDICIAL",
            "data": ' + @HIND_JUD + '
        }
    ]') AS series
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;

drop table #graf3
end
