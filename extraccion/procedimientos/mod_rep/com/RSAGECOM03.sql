-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-09-09 15:48:42.123000
 --exec [com].[RSAGECOM02]  7,'231','20240622',1,2,0,1,'GORRITI'  
 --exec [com].[RSAGECOM02]  7,'231','20240904',1,0,0,'0'  
CREATE  PROCEDURE [com].[RSAGECOM03]    
--@tip_cod int,@cod_rel varchar(20),@fec date,@fuga int,@prop int,@pagen int=1,@nom varchar(150)='0'   
@tip_cod int,@cod_rel varchar(20),@fec date,@mode int,@fuga int,@prop int,@nom int=0  
  
AS              
BEGIN              
 SET NOCOUNT ON;      
 declare @pagen int=1   
   -- declare @tip_cod int=7 , @cod_rel varchar(250)='231', @fec date='20240625',@pagen int=1 ,@nom varchar(150)='' ,@prop int =0,@fuga int =1  
 declare @cf as date   
      
  select @cf=@fec   
   
  
  --SELECT DATEPART(month, HFECCANC),HFECCANC from storage.com_act.WABDC004 where   DATEPART(month, HFECCANC)  = 6  
  
    
  declare @headers varchar(max)  
  select @headers  ='[   
   { "label":"Cuenta AUTO","key":"HCTACLI","cellStyle":{"text-align":"right","max-width":"60px","min-width":"60px","width":"50px"}},  
   { "label":"Nom Cliente","key":"HDESCLI","cellStyle":{"text-align":"left","min-width":"250px"}},  
   { "label":"Nivel de Riesgo","key":"HNVELRIE","cellStyle":{"text-align":"left","min-width":"100px"}},  
   { "label":"Origen de la base","key":"HINGRESO","cellStyle":{"text-align":"center","min-width":"130px"}},  
   { "label":"Fecha Cancelado","key":"HFECCANC","cellStyle":{"text-align":"center","min-width":"80px"}},  
   { "label":"s/. Desemb Cancelado","key":"HMONDESMN","cellStyle":{"text-align":"right","min-width":"80px"},"format":{"type":"integer"}},  
   { "label":"Agendado","key":"HINDAGE","cellStyle":{"text-align":"center","min-width":"80px"}},   
   { "label":"Gestionado","key":"HINDGEST","cellStyle":{"text-align":"center","min-width":"80px"}},     
   { "label":"Desembolsado","key":"HINDDESB","cellStyle":{"text-align":"center","min-width":"80px"}},  
   { "label":"Reacción","key":"HCOMENGEST","cellStyle":{"text-left":"center","min-width":"80px"}},  
   { "label":"Fecha Vto Oferta","key":"HFECV","cellStyle":{"text-align":"center","min-width":"80px"}},  
   { "label":"Propensión","key":"HNIVELP","cellStyle":{"text-align":"left","min-width":"80px"}},    
   { "label":"Cod Asesor","key":"HCODSEC","cellStyle":{"text-align":"left","min-width":"80px"}},  
   { "label":"Nom Asesor","key":"RDESSEC","cellStyle":{"text-align":"left","min-width":"250px"}},  
   { "label":"Unidad","key":"RDESUNI","cellStyle":{"text-align":"left","min-width":"220px"}},  
   { "label":"Corredor","key":"RDESCOR","cellStyle":{"text-align":"left","min-width":"220px"}},  
   { "label":"Territorio","key":"RDESTER","cellStyle":{"text-align":"left","min-width":"170px"}}] '   
  
   select @headers  
   
        
  DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT         
  SET @PageNumber = @pagen          
  SET @RowspPage = 30;      
    
       
 -- declare @tip_cod int=7 , @cod_rel varchar(20)='231'  
 declare @where_campo1 varchar(20),@where_campo1_ varchar(20), @where_campo2 varchar(20), @sql varchar(max)    
   
    
 if(@tip_cod=7)    
  Begin select @where_campo1 = '1', @where_campo1_ = '1'  End    
 else if (@tip_cod=20)    
  Begin select @where_campo1 = 'RCODTER', @where_campo1_ = 'C.RCODTER' End    
 else if (@tip_cod=19)    
  Begin select @where_campo1 = 'RCODCOR', @where_campo1_ = 'RCODCOR' End    
 else if (@tip_cod=21)    
  Begin select @where_campo1 = 'RCODGRU', @where_campo1_ = 'C.RCODGRU' End    
 else if (@tip_cod=18)    
  Begin select @where_campo1 = 'RCODUNI', @where_campo1_ = 'C.RCODUNI' End    
  else if (@tip_cod=17)    
  Begin select @where_campo1 = 'RCODUCO', @where_campo1_ = 'C.RCODUCO' End    
  
    declare @buscaasesor varchar(300)    
  set @buscaasesor = ''  
  --if(@nom = '') begin  
  --set @buscaasesor = '' end  
  --else begin  
  --set @buscaasesor = 'and RDESSEC like ''' +@nom+ '%'' '  
  --end  
   
  
    
 --select RFEC from storage.ref.RCALEN001 where RSEM = (select rsem from  storage.ref.RCALEN001 where RFEC = cast(GETDATE()-1 as date)) and RANI = year(cast(GETDATE()-1 as date))  
   
 --select RFEC from storage.ref.RCALEN001 where RSEM = (select rsem-1 from  storage.ref.RCALEN001 where RFEC = cast(GETDATE()-1 as date)) and RANI = year(cast(GETDATE()-1 as date))  
  
  
  
 set @where_campo2 =     
 case when @tip_cod=7 then '1' else @cod_rel    
 end    
  
  
 declare @rsem as varchar(3), @rsempas as varchar(3), @mes as varchar(3),@where_campo3 as varchar(200)  
 select @rsem =rsem,  @rsempas= rsem-1, @mes = RMES  from storage.ref.RCALEN001 where rfec = cast(GETDATE() as date)  
  
  if(@nom='1')    
  --Begin select @where_campo3 = ' and DATEPART(week, HFECCANC) ='+@rsem   End    
  Begin select @where_campo3 =  ' and HFECCANC in (  select RFEC from storage.ref.RCALEN001 where RSEM = (select rsem from  storage.ref.RCALEN001 where RFEC = cast(GETDATE()-1 as date)) and RANI = year(cast(GETDATE()-1 as date))  )'  end  
 else if (@nom='2')    
  --Begin select @where_campo3 = ' and DATEPART(week, HFECCANC) ='+@rsempas   End   
    Begin select @where_campo3 =  ' and HFECCANC in (  select RFEC from storage.ref.RCALEN001 where RSEM = (select rsem-1 from  storage.ref.RCALEN001 where RFEC = cast(GETDATE()-1 as date)) and RANI = year(cast(GETDATE()-1 as date)) )'  end  
 else if (@nom='3')    
  Begin select @where_campo3 = ' and DATEPART(month, HFECCANC) ='+@mes   End    
 else if(@nom = '0')   
 begin select @where_campo3 = '' end   
 else if(@nom = '')   
 begin select @where_campo3 = '' end   
  
  
  
declare @where_prop varchar(20) =' '  
declare @where_fuga varchar(20) =' '  
  
 if(@prop<>0)                                    
 begin   
  set @where_prop = ' and HNIVELP =' + cast(@prop as varchar)                            
 end   
   
 if(@fuga<>0)                                    
 begin   
  set @where_fuga = ' and HNIVELF =' + cast(@fuga as varchar)                            
 end   
  
 set @sql = '    
 ;WITH Datos as (    
   select distinct (HNUMCON) HNUMCON, B.HFECPRO, HSUCCLI, HCTACLI, HDESCLI,HFECV, E.HDSC,  B.HEVTO,HCODSEC, isnull(RDESSEC,''SIN ASIGNAR'') RDESSEC,   
   isnull(RDESCOR,''SIN ASIGNAR'') RDESCOR, isnull(RDESUNI,''SIN ASIGNAR'') RDESUNI, isnull(RDESTER,''SIN ASIGNAR'') RDESTER,  
 case when HINDAGE =1 then ''SI'' else ''NO'' end HINDAGE,    
 case when HINDGEST =1 then ''SI'' else ''NO'' end HINDGEST,    
 case when HINDDESB  =1 then ''SI'' else ''NO''end HINDDESB,  
 case when HNIVELF = 1 then ''1. Fuga.Alto''   
      when HNIVELF = 2 then ''2. Fuga.Medio''   
      when HNIVELF = 3 then ''3. Fuga.Bajo''  else '''' end HNIVELF,  
  
 case when HNIVELP =1  then ''1. Prop.Alto''  
   when HNIVELP =2 then  ''2. Prop.Medio''   
   when HNIVELP =3  then ''3. Prop.Bajo''  else '''' end HNIVELP,  
  
 case when HCRIT =0  then ''App Cliente''  
   when HCRIT =1 then  ''Huella de Consulta''   
   when HCRIT =2  then ''Cancelado''  else '''' end HINGRESO,  
 HFECCANC, HMONDESMN ,  
HCOMENGEST,HNVELRIE  
 from storage.com_act.WABDC004 B left join storage.[com_act].[VABRE001] E  
 on B.HEVTO = E.HEVTO   
  LEFT JOIN storage.[ref].WJERCOR03 C    
  on B.HCODSEC =  C.RCODSEC and B.HFECPRO = C.RFECPRO  and RINDFEC=''ACTUAL''      
  where '+@where_campo1+' = '''+@where_campo2+'''     '+@buscaasesor+'   
  '+@where_prop+' '+@where_fuga+' '+@where_campo3+'  
  
  union  
  
  select '''' HNUMCON,  '''' HFECPRO, '''' HSUCCLI, '''' HCTACLI, '''' HDESCLI, NULL HFECV, '''' HDSC, '''' HEVTO, '''' HCODSEC, '''' RDESSEC,   
  '''' RDESCOR, '''' RDESUNI, '''' RDESTER,'''' HINDAGE, '''' HINDGEST, '''' HINDDESB,  
 '''' HNIVELF,  
 '''' HNIVELP,  
 '''' HINGRESO,  
 NULL HFECCANC, NULL HMONDESMN  , NULL HCOMENGEST, NULL HNVELRIE  
  
 )  
 select  cast(RDESTER as varchar) RDESTER,cast(RDESCOR as varchar) RDESCOR,cast(RDESUNI as varchar) RDESUNI,cast(HCODSEC as varchar) HCODSEC,cast(RDESSEC  as varchar) RDESSEC,  
 HCTACLI,HDESCLI,HFECV,   
   cast(HINDAGE  as varchar) HINDAGE,cast(HINDGEST as varchar) HINDGEST,cast(HINDDESB  as varchar) HINDDESB,cast(HNIVELF as varchar) HNIVELF,cast(HNIVELP   as varchar) HNIVELP,  
 HINGRESO,HFECCANC, HMONDESMN ,HCOMENGEST,HNVELRIE   
     from Datos order by hctacli desc  
  '    
    
   --print (@sql )  
  
     
  exec (@sql)    
    
    
end
