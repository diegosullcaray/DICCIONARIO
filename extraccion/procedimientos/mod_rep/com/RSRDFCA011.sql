-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 05:18:05.037000
--exec [com].[RSRDFCA011] 7,'231'        
CREATE procedure [com].[RSRDFCA011]        
@tip_cod int, @cod_rel varchar(20)        
----------------------------------------------------------------------------------        
as        
begin        
--select*from mod_rep.[piv].[RREGVPIV01] where ralitpiv like '%cli%'        
        
SET NOCOUNT ON;        
declare @fecs varchar(max)declare @fec_a varchar(8);        
declare @defs as rep.TTHCOLDEF;         
        
SET LANGUAGE spanish;        
insert into @defs          
(TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values          
(1,1,2,1,'descripcion','Descripción','string',1)        
        
insert into @defs          
(TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TCOLS,THIDDEN)  values          
(2,2,2,1,'cli_nue','Clientes Nuevos','number',null,null,null),        
(3,3,2,1,'cli_recu','Clientes Recurrentes','number',null,null,null),        
(4,4,2,1,'ticket_nue','Ticket Promedio Cliente Nuevo','number',null,null,null),        
(5,5,2,1,'ticket_recu','Ticket Promedio Cliente Recurrente','number',null,null,null)        
        
 SET LANGUAGE english;          
 select rep.FFTHCOLDEF(@defs) result;          
        
 select @fecs=(select replace(cast(max(hfecpro) as varchar(250)),'-','')  from [storage].[com_act].WACLI001)        
        
 select top 1        
  @fec_a=max(RFECTXT)         
 from storage.ref.RCALEN001        
 where RFEC<=cast(eomonth(@fecs,-1) as date) and RDIAFER=0        
        
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)        
        
        
insert into @tvars        
values ('TickPCliNue', null, null, null, null, null),         
    ('TickPCliRec', null, null, null, null, null),        
    ('cli_nuev', null, null, null, null, null)        
        
insert into @tfil values ('todos', 'fec', ''+@fecs+'')        
insert into @tconf values ('level_alias', 'style')        
        
insert into @tfil        
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output            
        
create table #DES (fila int null, cod_fc varchar(250)null,cod_cter varchar(250)null,style int null,descripcion varchar(max)null,TickPCliNue float null,TickPCliRec float null,cli_nuev float null)        
insert into #DES        
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf        
         
Alter table #Des        
add  CliMes float null        
        
update a set a.CliMes=b.HNUMCLIMES        
from #Des a left join (select* from  storage.com_act.WJAS001 where hfecpro=cast(@fecs as date)) b          
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel        
        
update a set a.CliMes=b.HNUMCLIMES        
from #Des a left join (select* from  storage.com_act.WJAS001 where hfecpro=cast(@fecs as date)) b   
on case when @tip_cod=7 then '21'  
  when @tip_cod=21 then '20'  
  when @tip_cod=20 then '19'  
  when @tip_cod=19 then '18'
  when @tip_cod=18 then '17'
  when @tip_cod=17  then '1' end=b.HTIPCOD and isnull(a.cod_cter,'231')=b.hcodrel         
where a.style<>1        
        
select a.fila,a.cod_fc,a.cod_cter,a.style,a.descripcion,util.FFMTVAR(isnull(166,0),isnull(TickPCliNue,0),null) as ticket_nue, util.FFMTVAR(isnull(166,0),isnull(TickPCliRec,0),null)  as ticket_recu,        
     util.FFMTVAR(isnull(166,0),isnull(cli_nuev,0),null)  as cli_nue,   util.FFMTVAR(isnull(166,0),(a.CliMes - a.cli_nuev),null)   as cli_recu        
from #DES a        
        
end
