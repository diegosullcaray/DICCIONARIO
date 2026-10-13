-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-04-29 18:11:54.557000

--EXEC [mod_rep].[com].[RS_AGE_COM_CR_M_04] '7','231','0','20250331',0

 CREATE  PROCEDURE [com].[RS_AGE_COM_CR_M_04]  
@tip_cod int, @cod_rel varchar(10),@pagen int=1, @fecha date = null , @tipo_ase smallint = 0                  
----------------------------------------------------------------------------------                  
as                  
begin                  
SET NOCOUNT ON;   
select @pagen =1
--declare @tip_cod int = 7, @cod_rel varchar(10) = '231', @fec date ='20250412'                       
  
 declare @fec varchar(10);          
 select @fec=(select max(RFEC) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)    
   
 declare @defs as rep.TTHCOLDEF;            
            
  insert into @defs                
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND)  values             
          
  
 (1,1,1,'RDESTER','Territorio',1,1,1,'string',null,null,null),    
 (2,2,1,'RDESCOR','Corredor',1,1,1,'string',null,null,null),  
 (3,3,1,'RDESUNI','Unidad',1,1,1,'string',null,null,null),  
 (4,4,1,'RDESSEC','Sectorista',1,1,1,'string',null,null,null),  
 (5,5,1,'HCODSEC','Cod BT',1,1,1,'string',null,null,null),  
 (6,6,1,'NOM_CLI','Nom. Cliente',1,1,1,'string',null,null,null),  
 (7,7,1,'HCTA','Cliente',1,1,NULL,'Number',0,null,null),           
 --(8,8,1,'HINDAGE','Agendados',1,1,NULL,'string',null,null,null),           
 (9,9,1,'HINDGEST','Gestionados',1,1,NULL,'string',null,null,null),    
 (10,10,1,'HMEN200','Geolocalizaciones <=200 metros *',1,1,NULL,'string',null,null,'#1f8c26'),   
 (11,11,1,'HMAY200','Geolocalizaciones >200 metros *',1,1,NULL,'string',null,null,'#FF0000'),           
 (12,12,1,'DET_REACCION','Detalle Reacción',1,1,NULL,'string',null,null,null)    
   
 select rep.FFTHCOLDEF(@defs) result;    
 DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT           
  SET @PageNumber = @pagen            
  SET @RowspPage = 30;     
  
   
 --declare @tip_cod int=7 , @cod_rel varchar(20)='231', @fec varchar(10)='20250331' , @tipo_ase smallint = 0       
 --declare @tip_cod int=18 , @cod_rel varchar(20)='65', @cf1 varchar(10)='2022-06-03'  
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
   
   
  
   set @sql = '  
    
;with base as (  
 select distinct HNUMCON,HFECPRO,HCODSEC,HCTA, max(HINDBASE)HINDBASE,  max(HINDGEST)HINDGEST,  
 max(HGEOMEN200)HGEOMEN200, max(HINDGEST2)HINDGEST2, max(HNUMRCC)HNUMRCC, HDESCLI, max(HSALCAPMN)HSALCAPMN  
 from storage.[com_act].WABDC003 where hfecpro = '''+cast(@fec as varchar)+''' '+@tip_ase+'   group by HNUMCON,HFECPRO, HDESCLI,HCODSEC,HCTA    
 )  
   
 select   row_number() over(order by RDESTER desc) AS [row],    
 isnull(C.RDESTER,''Sin Asignar'')RDESTER, isnull(C.RDESCOR,''Sin Asignar'')RDESCOR,  
 isnull( C.RDESUNI,''Sin Asignar'')RDESUNI,C.RDESSEC,B.HCODSEC, B.HDESCLI NOM_CLI,  
 cast (HCTA as INT) HCTA    
     ,  CASE WHEN HINDGEST2 =1  THEN ''SI'' ELSE ''NO'' END HINDGEST  
    ,  CASE WHEN HGEOMEN200   =1  THEN ''SI'' ELSE ''NO'' END HMEN200  
    ,  CASE WHEN HGEOMEN200  =0  THEN ''SI'' ELSE ''NO'' END HMAY200  
 ,  CASE HNUMRCC WHEN 1 THEN ''Se ubicó conforme ''  
     WHEN 2 THEN ''Se ubicó con observaciones''  
     WHEN 3 THEN ''No se ubicó''  
     WHEN 4 THEN ''Dirección incorrecta''  
     WHEN 5 THEN ''Se niega a pagar''  
     else ''Sin Reacción''  
  END DET_REACCION  
  into Datos_AGR  
 from base B  
 LEFT JOIN storage.[ref].WJERCOR03 C  
 on B.HCODSEC =  C.RCODSEC and B.HFECPRO=C.RFECPRO   
 where   '+@where_campo1+'  '+@where_campo2+'  
   
  
 '  
   --print @sql      
 exec (@sql)   
  
 declare @result  as table([row] int,        
  RDESTER varchar(50),RDESCOR varchar(50),RDESUNI varchar(50),RDESSEC varchar(200),HCODSEC varchar(10),NOM_CLI varchar(200), HCTA varchar(50), HINDGEST varchar(2),  
  HMEN200 varchar(2),HMAY200 varchar(2),DET_REACCION varchar(50))      
      
      
   insert into @result        
   select   *    from Datos_AGR    
  
   select * from @result ORDER BY RDESTER,RDESCOR,RDESUNI desc        
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS            
  FETCH NEXT @RowspPage ROWS ONLY;        
        
 select count(*) as Total from @result        
       
 drop table  Datos_AGR       
    
end
