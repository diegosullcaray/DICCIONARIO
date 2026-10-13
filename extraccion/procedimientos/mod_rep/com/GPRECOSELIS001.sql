-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.910000
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
      
--EXEC  [com].[GPRECOSELIS001]  7,'231','20201031','TODO','TODO'        
CREATE procedure [com].[GPRECOSELIS001]                   
@tip_cod int,@cod_rel varchar(20),@fec varchar(50),@prod varchar(20),@subpro varchar(20),@pagen int=1,@nom VARCHAR(500)                       
AS                 
BEGIN           
SET NOCOUNT ON;                  
declare @fecha date=dateadd(day,-1,GETDATE());                
declare @fec_vigente date=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)                
declare @defs as rep.TTHCOLDEF;               
Declare @FechaCosechas varchar(max)            
          
;with Fechas as(                  
 select distinct cast(HFECPRO as varchar(max)) as SFECBAS from storage.[com_act].WBCH002 --select*from storage.[com_act].WBCH001                   
 --where  CASE WHEN @madu='TODO' THEN '1' else cast(HCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end                   
 )               
 select @FechaCosechas = STUFF((SELECT  ',' + QUOTENAME(cast(c.SFECBAS as varchar(max)))                                        
 FROM Fechas c                     
 FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)') ,1,1,'')                   
                  
 set  @FechaCosechas=replace(replace(replace(@FechaCosechas,'-',''),'[',''),']','')            
          
SET LANGUAGE spanish;                
insert into @defs                  
(TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TFORMOD)  values          
(1,1,1,'HCTACLI','CTA CLIENTE','string',1,''),                
(2,2,1,'HDESCLI','NOMBRE CLIENTE','string',0,''),          
(3,3,1,'HCODOPE','OPERACION','string',0,''),          
(4,4,1,'HMONDESMN','MONTO DESEMBOLSO','number',0,'.0-0'),          
(5,5,1,'HSUCCLI','CODIGO SUCURSAL DE CREDITO','number',0,'.0-0'),          
(6,6,1,'NOMMODULO','NOMBRE DEL MODULO','string',0,''),         
(7,7,1,'HDTIPOPE','TIPO OPERACION','string',0,''),          
--(11,11,1,'NROMORA','N° MORA','string',0),--          
(8,8,1,'RDESTER','TERRITORIO','string',0,''),          
(9,9,1,'RDESCOR','CORREDOR','string',0,''),          
(10,10,1,'RDESADM','ADMINISTRADOR','string',0,'')          
          
SET LANGUAGE english;                  
select rep.FFTHCOLDEF(@defs) result;           
          
DECLARE @PageNumber AS INT                
DECLARE @RowsOfPage AS INT                
SET @PageNumber=@pagen                
SET @RowsOfPage=10                
          
;WITH Datos as            
(          
 select HCTACLI,HDESCLI,HCODOPE,HMONDESMN,HSUCCLI,          
     case           
    when HCODMOD=101 then 'AGRICOLA'          
    WHEN HCODMOD=102 then 'INCLUSION'          
    WHEN HCODMOD=103 then 'PERSONAL'          
    WHEN HCODMOD=104 then 'NEGOCIOS'          
    WHEN HCODMOD=108 then 'COFIDE HIPOTECARIO'          
    WHEN HCODMOD=109 then 'HIPOTECARIOS RRPP'          
   END AS 'NOMMODULO'          
   ,        
   HDTIPOPE,b.RDESTER,b.RDESCOR,b.RDESADM --,c.C3M as NROMORA        
 from storage.[com_act].WBCH002 A  --select*from storage.[com_act].WBCH002          
 --left join storage.[ref].WJERCOR01 B ON A.HCODSEC=B.RCODSEC and B.RFECPRO=@fec_vigente          
 /*LEFT JOIN (select HCODOPE AS HCODOPES,ISNULL([0],0)+ISNULL([1],0)+ISNULL([2],0) AS C3M from        
      (select HCODOPE,HINDMORH,HCOSECHA from storage.[com_act].WBCH002  ) A        
       pivot (SUM(HINDMORH) for HCOSECHA in([0],[1],[2])) PVT)C        
ON A.HCODOPE=C.HCODOPES*/        
 left join storage.ref.FJERCOR01_(@FechaCosechas) B                   
 on  a.hCODSEC=B.RCODSEC    ANd A.HFECPRO=B.RFECPRO                     
 WHERE a.HFECPRO=@fec          
 and  case           
   when @tip_cod=15 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')                   
            when @tip_cod=14 then cast(B.RCODCOR as nvarchar(10))                   
            when @tip_cod=13 then B.RCODGRU                  
            when @tip_cod=11 then B.RCODADM else '1'           
   end=IIF(@tip_cod=7,'1',@cod_rel)           
 AND case when @prod='TODO' then '1' else A.RDESPROD end=case when @prod='TODO' then '1' else @prod end                    
    AND CASE WHEN @subpro='TODO' THEN '1' else a.HDTIPOPE  end=case when @subpro='TODO' then '1' else @subpro end                  
   -- AND CASE WHEN @madu='TODO' THEN '1' else cast(a.HCOSECHA as varchar(50))  end=case when @madu='TODO' then '1' else @madu end               
   AND A.HDESCLI  like @nom          
)          
          
select*  from Datos ORDER BY RDESTER              
 OFFSET (@PageNumber-1)*@RowsOfPage ROWS                
FETCH NEXT @RowsOfPage ROWS ONLY              
END
