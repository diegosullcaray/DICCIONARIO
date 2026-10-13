-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-16 08:45:16.860000
--EXEC [mod_rep].[com].[RMESA01] '19','1','1'

CREATE procedure [com].[RMESA01]       
@tip_cod int,@cod_rel varchar(20),@pagen int=1 --, @fecha date     
     
AS       
begin      
 set nocount on;        
 declare @defs as rep.TTHCOLDEF;  
  
    
 --insert into @defs         
 --   (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values        
 --   (1,1,'tinicio','Inicio',null,4),        
 --   (2,1,'tactual','Actual',null,9)       
      
 insert into @defs        
   
 
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values        
    (1,1,1,'ope','Operación Inicio','number',null,null,'green','8.3%'),        
    (2,2,1,'sec1','Asesor Inicio','string',null,null,'green','8.3%'),   
	(3,3,1,'sec1B','Asesor Inicio','string',null,null,'green','8.3%'),          
    (4,4,1,'tram1','Tramo Inicio','string','',null,'green','8.3%'),    
	(5,5,1,'sal1','Saldo Inicio','number','1.1-2',null,'green','8.3%'),        
    (6,6,1,'ter','Territorio Actual','string',null,null,null,'8.3%'),         
    (7,7,1,'corr','Corredor Actual','string',null,null,null,'8.3%'),           
    (8,8,1,'un','Unidad Actual','string',null,null,null,'8.3%'),          
	(9,9,1,'sec2','Asesor Actual','string',null,null,null,'8.3%'),   
	(10,10,1,'sec2B','Asesor Actual','string',null,null,null,'8.3%'),             
    (11,11,1,'tram2','Tramo Actual','string',null,null,null,'8.3%'),         
    (12,12,1,'situ','Situacion Actual','string',null,null,null,'8.3%'),         
	(13,13,1,'sal2','Saldo Actual','number','1.1-2',null,null,'8.3%'),        
	(14,14,1,'numg','Nro de Gestiones Actual','number','.0-0',null,null,'8.3%'),        
	(15,15,1,'reac','Última Reacción Actual','string',null,null,null,'8.3%')        
  
    
 select rep.FFTHCOLDEF(@defs) result;    
 DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT       
 SET @PageNumber = @pagen        
 SET @RowspPage = 30;    
  
declare @result as table([row] int,    
 ope varchar(100),sec1 varchar(100),sec1B varchar(250),tram1 varchar(100),sal1 varchar(100),ter varchar(100),corr varchar(100)    
 ,un varchar(100),sec2 varchar(100),sec2B varchar(250),tram2 varchar(100),situ varchar(100),sal2 varchar(100)      
 ,numg varchar(100),reac varchar(100)  
 )    
  
         
;WITH Datos as                
(    
--declare @tip_cod int=7 , @cod_rel varchar(250)='231'  
select HCODOPE ope,  
HCODSEC sec1,  
HDCODSEC sec1B,  
HTRAM01 tram1,  
HSALCAPMN sal1,  
RDESTER ter,  
RDESCOR corr,  
RDESUNI un,  
HCODSEC2 sec2,  
RDESSEC sec2B,  
HTRAM02 tram2,  
SITUACION situ,  
HSALCAPMN2 sal2,  
isnull(HFNUM,0)numg,  
isnull(HFCRES,'-')reac  
from storage.com_act.WDMESA001  
where case when @tip_cod=7 then '1'  
  when @tip_cod=20 then  cast(RCODTER as varchar(250))  
  when @tip_cod=19 then  cast(RCODCOR as varchar(250))  
  when @tip_cod=21 then  cast (RCODGRU as varchar (250))  
  when @tip_cod=18 then  cast(RCODUNI  as varchar (250))  
end = case when @tip_cod=7 then '1' else @cod_rel end   
  
)              
  
insert into @result    
   select     
   row_number() over(order by ter desc) AS [row],    
   *     
   from Datos    
        
     
  select * from @result ORDER BY [row] asc    
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS        
  FETCH NEXT @RowspPage ROWS ONLY;    
    
  select count(*) as Total from @result    
    
end 

--select * from storage.com_act.WDMESA001
