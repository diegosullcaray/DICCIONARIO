-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-02 09:11:24.027000
                
--exec [com].[GRESCAMCOND03]  7,'231','20211101','Monto','Stock',3              
CREATE procedure [com].[GRESCAMCOND03]                  
 @tip_cod varchar(5),@cod_rel varchar(25), @fec date,@tdcrMonto varchar(250),@tdcrMoti varchar(250),@niveles int                
as                  
begin                  
 set nocount on                  
                  
--declare @tip_cod varchar(5)='7',@cod_rel varchar(25)='231', @fec date ='20211027',@tdcrMonto varchar(250)='Monto',@tdcrMoti varchar(250)='Flujo',@niveles int=1                
 declare @FechaMax date    
 select  @FechaMax= '20220531' /*MAX(RFEC)    
    from    storage.[ref].[RCALEN001]    
    where RDIAFER = 0    
        and RFEC <= @fec   */ 
                
 DECLARE @fecs VARCHAR(MAX)    ,@fec2 varchar(250)                
select ROW_NUMBER() OVER(ORDER BY RFECTXT ASC) AS RORD,                
(RFECTXT) RFEC , RFEC FEC                  
into #FECS --                   
from storage.ref.RCALEN001 where RFEC  between cast(DATEADD(MONTH, DATEDIFF(MONTH, 0, @FechaMax), 0) as date)  and  @FechaMax and RDIAFER=0                
/*drop table #TablaTip15 drop table #FECS drop table #Cab drop table #subCab  drop table #ResultPre  drop table #Tabla drop table #Unpivot  drop table #Tabla2 drop table #T                  
drop table #TablaS     drop table #temp3          
*/           
  set @fec2=(select replace(max(fec),'-','') from #FECS)              
              
declare @defs as rep.TTHCOLDEF;                        
declare @countFec  int =(select count(*) from  #FECS)                      
                
create table #Cab                                                
 (                                                
 TORDER int identity(1,1) primary key,TISDATA int,TLEV int,TKEY varchar(250)null,TDESC varchar(250)null,TFORTYP varchar(250)null,TFORMOD varchar(250)null,                
 THIDDEN varchar(250)null,TROWS varchar(250)null,TSTBACKGROUND varchar(250)null ,TCOLS    VARCHAR(250)   NULL                                    
                  
 )                                                
 create table #subCab    --drop table #subCab                                             
 (                                                
 TORDER int ,TISDATA int identity(2,1) primary key,TLEV int,TKEY varchar(250)null,TDESC varchar(250)null,TFORTYP varchar(250)null,TFORMOD varchar(250)null,THIDDEN varchar(250)null,TROWS varchar(250)null,TSTBACKGROUND varchar(250)null                      
              
 )                    
                
 declare @count int=1    , @nombsub varchar(250)                    
            
                
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                      
from #FECS                  
                
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                      
                
if @tdcrMoti ='Stock'                      
begin                
if @tdcrMonto ='Monto'                  
begin                
 if @niveles=3                
 begin                
  insert into @tvars values                       
 ('sal_cap_condo', null, 'COND_CAPITAL', null, null, null),                
 ('sal_int_condo', null, 'COND_INTERES', null, null, null),                
 ('sal_comis_condo', null, 'COND_COMISION', null, null, null),                
 ('Total','cast(isnull(COND_CAPITAL,0)  + isnull(COND_INTERES,0)  +  isnull(COND_COMISION,0) as numeric(17,6))','Total','cal','dp',null)                
 end                
 if @niveles=1                
 begin                
  insert into @tvars values            
 ('sal_cap_condo', null, 'COND_CAPITAL', null, null, null),                
 ('sal_int_condo', null, 'COND_INTERES', null, null, null),                
 ('sal_comis_condo', null, 'COND_COMISION', null, null, null)                
 end            
                  
end                
if @tdcrMonto ='Ncredito'                 
begin             
 if @niveles=3                
 begin                
 insert into @tvars values                       
  ('num_cap_condo', null, 'COND_CAPITAL', null, null, null),                
  ('num_int_condo', null, 'COND_INTERES', null, null, null),                
  ('num_comis_condo', null, 'COND_COMISION', null, null, null),                
  ('Total','cast(isnull(COND_CAPITAL,0)  + isnull(COND_INTERES,0)  +  isnull(COND_COMISION,0) as numeric(17,6))','Total','cal','dp',null)                
  end                
                
  if @niveles=1                
  begin                
   insert into @tvars values                      
  ('num_cap_condo', null, 'COND_CAPITAL', null, null, null),                
  ('num_int_condo', null, 'COND_INTERES', null, null, null),                
  ('num_comis_condo', null, 'COND_COMISION', null, null, null)                
  end                
end                 
                
end                
              
/*Flujo*/              
              
if @tdcrMoti ='Flujo'                      
begin                
if @tdcrMonto ='Monto'                  
begin                
 if @niveles=3                
 begin                
  insert into @tvars values                       
 ('sal_cap_condo_f', null, 'COND_CAPITAL', null, null, null),                
 ('sal_int_condo_f', null, 'COND_INTERES', null, null, null),                
 ('sal_comis_condo_f', null, 'COND_COMISION', null, null, null),                
 ('Total','cast(isnull(COND_CAPITAL,0)  + isnull(COND_INTERES,0)  +  isnull(COND_COMISION,0) as numeric(17,6))','Total','cal','dp',null)                
 end                
 if @niveles=1                
 begin                
  insert into @tvars values                       
 ('sal_cap_condo_f', null, 'COND_CAPITAL', null, null, null),                
 ('sal_int_condo_f', null, 'COND_INTERES', null, null, null),                
 ('sal_comis_condo_f', null, 'COND_COMISION', null, null, null)                
 end                
                  
end                
if @tdcrMonto ='Ncredito'                 
begin                
 if @niveles=3                
 begin                
 insert into @tvars values                       
  ('num_cap_condo_f', null, 'COND_CAPITAL', null, null, null),                
  ('num_int_condo_f', null, 'COND_INTERES', null, null, null),                
  ('num_comis_condo_f', null, 'COND_COMISION', null, null, null),                
  ('Total','cast(isnull(COND_CAPITAL,0)  + isnull(COND_INTERES,0)  +  isnull(COND_COMISION,0) as numeric(17,6))','Total','cal','dp',null)                
  end                
                
  if @niveles=1                
  begin                
   insert into @tvars values                      
  ('num_cap_condo_f', null, 'COND_CAPITAL', null, null, null),                
  ('num_int_condo_f', null, 'COND_INTERES', null, null, null),                
  ('num_comis_condo_f', null, 'COND_COMISION', null, null, null)                
  end                
end                 
                
end              
              
              
/**/              
  if @tdcrMoti='Flujo'              
  begin              
  insert into @tfil values                      
 ('todos','fec','"'+cast(@fec2 as varchar(250))+'"')                    
 --   ('todos', 'fec', @fecs)                  
 end              
 if @tdcrMoti='Stock'              
 begin              
 insert into @tfil values                      
  ('todos', 'fec', @fecs)                
 end              
                
  declare @jer varchar(100);                    
  insert into @tfil                    
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output                    
                      
  insert into @tconf                      
  values                      
  ('level_alias','style') -- , ('insert_to','#Tabla')                
                   
  --select @jer = '"fec_dese"'+ ',' +@jer                 
              
   if @tdcrMoti='Flujo'              
   begin              
                  
  select @jer = '"fec_dese_v"'+ ',' +@jer                 
   end              
   if @tdcrMoti='Stock'              
   begin            
 select @jer = '"fec"'+ ',' +@jer                 
   end              
              
              
   DECLARE @Query nvarchar(max);                
                
 if @niveles=3                
 begin                
   create table #Tabla(                
   fila int,cod_fec_dese varchar(250)null,cod_fc varchar(250)null,cod_cter varchar(250)null,style int null,descripcion varchar(250)null,                
   sal_cap_condo float null,sal_int_condo float null, sal_comis_condo  float null,Total  float null                
   )                            
   create table #TablaTip15(                
   fila int,cod_fec_dese varchar(250)null,cod_fc varchar(250)null,cod_cter varchar(250)null,style int null,descripcion varchar(250)null,                
   sal_cap_condo float null,sal_int_condo float null, sal_comis_condo  float null,Total  float null                
   )                
                
   if @tip_cod='7'                
   begin                
   insert into #Tabla    -- select * from #Tabla                 
   exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1                   
   end                
    if @tip_cod in('15','14','13','18')                
   begin                
    insert into #TablaTip15                   
   exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1                   
                
   insert into #Tabla                
   select fila,cod_fec_dese,cod_fc,cod_cter,style,descripcion,sal_cap_condo,sal_int_condo,sal_comis_condo,Total                 
   from #TablaTip15                
                   
   end                
                  
            
   select  day(cod_fec_dese) id ,a.*               
   into #T     -- select * from #T            
   from #Tabla a      -- select * from #Tabla          
   left join #FECS b on replace(a.cod_fec_dese,'-','')=b.RFEC                
                
                   
   if @tip_cod=7                
   begin                
   delete from #T where style=2              
   end                
    if @tip_cod in('15','14','13','18')                
   begin                
   delete from #T where style=4                
   end                
                   
              
 select b.id as ID,a.RFEC,isnull(b.cod_cter,'') cod_cter,              
 isnull(b.cod_fec_dese,'') cod_fec,isnull(b.style,'')style,isnull(b.descripcion,'') descripcion,              
 ISNULL(sal_cap_condo,0)sal_cap_condo,ISNULL(sal_int_condo,0) sal_int_condo,ISNULL(sal_comis_condo,0)sal_comis_condo,ISNULL(Total ,0)Total              
 into #TablaS --drop table #Tabla  SELECT * FROM #Tabla  drop table #TablaS              
 from #FECS a  -- SELECT * FROM #TablaS             
 left join (select * from #T where style in(1,0))b              
 on a.FEC=b.cod_fec_dese              
         
   /**/               
if @niveles=3                
begin               
                                      
insert into @defs                       
  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS,TCOLS,TSTDEWIDTH)  values                    
 (1,1,1,'descripcion','Descripción','string',1,2,null,'250px') ,              
  (2,null,1,'cond_t','CONDONACION TOTAL',NULL,null,NULL,@countFec,null)                   
           
                                     
                                      
 if @tdcrMoti ='Stock'         
 begin                                                                
 while @count<=(select max(id) from #TablaS)   -- select * from #FECS                                              
 begin         
 -- set @nombsub=(select  FORMAT(fec,'dd/MM') from #FECS where RORD=@count)                  
    insert into #Cab     -- select * from #TablaS                                            
 select distinct 2+@count,2,'Ope'+cast(id as varchar(250)),RIGHT(RTRIM(cod_fec), 2)+'/'+SUBSTRING(CONVERT(nvarchar(6),cod_fec, 112),5,2),'number','.0-0',null,1,null,NULL         
    from #TablaS             
    where   id=@count                                   
    set @count=@count+1         
 end                                                
 end      
 if @tdcrMoti ='Flujo'        
 begin                                                                
 while @count<=(select max(id) from #TablaS)   -- select * from #FECS                                              
 begin         
 -- set @nombsub=(select  FORMAT(fec,'dd/MM') from #FECS where RORD=@count)                  
    insert into #Cab     -- select * from #TablaS                                            
 select distinct 2+@count,2,'Ope'+cast(id as varchar(250)),FORMAT(cast(cod_fec as date),'dd/MM'),'number','.0-0',null,1,null,NULL         
    from #TablaS             
    where   id=@count                                   
    set @count=@count+1         
 end                         
 end                                               
                                                
 insert into #subCab                                  
 select TORDER,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TROWS,TSTBACKGROUND                                                
 FROM #Cab                                                
 where TISDATA IS NOT NULL                                              
                                               
                                                
 insert into @defs  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TROWS,TSTBACKGROUND,TCOLS)                                       
 select TORDER+1,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TROWS,TSTBACKGROUND,TCOLS                                         
 from #Cab where TISDATA IS NULL                                            
 UNION ALL                                   
 SELECT               
 TORDER+1,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,NULL,TSTBACKGROUND,NULL FROM #subCab                                               
                                                
 select rep.FFTHCOLDEF(@defs) result;               
                
                
end              
                
--Primero ponemos las columnas sobre las cuales agruparemos                
SET @Query = N'SELECT style,descripcion' + NCHAR(10)                 
--Después colocamos las columnas que vamos a transponer                
+ ( SELECT REPLACE( N',MAX( CASE WHEN id = <<id>> THEN Total END) AS Ope<<id>>                
 ', N'<<id>>', id)+ NCHAR(10)                
    FROM #TablaS                
    --Eliminamos duplicados usando GROUP BY                
    GROUP BY id                
    --Definimos el orden de las columnas                
    ORDER BY id                
    --Usamos esta instrucción para concatenar los valores                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                
--Ponemos el resto de la consulta                
+ N'FROM #TablaS                
where descripcion<>''''                
GROUP BY descripcion,style                
order by style desc                
;'                
                
--Esto es para fines de debugging                
--PRINT @Query                
                
--Ejecutamos el código dinámico                
                
EXEC sp_Executesql @Query;             
                 
end                
if @niveles=1                
begin                
                
create table #Tabla2(fila int,cod_fec_dese VARCHAR(250)NULL, style INT NULL, descripcion  VARCHAR(250)NULL,                
   [COND_CAPITAL] FLOAT NULL, [COND_INTERES] FLOAT NULL, [COND_COMISION ] FLOAT NULL                
   )                
                
  if @tdcrMoti  ='Flujo'              
  begin              
   insert into #Tabla2                       
   -- exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec_dese"',@columns= '"vars"',@config=@tconf--,@show_query=1                    
    exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec_dese_v"',@columns= '"vars"',@config=@tconf--,@show_query=1                    
   end              
   if @tdcrMoti ='Stock'              
   begin              
   insert into #Tabla2    -- select * from #Tabla2                    
   -- exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec_dese"',@columns= '"vars"',@config=@tconf--,@show_query=1                    
    exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns= '"vars"',@config=@tconf--,@show_query=1                
   end               
    select  * into #temp3  from #Tabla2  truncate table #temp3            
            
   insert into  #temp3            
   select  day(cod_fec_dese),cod_fec_dese,style,descripcion,COND_CAPITAL,COND_INTERES,COND_COMISION             
    from #Tabla2            
            
   ALTER TABLE #temp3                
   ADD [COND_TOTAL] FLOAT NULL                
   --drop table #FECS                
                
   UPDATE #temp3 SET [COND_TOTAL]=   isnull([COND_CAPITAL],0)+ isnull([COND_INTERES],0) + isnull([COND_COMISION],0)                 
                
   SELECT case when condonacion='COND_TOTAL' then 1 else 0 end style,Condonacion,cod_fec_dese,fila,descripcions                
   into #Unpivot   -- drop table #Unpivot              
FROM #temp3 --select * from #temp3              
UNPIVOT                
(                
 descripcions                
 FOR Condonacion in ([COND_CAPITAL],  [COND_INTERES], [COND_COMISION] ,  [COND_TOTAL])                
) AS SchoolUnpivot                
                
               
                
if @niveles=1                
begin                
                                           
 insert into @defs                                                    
 (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS,TROWS,TISDATA,TSTDEWIDTH)  values                                                    
 (1,1,'descripcion','Descripción',null,1,2,1,'250px')                      
         
        
                   
 while @count<=(select max(fila) from #temp3)   -- select * from #temp3                                           
 begin                                         
  --set @nombsub=(select fec from #FECS where RORD=@count)                     
 -- set @nombsub=(select  FORMAT(fec,'dd/MM') from #FECS where RORD=@count)         
                    
  insert into #Cab                                                
 -- select 2+@count,1,'Ope'+cast(@count as varchar(40)),@nombsub,'number','.0-0',null,1,null,NULL       
  --select 2+@count,2,'Ope'+cast(@Count2 as varchar(40)),@nombsub,'number','.0-0',null,1,null,NULL                                          
    select 2+@count,2,'Ope'+cast(fila as varchar(250)),FORMAT(cast(cod_fec_dese as date),'dd/MM'),'number','.0-0',null,1,null,NULL         
   from #temp3             
   where   fila=@count                                   
  set @count=@count+1                                                
 end               
                                       
                        --select * from #Cab  select * from #subCab                  
 insert into #subCab                                                
 select TORDER,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TROWS,TSTBACKGROUND                                                
 FROM #Cab                                                
 where TISDATA IS NOT NULL                                              
                                               
                                                
 insert into @defs  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TROWS,TSTBACKGROUND)                                       
 select TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TROWS,TSTBACKGROUND                                           
 from #Cab where TISDATA IS NULL                                              
 UNION ALL                                     
 SELECT*FROM #subCab                                                
                                                
 select rep.FFTHCOLDEF(@defs) result;         
           
                
                
end                 
                
--Primero ponemos las columnas sobre las cuales agruparemos                
SET @Query = N'SELECT style,case when Condonacion=''COND_TOTAL'' then ''COND.TOTAL''        
            when Condonacion=''COND_CAPITAL'' then ''COND.CAPITAL''        
         when Condonacion=''COND_COMISION '' then ''COND.COMISION''        
         when Condonacion=''COND_INTERES'' then ''COND.INTERES'' END   as descripcion' + NCHAR(10)                 
--Después colocamos las columnas que vamos a transponer                
+ ( SELECT REPLACE( N',MAX( CASE WHEN fila = <<fila>> THEN descripcions END) AS Ope<<fila>>                
 ', N'<<fila>>', fila)+ NCHAR(10)                
    FROM #Unpivot                
    --Eliminamos duplicados usando GROUP BY                
    GROUP BY fila                
    --Definimos el orden de las columnas                
    ORDER BY fila                
    --Usamos esta instrucción para concatenar los valores                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                
--Ponemos el resto de la consulta                
+ N'FROM #Unpivot                
where Condonacion<>''''                
GROUP BY Condonacion,style                
order by style desc              
;'                
                
--Esto es para fines de debugging                
--PRINT @Query                
                
--Ejecutamos el código dinámico                
                
EXEC sp_Executesql @Query;                
                
END           
           
END
