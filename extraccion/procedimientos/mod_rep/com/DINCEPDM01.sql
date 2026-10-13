-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-09-01 10:06:43.510000
--EXEC mod_rep.[com].[DINCEPDM01] '7','231','20250831','1'
CREATE PROCEDURE [com].[DINCEPDM01]
@tip_cod int,@cod_rel varchar(20), @fecha date,@pagen int=1      
AS
BEGIN
 set nocount on;
 declare @defs as rep.TTHCOLDEF;  

 SET LANGUAGE spanish; 
 insert into @defs
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values          
 (1,1,1,'HFECPRO','Fecha','string',null,null,null,null),        
 (2,2,1,'rdester','Territorio','string',null,null,null,null),            
 (3,3,1,'rdescor','Corredor','string',null,null,null,null),        
 (4,4,1,'rdesuni','Unidad','string',null,null,null,null),    
 (4,8,1,'RDESUCO','COORDINADOR','string',null,null,null,null),              
 (5,5,1,'hcodsec','Sectorista BT','string',null,null,null,null),        
 (6,6,1,'rdessec','Sectorista','string',null,null,null,null),        
 (7,7,1,'HCODOPE','Operaci n','string',null,null,'#A72C12',null),  
 (7,7,1,'HNROG','# Grupo','string',null,null,'#A72C12',null),  
 (7,7,1,'HMONDESMN','Monto Desembolsado','number','.0-0',null,'#A72C12',null),  
 (7,7,1,'HDOCC','DNI Integrante','string',null,null,'#A72C12',null) 

 select rep.FFTHCOLDEF(@defs) result;

  DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT            
  SET @PageNumber = @pagen              
  SET @RowspPage = 30;      

 declare @result  as table([row] int,    
 HFECPRO date null,rdester varchar(250)null,rdescor varchar(250) null,    
rdesuni varchar(250) null,rdesuco varchar(250) null,hcodsec varchar(250) null,rdessec varchar(250) null,    
HCODOPE INT null,HNROG int null,  
HMONDESMN FLOAT null,HDOCC varchar(250) null
) 


DECLARE @dFechaMax date = (select MAX(HFECPRO) from storage.[com_act].[HDGP001])
select *
into #HINI_PDM
from storage.[com_act].[HDGP001]  --SELECT * FROM #HINI_PDM  HDOCC 
where 
HFECPRO=@dFechaMax and HESTG='ACTIVO' and HESTI='ACTIVO'

;with b as (
	select HNROG,HDNIP,count(*)  C
	from #HINI_PDM
	group by HNROG,HDNIP
	),
	c as (
	select HNROG,max(C) C
	from b
	group by HNROG
	),
	d as (
	select A.HNROG,string_agg('('+isnull(A.HDNIP,'#N/A')+')','-') HDNIP
	from b A
	join c B
	on A.HNROG=B.HNROG and A.C=B.C
	group by A.HNROG
	),
	e as (
	select distinct A.HNROG,HOPER,B.HDNIP,a.HDOCC
	from #HINI_PDM A
	left join d B
	on A.HNROG=B.HNROG
	),
	f as (
	select max(A.HNROG) HNROG,HOPER
	from #HINI_PDM A
	left join d B
	on A.HNROG=B.HNROG
	group by HOPER
	)
	select A.*
	into #GRU_PDM_INI--drop table #GRU_PDM_INI
	from e A
	join f b
	on A.HOPER=B.HOPER and A.HNROG=B.HNROG
	
SELECT * INTO  #VCAH002 FROM storage.[com_act].VCAH002 
;with a as ( 
	select A.HFECPRO,A.HCODOPE,A.HCODMOD,A.HTIPOPE,isnull(A.HSUBTIP,-99) HSUBTIP,A.HSUCCLI,
	case when A.HCODSEC is null or A.HCODSEC='' then '0' else A.HCODSEC end HCODSEC,
	B.HNROG,case when C.RNROG is not null then 0 else 1 end HINDGNUE,A.HMONDESMN,B.HDOCC
	from #VCAH002 A
	left join #GRU_PDM_INI B  --SELECT * FROM #GRU_PDM_INI
	on A.HCODOPE=B.HOPER
	left join (select * from storage.[com_act].RFGP001 where RFECG<=cast(eomonth(@dFechaMax,-1) as date)) C
	on B.HNROG=C.RNROG
	where B.HNROG is not null
	),
b as (
select 
HFECPRO,HCODOPE,HCODSEC,HNROG,HMONDESMN , HDOCC 
from a
)
INSERT INTO @result
select row_number() over(order by a.hcodsec desc) AS [row],HFECPRO,b.rdester,b.rdescor,b.rdesuni,B.RDESUCO,a.hcodsec,b.rdessec,HCODOPE,HNROG,HMONDESMN , HDOCC
from b a
left join storage.ref.wjercor03 b
on a.hcodsec=b.rcodsec and a.hfecpro=b.rfecpro 
where b.rindfec='ACTUAL' and 
            
 case           
 when @tip_cod=20 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')          
 when @tip_cod=19 then cast(B.RCODCOR as nvarchar(10))        
 when @tip_cod=21 then cast(B.RCODGRU as nvarchar(5))              
 when @tip_cod=18 then cast(B.RCODUNI as varchar(50))
 when @tip_cod=17 then cast(B.RCODUCO as varchar(50)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)  
--where hcodsec='TDASE001' 
ORDER BY HNROG ASC

select * from @result ORDER BY [row] asc          
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS              
  FETCH NEXT @RowspPage ROWS ONLY;          
         
  select count(*) as Total from @result      

end
--select * from storage.ref.wjercor03 where rdessec like '%ASENCIOS ESPINOZA%'
