-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-01-02 10:18:45.717000
CREATE procedure [com].[GRESREPSEG04] 
@tip_cod int,    
@cod_rel varchar(10)    
AS    
BEGIN   
  SET NOCOUNT ON;   

  DECLARE @dFechaMax date = (select MAX(SFECPRO) from storage.[com_seg].SDSF001)   
  CREATE TABLE #tmpDATOSS1S( --DROP TABLE #tmpDATOSS1S    
	  NVAR int, RCODVAR int,     
	  RDESPROD varchar(150), RNUM bigint,    
	  RNIVEL int, RNOMSUB varchar(250),    
	  TORD int, TFEC date,    
	  TNOMMES varchar(20), DESVAL varchar(150),    
	  VAL float)  

	  CREATE TABLE #tmpDATOSS1SINFAE( --DROP TABLE #tmpDATOSS1S    
	  NVAR int, RCODVAR int,     
	  RDESPROD varchar(150), RNUM bigint,    
	  RNIVEL int, RNOMSUB varchar(250),    
	  TORD int, TFEC date,    
	  TNOMMES varchar(20), DESVAL varchar(150),    
	  VAL float)  

	   CREATE TABLE #tmpDATOSS3S( --DROP TABLE #tmpDATOSS1S    
	  NVAR int, RCODVAR int,     
	  RDESPROD varchar(150), RNUM bigint,    
	  RNIVEL int, RNOMSUB varchar(250),    
	  TORD int, TFEC date,    
	  TNOMMES varchar(20), DESVAL varchar(150),    
	  VAL float)  


	 declare @nivel int
	if(@tip_cod=4)
	begin
	  set @nivel=3
	end
	else
	begin
		set @nivel=2
	end 


	DECLARE @cvariables varchar(50)    
	  declare @json varchar(max) =    
	  '[{"variables":"ASEG_Tot.Seg.Mult.Pol.CC,ASEG_Nro.CA,ASEG_Nro.CC,ASEG_Tot.Seg.Mult.Pol.P,ASEG_Tot.Seg.Prot.Pol.CE,ASEG_Tot.Seg.Prot.Pol.C,ASEG_Tot.Seg.MC.Pol.PCC,ASEG_Tot.Seg.Agr.Pol.CA,ASEG_Tot.Seg.Prot.Pol.PCC,ASEG_Nro.PCC,ASEG_Nro.OP","elementos":[{"TIPCOD":'+convert(varchar(50),@tip_cod)+ ',"CODREL":"' + @cod_rel +'","niveles":'+convert(varchar(50),@nivel)+'}],"fechas":["'+cast(@dFechaMax as nvarchar(10))+'"],"Tot. Seg.":"COM"}]'    
	   
	   insert into #tmpDATOSS1S     
	   EXEC mod_rep.[rep].[RCALC] @json, null, 2    

	declare @json1 varchar(max)=
	 '[{"variables":"ASEG_Nro.P","elementos":[{"TIPCOD":'+convert(varchar(50),@tip_cod)+ ',"CODREL":"' + @cod_rel +'","niveles":'+convert(varchar(50),@nivel)+'}],"fechas":["'+cast(@dFechaMax as nvarchar(10))+'"],"filtro":"SIN FAE"}]'    
	   insert into #tmpDATOSS1SINFAE
	    EXEC mod_rep.[rep].[RCALC] @json1, null, 2    

		declare @json2 varchar(max)=
	 '[{"variables":"ASEG_Nro.OPT","elementos":[{"TIPCOD":'+convert(varchar(50),@tip_cod)+ ',"CODREL":"' + @cod_rel +'","niveles":'+convert(varchar(50),@nivel)+'}],"fechas":["'+cast(@dFechaMax as nvarchar(10))+'"],"filtro":"SIN FAE"}]'    
	   insert into #tmpDATOSS3S
	    EXEC mod_rep.[rep].[RCALC] @json2, null, 2

		 declare @json5 varchar(max) =
	'[{"variables":"ASEG_Tot.Seg.Prot.Pol.PCCCCE,ASEG_Tot.Seg.MC.Pol.PCCCA","elementos":[{"TIPCOD":'+convert(varchar(50),@tip_cod)+ ',"CODREL":"' + @cod_rel +'","niveles":'+convert(varchar(50),@nivel)+ '}],"fechas":["'+cast(@dFechaMax as nvarchar(10))+'"]}]'    
	    insert into #tmpDATOSS1S     
	   EXEC mod_rep.[rep].[RCALC] @json5, null, 2  

	--	select * from #tmpDATOSS3S


	   create table #ResumenSeguro2   
	   (    
	   style int null,    
	   RNOMSUB varchar(100) null,    
	   TOpeOS int null,    
	   TSegOS int null,    
	   PorcPenOS float null,    
	   SMROS float null,
	   SMCOS float null,
	   SPCCOS float null,
	   SAGROS int null,
	   SEMPCOS INT null,
	   SCCOS INT null,
	   SAGROPEOS INT null,
	   SCONSUMOS INT null,
	   SCEOS INT null,
	   TOpeMR int null,    
	   SegMR int null,    
	   PorcPenMR float null,    
	   SECMR float null,
	   SECCMR float null,
	   TOpeAgro int null,    
	   SegAgro int null,    
	   PorcPenAgro float null,    
	   TOpeMC int null,    
	   SegMC int null,    
	   PorcPenMC float null,
	   TOpePC int null,    
	   SegPC int null,    
	   PorcPenPC float null,
	   EMPCPC int null,
	   CCPC int null,
	   CONSUMPC int null,
	   CREPC int null
	   )    
	    select RCODVAR,count(*)as contador into #MaxCodVar from #tmpDATOSS1S group by RCODVAR
	  declare @CodVar int,@counMax int
	  set @counMax=(select max(contador) from #MaxCodVar)
	  set @CodVar=(select top 1 RCODVAR from #MaxCodVar where contador=@counMax)

	   insert into #ResumenSeguro2 (style,RNOMSUB)    
	   select  RNIVEL,RNOMSUB from #tmpDATOSS1S where RCODVAR=@CodVar /*3203*//*3196*/ order by RNIVEL asc   
	   	  /*
	   insert into #ResumenSeguro2 (style,RNOMSUB)    
	   select  RNIVEL,RNOMSUB from #tmpDATOSS1S where RCODVAR=5006/*3244*/ order by RNIVEL asc
	   */
	   update #ResumenSeguro2 set style=0 where style=2  
	   UPDATE #ResumenSeguro2 set TOpeOS=0,TSegOS=0,PorcPenOS=0,TOpeMR=0,SegMR=0,PorcPenMR=0,
		TOpeAgro=0,SegAgro=0,PorcPenAgro=0,TOpeMC=0,SegMC=0,PorcPenMC=0,TOpePC=0,SegPC=0,PorcPenPC=0,
		CREPC=0,CONSUMPC=0,CCPC=0,EMPCPC=0,SECCMR=0,SECMR=0,SCEOS=0,SCONSUMOS=0,
		SAGROPEOS=0,SCCOS=0,SEMPCOS=0,SAGROS=0,SPCCOS=0,SMCOS=0,SMROS=0

		
	  update a    
	  set a.TOpeMR=b.val    
	  from #ResumenSeguro2 a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Nro.PCC')b    
	  on a.RNOMSUB=b.RNOMSUB  

	  update a    
	  set a.TOpeMC=b.val    
	  from #ResumenSeguro2 a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Nro.PCC')b    
	  on a.RNOMSUB=b.RNOMSUB  

	  update a    
	  set a.TOpePC=b.val    
	  from #ResumenSeguro2 a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Nro.PCC')b    
	  on a.RNOMSUB=b.RNOMSUB 

		update a    
	  set a.TOpeAgro=b.val    
	  from #ResumenSeguro2 a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Nro.CA')b    
	  on a.RNOMSUB=b.RNOMSUB  

	  update a    
	  set a.SegMC=b.val    
	  from #ResumenSeguro2 a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Tot.Seg.MC.Pol.PCCCA'/*'ASEG_Tot.Seg.MC.Pol.PCC'*/)b    
	  on a.RNOMSUB=b.RNOMSUB   

	  update a    
	  set a.SegPC=b.val    
	  from #ResumenSeguro2 a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Tot.Seg.Prot.Pol.PCCCCE'/*'ASEG_Tot.Seg.Prot.Pol.PCC'*/)b    
	  on a.RNOMSUB=b.RNOMSUB 

	  update a    
	  set a.SegAgro=b.val    
	  from #ResumenSeguro2 a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Tot.Seg.Agr.Pol.CA')b    
	  on a.RNOMSUB=b.RNOMSUB 
	
	  update a
	  set a.PorcPenAgro=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,case when TOpeAgro=0 then 0 else cast(cast(SegAgro as float)/cast(TOpeAgro as float)as float) end as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB


	  update a
	  set a.SECCMR=b.val
	  from #ResumenSeguro2  a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT' and RDESPROD='CONSTRUYENDO CONFIANZA' group by rnomsub)b--(select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Nro.CC')b    
	  on a.RNOMSUB=b.RNOMSUB

	   update a
	  set a.SECMR=b.val
	  from #ResumenSeguro2  a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT' and RDESPROD='EMPRENDIENDO CONFIANZA' group by rnomsub)b    
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.CCPC=b.val
	  from #ResumenSeguro2  a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT' and RDESPROD='CONSTRUYENDO CONFIANZA' group by rnomsub)b--(select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Nro.CC')b--'ASEG_Tot.Seg.Prot.Pol.CC')b    
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.CREPC=b.val
	  from #ResumenSeguro2  a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Tot.Seg.Prot.Pol.CE')b    
	  on a.RNOMSUB=b.RNOMSUB
	  
	   update a
	  set a.CONSUMPC=b.val
	  from #ResumenSeguro2  a inner join (select rnomsub,val from #tmpDATOSS1S where desval='ASEG_Tot.Seg.Prot.Pol.C')b    
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.EMPCPC=b.val
	  from #ResumenSeguro2  a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT' and RDESPROD='EMPRENDIENDO CONFIANZA' group by rnomsub)b    
	  on a.RNOMSUB=b.RNOMSUB
	  
	  update a
	  set a.PorcPenMR=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,case when TOpeMR=0 then 0 else cast(cast(SegMR as float)/cast(TOpeMR as float)as float) end as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB 

	   update a
	  set a.PorcPenMC=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,case when TOpeMC=0 then 0 else cast(cast(SegMC as float)/cast(TOpeMC as float) as float) end as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	  update a    
	  set a.SegMR=b.val    
	  from #ResumenSeguro2 a inner join  (select a.rnomsub,a.val+b.val as val from #tmpDATOSS1S a inner join #tmpDATOSS1S b on a.rnomsub=b.rnomsub where a.desval='ASEG_Tot.Seg.Mult.Pol.CC' and b.desval ='ASEG_Tot.Seg.Mult.Pol.P' )b 
	  on a.RNOMSUB=b.RNOMSUB 

	   update a
	  set a.PorcPenPC=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,case when TOpePC=0 then 0 else cast(((cast(SegPC as float)/cast(TOpePC as float))) as float)  end as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	   update a
	  set a.SMROS=b.val
	  from #ResumenSeguro2 a inner join (select a.rnomsub,a.val+b.val as val from #tmpDATOSS1S a inner join #tmpDATOSS1S b on a.rnomsub=b.rnomsub where a.desval='ASEG_Tot.Seg.Mult.Pol.CC' and b.desval ='ASEG_Tot.Seg.Mult.Pol.P' )b 
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.SMCOS=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,SegMC as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	   update a
	  set a.SPCCOS=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,SegPC as val from #ResumenSeguro2 )b
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.SAGROS=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,SegAgro as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	   update a
	  set a.SCONSUMOS=b.val
	  from #ResumenSeguro2 a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT' and RDESPROD='CONSUMO' group by rnomsub)b --(select RNOMSUB,CONSUMPC as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	   update a
	  set a.SCEOS=b.val
	  from #ResumenSeguro2 a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT' and RDESPROD='CREDITO EDUCATIVO' group by rnomsub)b--(select RNOMSUB,CREPC as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.TSegOS=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,SMROS+SMCOS+SPCCOS+SAGROS as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	  
	  update a
	  set a.SEMPCOS=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,(SECMR+EMPCPC)/2 as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.SCCOS=b.val
	  from #ResumenSeguro2 a inner join (select RNOMSUB,(SECCMR+CCPC)/2 as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB


	  update a
	  set a.SAGROPEOS=b.val
	  from #ResumenSeguro2 a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT' and RDESPROD='AGROPECUARIO' group by rnomsub)b --(select RNOMSUB,TOpeAgro as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB

	  update a
	  set a.TOpeOS=b.val
	  from #ResumenSeguro2  a inner join (select rnomsub,sum(val) as val from #tmpDATOSS3S where desval='ASEG_Nro.OPT'/*'ASEG_Nro.OP'*/ group by rnomsub)b    
	  on a.RNOMSUB=b.RNOMSUB

	   update a
	  set a.PorcPenOS=b.val
	  from #ResumenSeguro2 a inner join (select rnomsub,case when TOpeOS=0 then 0 else cast(cast(TSegOS as float)/cast(TOpeOS as float) as float) end as val from #ResumenSeguro2)b
	  on a.RNOMSUB=b.RNOMSUB 

	 create table #cab2 (result nvarchar(max)) --drop table #cab    
	 INSERT INTO #cab2   
	 exec [rep].[FTHEACOLS01] 'RSCMISEG_01';   

	 select result from #cab2   
	 select style,RNOMSUB,TOpeOS,SAGROS,TSegOS,SPCCOS,PorcPenOS from #ResumenSeguro2 
	  
END
