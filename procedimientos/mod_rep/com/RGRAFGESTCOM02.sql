-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-09 19:50:51.073000

--exec [com].[RGRAFGESTCOM01] 7,'231','20260211'  
CREATE PROCEDURE [com].[RGRAFGESTCOM02]    
@tip_cod int,@cod_rel varchar(20),@Fecha varchar(10)   
as  
begin  
 SET NOCOUNT ON;     
--declare @cod_rel varchar(25)='231', @Fecha date='20260211', @tip_cod varchar(5)='7'     
set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end
 
declare @fecs varchar(max)             
     
select top 12 RFEC ,ROW_NUMBER() over(order by rfec desc) ord into #Fechas 
from storage.ref.RCALEN001 where rfec <=@Fecha and RCIEBT=1 order by 1 desc

insert into #Fechas
select max(rfec) rfec,13 
from storage.ref.RCALEN001 where rfec<=@Fecha and RDIAFER=0  order by 1 desc


          
                         
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                        
from #Fechas                        
                        
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)                        
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL                        
                     
                        
insert into @tvars                        
values /*('mon_desem_sf2', null, '133', null, null, null),                        
        ('num_ope_sf2', null, '5006', null, null, null),                        
        ('prod_tot', null, '8070', null, null, null),                        
        ('tick_prom_sf2', null, '134', null, null, null),                        
        ('tapp_mes_sf2', null, '138', null, null, null),                        
        ('tapp_stock_ss1', null, '137', null, null, null),                        
        ('sal_cap', null, '100', null, null, null),                        
        ('canc', null, '136', null, null, null),          */            
        ('sal_vig',null,'saldovigente',   null, null, null)                      
                        
insert into @tfil values ('todos', 'fec', @fecs)                        
insert into @tconf values ('level_alias', 'style'),('insert_to', '#R')               
                        
insert into @tfil                        
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output                        

create table #R
(fila int null,
cod_fec varchar(250)null,
style int null,
descripcion varchar(250) null,
saldovigente float null,
varsaldovigente float null
)
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf--,@show_query=1     

 
update a 
set a.varsaldovigente=b.HVSALVIGMN
from #R a 
inner join  (select hfecpro,HVSALVIGMN 
from storage.com_act.WJAS001 
where hfecpro in(select rfec from #fechas) and htipcod=@tip_cod and hcodrel=@cod_rel
       )b
on a.descripcion=b.hfecpro

-- Declaramos variables para construir las partes del JSON
DECLARE @categories NVARCHAR(MAX);
DECLARE @dataSaldo NVARCHAR(MAX);
DECLARE @dataVariacion NVARCHAR(MAX);

-- 1. Agrupamos las descripciones (eje X) ordenadas por fecha
SELECT @categories = '[' + STRING_AGG('"' + descripcion + '"', ',') WITHIN GROUP (ORDER BY cod_fec) + ']'
FROM #R;

-- 2. Agrupamos los valores de Saldo Vigente
SELECT @dataSaldo = '[' + STRING_AGG(CAST(saldovigente AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY cod_fec) + ']'
FROM #R;

-- 3. Agrupamos los valores de Variación (Manejando los NULL como null de JSON)
SELECT @dataVariacion = '[' + STRING_AGG(ISNULL(CAST(varsaldovigente AS VARCHAR(50)), 'null'), ',') WITHIN GROUP (ORDER BY cod_fec) + ']'
FROM #R;

-- 4. Construimos el objeto final
SELECT 
    JSON_QUERY(@categories) AS categories,
    JSON_QUERY('[
        {"name": "SALDO VIGENTE", "data": ' + @dataSaldo + '},
        {"name": "VARIACIÓN VIGENTE", "data": ' + @dataVariacion + '}
    ]') AS series
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
  
end
