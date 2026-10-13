-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:19.703000
--exec [com].[RSRANKCOM01] 0,0,'2026-04-08'
CREATE procedure [com].[RSRANKCOM01] 
@territorio varchar(250)='0', @corredor varchar(250)='0' , @fecha DATE      
as
begin
SET NOCOUNT ON;   

select  '' json 
select * from storage.[com_act].VRANKCOM01 where cod_uuni not in(126,9999)

end
