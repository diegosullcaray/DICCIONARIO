-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-03-29 17:18:35.820000
  
CREATE PROCEDURE [com].[RPROSCORR005]     
@tip_cod int,@cod_rel varchar(20)    
AS           
begin          
 set nocount on;      
set language 'spanish' 

;with cte_a as (
select *
from storage.com.metas_saldos
where HTIPCOD=16 and hcodvar=10060 and year(hfecpro)=year(getdate())
)
SELECT HFECPRO,'0' SCODDESCRIP,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=15 then C.RDESTER
			when @tip_cod=14 then C.RDESCOR
			when @tip_cod=4 then c.RDESMAT    END descripcion,SUM(A.HVALVAR)  SMETSEGINC
into #MetSeg  --select * from storage.ref.vjercor03
FROM cte_a A
LEFT JOIN storage.ref.vjercor03 C 
on A.hcodrel =  C.RCODAGE  
WHERE case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(10)),'9999')               
         when @tip_cod=14 then cast(c.RCODCOR as nvarchar(10))            
         when @tip_cod=4 then c.RCODAGE                  
          else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY HFECPRO,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=15 then C.RDESTER
			when @tip_cod=14 then C.RDESCOR
			when @tip_cod=4 then c.RDESMAT   
			 END

UNION ALL
select HFECPRO,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODTER as varchar(250)),'9999')
			when @tip_cod=15 then cast(C.RCODCOR as varchar(250))
			when @tip_cod=14 then cast(C.RCODMAT as varchar(250))
			when @tip_cod=4 then cast(C.RCODAGE as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RDESTER,'SIN ASIGNAR')
			when @tip_cod=15 then C.RDESCOR
			when @tip_cod=14 then C.RDESMAT
			when @tip_cod=4 then C.RDESAGE END,SUM(a.HVALVAR)  SMETSEGINC

from cte_a a 
left join storage.ref.vjercor03 C
on a.hcodrel=c.RCODAGE
where  case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(10)),'9999')               
         when @tip_cod=14 then cast(c.RCODCOR as nvarchar(10))            
         when @tip_cod=4 then cast(c.RDESMAT as varchar(250))                  
         when @tip_cod=11 then cast(c.RDESAGE as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY HFECPRO,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODTER as varchar(250)),'9999')
			when @tip_cod=15 then cast(C.RCODCOR as varchar(250))
			when @tip_cod=14 then cast(C.RCODMAT as varchar(250))
			when @tip_cod=4 then cast(C.RCODAGE as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RDESTER,'SIN ASIGNAR')
			when @tip_cod=15 then C.RDESCOR
			when @tip_cod=14 then C.RDESMAT
			when @tip_cod=4 then C.RDESAGE END



declare @FecMin date=(select min(rfec) FROM [storage].[ref].[RCALEN001] WHERE RCIEBT=1 AND year(rfec)=year(getdate()))


;WITH CTE_A AS (
SELECT eomonth(HFECINSTAL) HFECPRO,HDESAGE,count(*) HCOUNT
FROM STORAGE.[com_act].[HCMC002] 
WHERE HINSTALAD='SI'  and eomonth(HFECINSTAL) between @FecMin and eomonth(getdate()) 
group by eomonth(HFECINSTAL),HDESAGE
)
SELECT HFECPRO,'0' SCODDESCRIP,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=15 then C.RDESTER
			when @tip_cod=14 then C.RDESCOR
			when @tip_cod=4 then c.RDESMAT    END descripcion,SUM(A.HCOUNT)  HCOUNT
into #Real  --select * from storage.ref.vjercor03
FROM cte_a A
LEFT JOIN storage.ref.vjercor03 C 
on A.HDESAGE =  C.RDESAGE  
WHERE case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(10)),'9999')               
         when @tip_cod=14 then cast(c.RCODCOR as nvarchar(10))            
         when @tip_cod=4 then c.RCODAGE                  
          else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY HFECPRO,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=15 then C.RDESTER
			when @tip_cod=14 then C.RDESCOR
			when @tip_cod=4 then c.RDESMAT   
			 END

UNION ALL
select HFECPRO,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODTER as varchar(250)),'9999')
			when @tip_cod=15 then cast(C.RCODCOR as varchar(250))
			when @tip_cod=14 then cast(C.RCODMAT as varchar(250))
			when @tip_cod=4 then cast(C.RCODAGE as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RDESTER,'SIN ASIGNAR')
			when @tip_cod=15 then C.RDESCOR
			when @tip_cod=14 then C.RDESMAT
			when @tip_cod=4 then C.RDESAGE END,SUM(a.HCOUNT)  HCOUNT

from cte_a a 
left join storage.ref.vjercor03 C
on A.HDESAGE =  C.RDESAGE  
where  case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(10)),'9999')               
         when @tip_cod=14 then cast(c.RCODCOR as nvarchar(10))            
         when @tip_cod=4 then cast(c.RDESMAT as varchar(250))                  
         when @tip_cod=11 then cast(c.RDESAGE as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY HFECPRO,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODTER as varchar(250)),'9999')
			when @tip_cod=15 then cast(C.RCODCOR as varchar(250))
			when @tip_cod=14 then cast(C.RCODMAT as varchar(250))
			when @tip_cod=4 then cast(C.RCODAGE as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RDESTER,'SIN ASIGNAR')
			when @tip_cod=15 then C.RDESCOR
			when @tip_cod=14 then C.RDESMAT
			when @tip_cod=4 then C.RDESAGE END

			 
 select  
a.hfecpro,a.SCODDESCRIP,a.descripcion,a.SMETSEGINC,b.HCOUNT,b.HCOUNT/a.SMETSEGINC 'Cumpl' 
into #Da
from #MetSeg a
left join #Real b 
on a.hfecpro=b.HFECPRO and a.SCODDESCRIP=b.SCODDESCRIP
where eomonth(a.HFECPRO) between @FecMin and eomonth(getdate())
  
 alter table #Da add ord int 

 UPDATE a
SET a.ord = x.ord
FROM #Da a  -- select * from #Da
inner join (
      SELECT hfecpro, ROW_NUMBER() OVER (ORDER BY hfecpro) AS ord
      FROM #Da 
	  where SCODDESCRIP=0
      )  x
on a.hfecpro=x.hfecpro
	    

declare @defs as rep.TTHCOLDEF;    
/*insert into @defs          
(TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values          
(1,1,1,'vars','Descripción',null,null,1,'string',null) 
*/
declare @count int=1       
declare @max int=(select max(ord)  from #Da where SCODDESCRIP=0)
declare @nomFecha varchar(50)

create table #Cab                                
(                                
TORDER int identity(1,1) primary key,
TISDATA int,TLEV int,
TKEY varchar(250)null,
TDESC varchar(250)null,
TFORTYP varchar(250)null,
TFORMOD varchar(250)null,
THIDDEN varchar(250)null,
TCOLS varchar(250)null,
TSTBACKGROUND varchar(250)null                            
)        

insert into #Cab          
(TISDATA,TLEV,TKEY,TDESC,TCOLS,TFORTYP,TFORMOD)  values          
(1,1,'vars','Descripción',null,'string',null) 

while @count<=@max
begin
set @nomFecha =(select hfecpro from   #Da where SCODDESCRIP=0 and ord=@count)
--insert into @defs          
insert into #Cab(TISDATA,TLEV,TKEY,TDESC,TCOLS,TFORTYP,TFORMOD)  values          
(@count + 1 ,1,'meta_'+ cast(@count as varchar(250)),'Meta ' + DateName(month,@nomFecha) + ' ' +DateName(year,@nomFecha),null,'number','.2-2'),
(@count + 2 ,1,'real_'+ cast(@count as varchar(250)),'Real ' + DateName(month,@nomFecha) + ' ' +DateName(year,@nomFecha),null,'number','.2-2'),
(@count + 3 ,1,'cumpl'+ cast(@count as varchar(250)),'Cumpl. ' + DateName(month,@nomFecha) + ' ' +DateName(year,@nomFecha),null,'percent','.2-2')

set @count= @count + 1

end
 
 insert into @defs (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD )
 select TORDER,TORDER,TLEV,TKEY,TDESC,TFORTYP,TFORMOD from #Cab

 select rep.FFTHCOLDEF(@defs) result;   


declare  @Query nvarchar(max)                            
SET @Query                            
= N'SELECT  SCODDESCRIP, descripcion  as vars' + NCHAR(10)                                     
 --Después colocamos las columnas que vamos a transponer                                    
 + ( SELECT REPLACE( N',MAX( CASE WHEN ORD = <<ORD>> THEN SMETSEGINC END) AS meta_<<ORD>>                                
    ,MAX( CASE WHEN ORD = <<ORD>> THEN HCOUNT END) AS real_<<ORD>>                                
 ,MAX( CASE WHEN ORD = <<ORD>> THEN Cumpl END) AS cumpl<<ORD>>', N'<<ORD>>', ORD)+ NCHAR(10)                                 
                                    
    FROM  #Da       --select * from #Da                                   
    --Eliminamos duplicados usando GROUP BY                                    
    GROUP BY ord                                    
    --Definimos el orden de las columnas                                    
    ORDER BY ord                                    
    --Usamos esta instrucción para concatenar los valores                                    
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                    
 --Ponemos el resto de la consulta                                    
 + N'FROM  #Da                                   
 group by SCODDESCRIP,descripcion  order by SCODDESCRIP asc  '                                    
                                                            
EXEC sp_Executesql @Query;    
     
 end
