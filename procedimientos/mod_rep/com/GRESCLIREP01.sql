-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.080000
--select * from storage.gpr.HPAD001 where HMAILPER='sandra.tandaypan@confianza.pe'
--exec com.GRESCLIREP01 '76968082'
CREATE PROCEDURE [com].[GRESCLIREP01]
@cod_rel varchar(20)  
AS  
BEGIN  
 SET NOCOUNT ON;  
  
    exec mod_rep.rep.FTHEACOLS01 'RES_SEC_REP_01'  

	 ;with a as (
	 select @cod_rel num_doc_sec,A.HCTACLI cta_cli,A.HDESCLI nom_cli,A.HTIPDOC tip_doc,A.HPAIS pais,A.HNUMDOC num_doc_cli,
	 A.HNOMG nombre_gru_pdm,
	 A.HBGCTACLI background_cta_cli,
	 A.HBGNOMCLI background_nom_cli,
	 A.RDESPROD producto,
	 A.HFLAGREAC base_reactivados,
	 A.HGRUPROD grupo_prod,
	 A.HCODOPE operacion,
	 A.HFECDES fec_desem,  
	 A.HSALCAPMN saldo_capital_mn, 
	 A.HFECMOR fec_sgt_cuo_rep,  
	 A.HCUOPEN cuo_pend 
	 from storage.[com_act].WBCR001 A  
	 where A.HCODSEC in (select HCODBT  
	 from  storage.[gpr].[VPPH001]    
	 where @cod_rel=HNUMDOC)  
	 )
	 select A.num_doc_sec,A.cta_cli,A.nom_cli,
	 P.HNUMTELE telefono,
	 A.nombre_gru_pdm,
	 A.background_cta_cli,
	 A.background_nom_cli,
	 A. producto,
	 A.base_reactivados,
	 A.grupo_prod,
	 R.HTIPCUO tipo_cuo,
	 case when R.HTIPCUO='FLEX' then 'yellow' else null end background_tipo_cuo,
	 A.operacion,
	 A.fec_desem,  
	 A.saldo_capital_mn,
	 R.HMONCUO mon_cuo,  
	 A.fec_sgt_cuo_rep,  
	 A.cuo_pend,
	 R.HPREG01 preg_01,R.HPREG02 preg_02,R.HPREG03 preg_03,R.HPREG04 preg_04 
	 from a A
	 left join storage.[com_act].HBAR001 R  
	 on A.operacion=R.HCODOPE 
	 left join storage.gpr.HDETPER01 P
	 on P.HNUMDOC=A.num_doc_cli and A.tip_doc=P.HTIPDOC and A.pais=P.HPAIS
	 order by R.HTIPCUO

	 --;with a_ as (  
	 --select *
	 --from storage.[com_act].HCDR001  
	 --where HFECPRO='20200331'
	 --), 
	 --a as (
	 --select distinct HCODOPE  
	 --from a_ 
	 --where HDSUBGRU='COVID-19'
	 --and HDESGRU='MASIVO'  
	 --), 
	 --pdm1 as (
	 --select distinct HOPER,HDNIP
	 --from [storage].[com_act].[VGPH001]
	 --),
	 --pdm2 as (
	 --select HOPER,max(HNOMG) HNOMG
	 --from [storage].[com_act].[VGPH001]
	 --group by HOPER
	 --),
	 --b_ as (
	 --select *
	 --from storage.[com_act].VCAH001 
	 --where HCODSEC in (select HCODBT  
	 --from  storage.[gpr].[VPPH001]    
	 --where @cod_rel=HNUMDOC)
	 --),
	 --b as (  
	 --select @cod_rel num_doc_sec,A.HCTACLI cta_cli,A.HDESCLI nom_cli,
	 --P.HNUMTELE telefono,PDM2.HNOMG nombre_gru_pdm,
	 --case when PDM1.HDNIP is not null then 'yellow' else null end background_cta_cli,
	 --case when PDM1.HDNIP is not null then 'yellow' else null end background_nom_cli,
	 --P3.RDESPROD producto,
	 --case when I.HCTACLI is not null then 'SI' else 'NO' end base_reactivados,
	 --case when P1.RCODPROD=6 then 'PDM' else 'INDIVIDUAL' end grupo_prod,R.HTIPCUO tipo_cuo,
	 --case when R.HTIPCUO='FLEX' then 'yellow' else null end background_tipo_cuo,
	 --A.HCODOPE operacion,isnull(G.ROPEFEC,A.HFECDES) fec_desem,  
	 --A.HSALCAPMN saldo_capital_mn,R.HMONCUO mon_cuo,  
	 --HFECMOR fec_sgt_cuo_rep,  
	 --A.HCUOPEN cuo_pend,  
	 --R.HPREG01 preg_01,R.HPREG02 preg_02,R.HPREG03 preg_03,R.HPREG04 preg_04  
	 --from b_ A  
	 --left join storage.[com_act].RETP001 P1  
	 --on P1.RCODMOD=A.HCODMOD and P1.RTIPOPE=A.HTIPOPE  
	 --left join storage.[com_act].RETP002 P2  
	 --on P2.RCODMOD=A.HCODMOD and P2.RTIPOPE=A.HTIPOPE and P2.RSUBTIP=A.HSUBTIP  
	 --left join storage.[com_act].RETP003 P3  
	 --on P3.RCODPROD=isnull(P2.RCODPROD,P1.RCODPROD)  
	 --left join [storage].[com_act].[RFOC001] G  
	 --on A.[HCODOPE]=G.RCODOPE and A.[HINDCAR]<>'REFINANCIADO' and A.[HCODMOD]<>110   
	 --left join storage.[com_act].HBAR001 R  
	 --on A.HCODOPE=R.HCODOPE 
	 --left join storage.gpr.HDETPER01 P
	 --on P.HNUMDOC=A.HNUMDOC and A.HTIPDOC=P.HTIPDOC and A.HPAIS=P.HPAIS
	 --left join storage.[com_act].VBCH001 I
	 --on I.HCTACLI=A.HCTACLI 
	 --left join pdm1 PDM1
	 --on A.HCODOPE=PDM1.HOPER and PDM1.HDNIP=A.HNUMDOC
	 --left join pdm2 PDM2
	 --on PDM2.HOPER=A.HCODOPE  
	 --)
	 --select A.*  
	 --from b A  
	 --join a B  
	 --on A.operacion=B.HCODOPE  
	 ----where motivo is not null
	 --order by A.tipo_cuo
END
