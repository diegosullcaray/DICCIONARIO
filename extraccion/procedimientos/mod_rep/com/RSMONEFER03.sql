-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-10-13 02:51:42.217000

--exec [com].[RSMONEFER03] 7,'231','2025-10-11',1
CREATE PROCEDURE [com].[RSMONEFER03]
--monitor efectividades reasignado
@tip_cod int, @cod_rel varchar(10), @fec  varchar(10), @imp smallint = 1     
AS        
BEGIN  
  SET NOCOUNT ON;     

--declare @tip_cod int = 7, @cod_rel varchar(10) ='231', @fec  varchar(8)='20251011', @imp smallint = 2   
--declare @tip_cod int = 17, @cod_rel varchar(10) ='1013', @fec  varchar(8)='20251011', @imp smallint = 1    
 
 
 
--CABECERA
--declare  @fec  varchar(8)='20251011'
 IF OBJECT_ID('tempdb..#tabla') IS NOT NULL DROP TABLE #tabla 
 SELECT * INTO #tabla 
 FROM [storage].[com].[FCMGCAB](@fec,1)A 
 pivot(MAX(VAL)
 for FORD in
 ([DESVAL],[4],[5],[6]))B 
  
 Declare  @obtenerNivel2_1anioactual varchar(50), @obtenerNivel2_2anioactual varchar(50),@obtenerNivel2_3anioactual varchar(50)
 
 set @obtenerNivel2_1anioactual=(select [4]  from #tabla where fila=0)
 set @obtenerNivel2_2anioactual=(select [5]  from #tabla where fila=0)
 set @obtenerNivel2_3anioactual=(select [6]  from #tabla where fila=0)

  
                    
declare @headers varchar(max)   

 

   select @headers   = '[
 {"label":"Portafolio","key":"desc","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"  }},
 {"label": "-30 a 0","key":"TRAM1", 
 "subs":[
	{"label":"Saldo Inicial","key":"SINI1_T1",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"SINI1_T1","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"SINI2_T1","cellStyle":{"text-align":"right"}}
		]},
	{"label":"Deteriorado","key":"DET1_T1",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"DET1_T1","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"DET2_T1","cellStyle":{"text-align":"right"}}
		]},
	{"label":"% Efectividad","key":"EFEC1_T1",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"EFEC1_T1","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"EFEC2_T1","cellStyle":{"text-align":"right"}}
		]}
 ]}, 

 {"label": "1 a 30","key":"TRAM2", 
 "subs":[
	{"label":"Saldo Inicial","key":"SINI1_T2",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"SINI1_T2","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"SINI2_T2","cellStyle":{"text-align":"right"}}
		]},
	{"label":"Deteriorado","key":"DET1_T2",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"DET1_T2","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"DET2_T2","cellStyle":{"text-align":"right"}}
		]},
	{"label":"% Efectividad","key":"EFEC1_T2",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"EFEC1_T2","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"EFEC2_T2","cellStyle":{"text-align":"right"}}
		]}
 ]},  

 {"label": "31 a 60","key":"TRAM3", 
 "subs":[
	{"label":"Saldo Inicial","key":"SINI1_T3",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"SINI1_T3","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"SINI2_T3","cellStyle":{"text-align":"right"}}
		]},
	{"label":"Deteriorado","key":"DET1_T3",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"DET1_T3","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"DET2_T3","cellStyle":{"text-align":"right"}}
		]},
	{"label":"% Efectividad","key":"EFEC1_T3",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"EFEC1_T3","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"EFEC2_T3","cellStyle":{"text-align":"right"}}
		]}
 ]}, 
 
 {"label": "61 a 90","key":"TRAM4", 
 "subs":[
	{"label":"Saldo Inicial","key":"SINI1_T4",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"SINI1_T4","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"SINI2_T4","cellStyle":{"text-align":"right"}}
		]},
	{"label":"Deteriorado","key":"DET1_T4",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"DET1_T4","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"DET2_T4","cellStyle":{"text-align":"right"}}
		]},
	{"label":"% Efectividad","key":"EFEC1_T4",
		"subs":[ 
			{ "label":"'+@obtenerNivel2_2anioactual+'","key":"EFEC1_T4","cellStyle":{"text-align":"right"}},
			{ "label":"'+@obtenerNivel2_3anioactual+'","key":"EFEC2_T4","cellStyle":{"text-align":"right"}}
		]}
 ]} 
	  
 ]'
 
 select @headers 

IF OBJECT_ID('tempdb..#fechas') IS NOT NULL DROP TABLE #fechas 
select DENSE_RANK() OVER (ORDER BY RFEC asc) AS R, format(RFEC,'yyyyMMdd') F into #fechas  from storage.[util].[FVECFEC01](@fec ,'hoy,cie_ant')  order by RFEC asc  

 declare @fec1 as varchar(8), @fec2 as varchar(8) 
 select @fec1 = f from #fechas where r=1 --cie mes ant 
 select @fec2 = f from #fechas where r=2 --cie dia
 
 declare @prod as varchar(25) 
 
 if @imp = 1 begin set @prod = '' end 
 else begin set @prod = 'IMPULSA MYPERU' end 
  
------------------------------------------------------------------------------------------------------------ 
------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#tram1') IS NOT NULL DROP TABLE #tram1
SELECT 
IDENTITY(INT,1,1) AS ORD,
--GROUPING(HDESPROD),GROUPING(HEREDADO),
    -- 1. Columna de identificación de la fila (Detalle, Subtotal o Total General)
    CASE
        -- Total General
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 2
        -- Subtotal por HEREDADO
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 1
        -- Detalle
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN 0
    END AS style,

	CASE 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 'TOTAL GENERAL' 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 'SUBTOTAL HEREDADO ' + CAST(T.HEREDADO AS NVARCHAR(10)) 
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN T.HDESPROD 
    END AS Item_Fila, 

	-- 2. Columna que muestra el valor de HEREDADO (solo en detalle)
    CASE
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN CAST(T.HEREDADO AS NVARCHAR(10))
        ELSE NULL 
    END AS HEREDADO,

    -- 3. Pivoteo 1: Suma para la fecha '2025-09-30'
    SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALINIMN ELSE 0 END) AS SINI1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALINIMN ELSE 0 END) AS SINI2,
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALDETMN ELSE 0 END) AS DET1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALDETMN ELSE 0 END) AS DET2, 

    CASE WHEN sum(HSALINIMN)>0 then
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC1,  
	 
 	CASE WHEN sum(HSALINIMN)>0 then
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC2 
 
INTO #tram1
FROM
    storage.com_act.WCRE001 T where hfecpro in (select F from #fechas) and htipcod = @tip_cod and hcodrel = @cod_rel and HDESPROD not in (@prod) and HTRAM = '1. -30-0'
    
GROUP BY
    GROUPING SETS ( 
        (T.HEREDADO, T.HDESPROD), -- Detalle
        (T.HEREDADO),             -- Subtotal
        ()                        -- Total General
    )
    
ORDER BY
    -- 1. Pone el Total General primero (le asigna el valor 1)
    CASE 
		WHEN GROUPING(HEREDADO) = 1 AND GROUPING(HDESPROD) = 1 THEN 1 ELSE 2 
    END, 
    T.HEREDADO desc,   --GROUPING(HDESPROD) DESC, 
    T.HDESPROD;

	--select * from #tram1
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#tram2') IS NOT NULL DROP TABLE #tram2
SELECT 
IDENTITY(INT,1,1) AS ORD,--GROUPING(HDESPROD),GROUPING(HEREDADO),
    -- 1. Columna de identificación de la fila (Detalle, Subtotal o Total General)
    CASE
        -- Total General
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 2
        -- Subtotal por HEREDADO
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 1
        -- Detalle
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN 0
    END AS style,

	CASE 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 'TOTAL GENERAL' 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 'SUBTOTAL HEREDADO ' + CAST(T.HEREDADO AS NVARCHAR(10)) 
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN T.HDESPROD 
    END AS Item_Fila, 

	-- 2. Columna que muestra el valor de HEREDADO (solo en detalle)
    CASE
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN CAST(T.HEREDADO AS NVARCHAR(10))
        ELSE NULL 
    END AS HEREDADO,

    -- 3. Pivoteo 1: Suma para la fecha '2025-09-30'
    SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALINIMN ELSE 0 END) AS SINI1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALINIMN ELSE 0 END) AS SINI2,
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALDETMN ELSE 0 END) AS DET1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALDETMN ELSE 0 END) AS DET2, 

    CASE WHEN sum(HSALINIMN)>0 then
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC1,  
	 
 	CASE WHEN sum(HSALINIMN)>0 then
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC2 
 
INTO #tram2
FROM
    storage.com_act.WCRE001 T where hfecpro in (select F from #fechas) and htipcod = @tip_cod and hcodrel = @cod_rel and HDESPROD not in (@prod) and HTRAM = '2. 1-30'
    
GROUP BY
    GROUPING SETS ( 
        (T.HEREDADO, T.HDESPROD), -- Detalle
        (T.HEREDADO),             -- Subtotal
        ()                        -- Total General
    )
    
ORDER BY
    -- 1. Pone el Total General primero (le asigna el valor 1)
    CASE 
		WHEN GROUPING(HEREDADO) = 1 AND GROUPING(HDESPROD) = 1 THEN 1 ELSE 2 
    END, 
    T.HEREDADO desc,   --GROUPING(HDESPROD) DESC, 
    T.HDESPROD;


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#tram3') IS NOT NULL DROP TABLE #tram3
SELECT 
IDENTITY(INT,1,1) AS ORD,--GROUPING(HDESPROD),GROUPING(HEREDADO),
    -- 1. Columna de identificación de la fila (Detalle, Subtotal o Total General)
    CASE
        -- Total General
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 2
        -- Subtotal por HEREDADO
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 1
        -- Detalle
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN 0
    END AS style,

	CASE 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 'TOTAL GENERAL' 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 'SUBTOTAL HEREDADO ' + CAST(T.HEREDADO AS NVARCHAR(10)) 
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN T.HDESPROD 
    END AS Item_Fila, 

	-- 2. Columna que muestra el valor de HEREDADO (solo en detalle)
    CASE
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN CAST(T.HEREDADO AS NVARCHAR(10))
        ELSE NULL 
    END AS HEREDADO,

    -- 3. Pivoteo 1: Suma para la fecha '2025-09-30'
    SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALINIMN ELSE 0 END) AS SINI1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALINIMN ELSE 0 END) AS SINI2,
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALDETMN ELSE 0 END) AS DET1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALDETMN ELSE 0 END) AS DET2, 

    CASE WHEN sum(HSALINIMN)>0 then
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC1,  
	 
 	CASE WHEN sum(HSALINIMN)>0 then
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC2 
 
INTO #tram3
FROM
    storage.com_act.WCRE001 T where hfecpro in (select F from #fechas) and htipcod = @tip_cod and hcodrel = @cod_rel and HDESPROD not in (@prod) and HTRAM = '3. 31-60'
    
GROUP BY
    GROUPING SETS ( 
        (T.HEREDADO, T.HDESPROD), -- Detalle
        (T.HEREDADO),             -- Subtotal
        ()                        -- Total General
    )
    
ORDER BY
    -- 1. Pone el Total General primero (le asigna el valor 1)
    CASE 
		WHEN GROUPING(HEREDADO) = 1 AND GROUPING(HDESPROD) = 1 THEN 1 ELSE 2 
    END, 
    T.HEREDADO desc,   --GROUPING(HDESPROD) DESC, 
    T.HDESPROD;

	
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#tram4') IS NOT NULL DROP TABLE #tram4
SELECT 
IDENTITY(INT,1,1) AS ORD,--GROUPING(HDESPROD),GROUPING(HEREDADO),
    -- 1. Columna de identificación de la fila (Detalle, Subtotal o Total General)
    CASE
        -- Total General
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 2
        -- Subtotal por HEREDADO
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 1
        -- Detalle
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN 0
    END AS style,

	CASE 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 1 THEN 'TOTAL GENERAL' 
        WHEN GROUPING(HDESPROD) = 1 AND GROUPING(HEREDADO) = 0 THEN 'SUBTOTAL HEREDADO ' + CAST(T.HEREDADO AS NVARCHAR(10)) 
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN T.HDESPROD 
    END AS Item_Fila, 

	-- 2. Columna que muestra el valor de HEREDADO (solo en detalle)
    CASE
        WHEN GROUPING(HDESPROD) = 0 AND GROUPING(HEREDADO) = 0 THEN CAST(T.HEREDADO AS NVARCHAR(10))
        ELSE NULL 
    END AS HEREDADO,

    -- 3. Pivoteo 1: Suma para la fecha '2025-09-30'
    SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALINIMN ELSE 0 END) AS SINI1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALINIMN ELSE 0 END) AS SINI2,
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN T.HSALDETMN ELSE 0 END) AS DET1,  
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN T.HSALDETMN ELSE 0 END) AS DET2, 

    CASE WHEN sum(HSALINIMN)>0 then
	SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec1 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC1,  
	 
 	CASE WHEN sum(HSALINIMN)>0 then
    SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALRECMN+HSALMAN01MN ELSE 0 END)/ NULLIF( SUM(CASE WHEN T.HFECPRO = @fec2 THEN HSALINIMN ELSE 0 END) ,0) else 0 end AS EFEC2 
 
INTO #tram4
FROM
    storage.com_act.WCRE001 T where hfecpro in (select F from #fechas) and htipcod = @tip_cod and hcodrel = @cod_rel and HDESPROD not in (@prod) and HTRAM = '4. 61-90'
    
GROUP BY
    GROUPING SETS ( 
        (T.HEREDADO, T.HDESPROD), -- Detalle
        (T.HEREDADO),             -- Subtotal
        ()                        -- Total General
    )
    
ORDER BY
    -- 1. Pone el Total General primero (le asigna el valor 1)
    CASE 
		WHEN GROUPING(HEREDADO) = 1 AND GROUPING(HDESPROD) = 1 THEN 1 ELSE 2 
    END, 
    T.HEREDADO desc,   --GROUPING(HDESPROD) DESC, 
    T.HDESPROD;



 
--RESULT
select  distinct 
case when A.Item_Fila = 'SUBTOTAL HEREDADO 0' then 'NO REASIGNADA' 
when A.Item_Fila = 'SUBTOTAL HEREDADO 1' THEN 'REASIGNADA'  
else  A.Item_Fila end  [desc],A.ord,
A.style,
FORMAT(isnull(A.SINI1,0), '#,##0') SINI1_T1, FORMAT(isnull(A.SINI2,0), '#,##0') SINI2_T1, FORMAT(isnull(A.DET1,0), '#,##0') DET1_T1, FORMAT(isnull(A.DET2,0), '#,##0') DET2_T1, FORMAT(isnull(A.EFEC1,0), 'P2') EFEC1_T1, FORMAT(isnull(A.EFEC2,0), 'P2') EFEC2_T1, 
FORMAT(isnull(B.SINI1,0), '#,##0') SINI1_T2, FORMAT(isnull(B.SINI2,0), '#,##0') SINI2_T2, FORMAT(isnull(B.DET1,0), '#,##0') DET1_T2, FORMAT(isnull(B.DET2,0), '#,##0') DET2_T2, FORMAT(isnull(B.EFEC1,0), 'P2') EFEC1_T2, FORMAT(isnull(B.EFEC2,0), 'P2') EFEC2_T2,
FORMAT(isnull(C.SINI1,0), '#,##0') SINI1_T3, FORMAT(isnull(C.SINI2,0), '#,##0') SINI2_T3, FORMAT(isnull(C.DET1,0), '#,##0') DET1_T3, FORMAT(isnull(C.DET2,0), '#,##0') DET2_T3, FORMAT(isnull(C.EFEC1,0), 'P2') EFEC1_T3, FORMAT(isnull(C.EFEC2,0), 'P2') EFEC2_T3,
FORMAT(isnull(D.SINI1,0), '#,##0') SINI1_T4, FORMAT(isnull(D.SINI2,0), '#,##0') SINI2_T4, FORMAT(isnull(D.DET1,0), '#,##0') DET1_T4, FORMAT(isnull(D.DET2,0), '#,##0') DET2_T4, FORMAT(isnull(D.EFEC1,0), 'P2') EFEC1_T4, FORMAT(isnull(D.EFEC2,0), 'P2') EFEC2_T4

from  #tram1 A
left join  #tram2 B on A.Item_Fila = B.Item_Fila and A.style = B.style  and isnull(A.HEREDADO,0) = isnull(B.HEREDADO,0)
left join  #tram3 C on A.Item_Fila = C.Item_Fila and A.style = C.style  and isnull(A.HEREDADO,0) = isnull(C.HEREDADO,0)
left join  #tram4 D on A.Item_Fila = D.Item_Fila and A.style = D.style  and isnull(A.HEREDADO,0) = isnull(D.HEREDADO,0)
order by A.ord

 
END
