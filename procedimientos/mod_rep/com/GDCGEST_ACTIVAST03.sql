-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-14 18:30:22.560000
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST03] '7', '231', 3, '20240319', 1  
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST03] '20', '1_3', 7, '20221022', 0  
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST03] '19', '20', 7, '20221022', 0--CORREDOR  
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST03] '18', '231', 7, '20221022', 0--UNIDAD DE NEGOCIO  
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST03] '18','141','7','20240713','1'

CREATE procedure [com].[GDCGEST_ACTIVAST03]  
 @tip_cod varchar(10), @cod_rel varchar(10), @var int, @fec date, @diario int=0  
as        
begin        
SET NOCOUNT ON;        
        
--DECLARE @tip_cod varchar(10) = 7, @cod_rel varchar(10) = '231', @dim int = 0, @var int = 7, @fec date = '20240713', @diario int = 1--FC      
--DECLARE @tip_cod varchar(10) = 18, @cod_rel varchar(10) = '141', @dim int = 0, @var int = 7, @fec date = '20240713', @diario int = 1--FC        

----DECLARE @tip_cod varchar(10) = 21, @cod_rel varchar(10) = '1', @dim int = 0, @var int = 1, @fec date = '20221025', @diario int = 0--GRUPAL        
----DECLARE @tip_cod varchar(10) = 20, @cod_rel varchar(10) = '1_3', @dim int = 0, @var int = 1, @fec date = '20221025', @diario int = 0--TERRITORIO        
        
declare @fecs varchar(max), @ORD int, @format varchar(10) ,@calc varchar(50), @json nvarchar(max)        
declare @fecs_2 varchar(max), @fecha date        
        
SELECT @fecha = (select max(rfec) from [storage].[ref].[RCALEN001] where RFEC <= @fec and RDIAFER = 0)        
--SELECT @fecha        
--SELECT @calc=iif(@var in(1,2,4),'HNRO',iif(@var in(3,6),'HTAPPMES','HMDES'))        
SELECT @calc = iif(@var in(1, 2, 4, 7), 'HNRO', iif(@var in(3, 6, 8), 'HTAPPMES', 'HMDES'))        
--SELECT @calc        
        
if @var = 7        
 begin        
  select @json=N'[        
        {        
          "level":1,        
          "columns":[        
         {        
            "columnDef":"DESCR",        
            "header":"Producto / Desembolso por Nivel",        
            "isdata":1,        
            "sticky":true,        
            "format":{        
              "type":"string"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"A1",        
            "header":"Encima Tasa M nima",        
            "isdata":2,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"A2",        
            "header":"A la Tasa M nima",        
            "isdata":3,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"auto_comerciales",        
            "header":"Autonomias Comerciales",        
            "cols":4        
                    
         },        
         {        
            "columnDef":"A3",        
            "header":"Total Autonom as",        
            "isdata":8,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"A10",        
            "header":"Total Operaciones",        
            "isdata":9,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"PO",        
            "header":"% Operaciones",        
            "isdata":10,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         }]        
        },        
        {        
          "level":2,        
         "columns":[        
          {        
            "columnDef":"B1",        
            "header":"Administrador",        
            "isdata":4,        
            "format":{        
              "type":"number"      
            }        
         },        
         {        
          "columnDef":"B2",        
          "header":"Gte. Corredor / R. Negocio Grupal",        
          "isdata":5,        
          "format":{        
            "type":"number"        
          }        
        },        
        {        
          "columnDef":"B3",        
"header":"Gte. Territorial",        
          "isdata":6,        
          "format":{        
            "type":"number"        
                   
          }        
        },        
        {        
          "columnDef":"B4",        
          "header":"Gte. Divisi n Comercial",        
          "isdata":7,        
          "format":{        
            "type":"number"        
                   
          }        
        }        
         ]        
        }        
    ]'        
 end        
if @var = 8        
 begin        
  select @json=N'[        
        {        
          "level":1,            "columns":[        
         {        
            "columnDef":"DESCR",        
            "header":"Producto / Desembolso por Nivel",        
            "isdata":1,        
            "sticky":true,        
            "format":{        
              "type":"string"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"A1",        
            "header":"Encima Tasa M nima",        
            "isdata":2,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"A2",        
            "header":"A la Tasa M nima",        
            "isdata":3,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"auto_comerciales",        
            "header":"Autonomias Comerciales",        
            "cols":4        
                    
         },        
         {        
            "columnDef":"A3",        
            "header":"TAPP Autonom as",        
            "isdata":8,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },        
         {        
            "columnDef":"A10",        
            "header":"TAPP Final",        
            "isdata":8,        
            "format":{        
              "type":"number",      
     "style":{"desktop":{"width":"120px"}}          
            },        
            "rows":2  ,    
    "style":{"desktop":{"width":"120px"}}            
         },        
         {        
            "columnDef":"TM",        
            "header":"TAPP M nima",        
            "isdata":9,        
            "format":{        
              "type":"number"        
            },        
            "rows":2        
         },     
   {        
            "columnDef":"FF",        
            "header":"",        
            "isdata":10,   
   "hidden":true,  
            "format":{        
              "type":"traffic-light"        
            }      
         },  
         {        
            "columnDef":"DT",        
            "header":"Distancia (en pbs)",        
            "isdata":11,        
            "format":{        
              "type":"number"        
            },        
            "rows":2,  
   "cols":2  
         }]        
        },        
        {        
          "level":2,        
         "columns":[        
          {        
            "columnDef":"B1",        
            "header":"Administrador",        
            "isdata":4,        
            "format":{        
              "type":"number"        
            }        
         },        
         {        
          "columnDef":"B2",        
          "header":"Gte. Corredor / R. Negocio Grupal",        
          "isdata":5,        
          "format":{        
            "type":"number"        
          }        
        },        
        {        
          "columnDef":"B3",        
          "header":"Gte. Territorial",        
          "isdata":6,        
          "format":{        
            "type":"number"        
                   
          }        
},        
        {        
          "columnDef":"B4",        
          "header":"Gte. Divisi n Comercial",        
          "isdata":7,        
          "format":{        
            "type":"number"                   
          }        
        }        
        ]        
        }        
    ]'        
 end        
         
        
SELECT RFEC, CONCAT(LEFT(RMESNOM, 3), '. ', RIGHT(RANI, 2)) [NomFec]        
INTO #FecList        
from [storage].[ref].[RCALEN001]        
where RFEC = @fecha        
--SELECT RFEC FROM #FecList        
----DROP TABLE #FecList        
        
select @ORD = max(ORD)        
from storage.[com_act].[WGATH002]        
where ORD <= case when @diario = 0 then 100 else 31 end        
--select @ORD        
        
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)        
select @fecs_2=(select replace(cast(max(hfecpro) as varchar(250)),'-','') from [storage].[com_act].WACLI001)        
        
insert into @tvars values ('num_cli_stock', null, '166', null, null, null), ('num_ope_sf2', null, '5006', null, null, null)        
insert into @tfil values ('todos', 'fec', ''+@fecs_2+'')        
insert into @tconf values ('level_alias', 'style')     
insert into @tconf values ('insert_to', '#DES')      
insert into @tfil        
--exec [piv].[GPIVLEV01] @tip_cod, @cod_rel, @jerar output        
exec [piv].[GPIVLEV08] @tip_cod, @cod_rel, @jerar output           
/*  
create table #DES (        
 ORD int null,        
 cod_fc varchar(250) null,        
 cod_cter varchar(250) null,        
 style int null,        
 DESCR varchar(max) null,        
 [166CLI] float null,        
 [5006] float null        
)    
*/  

 



create table dbo.#DES (        
 fila int null,     
 cod_fc varchar(250)null,  
 cod_cter varchar(250) null,     
 cod_ugru varchar(250)null,     
 cod_uter varchar(250) null,        
 cod_ucor varchar(250) null,    
 cod_uuni varchar(250)null,  
 cod_ucoor varchar(250)null,  
 cod_usec varchar(250)null,     
 style int null,        
 descripcion varchar(max) null,        
 [166] float null,    
 [166CLI] float null,         
 [5006] float null        
)       
        
--insert into #DES        
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf-- ,@show_query=1      
 



exec tempdb.sys.sp_rename @objname='dbo.#DES.fila',@newname='ORD',@objtype='COLUMN'      
exec tempdb.sys.sp_rename @objname='dbo.#DES.descripcion',@newname='DESCR',@objtype='COLUMN'  
   
if @tip_cod=7  
begin  
 update #DES set cod_cter=cod_ugru,[166CLI]=[166]  
end  
if @tip_cod=21  
begin  
 update #DES set cod_fc=cod_ugru,cod_cter=cod_uter,[166CLI]=[166]  
end  
if @tip_cod=20  
begin  
 update #DES set cod_fc=cod_uter,cod_cter=cod_ucor,[166CLI]=[166]  
end  
if @tip_cod=19  
begin  
 update #DES set cod_fc=cod_ucor,cod_cter=cod_uuni,[166CLI]=[166]  
end  
if @tip_cod=18  
begin  
 update #DES set cod_fc=cod_uuni,cod_cter=cod_ucoor,[166CLI]=[166]  
end      
if @tip_cod=17  
begin  
 update #DES set cod_fc=cod_ucoor,cod_cter=cod_usec,[166CLI]=[166]  
end    
;  
with  
cte_a  
as  
(  
SELECT A.HFECPRO, A.RDESUNI, A.HUCAP_FIN, A.HGESTTAS, A.RCODCOR, A.RCODGRU, A.RCODUNI, A.RDESGRU, A.RDESCOR,        
   A.RCODTER, A.RDESTER, A.HMDES, A.HTDES, A.HTMIN, A.RCODSEC, A.RDESSEC,A.RCODUCO,A.RDESUCO        
--INTO #cte_a        
from storage.[com_act].[WGATH002] A        
where ORD = @ORD and A.HFECPRO in (select rfec from #FecList)        
)  
,cte_b  
as  
(  
select '0' [STYLE], isnull(cast(HFECPRO as varchar),'TOTAL') HFECPRO        
 , case when @tip_cod = '7' THEN 'FINANCIERA CONFIANZA'        
     when @tip_cod = '20' THEN RDESTER--TERRITORIO        
     when @tip_cod = '19' THEN RDESCOR--CORREDOR        
     when @tip_cod = '21' THEN RDESGRU--GRUPO        
     when @tip_cod = '18' THEN RDESUNI--UNIDAD NEGOCIO     
     when @tip_cod = '17' THEN RDESUCO--coordinador    
   END [AGRUPADOR]        
 , isnull(HUCAP_FIN, 'TOTAL') HUCAP_FIN        
 , isnull(HGESTTAS, 10) HGESTTAS        
 , cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMES        
 , cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMIN        
 , cast(count(*)  as float) HNRO        
 , cast(sum(HMDES) as float) HMDES        
 , cast(sum(HMDES)/count(*) as float) HTPROM        
 --, round((cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -        
 --  cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) )*10000,0) HDIFTAPPMM        
 , round((  
 cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -  
 cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)  
   )*10000,0) HDIFTAPPMM        
--INTO #cte_b        
from cte_a        
where case when @tip_cod = '7' then cast('1' as varchar(10))        
   when @tip_cod = '20' then cast(RCODTER as varchar(10))        
   when @tip_cod = '19' then cast(RCODCOR as varchar(10))        
   when @tip_cod = '21' then cast(RCODGRU as varchar(10))        
   when @tip_cod = '18' then cast(RCODUNI as varchar(10))  
   when @tip_cod = '17' then cast(RCODUCO as varchar(10)) end =        
  case when @tip_cod = '7' then '1' else @cod_rel end        
and HFECPRO <= @fec        
group by HFECPRO, case when @tip_cod ='7' THEN 'FINANCIERA CONFIANZA'        
        when @tip_cod = '20' THEN RDESTER        
        when @tip_cod = '19' THEN RDESCOR        
        when @tip_cod = '21' THEN RDESGRU        
        when @tip_cod = '18' THEN RDESUNI  
        when @tip_cod = '17' THEN RDESUCO        
      END,        
   cube (HUCAP_FIN, HGESTTAS)        
UNION ALL        
select '1' [STYLE], 'TOTAL' HFECPRO        
 , case when @tip_cod = '7' THEN RDESGRU        
     when @tip_cod = '21' THEN RDESTER--GRUPO        
     when @tip_cod = '20' THEN RDESCOR--TERRITORIO        
     when @tip_cod = '19' THEN RDESUNI--CORREDOR        
     when @tip_cod = '18' THEN RDESUCO--UNIDAD NEGOCIO    
      when @tip_cod = '17' THEN  RDESSEC--corredor       
   END [AGRUPADOR]        
 , isnull(HUCAP_FIN, 'TOTAL') HUCAP_FIN        
 , isnull(HGESTTAS, 10) HGESTTAS        
 , cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMES        
 , cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMIN        
 , cast(count(*)  as float) HNRO        
 , cast(sum(HMDES) as float) HMDES        
 , cast(sum(HMDES)/count(*) as float) HTPROM        
 , round((  
 cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -  
 cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)  
 )*10000,0) HDIFTAPPMM        
from cte_a        
where case when @tip_cod = '7' then cast('1' as varchar(10))         
when @tip_cod = '21' then cast(RCODGRU as varchar(10))        
when @tip_cod = '20' then cast(RCODTER as varchar(10))  when @tip_cod = '19' then cast(RCODCOR as varchar(10))        
when @tip_cod = '18' then cast(RCODUNI as varchar(10))  
when @tip_cod = '17' then cast(RCODUCO as varchar(10)) end = case when @tip_cod='7' then '1'        
else @cod_rel end        
and HFECPRO <= @fec        
group by HFECPRO, case when @tip_cod = '7' THEN RDESGRU        
     when @tip_cod = '21' THEN RDESTER--GRUPO        
     when @tip_cod = '20' THEN RDESCOR--TERRITORIO        
     when @tip_cod = '19' THEN RDESUNI--CORREDOR     
     when @tip_cod = '18' THEN RDESUCO--UNIDAD NEGOCIO          
     when @tip_cod = '17' THEN RDESSEC--UNIDAD NEGOCIO        
   END,        
 cube(HUCAP_FIN,HGESTTAS)    
UNION ALL   
 -----------------------------------------------  
 --------------------------------------------------  
 select '-1' [STYLE], 'TOTAL' HFECPRO        
 , case when @tip_cod = '7' THEN RDESGRU        
     when @tip_cod = '21' THEN RDESTER--GRUPO        
     when @tip_cod = '20' THEN RDESCOR--TERRITORIO    
     when @tip_cod = '19' THEN RDESUNI--TERRITORIO    
     when @tip_cod = '18' THEN RDESUCO  
   END [AGRUPADOR]        
 , isnull(HUCAP_FIN, 'TOTAL') HUCAP_FIN        
 , isnull(HGESTTAS, 10) HGESTTAS        
 , cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMES        
 , cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMIN        
 , cast(count(*)  as float) HNRO        
 , cast(sum(HMDES) as float) HMDES        
 , cast(sum(HMDES)/count(*) as float) HTPROM        
 , round((  
 cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -  
 cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)  
 )*10000,0) HDIFTAPPMM        
from cte_a        
where case when @tip_cod = '7' then cast('1' as varchar(10))         
when @tip_cod = '21' then cast(RCODGRU as varchar(10))        
when @tip_cod = '20' then cast(RCODTER as varchar(10))  when @tip_cod = '19' then cast(RCODCOR as varchar(10))        
when @tip_cod = '18' then cast(RCODUNI as varchar(10))  
when @tip_cod = '17' then cast(RCODUCO as varchar(10)) end = case when @tip_cod='7' then '1'        
else @cod_rel end        
and HFECPRO <= @fec        
group by HFECPRO, case when @tip_cod = '7' THEN RDESGRU        
     when @tip_cod = '21' THEN RDESTER--GRUPO        
     when @tip_cod = '20' THEN RDESCOR--TERRITORIO    
     when @tip_cod = '19' THEN RDESUNI--TERRITORIO    
     when @tip_cod = '18' THEN RDESUCO         
   END,        
 cube(HUCAP_FIN,HGESTTAS)        
)  
,cte_c  
as  
(  
select A.*        
 , A.HNRO / (B.HNRO * 1.) HPARTNRO        
 , A.HMDES / (B.HMDES * 1.) HPARTMDES        
--INTO #cte_c        
from cte_b A        
left join cte_b B on B.HGESTTAS=10 and B.HUCAP_FIN='TOTAL' and A.HFECPRO=B.HFECPRO AND A.AGRUPADOR = B.AGRUPADOR        
)  
,cte_d  
as  
(  
select A.*        
    ,(A.HTAPPMES-B.HTAPPMES)*10000 [HVARTAPPMESHIST]        
    ,(A.HPARTNRO-B.HPARTNRO)*10000 [HVARPARTNROHIST]        
    ,(A.HPARTMDES-B.HPARTMDES)*10000 [HVARPARTMDESHIST]         
--INTO #cte_d        
from cte_c A        
left join cte_c B on A.HFECPRO = cast(@fec as varchar) and B.HFECPRO = 'TOTAL' and A.HGESTTAS = B.HGESTTAS and A.HUCAP_FIN = B.HUCAP_FIN AND A.AGRUPADOR = B.AGRUPADOR        
)  
select *        
into #RESULT        
from cte_d A        
unpivot(valores for variables in([HTAPPMIN],[HTAPPMES],[HDIFTAPPMM],[HNRO],[HMDES],[HTPROM],[HPARTNRO],[HPARTMDES],[HVARTAPPMESHIST],[HVARPARTNROHIST],[HVARPARTMDESHIST]) ) UNPTV        
--unpivot(valores for variables in([HTAPPMIN],[HTAPPMES],[HDIFTAPPMM],[HNRO],[HMDES],[HTPROM]) ) UNPTV        
order by 1,2,3        
        
UPDATE #RESULT SET AGRUPADOR='CAJAMARCA_' WHERE AGRUPADOR='CAJAMARCA'AND STYLE=1  
UPDATE #DES SET DESCR='CAJAMARCA_' WHERE style=1 AND DESCR='CAJAMARCA'  
  
select *        
into #C        
from (select * from #RESULT where /*variables=@calc and*/ HUCAP_FIN='TOTAL') A pivot(max(valores) for HGESTTAS in([1],[2],[3],[10])) PVT        
        
--SELECT TOP 10 * FROM #C        
        
select *        
into #D        
from (select * from #RESULT        
   where /*variables=@calc and*/ HGESTTAS=10) A pivot(max(valores) for HUCAP_FIN in([Administrador],[Gerente Corredor / R. Negocio Grupal],[Gerente Territorial],[Gte. Divisi n Comercial],[TOTAL])) PVT        
        
--DECLARE @var int = 8, @calc varchar(50)        
--SELECT @calc = iif(@var in(1, 2, 4, 7), 'HNRO', iif(@var in(3, 6, 8), 'HTAPPMES', 'HMDES'))        
        
select @json result        
        
SELECT DISTINCT A.ORD, A.style,   
 case when A.DESCR='CAJAMARCA_' then 'CAJAMARCA' ELSE A.DESCR END DESCR,        
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(B.[1],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(B.[1],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END [A1],        
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(B.[2],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(B.[2],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END [A2],        
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(C.Administrador,0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(C.Administrador,0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END [B1],        
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(C.[Gerente Corredor / R. Negocio Grupal],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(C.[Gerente Corredor / R. Negocio Grupal],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END 
[B2],  
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(C.[Gerente Territorial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(C.[Gerente Territorial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END [B3],        
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(C.[Gte. Divisi n Comercial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(C.[Gte. Divisi n Comercial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END [B4],        
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(B.[3],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(B.[3],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END [A3],        
 CASE WHEN @var in(1,2,4,7) THEN FORMAT(isnull(B.[10],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'N0') ELSE FORMAT(isnull(B.[10],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0), 'P') END [A10],        
 FORMAT(isnull(B.[3],0)/(iif(B.[10]=0,null,B.[10])*1.0), 'P') [PO],        
 FORMAT(D.[10],'N0') TP,        
 FORMAT(isnull(E.[10],0),'P') TM,        
 FORMAT(isnull(F.[10],0),'N0') DT ,  
 /*  
 CASE WHEN isnull(F.[10],0)> -500 THEN 1  
   WHEN isnull(F.[10],0) BETWEEN -100 AND -500 THEN 0  
   WHEN isnull(F.[10],0)< -100 then -1 end FF    
*/  
 CASE WHEN isnull(F.[10],0)< -500 THEN -1  
   WHEN isnull(F.[10],0) >=0 THEN 1  
   else 0 end FF  
   --WHEN isnull(F.[10],0)< -100 then 1 end FF   
--SELECT *        
FROM #DES A        
left join #C B ON A.DESCR = B.AGRUPADOR AND B.variables = @calc        
left join #D C ON A.DESCR = C.AGRUPADOR AND C.variables = @calc        
left join #C D ON D.variables not in('HVARTAPPMESHIST', 'HVARPARTNROHIST', 'HVARPARTMDESHIST') and D.variables='HTPROM' AND A.DESCR = D.AGRUPADOR         
left join #C E ON E.variables='HTAPPMIN' AND A.DESCR = E.AGRUPADOR         
left join #C F ON F.variables='HDIFTAPPMM' AND A.DESCR = F.AGRUPADOR         
        
--SELECT *        
--FROM #C D        
----WHERE B.AGRUPADOR = 'NOR ANDINO_IND'        
        
        
        
DROP TABLE #FecList--, #cte_a, #cte_b, #cte_c, #cte_d        
DROP TABLE #RESULT, #C, #D, #DES        
        
        
END
