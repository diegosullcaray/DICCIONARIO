-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-05-11 08:12:28.787000
--exec com.[GSELJERAR001]         
CREATE PROCEDURE [com].[GSELJERAR001]         
AS          
BEGIN          
 SET NOCOUNT ON;          
         
    --Headers         
 declare @defs as rep.TTHCOLDEF        
        
 insert into @defs        
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TSTICKY)  values        
 (1,1,1,'','',1)        
        
 select rep.FFTHCOLDEF(@defs) result;        
        
  /*      
 with a as (        
  select * from   [storage].[ref].[REGCIIU002]        
 )        
 select         
 A.HDESGIRO [desc],        
 A.HDESGIRO id,        
 A.HSECECO sec_eco        
 from a A        
  */      
         
  select 'Instalado'  [desc],'Instalado' id INTO #ESTCORRES union all      
  select 'Derivado contrato SO','Derivado contrato SO'  union all      
  select 'Esperando respuesta asesor','Esperando respuesta asesor'  union all      
  select 'Duplicado','Duplicado'  union all      
  select 'Contrato firmado - pendiente enrolamiento','Contrato firmado - pendiente enrolamiento'  union all      
  select 'Desistio','Desistio'  union all      
  select 'Solicito cancelacion','Solicito cancelacion'  union all      
  select 'No Califica','No Califica'       
        
  select distinct RDESTER [desc], RDESTER id,'Territorio' sec_eco from storage.ref.vjercor03 union all      
  select distinct RDESCOR, RDESCOR,'Corredor' from storage.ref.vjercor03 union all      
  select distinct RDESMAT [desc], RDESMAT id,'Matriz' sec_eco from storage.ref.vjercor03 union all      
  select distinct RDESAGE [desc], RDESAGE id,'Agencia' sec_eco from storage.ref.vjercor03 union all      
  select distinct RDESDEP,RDESDEP,'Departamento'  from [storage].[ref].[REUBI01]  union all      
  select distinct RDESPRO,RDESPRO,'Provincia'  from [storage].[ref].[REUBI01]  where    RDESPRO <>'' union all      
  select distinct RDESDIS,RDESDIS,'Distrito'  from [storage].[ref].[REUBI01] where    RDESDIS <>'' UNION ALL      
  select [desc],id,'ESTCOR' from #ESTCORRES   UNION ALL      
  select distinct /*HNOMTITCB,*/HNOMTITCB,CAST(HIDTITCB AS VARCHAR(250)) HIDTITCB,'Corresponsales'  from storage.com_act.HCMC001 WHERE EOMONTH(HFECPRO)=EOMONTH(GETDATE()) and HESTADOTX='VIGENTE' union all    
  select distinct HNOMBREPTO,HNOMBREPTO /*CAST(HCODIGOCB AS VARCHAR(250))*/ ,'NombCom' from storage.com_act.HCMC001 WHERE EOMONTH(HFECPRO)=EOMONTH(GETDATE()) and HESTADOTX='VIGENTE' union all    
  select distinct RDESCIIU,RCODCIIU,'ciiu'  from [storage].[ref].[REGCIIU003]    
END
