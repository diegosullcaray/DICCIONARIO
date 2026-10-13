-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-23 17:44:12.700000

	CREATE PROCEDURE rep.RTABCUERES01
		@fecha varchar(8) = 'NOW',     
		@tip_cod int,     
		@cod_rel varchar(20) 
	AS 
	BEGIN     
		SET NOCOUNT ON;  


		SELECT '{"preliminar":1,"fechas":["2026-06-01","2026-05-01","2026-04-01","2026-03-01","2026-02-01","2026-01-01"]}' dummy


		drop table if exists #pyg
		select	*
		into	#pyg
		from	mod_rep.dbo.WREPPYG001
		where	WFECPRO = '2026-06-30'
		and		WCODREL = 1


		
		select		a.style,				
					a.codigo as cuenta_codigo, 
					a.descripcion as cuenta_nombre,
					a.pos as orden,
					b.WVALAA as periodo_anio_anterior,
					b.WVALANT as periodo_anterior,
					b.WVALACT as periodo_actual,
					b.WVALACT - b.WVALANT as variacion_periodo_anterior,
					b.WACUMAA as acumulado_anio_anterior,
					b.WACUMACT as acumulado_actual,
					b.WACUMACT - b.WACUMAA as variacion_acumulado,
					0 as variacion_acumulado_pct,
					WACUMT1 as trimestre_1,
					WACUMT2 as trimestre_2,
					WACUMT3 as trimestre_3,
					WACUMT4 as trimestre_4,
					isnull(WACUMT1, 0) + isnull(WACUMT2, 0) + isnull(WACUMT3, 0) + isnull(WACUMT4, 0) as total_anio

		from		mod_rep.dbo.REVARPYG a
		left join	#pyg b on a.codigo = b.WCODVAR



	END
