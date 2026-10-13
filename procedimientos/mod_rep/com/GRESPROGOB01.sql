-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-12-27 16:46:13.893000
--exec mod_rep.com.GRESPROGOB01 '231','7','20211027',2
CREATE PROCEDURE [com].[GRESPROGOB01]      
@cod_rel varchar(20),@tip_cod varchar(5),@fec date,@var int=1
AS  
BEGIN
SET NOCOUNT ON;

select @fec=max(HFECPRO) from storage.com_act.HCDA001 where HFECPRO<=@fec

declare @defs as rep.TTHCOLDEF; 

create table #PROD(
    HTIPOPE varchar(50),
    HDESPROD varchar(50)
)
insert into #PROD
values('102;123','FAE MUJER')
,('104;123','FAE MUJER')
,('101;112','FAE MYPE')
,('104;122','FAE MYPE') 
,('101;150','REACTIVA')
,('104;150','REACTIVA') 
,('101;200','GARANTIA COVID')
,('102;200','GARANTIA COVID')
,('103;200','GARANTIA COVID')
,('104;200','GARANTIA COVID')

create table #RES(
    ORD int,
    STYLE int,
    HDESPROD varchar(50)
)
insert into #RES
values(1,1,'TOTAL'),(2,0,'FAE MUJER'),(3,0,'FAE MYPE'),(4,0,'GARANTIA COVID'),(5,0,'REACTIVA')


select *
into    #JERCOR 
from    storage.ref.WJERCOR03 
where   RINDFEC='ACTUAL' and case when @tip_cod=20 then cast(RCODTER as varchar)
                                    when @tip_cod=19 then cast(RCODCOR as varchar)
                                    when @tip_cod=21 then cast(RCODGRU as varchar)
                                    when @tip_cod=18 then cast(RCODUNI  as varchar)
                                    when   @tip_cod=7 then cast(RCODFC as varchar) end = @cod_rel 

if @var=1 
begin 

insert into @defs  
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS,TSTDEWIDTH)  values  
 (1,1,1,'HDESPROD','Producto','string',1,3,'200px')  

 insert into @defs  
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TROWS,TCOLS)  values  
 (2,null,1,'SaldoCartera','Saldo Cartera','string',null,1,9),  
 (3,null,1,'StockClientes','Stock Clientes','string',null,1,9),  
 (4,2,2,'HSALTOTAL','Total','number','.0-0',2,null),  
 (5,null,2,'SalVigente','Vigente','string',null,1,2),  
 (6,null,2,'SAl1_30','1 a 30','string',null,1,2),  
 (7,null,2,'Sal31_90','31 a 90','string',null,1,2),  
 (8,null,2,'Sal90_mas','> 90','string',null,1,2),  
 (9,11,2,'HCLITOTAL','Total','number','.0-0',2,null),  
 (10,null,2,'CliVigente','Vigente','string',null,1,2),  
 (11,null,2,'Cli1_30','1 a 30','string',null,1,2),  
 (12,null,2,'Cli31_90','31 a 90','string',null,1,2),  
 (13,null,2,'Cli90_mas','> 90','string',null,1,2),  
 (14,3,3,'HSALVIGENTE','Monto','number','.0-0',null,null),  
 (15,4,3,'HPSALVIGENTE','%','percent','.2-2',null,null),
 (16,5,3,'HSAL1_30','Monto','number','.0-0',null,null),
 (17,6,3,'HPSAL1_30','%','percent','.2-2',null,null),
 (18,7,3,'HSAL31_90','Monto','number','.0-0',null,null),
 (19,8,3,'HPSAL31_90','%','percent','.2-2',null,null),
 (20,9,3,'HSAL90_MAS','Monto','number','.0-0',null,null),
 (21,10,3,'HPSAL90_MAS','%','percent','.2-2',null,null),
 (22,11,3,'HCLIVIGENTE','Nro','number','.0-0',null,null),
 (23,12,3,'HPCLIVIGENTE','%','percent','.2-2',null,null),
 (24,13,3,'HCLI1_30','Nro','number','.0-0',null,null),
 (25,14,3,'HPCLI1_30','%','percent','.2-2',null,null),
 (26,15,3,'HCLI31_90','Nro','number','.0-0',null,null),
 (27,16,3,'HPCLI31_90','%','percent','.2-2',null,null),
 (28,17,3,'HCLI90_MAS','Nro','number','.0-0',null,null),
 (29,18,3,'HPCLI90_MAS','%','percent','.2-2',null,null)
 			
 select rep.FFTHCOLDEF(@defs) result;   

/*SALDOS*/
;with cte_a as(
select      A.*,C.HDESPROD
from		[storage].[com_act].HCDA001 A
join        #PROD C
on          concat(A.HCODMOD,';',A.HTIPOPE)=C.HTIPOPE
join        #JERCOR B
on          A.HFECPRO=B.RFECPRO and iif(A.HASEOPER='' or A.HASEOPER is null ,'0',A.HASEOPER)=B.RCODSEC
where		HFECPRO=@fec 
)
,cte_b as(
select		 isnull(HDESPROD,'TOTAL') HDESPROD1
			,sum(HSALCAPMN) HSALTOTAL
			,sum(case when HINDCAR='VIGENTE' then HSALCAPMN end) HSALVIGENTE
			,sum(case when HINDCAR='VIGENTE' then HSALCAPMN end)/sum(HSALCAPMN) HPSALVIGENTE
			,sum(case when HDIAATR between 1 and 30 then HSALCAPMN end) HSAL1_30
			,sum(case when HDIAATR between 1 and 30 then HSALCAPMN end)/sum(HSALCAPMN) HPSAL1_30
			,sum(case when HDIAATR between 31 and 90 then HSALCAPMN end) HSAL31_90
			,sum(case when HDIAATR between 31 and 90 then HSALCAPMN end)/sum(HSALCAPMN) HPSAL31_90
			,sum(case when HDIAATR > 90 then HSALCAPMN end) HSAL90_MAS
			,sum(case when HDIAATR > 90 then HSALCAPMN end)/sum(HSALCAPMN) HPSAL90_MAS
			,count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC)) HCLITOTAL
			,count (distinct case when HINDCAR='VIGENTE' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLIVIGENTE
			,count (distinct case when HINDCAR='VIGENTE' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLIVIGENTE
			,count (distinct case when HDIAATR between 1 and 30 then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLI1_30
			,count (distinct case when HDIAATR between 1 and 30 then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLI1_30
			,count (distinct case when HDIAATR between 31 and 90 then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLI31_90
			,count (distinct case when HDIAATR between 31 and 90 then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLI31_90
			,count (distinct case when HDIAATR > 90 then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLI90_MAS
			,count (distinct case when HDIAATR > 90 then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLI90_MAS
from        cte_a
group by	grouping sets ((),(HDESPROD))
)
select      A.STYLE style,A.HDESPROD,B.* 
from         #RES A
left join       cte_b B
on          A.HDESPROD=B.HDESPROD1
order by 	HSALTOTAL desc

end

if @var=2
begin
 
insert into @defs  
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS,TSTDEWIDTH)  values  
 (1,1,1,'HDESPROD','Producto','string',1,3,'200px')  

 insert into @defs  
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TROWS,TCOLS)  values  
 (2,null,1,'SaldoCartera','Saldo Cartera','string',null,1,13),  
 (3,null,1,'StockClientes','Stock Clientes','string',null,1,13),  
 (4,2,2,'HSALTOTAL','Total','number','.0-0',2,null),  
 (5,null,2,'SalNormal','Normal','string',null,1,2),  
 (6,null,2,'SalProb.Potenc.','Prob.Potenc.','string',null,1,2),  
 (7,null,2,'SalDeficiente','Deficiente','string',null,1,2),  
 (8,null,2,'SalDudoso','Dudoso','string',null,1,2),  
 (9,null,2,'SalPérdida','Pérdida','string',null,1,2),  
 (10,null,2,'SalSinCalif.','Sin Calif.','string',null,1,2),  
 (11,15,2,'HCLITOTAL','Total','number','.0-0',2,null),  
 (12,null,2,'CliNormal','Normal','string',null,1,2),  
 (13,null,2,'CliProb.Potenc.','Prob.Potenc.','string',null,1,2),  
 (14,null,2,'CliDeficiente','Deficiente','string',null,1,2),  
 (15,null,2,'CliDudoso','Dudoso','string',null,1,2),  
 (16,null,2,'CliPérdida','Pérdida','string',null,1,2),  
 (17,null,2,'CliSinCalif','Sin Calif.','string',null,1,2),  
 (18,3,3,'HSALNORMAL','Monto','number','.0-0',null,null),  
 (19,4,3,'HPSALNORMAL','%','percent','.2-2',null,null),
 (20,5,3,'HSALCPP','Monto','number','.0-0',null,null),
 (21,6,3,'HPSALCPP','%','percent','.2-2',null,null),
 (22,7,3,'HSALDEF','Monto','number','.0-0',null,null),
 (23,8,3,'HPSALDEF','%','percent','.2-2',null,null),
 (24,9,3,'HSALDUD','Monto','number','.0-0',null,null),
 (25,10,3,'HPSALDUD','%','percent','.2-2',null,null),
 (26,11,3,'HSALPER','Monto','number','.0-0',null,null),
 (27,12,3,'HPSALPER','%','percent','.2-2',null,null),
 (28,13,3,'HSALSINCALIF','Monto','number','.0-0',null,null),
 (29,14,3,'HPSALSINCALIF','%','percent','.2-2',null,null),
 (30,15,3,'HCLINORMAL','Nro','number','.0-0',null,null),
 (31,16,3,'HPCLINORMAL','%','percent','.2-2',null,null),
 (32,17,3,'HCLICPP','Nro','number','.0-0',null,null),
 (33,18,3,'HPCLICPP','%','percent','.2-2',null,null),
 (34,19,3,'HCLIDEF','Nro','number','.0-0',null,null),
 (35,20,3,'HPCLIDEF','%','percent','.2-2',null,null),
 (36,21,3,'HCLIDUD','Nro','number','.0-0',null,null),
 (37,22,3,'HPCLIDUD','%','percent','.2-2',null,null),
 (38,23,3,'HCLIPER','Nro','number','.0-0',null,null),
 (39,24,3,'HPCLIPER','%','percent','.2-2',null,null),
 (40,25,3,'HCLISINCALIF','Nro','number','.0-0',null,null),
 (41,26,3,'HPCLISINCALIF','%','percent','.2-2',null,null)
 			
 select rep.FFTHCOLDEF(@defs) result; 

;with cte_a as(
select      A.*,C.HDESPROD
from		[storage].[com_act].HCDA001 A
join        #PROD C
on          concat(A.HCODMOD,';',A.HTIPOPE)=C.HTIPOPE
join        #JERCOR B
on          A.HFECPRO=B.RFECPRO and iif(A.HASEOPER='' or A.HASEOPER is null ,'0',A.HASEOPER)=B.RCODSEC
where		HFECPRO=@fec
)
,cte_b as(
select		isnull(HDESPROD,'TOTAL') HDESPROD1
			,sum(HSALCAPMN) HSALTOTAL
			,sum(case when HCLFSBS='0-Normal' then HSALCAPMN end) HSALNORMAL
			,sum(case when HCLFSBS='0-Normal' then HSALCAPMN end)/sum(HSALCAPMN) HPSALNORMAL
			,sum(case when HCLFSBS='1-Prob.Potenc.' then HSALCAPMN end) HSALCPP
			,sum(case when HCLFSBS='1-Prob.Potenc.' then HSALCAPMN end)/sum(HSALCAPMN) HPSALCPP
			,sum(case when HCLFSBS='2-Deficiente' then HSALCAPMN end) HSALDEF
			,sum(case when HCLFSBS='2-Deficiente' then HSALCAPMN end)/sum(HSALCAPMN) HPSALDEF
			,sum(case when HCLFSBS='3-Dudoso' then HSALCAPMN end) HSALDUD
			,sum(case when HCLFSBS='3-Dudoso' then HSALCAPMN end)/sum(HSALCAPMN) HPSALDUD
			,sum(case when HCLFSBS='4-Pérdida' then HSALCAPMN end) HSALPER
			,sum(case when HCLFSBS='4-Pérdida' then HSALCAPMN end)/sum(HSALCAPMN) HPSALPER
			,sum(case when HCLFSBS='' then HSALCAPMN end) HSALSINCALIF
			,sum(case when HCLFSBS='' then HSALCAPMN end)/sum(HSALCAPMN) HPSALSINCALIF
			,count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC)) HCLITOTAL
			,count (distinct case when HCLFSBS='0-Normal' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLINORMAL
			,count (distinct case when HCLFSBS='0-Normal' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLINORMAL
			,count (distinct case when HCLFSBS='1-Prob.Potenc.' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLICPP
			,count (distinct case when HCLFSBS='1-Prob.Potenc.' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLICPP
			,count (distinct case when HCLFSBS='2-Deficiente' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLIDEF
			,count (distinct case when HCLFSBS='2-Deficiente' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLIDEF
			,count (distinct case when HCLFSBS='3-Dudoso' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLIDUD
			,count (distinct case when HCLFSBS='3-Dudoso' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLIDUD
			,count (distinct case when HCLFSBS='4-Pérdida' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLIPER
			,count (distinct case when HCLFSBS='4-Pérdida' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLIPER
			,count (distinct case when HCLFSBS='' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end) HCLISINCALIF
			,count (distinct case when HCLFSBS='' then concat_ws('-',HPAIS,HTIPDOC,HNUMDOC) end)/(count (distinct concat_ws('-',HPAIS,HTIPDOC,HNUMDOC))*1.) HPCLISINCALIF
from		cte_a A
group by	grouping sets ((),(HDESPROD))
)
select      A.STYLE style,A.HDESPROD,B.* 
from         #RES A
left join       cte_b B
on          A.HDESPROD=B.HDESPROD1
order by 	HSALTOTAL desc
end

END
