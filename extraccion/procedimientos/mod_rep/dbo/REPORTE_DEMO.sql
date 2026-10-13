-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:41.470000
CREATE PROCEDURE dbo.REPORTE_DEMO
@fec varchar(10),
@cod_bt varchar(10)
AS
BEGIN
	
	SET NOCOUNT ON;

	select '{}' HDRS

    select 'Hola '+@cod_bt+' en la fecha '+format(cast(@fec as date),'yyyy-MM-dd') msg
END
