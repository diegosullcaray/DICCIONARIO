-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:33.050000
CREATE PROCEDURE [com].[RSPANSUP003]  
@tip_cod int,@cod_rel nvarchar(10),@carg nvarchar(100)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 SET NOCOUNT ON;  
	-- Result Headers Multiple  
	exec [mod_rep].[rep].[FTHEACOLS01] 'PANEL_SUP_01';  
  
	-- Result Set  
	--declare @tip_cod  nvarchar(10)=7,@cod_rel nvarchar(10)='231',@carg nvarchar(100)='GERENTE REGIONAL';  
	DECLARE @fec nvarchar(10)=(SELECT max(RFECTXT) FROM [storage].[ref].RCALEN001 WHERE RFEC<= DATEADD(day,-1,cast(GETDATE() as  date)) AND RDIAFER=0)--'20200630'--

	SELECT M.RCODMAT,R.RCODREG,R.RCODTER,M.RDESMAT
	INTO #limitate
	from  storage.ref.REMR001 M
        left join storage.ref.RERT001 R
        on M.RCODREG=R.RCODREG
		where 
		case 
			when @tip_cod=6 then R.RCODTER 
			when @tip_cod=5 then R.RCODREG
			when @tip_cod=4 then M.RCODMAT
			else 1 end
		=
		case 
			when @tip_cod!=7 then @cod_rel 
			else 1 end

	select distinct HREG,HPERSUP--,HCODASE
	into #def
	from [storage].[com_act].[HDSC001]
	where HFECPRO=@fec
	and HCARGO=@carg



	;with a as (
	 select 
	 R.RDESREG,R.RDESREG+' - '+AA.HPERSUP as canal,  
	  SUM(A.SOPEPRE) [SupPre],SUM(SOPEPOST) [SupPost],
	  SUM(A.SOPECONF) [SupOpeConforme],SUM(SOPESEAL) [SupOpeConSeAler],SUM(SOPEREGR) [SupOpeRevGrav]
		from storage.[com_act].SDAS006  A
		left join storage.ref.REAM001 B on A.SSUCCLI=B.RCODAGE    
		left join storage.ref.REMR001 M on B.RCODMAT=M.RCODMAT    
		left join storage.ref.RERT001 R on M.RCODREG=R.RCODREG
		right join  #limitate BB on BB.RCODMAT=M.RCODMAT
		left join #def AA on AA.HREG=R.RDESREG
		where A.SFECPRO=@fec
		and A.SCODAGR IN (41)
		and A.SCARGO=@carg
		group by R.RDESREG,R.RDESREG+' - '+AA.HPERSUP
	),
	m as (
		select HDESREL,
		ISNULL(case when @carg='GERENTE REGIONAL' then HPREGREG when  @carg='JEFE AGROPECUARIO' then HPREJAGRO when  @carg='JEFE INCLUSION' then HPREJINCL when  @carg='COORDINADOR PDM' then HPRECOORPDM end,0) MPRE,
		ISNULL(case when @carg='GERENTE REGIONAL' then HPOSTGREG when  @carg='JEFE AGROPECUARIO' then HPOSTJAGRO when  @carg='JEFE INCLUSION' then HPOSTJINCL when  @carg='COORDINADOR PDM' then HPOSTCOORPDM end,0) MPOST
		--select * --f--rom 
		from storage.[com_act].[HMSUP001] 
		WHERE HFECPRO=EOMONTH(@fec)--HGRUREL='TERRITORIO'
	),
	b as (
	select 
		canal,
		[SupPre] sup_pre,MPRE cuo_pre,storage.api.FUSECDIV01([SupPre],MPRE,DEFAULT) por_pre,
		case when storage.api.FUSECDIV01([SupPre],MPRE,DEFAULT)>=1 then 1
			 when storage.api.FUSECDIV01([SupPre],MPRE,DEFAULT)<0.75 then -1
			 when storage.api.FUSECDIV01([SupPre],MPRE,DEFAULT) between 0.75 and 1 then 0
			 else null end sem_pre,
		[SupPost] sup_pos,MPOST cuo_pos,storage.api.FUSECDIV01([SupPost],MPOST,DEFAULT) por_pos,
		case when storage.api.FUSECDIV01([SupPost],MPOST,DEFAULT)>=1 then 1
			 when storage.api.FUSECDIV01([SupPost],MPOST,DEFAULT)<0.75 then -1
			 when storage.api.FUSECDIV01([SupPost],MPOST,DEFAULT) between 0.75 and 1 then 0
			 else null end sem_pos,
		ISNULL([SupPre],0)+ISNULL([SupPost],0) sup_tot,isnull(MPRE,0)+isnull(MPOST,0) cuo_tot,storage.api.FUSECDIV01(ISNULL([SupPre],0)+ISNULL([SupPost],0),isnull(MPRE,0)+isnull(MPOST,0),DEFAULT) por_tot,
		case when storage.api.FUSECDIV01(ISNULL([SupPre],0)+ISNULL([SupPost],0),isnull(MPRE,0)+isnull(MPOST,0),DEFAULT)>=1 then 1
			 when storage.api.FUSECDIV01(ISNULL([SupPre],0)+ISNULL([SupPost],0),isnull(MPRE,0)+isnull(MPOST,0),DEFAULT)<0.75 then -1
			 when storage.api.FUSECDIV01(ISNULL([SupPre],0)+ISNULL([SupPost],0),isnull(MPRE,0)+isnull(MPOST,0),DEFAULT) between 0.75 and 1 then 0
			 else null end sem_tot,
		[SupOpeConforme] ope_conf,storage.api.FUSECDIV01([SupOpeConforme],ISNULL([SupPre],0)+ISNULL([SupPost],0),DEFAULT) por_conf,
		[SupOpeConSeAler] ope_sena,storage.api.FUSECDIV01([SupOpeConSeAler],ISNULL([SupPre],0)+ISNULL([SupPost],0),DEFAULT) por_sena,
		[SupOpeRevGrav] ope_reva,storage.api.FUSECDIV01([SupOpeRevGrav],ISNULL([SupPre],0)+ISNULL([SupPost],0),DEFAULT) por_reva
		from a A
		left join m M ON RDESREG=M.HDESREL
	)
	select * 
	from b



END
