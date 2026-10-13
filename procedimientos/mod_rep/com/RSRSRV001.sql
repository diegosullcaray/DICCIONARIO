-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-08-31 10:45:38.260000
 
--EXEC [mod_rep].[com].[RSRSRV001] '7','231','20230830'
CREATE procedure [com].[RSRSRV001]                
@tip_cod int, @cod_rel varchar(10),@fec date                
----------------------------------------------------------------------------------                
as                
begin                
SET NOCOUNT ON; 
--declare @tip_cod int = 7, @cod_rel varchar(10) = '231', @fec date ='20230830'                     

 select @fec = RFEC from storage.util.FVECFEC01(@fec,'cmg_6')  
 
 declare @defs as rep.TTHCOLDEF;          
          
  insert into @defs              
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND)  values           
        
 (0,1,1,'EMPRESA','Entidad',1,1,1,'string',null,null,null),         
 (1,2,1,'SERVICIO','Servicio',1,1,NULL,'string',null,null,null),         
 (2,3,1,'CANT_TX_MES_ANT','Cantidad de veces que se cobro la comisión - MES ANTERIOR',1,1,NULL,'number',null,null,null),         
 (3,4,1,'MON_TX_MES_ANT','Ingreso de cobro de costo de recaudación - MES ANTERIOR',1,1,NULL,'number',null,null,null),         
 (4,5,1,'CANT_TX_MES_ACT','Cantidad de veces que se cobro la comisión - MES ACTUAL',1,1,NULL,'number',null,null,'#1f8c26'),         
 (5,6,1,'MON_TX_MES_ACT','Ingreso de cobro de costo de recaudación - MES ACTUAL',1,1,NULL,'number',null,null,'#1f8c26'),        
 (6,7,1,'CANT_TX_ULT_DIA','Cantidad de operaciones dia [Fecha ultimo dia proceso]',1,1,NULL,'number',null,null,'#1f8c26'),         
 (7,8,1,'MON_TX_ULT_DIA','Ingreso de cobro de costo de recaudación dia [Fecha ultimo dia proceso]',1,1,NULL,'number',null,null,'#1f8c26'),         
 (8,9,1,'CANT_TX_ANIO_ACT','Total Acumulado Operaciones año Actual',1,1,NULL,'number',null,null,null),         
 (9,10,1,'MON_TX_ANIO_ACT','Total Acumulado Ingresos año Actual',1,1,NULL,'number',null,null,null)

        
 select rep.FFTHCOLDEF(@defs) result;  

select 1 Style,'1' orden, 'BANTOTAL' EMPRESA,NULL SERVICIO,NULL CANT_TX_MES_ANT,NULL MON_TX_MES_ANT,NULL CANT_TX_MES_ACT,
NULL MON_TX_MES_ACT,NULL CANT_TX_ULT_DIA,NULL MON_TX_ULT_DIA,NULL CANT_TX_ANIO_ACT,NULL MON_TX_ANIO_ACT into #bt
union
select
0 Style,'2' orden, EMPRESA,SERVICIO,CANT_TX_MES_ANT,MON_TX_MES_ANT,CANT_TX_MES_ACT,MON_TX_MES_ACT,CANT_TX_ULT_DIA,MON_TX_ULT_DIA,CANT_TX_ANIO_ACT,MON_TX_ANIO_ACT
from storage.com_pas.wjas005 A
where HFECPRO = @fec and CANAL =1 and  A.HTIPCOD=@tip_cod and A.HCODREL=@cod_rel ORDER BY 1 desc, 3 ASC

select 1 Style,'3' orden, 'APP CORRESPONSAL' EMPRESA,NULL SERVICIO,NULL CANT_TX_MES_ANT,NULL MON_TX_MES_ANT,NULL CANT_TX_MES_ACT,
NULL MON_TX_MES_ACT,NULL CANT_TX_ULT_DIA,NULL MON_TX_ULT_DIA,NULL CANT_TX_ANIO_ACT,NULL MON_TX_ANIO_ACT into #app
union
select 
0 Style,'4' orden, EMPRESA,SERVICIO,CANT_TX_MES_ANT,MON_TX_MES_ANT,CANT_TX_MES_ACT,MON_TX_MES_ACT,CANT_TX_ULT_DIA,MON_TX_ULT_DIA,CANT_TX_ANIO_ACT,MON_TX_ANIO_ACT
from storage.com_pas.wjas005 A
where HFECPRO = @fec and CANAL =91 and  A.HTIPCOD=@tip_cod and A.HCODREL=@cod_rel ORDER BY 1 desc, 3 ASC

select * into #cuadro from #BT
union
select * from #app
 
 --select * from #cuadro
select style,EMPRESA,SERVICIO,CANT_TX_MES_ANT,MON_TX_MES_ANT,CANT_TX_MES_ACT,MON_TX_MES_ACT,CANT_TX_ULT_DIA,MON_TX_ULT_DIA,CANT_TX_ANIO_ACT,MON_TX_ANIO_ACT from #cuadro
order by   orden asc, style desc

drop table  #bt,#app,#cuadro
end
