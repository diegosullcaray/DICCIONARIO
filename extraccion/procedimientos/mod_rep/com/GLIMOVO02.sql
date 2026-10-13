-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-09-07 08:23:27.187000

--exec [com].[GLIMOVO02]  2,'00245492','20220822' 
CREATE  PROCEDURE [com].[GLIMOVO02]                      
  @tip_cod int,                              
 @cod_rel varchar(20),                          
 @fec date                         
 as                          
begin                          
  SET NOCOUNT ON;                             
                          
  declare @defs as rep.TTHCOLDEF;                  
  SET LANGUAGE spanish;      
                                      
  insert into @defs                              
  (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TSTBACKGROUND,TSTDEWIDTH)  values                                
  (1,1,1,1,'descripcion','Filtros','string',1,NULL,'80px'),  
  (2,2,1,1,'Calculados','Calculados','number',1,NULL,NULL)                        
  --,(2,2,1,1,'Registros','Registros','number',1,NULL,NULL)                          
  --,(3,3,1,1,'Depurados','Depurados','number',1,NULL,NULL)        
                         
  SET LANGUAGE english;                                                
  select rep.FFTHCOLDEF(@defs) result;   
     
  --declare @tip_cod int = 2,@cod_rel varchar(20)='00245492',@fec date='20220822' 
      
 declare @FecMax as date, @HCODBT as varchar(25), @fp as int = 0      
 set @FecMax=(SELECT max(HFECPRO) FROM STORAGE.[com_act].[HBMOV003])                        
 --por defaul en la plantilla le esta mandando el tip_cod =2      
 --if @tip_cod=2 begin        
 select  top 1 @HCODBT=HCODBT from  [storage].[gpr].[VPPH001] where  HNUMDOC= @cod_rel  --end      
      
 select  top 1 @fp=FLAG_PAGADOR from  STORAGE.[com_act].[HBMOV004] where HFECPRO = @FecMax and CODIGO_BT = @HCODBT and FLAG_PAGADOR = 1  
      
 select       
 count(codigo_bt) TOTAL,      
 sum(case when A.filtro2='SI' then 1 else 0 end ) F2, 
 count(codigo_bt) - sum(case when A.filtro2='si' then 1 else 0 end ) Depf2,
 sum(case when A.filtro3='SI' then 1 else 0 end ) F3,      
 sum(case when A.filtro2='SI' then 1 else 0 end ) - sum(case when A.filtro3='si' then 1 else 0 end ) Depf3,      
 sum(case when A.filtro4='SI' then 1 else 0 end ) F4,      
 sum(case when A.filtro3='SI' then 1 else 0 end ) - sum(case when A.filtro4='si' then 1 else 0 end ) Depf4,      
 sum(case when A.filtro5='SI' then 1 else 0 end ) F5,      
 sum(case when A.filtro4='SI' then 1 else 0 end ) - sum(case when A.filtro5='si' then 1 else 0 end ) Depf5,      
 sum(case when A.filtro6='SI' then 1 else 0 end ) F6,      
 sum(case when A.filtro5='SI' then 1 else 0 end ) - sum(case when A.filtro6='si' then 1 else 0 end ) Depf6,      
 sum(case when A.filtro7='SI' then 1 else 0 end ) F7,      
 sum(case when A.filtro6='SI' then 1 else 0 end ) - sum(case when A.filtro7='si' then 1 else 0 end ) Depf7      
      
 into #resultados      
 from STORAGE.[com_act].[HBMOV003] A      
 where codigo_bt = @HCODBT and HFECPRO = @FecMax      
      
      
    create table #rangos(      
 grupo int,      
 descripcion varchar(250),      
 Registros int,      
 Depurados int      
 )      
 insert into #rangos values (1,'Total de visitas registradas',null,null)      
 insert into #rangos values (2,' - Coordenadas duplicadas (se aceptan hasta  4 decimales iguales)',null,null)      
 insert into #rangos values (3,' - Puntos geolocalizados en domingos o feriados',null,null)      
 insert into #rangos values (4,' - Puntos geolocalizados en  días de vacaciones ó licencias',null,null)      
 insert into #rangos values (5,' - Conversión de puntos a desplazamientos',null,null)      
 insert into #rangos values (6,' - Puntos fuera de la zona de influencia del asesor',null,null)      
 insert into #rangos values (7,' - Desplazamientos diarios  no totalizan como mínimo 400mts',null,null)      
 insert into #rangos values (8,' - Monto a pagar menor a S/5',null,null)      

 update #rangos set Registros = (select TOTAL from #resultados) where grupo =1      
 update #rangos set Depurados = 0 where grupo =1      
 update #rangos set Registros = (select F2 from #resultados) where grupo =2      
 update #rangos set Depurados = (select Depf2 from #resultados) where grupo =2      
 update #rangos set Registros = (select F3 from #resultados) where grupo =3      
 update #rangos set Depurados = (select Depf3 from #resultados) where grupo =3      
 update #rangos set Registros = (select F4 from #resultados) where grupo =4      
 update #rangos set Depurados = (select Depf4 from #resultados) where grupo =4      
 update #rangos set Registros = (select F5 from #resultados) where grupo =5      
 update #rangos set Depurados = (select Depf5 from #resultados) where grupo =5      
 update #rangos set Registros = (select F6 from #resultados) where grupo = 6      
 update #rangos set Depurados = (select Depf6 from #resultados) where grupo =6      
 update #rangos set Registros = (select F7 from #resultados) where grupo = 7      
 update #rangos set Depurados = (select Depf7 from #resultados) where grupo =7      
 if @fp = 1       
  begin       
  update #rangos set Registros = (select Registros from #rangos where grupo = 7) where grupo = 8      
  end      
 if @fp = 0      
  begin       
  update #rangos set Registros = 0 where grupo = 8      
  end      
 update #rangos set Depurados = ((select Registros from #rangos where grupo = 7)-(select Registros from #rangos where grupo = 8)) where grupo =8      
  
  --select * from #rangos
 select grupo,descripcion,  case when grupo =1 then Registros else Depurados *-1 end  Calculados  from #rangos  
 UNION ALL                      
 SELECT NULL,'Total registros Válidos',Registros   from #rangos  where grupo =8  
  
 SET LANGUAGE spanish;                    
 select top 1 max(HFECPRO) as HFECEMI,'blue-text' as style_HFECEMI,DATENAME(mm, max(HFECPRO)) + ' ' + DATENAME(yyyy, max(HFECPRO)) AS Fecha                    
 from STORAGE.[com_act].[HBMOV003]    
 WHERE codigo_bt = @HCODBT  and hfecpro=@FecMax     
                      
  end
