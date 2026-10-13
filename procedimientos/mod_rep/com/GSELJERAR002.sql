-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-04 13:23:47.540000
--exec com.[GSELJERAR002] 18,12             
create PROCEDURE [com].[GSELJERAR002]   
@tip_cod int,  @cod_rel varchar(250)          
AS              
BEGIN              
 SET NOCOUNT ON;              
             
    --Headers             
 declare @defs as rep.TTHCOLDEF            
            
 insert into @defs            
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TSTICKY)  values            
 (1,1,1,'','',1)            
            
 select rep.FFTHCOLDEF(@defs) result;            
             
 declare @fecMax date  
 set @fecMax=(select max(rfecpro) from storage.[ref].WJERCOR03)  
  select DISTINCT RDESSEC as 'desc',RCODSEC as id
  from storage.[ref].WJERCOR03  
  where RFECPRO=@fecMax and RINDFEC='ACTUAL' and 
  case when @tip_cod=7 then '1'          
       when @tip_cod=21 then RCODGRU          
       when @tip_cod=20 then RCODTER          
       when @tip_cod=19 then RCODCOR          
       when @tip_cod=18 then RCODUNI END =CASE WHEN @tip_cod=7 THEN '1' ELSE @cod_rel END  
END
