-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.757000
--exec com.[GLISDETCLI01] '00245492'
CREATE PROCEDURE [com].[GLISDETCLI01]
@cod_rel varchar(20)  
AS  
BEGIN  
 SET NOCOUNT ON;  
  
    exec mod_rep.rep.FTHEACOLS01 'DET_CLI_01'  ;

	;with a as (
	select distinct HNUMDOC,HTIPDOC,HPAIS,HDESCLI
	from storage.[com_act].VCAH001
	where HCODSEC in (select HCODBT  
	from  storage.[gpr].[VPPH001]    
	where @cod_rel=HNUMDOC)  
	),
	ciu as (
	select [RDESCIIU],
	case when concat(substring([RCODCIIU],2,3),'00') in ('11100','11200','11300','12100','12200','13000','14000','15000','20000','50000')
	then left([RCODCIIU],5) else [RCODCIIU] end RCODCIIU
	from storage.[ref].[REGCIIU003]
	)
	select A.HNUMDOC num_doc,
	A.HTIPDOC cod_tip_doc,
	C.RDTIPDOC des_tip_doc,
	A.HPAIS cod_pais,
	D.RDPAIS des_pais,
	A.HDESCLI nom_cli,
    B.HEMAIL email,
	B.HNUMTELE num_tele_0,
	B.HVERTEL verificador_num_tele, 
	B.HVERTEL ver_num_tele,
	json_value(B.HTELEINFO,'$[0].num_tele') num_tele_1,
	json_value(B.HTELEINFO,'$[1].num_tele') num_tele_2,
	CIUBT.RDESCIIU ciiu_0,
	B.HCIIU ciiu_0_id,
	case when B.HVERCIIU=1 then 'OK' when B.HVERCIIU=0 then 'NO OK' end verificador_ciiu,
	B.HVERCIIU ver_ciiu,
	CIU1.RDESCIIU ciiu_1 , 
	CIU2.RDESCIIU ciiu_2 , 
	CIU3.RDESCIIU ciiu_3 , 
	B.HTELEINFO cels,
	B.HCIUINFO cius
	from a A
	left join storage.gpr.HDETPER01 B
	on A.HNUMDOC=B.HNUMDOC and A.HPAIS=B.HPAIS and A.HTIPDOC=B.HTIPDOC
	left join storage.ref.RDTD001 C
	on C.RTIPDOC=A.HTIPDOC
	left join storage.ref.RDPAIS001 D
	on D.RPAIS=A.HPAIS
	left join ciu  CIUBT
	on CONCAT(CIUBT.RCODCIIU,'00')=B.HCIIU
	left join ciu  CIU1 
	on CONCAT(CIU1.RCODCIIU,'00')=JSON_value(B.HCIUINFO, '$[0]')
	left join ciu  CIU2 
	on CONCAT(CIU2.RCODCIIU,'00')=JSON_value(B.HCIUINFO, '$[1]')
	left join ciu  CIU3 
	on CONCAT(CIU3.RCODCIIU,'00')=JSON_value(B.HCIUINFO, '$[2]')

END
