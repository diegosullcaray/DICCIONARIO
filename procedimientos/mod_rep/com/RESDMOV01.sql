-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-07-08 10:01:07.840000
--exec [com].[RESDMOV01]  2,'00245492','20221011'

--exec [com].[RESDMOV01]  7,'231','20250519'


CREATE procedure [com].[RESDMOV01]      
@tip_cod int,@cod_rel varchar(20),@fec varchar(8)='NOW'  ,@pagen int=1    
-- declare @tip_cod int=11 , @cod_rel varchar(250)='TACOL001'    
--declare @tip_cod int=7 , @cod_rel varchar(250)='231'    
    
            
AS              
BEGIN              
 SET NOCOUNT ON;              
   -- declare @tip_cod int=11 , @cod_rel varchar(250)='TACOL001', @fec varchar(8)='NOW' 
    -- declare @tip_cod int=21 , @cod_rel varchar(250)='1', @fec varchar(8)='NOW'       
 declare @cf as date,@cf_a as varchar(10)      
                   
 if(@fec='NOW')              
 begin  
  select @cf=MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())               
  --select @cf=dateadd(day,-1,getdate())           
  end              
 else              
 begin              
  select @cf=@fec              
 end           
        
  select top 1 @cf_a=RFEC from storage.ref.RCALEN001 where RFEC<=cast(eomonth(@cf,-1) as date) order by rfec desc              
   --select @cf, @cf_a    
    
           
 declare @defs as rep.TTHCOLDEF;      
    
  insert into @defs            
    
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values       
 (1,1,1,'RDESTER','Territorio','string',null,null,null,null),    
 (2,1,1,'RDESCOR','Corredor','string',null,null,null,null),         
 (3,1,1,'HCODSEC','Asesor','string',null,null,null,null),    
 (4,2,1,'RDESSEC','Nombre','string',null,null,null,null),     
 (5,2,1,'CARGO','Cargo','string',null,null,null,null),       
 --(6,3,1,'HTOT_DESPLAZAMIENTO','Desplazamientos Únicos','number','.0-0',null,null,null),    
 --(7,3,1,'HDESPL_VALIDOG','Desplazamiento Válidos google','number','.0-0',null,null,null),    
 --(8,3,1,'HDISTPROMG','Distancia Promedio Google (km)','number','1.2-2',null,null,null),    
 (9,3,1,'HMONTOMOV','Monto Movilidad','number','1.2-2',null,null,null),    
 (10,3,1,'HPLANDATOS','Plan de Datos','number','1.2-2',null,null,null),    
 (11,3,1,'HRECLAMO','Reclamo / Regularización','number','1.2-2',null,null,null),    
 (12,3,1,'HDESCTO','Descuento','number','1.2-2',null,null,null),    
 (13,3,1,'HPAGOFINAL','Pago Final','number','1.2-2',null,null,null),    
 (14,3,1,'HCOMETARIO','Comentario','string',null,null,null,null),    
 (15,3,1,'HCARTERA','Cartera al cierre ant','number','1.2-2',null,null,null) 
     
     
    
  select rep.FFTHCOLDEF(@defs) result;        
  DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT         
  SET @PageNumber = @pagen          
  SET @RowspPage = 30;      
    

IF OBJECT_ID('dbo.TEMP_RESDMOV01_MOV', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.TEMP_RESDMOV01_MOV;
END
    
 -- declare @tip_cod int=17 , @cod_rel varchar(20)='9375', @cant varchar='1',@cf_a varchar(10) =  '20250430',@cf  varchar(10) =  '20250519'   

 declare @where_campo1 varchar(20),@where_campo1_ varchar(20), @where_campo2 varchar(20), @esq varchar(3) = 'C.', @sql nvarchar(max)    
 declare @cf1 varchar(10) , @sql_unionGC varchar(max) , @sql_unionUN varchar(max)    
     
 set @cf1  = @cf    
    
 select @sql_unionGC = 'union   
 select * from DatosC'

 select @sql_unionUN = 'union   
 select * from DatosB'

 if(@tip_cod=7) 
  Begin select @where_campo1 = '1', @where_campo1_ = '1', @esq ='' End    
 else if (@tip_cod=20)    
  Begin select @where_campo1 = 'RCODTER', @where_campo1_ = 'W.RCODTER' End    
 else if (@tip_cod=19)    
  Begin select @where_campo1 = 'RCODCOR', @where_campo1_ = 'C.RCODCOR' End    
 else if (@tip_cod=21)    
  Begin select @where_campo1 = 'RCODGRU', @where_campo1_ = 'C.RCODGRU' End    
 else if (@tip_cod=18)    
  Begin select @where_campo1 = 'RCODUNI', @where_campo1_ = 'H.RCODUNI', @sql_unionGC = '' End    
 else if (@tip_cod=17)    
  Begin select @where_campo1 = 'RCODUCO', @where_campo1_ = 'H.RCODUNI', @sql_unionGC = '', @sql_unionUN = '' End       
       
 set @where_campo2 =     
 case when @tip_cod=7 then '1' else @cod_rel    
 end    
    
 set @sql = '    
 ;WITH Datos as (    
  select    
  B.HCODSEC, C.RDESSEC, ''ASESOR COMERCIAL'' CARGO, C.RDESTER, C.RDESCOR, isnull(B.HTOT_DESPLAZAMIENTO,0) HTOT_DESPLAZAMIENTO,     
  isnull(B.HDESPL_VALIDOG,0)HDESPL_VALIDOG, isnull(B.HDISTPROMG,0)HDISTPROMG, isnull(B.HMONTOMOV,0)HMONTOMOV,     
  isnull(B.HPLANDATOS,0)HPLANDATOS, isnull(B.HRECLAMO,0)HRECLAMO, isnull(B.HDESCTO,0)HDESCTO,     
  isnull(B.HPAGOFINAL,0)HPAGOFINAL, B.HCOMETARIO  ,isnull(B.HCARTERA,0)HCARTERA   
  from storage.[com_act].[HBMOV002] B    
  JOIN storage.[ref].WJERCOR03 C    
  on B.HCODSEC =  C.RCODSEC and C.RFECPRO= '''+@cf1+''' and RINDFEC=''ACTUAL''      
  where '+@where_campo1+' = '''+@where_campo2+'''  AND B.HFECPRO = '''+@cf_a+'''    
 ),    
 DatosB as (    
  select    
  distinct D.RCODADM HCODSEC, E.HDESPER, ''ADMINISTRADOR'' CARGO,C.RDESTER, C.RDESCOR,isnull(B.HTOT_DESPLAZAMIENTO,0) HTOT_DESPLAZAMIENTO,     
  isnull(B.HDESPL_VALIDOG,0)HDESPL_VALIDOG, isnull(B.HDISTPROMG,0)HDISTPROMG, isnull(B.HMONTOMOV,0)HMONTOMOV,     
  isnull(B.HPLANDATOS,0)HPLANDATOS, isnull(B.HRECLAMO,0)HRECLAMO, isnull(B.HDESCTO,0)HDESCTO,     
  isnull(B.HPAGOFINAL,0)HPAGOFINAL, B.HCOMETARIO ,isnull(B.HCARTERA,0)HCARTERA     
  from storage.[com_act].[HBMOV002] B 
  LEFT JOIN storage.ref.RECUC001 D
  on B.HCODSEC = D.RCODADM   
  JOIN storage.[ref].WJERCOR03  C    
  on C.RCODUNI =  D.RCODUNI and C.RFECPRO= '''+@cf1+''' and RINDFEC=''ACTUAL''  
  left join [storage].[gpr].[VPPH001] E
  on B.HCODSEC = E.HCODBT
  where '+ @esq+''+@where_campo1+' = '''+@where_campo2+'''  AND B.HFECPRO = '''+@cf_a+'''    
 ),    
 DatosC as (    
  select distinct(C.RUSUADM), E.HDESPER, ''G. CORREDOR'' CARGO, D.RDESTER, C.RDESCOR,isnull(B.HTOT_DESPLAZAMIENTO,0) HTOT_DESPLAZAMIENTO,     
  isnull(B.HDESPL_VALIDOG,0)HDESPL_VALIDOG, isnull(B.HDISTPROMG,0)HDISTPROMG, isnull(B.HMONTOMOV,0)HMONTOMOV,     
  isnull(B.HPLANDATOS,0)HPLANDATOS, isnull(B.HRECLAMO,0)HRECLAMO, isnull(B.HDESCTO,0)HDESCTO,     
  isnull(B.HPAGOFINAL,0)HPAGOFINAL, B.HCOMETARIO  ,isnull(B.HCARTERA,0)HCARTERA   
  from storage.ref.RECCT001 C    
  left join  [storage].[gpr].[VPPH001] E    
  on C.RUSUADM = E.HCODBT    
  join storage.[com_act].[HBMOV002] b    
  on C.RUSUADM = b.HCODSEC    
  join storage.ref.RECTFC001 D    
  on C.RCODTER = D.RCODTER 
  left join   (select distinct rcodter,rcodcor from  storage.[ref].WJERCOR03 where RFECPRO= '''+@cf1+''' and RINDFEC=''ACTUAL''  ) W
  on C.RCODCOR =  W.rcodcor
  left join storage.ref.RECUC001 H
  on C.rcodcor = H.rcodcor
  where '+@where_campo1_+' = '''+@where_campo2+'''  AND B.HFECPRO = '''+@cf_a+'''    
 ), 
 DatosD as (
 select    
  distinct D.RCODADM HCODSEC, E.HDESPER, ''COORDINADOR'' CARGO,C.RDESTER, C.RDESCOR,isnull(B.HTOT_DESPLAZAMIENTO,0) HTOT_DESPLAZAMIENTO,     
  isnull(B.HDESPL_VALIDOG,0)HDESPL_VALIDOG, isnull(B.HDISTPROMG,0)HDISTPROMG, isnull(B.HMONTOMOV,0)HMONTOMOV,     
  isnull(B.HPLANDATOS,0)HPLANDATOS, isnull(B.HRECLAMO,0)HRECLAMO, isnull(B.HDESCTO,0)HDESCTO,     
  isnull(B.HPAGOFINAL,0)HPAGOFINAL, B.HCOMETARIO ,isnull(B.HCARTERA,0)HCARTERA     
  from storage.[com_act].[HBMOV002] B 
  LEFT JOIN storage.ref.RECCO001 D
  on B.HCODSEC = D.RCODADM 
  JOIN storage.[ref].WJERCOR03  C    
  on C.RCODUCO =  D.RCODUCO and C.RFECPRO= '''+@cf1+''' and RINDFEC=''ACTUAL''  
  left join [storage].[gpr].[VPPH001] E
  on B.HCODSEC = E.HCODBT
  where '+ @esq+''+@where_campo1+' = '''+@where_campo2+'''  AND B.HFECPRO = '''+@cf_a+'''    
 ),
 DatosFinal as (    
 select * from Datos      
 '+ @sql_unionUN +'
 union     
 select * from DatosD     
 '+ @sql_unionGC +'

 )    
      
 select * into TEMP_RESDMOV01_MOV from DatosFinal    
  '     
      
      --print @sql    
    
  EXEC (@sql)    
    
 declare @result  as table([row] int,      
  HCODSEC varchar(10),RDESSEC varchar(250),CARGO varchar(250),RDESTER varchar(250),RDESCOR varchar(250),HTOT_DESPLAZAMIENTO smallint,    
  HDESPL_VALIDOG smallint,HDISTPROMG float,HMONTOMOV numeric(10, 2),HPLANDATOS numeric(10, 2),HRECLAMO numeric(10, 2),HDESCTO numeric(10, 2),    
  HPAGOFINAL numeric(10, 2),HCOMETARIO varchar(300),HCARTERA numeric(17, 2))    
    
    
   insert into @result      
   select       
   row_number() over(order by RDESTER desc) AS [row],      
   *       
   from TEMP_RESDMOV01_MOV      order by HCODSEC
          
       
  select * from @result ORDER BY [row] asc      
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS          
  FETCH NEXT @RowspPage ROWS ONLY;      
      
  select count(*) as Total from @result      
     
 drop table  TEMP_RESDMOV01_MOV     
end
