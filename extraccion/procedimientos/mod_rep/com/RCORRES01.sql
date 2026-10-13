-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-11 11:14:02.127000
--exec [com].[RCORRES01] 7,'231','20210923'                                  
CREATE procedure [com].[RCORRES01]                                  
@tip_cod int,@cod_rel varchar(20), @fecha date                                 
as                                  
begin                                  
set nocount on;      
  
Declare @FecA date              
 set @FecA=(SELECT  max(RFEC)  FROM [storage].[ref].[RCALEN001] WHERE (RFEC)<=@fecha and RDIAFER = 0)     
  
  DECLARE @FECMIN date     
	set @FECMIN =(select min(hfecpro) from storage.com_act.HCMC001)     
 SELECT  rfec into #FecConsultar   FROM [storage].[ref].[RCALEN001] WHERE (RFEC)between @FECMIN and getdate() -1 and RDIAFER = 0 and RCIEBT=1 
                                 
DECLARE @Query nvarchar(max);DECLARE @Query2 nvarchar(max);                                
SET LANGUAGE Spanish       

      
select /*DENSE_RANK() OVER (ORDER BY SFECPRO asc) AS 'ORD' ,*/ CASE WHEN @tip_cod=7 THEN STERRIT                                   
      WHEN @tip_cod=15 THEN SCORRED                                  
      WHEN @tip_cod=14 THEN SAGENCI                                  
      WHEN @tip_cod=4 then SAGENCI                                   
     END  descripcion,SFECPRO HFECPRO,SCORRES,                                 
       STIPTRA,SNUMTRANS,SMONTO,STICKPROM,SNUMCORRE      INTO #temp1_1 --DROP TABLE #temp1 drop table #Cab  drop table        #subCab                             
   from storage.[com_act].SDAS021 A --select * from storage.[com_act].SDAS021                           
   inner join (select distinct case when @tip_cod=7 then '1'                                
         when @tip_cod=15 then RDESTER                                
         when @tip_cod=14 then RDESCOR                                
         when @tip_cod=4 then RDESMAT                                 
        end RDESJER                                  
     from storage.ref.vjercor03                                 
     where case when @tip_cod=7 then 1                                
       when @tip_cod=15 then RCODTER                                
       when @tip_cod=14 then RCODCOR                                
       when @tip_cod=4 then RCODMAT                                
     end = case when @tip_cod=7 then 1 else @cod_rel end) B                                
 ON CASE WHEN @TIP_COD=7 THEN '1'                                
   WHEN @tip_cod=15 then STERRIT                                 
   when @tip_cod=14 then SCORRED                                
   when @tip_cod=4 then SAGENCI end = B.RDESJER       
      where a.sfecpro in(select rfec from #FecConsultar)     
   
   delete from #temp1_1 where eomonth(HFECPRO)=eomonth(@FecA)

   insert into #temp1_1
select /*DENSE_RANK() OVER (ORDER BY SFECPRO asc) AS 'ORD' ,*/ CASE WHEN @tip_cod=7 THEN STERRIT                                   
      WHEN @tip_cod=15 THEN SCORRED                                  
      WHEN @tip_cod=14 THEN SAGENCI                                  
      WHEN @tip_cod=4 then SAGENCI                                   
     END  descripcion,SFECPRO HFECPRO,SCORRES,                                 
       STIPTRA,SNUMTRANS,SMONTO,STICKPROM,SNUMCORRE   --DROP TABLE #temp1 drop table #Cab  drop table        #subCab                             
   from storage.[com_act].SDAS021 A --select * from storage.[com_act].SDAS021                           
   inner join (select distinct case when @tip_cod=7 then '1'                                
         when @tip_cod=15 then RDESTER                                
         when @tip_cod=14 then RDESCOR                                
         when @tip_cod=4 then RDESMAT                                 
        end RDESJER                                  
     from storage.ref.vjercor03                                 
     where case when @tip_cod=7 then 1                                
       when @tip_cod=15 then RCODTER                                
       when @tip_cod=14 then RCODCOR                                
       when @tip_cod=4 then RCODMAT                                
     end = case when @tip_cod=7 then 1 else @cod_rel end) B                                
 ON CASE WHEN @TIP_COD=7 THEN '1'                                
   WHEN @tip_cod=15 then STERRIT                                 
   when @tip_cod=14 then SCORRED                                
   when @tip_cod=4 then SAGENCI end = B.RDESJER    
   where a.sfecpro=@FecA

   select DENSE_RANK() OVER (ORDER BY hfecpro asc) AS 'ORD',* into #temp1 from #temp1_1

      
 /*      
declare @PD date,@UD date,@MF datetime                  
set @MF=(select max(hfecpro) hfecpro from #temp1)                  
set @PD=(select CONVERT(varchar,dateadd(d,-(day(@MF-1)),@MF),106))                  
set @UD=(select CONVERT(varchar,dateadd(d,-(day(dateadd(m,1,@MF))),dateadd(m,1,@MF)),106) )                  
                  
delete from #temp1 where  HFECPRO in(@MF) and not SFECMOV between @PD and @UD                  
*/                             
--Primero ponemos las columnas sobre las cuales agruparemos                                
SET @Query = N'SELECT top 100 SCORRES NomCorr,STIPTRA HTIPOTRN ' + NCHAR(10)                                 
--Después colocamos las columnas que vamos a transponer                                
+ ( SELECT REPLACE( N',MAX( CASE WHEN ORD = <<ORD>> THEN SNUMTRANS END) AS num_trans<<ORD>>                                
    ,MAX( CASE WHEN ORD = <<ORD>> THEN SMONTO END) AS sum_monto<<ORD>>                                
 ,MAX( CASE WHEN ORD = <<ORD>> THEN STICKPROM END) AS HTICKETPRO<<ORD>>', N'<<ORD>>', ORD)+ NCHAR(10)                                
    FROM #temp1     --DROP TABLE #temp1     SELECT * FROM #temp1                         
    --Eliminamos duplicados usando GROUP BY                                
    GROUP BY ORD                               
 --Definimos el orden de las columnas                                
    ORDER BY ORD                                
    --Usamos esta instrucción para concatenar los valores                                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                
--Ponemos el resto de la consulta                                
+ N'FROM #temp1       
where SCORRES IS NOT NULL                               
GROUP BY SCORRES,STIPTRA order by SCORRES asc;                      
'                                
                                
                     
declare @defs as rep.TTHCOLDEF;                                  
insert into @defs                                    
(TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values                                    
(1,1,'Transacc','Transacciones',null,2)                                  
                                
create table #Cab                                
(                                
TORDER int identity(1,1) primary key,TISDATA int,TLEV int,TKEY varchar(250)null,TDESC varchar(250)null,TFORTYP varchar(250)null,TFORMOD varchar(250)null,THIDDEN varchar(250)null,TCOLS varchar(250)null,TSTBACKGROUND varchar(250)null                        

  
    
     
         
)                                
create table #subCab                                
(                                
TORDER int ,TISDATA int identity(1,1) primary key,TLEV int,TKEY varchar(250)null,TDESC varchar(250)null,TFORTYP varchar(250)null,TFORMOD varchar(250)null,THIDDEN varchar(250)null,TCOLS varchar(250)null,TSTBACKGROUND varchar(250)null                       

  
)                                
insert into #Cab                                
select distinct null,1,HFECPRO,HFECPRO,null,null,null,3,null                                
from #temp1 order by 3 asc                                
                                
insert into #Cab                                
select 1,2,'NomCorr','Nombre','string',null,null,1,null                                
                                
insert into  #Cab                                
select 2,2,'HTIPOTRN','Tipo Transacción','string',null,null,1,null            
                                
declare @count int=1                                
while @count<=(select max(ORD) from #temp1)                                
begin                                
 insert into #Cab                                
 select 2+@count,2,'num_trans'+cast(@count as varchar(40)),'# Transacciones','number','.0-0',null,1,null union all                                
 select 3+@count,2,'sum_monto'+cast(@count as varchar(40)),'Monto','number','.0-0',null,1,null union all                                
 select 4+@count,2,'HTICKETPRO'+cast(@count as varchar(40)),'Ticket Prom','number','.0-0',null,1,null                                
                                
 set @count=@count+1                                
end                                
                                
insert into #subCab                                
select TORDER,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND                                
FROM #Cab                                
where TISDATA IS NOT NULL                              
                                
                                
insert into @defs  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND)                       
select TORDER,TISDATA,TLEV,DATENAME(month,EOMONTH(TKEY))+''+DATENAME(YEAR,EOMONTH(TKEY)),DATENAME(month,EOMONTH(TDESC))+''+DATENAME(YEAR,EOMONTH(TDESC)),TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND                           
from #Cab where TISDATA IS NULL                              
UNION ALL                     
SELECT*FROM #subCab                                
                                
select rep.FFTHCOLDEF(@defs) result;                                   
                                
--Ejecutamos el código dinámico                                
EXEC sp_Executesql @Query;                                
                                  
                                
select format((select count(distinct SCORRES) from #temp1 where SCORRES IS NOT NULL),'N0','en-US') as corresstock,                                
      format(sum(SNUMTRANS),'N0','en-US') transstock,                                
   format(sum(SMONTO),'N0','en-US') montstock,                                 
   format((sum(SMONTO) / sum(SNUMTRANS)),'N0','en-US') tickstock,                                          
   format((select count(distinct SCORRES) from #temp1 where (HFECPRO)=(@FecA) AND SCORRES IS NOT NULL),'N0','en-US') corresmes ,                    
   format((select sum(SNUMTRANS) from #temp1 where (HFECPRO)=(@FecA) AND SCORRES IS NOT NULL),'N0','en-US') transmes ,                                
   format((select sum(SMONTO) from #temp1 where (HFECPRO)=(@FecA) AND SCORRES IS NOT NULL),'N0','en-US') montmes ,                                
   format((select sum(SMONTO) / sum(SNUMTRANS) from #temp1 where (HFECPRO)=(@FecA) AND SCORRES IS NOT NULL),'N0','en-US') tickmes                             
  from #temp1 a         
  WHERE 1=case when @tip_cod=7 then     
         case when a.SCORRES IS NULL then 1 end    
   WHEN @tip_cod<>7 and a.SCORRES IS NOT NULL THEN 1     
   end    
                                
end
