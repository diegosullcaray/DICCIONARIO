-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-01-02 10:18:31.023000
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--exec mod_rep.[com].[GRESREPSEG03] 7,'231'
CREATE procedure [com].[GRESREPSEG03] 
@tip_cod int,
@cod_rel varchar(10)
AS    
BEGIN   
  SET NOCOUNT ON;   

  DECLARE @dFechaMax date = (select MAX(SFECPRO) from storage.[com_seg].SDSF001)   

declare @nivel int
	if(@tip_cod=4)
	begin
	  set @nivel=3
	end
	else
	begin
		set @nivel=2
	end 
	
  CREATE TABLE #tmpDATOSSOPC3S(    
	  NVAR int, RCODVAR int,     
	  RDESPROD varchar(150), RNUM bigint,    
	  RNIVEL int, RNOMSUB varchar(250),    
	  TORD int, TFEC date,    
	  TNOMMES varchar(20), DESVAL varchar(150),    
	  VAL float)    

	  DECLARE @cvariables3 varchar(50)    
	  declare @json3 varchar(max) =    
	 '[{"variables":"ASEG_Tot.Seg.Nro,ASEG_Tot.Seg.SOAT.Nro.,ASEG_Tot.Seg.MA.Nro.,ASEG_Tot.Seg.ProtT.Nro.","elementos":[{"TIPCOD":'+convert(varchar(50),@tip_cod)+ ',"CODREL":"' + @cod_rel +'","niveles":'+convert(varchar(50),@nivel)+ '}],"fechas":["'+cast(@dFechaMax as nvarchar(10))+'"],"Tot. Seg.":"COM"}]'    
	   insert into #tmpDATOSSOPC3S     
	   EXEC mod_rep.[rep].[RCALC] @json3, null, 2   

	    create table #ResumenSeguro3    
	   (    
	   style int null,    
	   RNOMSUB varchar(100) null,    
	   VentaT int null,    
	   MetaT int null,    
	   CumpT float null,    
	   VentaMA int null,    
	   MetaMA int null,    
	   CumpMA float null,    
	   VentaPT int null,    
	   MetaPT int null,    
	   CumpPT float null,    
	   Venta int null,    
	   Meta int null,    
	   Cump float null
	   )    

	   select RCODVAR,count(*)as contador into #MaxCodVar from #tmpDATOSSOPC3S group by RCODVAR
	  declare @CodVar int,@counMax int
	  set @counMax=(select max(contador) from #MaxCodVar)
	  set @CodVar=(select top 1 RCODVAR from #MaxCodVar where contador=@counMax)

	   insert into #ResumenSeguro3 (style,RNOMSUB)
	   select  RNIVEL,RNOMSUB from #tmpDATOSSOPC3S where RCODVAR=@CodVar
	
	   update #ResumenSeguro3 set style=0 where style=2  
	   update #ResumenSeguro3 set VentaT=0,MetaT=0,CumpT=0,VentaMA=0,MetaMA=0,CumpMA=0,VentaPT=0,
	   MetaPT=0,CumpPT=0,Venta=0,Meta=0,Cump=0

	  update a    
	  set a.VentaMA=b.val    
	  from #ResumenSeguro3 a inner join (select rnomsub,val from #tmpDATOSSOPC3S where desval='ASEG_Tot.Seg.MA.Nro.')b    
	  on a.RNOMSUB=b.RNOMSUB   

	   update a    
	  set a.VentaPT=b.val    
	  from #ResumenSeguro3 a inner join (select rnomsub,val from #tmpDATOSSOPC3S where desval='ASEG_Tot.Seg.ProtT.Nro.')b    
	  on a.RNOMSUB=b.RNOMSUB   

	   update a    
	  set a.Venta=b.val    
	  from #ResumenSeguro3 a inner join (select rnomsub,val from #tmpDATOSSOPC3S where desval='ASEG_Tot.Seg.SOAT.Nro.')b    
	  on a.RNOMSUB=b.RNOMSUB   
	 
	  update a    
	  set a.CumpT=b.val    
	  from #ResumenSeguro3 a inner join (select  rnomsub,case when MetaT=0 then 0 else  cast(VentaT as float)/cast(MetaT as float)end as val  from #ResumenSeguro3)b    
	  on a.RNOMSUB=b.RNOMSUB

	  update a    
	  set a.CumpMA=b.val    
	  from #ResumenSeguro3 a inner join (select  rnomsub,case when MetaMA=0 then 0 else  cast(VentaMA as float)/cast(MetaMA as float) end as val  from #ResumenSeguro3)b    
	  on a.RNOMSUB=b.RNOMSUB

	   update a    
	  set a.CumpPT=b.val    
	  from #ResumenSeguro3 a inner join (select  rnomsub,case when MetaPT=0 then 0 else  cast(VentaPT as float)/cast(MetaPT as float) end as val  from #ResumenSeguro3)b    
	  on a.RNOMSUB=b.RNOMSUB

	   update a    
	  set a.Cump=b.val    
	  from #ResumenSeguro3 a inner join (select  rnomsub,case when Meta=0 then 0 else  cast(Venta as float)/cast(Meta as float) end as val  from #ResumenSeguro3)b    
	  on a.RNOMSUB=b.RNOMSUB

	  update a    
	  set a.VentaT=b.val    
	  from #ResumenSeguro3 a inner join (select rnomsub,VentaMA+VentaPT+Venta as val from #ResumenSeguro3)b    
	  on a.RNOMSUB=b.RNOMSUB

	 create table #cab3 (result nvarchar(max)) --drop table #cab    
	 INSERT INTO #cab3    
	 exec [rep].[FTHEACOLS01] 'RSCMIS_03';    
    
	 select result from #cab3   
	 select*from #ResumenSeguro3 
END
