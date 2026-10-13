-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.437000

--use mod_rep

CREATE PROCEDURE [com].[GSELREP002]
    @codmod smallint = 11
AS
BEGIN
    SET NOCOUNT ON;

	exec mod_rep.rep.[FTHEACOLS01] 'SEL_JEFE_01'

	select	distinct
			SCODSUB id, 
			case STIPCOD
				when 11 then 'Jefe Agro - '
				when 12 then 'Jefe Inclusion - '
				else 'Ejecutivo BP - ' 
			end + SNOMSUB [desc]
	from	mod_rep.[rep].[SDECCOM01]
	where STIPCOD = @codmod
	order by
			2 DESC

	-- 11: AGRO
	-- 12: PDM
	-- 9: Ejecutivo BP
    
END
