-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:21:31.197000
--exec [com].[GCMGCARTAS001] 'TICHZ100','20251105','1','1'
CREATE PROCEDURE [com].[GCMGCARTAS001](@cod_rel varchar(25), @Fecha date, @tip_cod varchar(5), @met int = 1)
AS  
BEGIN
 SET NOCOUNT ON;
--declare @cod_rel varchar(25)='TICHZ100', @Fecha date='20251105', @tip_cod varchar(5)='1',@prod int=1,  @met int=1         
--------------------------------
DECLARE @fecs VARCHAR(MAX),@fec1 varchar(20),@fec2 varchar(20)

select *
into	#FECS
from	storage.util.FVECFEC01(@Fecha,'cmg_5,cmg_6')  --select * from #FECS

select	@fecs=string_agg(convert(varchar(10),RFEC,112),',')
from	#FECS

select @fec1=rfec from #FECS where rord=1                
select @fec2=rfec from #FECS where rord=2  
  
declare @headers varchar(max)                      
select @headers  ='[                       
   { "label":"Variable (en miles PEN, %, y número)","key":"DESVAL","cellStyle":{"text-align":"left","max-width":"150px","min-width":"150px","width":"150px"}},   
   { "label":"'+FORMAT(CAST(@fec1 AS DATE), 'dd-MMM-yyyy', 'es-ES')+'","key":"1","cellStyle":{"text-align":"right","max-width":"50px","min-width":"50px","width":"50px"}},
   { "label":"'+FORMAT(CAST(@fec2 AS DATE), 'dd-MMM-yyyy', 'es-ES')+'","key":"2","cellStyle":{"text-align":"right","max-width":"50px","min-width":"50px","width":"50px"}},
   { "label":"META","key":"7","cellStyle":{"text-align":"right","max-width":"100px","min-width":"50px","width":"50px"}},       
    { "label":"TMM","key":"9","cellStyle":{"text-align":"right","max-width":"100px","min-width":"50px","width":"50px"}},       
	{ "label":"TAM","key":"13","cellStyle":{"text-align":"right","max-width":"100px","min-width":"50px","width":"50px"}}         
   ] '                          
                    
select @headers  


declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)                          
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL     

                 
insert into @tvars                          
values  --cartera
	    ('mon_desem_sf2', null, '133', null, null, null),                          
        ('num_ope_sf2', null, '5006', null, null, null),                     
        ('tapp_mes_sf2', null, '138', null, null, null),                          
        ('tapp_stock_ss1', null, '137', null, null, null),                          
        ('sal_cap', null, '100', null, null, null),                          
        ('canc', null, '136', null, null, null),                        
        ('sal_vig',null,'199',   null, null, null),
		--cliente
		('num_cli_stock', null, '166', null, null, null),
		('cli_nuev', null, '167', null, null, null),
		---mora
		('efec_m30_0', null, '126', null, null, null),--Efectividad -30-0d
		('efec_1_30', null, '122', null, null, null),--Efectividad 1-30d
		('efec_31_60', null, '124', null, null, null),--Efectividad 31-60d
		('efec_61_90', null, '127', null, null, null),--Efectividad 61-90d
		('efec_91_120', null, '128', null, null, null),	--Efectividad 91-120d
		('efec_121_150', null, '129', null, null, null),--Efectividad 121-150d
		('efec_151_180', null, '130', null, null, null),--Efectividad 151-180d
		('efec_180', null, '131', null, null, null),	--Efectividad 181d a mas
		('efec_jud', null, '132', null, null, null),	--Efectividad Judicial
		('sal_mor_30', null, '9015', null, null, null)	--Cartera Mora > 30
		

insert into @tfil values ('todos', 'fec', @fecs)                        
insert into @tconf values ('level_alias', 'style'),('insert_to', '#DES')                                 
                        
insert into @tfil                        
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output             

create table #DES --select*from #DES                          
( fila int,                          
    cod_fec varchar(250)null,                          
    style int null,                          
    descripcion varchar(250)null,                          
    [133] float null,                          
    [5006] float null,                          
    [138] float null,
	[137] float null,
	[100] float null,
	[136] float null,
	[199] float null,
	[166] float null,
	[167] float null,
	[126] float null,
	[122] float null,
	[124] float null,
	[127] float null,
	[128] float null,
	[129] float null,
	[130] float null,
	[131] float null,
	[132] float null,
	[9015] float null               
)           
                                   
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf--,@show_query=1              

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
            unpivot (valores for variables in([133],[5006],[138],[137],[100],[136],[199],[166],[167],[126],[122],[124],[127],[128],[129],[130],[131],[132],[9015] )) UNPVT     


select  RORD, variables, valores                          
    into    #RESULT01                          
    from    #DES00                          
    UNION                          
    select 7 FORD, B.HCODVAR, B.HVALVAR                          
    FROM    #DES00 A                          
        join [storage].[com].[VDMCOM01] B     --select   * from [storage].[com].[VDMCOM01] where hfecpro='20251031'     and htipcod=2                  
        on A.variables = B.HCODVAR                          
            and B.HTIPMETA = @met                          
            and B.HFECPRO = eomonth(@fecha)                          
            and B.HTIPCOD = case when @tip_cod  =1 then 2 else @tip_cod end                        
            and B.HCODREL = @cod_rel   
			
/*resultados sin API*/ 
 ;with                          
    cte_a as(                          
        select  B.RORD fila, B.RFEC descripcion                                    
    , cast(A.HSALMEDMN as float) [8010]                          
    , cast(A.HVSALMN as float) [8000]                          
    , CAST(a.HVSALVIGMN as float) [9000]             
 ,cast(a.HSALMEDMNVIGE as float)[9009]            
        from    storage.com_act.WJAS001 A  --select distinct htipcod from storage.com_act.WJAS001 where hfecpro='20251031'                         
            join #FECS B                          
            on         a.HFECPRO=B.RFEC                          
            where       A.HTIPCOD=@tip_cod and A.HCODREL=@cod_rel                          
    )          
select *             
    into    #ACUM00                          
    from    #FECS A                          
    left join cte_a B                          
        on   A.RORD=B.fila and A.RFEC=B.descripcion                          
        unpivot (valores for variables in( [8010],[8000],[9000],[9009])) UNPVT        

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
            and B.HTIPCOD = case when @tip_cod=1 then 2 else  @tip_cod end                         
            and B.HCODREL = @cod_rel           

                         
/*UNIFICACION  DE RESULTADOS*/                          
    select *                          
    into #RESULTPRE                        
    from #RESULT01                     
        UNION ALL                          
    select *                          
    from #RESULT02      
	 
/*Comparativos, formatos y presentacion*/                          
    select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                          
    into #AAA                          
    from #RESULTPRE --select*from #RESULTPRE where variables=133                    
        UNION ALL        
    select  case when concat(A.RORD,'-',B.RORD) = '2-1' then 9                             
                when concat(A.RORD,'-',B.RORD) = '2-7' then 13 end RORD                        
            ,A.variables, util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(137,138),1,null)) SVALOR                          
    from #RESULTPRE A                          
        join #RESULTPRE B                          
        on A.variables=B.variables                          
    where concat(A.RORD,'-',B.RORD) in('2-1','2-7')                          
        UNION ALL                          
    select  case when concat(A.RORD,'-',B.RORD) ='2-1' then 8                              
when concat(A.RORD,'-',B.RORD) ='2-7' then 12 end RORD                          
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR                          
    from #RESULTPRE A                          
        join #RESULTPRE B                          
        on A.variables=B.variables                          
    where concat(A.RORD,'-',B.RORD) in('2-1','2-7')       

select *                          
into #RES                          
--select distinct rord from #AAA         
from #AAA pivot (max(SVALOR) for RORD in  ([1],[2],[7],[9],[8],[12],[13])) PVT                          
 
                  
create table #CMG               
(   
    style int null,
    RDESVAR varchar(250),                          
    RCODVAR int                          
)                          
                          
insert into #CMG                          
values
   (1,'Cartera', null)  ,   
    (0,'Saldo de Cartera (miles PEN)', 100),                          
    (0,'Var. Mes Saldo de Cartera (miles PEN)', 8000),                          
    (0,'Saldo de Cartera Vigente (miles PEN)', 199),                          
    (0,'Var. Mes Saldo de Cartera Vigente (miles PEN)', 9000),                          
    (0,'Desembolsos (miles PEN)', 133),                                  
    (0,'Ope. Desembolsadas (Nro)', 5006),                       
    (0,'Cancelaciones Mes (miles PEN)', 136),                              
    (0,'TAPP Stock (%)', 137),                          
    (0,'TAPP Mes (%)', 138),                          
    (0,'Saldo Medio Cartera (miles PEN)', 8010),            
    (0,'Saldo Medio Cartera Vigente(miles PEN)', 9009)  ,  
 --
    (1,'Clientes', null)  ,   
    (0,'Clientes Stock', 166)  ,  
    (0,'Clientes Nuevos', 167),
 
 --
      (1,'Mora', null)  ,   
     (0,'Mora Contable (miles PEN)', 9015),
     (0,'Efectividad -30-0d (%)',126),
	 (0,'Efectividad 1-30d (%)',122),
	 (0,'Efectividad 31-60d (%)',124),
	 (0,'Efectividad 61-90d (%)',127),
	 (0,'Efectividad 91-120d (%)',128),
	 (0,'Efectividad 121-150d (%)',129),
	 (0,'Efectividad 151-180d (%)',130),
	 (0,'Efectividad 181d a mas (%)',131),
	 (0,'Efectividad Judicial (%)',132)

                          

select a.style, A.RDESVAR as DESVAL, [1], [2],  [7], [8], [9],  [12], [13]                          
from #CMG A                          
    left join #RES B  --select * from #RES                         
    on A.RCODVAR=B.variables   

end
