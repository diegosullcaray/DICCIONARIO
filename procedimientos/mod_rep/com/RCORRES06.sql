-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-11 11:12:16.780000
--exec [com].[RCORRES06] 7,'231','20210810'                    
CREATE procedure [com].[RCORRES06]                    
@tip_cod int,@cod_rel varchar(20), @fecha date   
AS
BEGIN
set nocount on;  
--declare @tip_cod int=7,@cod_rel varchar(50)='231'
declare @fecMax date 
set @fecMax =(select max(hfeccar) from storage.com.metas_corresponsales)

;with cte_a as (
select * from storage.com.metas_corresponsales
where HFECCAR=@fecMax
),
cte_b as (
select a.hfecpro,CASE WHEN @tip_cod=7 THEN a.HTERDES                  
      WHEN @tip_cod=15 THEN a.HDESCOR                  
      WHEN @tip_cod=14 THEN a.HCODOFI                
      WHEN @tip_cod=4 then a.HCODOFI                 
     END  descripcion,a.hval

from cte_a a
left join (select distinct RDESAGE,RCODMAT,RDESMAT,RCODCOR,RDESCOR,RCODTER,RDESTER 
		   from storage.ref.vjercor03 
		   where case when @tip_cod=7 then 1                  
		              when @tip_cod=15 then RCODTER                  
                      when @tip_cod=14 then RCODCOR                  
                      when @tip_cod=4 then RCODMAT                  
			     end=case when @tip_cod=7 then 1 else @cod_rel end
		   ) b on a.HCODOFI=b.RDESAGE
)
select * into #MC from cte_b

create table #Fec(ORD int identity(1,1) not null, hfecpro date)
insert into #Fec --select*from #Fec
select distinct hfecpro from #MC order by 1 asc  --select * from #MC
alter table #MC add ord int null
update a 
set a.ord=b.ord
from #MC a inner join #Fec b on a.hfecpro=b.hfecpro


SET LANGUAGE Spanish 
declare @defs as rep.TTHCOLDEF;      
insert into @defs                      
(TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS,TISDATA,TSTDEWIDTH,TFORTYP)  values                      
(1,1,'descripcion','Descripción',null,1,1,'10px','string')        

insert into @defs  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND,TSTDEWIDTH)  
select ord,ord+1,1,'V'+cast(ord as varchar(250)),DATENAME(month,EOMONTH(hfecpro))+' '+DATENAME(YEAR,EOMONTH(hfecpro)),'number','.0-0',null,null,null,'60px'
from #Fec 
order by ord asc


select rep.FFTHCOLDEF(@defs) result;  

  declare @Query nvarchar(max)           
 --Primero ponemos las columnas sobre las cuales agruparemos                
 SET @Query = N'SELECT  descripcion' + NCHAR(10)                 
 --Después colocamos las columnas que vamos a transponer                
 + ( SELECT REPLACE( N',sum( CASE WHEN ORD = <<ORD>> THEN hval  END) AS V<<ORD>>', N'<<ORD>>', ord)+ NCHAR(10)                
                
    FROM  #MC                          
    --Eliminamos duplicados usando GROUP BY         
    GROUP BY ord               
    --Definimos el orden de las columnas                
    ORDER BY ORD                
    --Usamos esta instrucción para concatenar los valores                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                
 --Ponemos el resto de la consulta                
 + N'FROM  #MC               
 group by  descripcion '   
EXEC sp_Executesql @Query;  
END
