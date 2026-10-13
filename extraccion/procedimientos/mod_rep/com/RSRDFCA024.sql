-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-04-04 10:57:50.133000
CREATE PROCEDURE [com].[RSRDFCA024]       
@tipcod varchar(5),@codrel varchar(10),@fec varchar(10)    
AS             
begin            
set nocount on;      
   
;with cte_a as(    
select RFEC      
FROM [storage].[ref].[RCALEN001]        
WHERE RFEC between  dateadd(day, 1, eomonth(@fec, -6))  and @fec and RCIEBT=1 
UNION    
select RFEC=@fec    
)        
select ROW_NUMBER() OVER(ORDER BY RFEC ASC) AS Row#,RFEC     
into #FecMensual --drop table  #FecMensual  select * from #FecMensual    
from cte_a    
    
declare @fecs varchar(max)    
select @fecs=string_agg(RFEC,'","') from #FecMensual    
    
Declare @obtenerdata1 varchar(10),@obtenerdata2 varchar(10),@obtenerdata3 varchar(10),@obtenerdata4 varchar(10),@obtenerdata5 varchar(10),@obtenerdata6 varchar(10)    
    
select * into #CABS from #FecMensual pivot(max(RFEC) for Row# in ([1],[2],[3],[4],[5],[6])) PVT    
    
select @obtenerdata1=[1],@obtenerdata2=[2],@obtenerdata3=[3],@obtenerdata4=[4],@obtenerdata5=[5],@obtenerdata6=[6]    
 from #CABS    -- drop table #CABS    
    
DECLARE @json NVARCHAR(Max)      
     
   set @json = N'[{"level": 1,"columns":[      
         {"columnDef":"descripcion","header": "Descripción","isdata": 1,"sticky":true,"format":{"type":"string"}},      
           {"columnDef":"Ope1","header": "'+@obtenerdata1+'","isdata": 2,"format":{"type":"number","mode":".0-0"}},      
         {"columnDef":"Ope2","header": "'+@obtenerdata2+'","isdata": 3,"format":{"type":"number","mode":".0-0"}},      
         {"columnDef":"Ope3","header": "'+@obtenerdata3+'","isdata": 4,"format":{"type":"number","mode":".0-0"}},      
         {"columnDef":"Ope4","header": "'+@obtenerdata4+'","isdata": 5,"format":{"type":"number","mode":".0-0"}},      
         {"columnDef":"Ope5","header": "'+@obtenerdata5+'","isdata": 6,"format":{"type":"number","mode":".0-0"}},      
         {"columnDef":"Ope6","header": "'+@obtenerdata6+'","isdata": 7,"format":{"type":"number","mode":".0-0"}}]}    
        ]'      
              
   SELECT  LTRIM(RTRIM(@json))     
    
    
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF    
insert into @tvars values         
('num_ope_ce01',null,null,null,null,null)       
         
insert into @tfil        
values ('todos','fec','"'+cast(@fecs as varchar(250))+'"')--,        
    
insert into @tconf        
values ('level_alias','style'),    
  --('insert_to','#report'),    
  ('fec_corr','true')    
    
declare @jer varchar(100)    
insert into @tfil        
exec piv.GPIVLEV01 @tipcod,@codrel,@jer output      
     
select @jer = '"fec"'+ ',' +@jer     
     
create table #T(fila int,cod_fec varchar(250)null,cod_fc varchar(250)null,cod_cter varchar(250)null,style int null, descripcion varchar(250)null,Ope int null)    
insert into #T --drop table #T  select * from #T    
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf --,@show_query=1        
       
select  a.Row# as ID,a.RFEC,isnull(b.cod_cter,'') cod_cter,    
   isnull(b.cod_fec,'') cod_fec,isnull(b.style,'')style,isnull(b.descripcion,'') descripcion,isnull(b.Ope,0) Ope    
into  #Tabla --drop table #Tabla select * from #Tabla    
from  #FecMensual a    
left join (select * from #T where style in(1,0))b    
on   convert(varchar(10),a.RFEC ,112)=b.cod_fec    
    
DECLARE @Query nvarchar(max);    
    
--Primero ponemos las columnas sobre las cuales agruparemos    
SET @Query = N'SELECT style,descripcion' + NCHAR(10)     
--Después colocamos las columnas que vamos a transponer    
+ ( SELECT REPLACE( N',MAX( CASE WHEN id = <<id>> THEN Ope END) AS Ope<<id>>,    
 MAX( CASE WHEN id = <<id>> THEN ''NULL'' ELSE ''#ec9f9f'' END) AS background_<<id>>', N'<<id>>', id)+ NCHAR(10)    
    FROM #Tabla    
    --Eliminamos duplicados usando GROUP BY    
    GROUP BY id    
    --Definimos el orden de las columnas    
    ORDER BY id    
    --Usamos esta instrucción para concatenar los valores    
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')    
--Ponemos el resto de la consulta    
+ N'FROM #Tabla    
where descripcion<>''''    
GROUP BY descripcion,style    
order by style desc    
;'    
    
--Esto es para fines de debugging    
--PRINT @Query    
    
--Ejecutamos el código dinámico    
    
EXEC sp_Executesql @Query;    
end
