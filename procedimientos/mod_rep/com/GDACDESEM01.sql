-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 06:10:35.190000
--exec com.[GDACDESEM01] 7,'231'    
CREATE PROCEDURE [com].[GDACDESEM01]    
@tip_cod int,@cod_rel varchar(20)     
AS    
BEGIN    
SET NOCOUNT ON;      
 declare @fecha date    
 select @fecha=(select max(sfecpro) from storage.[com_act].[SDAF002_SINFAEREACT])  --select distinct (sfecpro) from storage.[com_act].[SDAF002_SINFAEREACT] order by 1 desc    
 declare @fec varchar(8); declare @fec_a varchar(8); declare @fecAnualAnt varchar(20)      
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0) --select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<='2020-08-01' and RDIAFER=0    
     
 select top 1        
  @fec_a=RFECTXT        
 from storage.ref.RCALEN001        
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0        
 order by RFEC desc    
    
 set @fecAnualAnt =(select cast(year(cast(eomonth(@fec,-12) as date)) as varchar(250)))+'12'+'31'    
    
    
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF    
 insert into @tvars    
 values ('mon_desem_sf2_sfe',null,null,null,null,null)    
    
 insert into @tvars    
 values ('num_ope_sf2_sfe',null,null,null,null,null)    
    
 insert into @tfil    
 values    
 --tabla,clave,valores (usar la doble comilla para valores texto/fecha)    
 ('todos','fec','"'+@fec+'"'+'')    
    
 insert into @tconf    
 values    
 ('level_alias','style')    
    
 declare @jer varchar(100)    
 insert into @tfil     
 exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jer output    
    
 insert into @tconf      
 values      
 ('level_alias','style')      
    
 create table #ractAyer (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),mon_desem_ayer float,num_ope_ayer float)      
 insert into #ractAyer  --drop table #ractAyer    
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1      
    
 delete from @tfil where   TKEYFIL='fec'    
 insert into @tfil  values ('todos','fec',''+@fec_a+'')    
    
 create table #ractCierreMes (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),mon_desem_mes float,num_ope_mes float)      
 insert into #ractCierreMes --drop table #ractCierreMes    
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1      
    
 delete from @tfil where   TKEYFIL='fec'    
 insert into @tfil  values ('todos','fec',''+@fecAnualAnt+'')    
     
 create table #ractCierreAnteriorAnual (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),mon_desem_anual float,num_ope_anual float)      
 insert into #ractCierreAnteriorAnual --drop table #ractCierreAnteriorAnual    
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1      
    
 declare @fec_d date=@fec--'20200808'      
 ;with cte_m as (      
  select HTIPCOD,HCODREL,[133] meta_desemb,[5006] meta_ope_desemb    
   from (        
   select HCODVAR,HTIPCOD,iif(HCODREL='231','7',HCODREL) HCODREL,HVALVAR       
   from storage.[com].[VDMCOM01]       
   where HFECPRO=eomonth(@fec_d) and HCODVAR in (133,5006)      
   and HTIPCOD in (@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)))      
   ) as p      
   pivot (      
   max(HVALVAR) FOR HCODVAR IN ([133],[5006])      
   ) as pv      
 ),      
 cte_act_ayer as (      
 select * from #ractAyer     
 ),    
 cte_ant_mesant as (    
 select * from #ractCierreMes    
 ) ,    
 cte_ant_antAnual as (    
 select * from #ractCierreAnteriorAnual    
 )    
 select r.*,m.meta_ope_desemb as 'ope_meta',(r.num_ope_ayer - m.meta_ope_desemb) as 'var_ope_meta', m.meta_desemb as 'mont_meta' ,(r.mon_desem_ayer - m.meta_desemb) as 'var_mont_meta',(r.num_ope_ayer - b.num_ope_mes) as 'var_ope_mes',(r.mon_desem_ayer - b
  
.mon_desem_mes) as 'var_mont_mes',(r.num_ope_ayer - c.num_ope_anual) as 'var_ope_año',(r.mon_desem_ayer - c.mon_desem_anual) as 'var_monto_año'    
 into #result --drop table #result    
 from cte_act_ayer r       
 left join cte_ant_mesant b on b.descripcion=r.descripcion    
 left join cte_ant_antAnual c on c.descripcion=r.descripcion    
 left join cte_m m on iif(r.cod_n2 is null,@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)))=m.HTIPCOD       
 and isnull(r.cod_n2,r.cod_n1)=m.HCODREL      
 order by r.fila      
    
 exec [rep].[FTHEACOLS01] 'DESEMBOLSOS_01';    
 select * from #result order by style desc    
END
