-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-09-29 16:22:36.900000
--exec mod_rep.com.GRESDESCRE02 '11','TYALG001','20211211'    
CREATE PROCEDURE [com].[GRESDESCRE02]    
    @tip_cod varchar(5),    
    @cod_rel varchar(20),    
    @fec date    
AS    
BEGIN    
    SET NOCOUNT ON;    
    
	declare @fec_cieant date   
    select @fec=max(RFEC) from storage.ref.RCALEN001 where RFEC<=@fec and RDIAFER=0   
	select @fec_cieant=max(RFEC)  from storage.ref.RCALEN001  where   RFEC<@fec and RCIEBT=1   
	
     
    declare @defs as rep.TTHCOLDEF;    
    insert into @defs    
        (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS,TSTDEWIDTH)    
    values    
        (1, 1, 1, 'HDESCRIP', 'Descripción', 'string', 1, 2, '250px')    
    insert into @defs    
        (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN,TCOLS)    
    values    
        (2, null, 1, 'DES_ANT', 'Desembolsos mes anterior', null, null, null, null, 2),    
        (3, null, 1, 'VIS', 'Realizaron visita de seguimiento', null, null, null, null, 3),    
        (4, null, 1, 'CUMP', 'Cumplió destino de crédito', null, null, null, null, 3),    
        --(5, null, 1, 'PCUMP', 'Cumplimiento destino de crédito', null, null, null, null, 2),    
    
        (5, 2, 2, 'HMONDES_ANT', 'Monto S/', 'number', '.0-0', null, null, 1),    
        (6, 3, 2, 'HOPEDES_ANT', 'Nro.', 'number', '.0-0', null, null, 1),    
            
        (7, 4, 2, 'HMONDES_VIS', 'Monto S/', 'number', '.0-0', null, null, 1),    
        (8, 5, 2, 'HOPEDES_VIS', 'Nro.', 'number', '.0-0', null, null, 1),    
        (9, 6, 2, 'HPCUMP_VIS', '%', 'percent', '.2-2', null, null, 1),    
    
        (10, 7, 2, 'HMONDES_CUMP', 'Monto S/', 'number', '.0-0', null, null, 1),    
        (11, 8, 2, 'HOPEDES_CUMP', 'Nro.', 'number', '.0-0', null, null, 1),    
        (12, 9, 2, 'HPCUMP', '%', 'percent', '.2-2', null, null, 1)    
    
    
    select rep.FFTHCOLDEF(@defs) result;    
 
    
    ;with    
		cte_0 as (
		select distinct A.HFECPRO, A.HCODOPE, A.HDESCLI, A.HFECDES, A.HMONDES, A.HCODMON, A.HCODSEC, A.HCODADM, A.HINDCAR, A.HFECVIS, A.HCUMPLDC, A.HDESCRE, E.RDESPROD--, B.HSALCAPMN
		,RCODTER, isnull(RCODGRU,'9999') RCODGRU, RCODCOR, RCODUNI, RCODUCO  from storage.com_act.HDESCRE001 A    
                left join (select * from storage.ref.WJERCOR03 where RFECPRO=@fec)  B 
                on A.HCODSEC=B.RCODSEC    and RINDFEC='ACTUAL'
                left join storage.com_act.RETP001 C    
                on A.HCODMOD=C.RCODMOD and A.HTIPOPE=C.RTIPOPE    
                left join storage.com_act.RETP002 D    
                on A.HCODMOD=D.RCODMOD and A.HTIPOPE=D.RTIPOPE and A.HSUBTIP=D.RSUBTIP    
                left join storage.com_act.RETP003 E    
                on isnull(D.RCODPROD,C.RCODPROD)=E.RCODPROD    
            where A.HFECPRO=@fec_cieant 
		)
        ,cte_a as (    

			select * from cte_0 A
            where A.HFECPRO=@fec_cieant  and case when @tip_cod=21 then cast(RCODGRU as varchar)    
                when @tip_cod=20 then cast(RCODTER as varchar)    
                when @tip_cod=19 then cast(RCODCOR as varchar)    
                when @tip_cod=18 then cast(RCODUNI  as varchar)    
                when @tip_cod=17 then cast(RCODUCO  as varchar)    
                when   @tip_cod=7 then '1' end = case when @tip_cod=7 then '1' else  @cod_rel   end      
        )    
    select HDESCRE, RDESPROD    
            , count(*) HOPEDES_ANT, /*sum(HSALCAPMN) HSALCAPMN,*/ sum(HMONDES)HMONDES_ANT    
            , count(case when HFECVIS is not null then HCODOPE end) HOPEDES_VIS    
            , sum(case when HFECVIS is not null then HMONDES end) HMONDES_VIS    
            , count(case when HCUMPLDC ='Si' then HCODOPE end) HOPEDES_CUMP    
            , sum(case when HCUMPLDC ='Si' then HMONDES end) HMONDES_CUMP    
    into #RES            
    from cte_a    
    group by grouping sets ((),(HDESCRE),(HDESCRE,RDESPROD))    
        
    select *,HOPEDES_CUMP/case when HOPEDES_ANT=0 then null else HOPEDES_ANT*1. end HPCUMP    
            ,HOPEDES_VIS/case when HOPEDES_ANT=0 then null else HOPEDES_ANT*1. end HPCUMP_VIS    
            ,case when HDESCRE is null and RDESPROD is null then 2    
                when HDESCRE is not null and RDESPROD is null then 1    
                else 0 end style    
            ,coalesce(RDESPROD,HDESCRE,'TOTAL') HDESCRIP    
    from #RES    
    order by HDESCRE,RDESPROD    
END
