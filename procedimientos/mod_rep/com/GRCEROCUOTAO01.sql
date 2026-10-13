-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-25 18:45:44.993000
--exec [com].[GRCEROCUOTAO01]   7,'231' 
--exec [com].[GRCEROCUOTAO01]   21,'1'
--exec [com].[GRCEROCUOTAO01]   20,'1_1'
--exec [com].[GRCEROCUOTAO01]   19,'1'                                                  
                                                  
   -- drop table #Fec    drop table #R1 drop table #t                                 
CREATE  PROCEDURE [com].[GRCEROCUOTAO01]  
@tip_cod int,@cod_rel varchar(50) 
as                                                                            
begin                                                                            
  SET NOCOUNT ON;   
  --declare @tip_cod int=7,@cod_rel varchar(50)='231' 
  --declare @tip_cod int=21,@cod_rel varchar(50)='1' 


  declare @fec date
  set @fec=(select max(sfecpro) from storage.[com_act].[SDAS001])
declare @defs as rep.TTHCOLDEF                                                                  
 insert into @defs                                                                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,TFORUNI)  values                                                                   
 (1,1,1,'descripcion','Descripción','string',null,'20px',null),                                                                    
 (2,2,1,'num_cero_2','Nro Operaciones','number',null,null,null),                                                                    
 (3,3,1,'saldo_2','Monto','number',null,null,null),                                                                    
 (4,4,1,'partNum','Variación Operaciones(a)','number',null,null,null),                           
 (5,5,1,'partSaldo','Variación Monto(a)','number','.0-0',null,null),                                     
 (6,6,1,'VarPart','Variación % Participación(b)','number','.0-0',null,'pbs'),                                     
 (7,7,1,'meta_ope_zc','Meta Nro. Operaciones','number',null,null,null),                                     
 (8,8,1,'meta_saldo_zc','Meta Monto Operaciones','number',null,null,null),                                     
 (9,9,1,'var_meta_ope_zc','Var. Meta Nro. Operaciones','number',null,null,null),                                                
 (10,10,1,'var_meta_saldo_zc','Var. Meta Monto Operaciones','number',null,null,null)   

 select rep.FFTHCOLDEF(@defs) result;   

declare @fec_a date,@fecs varchar(max)
 select top 1    
  @fec_a=RFECTXT    
 from storage.ref.RCALEN001    
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0    
 order by RFEC desc
 
 select @fec fec  into #Fec  union all select @fec_a  
  

 select @fecs=string_agg(convert(varchar(10),fec,112),',')  
from #Fec  

declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF


 insert into @tvars values     
 ('num_cero',null,null,null,null,null), 
 ('sal_cero',null,null,null,null,null) ,
 ('num_ope_cc' , null,null,null,null,null)
     
 insert into @tfil    
 values    
 ('todos','fec',@fecs)--,    

 insert into @tconf    
  values    
  ('level_alias','style'),
  --('insert_to','#report'),
  ('fec_corr','true')

  

	declare @jer varchar(100)
 insert into @tfil    
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output   

  create table #R1 (fila int null,cod varchar(250)null,cod_u varchar(250)null,style int null,descripcion varchar(250)null,
				   num_cero_1 int null,num_cero_2 int null,num_ope_cc_1 int null,num_ope_cc_2 int null,saldo_1 float null,saldo_2 float)  
 
  insert into #R1
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1    
 
  select style,descripcion,num_cero_2,saldo_2,
	     num_cero_2-num_cero_1 partNum,saldo_2 - saldo_1 partSaldo,
		 ((num_cero_1)/(1.* num_ope_cc_1)) as Part1,
		 ((num_cero_2)/(1.* num_ope_cc_2)) as Part2,
		 ((((num_cero_2)/(1.* num_ope_cc_2))) - (((num_cero_1)/(1.* num_ope_cc_1))))*10000 VarPart
		 into #T
  from #R1  --select * from #T   select * from #R1
--select *,(Part2 - Part1)*10000 as  from #T


--declare @tip_cod int=21,@cod_rel varchar(50)='1', @fec date = '2022-08-24'
--select * from #WJERCOR3  drop table #WJERCOR3
select  * into #WJERCOR3   --drop table #WJERCOR3
 from  storage.[ref].WJERCOR03 
 where RINDFEC='ACTUAL' and RFECPRO=@fec
 and case when @tip_cod=7 then '1'  
                        when @tip_cod=21 then cast(RCODGRU as varchar(250))  
      when @tip_cod=20 then cast(RCODTER as varchar(250))  
      when @tip_cod=19 then cast(RCODCOR as varchar(250))  
      when @tip_cod=18 then cast(RCODUNI as varchar(250)) end = case when @tip_cod=7 then '1' else @cod_rel end  


--declare @tip_cod int=21,@cod_rel varchar(50)='1', @fec date = '2022-08-24'
--select * from #r2 order by 2 desc  drop table #r2
select distinct(descripcion),style,num_cero_2,saldo_2,partNum,partSaldo,Part1,Part2,VarPart,
case when style = 1 then  @tip_cod else
	  case when @tip_cod=7 then '21'
      when @tip_cod=21 then '20'  
      when @tip_cod=20 then '19'  
      when @tip_cod=19 then '18'  
      when @tip_cod=18 then '0' end  
end HTIPCOD  
into #r2 
from #T  order by 2 desc
 

--declare @tip_cod int=21,@cod_rel varchar(50)='1', @fec date = '2022-08-24'
--select * from #r2 order by 2 desc  drop table #r2  drop table #r3
select distinct(descripcion),style,num_cero_2,saldo_2,partNum,partSaldo,Part1,Part2,VarPart,HTIPCOD,
case when style = 1 then  @cod_rel else
	  case when @tip_cod=7 then cast(RCODGRU as varchar(250))
      when @tip_cod=21 then cast(RCODTER as varchar(250)) 
      when @tip_cod=20 then cast(RCODCOR as varchar(250)) 
      when @tip_cod=19 then cast(RCODUNI as varchar(250))  
      when @tip_cod=18 then '0' end  
end HCODREL  
  into #r3  
from #r2  a
left join #WJERCOR3 b on
a.descripcion = case when HTIPCOD =7 then '231'  
      when HTIPCOD=21 then cast(RDESGRU as varchar(250))  
      when HTIPCOD=20 then cast(RDESTER as varchar(250))  
      when HTIPCOD=19 then cast(RDESCOR as varchar(250))  
      when HTIPCOD=18 then cast(RDESUNI as varchar(250)) end  
order by 2 desc,1 asc


--declare @tip_cod int=21,@cod_rel varchar(50)='1', @fec date = '2022-08-24'
 ;with cte_meta as (
select *
from storage.com.metas_saldos
where htipmeta =1  and hcodvar in(118,120) and hfecpro=eomonth(@fec)
) 

select a.*,
a.num_cero_2 - isnull(case when b.hcodvar=120 then b.hvalvar else null end,0) var_meta_ope_zc,
a.saldo_2 - isnull(case when c.hcodvar=118 then c.hvalvar else null end,0) var_meta_saldo_zc,
case when b.hcodvar=120 then b.hvalvar else null end meta_ope_zc ,
case when c.hcodvar=118 then c.hvalvar else null end meta_saldo_zc 
from #R3 a
left join cte_meta b on a.hcodrel=b.HCODREL and a.HTIPCOD=b.HTIPCOD and b.hcodvar = 120
left join cte_meta c on a.hcodrel=c.HCODREL and a.HTIPCOD=c.HTIPCOD and c.hcodvar = 118
order by 2 desc,1asc
  


			/*

 ;with cte_a as (
select *
from storage.com.metas_saldos
where HTIPCOD=2 and hcodvar in(118,120) and hfecpro=eomonth(@fec)
)
SELECT '0' SCODDESCRIP,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=21 then C.RDESGRU
			when @tip_cod=20 then C.RDESTER
			when @tip_cod=19 then C.RDESCOR
			when @tip_cod=18 then C.RDESUNI END descripcion,
			SUM(A.HVALVAR)  SMETA,hcodvar 
into #MetSeg  --select * from #REPSEG  select * from #MetSeg
FROM cte_a A
LEFT JOIN #WJERCOR3 C 
on A.hcodrel =  C.RCODSEC  
WHERE case when @tip_cod=21 then  ISNULL(cast(c.RDESGRU as nvarchar(10)),'9999')               
         when @tip_cod=20 then cast(c.RDESTER as nvarchar(10))            
         when @tip_cod=19 then C.RDESCOR
			when @tip_cod=18 then C.RDESUNI  else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'
			when @tip_cod=21 then C.RDESGRU
			when @tip_cod=20 then C.RDESTER
			when @tip_cod=19 then C.RDESCOR
			when @tip_cod=18 then C.RDESUNI END,hcodvar

UNION ALL
select CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'9999')
			when @tip_cod=21 then cast(C.RDESTER as varchar(250))
			when @tip_cod=20 then cast(C.RDESCOR as varchar(250))
			when @tip_cod=19 then cast(C.RDESUNI as varchar(250))
			when @tip_cod=18 then cast(C.RCODSEC as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RCODGRU,'SIN ASIGNAR')
			when @tip_cod=21 then C.RCODTER
			when @tip_cod=20 then C.RCODCOR
			when @tip_cod=19 then C.RCODUNI
			when @tip_cod=18 then C.RCODSEC END,SUM(a.HVALVAR)  SMETSEGINC,hcodvar

from cte_a a 
left join #WJERCOR3 C
on a.hcodrel=c.RCODSEC
where  case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')               
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))            
         when @tip_cod=19 then cast(c.RCODCOR as varchar(250))                  
         when @tip_cod=18 then cast(c.RCODUNI as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
GROUP BY CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'9999')
			when @tip_cod=21 then cast(C.RDESTER as varchar(250))
			when @tip_cod=20 then cast(C.RDESCOR as varchar(250))
			when @tip_cod=19 then cast(C.RDESUNI as varchar(250))
			when @tip_cod=18 then cast(C.RCODSEC as varchar(250)) END ,
		 CASE WHEN @tip_cod=7 then ISNULL(C.RCODGRU,'SIN ASIGNAR')
			when @tip_cod=21 then C.RCODTER
			when @tip_cod=20 then C.RCODCOR
			when @tip_cod=19 then C.RCODUNI
			when @tip_cod=18 then C.RCODSEC END,hcodvar


select a.*,
a.num_cero_2 - isnull(case when hcodvar=120 then smeta else null end,0) var_meta_ope_zc,
a.saldo_2 - isnull(case when hcodvar=118 then smeta else null end,0) var_meta_saldo_zc,
case when hcodvar=120 then smeta else null end meta_ope_zc ,
case when hcodvar=118 then smeta else null end meta_saldo_zc 
from  #T a
left join #MetSeg b --select * from #R1
on a.descripcion=b.descripcion  --select * from #MetSeg
 */
end
