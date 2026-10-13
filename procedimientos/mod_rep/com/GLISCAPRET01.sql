-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.747000
--exec com.[GLISCAPRET01] '41230938'
create PROCEDURE [com].[GLISCAPRET01]
@cod_rel varchar(20) 
AS  
BEGIN  
 SET NOCOUNT ON;  
	
    --Headers 
	declare @defs as rep.TTHCOLDEF

	insert into @defs
	(TORDER,TLEV,TISDATA,TKEY,TDESC,TSTICKY,TFORTYP,TFORMOD,TSTBACKGROUND)  values
	(1,1,1,'cta_cli','Cuenta Cliente',null,'string',null,null),
	(2,1,2,'nom_cli','Nombre Cliente',1,'string',null,null),
	(3,1,3,'tip_sbs','Tipo SBS',null,'string',null,null),
	(4,1,4,'sit_cred','Situación de Crédito',null,'string',null,null),
	(5,1,5,'sal_cart','Saldo Cartera',null,'number','.0-0',null),
	(6,1,6,'max_atr','Días Atraso',null,'number','.0-0',null),
	(7,1,7,'afec_neg','Afectación de Negocio',null,'string',null,'orange'),
	(8,1,8,'fun_neg','Negocio  Funcionando?',null,'string',null,'orange'),
	(9,1,9,'sit_neg','Nivel de Ventas',null,'string',null,'orange'),
	(10,1,10,'red_neg','Reducción Nivel de Ventas',null,'string',null,'orange'),
	(11,1,11,'sec_eco','Sector Económico',null,'string',null,'orange'),
	(12,1,12,'gir_neg','Giro Negocio',null,'string',null,'orange')

	insert into @defs
	(TORDER,TLEV,TISDATA,TKEY,TDESC,TSTICKYEND,TFORTYP,TSTDEWIDTH,TACTVAR,TACTICON)  values
	(13,1,13,'action_01','Act. Encuesta',1,'button','40px','nom_cli-fec_pro-fini_vig-ffin_vig-hor_pro-cta_cli-cod_ope-tip_ope-num_doc-tip_doc-cod_pais-reaccion','launch')

	--select * from @defs
	select rep.FFTHCOLDEF(@defs) result;

	--declare @cod_rel varchar(10)='00245492';
	with a as (
		select HCODOPE,HTIPOPE,HCTACLI,HDCLI,HDIAATR,
		HFECPRO,HHORPRO,HFINIVIG,HFFINVIG,HSALCAPMN
		,HTIPSBS,HDSITCRED,HNUMDOC,HTIPDOC,HPAIS,HDREACC
		from [storage].[com].VLDRD01
		where HCODSEC in (select HCODBT  
		from  storage.[gpr].[VPPH001]    
		where @cod_rel=HNUMDOC)  
	)
	select 
	A.HCODOPE cod_ope,
	A.HSALCAPMN sal_cart,
	A.HDCLI nom_cli,
	A.HDIAATR max_atr,
	A.HFECPRO fec_pro,
	A.HTIPSBS tip_sbs,
	A.HDSITCRED sit_cred,

	A.HFECPRO fec_pro,
	A.HFINIVIG fini_vig,
	A.HFFINVIG ffin_vig,
	CAST(HHORPRO AS nvarchar) hor_pro,
	A.HCTACLI cta_cli,
	A.HCODOPE cod_ope,
	A.HTIPOPE tip_ope,
	A.HNUMDOC num_doc,
	A.HTIPDOC tip_doc,
	A.HPAIS cod_pais,
	A.HDREACC reaccion,
	json_value(A.HDREACC,'$.afec_neg') afec_neg,
	json_value(A.HDREACC,'$.fun_neg') fun_neg,
	json_value(A.HDREACC,'$.sit_neg') sit_neg,
	json_value(A.HDREACC,'$.red_neg') red_neg,
	json_value(A.HDREACC,'$.sec_eco') sec_eco,
	json_value(A.HDREACC,'$.gir_neg') gir_neg
	from a A
	order by A.HDCLI

END
