-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-04-13 15:47:08.227000
-- exec mod_rep.[com].[GRESPDATOS01]  7,'231','20220331'        
CREATE procedure [com].[GRESPDATOS01]         
@tip_cod int,        
@cod_rel varchar(10)  ,    
@fec date       
AS     
begin    
    
SET NOCOUNT ON;    
/*declare  @tip_cod int =15,                                                                          
   @cod_rel varchar(20)='1',                                                                      
   @fec date ='20220331'      
 */    
 declare @defs as rep.TTHCOLDEF;      
insert into @defs          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values          
 (1,1,1,'hfecpro','Fecha',null,null,1,'string',null),       
 (2,2,1,'htipo','Tipo',null,null,null,'string',null),      
 (3,3,1,'HDESPER','Colaborador',null,null,null,'string',null),     
 (4,4,1,'hratio','Ratio',null,null,null,'percent','.2-2'),     
 (5,5,1,'hcindi','Cumple Indicador',null,null,null,'string',null)    
     
  select rep.FFTHCOLDEF(@defs) result;         
    
;with cte_a as (    
select  *     
from storage.[com_act].[HBPDATOS001]    
where hfecpro=@fec    
)     
,cte_b as (    
select a.hfecpro,htipo,a.hcodsec,hratio,hcindi    
from cte_a a    
inner JOIN storage.[ref].WJERCOR01 C on A.hcodsec =  C.RCODSEC and A.HFECPRO=C.RFECPRO and RINDFEC='ACTUAL'     
AND case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(250)),'9999')                   
         when @tip_cod=14 then  cast(c.RCODCOR as nvarchar(250))                
         when @tip_cod=13 then  CAST(c.RCODGRU AS VARCHAR(250))                      
         when @tip_cod=11 then  CAST(c.RCODADM  AS VARCHAR(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)     
),    
cte_c as (    
select * from cte_b  where hcodsec is not null     
)    
select a.hfecpro,htipo,b.HDESPER,hratio,hcindi    
from cte_c a    
left join [storage].[gpr].[VPPH001] b    
on a.hcodsec=b.HCODBT    
    
end
