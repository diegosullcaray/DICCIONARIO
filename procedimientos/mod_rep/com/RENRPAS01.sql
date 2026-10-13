-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-04-04 07:51:45.050000
--exec [com].[RENRPAS01] 7,'231','20220402'    
CREATE procedure [com].[RENRPAS01]     
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
    
  select HUSERBP,  
count( distinct concat(p.HPETDOC,p.HPENDOC) )  as nro_Clientes,     
count(distinct lo.HTIPNUMDOC) as nro_clientes_instalados,    
count ( distinct iif(eomonth(HSBFECH) = eomonth(   iif( DATEPART(dw,  getdate()) = 2 , dateadd(day,-2,  getdate()),dateadd(day,-1,  getdate()))) and concat (p.HSBMOD, HSBTOPE) in ('211','2114','221','222','224','227','228') , concat(p.HPETDOC,p.HPENDOC),null) ) as nro_clientes_apertura,    
count ( distinct iif(eomonth(HSBFECH) = eomonth(   iif( DATEPART(dw,  getdate()) = 2 , dateadd(day,-2,  getdate()),dateadd(day,-1,  getdate())))   
and concat (p.HSBMOD, HSBTOPE) in ('211','2114','221','222','224','227','228')   
and lo.HTIPNUMDOC is not null , concat(p.HPETDOC,p.HPENDOC),null) ) as nro_clientes_apertura_instalados   
into #T1 --drop table #T1  
from storage.[com_pas].[VCPH001] p   -- select * from storage.[com_pas].[VCPH001] where HCODSEC in (1) and HESTADO not in ('INACTIVAS') and HSBSDO1 >0      
left join storage.[com_act].VLCAPP001 lo on lo.HTIPNUMDOC = concat(p.HPETDOC,p.HPENDOC)    
where HCODSEC in (1) and HESTADO not in ('INACTIVAS') and HSBSDO1 >0      
group by HUSERBP   
   
SELECT B.HDESPER descripcion,HUSERBP,  
    nro_Clientes num_cli_pas_enro,  
    nro_clientes_instalados cli_inst_pas_enro,  
    case when nro_Clientes=0 then 0 else CAST(nro_clientes_instalados AS FLOAT) /  nro_Clientes end ratio_t1,  
       nro_clientes_apertura cli_aper_pas_enro,  
    nro_clientes_apertura_instalados cli_aper_insta_pas_enro ,   
    case when nro_clientes_apertura=0 then 0 else CAST(nro_clientes_apertura_instalados AS FLOAT)/ nro_clientes_apertura  end ratio_t2  
FROM   #T1 A  
LEFT JOIN [storage].[gpr].[VPPH001] B -- SELECT TOP 10 * FROM  [storage].[gpr].[VPPH001]   
ON A.HUSERBP=B.HCODBT   
     
end
