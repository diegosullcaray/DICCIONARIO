-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-03-22 16:13:55.517000
--EXEC [mod_rep].[com].[RMESA01] '19','1','1'   
CREATE procedure [com].[RDETCORR01]         
@tip_cod int,@cod_rel varchar(20),@fec date,@pagen int=1,@tipo varchar(250) --, @fecha date       
       
AS         
begin        
 set nocount on;          
 declare @defs as rep.TTHCOLDEF;    
     
	 declare @fecc date
	set @fecc=( select max(rfec)  from storage.ref.rcalen001  where rfec<='20240318' and RDIAFER=0)
        
 insert into @defs          
     
   
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values          
    (1,1,1,'HNOMBREPTO','Corresponsales','string',null),          
    (2,2,1,'HTIPOTRN','Tipo Transacción','string',null), 
	(3,3,1,'NRO','Nro','string',null), 
	(4,4,1,'MONTO','Monto','number','.0-0'), 
	(5,5,1,'TICKET','Ticket Promedio','number','.0-0'), 
	(6,6,1,'ULT_FEC_TRX','Ult.Transacción','string',null)               
    
      
 select rep.FFTHCOLDEF(@defs) result;      
  
  
;with cte_maestrocorres as (
select HCODREDEXT,HCODSUC 
from  storage.com_act.HCMC004  --select top 5 * from storage.com_act.HCMC004 where hfecpro='20240318' and  HCODREDEXT=1502
WHERE HFECPRO = @fecc AND HESTCORR = 'AC' AND HFECINSTALA IS NOT NULL
),
cte_corres as (
select b.HCODREDEXT,b.HCODSUC,MAX(HFECHAMOV) ULT_FEC_TRX
from storage.com_act.HCMC001 a 
inner join  cte_maestrocorres b 
on a.HCODIGOCB=b.HCODREDEXT  --select top 5 HCODIGOCB,* from storage.com_act.HCMC001  where hfecpro='2024-03-18' and HCODIGOCB=1502
WHERE HCAUSAL = 'TRANSACCION EXITOSA' 
and hfecpro=@fecc
group by b.HCODREDEXT,b.HCODSUC
),
cte_res as (
SELECT C.HCODIGOCB,C.HNOMBREPTO,HTIPOTRN,u.HCODSUC, COUNT(*) NRO, SUM(HVALORTX) MONTO, AVG(HVALORTX) TICKET , u.ULT_FEC_TRX
FROM storage.com_act.HCMC001 C
RIGHT JOIN cte_corres U ON U.HCODREDEXT=C.HCODIGOCB
WHERE C.HCAUSAL = 'TRANSACCION EXITOSA' AND HFECPRO = @fecc
GROUP BY C.HCODIGOCB,C.HNOMBREPTO,HTIPOTRN,u.ULT_FEC_TRX,u.HCODSUC
) 
select * into #PRE from cte_res --drop table #PRE

 DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT                 
 SET @PageNumber = @pagen                  
 SET @RowspPage = 30; 

 declare @result as table(
 [row] int,HCODIGOCB int null,	HNOMBREPTO varchar(250)null,HTIPOTRN  varchar(250)null,	
 HCODSUC int null,NRO int null,MONTO	float null,TICKET float null,ULT_FEC_TRX  date null  
 )

 ;with cte_a as (
select a.*  
from #PRE a 
left join storage.ref.vjercor03 c
on a.HCODSUC=c.rcodage
where  case when @tip_cod=15 then  ISNULL(cast(c.RCODTER as nvarchar(10)),'9999')               
         when @tip_cod=14 then cast(c.RCODCOR as nvarchar(10))            
         when @tip_cod=4 then cast(c.RCODMAT as varchar(250))                  
         when @tip_cod=16 then cast(c.rcodage as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel) 
and HTIPOTRN=@tipo
)
insert into @result
select               
   row_number() over(order by HCODIGOCB  asc) AS [row], *  
from cte_a

select * from @result ORDER BY [row] asc              
OFFSET ((@PageNumber - 1) * @RowspPage) ROWS                  
FETCH NEXT @RowspPage ROWS ONLY;              
            
select count(*) as Total from @result        
      
end   
  
--select * from storage.com_act.WDMESA001
