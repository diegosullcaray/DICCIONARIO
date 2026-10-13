-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:42:08.683000
--exec mod_rep_com_act.HTTPTRACE 7,'231'   
CREATE procedure [mod_rep_com_act].[HTTPTRACE]
--@tip_cod int, @cod_rel varchar(50)  
as  
begin
  SET NOCOUNT ON;
  -- create table #cab2 (result nvarchar(max))     
  --INSERT INTO #cab2     
  --exec [mod_rep].[rep].[FTHEACOLS01] 'HTTPTRACE_01';     
  --select result from #cab2     
  --select request as pagina,count(request) as numVisi from  storage.dbo.HTTPTRACE group by request order by 2 desc  

  select request as pagina, count(request) as numVisi
  from strategos.sys_met.HTTPTRACE
  where  request not like '/login%' and request not like '/selector%'
    and request not like '/session%'
  group by request
  order by 2 desc
end
