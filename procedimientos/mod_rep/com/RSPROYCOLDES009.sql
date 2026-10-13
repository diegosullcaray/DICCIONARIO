-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-05-04 11:10:32.700000
  
CREATE PROCEDURE [com].[RSPROYCOLDES009]                        
 @tip_cod int,                            
 @cod_rel varchar(10),   
 @pagen int    
 as                        
 begin                        
  SET NOCOUNT ON;                           
                        
  declare @defs as rep.TTHCOLDEF;                
  SET LANGUAGE spanish;                                            
  insert into @defs                            
  (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TSTBACKGROUND)  values                              
  (1,1,1,1,'NomCli','Nombre cliente','string',NULL,NULL,NULL),                        
  (2,2,1,1,'HASESOR','Código asesor','string',NULL,NULL,NULL),                        
  (3,3,1,1,'HNOMASE','Nobre asesor','string',NULL,NULL,NULL),                        
  (4,4,1,1,'HMONT','Monto','number','1.2-2',NULL,NULL),                
  (5,5,1,1,'HNOMTEV','Tipo evento','string',NULL,NULL,NULL)     
                              
  --SET LANGUAGE english;                                              
  select rep.FFTHCOLDEF(@defs) result;     
   DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT         
  SET @PageNumber = @pagen          
  SET @RowspPage = 30;      
    
        
   --declare @tip_cod int =7, @cod_rel varchar (3)='231'    
  declare @FecMax as varchar(10), @cf as varchar(10), @where as varchar(max), @sql varchar(max)         
  select @FecMax=MAX(HFECPRO) FROM STORAGE.[com_act].HBPDR001     
  --select @cf=MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())      
  SELECT @cf=MAX(hfecreg) FROM STORAGE.[com_act].HBPDR001     
    
    
  if(@tip_cod=7)    
  Begin  select @where = ''  End    
 else if (@tip_cod=20)    
  Begin    
  select @where = ' and RCODTER = '''+@cod_rel+' '''    
  End    
 else if (@tip_cod=19)    
  Begin    
  select @where = ' and RCODCOR = '''+@cod_rel+''''    
  End    
 else if (@tip_cod=21)    
  Begin    
  select @where = ' and RCODGRU = '''+@cod_rel+''''    
  End    
 else if (@tip_cod=18)    
  Begin    
  select @where = ' and RCODUNI = '''+@cod_rel+''''     
  End    
    
 set @sql = '    
 select   row_number() over(order by RDESTER desc) AS [row],  
 HAPPAT+'' ''+HAPMAT+'' ''+HNOMCLI as NomCli,HASESOR,HNOMASE,HMONT, HNOMTEV   into Datos_PD  
 from  STORAGE.[com_act].HBPDR001 A       
  LEFT JOIN storage.[ref].WJERCOR03 C    
  on A.HASESOR =  C.RCODSEC and A.HFECPRO=C.RFECPRO      
  where A.hfecpro  = '''+@FecMax+''' and A.hfecreg = '''+@cf+''' and HTIPPRO = ''C'' and HESTADO = ''A''    
  and HTIPEVE in (1,5,6)  '+ @where +'     
  order by HMONT desc    
  '    
  --print @sql    
 exec (@sql)    
 declare @result  as table([row] int,      
  NomCli varchar(250),HASESOR varchar(10),HNOMASE varchar(250),HMONT numeric(10, 2),HNOMTEV varchar(300))    
    
    
   insert into @result      
   select   *    from Datos_PD      
          
       
  select * from @result ORDER BY HMONT desc      
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS          
  FETCH NEXT @RowspPage ROWS ONLY;      
      
 select count(*) as Total from @result      
     
 drop table  Datos_PD     
        
end
