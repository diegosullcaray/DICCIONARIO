-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.803000
--exec com.[GLISDETCLIPDM01] '41230938'
CREATE PROCEDURE [com].[GLISDETCLIPDM01]
@cod_rel varchar(20),@base varchar(20)  
AS  
BEGIN  
 SET NOCOUNT ON;  
	
    exec mod_rep.rep.FTHEACOLS01 'REACT_PDM_01'  ;

	--declare @cod_rel varchar(10)='41230938';
	with a as (
		select HDGRP,HCTACLI,HDCLI,HTELF01,HSEMF,HMONDESMN,HFUVEN,HDIAATR,HENTID,
		HTIPIN,HNUMDOC,HTIPDOC,HPAIS,HFECPRO,HHORPRO,HFINIVIG,HFFINVIG,HTIPOF
		from storage.[com_act].VRPDM001
		where HCODSEC in (select HCODBT  
		from  storage.[gpr].[VPPH001]    
		where @cod_rel=HNUMDOC)  
		and HTIPBASE=@base
	)
	select 
	A.HDGRP nom_grup,
	A.HCTACLI cta_cli,
	A.HDCLI nom_cli,
	A.HTELF01 num_tele,
	A.HSEMF sem,
	A.HMONDESMN mon_desem,
	A.HFUVEN fec_ult_ven,
	A.HDIAATR max_atr,
	A.HTIPOF tipo,
	A.HENTID num_ent,
	'' fec_ven,
	case when A.HTIPIN='Presidenta' then 'yellow' else null end background,
	A.HNUMDOC num_doc,
	A.HTIPDOC tip_doc,
	A.HPAIS cod_pais,
	A.HFECPRO fec_pro,
	CAST(A.HHORPRO AS nvarchar) hor_pro,
	A.HFINIVIG fini_vig,
	A.HFFINVIG ffin_vig,
	B.HREACC reaccion,
	B.HMOREACC motivo
	from a A
	left join storage.[com_act].HRPDM002 B
	on A.HNUMDOC=B.HNUMDOC and A.HPAIS=B.HPAIS and A.HTIPDOC=B.HTIPDOC
	and A.HHORPRO=B.HHORPRO and A.HFINIVIG=B.HFINIVIG and A.HFFINVIG=B.HFFINVIG
	order by A.HDGRP,A.HTIPIN desc,A.HDCLI



END
