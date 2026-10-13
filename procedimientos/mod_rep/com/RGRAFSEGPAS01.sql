-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-06-27 15:31:08.643000
--exec mod_rep.com.RGRAFSEGPAS01 7,'231','20240618'
CREATE procedure com.RGRAFSEGPAS01
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
select ord,rfec,case when ord=12 then format(cast(rfec as date),'dd-MMM-yy') else format(cast(rfec as date),'MMM-yy') end rfecname
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
from #fec_Cat a  --select * from #fec_Cat
left join #Res b
on cast(a.rfec as varchar(250))=b.descripcion

declare @jsons nvarchar(max)         
 
set @jsons='[{"graphName":"","graphSubName":"","categoryIds":["meses"],"series":[{"baseId":"meses","type":"column","unit_des":"En número","name":"Poliza","cols_data":[1]}]}]'

select @jsons  JsonGraf

select * into #ST from #sss order by rfec asc  --select * from #sss

declare @615 int,@616 int
set @615 =(select isnull([615_num_pol_pasiv],0) from #ST where ord=12)
set @616 =(select isnull([616_num_pol_pasiv],0) from #ST where ord=12)

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
select   'Onco Mensual' as name
       , (select '[' + STRING_AGG(cast(cast([615_num_pol_pasiv] as int) as varchar(20)), ',') WITHIN GROUP(order by rfec asc)  + ']' from #ST) as data
union all
select   'Onco Anual' as name
       , (select '[' + STRING_AGG(cast(cast([616_num_pol_pasiv] as int) as varchar(20)), ',') WITHIN GROUP(order by rfec asc)  + ']' from #ST) as data
),
cta as (
select (
select *
  from X
   for json path)as series
   )
   select @JResult2=series from cta

select  @JResult categories,replace(replace(@JResult2,'"data":"','"data":'),']"',']') series,2 vucle,@615 result615,@616 result616
    
 
end


--select * from storage.com_seg.RETPP003
