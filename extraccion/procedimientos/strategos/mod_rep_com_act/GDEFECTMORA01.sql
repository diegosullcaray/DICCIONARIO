-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:42:07.880000

CREATE PROCEDURE [mod_rep_com_act].[GDEFECTMORA01] 
@tipcod int,@codrel varchar(20)
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 declare @fec date  
  
 select @fec=max(HFECPRO) from [storage].[com_act].HCDA001  
  
  exec storage.[com_act].RSRDFCA006 @tipcod,@codrel,@fec  

 --1 Codigo BT  
 --2 DNI  
 --3 Codigo Agencia  
 --4 Codigo Matriz  
 --5 Codigo Region  
 --6 Codigo Territorio  
 --7 FC  
  /*
 if(@tipcod=4)  
 begin  
  exec storage.[com_act].RSRDMA006 @codrel,@fec  
 end  
 if(@tipcod=5)  
 begin  
  exec storage.[com_act].RSRDRA006 @codrel,@fec  
 end  
 if(@tipcod=6)  
 begin  
  exec storage.[com_act].RSRDTA006 @codrel,@fec  
 end  
 if(@tipcod=7)  
 begin  
  exec storage.[com_act].RSRDFCA006 @fec  
 end  
 if(@tipcod=8)  
 begin  
  exec storage.[com_act].RSRDCA006 @codrel,@fec  
 end  
 */
END
