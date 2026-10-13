-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-10 10:53:12.290000
  --EXEC [mod_rep].[com].[RSAPPUSO001] '18','55'

CREATE PROCEDURE [com].[RSAPPUSO001]   
@tip_cod int,@cod_rel varchar(20)  
AS         
begin        
 set nocount on;    
    
         
 declare @defs as rep.TTHCOLDEF;    
  
 --declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int)        
 --(0,null,'Descripción',null)     
        
 --insert into @defs         
 --(TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)         
 --select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,null,IIF(ord=0,1,0)        
 --from @head        
       
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values        
 (1,1,2,'descripcion','Descripción',null,null,1,'string',null),    
  
 --(3,3,2,'PRE_EVALUACION','Pre Evaluación (por DNI)',null,null,null,'number','.0-0'),    
 (4,4,2,'SOLICITUD','Solicitud(Instancias Ingresadas)*',null,null,null,'number','.0-0'),    
 (5,5,2,'EVAL_PROPUESTA','Evaluacion/ Propuesta**',null,null,null,'number','.0-0'),   
 (6,6,2,'APROBACION','Envío a Aprobación',null,null,null,'number','.0-0'),   
 (7,7,2,'COMITE','Comité de Creditos Movil',null,null,null,'number','.0-0'),   
 (8,8,2,'FIRMA_ELECTRONICA','Firma Electrónica',null,null,null,'number','.0-0'),   
 (9,9,2,'DESEMBOLSO','Operaciones Desembolsadas',null,null,null,'number','.0-0'),    
        
 (10,10,2,'SOLICITUD_efec','Efec Solicitud',null,null,null,'percent','.2-2'),      
 (11,11,2,'EVAL_PROPUESTA_efec','Efec E/P',null,null,null,'percent','.2-2'),   
 (12,12,2,'APROBACION_efec','Efec Envío a Aprobación',null,null,null,'percent','.2-2'),   
 (13,13,2,'COMITE_efec','Efec Comité',null,null,null,'percent','.2-2'),  
 (14,14,2,'FIRMA_ELECTRONICA_efec','Efec Firma Electrónica',null,null,null,'percent','.2-2'),   
 (15,15,2,'DESEMBOLSO_FIRMA_efec','Desem por Firma Electrónica',null,null,null,'percent','.2-2')  
   
  
  select rep.FFTHCOLDEF(@defs) result;      
   
 -- declare @tip_cod int=7 , @cod_rel varchar(20)='231', @cf1 varchar(10)='2021-08-04'  
 -- declare @tip_cod int=11 , @cod_rel varchar(20)='TSBEG002', @cf1 varchar(10)='2021-11-23'  
 declare @select_campo1 varchar(20), @select_campo2 varchar(20), @select_campo3 varchar(20), @select_campo4 varchar(20),  
 @sql varchar(max),@where_campo1 varchar(20), @where_campo2 varchar(20), @grouping1 varchar(20), @grouping2 varchar(20), @where_HMONDESMN varchar(50)  
  
 -- condiciones según los filtros  
 if(@tip_cod=7)  
  Begin  
  select @select_campo1 ='_FC.RCODEMP', @select_campo2 ='_FC.RDESEMP',@select_campo3 ='RCODTER',@select_campo4 ='RDESTER',  
  @where_campo1 = '1', @grouping1='_FC.RCODEMP', @grouping2='RDESGRU02'  
  End  
 else if (@tip_cod=20)  
  Begin  
  select @select_campo1 ='RCODTER', @select_campo2 ='RDESTER',@select_campo3 ='RCODCOR',@select_campo4 ='RDESCOR',  
  @where_campo1 = 'RCODTER', @grouping1='RCODTER', @grouping2='RDESGRU02'  
  End  
 else if (@tip_cod=19)  
  Begin  
  select @select_campo1 ='RCODCOR', @select_campo2 ='RDESCOR',@select_campo3 ='RCODGRU',@select_campo4 ='RDESGRU',  
  @where_campo1 = 'RCODCOR', @grouping1='RCODCOR', @grouping2='RDESGRU02'  
  End  
 else if (@tip_cod=21)  
  Begin  
  select @select_campo1 ='RCODGRU', @select_campo2 ='RDESGRU',@select_campo3 ='RCODADM',@select_campo4 ='RDESADM',  
  @where_campo1 = 'RCODGRU', @grouping1='RCODGRU', @grouping2='RDESGRU02'  
  End   
 else if (@tip_cod=18)  
  Begin  
  select @select_campo1 ='RCODUNI', @select_campo2 ='RDESUNI',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',  
  @where_campo1 ='RCODUNI', @grouping1='RCODUNI', @grouping2='RDESGRU02'  
  End  
 else if (@tip_cod=17)  
  Begin  
  select @select_campo1 ='RCODUCO', @select_campo2 ='RDESUCO',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',  
  @where_campo1 ='RCODUCO', @grouping1='RDESUCO', @grouping2='RDESGRU02'  
  End   
     
 
   
  set @where_campo2 =   
 case when @tip_cod=7 then '=1' else   
 case when @cod_rel = '9999' then 'is null' else '='''+@cod_rel+'''' end  
 end  
  
 --select * from storage.com_act.WUSUAPP001  
 --calculo del reporte  
  set @sql = '  
 ;with datos as (   
 select    
  RDESPROD,RDESGRU02,  
  sum(SOLICITUD) SOLICITUD,   
  sum(EVAL_PROPUESTA) EVAL_PROPUESTA,  
  sum(APROBACION) APROBACION,  
  sum(COMITE) COMITE,  
  SUM(CONTRATACION_E) FIRMA_ELECTRONICA,  
  sum(DESEMBOLSO) DESEMBOLSO,  
  
  case when sum(SOLICITUD) = 0 then 0 else sum(cast(DESEMBOLSO as float)) / sum(cast(SOLICITUD as float)) END SOLICITUD_efec,        
  case when sum(SOLICITUD) = 0 then 0 else sum(cast(EVAL_PROPUESTA as float)) / sum(cast(SOLICITUD as float)) END EVAL_PROPUESTA_efec,       
  case when sum(SOLICITUD) = 0 then 0 else sum(cast(APROBACION as float)) / sum(cast(SOLICITUD as float)) END APROBACION_efec,  
  case when sum(COMITE) = 0 then 0 else sum(cast(DESEMBOLSO as float)) / sum(cast(COMITE as float)) END  COMITE_efec,  
  case when sum(SOLICITUD) = 0 then 0 else sum(cast(CONTRATACION_E as float)) / sum(cast(SOLICITUD as float)) END FIRMA_ELECTRONICA_efec,--firma/solicitud  
  case when sum(DESEMBOLSO) = 0 then 0 else sum(cast(CONTRATACION_E as float)) / sum(cast(DESEMBOLSO as float)) END  DESEMBOLSO_FIRMA_efec  
       
       
  
  from storage.com_act.WUSUAPP001 A  
  left join (values(7,''FINANCIERA CONFIANZA'')) _FC(RCODEMP,RDESEMP) on A.HFECPRO=A.HFECPRO  
  left JOIN storage.[ref].WJERCOR03 D  
  on A.HUSER =  D.RCODSEC and A.HFECPRO=D.RFECPRO   
  WHERE '+@where_campo1+'  '+@where_campo2+'  
  
  group by grouping sets(('+@grouping1+',RDESGRU02),('+@grouping1+',RDESGRU02,RDESPROD))  
  
  --group by grouping sets((_FC.RCODEMP,A.RDESGRU02),(_FC.RCODEMP,A.RDESGRU02,A.RDESPROD)) -- 7,231     
  --group by grouping sets((D.RCODTER,A.RDESGRU02),(D.RCODTER,A.RDESGRU02,A.RDESPROD)) --15,2  
  --group by grouping sets((D.RCODCOR,A.RDESGRU02),(D.RCODCOR,A.RDESGRU02,A.RDESPROD)) -- 14 1  
  --group by grouping sets((D.RCODGRU,A.RDESGRU02),(D.RCODGRU,A.RDESGRU02,A.RDESPROD)) -- 13  
  --group by grouping sets((D.RCODADM,A.RDESGRU02),(D.RCODADM,A.RDESGRU02,A.RDESPROD)) --  11  
)  
      select row_number() over(order by RDESGRU02,RDESPROD) fila,  
      case when rdesprod is not null then 0 when RDESGRU02 is not null then 1 end style,  
   case when rdesprod is not null then rdesprod  when RDESGRU02 is not null then RDESGRU02  end descripcion,  
   --PRE_EVALUACION,  
   SOLICITUD,EVAL_PROPUESTA,APROBACION,FIRMA_ELECTRONICA,DESEMBOLSO,   
   SOLICITUD_efec,EVAL_PROPUESTA_efec,APROBACION_efec,FIRMA_ELECTRONICA_efec,DESEMBOLSO_FIRMA_efec,  
   COMITE,COMITE_efec  
   from datos ORDER BY RDESGRU02,RDESPROD '  
  
  
  -- print @sql  
  
 exec (@sql)  
          
      
end
