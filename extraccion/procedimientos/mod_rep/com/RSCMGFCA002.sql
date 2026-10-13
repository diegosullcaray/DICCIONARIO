-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-01-12 12:09:12.983000
--EXEC [com].RSCMGFCA002 '231','20250813',7,1,1                        
                     
CREATE PROCEDURE [com].[RSCMGFCA002](@codrel varchar(25), @Fecha date, @tipcod varchar(5), @met int,@prod varchar(250))                       
AS                        
BEGIN                        
 SET NOCOUNT ON;                          
 --           SET LANGUAGE SPANISH
--declare @codrel varchar(25)='231', @Fecha date='20250701', @tipcod varchar(5)='7',@prod int=1,  @met int=1                      
declare @fecs varchar(max) ,              
@fec1 varchar(20),@fec2 varchar(20),@fec3 varchar(20),@fec4 varchar(20),@fec5 varchar(20),              
@fec6 varchar(20)               
                        
select *                        
into #FECS                        
from storage.util.FVECFEC01(@fecha,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')                   
              
select @fec1=rfec from #FECS where rord=1              
select @fec2=rfec from #FECS where rord=2              
select @fec3=rfec from #FECS where rord=3              
select @fec4=rfec from #FECS where rord=4              
select @fec5=rfec from #FECS where rord=5              
select @fec6=rfec from #FECS where rord=6              
              
declare @headers varchar(max)                    
select @headers  ='[                     
   { "label":"Variable (en miles PEN, %, y número)","key":"DESVAL","cellStyle":{"text-align":"left","max-width":"300px","min-width":"300px","width":"300px"}},                    
   { "label":"'+cast(year(@fec1) as varchar)+'","subs":[ {"label": "'+FORMAT(CAST(@fec1 AS DATE), 'dd-MMM', 'es-ES')+'","key":1,"cellStyle":{"text-align":"right"}} ,               
   {"label": "'+FORMAT(CAST(@fec2 AS DATE), 'dd-MMM', 'es-ES')+'","key":"2","cellStyle":{"text-align":"right"}},{"label": "'+FORMAT(CAST(@fec3 AS DATE), 'dd-MMM', 'es-ES')+'","key":"3","cellStyle":{"text-align":"right"}} ]},              
   { "label":"'+cast(year(@fec4) as varchar)+'","subs":[ {"label": "'+FORMAT(CAST(@fec4 AS DATE), 'dd-MMM', 'es-ES')+'","key":"4","cellStyle":{"text-align":"right"} },              
   {"label": "'+FORMAT(CAST(@fec5 AS DATE), 'dd-MMM', 'es-ES')+'","key":"5","cellStyle":{"text-align":"right"} },{"label": "'+FORMAT(CAST(@fec6 AS DATE), 'dd-MMM', 'es-ES')+'","key":"6","cellStyle":{"text-align":"right"}}]},              
   { "label":"META","key":"7","cellStyle":{"text-align":"right"}},                 
   { "label": "TMM", "key": "9","cellStyle": {"text-align": "left"}},              
  { "label": "", "key": "8", "cellStyle": { "display": "none" } },              
                  
                 
   { "label":"TAM","key":"11","cellStyle": {"text-align": "left","font-size": "11px"}},              
   { "label": "", "key": "10", "cellStyle": { "display": "none" } },              
   { "label":"Distancia Meta","key":"13","cellStyle": {"text-align": "left"}},              
    { "label": "", "key": "12", "cellStyle": { "text-align": "left","display": "none" } }              
   ] '                        
               
              
select @headers                  
                        
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                        
from #FECS                        
                        
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)                        
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL                        
              
if @prod=1              
begin              
                        
insert into @tvars                        
values ('mon_desem_sf2', null, '133', null, null, null),                        
        ('num_ope_sf2', null, '5006', null, null, null),                        
        ('prod_tot', null, '8070', null, null, null),                        
        ('tick_prom_sf2', null, '134', null, null, null),                        
        ('tapp_mes_sf2', null, '138', null, null, null),                        
        ('tapp_stock_ss1', null, '137', null, null, null),                        
        ('sal_cap', null, '100', null, null, null),                        
        ('canc', null, '136', null, null, null),                      
        ('sal_vig',null,'199',   null, null, null)                      
                        
insert into @tfil values ('todos', 'fec', @fecs)                        
insert into @tconf values ('level_alias', 'style'),('insert_to', '#DES')                        
                        
insert into @tfil                        
exec [piv].[GPIVLEV01] @tipcod,@codrel,@jerar output                        
                        
create table #DES --select*from #DES                        
( fila int,                        
    cod_fec varchar(250)null,                        
    style int null,                        
    descripcion varchar(250)null,                        
    [133] float null,                        
    [5006] float null,                        
    [8070] float null,                        
    [134] float null,                        
    [138] float null,                        
    [137] float null,                        
    [100] float null,                        
    [136] float null,                      
    [199] float null                       
)                        
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf--,@show_query=1                        
                        
/*PRODUCTIVIDAD IND GRU*/                        
insert into @tfilPRD                        
exec [piv].[GPIVLEV01] @tipcod,@codrel,@jerar output                        
                        
insert into @tvarsPRD                        
values                        
    ('num_ope_sf2', null, null, null, null, null)--,                        
   -- ('ase_dese', null, null, null, null, null)                        
insert into @tconfPRD                        
values                        
    ('level_alias', 'style'),('insert_to','#ProdTip1')                        
                         
create table #ProdTip1                        
(                        
    fila int,                        
    cod_fec varchar(250)null,                        
    style int null,                        
    descripcion varchar(250)null,                        
   /* [AS1] float null,                        
    [AS2] float null,*/                        
    num_ope_sf2_1 float null,                        
    num_ope_sf2_2 float null                        
)                        
                        
--insert into #ProdTip1 --select*from #ProdTip1                        
exec piv.GPIVRES01 @variables=@tvarsPRD,@filters=@tfil,@rows='"fec"',@columns='"vars","prod_tipgru"',@config=@tconfPRD--,@show_query=1                        
   ;with cte_b as (                        
    select B.RORD fila, B.RFEC descripcion,                        
        cast(A.HNUMSECIMES as float) IND,                        
     cast(A.HNUMSECGMES as float) PDM                        
 FROM  storage.com_act.WJAS001 A  --select *  from storage.com_act.WJAS001 A JOIN  #FECS B ON  A.HFECPRO=B.RFEC WHERE HTIPCOD=7 AND HCODREL='231'                        
    join #FECS B                        
    on         a.HFECPRO=B.RFEC                        
    where       A.HTIPCOD=@tipcod and A.HCODREL=@codrel                        
   ),                        
   cte_a as (                        
      select a.fila,a.descripcion,case when (isnull(a.IND,0)*1.0)=0 then 0 else isnull(B.num_ope_sf2_2,0)/(isnull(a.IND,0)*1.0) end [8080],case when (isnull(a.PDM,0)*1.0)=0 then 0 else isnull(b.num_ope_sf2_1,0)/(isnull(a.PDM,0)*1.0) end [8090]            
  
    
     
       
   from cte_b a                        
   join  #ProdTip1 b on a.descripcion=b.descripcion  --SELECT*FROM #ProdTip1                        
   )                        
   /*                        
    ;with  cte_a  as(                        
        select fila, cod_fec, style, descripcion, OP1/(AS1*1.0) [8090], OP2/(AS2*1.0) [8080]                        
        from #ProdTip1                        
    )*/                        
    select *                        
    into #PROD00                        
    from #FECS A                        
  left join cte_a B                        
    on  /*A.RORD=B.fila and*/ A.RFEC=B.descripcion                        
            unpivot(valores for variables in([8090],[8080])) UNPVT                        
                        
    select  RORD, variables, valores                        
    into #RESULT00                        
    from    #PROD00                  
    UNION                        
    select 7 FORD, B.HCODVAR, B.HVALVAR                        
    FROM    #PROD00 A                        
        join [storage].[com].[VDMCOM01] B                        
        on A.variables= B.HCODVAR                        
            and B.HTIPMETA = @met                        
            and B.HFECPRO = eomonth(@fecha)                        
        and B.HTIPCOD = @tipcod                        
            and B.HCODREL = @codrel                        
                        
/*CALCULOS DIRECTO API*/                        
    ;with cte_a as (                        
        select  *, case when [100] =0 then 0 else cast([136] as float)/ [100] end [200]                      
        from    #DES A                                
    )                        
    select *                         
    into    #DES00                        
    from    #FECS A                        
    left join cte_a B                        
        on   /*A.RORD=B.fila and*/ A.RFEC=B.descripcion                        
            unpivot (valores for variables in([133],[5006],[8070],[134],[138],[137],[100],[136],[199],[200])) UNPVT                        
                        
    select  RORD, variables, valores                        
    into    #RESULT01                        
    from    #DES00                        
    UNION                        
    select 7 FORD, B.HCODVAR, B.HVALVAR                        
    FROM    #DES00 A                        
        join [storage].[com].[VDMCOM01] B                        
        on A.variables = B.HCODVAR                        
            and B.HTIPMETA = @met                        
            and B.HFECPRO = eomonth(@fecha)                        
            and B.HTIPCOD = @tipcod                        
            and B.HCODREL = @codrel                        
                        
/*resultados sin API*/                        
--declare @fecha date ='2021-02-15', @tipcod int = 7, @codrel varchar(10)='231'                        
 ;with                        
    cte_a as(                        
        select  B.RORD fila, B.RFEC descripcion                        
    , cast(A.HOPEDESA as float) [8060]                        
    ,cast(A.HMONDESAMN as float) [8330]                         
    , cast(A.HCANAMN as float) [8360]                        
    , cast(A.HSALMEDMN as float) [8010]                        
    , cast(A.HVSALMN as float) [8000]                        
    , CAST(a.HVSALVIGMN as float) [9000]           
 ,cast(a.HSALMEDMNVIGE as float)[9009]          
        from    storage.com_act.WJAS001 A  --select top 10 * from storage.com_act.WJAS001                        
            join #FECS B                        
            on         a.HFECPRO=B.RFEC                        
            where       A.HTIPCOD=@tipcod and A.HCODREL=@codrel                        
    )                        
    select *                         
    into    #ACUM00                        
    from    #FECS A                        
    left join cte_a B                        
        on   A.RORD=B.fila and A.RFEC=B.descripcion                        
        unpivot (valores for variables in([8060],[8330],[8360],[8010],[8000],[9000],[9009])) UNPVT                        
                            
    select  RORD,variables,valores            
    into    #RESULT02                        
    from    #ACUM00                        
    UNION                        
    select 7 FORD, B.HCODVAR, B.HVALVAR                        
    FROM    #ACUM00 A                        
        join [storage].[com].[VDMCOM01] B                        
        on A.variables= B.HCODVAR                        
            and B.HTIPMETA = @met                        
            and B.HFECPRO = eomonth(@fecha)                        
            and B.HTIPCOD = @tipcod                        
            and B.HCODREL = @codrel                        
                        
                            
/*UNIFICACION  DE RESULTADOS*/                        
    select *                        
    into #RESULTPRE                        
    from #RESULT00                        
        UNION ALL                        
    select *                        
    from #RESULT01                   
        UNION ALL                        
    select *                        
    from #RESULT02                        
                        
/*Comparativos, formatos y presentacion*/                        
    select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                        
    into #AAA                        
    from #RESULTPRE --select*from #RESULTPRE use mod_rep;                        
        UNION ALL                        
    select  case when concat(A.RORD,'-',B.RORD) = '6-4' then 9                        
                when concat(A.RORD,'-',B.RORD) = '6-1' then 11                        
                when concat(A.RORD,'-',B.RORD) = '6-7' then 13 end RORD                      
            ,A.variables, util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(137,138),1,null)) SVALOR                        
    from #RESULTPRE A                        
        join #RESULTPRE B                        
        on A.variables=B.variables                        
    where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                        
        UNION ALL                        
    select  case when concat(A.RORD,'-',B.RORD) ='6-4' then 8                        
                when concat(A.RORD,'-',B.RORD) ='6-1' then 10                        
when concat(A.RORD,'-',B.RORD) ='6-7' then 12 end RORD                        
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR                        
    from #RESULTPRE A                        
        join #RESULTPRE B                        
        on A.variables=B.variables                        
    where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')                        
                        
select *                        
into #RES                        
--select * from #AAA                        
from #AAA pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])) PVT                        
                        
                        
create table #CMG             
(   RDESVAR varchar(250),                        
    RCODVAR int                        
)                        
                        
insert into #CMG                        
values('Saldo de Cartera (miles PEN)', 100),                        
    ('Var. Mes Saldo de Cartera (miles PEN)', 8000),                        
    ('Saldo de Cartera Vigente (miles PEN)', 199),                        
    ('Var. Mes Saldo de Cartera Vigente (miles PEN)', 9000),                        
    ('Desembolsos (miles PEN)', 133),                        
    ('Desembolsos Acum. (miles PEN)', 8330),                        
    ('Ope. Desembolsadas (Nro)', 5006),                        
    ('Ope. Desembolsadas Acum (Nro)', 8060),                        
    ('Ticket Promedio (PEN)', 134),                        
    ('Productividad (Nro Prom.)', 8070),                        
    ('Productividad IND (Nro Prom.)', 8080),                        
    ('Productividad PDM (Nro Prom.)', 8090),                
 ('% Cancelaciones Mes (miles PEN)', 200),                   
    ('Cancelaciones Mes (miles PEN)', 136),                        
    ('Cancelaciones Acum. (miles PEN)', 8360),                        
    ('TAPP Stock (%)', 137),                        
    ('TAPP Mes (%)', 138),                        
    ('Saldo Medio Cartera (miles PEN)', 8010),          
 ('Saldo Medio Cartera Vigente(miles PEN)', 9009)          
                        
                        
select A.RDESVAR as DESVAL, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13]                        
from #CMG A                        
    left join #RES B                         
    on A.RCODVAR=B.variables                        
                        
                        
drop table #DES                        
drop table #FECS                        
drop table #AAA                        
drop table #CMG                        
drop table #RES                        
drop table #ProdTip1                        
drop table #PROD00                        
drop table #RESULT00                        
drop table #RESULT01                        
drop table #RESULT02                        
drop table #RESULTPRE          
drop table #DES00                        
drop table #ACUM00                     
              
end              
           
if @prod=2              
begin              
 exec mod_rep.[com].RSCMGFCA001_CFAE @codrel,@Fecha,@tipcod,@met              
end              
if @prod=3              
begin              
exec mod_rep.[com].RSCMGFCA001_SFAE @codrel,@Fecha,@tipcod,@met              
end             
end
