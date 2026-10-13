-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.647000

CREATE PROCEDURE [com].[GLISAUTO01]
@tip_cod int,
@cod_rel varchar(20),
@c_aut int,
@aut int
AS  
BEGIN  
 SET NOCOUNT ON; 
	--declare @tip_cod int=7,@cod_rel varchar(20)='231',@c_aut int=0,@aut bit=2; 
	declare @i int=3;
	declare @defs as rep.TTHCOLDEF
    
	if(@c_aut in (1,2))
	begin
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC,TCOLS,TSTICKY)  values
		(0,0,'lim_01','',4,null),
		(0,0,'lim_02','Limite',1,1),
		(0,0,'lim_03','12.00%',2,null),
		(0,0,'lim_04','7.00%',4,null),
		(0,0,'lim_05',IIF(@c_aut=1,'0.33%','0.30%'),4,null),
		(0,0,'lim_06',IIF(@c_aut=1,'6.00%','6.10%'),4,null),
		(0,0,'lim_07','',5,null)

	end

	insert into @defs
	(TORDER,TLEV,TKEY,TDESC,TCOLS, TROWS, TISDATA,  TSTICKY, TFORTYP)  values
	(1,1,'nom_ter','Territorio',1,2,1,null,'string'),
	(2,1,'nom_reg','Región',1,2,2,null,'string')

	if(@c_aut not in (0))
	begin 
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC,TCOLS, TROWS, TISDATA,  TSTICKY, TFORTYP)  values
		(3,1,'nom_age','Agencia',1,2,@i,null,'string')
		set @i=@i+1;
	end 


	insert into @defs
	(TORDER,TLEV,TKEY,TDESC,TCOLS, TROWS, TISDATA,  TSTICKY, TFORTYP)  values
	(4,1,'usu_bt','Usuario BT',1,2,@i,null,'string'),
	(5,1,'nom_per','Nombre',1,2,@i+1,1,'string'),
	(6,1,'carg_per','Cargo',1,2,@i+2,null,'string')
	set @i=@i+3;

	if(@c_aut in (1,3))
	begin 
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC,TCOLS, TROWS, TISDATA, TFORTYP)  values
		(7,1,'fec_ini','Fecha de Ingreso',1,2,@i,'string')
		set @i=@i+1;
	end
	if(@c_aut=2)
	begin
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC,TCOLS, TROWS, TISDATA, TFORTYP,TFORMOD)  values
		(8,1,'mr_prop','%MR PROPIA Ago-19',1,2,@i,'percent','.1-1')
		set @i=@i+1;
	end
	if(@c_aut=3)
	begin
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC,TCOLS, TROWS, TISDATA, TFORTYP)  values
		(9,1,'ant_fc','Antiguedad FC',1,2,@i,'string'),
		(10,1,'cum_ant','Cumple Antiguedad',1,2,@i+1,'string')
		set @i=@i+2
	end

	insert into @defs
	(TORDER,TLEV,TKEY,TDESC,TCOLS, TROWS, TISDATA, TFORTYP)  values
	(11,1,'mr_apro','% MR APROBADOR',IIF(@c_aut in (0,1,2),4,5),1,null,'string'),
	(12,1,'c3m_apro','C3M (N°) APROBADOR',IIF(@c_aut in (0,1,2),4,3),1,null,'string'),
	(13,1,'c12m_apro','C12M (N°) APROBADOR',IIF(@c_aut in (0,1,2),4,3),1,null,'string')
	
	if(@c_aut in (0,1,2))
	begin
		 insert into @defs
		(TORDER,TLEV,TKEY,TDESC, TISDATA, TFORTYP,TFORMOD,TSTDEWIDTH)  values
		(19,2,'mes_1','Mes 1',@i,'percent','.1-1','80px'),
		(20,2,'mes_2','Mes 2',@i+1,'percent','.1-1','80px'),
		(21,2,'mes_3','Mes 3',@i+2,'percent','.1-1','80px'),
		(22,2,'prom_mr','AVG % MR APROB',@i+3,'percent','.1-1','80px'),
		(23,2,'mes_4','Mes 1',@i+4,'percent','.1-1','80px'),
		(24,2,'mes_5','Mes 2',@i+5,'percent','.1-1','80px'),
		(25,2,'mes_6','Mes 3',@i+6,'percent','.1-1','80px'),
		(26,2,'c3m_prom','Acum. 3 Mes',@i+7,'percent','.1-1','80px'),
		(27,2,'mes_7','Mes 1',@i+8,'percent','.1-1','80px'),
		(28,2,'mes_8','Mes 2',@i+9,'percent','.1-1','80px'),
		(29,2,'mes_9','Mes 3',@i+10,'percent','.1-1','80px'),
		(30,2,'c12m_prom','Acum. 3 meses',@i+11,'percent','.1-1','80px')
		set @i=@i+12
	end
	if(@c_aut in (1,2))
	begin
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC, TISDATA, TFORTYP,TSTDEWIDTH,TROWS)  values
		(14,1,'filtro_mr','Filtro MR',@i,'string','100px',2),
		(15,1,'seg','Segmentación',@i+1,'string','120px',2),
		(16,1,'aut_sug','Autonomía Sugerida',@i+2,'string','120px',2),
		(17,1,'aut','Autonomía WF',@i+3,'string','80px',2),
		(18,1,'coment','Comentarios',@i+4,'string','120px',2)
		set @i=@i+5
	end
	if(@c_aut in (0))
	begin
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC, TISDATA, TFORTYP,TFORMOD,TSTDEWIDTH,TROWS)  values
		(14,1,'ag_sup','Nro AG Superan Limite',@i,'number','.0-0','80px',2),
		(15,1,'ag_tot','Nro AG Total',@i+1,'number','.0-0','80px',2),
		(16,1,'pag_sup','% AG Superan Limites',@i+2,'number','.0-0','80px',2),
		(17,1,'result','Resultado',@i+3,'string',null,'80px',2)
		set @i=@i+4
	end

	if(@c_aut=3)
	begin
		insert into @defs
		(TORDER,TLEV,TKEY,TDESC, TISDATA, TFORTYP,TFORMOD,TSTDEWIDTH)  values
		(16,2,'mes_1','Mes 1',@i,'percent','.1-1','80px'),
		(17,2,'mes_2','Mes 2',@i+1,'percent','.1-1','80px'),
		(18,2,'mes_3','Mes 3',@i+2,'percent','.1-1','80px'),
		(19,2,'mes_4','Mes 4',@i+3,'percent','.1-1','80px'),
		(20,2,'tend_3m','Tendencia 3M',@i+4,'string',null,'80px'),
		(21,2,'mes_5','Mes 1',@i+5,'percent','.1-1','80px'),
		(22,2,'mes_6','Mes 2',@i+6,'percent','.1-1','80px'),
		(23,2,'mes_7','Mes 3',@i+7,'percent','.1-1','80px'),
		(24,2,'mes_8','Mes 1',@i+8,'percent','.1-1','80px'),
		(25,2,'mes_9','Mes 2',@i+9,'percent','.1-1','80px'),
		(26,2,'mes_10','Mes 3',@i+10,'percent','.1-1','80px')
		set @i=@i+11

		insert into @defs
		(TORDER,TLEV,TKEY,TDESC, TISDATA, TFORTYP,TSTDEWIDTH,TROWS)  values
		(14,1,'res','Resultado',@i,'string','100px',2),
		(15,1,'niv_aut','Nivel de Autonomía',@i+1,'string','120px',2)

	end


	--select * from @defs
	select rep.FFTHCOLDEF(@defs) result;

	-- data
	IF(@c_aut=0)
	BEGIN
		;with a as (
		SELECT	*
		FROM	[com].[FTRAGEASE](@tip_cod,@cod_rel,1)
		),
		b as (
			select   HCODSUC,HCODBT
			from [storage].[gpr].[HPPC001]
			where HFECPRO=(select MAX(HFECPRO) from [storage].[gpr].[HPPC001])
		),
		c as (
			select  D.*
			from [storage].[com_act].[BTPCRT001] D
			left join b B on B.HCODBT=D.SCODSEC
			join a A on A.RCODAGE=IIF(@tip_cod=7,'-1',B.HCODSUC)
			--where case when D.SAUTSUG!='Sin Autonomia' then 1 when D.SAUTSUG='Sin Autonomia' then 0 end=
			--case when @aut=2 then case when D.SAUTSUG!='Sin Autonomia' then 1 when D.SAUTSUG='Sin Autonomia' then 0 end else @aut end
		)
		SELECT 
			[SDTER] nom_ter,
			case when SCARGO='GERENTE TERRITORIAL' then null else [SDREG] end nom_reg
			,[SCODSEC] usu_bt
			,[SDCODSEC] nom_per
			,[SCARGO] carg_per
			,[SRMAPROB1] mes_1
			,[SMAPROB2] mes_2
			,[SMRAPROB3] mes_3
			,[SAVGMRAPROB] prom_mr
			,[SC3M1] mes_4
			,[SC3M2] mes_5
			,[SC3M3] mes_6
			,[SAVGC3M] c3m_prom
			,[SC12M1] mes_7
			,[SC12M2] mes_8
			,[SC12M3] mes_9
			,[SAVGC12M] c12m_prom
			,[SAGSUP] ag_sup
			,[SAGTOT] ag_tot
			,[SPAGSUP] pag_sup
			,[SRESUL] result
		  FROM c

	END
	IF(@c_aut=1)
	BEGIN 
		;with a as (
		SELECT	*
		FROM	[com].[FTRAGEASE](@tip_cod,@cod_rel,1)
		),
		b as (
			select   HCODSUC,HCODBT
			from [storage].[gpr].[HPPC001]
			where HFECPRO=(select MAX(HFECPRO) from [storage].[gpr].[HPPC001])
		),
		c as (
			select  D.*
			from storage.[com_act].BTPCRA001 D
			left join b B on B.HCODBT=D.SCODSEC
			join a A on A.RCODAGE=IIF(@tip_cod=7,'-1',B.HCODSUC)
			where case when D.SAUTSUG!='Sin Autonomia' then 1 when D.SAUTSUG='Sin Autonomia' then 0 end=
			case when @aut=2 then case when D.SAUTSUG!='Sin Autonomia' then 1 when D.SAUTSUG='Sin Autonomia' then 0 end else @aut end
		)
		select 
		STERRITORIO nom_ter,
		SREGION nom_reg,
		SAGENCIA nom_age,
		SCODSEC usu_bt,
		SNOMADM nom_per,
		CARGO_ADM carg_per,
		FECHA_INGRESO fec_ini,
		SMRAPROB1 mes_1,
		SMRAPROB2 mes_2,
		SMRAPROB3 mes_3,
		SAVGMRAPROB prom_mr,
		SC3M1 mes_4,
		SC3M2 mes_5,
		SC3M3 mes_6,
		SC3MACUM c3m_prom,
		SC12M1 mes_7,
		SC12M2 mes_8,
		SC12M3 mes_9,
		SC12MACUM c12m_prom,
		SFILMR filtro_mr,
		Segmentacion seg,
		SAUTSUG aut_sug,
		SAUTWF aut,
		SCOMENT coment
		from c
	END 
		
	IF(@c_aut=2)
	BEGIN
		;with a as (
		SELECT	*
		FROM	[com].[FTRAGEASE](@tip_cod,@cod_rel,1)
		),
		b as (
			select   HCODSUC,HCODBT
			from [storage].[gpr].[HPPC001]
			where HFECPRO=(select MAX(HFECPRO) from [storage].[gpr].[HPPC001])
		),
		c as (
			select  D.*
			from storage.[com_act].BTPCRC001 D -- coordinador
			left join b B on B.HCODBT=D.SCODSEC
			join a A on A.RCODAGE=IIF(@tip_cod=7,'-1',B.HCODSUC)
			where case when D.SAUTSUG!='Sin Autonomia' then 1 when D.SAUTSUG='Sin Autonomia' then 0 end=
			case when @aut=2 then case when D.SAUTSUG!='Sin Autonomia' then 1 when D.SAUTSUG='Sin Autonomia' then 0 end else @aut end
		)
		select 
		TERRITORIO nom_ter,
		REGION nom_reg,
		AGENCIA nom_age,
		SCODSEC usu_bt,
		SNOMCOOR nom_per,
		SCARCOOR carg_per,
		SMRPROP mr_prop,
		SMR1 mes_1,
		SMR2 mes_2,
		SMR3 mes_3,
		SAVGMRAPRO prom_mr,
		SC3M1 mes_4,
		SC3M2 mes_5,
		SC3M3 mes_6,
		SC3MACUM c3m_prom,
		SC12M1 mes_7,
		SC12M2 mes_8,
		SC12M3 mes_9,
		SC12MACUM c12m_prom,
		SFILMR filtro_mr,
		Segmentacion seg,
		SAUTSUG aut_sug,
		SAUTWF aut,
		Comentarios coment
		from c
	END
		
	IF(@c_aut=3)
	BEGIN
		;with a as (
		SELECT	*
		FROM	[com].[FTRAGEASE](@tip_cod,@cod_rel,1)
		),
		b as (
			select   HCODSUC,HCODBT
			from [storage].[gpr].[HPPC001]
			where HFECPRO=(select MAX(HFECPRO) from [storage].[gpr].[HPPC001])
		),
		c as (
			select  D.*
			from storage.[com_act].BTPCRS001 D -- sectorista
			left join b B on B.HCODBT=D.SCODSEC
			join a A on IIF(@tip_cod=2,A.RCODSEC,cast(A.RCODAGE as varchar))=IIF(@tip_cod=7,'-1',IIF(@tip_cod=2,B.HCODBT,cast(B.HCODSUC as varchar)))
			--join a A on A.RCODAGE=IIF(@tip_cod=7,'-1',B.HCODSUC)
			where D.Resultado=case 
			when @aut=2 then D.Resultado
			when @aut=1 then 'Autonomia' 
			when @aut=0 then 'Sin Autonomia' end
		)
		select 
		TERRITORIO nom_ter,
		REGION nom_reg,
		AGENCIA nom_age,
		SCODSEC usu_bt,
		SDCODSEC nom_per,
		SCARSEC carg_per,
		[Fecha de ingreso] fec_ini,
		SANTIGFC ant_fc,
		SCUMPANTIGFC cum_ant,
		SMR1 mes_1,
		SMR2 mes_2,
		SMR3 mes_3,
		SMR4 mes_4,
		SMRTEND3M tend_3m,
		SC3M1 mes_5,
		SC3M2 mes_6,
		SC3M3 mes_7,
		SC12M1 mes_8,
		SC12M2 mes_9,
		SC12M3 mes_10,
		Resultado result,
		SNIVAUT [desc],
		Resultado res,
		SNIVAUT niv_aut
		from c
	END
	
END;
