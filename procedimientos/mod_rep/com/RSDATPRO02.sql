-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:32.383000
CREATE procedure [com].[RSDATPRO02]    
@tip_cod int,@cod_rel varchar(20), @fecha date       
as     
begin    
  
 set nocount on;    
 declare @defs as rep.TTHCOLDEF;    
 declare @w varchar(10)='90px';    
 declare @fec varchar(8);    
 declare @fec_a varchar(8);    
    
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)    
     
 select top 1      
  @fec_a=RFECTXT      
 from storage.ref.RCALEN001      
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0      
 order by RFEC desc    
    
 insert into @defs    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS,TSTDEWIDTH)  values    
 (1,1,1,'descripcion','Descripción','string',null,1,2,null),    
 (2,2,1,'mora','Mora','number','.0-0',null,2,@w)    
    
 insert into @defs    
 (TORDER,TLEV,TKEY,TDESC,TCOLS) values    
 (3,1,'m_01','Mora >= 1 día',2),    
 (4,1,'m_02','Var. Mora >= 1 dia',2),    
 (5,1,'m_03','Mora > 30 días',2),    
 (5,1,'m_04','Var. Mora > 30 días',2)    
    
 insert into @defs    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values    
 (3,3,2,'saldo_1','Saldo','number','.0-0',@w),    
 (4,4,2,'ratio_1','Ratio','percent','.2-2',@w),    
 (5,5,2,'saldo_2','Saldo','number','.0-0',@w),    
 (6,6,2,'ratio_2','Ratio','percent','.2-2',@w),    
 (7,7,2,'saldo_3','Saldo','number','.0-0',@w),    
 (8,8,2,'ratio_3','Ratio','percent','.2-2',@w),    
 (9,9,2,'saldo_4','Saldo','number','.0-0',@w),    
 (10,10,2,'ratio_4','Ratio','percent','.2-2',@w)    
    
 select rep.FFTHCOLDEF(@defs) result;    
    
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF      
      
  insert into @tvars values       
  ('sal_ven',null,null,null,null,null),    
  ('sal_mor_1',null,null,null,null,null),    
  ('sal_mor_30',null,null,null,null,null),    
  ('rat_mor_1',null,null,null,null,null),    
  ('rat_mor_30',null,null,null,null,null)    
      
  insert into @tfil values      
  ('todos','fec','"'+concat_ws('","',@fec,@fec_a)+'"')    
    
  --declare @tip_cod int=7,@cod_rel varchar(100)='231'    
  declare @jer varchar(100);    
  insert into @tfil    
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output    
      
 select @jer='"prod_tipo","prod_com"'    
  insert into @tconf      
  values      
  ('level_alias','style') ,
  ('insert_to','#report'),
('fec_corr','true') 
      
  --los valores rows y columnas van separados por comas y cada valor entre doble comilla      
  --'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion      
    
  create table #report (fila int,cod_prod_tipo varchar(100),cod_prod_com int,style int,descripcion varchar(100),    
  rat_mor_1_1 float,rat_mor_1_2 float,    
  rat_mor_30_1 float,rat_mor_30_2 float,    
  sal_mor_1_1 float,sal_mor_1_2 float,    
  sal_mor_30_1 float,sal_mor_30_2 float,    
  sal_ven_1 float,sal_ven_2 float)     
     
	exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1   

  ;with cte_report as (    
  select fila,style,descripcion,    
  sal_ven_2 mora,    
  sal_mor_1_2 saldo_1,rat_mor_1_2 ratio_1,    
  isnull(sal_mor_1_2,0)-isnull(sal_mor_1_1,0) saldo_2,isnull(rat_mor_1_2,0)-isnull(rat_mor_1_1,0) ratio_2,    
  sal_mor_30_2 saldo_3,rat_mor_30_2 ratio_3,    
  isnull(sal_mor_30_2,0)-isnull(sal_mor_30_1,0) saldo_4,isnull(rat_mor_30_2,0)-isnull(rat_mor_30_1,0) ratio_4    
  from #report    
  where descripcion is not null    
  )select * from cte_report    
    
end
