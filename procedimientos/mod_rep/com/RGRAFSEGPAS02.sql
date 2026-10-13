-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-01 16:14:23.743000
--exec mod_rep.com.RGRAFSEGPAS02 7,'231','20240618'
CREATE procedure com.RGRAFSEGPAS02
@tip_cod int,
@cod_rel varchar(50),
@fec date
as
begin

set nocount on;      

 SET LANGUAGE spanish;  

declare @fecs varchar(max),@fechaP date
 
set @fechaP=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fec and RDIAFER=0)

select top 11 rfec into #fec from storage.ref.RCALEN001 where RFEC<=@fec and RMES between 1 and 12 and RCIEBT=1 order by rfec desc

;with cte_a as (
select @fechaP rfec  
union all 
select * from #fec 
),
cte_b as (
select ROW_NUMBER() over(order by rfec asc) ord, *   from cte_a
)
select rfec,case when ord=12 then format(cast(rfec as date),'dd-MMM-yy') else format(cast(rfec as date),'MMM-yy') end rfecname
into #fec_Cat
from cte_b

select @fecs=string_agg(convert(varchar(10),RFEC,112),',')            
from #fec_Cat    

declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                        
            --exec STORAGE.[com_pas].[PSLSDPS010] '20230218'            
 insert into @tvars values                         
 ('num_pol_pasiv',null,null,null,null,null)                        
                         
 insert into @tfil                        
 values                        
 ('todos','fec',@fecs)            
                 
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'                        
 declare @jer varchar(100);                      
 insert into @tfil                
 exec piv.GPIVLEV09 @tip_cod,@cod_rel,@jer output                        
                        
 insert into @tconf                        
 values                        
 ('level_alias','style')
 ,('fec','true'),('insert_to', '#T_')                         
                   
 
 --select @jer=@jer+',"Prod_Seg"'   --,"prod_com"    
 select @jer=@jer+',"fec"'   --,"prod_com"    
  

 create table #T_ (
 fila int null,cod_fc varchar(250)null,cod_cter_seg_m varchar(250)null,cod_fec varchar(250)null
 ,style  varchar(250)null,descripcion  varchar(250)null,
  [615_num_pol_pasiv] float null,[616_num_pol_pasiv] float null,[617_num_pol_pasiv] float null,
  [618_num_pol_pasiv] float null,[619_num_pol_pasiv ]float null,[num_pol_pasiv]  float null
 )
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"Prod_Seg","vars"',@config=@tconf--,@show_query=1    
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec","Prod_Seg","vars"',@columns=@jer,@config=@tconf,@show_query=1           

select descripcion,cod_fc, 
SUM(isnull([615_num_pol_pasiv],0))[615_num_pol_pasiv] ,SUM(isnull([616_num_pol_pasiv],0))[616_num_pol_pasiv],
SUM(isnull([617_num_pol_pasiv],0))[617_num_pol_pasiv] ,SUM(isnull([618_num_pol_pasiv],0))[618_num_pol_pasiv],
SUM(isnull([619_num_pol_pasiv],0))[619_num_pol_pasiv] 
into #Res
from #T_
group by descripcion,cod_fc


declare @json nvarchar(max)

select a.*,b.[615_num_pol_pasiv],b.[616_num_pol_pasiv],b.[617_num_pol_pasiv],b.[618_num_pol_pasiv],b.[619_num_pol_pasiv]  
into #sss
from #fec_Cat a
left join #Res b
on cast(a.rfec as varchar(250))=b.descripcion

declare @jsons nvarchar(max)         
 
set @jsons='[{"graphName":"","graphSubName":"","categoryIds":["meses"],"series":[{"baseId":"meses","type":"column","unit_des":"En número","name":"Poliza","cols_data":[1]}]}]'

select @jsons  JsonGraf

select * into #ST from #sss order by rfec asc

;with 
b as (
select (select rfecname   from #ST  order by rfec asc
FOR JSON PATH  ) AS CtaLicenc     
)
select @json=CtaLicenc from b 

declare @JResult nvarchar(max),@JResult2 nvarchar(max)

select @JResult=replace(replace(@json,'{"rfecname":',''),'}','')-- as categories
 
;with
X as (
select   'Multiple Mensual' as name,
          '#304156' as color 
       , (select '[' + STRING_AGG(cast(cast([617_num_pol_pasiv] as int) as varchar(20)), ',') WITHIN GROUP(order by rfec asc)  + ']' from #ST) as data
union all
select   'Multiple Semestral' as name,
          '#0081ff' as color 
       , (select '[' + STRING_AGG(cast(cast([618_num_pol_pasiv] as int) as varchar(20)), ',') WITHIN GROUP(order by rfec asc)  + ']' from #ST) as data
union all
select   'Multiple Anual' as name,
         '#909799' as color 
       , (select '[' + STRING_AGG(cast(cast([619_num_pol_pasiv] as int) as varchar(20)), ',') WITHIN GROUP(order by rfec asc)  + ']' from #ST) as data
),
cta as (
select (
select *
  from X
   for json path)as series
   )
   select @JResult2=series from cta

select  @JResult categories,replace(replace(@JResult2,'"data":"','"data":'),']"',']') series
    
 
end


--select * from storage.com_seg.RETPP003
