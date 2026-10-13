-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.570000
CREATE PROCEDURE [com].[GDMREP001] (@cod_rel varchar(20), @fec date,@tip_cod varchar(10),  @car int=1)
AS
BEGIN
  SET NOCOUNT ON;

  select  @fec=max(HFECPRO)
  from    storage.[com_act].[WCRH001]
  --where   HFECPRO<=@fec

  --1 Codigo BT                
  --2 DNI                
  --3 Codigo Agencia                  
  --4 Codigo Matriz                  
  --5 Codigo Region                  
  --6 Codigo Territorio                  
  --7 FC                 


 if(@tip_cod in('2','1'))
BEGIN
    exec [com].[RSMREP002] @cod_rel, @fec, @tip_cod , @car
  END
ELSE
BEGIN
    exec [com].[RSMREP001] @cod_rel, @fec, @tip_cod , @car
END

END
