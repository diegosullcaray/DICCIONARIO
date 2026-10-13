-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-04-29 17:12:03.123000
--exec [com].[RS_AGE_COM_CR_M_03]  7,231,0,'20250331',1 
CREATE  PROCEDURE [com].[RS_AGE_COM_CR_M_03]    
@tip_cod int, @cod_rel varchar(10) , @ver smallint = 0, @fecha date = null, @tipo_ase smallint = 0        
----------------------------------------------------------------------------------                  
as                  
begin                  
SET NOCOUNT ON;  
--declare @tip_cod int = 7, @cod_rel varchar(10) = '231', @fec date ='20230830'                       
   
 declare @fec varchar(10);          
 select @fec=(select max(RFEC) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)          
 declare @defs as rep.TTHCOLDEF;            
            
  insert into @defs                
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND)  values             
          
  
  
 (0,1,1,'descripcion','Entidad',1,1,1,'string',null,null,null),           
 (1,2,1,'TOTBASE','Total Base',1,1,NULL,'number','.0-0',null,null),           
 --(2,3,1,'HINDAGE','Agendados',1,1,NULL,'number','.0-0',null,null),           
 --(3,4,1,'PORC_AG','%Agendados',1,1,NULL,'percent','.2-2',null,null),   
 (4,5,1,'HINDGEST','Gestionados',1,1,NULL,'number','.0-0',null,null),    
 (5,6,1,'POR_GEST','%Gestionados',1,1,NULL,'percent','.2-2',null,null),           
 (6,7,1,'HMEN200','Geolocalizaciones <=200 metros *',1,1,NULL,'number','.0-0',null,'#1f8c26'),   
 (7,8,1,'PORC_MEN200','Geolocalizaciones <=200metros %',1,1,NULL,'percent','.2-2',null,'#1f8c26'),  
 (8,9,1,'HMAY200','Geolocalizaciones >200 metros *',1,1,NULL,'number','.0-0',null,'#FF0000'),           
 (9,10,1,'PORCMAY200','Geolocalizaciones >200metros %',1,1,NULL,'percent','.2-2',null,'#FF0000')   

 select rep.FFTHCOLDEF(@defs) result;    
   
 --declare @tip_cod int=7 , @cod_rel varchar(20)='231', @cf1 varchar(10)='20250327', @ver smallint=1, @fec varchar(10)='20250327'  
 --declare @tip_cod int=18 , @cod_rel varchar(20)='65', @cf1 varchar(10)='20250327', @ver smallint=0, @fec varchar(10)='20250327'  
 declare @select_campo1 varchar(20), @select_campo2 varchar(20), @select_campo3 varchar(20), @select_campo4 varchar(20),  
 @sql varchar(max),@where_campo1 varchar(20), @where_campo2 varchar(20), @grouping1 varchar(20), @grouping2 varchar(20), @where_HMONDESMN varchar(50), @tip_ase  varchar(50) 
  
 if(@tip_cod=7)  
  Begin  
  select @select_campo1 ='_FC.RCODEMP', @select_campo2 ='_FC.RDESEMP',@select_campo3 ='RCODGRU',@select_campo4 ='RDESGRU',  
  @where_campo1 = '1', @grouping1='_FC.RCODEMP', @grouping2='RCODGRU'  
  End  
 else if (@tip_cod=21)  
  Begin  
  select @select_campo1 ='RCODGRU', @select_campo2 ='RDESGRU',@select_campo3 ='RCODTER',@select_campo4 ='RDESTER',  
  @where_campo1 = 'RCODGRU', @grouping1='RCODGRU', @grouping2='RCODTER'  
  End  
 else if (@tip_cod=20)  
  Begin   
  select @select_campo1 ='RCODTER', @select_campo2 ='RDESTER',@select_campo3 ='RCODCOR',@select_campo4 ='RDESCOR',  
  @where_campo1 = 'RCODTER', @grouping1='RCODTER', @grouping2='RCODCOR'  
  End  
 else if (@tip_cod=19)  
  Begin  
  select @select_campo1 ='RCODCOR', @select_campo2 ='RDESCOR',@select_campo3 ='RCODUNI',@select_campo4 ='RDESUNI',  
  @where_campo1 = 'RCODCOR', @grouping1='RCODCOR', @grouping2='RCODUNI'  
  End  
 else if (@tip_cod=18)  
  Begin  
  select @select_campo1 ='RCODUNI', @select_campo2 ='RDESUNI',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',  
  @where_campo1 ='RCODUNI', @grouping1='RCODUNI', @grouping2='RCODSEC'  
  End  
  
  set @where_campo2 =   
 case when @tip_cod=7 then '=1' else   
 case when @cod_rel = '9999' then 'is null' else '='''+@cod_rel+'''' end  
 end  
     

 set @tip_ase =   
 case when @tipo_ase=0 then ''
  when @tipo_ase=1 then ' and hcodsec NOT like ''ASESO%'' '  else ' and hcodsec like ''ASESO%''' end  
   
 
  
    SET @sql  = '  
 ;with base as (  
 select distinct HNUMCON,HFECPRO,HCODSEC, max(HINDBASE)HINDBASE,  max(HINDGEST)HINDGEST, 
 max(HGEOMEN200)HGEOMEN200, max(HINDGEST)HINDGEST2, max(HNUMRCC)HNUMRCC, HDESCLI, max(HSALCAPMN)HSALCAPMN  
 from storage.[com_act].WABDC003 where hfecpro = '''+cast(@fec as varchar)+'''  '+@tip_ase+'  group by HNUMCON,HFECPRO, HDESCLI,HCODSEC     
 ),  
   
 datos as (   
 select   
 isnull('+@select_campo1+',''9999'') id_prin ,max(isnull('+@select_campo2+',''SIN ASIGNAR'')) desc_prin,  
 isnull('+@select_campo3+',''9999'') id_sec ,max(isnull('+@select_campo4+',''SIN ASIGNAR'')) desc_sec '  
  


 
   
 if(@ver=1)  
 begin  
 SET @sql += '  
 , SUM (HSALCAPMN ) TOTBASE 
    , SUM(CASE WHEN HINDGEST =1 THEN  HSALCAPMN  END) HINDGEST  
    , SUM(CASE WHEN HGEOMEN200 =1 THEN  HSALCAPMN  END) HMEN200  
    , SUM(CASE WHEN HGEOMEN200 =0 THEN  HSALCAPMN  END) HMAY200  
    , SUM(CASE WHEN HNUMRCC  =1 THEN  HSALCAPMN  END) reac_1  
    , SUM(CASE WHEN HNUMRCC  =2 THEN  HSALCAPMN  END) reac_2  
    , SUM(CASE WHEN HNUMRCC  =3 THEN  HSALCAPMN  END) reac_3  
    , SUM(CASE WHEN HNUMRCC  =4 THEN  HSALCAPMN  END) reac_4  
    , SUM(CASE WHEN HNUMRCC  =5 THEN  HSALCAPMN  END) reac_5  
 '  
 end  
 else  
 begin  
 SET @sql += '  
 , COUNT(distinct HNUMCON ) TOTBASE 
    , COUNT(DISTINCT CASE WHEN HINDGEST =1 THEN  HNUMCON  END) HINDGEST  
    , COUNT(DISTINCT CASE WHEN HGEOMEN200 =1 THEN  HNUMCON  END) HMEN200  
    , COUNT(DISTINCT CASE WHEN HGEOMEN200 =0 THEN  HNUMCON  END) HMAY200  
    , COUNT(DISTINCT CASE WHEN HNUMRCC  =1 THEN  HNUMCON  END) reac_1  
    , COUNT(DISTINCT CASE WHEN HNUMRCC  =2 THEN  HNUMCON  END) reac_2  
    , COUNT(DISTINCT CASE WHEN HNUMRCC  =3 THEN  HNUMCON  END) reac_3  
    , COUNT(DISTINCT CASE WHEN HNUMRCC  =4 THEN  HNUMCON  END) reac_4  
    , COUNT(DISTINCT CASE WHEN HNUMRCC  =5 THEN  HNUMCON  END) reac_5  
 '  
 end  
  
  
 SET @sql += '  
 from base B  
 left join (values(7,''FINANCIERA CONFIANZA'')) _FC(RCODEMP,RDESEMP) on B.HFECPRO=B.HFECPRO  
 LEFT JOIN storage.[ref].WJERCOR03 C  
 on B.HCODSEC =  C.RCODSEC and B.HFECPRO=C.RFECPRO AND RINDFEC = ''ACTUAL''   
 where   '+@where_campo1+'  '+@where_campo2+'  
     
 group by grouping sets((isnull('+@grouping1+',''9999'')),(isnull('+@grouping1+',''9999''),isnull('+@grouping2+',''9999'')))  
 )  
  
  
 select row_number() over(order by id_prin,id_sec) fila,  
   id_prin,id_sec,  
   case when id_sec is not null then 0 when id_prin is not null then 1 end style,  
   case when id_sec is not null then desc_sec  when id_prin is not null then desc_prin  end descripcion   
   ,TOTBASE,    
   HINDGEST,iif(HINDGEST>0,(HINDGEST/cast(TOTBASE as float)),0) POR_GEST,  
      HMEN200, iif(HMEN200>0, (HMEN200/cast(HINDGEST as float)),0) PORC_MEN200,   
   HMAY200, iif(HMAY200>0, (HMAY200/cast(HINDGEST as float)),0) PORCMAY200,  
      reac_1 , iif(HINDGEST>0,(reac_1/cast(HINDGEST as float)),0) PORC_reac_1,  
      reac_2 , iif(HINDGEST>0,(reac_2/cast(HINDGEST as float)),0) PORC_reac_2,  
      reac_3 , iif(HINDGEST>0,(reac_3/cast(HINDGEST as float)),0) PORC_reac_3,  
      reac_4 , iif(HINDGEST>0,(reac_4/cast(HINDGEST as float)),0) PORC_reac_4,  
      reac_5 , iif(HINDGEST>0,(reac_5/cast(HINDGEST as float)),0) PORC_reac_5       
   from datos    
 '  
  
  --print @sql   
 exec (@sql)  
   
  
end
