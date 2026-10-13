-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-06-12 17:29:30.960000
--exec mod_rep.com.RSTABCOMER 7,'231','20250519'      
CREATE PROCEDURE [com].[RSTABCOMER]      
@tip_cod int,@cod_rel varchar(20),@fec date         
AS            
BEGIN        
 SET NOCOUNT ON;          
--declare @tip_cod int=7, @cod_rel varchar(10)='231',@fec date ='20250516'       
--declare @tip_cod int=21, @cod_rel varchar(10)='1',@fec date ='20250516'       
-----------------------------------------------------------------------      
declare @fecs varchar(max)  ,@fecc varchar(250) ,@fecc1 date    
select * into #FECS  from storage.[util].[FVECFEC01](@fec,'cmg_5,cmg_6')       
    
set @fecc1=(select rfec from #FECS where rord=1)    
set @fecc=(select rfec from #FECS where rord=2)      
select @fecs=string_agg(convert(varchar(10),RFEC,112),',') from #FECS       
      
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                
      
insert into @tvars values                  
--('num_cli_stock',null,null,null,null,null),        
 ('num_enro',null,null,null,null,null),        
('num_usab',null,null,null,null,null)      
      
 insert into @tfil          
 values          
 ('todos','fec',@fecs)--,       
      
 insert into @tconf                  
 values                  
 ('level_alias','style')        
      
declare @jer varchar(100);                  
 insert into @tfil                  
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output          
        
create table #R (      
fila int null,      
cod_fc varchar(250)null,      
cod_ugru varchar(250)null,      
style int null,      
descripcion varchar(250)null,      
/*num_cli_stock_1 int null,      
num_cli_stock_2 int null,  */    
num_enro_1 int null,      
num_enro_2 int null,      
num_usab_1 int null,      
num_usab_2 int null      
)      
insert into #R      
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1      
      
    
alter table #R add num_cli_stock_1 int null,num_cli_stock_2 int null    
    
update a set a.num_cli_stock_1=b.HNUMCLI      
from #R a left join (select* from storage.com_act.WJAS001 where hfecpro=@fecc1) b      
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel  where a.style=1    
    
update a set a.num_cli_stock_2=b.HNUMCLI      
from #R a left join (select* from storage.com_act.WJAS001 where hfecpro=@fecc) b      
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel   where a.style=1    
    
update a set a.num_cli_stock_1=b.HNUMCLI      
from #R a left join (select* from storage.com_act.WJAS001 where hfecpro=@fecc1) b       
on case when @tip_cod=7 then '21'--fc--gru       
 when @tip_cod=21 then '20'--gru-terr      
 when @tip_cod=20 then '19' --terr-corr      
 when @tip_cod=19 then '18'   --corr-uni      
 when @tip_cod=18 then '17' --coordinador    
 when @tip_cod=17 then '1' end=b.HTIPCOD and a.cod_ugru=b.hcodrel --uni-asec      
where a.style<>1      
    
update a set a.num_cli_stock_2=b.HNUMCLI      
from #R a left join (select* from storage.com_act.WJAS001 where hfecpro=@fecc) b       
on case when @tip_cod=7 then '21'--fc--gru       
 when @tip_cod=21 then '20'--gru-terr      
 when @tip_cod=20 then '19' --terr-corr      
 when @tip_cod=19 then '18'   --corr-uni      
 when @tip_cod=18 then '17' --coordinador    
 when @tip_cod=17 then '1' end=b.HTIPCOD and a.cod_ugru=b.hcodrel --uni-asec      
where a.style<>1      
    
declare @head nvarchar(max)      
set @head =    ''   
select @head        
      
select fila,cod_fc,cod_ugru,style,descripcion,num_cli_stock_2,      
num_enro_2,num_enro_2-num_enro_1 var_enro,       
case when num_cli_stock_2=0 then 0 else  cast(num_enro_2 as float)/num_cli_stock_2 end percent_enro,      
(case when num_cli_stock_2=0 then 0 else cast(num_enro_2 as float)/num_cli_stock_2 end ) - (case when num_cli_stock_1=0 then 0 else cast(num_enro_1 as float)/num_cli_stock_1 end ) var_percent_enro,      
num_usab_2,num_usab_2 - num_usab_1 var_usabili,      
case when num_enro_2=0 then 0 else cast(num_usab_2 as float) / num_enro_2 end percent_usa,      
(case when num_enro_2=0 then 0 else cast(num_usab_2 as float) / num_enro_2 end ) - (case when num_enro_1=0 then 0 else cast(num_usab_1 as float) / num_enro_1 end) var_percent_usa,      
case when num_cli_stock_2=0 then 0 else  cast(num_usab_2 as float) / num_cli_stock_2 end percen_usa_cart,      
(case when num_cli_stock_2=0 then 0 else cast(num_usab_2 as float) / num_cli_stock_2 end) - (case when num_cli_stock_1=0 then 0 else cast(num_usab_1 as float) / num_cli_stock_1 end) var_perce_usa_carte      
into #R_M    
from #R      
      
alter table #R_M add met_usa float null,met_usa_cartera float null    
     
update a set a.met_usa=0.205--b.hvalvar              
from #R_M a left join (select* from  [storage].[com].[VDMCOM01] where HCODVAR in(10251) and hfecpro=eomonth(@fecc)) b                
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel    where a.style=1    
    
     
update a set a.met_usa_cartera=0.09--b.hvalvar              
from #R_M a left join (select* from  [storage].[com].[VDMCOM01] where HCODVAR in(10252) and hfecpro=eomonth(@fecc)) b                
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel        
    
update a set a.met_usa=0.205--b.hvalvar              
from #R_M a left join (select* from  [storage].[com].[VDMCOM01] where HCODVAR=10251 and hfecpro=eomonth(@fecc)) b                
on case when @tip_cod=7 then '21'    
  when @tip_cod=21 then '20'    
  when @tip_cod=20 then '19'    
  when @tip_cod=19 then '18'    
  when @tip_cod=18  then '2' end=b.HTIPCOD and isnull(a.cod_ugru,'231')=b.hcodrel              
where a.style<>1      
    
update a set a.met_usa_cartera=0.09--b.hvalvar              
from #R_M a left join (select* from  [storage].[com].[VDMCOM01] where HCODVAR=10252 and hfecpro=eomonth(@fecc)) b                
on case when @tip_cod=7 then '21'    
  when @tip_cod=21 then '20'    
  when @tip_cod=20 then '19'    
  when @tip_cod=19 then '18'    
  when @tip_cod=18  then '2' end=b.HTIPCOD and isnull(a.cod_ugru,'231')=b.hcodrel              
where a.style<>1      
    
select * ,    
case when met_usa=0 then 0 else cast(percent_usa as float)/met_usa end cumplUsa,    
case when case when met_usa=0 then 0 else cast(percent_usa as float)/met_usa end >=1 then 1    
when case when met_usa=0 then 0 else cast(percent_usa as float)/met_usa end < 0.9 then -1    
else 0 end semCumpUsa,    
case when met_usa_cartera=0 then 0 else cast(percen_usa_cart as float)/met_usa_cartera end cumplUsaCar,    
case when case when met_usa_cartera=0 then 0 else cast(percen_usa_cart as float)/met_usa_cartera end >=1 then 1    
when case when met_usa_cartera=0 then 0 else cast(percen_usa_cart as float)/met_usa_cartera end < 0.9 then -1    
else 0 end semCumpUsaCart,@tip_cod htipcod    
from #R_M    
    
drop table #FECS,#R ,#R_M     
    
END
