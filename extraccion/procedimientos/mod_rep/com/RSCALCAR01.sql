-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-04-23 11:44:33.043000
--EXEC com.RSCALCAR01 13,'2_1','20200822'      
CREATE PROCEDURE [com].[RSCALCAR01]         
@tip_cod int,@cod_rel varchar(20), @fecha date         
AS             
BEGIN        
 set nocount on;        
 declare @fec varchar(8);        
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)        
 declare @defs as rep.TTHCOLDEF        
 declare @w varchar(10)='11%'        
       
 declare @fec_a varchar(8);      
 select top 1      
  @fec_a=RFECTXT      
 from storage.ref.RCALEN001      
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0      
 order by RFEC desc      
         
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values        
 (1,1,1,'descripcion','Descripción','string',1)        
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values        
 (2,2,1,'mora_real','Mora Real a Hoy','number','.0-0',@w),        
 (3,3,1,'var_mora_real','Variacion de Mora Real Mes','number','.0-0',@w),        
 (4,4,1,'mor_ven_ss1','Mora por vencer en el Mes','number','.0-0',@w),        
 (5,5,1,'num_cli_cm6','Nro de Clientes en Mora','number','.0-0',@w),        
 (6,6,1,'sal_mor_1','Mora >= 1 día','number','.0-0',@w),        
 (7,7,1,'sal_mor_30','Mora > 30 días','number','.0-0',@w),        
 (8,8,1,'sal_prov_ss7','Gasto de Provisiones (Proyectado)','number','.0-0',@w)        
      
 --select * from @defs        
 select rep.FFTHCOLDEF(@defs) result;        
        
 --declare @fec varchar(8)='20200805'        
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF        
        
 insert into @tvars values         
 ('sal_ven',null,null,null,null,null),      
 ('mora_real','isnull(sal_ven,0)+isnull(sal_cas_ss2,0)','mora_real','cal','dp',null),      
 ('sal_prov_ss7','isnull(sal_prov_ss7,0)','sal_prov_ss7',null,null,null),      
 ('sal_cap',null,null,null,null,null),      
 ('num_cli_cm6',null,null,null,null,null),      
 ('sal_mor_1',null,null,null,null,null),      
 ('sal_mor_30',null,null,null,null,null),      
 ('mor_ven_ss1',null,null,null,null,null),      
 ('sal_cas_ss2',null,null,null,null,null)      
       
      
 insert into @tfil        
 values        
 ('todos','fec',''+@fec+'')      
        
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'      
 declare @jer varchar(100);      
 insert into @tfil      
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output      
        
 insert into @tconf        
 values        
 ('level_alias','style')        
        
 --los valores rows y columnas van separados por comas y cada valor entre doble comilla        
 --'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion        
 create table #report_p1 (fila int,parent varchar(10),child varchar(10),style int,descripcion varchar(100),        
 sal_ven float,mora_real float,sal_prov_ss7 float ,sal_cap float ,num_cli_cm6 int,      
 sal_mor_1 float,sal_mor_30 float,mor_ven_ss1 float,sal_cas_ss2 float)      
        
 insert into #report_p1      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1        
      
 delete from @tfil where TKEYFIL='fec'      
 insert into @tfil values ('todos','fec',''+@fec_a+'')       
 delete from @tvars      
 insert into @tvars values ('sal_ven',null,null,null,null,null)      
      
 create table #report_p2 (fila int,parent varchar(10),child varchar(10),style int,descripcion varchar(100),        
 sal_ven_ant float)      
      
 insert into #report_p2      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1        
      
        
 select A.fila,A.parent,A.child,A.style,A.descripcion,        
 A.sal_ven,A.mora_real,A.sal_prov_ss7,A.sal_cap,A.num_cli_cm6,      
 A.sal_mor_1,A.sal_mor_30,A.mor_ven_ss1,A.sal_cas_ss2,      
 isnull(A.mora_real,0)-isnull(B.sal_ven_ant,0) as var_mora_real      
 from #report_p1 A      
 left join #report_p2 B on A.descripcion=B.descripcion       
      
         
END
