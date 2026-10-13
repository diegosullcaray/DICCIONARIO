-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-11-25 11:46:24.040000
  
--EXEC com.RSEGSECTOR001     7,'231','20210801',0            
CREATE procedure com.RSEGSECTOR001                     
@tip_cod int,                       
@cod_rel varchar(250),                      
@fec date,                      
@grup varchar(50)                      
as                      
begin                      
SET NOCOUNT ON;                
 declare @SemPorcentSec float,@SemPorcentotal float,@SemPorcentSecCarga float,@SemPorcentSecPasajero float ,        
 @Sem1 float,@Sem2 float,@Sem3 float,@Sem4 float,@Sem5 float,@Sem6 float,@Sem7 float,@Sem8 float ,@SemPorcentSecTOtros FLOAT          
 ,@Sem9 float,@Sem10 float,@Sem11 float,@Sem12 float,@Sem13 float,@Sem14 float,@Sem15 float,@Sem16 float,@Sem17 float      
declare @p_fecha_ant date                  
SELECT @p_fecha_ant=MAX(RFEC) FROM [storage].[ref].[RCALEN001] WHERE RDIAFER=0 AND RFEC<=@fec          
          
SET LANGUAGE Spanish                       
declare @defs as rep.TTHCOLDEF;                          
DECLARE @Query nvarchar(max);                              
insert into @defs                                    
(TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS,TROWS,TISDATA)  values                                    
(1,1,'vars','Indicadores',null,1,2,1) ,                      
(2,1,'ind','Periodo de seguimiento',null,10,1,null)                               
                                  
create table #subCab                                
(                                
TORDER int ,TISDATA int identity(2,1) primary key,TLEV int,TKEY varchar(250)null,TDESC varchar(250)null,TFORTYP varchar(250)null,TFORMOD varchar(250)null,THIDDEN varchar(250)null,TCOLS varchar(250)null,TSTBACKGROUND varchar(250)null                       
  
    
      
        
         
)                                
;with a as (                      
 select distinct HFECPRO  from  storage.[com_act].WACIIU0012 where HFECPRO is not null --select top 5* from storage.[com_act].WACIIU0013                      
),                      
B AS (                      
SELECT ROW_NUMBER() OVER(ORDER BY HFECPRO ASC) AS Rowid,HFECPRO                      
FROM A                      
)--sELECT * FROM B                      
insert into #subCab     --drop table #subCab       select * from #subCab                      
select distinct null,2,'Sem'+CAST(Rowid AS VARCHAR(5)),DATENAME(month,EOMONTH(hfecpro))+''+DATENAME(YEAR,EOMONTH(hfecpro)),'traffic-light',null,'true',null,case when Rowid=1 then '#28B8B8' else null end                         
FROM B where Rowid=1                      
union all                      
select distinct null,2,'V'+CAST(Rowid AS VARCHAR(5)),DATENAME(month,EOMONTH(hfecpro))+''+DATENAME(YEAR,EOMONTH(hfecpro)),'number',null,null,2,case when Rowid=1 then '#28B8B8' else null end                                
FROM B where Rowid=1                      
union all                      
select distinct null,2,'Sem'+CAST(Rowid AS VARCHAR(5)),DATENAME(month,EOMONTH(hfecpro))+''+DATENAME(YEAR,EOMONTH(hfecpro)),'traffic-light',null,'true',null,case when Rowid=1 then '#28B8B8' else null end                         
FROM B where Rowid=2                      
union all                      
select distinct null,2,'V'+CAST(Rowid AS VARCHAR(5)),DATENAME(month,EOMONTH(hfecpro))+''+DATENAME(YEAR,EOMONTH(hfecpro)),'number',null,null,case when Rowid=1 then 1 else 2 end,case when Rowid=1 then '#28B8B8' else null end                                
FROM B where Rowid=2                      
union all                      
select distinct null,2,'Sem'+CAST(Rowid AS VARCHAR(5)),DATENAME(month,EOMONTH(hfecpro))+''+DATENAME(YEAR,EOMONTH(hfecpro)),'traffic-light',null,'true',null,case when Rowid=1 then '#28B8B8' else null end                         
FROM B where Rowid=3                      
union all                      
select distinct null,2,'V'+CAST(Rowid AS VARCHAR(5)),DATENAME(month,EOMONTH(hfecpro))+''+DATENAME(YEAR,EOMONTH(hfecpro)),'number',null,null,case when Rowid=1 then 1 else 2 end,case when Rowid=1 then '#28B8B8' else null end                                
FROM B where Rowid=3                      
union all                      
select distinct null,2,'Sem'+CAST(Rowid AS VARCHAR(5)),DATENAME(month,EOMONTH(hfecpro))+''+DATENAME(YEAR,EOMONTH(hfecpro)),'traffic-light',null,'true',null,case when Rowid=1 then '#28B8B8' else null end                         
FROM B where Rowid=4                      
union all                      
select distinct null,2,'V'+CAST(Rowid AS VARCHAR(5)),format(cast(hfecpro as date),'dd-MMM'),'number',null,null,case when Rowid=1 then 1 else 2 end,case when Rowid=1 then '#28B8B8' else null end                                
FROM B where Rowid=4                      
                      
 --ORDER BY 3 ASC                      
--from storage.[com_act].WACIIU0013 order by 3 asc                                
                                             
--select * from storage.[com_act].WACIIU0013                      
                                
insert into @defs  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND)                                    
SELECT TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND  FROM #subCab                                
                                
select rep.FFTHCOLDEF(@defs) result;                         
                  
SET LANGUAGE english                     
        
declare @hcodrel varchar(50)        
        
if @tip_cod=2        
begin        
 set @hcodrel=(select hcodbt from [storage].[gpr].[VPPH001] where HNUMDOC=@cod_rel)--TAARP001  select*from  [storage].[gpr].[VPPH001] where hcodbt='TAARP001'        
  ;with SalCap as (                
 select 1 style,null ORD,'00_Saldo Colocaciones (Miles PEN)' RDESGRUP, null HSALCAPMN,null codvarsFormat               
 union all             
 select null style, ORD ,'01_Total' RDESGRUP ,sum(_TS_1.SalCapi) HSALCAPMN, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1 --select * from storage.[com_act].WACIIU0013 order by 1 desc hfecproc                 
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecpro=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                      
  and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 ),                
 SalCapSector as (                
 select null style,ORD ,'02_'+ _TS_1.RDESGRUP RDESGRUP,_TS_1.RDESGRUP RDESGRUP_,  sum(_TS_1.SalCapi) HSALCAPMN, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                   
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 CuotaVencidaSector as (                
 select 1 style,null ORD,'06_N° Ope Vencidas (Miles PEN)' RDESGRUP, null HCUOVEN,null codvarsFormat                
 union all                
 select null style,ORD,'07_Total'RDESGRUP,                
     SUM(HCUOVEN)HCUOVEN, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                 
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'08_'+ _TS_1.RDESGRUP RDESGRUP,                
     SUM(HCUOVEN)HCUOVEN, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                  
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
                
 ),                
 SaldoVencidoSector as (                
 select 1 style,null ORD,'09_ Saldo Vencido (Miles PEN)' RDESGRUP, null HSALVENMN,null codvarsFormat                
 union all                
 select null style,ORD ,'10_Total' RDESGRUP,                
     SUM(HSALVENMN) HSALVENMN, 9082 codvarsFormat              
 from storage.[com_act].WACIIU0013 _TS_1             
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                   
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'11_'+ _TS_1.RDESGRUP RDESGRUP,                
     SUM(HSALVENMN) HSALVENMN, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                    
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 NDesembolsados as (                
 select 1 style,null ORD,'12_ N° Desembolsos ' RDESGRUP, null NDesembolsados,null codvarsFormat                
 union all                
 select null style,ORD ,'13_Total' RDESGRUP,                
     SUM(NDesembolsados)  NDesembolsados, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                      
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'14_'+ _TS_1.RDESGRUP RDESGRUP,                
     SUM(NDesembolsados)  NDesembolsados, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)              
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 NDesembolsadosNuevos as (                
 select 1 style,null ORD,'15_ N° Desembolsos (Nuevos) ' RDESGRUP, null NDesembolsadosNuevos,null codvarsFormat                
 union all                
 select null style,ORD ,'16_Total' RDESGRUP,                
    SUM(NDesembolsadosNuevos)  as NDesembolsadosNuevos, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)               
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'17_'+ _TS_1.RDESGRUP RDESGRUP,                
    SUM(NDesembolsadosNuevos)  as NDesembolsadosNuevos, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)             
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 NDesembolsadosRecurrentes as (                
 select 1 style,null ORD,'18_ N° Desem. (Recurrente) ' RDESGRUP, null NDesembolsadosRecurrentes,null codvarsFormat                
 union all                
 select null style,ORD ,'19_Total'RDESGRUP,                
    SUM(NDesembolsadosRecurrentes) NDesembolsadosRecurrentes, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                    
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'20_'+ _TS_1.RDESGRUP RDESGRUP,                
    SUM(NDesembolsadosRecurrentes) NDesembolsadosRecurrentes, 9081 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 --                
 MontoDesembolsados as (                
 select 1 style,null ORD,'21_ Monto Desembolsos (Miles PEN)' RDESGRUP, null MontoDesembolsados,null codvarsFormat                
 union all                
 select null style,ORD ,'22_Total'  RDESGRUP,                
     SUM(MontoDesembolsados)  MontoDesembolsados, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                      
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'23_'+ _TS_1.RDESGRUP RDESGRUP,                
     SUM(MontoDesembolsados)  MontoDesembolsados, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 MontoDesembolsadosNuevos as (                
 select 1 style,null ORD,'24_ Monto  Desem. (Nuevos) (Miles PEN)' RDESGRUP, null MontoDesembolsadosNuevos,null codvarsFormat                
 union all                
 select null style,ORD ,'25_Total'  RDESGRUP,                
    SUM(MontoDesembolsadosNuevos)  as MontoDesembolsadosNuevos, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                    
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'26_'+ _TS_1.RDESGRUP RDESGRUP,                
    SUM(MontoDesembolsadosNuevos)  as MontoDesembolsadosNuevos, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                    
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 MontoDesembolsadosRecurrentes as (                
 select 1 style,null ORD,'27_ Monto Desem. (Recurrente) (Miles PEN)' RDESGRUP, null MontoDesembolsadosRecurrentes,null codvarsFormat                
 union all                
 select null style,ORD ,'28_Total' RDESGRUP,                
    SUM(MontoDesembolsadosRecurrentes)MontoDesembolsadosRecurrentes, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)              
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD                
 UNION ALL                
 select null style,ORD ,'29_'+ _TS_1.RDESGRUP RDESGRUP,                
    SUM(MontoDesembolsadosRecurrentes)MontoDesembolsadosRecurrentes, 9082 codvarsFormat                
 from storage.[com_act].WACIIU0013 _TS_1                
 left join storage.[ref].WJERCOR01 _JC on _TS_1.hfecproc=_JC.RFECPRO and   _JC.RCODSEC=_TS_1.HCODSEC and _JC.RINDFEC='ACTUAL'                
 WHERE case when @tip_cod=2 then _JC.RCODSEC else '1' end=IIF(@tip_cod=7,'1',@hcodrel)                    
 and _TS_1.ord in(1,2,3,4)                
 group by _TS_1.ORD,RDESGRUP                
 ),                
 Part as (                
 select 1 style,null ORD,'03_%Part. Sector' RDESGRUP, null HSALCAPMN,null codvarsFormat                
 union all                
  select null style, A.ORD ,'04_Total' RDESGRUP,             sum(B.HSALCAPMN)/(A.HSALCAPMN)  HSALCAPMN ,9080 codvarsFormat                
 from SalCap a inner join SalCapSector b on a.ORD=b.ORD                
 group by A.ORD,A.HSALCAPMN                
 union all                
 select null style, A.ORD ,'05_'+ b.RDESGRUP_ RDESGRUP,                
   B.HSALCAPMN/A.HSALCAPMN  HSALCAPMN ,9080 codvarsFormat                
 from SalCap a inner join SalCapSector b on a.ORD=b.ORD                
 ),        
 RATMORA AS (        
 select 1 style,null ORD,'30_Ratio Mora' RDESGRUP, null HRATMORR,null codvarsFormat           
 /*union all            
 select null style,ORD,'31_TOTAL' RDESGRUP,sum(HRATMORR) ratM,9080 codvarsFormat          
 from STORAGE.com_act.WJAS003 where HTIPCOD =@tip_cod and HCODREL=@cod_rel        
 GROUP BY ORD*/        
 UNION ALL        
 select null style,ORD,'31_'+ RDESGRUP,sum(HRATMORR) ratM,9080 codvarsFormat          
 from STORAGE.com_act.WJAS003 where HTIPCOD =1 and HCODREL=@hcodrel --select * from STORAGE.com_act.WJAS003        
 and RDESGRUP not in('-')        
 GROUP BY ORD,RDESGRUP        
        
 )                
                
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,cast(HSALCAPMN as float) HSALCAPMN  ,util.FFMTVAR(codvarsFormat,HSALCAPMN,null) HSALDOF             
into #SalCap from SalCap  union all  --drop table #SalCap                
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,HSALCAPMN ,util.FFMTVAR(codvarsFormat,HSALCAPMN,null) HSALDOF  from SalCapSector  UNION ALL                
SELECT  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,HSALCAPMN ,util.FFMTVAR(codvarsFormat,HSALCAPMN,null) HSALDOF   FROM Part UNION ALL                
SELECT  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,HCUOVEN ,util.FFMTVAR(codvarsFormat,HCUOVEN,null) HSALDOF    FROM CuotaVencidaSector union all                
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,HSALVENMN ,util.FFMTVAR(codvarsFormat,HSALVENMN,null) HSALDOF     from SaldoVencidoSector union all                
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,NDesembolsados ,util.FFMTVAR(codvarsFormat,NDesembolsados,null) HSALDOF   from NDesembolsados union all                
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,NDesembolsadosNuevos ,util.FFMTVAR(codvarsFormat,NDesembolsadosNuevos,null) HSALDOF          from NDesembolsadosNuevos union all              
  
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,NDesembolsadosRecurrentes ,util.FFMTVAR(codvarsFormat,NDesembolsadosRecurrentes,null) HSALDOF     from NDesembolsadosRecurrentes union all -- 
  
   
      
         
          
           
              
--select* from storage.[com_act].WACIIU0013  drop table #SalCap                
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,MontoDesembolsados ,util.FFMTVAR(codvarsFormat,MontoDesembolsados,null) HSALDOF            from MontoDesembolsados union all                
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,MontoDesembolsadosNuevos ,util.FFMTVAR(codvarsFormat,MontoDesembolsadosNuevos,null) HSALDOF      from MontoDesembolsadosNuevos union all      
  
    
      
        
          
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,MontoDesembolsadosRecurrentes ,util.FFMTVAR(codvarsFormat,MontoDesembolsadosRecurrentes,null) HSALDOF from MontoDesembolsadosRecurrentes      
  
    
      
        
UNION ALL           
select  style,LEFT(RDESGRUP,CHARINDEX('_',RDESGRUP)-1) RORDEN,ORD,RIGHT(RDESGRUP, LEN(RDESGRUP) - 3) AS RDESGRUP,HRATMORR ,util.FFMTVAR(codvarsFormat,HRATMORR,null) HSALDOF from RATMORA                
           
                
                
set @SemPorcentotal =(select HSALCAPMN from #SalCap WHERE RORDEN IN('04') AND ORD=1) --drop table #SalCap                
set @Sem1 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Agropecuario' AND ORD=1 and RORDEN IN('05'))                
set @Sem2 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Comercio' AND ORD=1 and RORDEN IN('05'))                
set @Sem3 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Construcción' AND ORD=1 and RORDEN IN('05'))                
set @Sem4 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Indeterminado' AND ORD=1 and RORDEN IN('05'))                
set @Sem5 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Manufactura' AND ORD=1 and RORDEN IN('05'))                
set @Sem6 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Otros' AND ORD=1 and RORDEN IN('05'))                
set @Sem7 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Servicios' AND ORD=1 and RORDEN IN('05'))                
set @Sem8 =(select HSALCAPMN from #SalCap WHERE RDESGRUP='Transporte' AND ORD=1 and RORDEN IN('05'))                
                
                
SELECT * ,CASE  WHEN RORDEN='05' AND RDESGRUP='Agropecuario' and ORD IN(2,3,4) and HSALCAPMN > @Sem1 then -1               
       WHEN RORDEN='05' AND RDESGRUP='Agropecuario' and ORD IN(2,3,4) and HSALCAPMN < @Sem1 then 1                
             WHEN RORDEN='05' AND RDESGRUP='Comercio' and ORD IN(2,3,4) and HSALCAPMN > @Sem2 then -1               
    WHEN RORDEN='05' AND RDESGRUP='Comercio' and ORD IN(2,3,4) and HSALCAPMN < @Sem2 then 1                   
    WHEN RORDEN='05' AND RDESGRUP='Construcción' and ORD IN(2,3,4) and HSALCAPMN > @Sem3 then -1            
 WHEN RORDEN='05' AND RDESGRUP='Construcción' and ORD IN(2,3,4) and HSALCAPMN < @Sem3 then 1                  
    WHEN RORDEN='05' AND RDESGRUP='Indeterminado' and ORD IN(2,3,4) and HSALCAPMN > @Sem4 then -1                 
 WHEN RORDEN='05' AND RDESGRUP='Indeterminado' and ORD IN(2,3,4) and HSALCAPMN < @Sem4 then 1             
    WHEN RORDEN='05' AND RDESGRUP='Manufactura' and ORD IN(2,3,4) and HSALCAPMN > @Sem5 then -1             
 WHEN RORDEN='05' AND RDESGRUP='Manufactura' and ORD IN(2,3,4) and HSALCAPMN < @Sem5 then 1                  
    WHEN RORDEN='05' AND RDESGRUP='Otros' and ORD IN(2,3,4) and HSALCAPMN > @Sem6 then -1                
 WHEN RORDEN='05' AND RDESGRUP='Otros' and ORD IN(2,3,4) and HSALCAPMN < @Sem6 then 1                 
    WHEN RORDEN='05' AND RDESGRUP='Servicios' and ORD IN(2,3,4) and HSALCAPMN > @Sem7 then -1             
 WHEN RORDEN='05' AND RDESGRUP='Servicios' and ORD IN(2,3,4) and HSALCAPMN < @Sem7 then 1                     
    WHEN RORDEN='05' AND RDESGRUP='Transporte' and ORD IN(2,3,4) and HSALCAPMN > @Sem8 then -1              
 WHEN RORDEN='05' AND RDESGRUP='Transporte' and ORD IN(2,3,4) and HSALCAPMN < @Sem8 then 1                 
    else null end Sem                
into #SalCapS                
FROM #SalCap                
                
                
 --Primero ponemos las columnas sobre las cuales agruparemos                
 SET @Query = N'SELECT style,RORDEN ,  RDESGRUP  as vars' + NCHAR(10)                 
 --Después colocamos las columnas que vamos a transponer                
 + ( SELECT REPLACE( N',MAX( CASE WHEN ORD = <<ORD>> THEN HSALDOF  END) AS V<<ORD>>                
  ,MAX( CASE WHEN ORD = <<ORD>> THEN Sem END) AS Sem<<ORD>>', N'<<ORD>>', ORD)+ NCHAR(10)                
                
    FROM  #SalCapS                
 where ord in(1,2,3,4)                
    --Eliminamos duplicados usando GROUP BY         
    GROUP BY ORD                
    --Definimos el orden de las columnas                
    ORDER BY ORD                
    --Usamos esta instrucción para concatenar los valores                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                
 --Ponemos el resto de la consulta                
 + N'FROM  #SalCapS                
 group by style,RORDEN,RDESGRUP                
 order by RORDEN '                
                
EXEC sp_Executesql @Query;            
end        
else        
begin          
/*            
DECLARE @tip_cod int=7,                     
@cod_rel varchar(250)='231',                    
@fec date='20210624',                    
@grup varchar(50)  ='0'            
-------------------------------            
*/            
--declare @fecha varchar(10);              
--select @fecha='20210624'--(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fec and RDIAFER=0)               
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)              
            
insert into @tvars values                   
 ('sal_colo_',null,null,null,null,null),        
 ('num_cuov_',null,null,null,null,null),    
 ('sald_cuov_',null,null,null,null,null),    
 ('num_desemb_',null,null,null,null,null),    
 ('num_desemb_nuev_',null,null,null,null,null),    
 ('num_desemb_recu_',null,null,null,null,null),    
 ('mont_desemb_nuev_',null,null,null,null,null),    
 ('mont_desemb_sec_',null,null,null,null,null),       
 ('mont_desemb_recu_',null,null,null,null,null)            
                             
  insert into @tfil values ('todos', 'fec','"'+cast(@p_fecha_ant as varchar(50))+'"'+'')          
                      
 declare @jer varchar(100);                  
 insert into @tfil                  
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output                  
     
 select @jer='"grup_ciius","fec_jerciiu"'      
     
 --SELECT @jer='"fc","ccor"' ;                  
 insert into @tconf                  
 values                  
 ('level_alias','style')                  
     
 create table #Resultpre1(fila int null,Grup varchar(250)null,fec date null,style int null,descripcion varchar(250)null,    
 sal_colo_ float null,num_cuov_  float null, sald_cuov_ float null ,num_desemb_ float null, num_desemb_nuev_ float null,num_desemb_recu_ float null,mont_desemb_nuev_ float null,mont_desemb_sec_ float null,mont_desemb_recu_ float null    
  )           
 insert into #Resultpre1  -- drop table #Resultpre1    
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1       
     
 alter table #Resultpre1 --drop table #Resultpre1    
 add Part_Sector float null    
     
 ;with a as (    
 select * from #Resultpre1 where style=0    
 ),    
 b as (    
 select * from #Resultpre1 where style=1    
 ),    
 c as (    
 select a.Grup,a.fec,a.style,a.descripcion,a.sal_colo_/b.sal_colo_ as des_result--,'Part_sector'+a.Grup as res    
 from a a inner join b on a.grup=b.grup    
     
 )     
 update a    
 set a.Part_Sector=b.des_result    
 from #Resultpre1 a inner join c b on a.grup=b.grup and a.fec  =b.fec    
     
    
create table #Resultpre2 (Grup varchar(250) null,fec date null, style int null,descripcion varchar(250) null,result float null,res varchar(250)null)    
insert into #Resultpre2    
SELECT Grup,fec,style,descripcion,des_result,res        
FROM           
   (SELECT Grup,fec,style,descripcion,    
    sal_colo_,num_cuov_,sald_cuov_,num_desemb_,num_desemb_nuev_,num_desemb_recu_,mont_desemb_nuev_,mont_desemb_sec_,mont_desemb_recu_,Part_Sector      
   FROM #Resultpre1    
   where style=0) p          
UNPIVOT          
   (des_result FOR res  IN           
      (sal_colo_,num_cuov_,sald_cuov_,num_desemb_,num_desemb_nuev_,num_desemb_recu_,mont_desemb_nuev_,mont_desemb_sec_,mont_desemb_recu_,Part_Sector  )          
)AS unpvt;      
--drop table #Resultpre1    
    
    
----------------  
Declare @TFec  nvarchar(max)  ,@sql2 nvarchar(max)   
;WITH FEC AS (              
SELECT ROW_NUMBER() OVER(ORDER BY RFEC DESC) AS RowId,*               
FROM [storage].[ref].[RCALEN001]                
WHERE YEAR(RFEC)=year(@fec) AND MONTH(RFEC)<MONTH(@fec) AND RCIEBT=1              
)              
SELECT  @TFec =  COALESCE(@TFec + '","', '') + cast(RFEC as varchar(250))+''              
FROM  FEC                 
WHERE RowId in(1,2,3)              
              
set @TFec = replace('"'+ @TFec + '"','"','''')+','''+cast(@fec as varchar(250))+''''    
  
set @sql2='     
insert into #Resultpre2   
 select RDESGRUP,HFECPRO,0,null,sum(HRATMORR) ratM,''RatMora_''     
 from storage.com_act.WJAS003 where  HTIPCOD ='+cast(@tip_cod as varchar(250))+' and HCODREL='''+cast(@cod_rel as varchar(250))+'''          
 and RDESGRUP not in(''-'')    and hfecpro in('+@TFec+')       
 GROUP BY RDESGRUP,HFECPRO    
 '  
  exec(@sql2)     
   
    
 create table #Fec( id int identity(1,1)not null primary key,fec date null)  insert into #Fec  select  distinct fec from   #Resultpre2  order by 1 asc      
 alter table #Resultpre2 add id int null    
 update a    
 set a.id=b.id    
 from #Resultpre2 a inner join #Fec b on a.fec=b.fec    
 --select * from #Resultpre2 WHERE RES='Part_Sector' AND ID=1     
 set @Sem1 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='ACT.INMOVILIARIA' )                    
set @Sem2 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='ADM.PUBLICA')                    
set @Sem3 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='AGROPECUARIO')                    
set @Sem4 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='COMERCIO')                    
set @Sem5 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='CONSTRUCCION')                    
set @Sem6 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='ELECTRICIDAD')                    
set @Sem7 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='ENSEÑANZA')                    
set @Sem8 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='HOGAR')                   
set @Sem9 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1  and grup='INDETERMINADO')                 
set @Sem10 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='INTERMEDIACION FINANCIERA')                 
set @Sem11 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='MANUFACTURA')                 
set @Sem12 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='MINERIA')                 
set @Sem13 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='OTRAS ACT.SERVICIO')                 
set @Sem14 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='PESCA')                 
set @Sem15 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='SERVICIOS')            
set @Sem16 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='SERVICIOS SOCIALES')            
set @Sem17 =(select result from #Resultpre2 WHERE RES='Part_Sector' AND ID=1 and grup='TRANSPORTE')      
    
alter table #Resultpre2    add sem int null   --select  * from #Resultpre2    
    
select ID,Grup,fec,style,descripcion,result,NULL AS FSAL,RES,    
CASE   WHEN res='Part_Sector' and grup='ACT.INMOVILIARIA' and id IN(2,3,4) and result > @Sem1 then -1                   
       WHEN res='Part_Sector' and grup='ACT.INMOVILIARIA' and id IN(2,3,4) and result < @Sem1 then 1                    
       WHEN res='Part_Sector' and grup='ADM.PUBLICA' and id IN(2,3,4) and result > @Sem2 then -1                   
       WHEN res='Part_Sector' and grup='ADM.PUBLICA' and id IN(2,3,4) and result < @Sem2 then 1                       
       WHEN res='Part_Sector' and grup='AGROPECUARIO' and id IN(2,3,4) and result > @Sem3 then -1                
       WHEN res='Part_Sector' and grup='AGROPECUARIO' and id IN(2,3,4) and result < @Sem3 then 1                      
       WHEN res='Part_Sector' and grup='COMERCIO' and id IN(2,3,4) and result > @Sem4 then -1                     
       WHEN res='Part_Sector' and grup='COMERCIO' and id IN(2,3,4) and result < @Sem4 then 1                 
       WHEN res='Part_Sector' and grup='CONSTRUCCION' and id IN(2,3,4) and result > @Sem5 then -1                 
       WHEN res='Part_Sector' and grup='CONSTRUCCION' and id IN(2,3,4) and result < @Sem5 then 1                      
       WHEN res='Part_Sector' and grup='ELECTRICIDAD' and id IN(2,3,4) and result > @Sem6 then -1       
       WHEN res='Part_Sector' and grup='ELECTRICIDAD' and id IN(2,3,4) and result < @Sem6 then 1                     
       WHEN res='Part_Sector' and grup='ENSEÑANZA' and id IN(2,3,4) and result > @Sem7 then -1                 
       WHEN res='Part_Sector' and grup='ENSEÑANZA' and id IN(2,3,4) and result < @Sem7 then 1                         
       WHEN res='Part_Sector' and grup='HOGAR' and id IN(2,3,4) and result > @Sem8 then -1                  
       WHEN res='Part_Sector' and grup='HOGAR' and id IN(2,3,4) and result < @Sem8 then 1         
    WHEN res='Part_Sector' and grup='INDETERMINADO' and id IN(2,3,4) and result > @Sem9 then -1                  
       WHEN res='Part_Sector' and grup='INDETERMINADO' and id IN(2,3,4) and result < @Sem9 then 1          
    WHEN res='Part_Sector' and grup='INTERMEDIACION FINANCIERA' and id IN(2,3,4) and result > @Sem10 then -1                  
       WHEN res='Part_Sector' and grup='INTERMEDIACION FINANCIERA' and id IN(2,3,4) and result < @Sem10 then 1          
    WHEN res='Part_Sector' and grup='MANUFACTURA' and id IN(2,3,4) and result > @Sem11 then -1                  
       WHEN res='Part_Sector' and grup='MANUFACTURA' and id IN(2,3,4) and result < @Sem11 then 1          
    WHEN res='Part_Sector' and grup='MINERIA' and id IN(2,3,4) and result > @Sem12 then -1                  
       WHEN res='Part_Sector' and grup='MINERIA' and id IN(2,3,4) and result < @Sem12 then 1          
    WHEN res='Part_Sector' and grup='OTRAS ACT.SERVICIO' and id IN(2,3,4) and result > @Sem13 then -1                  
       WHEN res='Part_Sector' and grup='OTRAS ACT.SERVICIO' and id IN(2,3,4) and result < @Sem13 then 1          
    WHEN res='Part_Sector' and grup='PESCA' and id IN(2,3,4) and result > @Sem14 then -1                  
       WHEN res='Part_Sector' and grup='PESCA' and id IN(2,3,4) and result < @Sem14 then 1          
    WHEN res='Part_Sector' and grup='SERVICIOS' and id IN(2,3,4) and result > @Sem15 then -1                  
       WHEN res='Part_Sector' and grup='SERVICIOS' and id IN(2,3,4) and result < @Sem15 then 1          
    WHEN res='Part_Sector' and grup='SERVICIOS SOCIALES' and id IN(2,3,4) and result > @Sem16 then -1                  
       WHEN res='Part_Sector' and grup='SERVICIOS SOCIALES' and id IN(2,3,4) and result < @Sem16 then 1          
    WHEN res='Part_Sector' and grup='TRANSPORTE' and id IN(2,3,4) and result > @Sem17 then -1                  
       WHEN res='Part_Sector' and grup='TRANSPORTE' and id IN(2,3,4) and result < @Sem17 then 1                          
    else null end Sem INTO #SEM          
from #Resultpre2      
    
  /*  
UPDATE A          
SET A.SEM=B.SEM          
FROM #Resultpre2 A INNER JOIN #SEM B          
ON A.RES=B.RES AND A.id=B.id          
WHERE A.id IN(2,3,4)        
*/  
UPDATE A          
SET A.SEM=B.SEM          
FROM #Resultpre2 A INNER JOIN (select * from #SEM where id in(2,3,4) and res='Part_Sector') B          
ON A.RES=B.RES AND   a.id=b.id       and a.grup=b.grup  
WHERE A.id IN(2,3,4)        
    
    
create table #PreResults(style int null,vars varchar(250)null,V1 float null,Sem1 float null,V2 float null,Sem2 float null,V3 float null,Sem3 float null,V4 float null,Sem4 float null )          
     
--DECLARE @Query NVARCHAR(MAX)          
 --Primero ponemos las columnas sobre las cuales agruparemos                    
 SET @Query = N'SELECT style,  RES+''_''+grup  as vars' + NCHAR(10)                     
 --Después colocamos las columnas que vamos a transponer                    
 + ( SELECT REPLACE( N',MAX( CASE WHEN id = <<id>> THEN result  END) AS V<<id>>                    
  ,MAX( CASE WHEN id = <<id>> THEN Sem END) AS Sem<<id>>', N'<<id>>', id)+ NCHAR(10)                    
                    
    FROM  #Resultpre2                    
 where id in(1,2,3,4)                    
    --Eliminamos duplicados usando GROUP BY                    
    GROUP BY id                    
    --Definimos el orden de las columnas                    
    ORDER BY id                    
    --Usamos esta instrucción para concatenar los valores                    
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                    
 --Ponemos el resto de la consulta                    
 + N'FROM  #Resultpre2                    
 group by style,RES+''_''+grup                    
 '                    
insert into #PreResults          
EXEC sp_Executesql @Query;        
    
    
    
select a.ROWI,a.style,a.codvars as vars,util.FFMTVAR(codvarsFormat,v1,null) V1,Sem1,    
 util.FFMTVAR(codvarsFormat,v2,null) V2,Sem2,util.FFMTVAR(codvarsFormat,v3,null) V3,Sem3,util.FFMTVAR(codvarsFormat,v4,null) V4,Sem4           
from  [storage].[ref].ResGridCiiu2 a     --select*from  [storage].[ref].ResGridCiiu2     
left join #PreResults b on a.vars=b.vars        
END    
end
