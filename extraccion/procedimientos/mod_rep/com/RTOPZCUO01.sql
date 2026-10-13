-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-20 19:46:38.283000
--exec mod_rep.[com].[RTOPZCUO01] 7,'231','20260919'
CREATE PROCEDURE [com].[RTOPZCUO01]    
@tip_cod int, @cod_rel varchar(20), @Fecha varchar(10)   
AS  
BEGIN  
    SET NOCOUNT ON; 

	declare @headers varchar(max)  
	select @headers  ='[ 
	 { "label":"Territorio","key":"RDESTER","sticky": "true","cellStyle":{"text-align":"left","max-width":"100px","min-width":"100px","width":"100px"}},
	 { "label":"Corredor","key":"RDESCOR","sticky": "true","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}},
	 { "label":"Unidad","key":"RDESUNI","sticky": "true","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}},
	 { "label":"Asesor","key":"RDESSEC","sticky": "true","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}},
	 { "label":"Saldo MN","key":"hsalcapmn","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                    
	 { "label":"Tot Operaciones","key":"HTOTOPE","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                    
	 { "label":"Ope Traslados","key":"TRASLADO","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                    
	 { "label":"ope Heredados","key":"HEREDADO","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}}
	]'

	select @headers  
	--declare @tip_cod varchar(5)=7, @cod_rel varchar(25)='231', @Fecha DATE ='20260919'    
	
	select top 10 RDESTER, RDESCOR, RDESUNI, RDESSEC, sum(A.hsalcapmn)hsalcapmn, count(distinct A.HCODOPE)HTOTOPE,
	count(distinct case when a.HCODORI = A.HASEOPER then A.HCODOPE end ) TRASLADO,
	count(distinct case when a.HCODDES = A.HASEOPER then A.HCODOPE end ) HEREDADO  
	from storage.com_act.wzcuo001 A 
	where A.hfecpro  = @Fecha and CASE 
				WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
				WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
				WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
				WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
				WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
				WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
			  END = @cod_rel  and A.HASEOPER like 't%'
	group by RDESTER, RDESCOR, RDESUNI, RDESSEC
	order by 5 desc 
  
END
