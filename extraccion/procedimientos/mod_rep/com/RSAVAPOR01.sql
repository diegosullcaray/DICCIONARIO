-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-01 16:26:56.713000
--EXEC com.RSAVAPOR01 7,'231',1,'20220224'        
CREATE PROCEDURE [com].[RSAVAPOR01]           
@tip_cod int,@cod_rel varchar(20),@mode int, @fecha date           
AS        
BEGIN          
 set nocount on;          
 --declare @fecha date='20200916'        
 declare @fin int,@columns varchar(200)        
 declare @i int=0        
 if(@mode=1)        
 begin        
    set @i=1        
 set @fin=1        
 set @columns='"vars","fec"'        
 end        
 else if(@mode in (2,3))        
 begin        
 set @i=iif(@mode=2,1,7)        
 set @fin=iif(@mode=2,6,8)        
 set @columns='"vars","fec","prod_rie"'        
 end        
        
 declare @fec varchar(8);          
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0);        
 declare @fec_a varchar(8);          
 select top 1          
 @fec_a=        
 RFECTXT          
from storage.ref.RCALEN001          
where RFEC<cast(@fec as date) and RDIAFER=0          
order by RFEC desc         
        
 declare @defs as rep.TTHCOLDEF          
 declare @w varchar(10)='90px'          
           
 insert into @defs          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS)  values          
 (1,1,1,'descripcion','Descripción','string',1,3)          
        
 if(@mode=1)        
 begin        
  insert into @defs        
  (TORDER,TLEV,TKEY,TDESC,TFORTYP,TCOLS) values        
  (2,1,'a1','Potencial Ingreso a Mora > 1 (Tramo -30 a 0) al '+@fec,'string','8')        
 end        
 else if(@mode=2)        
 begin        
  insert into @defs        
  (TORDER,TLEV,TKEY,TDESC,TFORTYP,TCOLS) values        
  (3,1,'a2','Créditos FAE MYPE','string','8'),        
  (4,1,'a3','Créditos al Vencimiento','string','8'),        
  (5,1,'a4','Créditos Cuota Libre','string','8'),        
  (6,1,'a5','Créditos Hipotecarios','string','8'),        
  (7,1,'a6','Créditos PDM','string','8'),        
  (8,1,'a7','Créditos Garantía Líquida','string','8')--,        
  --(9,1,'a8','Créditos Cuota BALLOM','string','8'),        
  --(10,1,'a9','Créditos No Minoristas','string','8')        
 end        
 else if(@mode=3)        
 begin        
 insert into @defs        
  (TORDER,TLEV,TKEY,TDESC,TFORTYP,TCOLS) values        
  (9,1,'a8','Créditos Cuota BALLOM','string','8'),        
  (10,1,'a9','Créditos No Minoristas','string','8')        
 end        
        
 declare @head_1 as table(ord int,color nvarchar(20),name nvarchar(200),cols int);        
 declare @head_2 as table(ord int,color nvarchar(20),name nvarchar(200),[key] nvarchar(200),ftype varchar(100),fmode varchar(100),actvar varchar(100));        
 insert into @head_1 values        
 (1,null,'Deteriorado',2),(2,null,'Por Vencer',2),(3,'#049ce4','Deteriorado',2),(4,'#049ce4','Por Vencer',2)        
 insert into @head_2 values        
 (1,null,'Nro Ope','vari_1_'+@fec+':_ord','number','.0-0',null),(2,null,'Saldo Stock S/','vari_2_'+@fec+':_ord','number','.0-0',null),        
 (3,null,'Nro Ope','vari_3_'+@fec+':_ord','number','.0-0',null),(4,null,'Saldo Stock S/','vari_4_'+@fec+':_ord','number','.0-0',null),        
 (5,'#049ce4','Var. Nro Ope','var_nro_ope_det:_ord','variation',null,'vari_1_'+@fec+':_ord-vari_1_'+@fec_a+':_ord'),        
 (6,'#049ce4','Var. Saldo Stock','var_sal_stk_det:_ord','variation',null,'vari_2_'+@fec+':_ord-vari_2_'+@fec_a+':_ord'),        
 (7,'#049ce4','Var. Nro Ope','var_nro_ope_ven:_ord','variation',null,'vari_3_'+@fec+':_ord-vari_3_'+@fec_a+':_ord'),        
 (8,'#049ce4','Var. Saldo Stock','var_sal_stk_ven:_ord','variation',null,'vari_4_'+@fec+':_ord-vari_4_'+@fec_a+':_ord')        
        
         
 while @i<=@fin        
 begin         
 insert into @defs        
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND)        
 select ord+(8*@i),2,'b_'+cast(@i as varchar)+'_'+cast(ord as varchar),name,cols,color from @head_1        
        
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TSTBACKGROUND,TFORTYP,TFORMOD,TACTVAR,TSTDEWIDTH)        
 select         
 ord+(8*@i),ord+(8*@i),        
 3,        
 replace([key],':_ord',IIF(@mode=1,'','_'+cast(@i as varchar))),        
 name,color,ftype,fmode,        
 replace(actvar,':_ord',IIF(@mode=1,'','_'+cast(@i as varchar))),@w         
 from @head_2        
 set @i=@i+1        
 end        
--select * from @defs order by TLEV,TORDER        
 select rep.FFTHCOLDEF(@defs) result;          
        
 --declare @fec varchar(8)='20200805'          
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF          
          
        
  if(@mode in (1,2))        
 begin        
  insert into @tvars values           
 --('nro_ope_sm2',null,'vari_1',null,null,null),        
 -- ('sal_stk_sm2','sal_stk_sm2','vari_2',null,null,null),        
 ('num_ope_det_m30_0',null,'vari_1',null,null,null),        
  ('sal_det_m30_0','sal_det_m30_0','vari_2',null,null,null),   
         
 -- ('nro_ope_sm1',null,'vari_3',null,null,null),        
 -- ('sal_stk_sm1','sal_stk_sm1','vari_4',null,null,null)        
 ('num_ope_man_ven_m30_0',null,'vari_3',null,null,null),   
  ('saldo_man_ven_m30_0','saldo_man_ven_m30_0','vari_4',null,null,null)      
 end        
 else if(@mode=3)        
 begin        
  insert into @tvars values        
  ('nro_ope_1a30_sm100',null,'vari_1',null,null,null),        
  ('sal_stk_1a30_sm100','sal_stk_1a30_sm100','vari_2',null,null,null),        
  ('nro_ope_30a0_sm100',null,'vari_3',null,null,null),        
  ('sal_stk_30a0_sm100','sal_stk_30a0_sm100','vari_4',null,null,null)        
 end        
        
 insert into @tfil          
 values          
 ('todos','fec','"'+CONCAT_WS('","',@fec,@fec_a)+'"')        
        
 if(@mode in (2,3))        
 begin        
 insert into @tfil  values          
 ('todos','prod_rie',IIF(@mode=2,'"1","2","3","4","5","6"','"7","8"'))        
 end        
          
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'        
 declare @jer varchar(100);        
 insert into @tfil        
 --exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output        
 exec piv.GPIVLEV04 @tip_cod,@cod_rel,@jer output        
          
 insert into @tconf          
 values          
 ('level_alias','style')          
          
 --los valores rows y columnas van separados por comas y cada valor entre doble comilla          
 --'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion         
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns=@columns,@config=@tconf--,@show_query=1          
         
           
END
