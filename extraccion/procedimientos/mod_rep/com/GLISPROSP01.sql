-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-03-18 16:37:48.647000
--exec [com].[GLISPROSP01] '00245492'      
CREATE PROCEDURE [com].[GLISPROSP01]      
@cod_rel varchar(20)       
AS        
BEGIN        
 SET NOCOUNT ON;        
       
    --Headers       
 declare @defs as rep.TTHCOLDEF      
      
 insert into @defs      
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TSTICKY,TFORTYP,TFORMOD,TSTBACKGROUND)  values      
 (1,1,1,'HFECPRO','Fecha',null,'string',null,null),      
 (2,1,2,'HAPENOMB','Nombre Cliente',null,'string',null,null),      
 (3,1,3,'HNUMDOC','Dni',1,'string',null,null),      
 (4,1,4,'HNUMRUC','Ruc',null,'string',null,null),      
 (5,1,5,'HDIREC','Dirección',null,'string',null,null),      
 (7,1,7,'HDEPA','Departamento',null,'string',null,null),      
 (8,1,8,'HPROV','Provincia',null,'string',null,null),    
 (9,1,9,'HDISTR','Distrito',null,'string',null,null),    
 (10,1,10,'HCELULAR','Celular',null,'string',null,null),    
 (11,1,11,'HDCIIU','CIIU',null,'string',null,null),   
 (12,1,12,'HDESASE','Asesor',null,'string',null,null),   
 (13,1,13,'HDESTER','Territorio',null,'string',null,null),     
 (14,1,14,'HDESCOR','Corredor',null,'string',null,null),     
 (15,1,15,'HDESAGE','Agencia',null,'string',null,null),     
 (16,1,16,'HAPERTCTA','Apertura de Cta',null,'string',null,null),    
 (17,1,17,'HGEOLATI','Latitud',null,'string',null,null),      
 (18,1,18,'HGEOLON','Longitud',null,'string',null,null),   
 (19,1,19,'HNOMCOM','Nombre Comercial',null,'string',null,null),     
 (20,1,20,'HINSTALAD','Instalado',null,'string',null,null),    
 (21,1,21,'HESTDCORE','Status',null,'string',null,null),      
 (22,1,22,'HZONA','Zona',null,'string',null,null),      
 (23,1,23,'HPROSPEC','Prospecto',null,'string',null,null),  
 (24,1,24,'HTAPERCC','Apert.Cta',null,'string',null,null),    
 (25,1,25,'HCONSRUC','Consulta RUC',null,'string',null,null)  , ---
 (26,1,26,'HCONSRCC','Consulta RCC',null,'string',null,null),
 (27,1,27,'HCONSLNE','Consulta Listas Negras',null,'string',null,null),
 (28,1,28,'HFOTNEGO','Foto Negocio',null,'string',null,null),
 (29,1,29,'HCTALICEF','Cuenta Licencia',null,'string',null,null),
 (30,1,30,'HLICFUNCI','Licencia Funcionamiento',null,'string',null,null),
 (31,1,31,'HCANACAP','Canal Captación',null,'string',null,null),
 (32,1,32,'HMESINST','Mes Instalado',null,'string',null,null),
 (33,1,33,'HTIPAGENT','Tipo Agente',null,'string',null,null),
 (34,1,34,'HCODSECASIG','BT Asignado',null,'string',null,null),
 (35,1,35,'HASEASIG','Asesor Asignado',null,'string',null,null),
 (36,1,36,'HVINFAMI','Vinculo Familiar',null,'string',null,null),
 (37,1,37,'HTIPVINC','Tipo VinculoFirmo Adendo',null,'string',null,null),
 (38,1,38,'HIDCORRES','ID Corresponsal',null,'string',null,null)
   
       
   /*    
 insert into @defs      
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TSTICKYEND,TFORTYP,TSTDEWIDTH,TACTVAR,TACTICON)  values      
 (13,1,13,'action_01','Act. Encuesta',1,'button','40px','nom_cli-fec_pro-fini_vig-ffin_vig-hor_pro-cta_cli-cod_ope-tip_ope-num_doc-tip_doc-cod_pais-reaccion','launch')      
  */    
 --select * from @defs      
 select rep.FFTHCOLDEF(@defs) result;      
      
 --declare @cod_rel varchar(10)='00245492';      
 with a as (      
  select HFECPRO,HAPENOMB,HNUMDOC ,HNUMRUC ,  
    HCELULAR ,HDIREC ,HDISTR ,HPROV ,HDEPA ,  
       HDCIIU ,HDESASE ,HDESCOR ,HDESAGE ,HGEOLATI ,HGEOLON ,HNOMCOM ,HDESTER ,  
       HAPERTCTA ,HESTDCORE ,HINSTALAD ,HFECINSTAL ,HZONA ,  
       HPROSPEC ,HFIRMADN  ,
	   ------HCONSLNE,HFOTNEGO,HLICFUNCI,HMESINST,HVINFAMI,HTIPVINC,HIDCORRES

	   HTAPERCC,HCONSRUC,HCONSRCC,HCONSLNE,HFOTNEGO,HCTALICEF,HLICFUNCI,
	   HCANACAP,HMESINST,HTIPAGENT,HCODSECASIG,HASEASIG,HVINFAMI,HTIPVINC,
	   HIDCORRES
  from STORAGE.[com_act].[HCMC002]     
  where HCODSEC in (select HCODBT        
  from  storage.[gpr].[VPPH001]          
  where @cod_rel=HNUMDOC)        
 )      
 select  ---TOP 5     
 HFECPRO,HAPENOMB,HNUMDOC ,HNUMRUC ,  
    HCELULAR ,HDIREC ,HDISTR ,HPROV ,HDEPA ,  
       HDCIIU ,HDESASE ,HDESCOR ,HDESAGE ,HGEOLATI ,HGEOLON ,HNOMCOM ,HDESTER ,  
       HAPERTCTA ,HESTDCORE ,HINSTALAD ,HFECINSTAL ,HZONA ,  
       HPROSPEC ,HFIRMADN,
	   ------------
	   HTAPERCC,HCONSRUC,HCONSRCC,HCONSLNE,HFOTNEGO,HCTALICEF,HLICFUNCI,
	   HCANACAP,HMESINST,HTIPAGENT,HCODSECASIG,HASEASIG,HVINFAMI,HTIPVINC,
	   HIDCORRES  
 from a A      
 order by A.HFECPRO DESC      
      
END
