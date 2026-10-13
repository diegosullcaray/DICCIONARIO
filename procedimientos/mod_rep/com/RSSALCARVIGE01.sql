-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-03-06 08:24:03.477000
--exec [com].[RSSALCARVIGE01] 7,'231','20250305'
CREATE PROCEDURE [com].[RSSALCARVIGE01]          
@tip_cod int,@cod_rel varchar(20), @fecha date          
AS          
BEGIN          
 set nocount on;   
--declare @tip_cod int =7,@cod_rel varchar(20)=231, @fecha varchar(8)='20250305'          
  --declare @tip_cod int =7,@cod_rel varchar(20)=231, @fecha varchar(8)='20240710'          
          
 declare @fec varchar(8);          
 declare @defs as rep.TTHCOLDEF;          
 declare @w varchar(10)='10%';          
 declare @fec_a varchar(8);          
          
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)          
          
 select top 1           
@fec_a=RFECTXT           
 from storage.ref.RCALEN001           
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0           
 order by RFEC desc          
          
 --select MONTH(@fec),YEAR(@fec)          
 --if(MONTH(@fec)=8 and YEAR(@fec)=2020)          
--select @fec_a='20200801'          
--SELECT FORMAT(@fec_a,'dd-MMMM') Fecha;          
 SET LANGUAGE spanish;           
 insert into @defs          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS)values          
 (1,1,1,'descripcion','Descripción','string',null,1,2) ,        
 (2,2,1,'sal_cap_ant','Saldo al <br>'+format(cast(@fec_a as date),'dd-MMM'),'number','.0-0',null,2) ,        
 (3,3,1,'sal_cap','Saldo al <br>'+format(cast(@fec as date),'dd-MMM'),'number','.0-0',null,2),         
 (4,4,1,'var_cart','Var.Mes','number','.0-0',null,2),        
 (12,12,1,'HSALMEDMNVIGE','Saldo Medio al <br>'+format(cast(@fec as date),'dd-MMM'),'number','.0-0',null,2)        
         
         
  insert into @defs              
 (TORDER,TLEV,TKEY,TDESC,TCOLS) values               
 (5,1,'meta_','Meta',2),          
 (6,1,'dis_meta_','Distancia Meta',4)          
          
        
 insert into @defs          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN,TCOLS,TSTBACKGROUND,TROWS)values        
 (6,6,2,'meta_var_cart','Var.mes','number','.0-0',@w,null,null,null,null)    ,  
--meta_sal_cart_v2 (7,7,2,'meta_cart','Saldo','number','.0-0',@w,null,null,null,null),     
 (7,7,2,'meta_sal_cart_v2','Saldo','number','.0-0',@w,null,null,null,null),    
        
 (8,8,2,'sem_met_var_cart','','traffic-light',null,null,1,null,null,null),          
  (9,9,2,'dist_met_var_cart','Var mes','number','.0-0',@w,null,2,null,null)  ,   
    
 (10,10,2,'sem_met_cart','','traffic-light',null,null,1,null,null,null),          
 (11,11,2,'dist_met_cart_v2','Saldo','number','.0-0',@w,null,2,NULL,null)   
  
  
       
        
        
         
        
        
         
         
        
 SET LANGUAGE english;           
          
 --select * from @defs          
 select rep.FFTHCOLDEF(@defs) result;          
          
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF          
          
 insert into @tvars values          
 ('sal_vig',null,null,null,null,null)           
          
 insert into @tfil          
 values          
 ('saldos_stock_1','fec',''+@fec+'')--,          
          
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'          
          
 declare @lvl_cfg varchar(max)= '1'          
          
 declare @jer varchar(100);          
 insert into @tfil          
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output,9,@lvl_cfg          
           
          
 insert into @tconf          
 values          
 ('level_alias','style')          
          
           
          
 --create table #ract (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)          
 --insert into #ract          
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
          
          
   --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
          
          
 create table #ract0 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)          
 create table #ract1 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),cod_n3 varchar(100),style int,descripcion varchar(100),sal_cap float)          
   if (@tip_cod <>18) begin   insert into #ract0          
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
  end    if (@tip_cod =18) begin   insert into #ract1          
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
  end    select fila ,cod_n1 ,cod_n2,cast(NULL as varchar) cod_n3 ,style ,descripcion ,sal_cap into #ract   from #ract0   union   select  fila ,cod_n1 ,cod_n2, cod_n3,style ,descripcion ,sal_cap   from #ract1           
          
          
          
          
           
 delete from @tfil where TKEYFIL = 'fec'          
 insert into @tfil values ('saldos_stock_1','fec',''+@fec_a+'')          
          
 --create table #rant (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)          
 --insert into #rant          
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
          
          
 create table #rant0 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)          
 create table #rant1 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),cod_n3 varchar(100),style int,descripcion varchar(100),sal_cap float)          
   if (@tip_cod <>18) begin   insert into #rant0          
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
  end    if (@tip_cod =18) begin   insert into #rant1          
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
  end    select fila ,cod_n1 ,cod_n2, cast(NULL as varchar) cod_n3 ,style ,descripcion ,sal_cap into #rant   from #rant0   union   select  fila ,cod_n1 ,cod_n2,cod_n3 ,style ,descripcion ,sal_cap   from #rant1           
          
          
          
          
          
          
          
          
          
          
          
          
          
 
             
          
--EXEC com.RSSALCAR01 17,'1141','20240709'--UNIDAD DE NEGOCIO          
          
--declare @fec date = '20250305',@tip_cod int=7          
 declare @fec_d date=@fec--'20200808'          
 ;with cte_m as (          
select HTIPCOD,HCODREL,[199] meta_cart,[9000] meta_var_cart          
from (          
select HCODVAR,HTIPCOD,iif(HCODREL='231' AND HTIPCOD = 7,'7',HCODREL) HCODREL,HVALVAR          
from storage.[com].[VDMCOM01]          
where HFECPRO=eomonth(@fec_d) and HCODVAR in (199,9000)          
and HTIPCOD in (@tip_cod, iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)) ,2)          
) as p          
pivot (          
max(HVALVAR) FOR HCODVAR IN ([199],[9000])          
) as pv          
),          
 cte_act as (          
 select * from #ract --drop table #report          
 ),          
 cte_ant as (          
 select * from #rant          
 )          
 select r.*,b.sal_cap sal_cap_ant,         
 m.meta_cart,  
 isnull(r.sal_cap,0)-isnull(m.meta_cart,0) dist_met_cart,  
 m.meta_var_cart,        
 isnull(r.sal_cap,0)-isnull(b.sal_cap,0) var_cart,(isnull(r.sal_cap,0)-isnull(b.sal_cap,0))-isnull(meta_var_cart,0) dist_met_var_cart,        
 case        
when m.meta_cart is null then null        
when r.sal_cap>m.meta_cart then 1        
when r.sal_cap>m.meta_cart*95/100.0 then 0        
else -1 end sem_met_cart,        
case        
when m.meta_var_cart is null then null        
when (isnull(r.sal_cap,0)-isnull(b.sal_cap,0))>isnull(meta_var_cart,0) then 1        
when (isnull(r.sal_cap,0)-isnull(b.sal_cap,0))>isnull(meta_var_cart,0)*95/100.0 then 0        
else -1 end sem_met_var_cart        
        
--,b.descripcion,r.descripcion        
,iif(r.cod_n2 is null,@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)))_tipcod,m.HTIPCOD        
,isnull(isnull(r.cod_n3,r.cod_n2),r.cod_n1)_codrel,m.HCODREL        
--,r.cod_n1,r.cod_n2,r.cod_n3        
 into #PreResult      
 from cte_act r       
 left join cte_ant b on b.descripcion=r.descripcion        
 left join cte_m m on         
 iif(r.cod_n3 is null,  iif(r.cod_n2 is null,@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)))  ,2) =m.HTIPCOD        
 and isnull(isnull(r.cod_n3,r.cod_n2),r.cod_n1)=m.HCODREL        
 order by r.fila        
        
      
        
  select * into #SaldoMedio from storage.com_act.WJAS001 where hfecpro=@fec      


  select * from #PreResult
   
   /*
    select distinct a.*,HSALMEDMNVIGE,isnull(a.sal_cap_ant,0) + isnull(meta_var_cart,0) meta_sal_cart_v2,isnull(sal_cap,0) - (isnull(a.sal_cap_ant,0) + isnull(meta_var_cart,0)) dist_met_cart_v2  from #PreResult a       
 left join #SaldoMedio b      
-- on case when  a.HTIPCOD is null then a._tipcod else a.HTIPCOD end=case when b.HTIPCOD='1' then '2' else b.HTIPCOD end and case when  a.HTIPCOD=7 then '231' else a._codrel end =b.HCODREL     
 on case when  a.HTIPCOD is null then a._tipcod else a.HTIPCOD end=case when b.HTIPCOD='1' then '2' else b.HTIPCOD end and case when  a._tipcod=7 then '231' else a._codrel end =b.HCODREL     
 ORDER BY A.fila ASC      
     */
	 
	  if @tip_cod <>18
	  begin
    select distinct a.*,HSALMEDMNVIGE,isnull(a.sal_cap_ant,0) + isnull(meta_var_cart,0) meta_sal_cart_v2,isnull(sal_cap,0) - (isnull(a.sal_cap_ant,0) + isnull(meta_var_cart,0)) dist_met_cart_v2  
	from #PreResult a       
 left join #SaldoMedio b      
 on case when  a.HTIPCOD is null then a._tipcod else a.HTIPCOD end=case when b.HTIPCOD='1' then '2' else b.HTIPCOD end and case when  a._tipcod=7 then '231' else a._codrel end =b.HCODREL          
 ORDER BY A.fila ASC   
 end

  if @tip_cod= 18
	  begin
    select distinct a.*,HSALMEDMNVIGE,isnull(a.sal_cap_ant,0) + isnull(meta_var_cart,0) meta_sal_cart_v2,isnull(sal_cap,0) - (isnull(a.sal_cap_ant,0) + isnull(meta_var_cart,0)) dist_met_cart_v2  
	from #PreResult a       
 left join #SaldoMedio b      
 on case when  a.HTIPCOD is null then a._tipcod else a.HTIPCOD end=case when b.HTIPCOD='1' then '2' else b.HTIPCOD end and case when  a._tipcod=7 then '231' else a._codrel end =b.HCODREL    
 where a.style in(1,2)
 ORDER BY A.fila ASC   
 end 
           
 drop table #ract,#ract0,#ract1,#rant,#rant0,#rant1,#SaldoMedio ,#PreResult           
           
END
