-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-14 19:34:19.540000
CREATE PROCEDURE [com].[RSPANSUP002]  
@tip_cod int,@cod_rel nvarchar(10),@carg int,@state nvarchar(100)      
AS      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 SET NOCOUNT ON;      
 -- Result Headers Multiple      
 exec [rep].[FTHEACOLS01] 'PANEL_SUP_02';      
      
 -- Result Set      
 --declare @tip_cod  nvarchar(10)=7,@cod_rel nvarchar(10)='231',@state varchar(100)='REVISTE GRAVEDAD',@carg varchar(100)='TODO';      
 DECLARE @fec nvarchar(10)=(select MAX(HFECPRO) from [storage].[com_act].VDSC001)       
 ;with cte_base as (      
  select A.HAGDEP agencia,A.HTCANAL canal,A.HPERSUP supervisor,A.HCARGO cargo_sup,A.HASESUP asesor,A.HNTOPE producto,A.HDESCLI cliente,A.HMDESOL monto,A.HFECVIS fecha_visita,A.HJUSTIF motivo 
  from [storage].[com_act].VDSC001 A  -- select top 10 * from [storage].[com_act].VDSC001      
   left join storage.[ref].WJERCOR03 B ON A.HCODASE=B.RCODSEC      
   where  case when @tip_cod=20 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')       
     when @tip_cod=19 then cast(B.RCODCOR as nvarchar(10))       
     when @tip_cod=21 then cast(B.RCODGRU as nvarchar(5))      
      when @tip_cod=18 then cast(B.RCODUNI as nvarchar(10)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)      
    and A.HFECPRO=@fec      
    and A.HCARGO = case when @carg=0 then A.HCARGO ELSE (select RDESCAR from  storage.ref.[RCAR001] where RCODCAR=@carg) end      
    and A.HCDEFIN=@state--'REVISTE GRAVEDAD'      
 )select distinct * from cte_base      
      
END
