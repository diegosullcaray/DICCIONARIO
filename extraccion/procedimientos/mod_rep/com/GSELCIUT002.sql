-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.403000
--exec com.[GSELCIUT002] 
CREATE PROCEDURE [com].[GSELCIUT002] 
AS  
BEGIN  
 SET NOCOUNT ON;  
	
    --Headers 
	declare @defs as rep.TTHCOLDEF

	insert into @defs
	(TORDER,TLEV,TISDATA,TKEY,TDESC,TSTICKY)  values
	(1,1,1,'','',1)

	select rep.FFTHCOLDEF(@defs) result;


	with a as (
		select * from   [storage].[ref].[REGCIIU002]
	)
	select 
	A.HDESGIRO [desc],
	A.HDESGIRO id,
	A.HSECECO sec_eco
	from a A




END
