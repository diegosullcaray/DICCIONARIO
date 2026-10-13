-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-03-30 16:55:49.580000
--exec [com].[RENRPAS01] 15,'1','20210325'  
CREATE procedure [com].[RENRPAS02]   
@tip_cod int,@cod_rel varchar(20), @fecha date    
AS   
begin  
 set nocount on;    
 declare @defs as rep.TTHCOLDEF; declare @fec varchar(8);  
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)  
  
 insert into @defs    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS)  values    
 (1,1,1,'descripcion','Descripción','string',1,2)    
 insert into @defs     
    (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values    
    (2,1,'tcartera','Total Cartera',null,3),    
    (3,1,'tapert','Aperturas',null,3)   
  
 insert into @defs    
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND)  values    
    (4,2,2,'num_cli_pas_enro','Nro Clientes ','number','.0-0',null,1,null),    
    (5,3,2,'cli_inst_pas_enro','Instalados','number','.0-0',null,1,null),    
    (6,4,2,'ratio_t1','% Instalados','percent','.2-2',null,1,'#870800'),    
    (7,5,2,'cli_aper_pas_enro','Nro Clientes Ap.','number','.0-0',null,1,null),    
    (8,6,2,'cli_aper_insta_pas_enro','Instalados Ap.','number','.0-0',null,1,null),    
    (9,7,2,'ratio_t2','% Instalados Ap.','percent','.2-2',null,1,'#870800')  
  
  select rep.FFTHCOLDEF(@defs) result;   
  
   select HSBSUC,
count( distinct concat(p.HPETDOC,p.HPENDOC) )  as nro_Clientes,   
count(distinct lo.HTIPNUMDOC) as nro_clientes_instalados,  
count ( distinct iif(eomonth(HSBFECH) = eomonth(   iif( DATEPART(dw,  getdate()) = 2 , dateadd(day,-2,  getdate()),dateadd(day,-1,  getdate()))) and concat (p.HSBMOD, HSBTOPE) in ('211','2114','221','222','224','227','228') , concat(p.HPETDOC,p.HPENDOC),null) ) as nro_clientes_apertura,  
count ( distinct iif(eomonth(HSBFECH) = eomonth(   iif( DATEPART(dw,  getdate()) = 2 , dateadd(day,-2,  getdate()),dateadd(day,-1,  getdate()))) 
and concat (p.HSBMOD, HSBTOPE) in ('211','2114','221','222','224','227','228') 
and lo.HTIPNUMDOC is not null , concat(p.HPETDOC,p.HPENDOC),null) ) as nro_clientes_apertura_instalados 
into #T1
from storage.[com_pas].[VCPH001] p   -- select * from storage.[com_pas].[VCPH001]
left join storage.[com_act].VLCAPP001 lo on lo.HTIPNUMDOC = concat(p.HPETDOC,p.HPENDOC)  
where HCODSEC in (1,0) and HESTADO not in ('INACTIVAS') and HSBSDO1 >0    
group by HSBSUC

select '0'cod,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=15 then C.RDESTER
			when @tip_cod=14 then C.RDESCOR
			when @tip_cod=4 then c.RDESMAT    END descripcion,
		SUM(A.nro_Clientes)  num_cli_pas_enro,
		sum(a.nro_clientes_instalados)cli_inst_pas_enro,
		cast(sum(a.nro_clientes_instalados) as float) /  SUM(A.nro_Clientes) 'ratio_t1',
		sum(a.nro_clientes_apertura)cli_aper_pas_enro,
		sum(a.nro_clientes_apertura_instalados) cli_aper_insta_pas_enro,
		cast(sum(a.nro_clientes_apertura_instalados) as float) /  SUM(A.nro_clientes_apertura) 'ratio_t2'
			 
from #T1 a
left join storage.ref.vjercor03 C 
on A.HSBSUC =  C.RCODAGE  
WHERE case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(10)),'9999')               
         when @tip_cod=14 then cast(c.RCODCOR as nvarchar(10))            
         when @tip_cod=4 then c.RCODAGE                  
          else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=15 then C.RDESTER
			when @tip_cod=14 then C.RDESCOR
			when @tip_cod=4 then c.RDESMAT   
			 END

UNION ALL
select CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODTER as varchar(250)),'9999')
			when @tip_cod=15 then cast(C.RCODCOR as varchar(250))
			when @tip_cod=14 then cast(C.RCODMAT as varchar(250))
			when @tip_cod=4 then cast(C.RCODAGE as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RDESTER,'SIN ASIGNAR')
			when @tip_cod=15 then C.RDESCOR
			when @tip_cod=14 then C.RDESMAT
			when @tip_cod=4 then C.RDESAGE END,
			SUM(A.nro_Clientes)  nro_Clientes,
		sum(a.nro_clientes_instalados)nro_clientes_instalados,
		cast(sum(a.nro_clientes_instalados) as float) /  SUM(A.nro_Clientes) 'percentInstalado',
		sum(a.nro_clientes_apertura)nro_clientes_apertura,
		sum(a.nro_clientes_apertura_instalados),
		cast(sum(a.nro_clientes_apertura_instalados) as float) /  SUM(A.nro_clientes_apertura) 'percentAperInstalado'

from #T1 a 
left join storage.ref.vjercor03 C
on a.HSBSUC=c.RCODAGE
where  case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(10)),'9999')               
         when @tip_cod=14 then cast(c.RCODCOR as nvarchar(10))            
         when @tip_cod=4 then cast(c.RDESMAT as varchar(250))                  
         when @tip_cod=11 then cast(c.RDESAGE as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODTER as varchar(250)),'9999')
			when @tip_cod=15 then cast(C.RCODCOR as varchar(250))
			when @tip_cod=14 then cast(C.RCODMAT as varchar(250))
			when @tip_cod=4 then cast(C.RCODAGE as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RDESTER,'SIN ASIGNAR')
			when @tip_cod=15 then C.RDESCOR
			when @tip_cod=14 then C.RDESMAT
			when @tip_cod=4 then C.RDESAGE END
   
end
