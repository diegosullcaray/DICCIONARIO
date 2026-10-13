-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.797000
--exec [com].[RENRCOLAB01]  7,'231','20210301'    
CREATE procedure [com].[RENRCOLAB01]     
@tip_cod int,@cod_rel varchar(20), @fecha date      
AS     
begin    
set nocount on;      
---------------------------------------------------    
declare @defs as rep.TTHCOLDEF;    
 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS)  values      
 (1,1,1,'descripcion','Descripción','string',1,2)      
 insert into @defs       
    (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values      
    (2,1,'numInst','NUMERO DE INSTALADOS',null,2),      
    (3,1,'proInstal','% INSTALADOS',null,2)     
 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS)  values      
 (4,6,1,'TOTAL','T. DE COLABORADORES','number',1,2)      
    
 insert into @defs      
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN)  values      
    (5,2,2,'SI','SI ','number','.0-0',null),      
    (6,3,2,'NO','NO','number','.0-0',null),      
    (7,4,2,'porcentSI','SI','percent','.2-2',null),      
    (8,5,2,'porcentNO','NO','percent','.2-2',null)    
    
 select rep.FFTHCOLDEF(@defs) result;     
    
Declare @FechaMaximaPlanilla date    
set @FechaMaximaPlanilla =(select max(hfecpro) from [storage].[gpr].[HPPC001])    
    
;WITH A AS (    
select 1 style,CASE WHEN @tip_cod=7 THEN 'FINANCIERA CONFIANZA'     
   WHEN @tip_cod=15 THEN b.RDESTER     
   WHEN @TIP_COD=14 THEN B.RDESCOR     
   when @TIP_COD=4 then b.RDESMAT    
   when @tip_cod=16 then B.RDESAGE    
   END as descripcion,    
     case when c.HTIPNUMDOC is not null then COUNT(c.HTIPNUMDOC) else 0 END as SI,    
  count(HNUMDOC) TotalUsuario    
from [storage].[gpr].[HPPC001] a --select*from [storage].[gpr].[HPPC001] where hfecpro='2021-01-31' and hdesage like '%caym%'    
left join storage.ref.VJERCOR02 b on  A.HCODSUC=b.rcodage --select*from storage.ref.VJERCOR02 where rcodage=116    
left join storage.[com_act].VLCAPP001 c on '21'+a.HNUMDOC =c.HTIPNUMDOC    
where hfecpro=@FechaMaximaPlanilla and     
    case when @tip_cod=7 then 1    
         WHEN @tip_cod=15 then rcodter    
   WHEN @TIP_COD=14 then rcodcor    
   when @TIP_COD=4  then rcodmat    
   when @tip_cod=16 then RCODAGEH end =     
  case when @tip_cod=7 then 1 else @cod_rel end       
group by CASE WHEN @tip_cod=7 THEN 'FINANCIERA CONFIANZA'     
   WHEN @tip_cod=15 THEN b.RDESTER     
   WHEN @TIP_COD=14 THEN B.RDESCOR     
   when @TIP_COD=4 then b.RDESMAT    
   when @tip_cod=16 then B.RDESAGE    
   END,c.HTIPNUMDOC    
    
UNION ALL    
    
select  0 style,CASE WHEN @tip_cod=7 THEN      
       CASE WHEN A.HDESTER='OFICINA CORPORATIVA' THEN 'STAFF' else A.HDESTER end     
   WHEN @tip_cod=15 THEN b.RDESCOR     
   WHEN @TIP_COD=14 THEN B.RDESMAT     
   when @TIP_COD=4 then b.RDESAGE    
   when @tip_cod=16 then B.RDESAGE    
   END as descripcion,    
     case when c.HTIPNUMDOC is not null then COUNT(c.HTIPNUMDOC) else 0 END as SI,    
  count(HNUMDOC) TotalUsuario    
from [storage].[gpr].[HPPC001] a --select*from [storage].[gpr].[HPPC001] where hfecpro='2021-01-31' and hdesage like '%caym%'    
left join storage.ref.VJERCOR02 b on  A.HCODSUC=b.rcodage --select*from storage.ref.VJERCOR02 where rcodage=116    
left join storage.[com_act].VLCAPP001 c on '21'+a.HNUMDOC =c.HTIPNUMDOC    
where hfecpro=@FechaMaximaPlanilla and     
    case when @tip_cod=7 then 1    
         WHEN @tip_cod=15 then rcodter    
   WHEN @TIP_COD=14 then rcodcor    
   when @TIP_COD=4  then rcodmat    
   when @tip_cod=16 then RCODAGEH end =     
  case when @tip_cod=7 then 1 else @cod_rel end -- and    c.HTIPNUMDOC is not null  
group by CASE WHEN @tip_cod=7 THEN      
       CASE WHEN A.HDESTER='OFICINA CORPORATIVA' THEN 'STAFF' else A.HDESTER end     
   WHEN @tip_cod=15 THEN b.RDESCOR     
   WHEN @TIP_COD=14 THEN B.RDESMAT     
   when @TIP_COD=4 then b.RDESAGE    
   when @tip_cod=16 then B.RDESAGE    
   END ,c.HTIPNUMDOC    
),    
b as (
	select a.style,a.descripcion,sum(a.SI) as conteo,sum(a.totalusuario) as total   
	from a
	where style not in(1)
	group by a.style,a.descripcion
	),
	d as (
	select a.style,a.descripcion,sum(a.SI) as conteo,sum(a.totalusuario) as total   
	from a
	where style=1
	group by a.style,a.descripcion
	),
	c as (
	select a.style,a.descripcion,a.conteo AS SI,a.total - a.conteo as NO,
		    cast((a.conteo) as float)/cast((a.total) as float) as 'porcentSI' , 
		    cast((a.total - a.conteo) as float)/cast((a.total) as float) 'porcentNO' ,
		    a.total  AS TOTAL
	from d a
	union all
	select a.style,a.descripcion,a.conteo AS SI,a.total - a.conteo as NO,
		    cast((a.conteo) as float)/cast((a.total) as float) as 'porcentSI' , 
		    cast((a.total - a.conteo) as float)/cast((a.total) as float) 'porcentNO' ,
		    a.total  AS TOTAL
	from b a 
	)
	select*from c
/*b as (    
select a.style,a.descripcion,sum(a.SI) as conteo,sum(a.totalusuario) as total     
from a a    
where a.si<>0    
group by a.style,a.descripcion    
),    
c as     
(    
select a.style,a.descripcion,sum(a.SI) as conteo,sum(a.totalusuario) as total     
from a a    
where a.si=0    
group by a.style,a.descripcion    
)    
select a.style,a.descripcion,a.conteo SI,b.total as NO,     
    cast((a.conteo) as float)/cast((a.total + b.total) as float) as 'porcentSI' ,     
    cast((b.total) as float)/cast((a.total + b.total) as float) 'porcentNO' ,    
    a.total + b.total  AS TOTAL    
from b a     
inner join c b on a.descripcion=b.descripcion    and a.style=b.style
order by a.style desc   */ 
END
