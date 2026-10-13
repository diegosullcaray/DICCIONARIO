-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-02 10:18:47.453000
--exec [com].RSRDFCA007 7,'231'    
CREATE procedure [com].[RSRDFCA007]    
@tip_cod int, @cod_rel varchar(10)    
as    
begin    
 SET NOCOUNT ON;     
 declare @fecha date= '20220531'--(select MAX(hfecpro) from [storage].[com_act].WACLI001)       
 declare @fec varchar(8);      
 declare @defs as rep.TTHCOLDEF;      
 declare @fecAnualAnt varchar(20)     
 set @fecAnualAnt =(select cast(year(cast(eomonth(@fecha,-12) as date)) as varchar(250)))+'12'+'31'    
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)      
    
 declare @fec_a varchar(8);    
 select top 1    
  @fec_a=RFECTXT    
 from storage.ref.RCALEN001    
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0    
 order by RFEC desc    
    
 SET LANGUAGE spanish;    
 insert into @defs      
 (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values      
 (1,1,2,1,'descripcion','Descripción','string',1)      
    
 insert into @defs     
 (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values    
 (2,1,'clienAct','Clientes Activo (Nro)',null,5),    
 (3,1,'ClienNueAct','Clientes Nuevos del Activo (Nro)',null,3),    
 (4,1,'ClienInd','Clientes Individuales (Nro)',null,3),    
 (5,1,'ClienPDM','Clientes PDM (Nro)',null,3)    
    
 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS)  values      
 (6,2,2,'num_cli_act_MA','Clientes al <br>'+format(cast(@fec_a as date),'dd-MMM'),'number','.0-0',null,null),      
 (7,3,2,'meta_cli_act','META','number','.0-0',null,null),    
 (8,4,2,'meta_var_cli_act','Var Meta','number','.0-0',null,null),    
 (9,5,2,'Var_Cli_act_Mes','Variación Mes','number','.0-0',null,null),    
 (10,6,2,'Var_Cli_act_Anio','Variación Año','number','.0-0',null,null),    
 (11,7,2,'num_cli_nuev_MA','Clientes al <br>'+format(cast(@fec_a as date),'dd-MMM'),'number','.0-0',null,null),    
 (12,8,2,'Var_Cli_nuev_Mes','Variación Mes','number','.0-0',null,null),    
 (13,9,2,'Var_Cli_nuev_Anio','Variación Año','number','.0-0',null,null),    
 (14,10,2,'num_cli_ind_MA','Clientes al <br>'+format(cast(@fec_a as date),'dd-MMM'),'number','.0-0',null,null),    
 (15,11,2,'Var_Cli_ind_Mes','Variación Mes','number','.0-0',null,null),    
 (16,12,2,'Var_Cli_ind_Anio','Variación Año','number','.0-0',null,null),    
 (17,13,2,'num_cli_pdm_MA','Clientes al <br>'+format(cast(@fec_a as date),'dd-MMM'),'number','.0-0',null,null),    
 (18,14,2,'Var_Cli_pdm_Mes','Variación Mes','number','.0-0',null,null),    
 (19,15,2,'Var_Cli_pdm_Anio','Variación Año','number','.0-0',null,null)    
    
 SET LANGUAGE english;      
 select rep.FFTHCOLDEF(@defs) result;     
    
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF     
 insert into @tvars values       
 ('num_cli_stock',null,null,null,null,null),    
 ('cli_nuev',null,null,null,null,null),    
 ('cli_ind',null,null,null,null,null),    
 ('cli_pdm',null,null,null,null,null)    
    
 insert into @tfil      
 values      
 ('todos','fec',''+@fec+'')    
    
 declare @jer varchar(100);    
 insert into @tfil    
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output    
    
 insert into @tconf      
 values      
 ('level_alias','style')    
    
 create table #CliAyer (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),num_cli_act_ayer int,num_cli_nuev_ayer int,num_cli_ind_ayer int,num_cli_pdm_ayer int)      
 insert into #CliAyer --drop table #CliAyer   select*from #CliAyer      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1      
    
 delete from @tfil where   TKEYFIL='fec'    
 insert into @tfil  values ('todos','fec',''+@fec_a+'')    
    
 create table #CliMA (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),num_cli_act_MA int,num_cli_nuev_MA int,num_cli_ind_MA int,num_cli_pdm_MA int)        
 insert into #CliMA --drop table  #CliMA    
 Exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1     
    
 delete from @tfil where   TKEYFIL='fec'    
 insert into @tfil  values ('todos','fec',''+@fecAnualAnt+'')     
    
 create table #CliAnual (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),num_cli_act_Anual int,num_cli_nuev_Anual int,num_cli_ind_Anual int,num_cli_pdm_Anual int)        
 insert into #CliAnual --drop table  #CliAnual    
 Exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1     
    
 declare @fec_d date=@fec--'20200808'      
 ;with cte_m as (      
  select HTIPCOD,HCODREL,[165] meta_cli_act    
   from (        
   select HCODVAR,HTIPCOD,iif(HCODREL='231','7',HCODREL) HCODREL,HVALVAR       
   from storage.[com].[VDMCOM01]       
   where HFECPRO=eomonth(@fec_d) and HCODVAR in (165)      
   and HTIPCOD in (@tip_cod,iif(@tip_cod=7,15,iif(@tip_cod=11,2,@tip_cod-1)))      
   ) as p      
   pivot (      
   max(HVALVAR) FOR HCODVAR IN ([165])      
   ) as pv      
 ),    
 cte_cli_ayer as (      
 select * from #CliAyer     
 ),    
 cte_cli_mesant as (    
 select * from #CliMA    
 ) ,    
 cte_cli_antAnual as (    
 select * from #CliAnual    
 )    
 select a.fila,a.cod_n1,a.cod_n2,a.style,a.descripcion, m.meta_cli_act ,(isnull(b.num_cli_act_MA,0) - isnull(m.meta_cli_act,0) ) as meta_var_cli_act, isnull(b.num_cli_act_MA,0)num_cli_act_MA,    
     (isnull(a.num_cli_act_ayer,0) - isnull(b.num_cli_act_MA,0)) as Var_Cli_act_Mes,     
     (isnull(a.num_cli_act_ayer,0) - isnull(c.num_cli_act_Anual,0)) as Var_Cli_act_Anio,    
    
     isnull(b.num_cli_nuev_MA,0)num_cli_nuev_MA,    
     (isnull(a.num_cli_nuev_ayer,0) - isnull(b.num_cli_nuev_MA,0)) as Var_Cli_nuev_Mes,     
     (isnull(a.num_cli_nuev_ayer,0) - isnull(c.num_cli_nuev_Anual,0)) as Var_Cli_nuev_Anio,    
    
     isnull(b.num_cli_ind_MA,0)num_cli_ind_MA,    
     (isnull(a.num_cli_ind_ayer,0) - isnull(b.num_cli_ind_MA,0)) as Var_Cli_ind_Mes,     
     (isnull(a.num_cli_ind_ayer,0) - isnull(c.num_cli_ind_Anual,0)) as Var_Cli_ind_Anio,    
    
     isnull(b.num_cli_pdm_MA,0)num_cli_pdm_MA,    
     (isnull(a.num_cli_pdm_ayer,0) - isnull(b.num_cli_pdm_MA,0)) as Var_Cli_pdm_Mes,     
     (isnull(a.num_cli_pdm_ayer,0) - isnull(c.num_cli_pdm_Anual,0)) as Var_Cli_pdm_Anio    
 from cte_cli_ayer a    
 left join cte_cli_mesant b on b.descripcion=a.descripcion    
 left join cte_cli_antAnual c on c.descripcion=a.descripcion    
 left join cte_m m on iif(a.cod_n2 is null,@tip_cod,iif(@tip_cod=7,15,iif(@tip_cod=11,2,@tip_cod-1)))=m.HTIPCOD       
 and isnull(a.cod_n2,a.cod_n1)=m.HCODREL      
 order by a.fila      
    
 /*select a.fila,a.cod_n1,a.cod_n2,a.style,a.descripcion,isnull(b.num_cli_act_MA,0)num_cli_act_MA,    
     (isnull(a.num_cli_act_ayer,0) - isnull(b.num_cli_act_MA,0)) as Var_Cli_act_Mes,     
     (isnull(a.num_cli_act_ayer,0) - isnull(c.num_cli_act_Anual,0)) as Var_Cli_act_Anio,    
    
     isnull(b.num_cli_nuev_MA,0)num_cli_nuev_MA,    
     (isnull(a.num_cli_nuev_ayer,0) - isnull(b.num_cli_nuev_MA,0)) as Var_Cli_nuev_Mes,     
     (isnull(a.num_cli_nuev_ayer,0) - isnull(c.num_cli_nuev_Anual,0)) as Var_Cli_nuev_Anio,    
    
     isnull(b.num_cli_ind_MA,0)num_cli_ind_MA,    
     (isnull(a.num_cli_ind_ayer,0) - isnull(b.num_cli_ind_MA,0)) as Var_Cli_ind_Mes,     
     (isnull(a.num_cli_ind_ayer,0) - isnull(c.num_cli_ind_Anual,0)) as Var_Cli_ind_Anio,    
    
     isnull(b.num_cli_pdm_MA,0)num_cli_pdm_MA,    
     (isnull(a.num_cli_pdm_ayer,0) - isnull(b.num_cli_pdm_MA,0)) as Var_Cli_pdm_Mes,     
     (isnull(a.num_cli_pdm_ayer,0) - isnull(c.num_cli_pdm_Anual,0)) as Var_Cli_pdm_Anio    
    
 from #CliAyer a     
 left join #CliMA b    
 on a.descripcion=b.descripcion    
 left join #CliAnual c    
 on c.descripcion=a.descripcion    
 */    
end
