-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:32.127000
CREATE PROCEDURE [com].[RSCALCAR02]   
@tip_cod int,@cod_rel varchar(20), @fecha date   
AS       
BEGIN  
 set nocount on;  
 --declare @fecha varchar(8)='20200819'
 declare @fec varchar(8);  
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)  
 declare @defs as rep.TTHCOLDEF  
 declare @w varchar(10)='80px';
   
 insert into @defs  
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS)  values  
 (1,1,1,'descripcion','Descripción','string',1,3)
 
 insert into @defs
 (TORDER,TLEV,TKEY,TDESC,TCOLS) values
 (2,1,'mora','Mora',15),
 (1,2,'tramo_30_0','Tramo -30-0 días',3),
 (2,2,'tramo_1_30','Tramo 1-30 días',3),
 (3,2,'tramo_1_60','Tramo 31-60 días',3),
 (4,2,'tramo_61_90','Tramo 61-90 días',3),
 (5,2,'tramo_91_180','Tramo 91-180 días',3)

 insert into @defs  
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values  
 (2,2,3,'num_cli_cm1','Clientes','number','.0-0',@w),  
 (3,3,3,'sal_cap_sm1','Saldo','number','.0-0',@w),  
 (4,4,3,'ratio_t1','%','percent','.2-2',@w),  
 (5,5,3,'num_cli_cm2','Clientes','number','.0-0',@w),  
 (6,6,3,'sal_cap_sm2','Saldo','number','.0-0',@w),  
 (7,7,3,'ratio_t2','%','percent','.2-2',@w),
 (8,8,3,'num_cli_cm3','Clientes','number','.0-0',@w),  
 (9,9,3,'sal_cap_sm3','Saldo','number','.0-0',@w),  
 (10,10,3,'ratio_t3','%','percent','.2-2',@w),  
 (11,11,3,'num_cli_cm4','Clientes','number','.0-0',@w),  
 (12,12,3,'sal_cap_sm4','Saldo','number','.0-0',@w),  
 (13,13,3,'ratio_t4','%','percent','.2-2',@w),
 (14,14,3,'num_cli_cm5','Clientes','number','.0-0',@w),  
 (15,15,3,'sal_cap_sm5','Saldo','number','.0-0',@w),  
 (16,16,3,'ratio_t5','%','percent','.2-2',@w)     


 --select * from @defs  
 select rep.FFTHCOLDEF(@defs) result;  
  
 --declare @fec varchar(8)='20200805'  
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF  
  
 insert into @tvars values   
 ('sal_cap',null,null,null,null,null),
 ('sal_cap_sm1',null,null,null,null,null),
 ('num_cli_cm1',null,null,null,null,null),
 ('ratio_t1','case when sal_cap>0 then cast(sal_cap_sm1/sal_cap as numeric(17,6)) else 0 end','ratio_t1','cal','dp',null),
 ('sal_cap_sm2',null,null,null,null,null),
 ('num_cli_cm2',null,null,null,null,null),
 ('ratio_t2','case when sal_cap>0 then cast(sal_cap_sm2/sal_cap as numeric(17,6)) else 0 end','ratio_t2','cal','dp',null),
 ('sal_cap_sm3',null,null,null,null,null),
 ('num_cli_cm3',null,null,null,null,null),
 ('ratio_t3','case when sal_cap>0 then cast(sal_cap_sm3/sal_cap as numeric(17,6)) else 0 end','ratio_t3','cal','dp',null),
 ('sal_cap_sm4',null,null,null,null,null),
 ('num_cli_cm4',null,null,null,null,null),
 ('ratio_t4','case when sal_cap>0 then cast(sal_cap_sm4/sal_cap as numeric(17,6)) else 0 end','ratio_t4','cal','dp',null),
 ('sal_cap_sm5',null,null,null,null,null),
 ('num_cli_cm5',null,null,null,null,null),
 ('ratio_t5','case when sal_cap>0 then cast(sal_cap_sm5/sal_cap as numeric(17,6)) else 0 end','ratio_t5','cal','dp',null)
 

 insert into @tfil  
 values  
 ('todos','fec',''+@fec+'')--, 

  
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
 sal_cap float,sal_cap_sm1 float,ratio_t1 float ,sal_cap_sm2 float ,ratio_t2 float,
 sal_cap_sm3 float,ratio_t3 float ,sal_cap_sm4 float ,ratio_t4 float,
 sal_cap_sm5 float,ratio_t5 float)  

 create table #report_p2 (fila int,parent varchar(10),child varchar(10),style int,descripcion varchar(100),  
 num_cli_cm1 int,num_cli_cm2 int,num_cli_cm3 int ,num_cli_cm4 int ,num_cli_cm5 int)
 
 declare @tvars_aux as piv.TPIVVAR;
 insert into @tvars_aux  select * from @tvars where TKEYVAR not like 'num_cli%'
 insert into #report_p1  
 exec piv.GPIVRES01 @variables=@tvars_aux,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1  
 
 delete from @tvars_aux;
 insert into @tvars_aux  select * from @tvars where TKEYVAR like 'num_cli%'
 insert into #report_p2  
 exec piv.GPIVRES01 @variables=@tvars_aux,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1  

 select A.fila,A.parent,A.child,A.style,A.descripcion,  
 A.sal_cap,A.sal_cap_sm1,A.ratio_t1,A.sal_cap_sm2,A.ratio_t2,
 A.sal_cap_sm3,A.ratio_t3,A.sal_cap_sm4,A.ratio_t4,
 A.sal_cap_sm5,A.ratio_t5,
 B.num_cli_cm1,B.num_cli_cm2,B.num_cli_cm3,B.num_cli_cm4,B.num_cli_cm5
 from #report_p1 A
 left join #report_p2 B on A.descripcion=B.descripcion
   
END
