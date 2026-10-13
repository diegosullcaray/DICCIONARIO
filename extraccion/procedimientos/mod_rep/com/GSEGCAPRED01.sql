-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.367000
--exec mod_rep.[com].[GSEGCAPRED01] 4,301
CREATE procedure [com].[GSEGCAPRED01] 
@tip_cod int,    
@cod_rel varchar(10)    
AS    
BEGIN   
  SET NOCOUNT ON;   

  DECLARE @dFechaMax varchar(20) = format((select MAX(SFECPRO) from storage.[com_pas].SDPS002),'yyyyMMdd')
  declare @f2 varchar(20) = (select top 1 RFECTXT from storage.ref.RCALEN001 where RFEC<=eomonth(@dFechaMax,-1) and RDIAFER=0 order by RFEC desc)
  
  declare @tip_cod2 int
  select @tip_cod2=@tip_cod-1

  declare @sql varchar(max)

  set @sql='
	;with a as (
	select *
	from storage.[com_pas].SDPS002
	where SFECPRO='''+@dFechaMax+'''
	and SCODAGR=7
	),
	b as (
	select ''231'' C7,''FC'' D7,B.RCODTER C6,B.RDESTER D6,B.RCODREG C5,B.RDESREG D5,B.RCODMAT C4,B.RDESMAT D4,B.RCODAGE C3,B.RDESAGE D3,sum(A.SSALMN) saldo_cap,
	sum(case when C.RDESCPROD02=''AHORROS'' then A.SSALMN else 0 end) saldo_cap_aho,
	sum(case when C.RDESCPROD02=''CTS'' then A.SSALMN else 0 end) saldo_cap_cts,
	sum(case when C.RDESCPROD02=''PLAZO FIJO'' then A.SSALMN else 0 end) saldo_cap_dpf
	from a A
	left join storage.ref.VJERAGE01 B
	on A.SSUCCLI=B.RCODAGE
	left join storage.[com_pas].RETP001 C
	on C.RCODMOD=A.SSBMOD and C.RTIPOPE=A.SSBTOPE
	group by B.RCODTER,B.RDESTER,B.RCODREG,RDESREG,B.RCODMAT,B.RDESMAT,B.RCODAGE,B.RDESAGE
	),
	a2 as (
	select *
	from storage.[com_pas].SDPS002
	where SFECPRO='''+@f2+'''
	and SCODAGR=7
	),
	b2 as (
	select ''231'' C7,''FC'' D7,B.RCODTER C6,B.RDESTER D6,B.RCODREG C5,B.RDESREG D5,B.RCODMAT C4,B.RDESMAT D4,B.RCODAGE C3,B.RDESAGE D3,sum(A.SSALMN) saldo_cap,
	sum(case when C.RDESCPROD02=''AHORROS'' then A.SSALMN else 0 end) saldo_cap_aho,
	sum(case when C.RDESCPROD02=''CTS'' then A.SSALMN else 0 end) saldo_cap_cts,
	sum(case when C.RDESCPROD02=''PLAZO FIJO'' then A.SSALMN else 0 end) saldo_cap_dpf
	from a2 A
	left join storage.ref.VJERAGE01 B
	on A.SSUCCLI=B.RCODAGE
	left join storage.[com_pas].RETP001 C
	on C.RCODMOD=A.SSBMOD and C.RTIPOPE=A.SSBTOPE
	group by B.RCODTER,B.RDESTER,B.RCODREG,RDESREG,B.RCODMAT,B.RDESMAT,B.RCODAGE,B.RDESAGE
	),
	c as (
	select 
	isnull(A.C7,B.C7) C7,
	isnull(A.D7,B.D7) D7,
	isnull(A.C6,B.C6) C6,
	isnull(A.D6,B.D6) D6,
	isnull(A.C5,B.C5) C5,
	isnull(A.D5,B.D5) D5,
	isnull(A.C4,B.C4) C4,
	isnull(A.D4,B.D4) D4,
	isnull(A.D3,B.D3) D3,
	isnull(A.saldo_cap,0) saldo_cap,
	isnull(B.saldo_cap,0) saldo_cap2,
	isnull(A.saldo_cap_aho,0) saldo_cap_aho,
	isnull(B.saldo_cap_aho,0) saldo_cap_aho2,
	isnull(A.saldo_cap_cts,0) saldo_cap_cts,
	isnull(B.saldo_cap_cts,0) saldo_cap_cts2,
	isnull(A.saldo_cap_dpf,0) saldo_cap_dpf,
	isnull(B.saldo_cap_dpf,0) saldo_cap_dpf2
	from b A
	full join B2 B
	on A.C3=B.C3
	),
	d as (
	select cast(D'+cast(@tip_cod as varchar)+' as varchar(250)) D1,cast(D'+cast(@tip_cod2 as varchar)+' as varchar(250)) D2,
	sum(saldo_cap) saldo_cap,sum(saldo_cap-saldo_cap2) var_saldo_cap,sum(saldo_cap2) saldo_cap2,
	sum(saldo_cap_aho) saldo_cap_aho,sum(saldo_cap_aho-saldo_cap_aho2) var_saldo_cap_aho,sum(saldo_cap_aho2) saldo_cap_aho2,
	sum(saldo_cap_cts) saldo_cap_cts,sum(saldo_cap_cts-saldo_cap_cts2) var_saldo_cap_cts,sum(saldo_cap_cts2) saldo_cap_cts2,
	sum(saldo_cap_dpf) saldo_cap_dpf,sum(saldo_cap_dpf-saldo_cap_dpf2) var_saldo_cap_dpf,sum(saldo_cap_dpf2) saldo_cap_dpf2
	from c
	where C'+cast(@tip_cod as varchar)+'='''+cast(@cod_rel as varchar)+'''
	group by grouping sets (
	(D'+cast(@tip_cod as varchar)+'),
	(D'+cast(@tip_cod2 as varchar)+')
	)
	)
	select iif(D1 is null,0,1) style,isnull(D1,D2) descripcion,
	saldo_cap,iif(var_saldo_cap>0,1,iif(var_saldo_cap>saldo_cap2*-0.05,0,-1)) style_var_saldo_cap,var_saldo_cap,
	null meta_saldo_cap,null var_meta_saldo_cap,
	saldo_cap_aho,iif(var_saldo_cap_aho>0,1,iif(var_saldo_cap_aho>saldo_cap_aho2*-0.05,0,-1)) style_var_saldo_cap_aho,var_saldo_cap_aho,
	null meta_saldo_cap_aho,null var_meta_saldo_cap_aho,
	saldo_cap_cts,iif(var_saldo_cap_cts>0,1,iif(var_saldo_cap_cts>saldo_cap_cts2*-0.05,0,-1)) style_var_saldo_cap_cts,var_saldo_cap_cts,
	saldo_cap_dpf,iif(var_saldo_cap_dpf>0,1,iif(var_saldo_cap_dpf>saldo_cap_dpf2*-0.05,0,-1)) style_var_saldo_cap_dpf,var_saldo_cap_dpf,
	null meta_saldo_cap_dpf,null var_meta_saldo_cap_dpf
	from d
	order by 1 desc,2

  '


	declare @defs as rep.TTHCOLDEF;
    
	insert into @defs
	(TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH)  values
	(1,1,1,'descripcion','Nivel',null,2,1,'string',null,null),
	(2,1,null,'Pasivos','Pasivos',4,null,null,null,null,null),
	(3,1,null,'Ahorros','Ahorros',4,null,null,null,null,null),
	(4,1,null,'CTS','CTS',2,null,null,null,null,null),
	(5,1,null,'DPF','DPF',4,null,null,null,null,null),
	(6,2,2,'saldo_cap','Saldo Pasivo',null,null,null,'number','.0-0','100px'),
	(7,2,3,'var_saldo_cap','Variación Pasivo',null,null,null,'number','.0-0','100px'),
	(8,2,4,'meta_saldo_cap','Meta Var. Pasivo',null,null,null,'number','.0-0','100px'),
	(9,2,5,'var_meta_saldo_cap','Cump. Pasivo',null,null,null,'percent','.0-0','100px'),
	(10,2,6,'saldo_cap_aho','Saldo Ahorro',null,null,null,'number','.0-0','100px'),
	(11,2,7,'var_saldo_cap_aho','Variación Ahorro',null,null,null,'number','.0-0','100px'),
	(12,2,8,'meta_saldo_cap_aho','Meta Var. Ahorro',null,null,null,'number','.0-0','100px'),
	(13,2,9,'var_meta_saldo_cap_aho','Cump. Ahorro',null,null,null,'percent','.0-0','100px'),
	(14,2,10,'saldo_cap_cts','Saldo CTS',null,null,null,'number','.0-0','100px'),
	(15,2,11,'var_saldo_cap_cts','Variación CTS',null,null,null,'number','.0-0','100px'),
	(16,2,12,'saldo_cap_dpf','Saldo DPF',null,null,null,'number','.0-0','100px'),
	(17,2,13,'var_saldo_cap_dpf','Variación DPF',null,null,null,'number','.0-0','100px'),
	(18,2,14,'meta_saldo_cap_dpf','Meta Var. DPF',null,null,null,'number','.0-0','100px'),
	(19,2,15,'var_meta_saldo_cap_dpf','Cump. DPF',null,null,null,'percent','.0-0','100px')

	--select * from @defs
	select rep.FFTHCOLDEF(@defs) result;

  exec(@sql)
END
