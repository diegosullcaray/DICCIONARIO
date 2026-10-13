-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-04 04:40:05.173000
--EXEC [com].[RINCEGP01]  7,'231'    
CREATE procedure [com].[RINCEGP01]          
@tip_cod int,@cod_rel varchar(20),@fec varchar(8)='NOW'  ,@pagen int=1        
-- declare @tip_cod int=11 , @cod_rel varchar(250)='TACOL001'        
--declare @tip_cod int=7 , @cod_rel varchar(250)='231'        
        
                
AS                  
BEGIN                  
 SET NOCOUNT ON;                  
   -- declare @tip_cod int=11 , @cod_rel varchar(250)='TACOL001', @fec varchar(8)='NOW'     
    -- declare @tip_cod int=21 , @cod_rel varchar(250)='1', @fec varchar(8)='NOW'           
 declare @cf as date,@cf_a as varchar(10)          
                       
 if(@fec='NOW')                  
 begin      
  select @cf=MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())                   
  --select @cf=dateadd(day,-1,getdate())               
  end                  
 else                  
 begin                  
  select @cf=@fec                  
 end               
      
     
               
 declare @defs as rep.TTHCOLDEF;          
        
  insert into @defs                
        
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values           
 (1,1,1,'rdester','Territorio','string',null,null,null,null),        
 (2,1,1,'rdescor','Corredor','string',null,null,null,null),             
    (3,1,1,'rdesuni','Unidad','string',null,null,null,null),        
 (4,2,1,'RDESSEC','Asesor','string',null,null,null,null),              
 (6,3,1,'M_GRUPO','Meta Grupo','number','.0-0',null,'#A72C12',null),        
 (7,3,1,'GrupNu','Avance Grupos nuevos','number','.0-0',null,'#A72C12',null),        
 (8,3,1,'GrupRec','Avance Grupos recurrentes','number','.0-0',null,'#A72C12',null),        
   (9,3,1,'A_MET_GRUPO','% Avance meta grupos','percent','.0-0',null,'#A72C12',null),        
 (10,3,1,'M_VAR_CLI','Meta variaci n de clientes','number','.0-0',null,'#B68A24',null),        
 (11,3,1,'Stock_Ant','Stock clientes cierre mes anterior','number','.0-0',null,'#B68A24',null),        
 (12,3,1,'Stock_F','Stock clientes a la fecha','number','.0-0',null,'#B68A24',null),        
 (13,3,1,'VariacionStock','Avance variaci n de clientes','number','.0-0',null,'#B68A24',null),        
 (14,3,1,'A_MET_VAR','% avance meta variaci n de clientes','percent','.0-0',null,'#B68A24',null) ,    
 (14,3,1,'M_CLI_NUEV','Meta clientes nuevos','number','.0-0',null,'#55B624',null) ,    
 (14,3,1,'clinuev','Avance ','number','.0-0',null,'#55B624',null) ,    
 (14,3,1,'A_CUMPL','% de cumplimiento','percent','.0-0',null,'#55B624',null)      
        
  select rep.FFTHCOLDEF(@defs) result;      
            
  DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT             
  SET @PageNumber = @pagen              
  SET @RowspPage = 30;          
    
  declare @fecH date,@fecMA date    
select @fecH=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@cf and RDIAFER=0)                
select top 1   @fecMA=RFECTXT                  
from storage.ref.RCALEN001                  
where RFEC<=cast(eomonth(@cf,-1) as date) and RDIAFER=0                  
order by RFEC desc     

select distinct HNROG into #GrupAnte  from storage.com_act.HDGP001 where HESTG='ACTIVO' and HESTI='ACTIVO' and HFECPRO<=@fecMA
   
     
select * into #VCAH001 from /*storage.[com_act].VCAH002--*/[storage].[com_act].[VCAH001]    
select * into #VCAM001 from [storage].[com_act].[VCAM001]    

declare @PrimerDíaAct date =( select cast(DATEADD(MONTH, DATEDIFF(MONTH, 0,@fecH), 0) as DATE)  )
declare @PrimerDíaMAnt date =( select cast(DATEADD(MONTH, DATEDIFF(MONTH, 0,@fecMA), 0) as DATE)  )
     
;WITH VGPH001 as    
( select A.*,B.[HSALVENMN],B.[HSALCAPMN],B.[HSALM1MN],B.HFECDES,B.HINDCAR,B.HCODMOD,B.HMONDES,B.HCODMON--,B.HINDMETA    
  from (select *    
  from [storage].[com_act].[HDGP001] A    
  where (HFECPRO)=@fecH    
  and HESTG='ACTIVO' and HESTI='ACTIVO') A    
  left join (select [HCODOPE],sum(HSALVENMN) [HSALVENMN],sum(HSALCAPMN) [HSALCAPMN],
				    sum(case when HDIAATR>0 then HSALCAPMN else 0 end) HSALM1MN,    
				    max(HFECDES) HFECDES,max(HINDCAR) HINDCAR,max(HCODMOD) HCODMOD,
				    max(HCODMON) HCODMON,sum(HMONDES) HMONDES--,max(HINDMETA) HINDMETA    
			 from #VCAH001 group by [HCODOPE]) B    
             on A.[HOPER]=B.[HCODOPE]    
),
VGPH001_D as (
 select a.* from VGPH001  A  
  left join [storage].[com_act].[RFOC001] G  
  on A.[HOPER]=G.RCODOPE and A.[HINDCAR]<>'REFINANCIADO' and A.[HCODMOD]<>110   
  where isnull(G.ROPEFEC,A.HFECDES)>=@PrimerDíaAct
  and HINDCAR='VIGENTE'  
  and A.HOPER not in( select HCODOPE from storage.com_act.HCDR001 where HFECPRO=@fecH and eomonth(HFECREP)=eomonth(HFECPRO)   
  UNION  
  select HCODOPE from storage.com_act.HCDR002 where HFECPRO=@fecH and eomonth(HFECREP)=eomonth(HFECPRO))
) ,   
VGPM001 as (    
select A.*,B.[HSALVENMN],B.[HSALCAPMN],B.[HSALM1MN],B.HFECDES,B.HINDCAR,B.HCODMOD,B.HMONDES,B.HCODMON--,B.HINDMETA    
  from (select *    
  from [storage].[com_act].[HDGP001] A    
  where (HFECPRO)=@fecMA    
  and HESTG='ACTIVO' and HESTI='ACTIVO') A    
  left join (select [HCODOPE],sum(HSALVENMN) [HSALVENMN],sum(HSALCAPMN) [HSALCAPMN],sum(case when HDIAATR>0 then HSALCAPMN else 0 end) HSALM1MN,    
  max(HFECDES) HFECDES,max(HINDCAR) HINDCAR,max(HCODMOD) HCODMOD,max(HCODMON) HCODMON,sum(HMONDES) HMONDES--,max(HINDMETA) HINDMETA    
  from #VCAM001 group by [HCODOPE]) B    
  on A.[HOPER]=B.[HCODOPE]    
),   
VGPM001_D as (
select a.* from VGPM001  A  
  left join [storage].[com_act].[RFOC001] G  
  on A.[HOPER]=G.RCODOPE and A.[HINDCAR]<>'REFINANCIADO' and A.[HCODMOD]<>110   
  where isnull(G.ROPEFEC,A.HFECDES)>=@PrimerDíaMAnt 
  and HINDCAR='VIGENTE'  
  and A.HOPER not in( select HCODOPE from storage.com_act.HCDR001 where HFECPRO=@fecMA and eomonth(HFECREP)=eomonth(HFECPRO)   
  UNION  
  select HCODOPE from storage.com_act.HCDR002 where HFECPRO=@fecMA and eomonth(HFECREP)=eomonth(HFECPRO))
) ,
CTE_DIF AS (     
select DISTINCT A.HFECPRO,A.HCODA,A.HNROG,ISNULL(B.HNROG,0) HNROGM    
from VGPH001_D A    
LEFT JOIN VGPM001_D B ON A.HCODA=B.HCODA AND A.HNROG=B.HNROG     
),
cte_Grup as (
select a.HFECPRO,a.HCODA,a.HNROG,isnull(b.HNROG,0) HNROGM 
from CTE_DIF a 
left join #GrupAnte b on a.HNROG=b.HNROG
)     
SELECT HFECPRO,HCODA,sum(CASE WHEN HNROG=HNROGM THEN 1 ELSE 0 END)GrupRec,sum(CASE WHEN HNROGM=0 THEN 1 ELSE 0 END) GrupNu    
into #Grupos   
FROM cte_Grup--CTE_DIF    
GROUP BY HFECPRO,HCODA    
        
    
;with cte_a as (    
select  HFECPRO,HTIPCOD,HCODREL,HNUMCLIN,HNUMCLI from  storage.com_act.WJAS001   where hfecpro=@fecH and htipcod=1 union all    
select  HFECPRO,HTIPCOD,HCODREL,HNUMCLIN,HNUMCLI from  storage.com_act.WJAS001   where hfecpro=@fecMA and htipcod=1      
)    
select hfecpro,HTIPCOD,HCODREL,SUM(HNUMCLIN) CLINUEV,/*SUM(ISNULL(HNUMCLIG,0)),*/ SUM(ISNULL(HNUMCLI,0)) CliStock     
into #GrupCli    
from cte_a a     
INNER join (select * from storage.[ref].WJERCOR03 where   RDESGRU='GRUPAL') B     
ON A.HCODREL=B.RCODSEC and B.RFECPRO=A.HFECPRO      
group by hfecpro,HTIPCOD,HCODREL    
    
 declare @result  as table([row] int,    
 HFECPRO date null,HCODA varchar(50)null,GrupRec int null,    
GrupNu int null,Stock_Ant int null,Stock_F int null,    
VariacionStock varchar(50) null,clinuev int null,  
M_VAR_CLI int null,M_CLI_NUEV int null,M_GRUPO int null,  
A_MET_GRUPO float null,A_MET_VAR float null,A_CUMPL float null,    
rdester varchar(250)null,rdescor varchar(250)null,rdesuni  varchar(250)null,RDESSEC varchar(250)null    
)    
     
;with cte_a as (       
select a.*,b.cliStock Stock_Ant,c.cliStock Stock_F,c.cliStock-b.cliStock as VariacionStock,c.clinuev  from #Grupos a    
left join (select * from #GrupCli where hfecpro=@fecMA) b    
on a.HCODA=b.hcodrel    
left join (select * from #GrupCli where hfecpro=@fecH)  c    
on a.HCODA=c.hcodrel     
),  
cte_b as (  
select a.*,b.HVALVAR MetaVarCli,c.HVALVAR MetaCliNu,d.HVALVAR MetaGruDes    
from cte_a a  
left join (select * from [storage].[com].[VDMCOM01] where HCODVAR=10062 and HTIPCOD=2  and HFECPRO=eomonth(@fecH)) B    
on a.HCODA=b.HCODREL  
left join (select * from [storage].[com].[VDMCOM01] where HCODVAR=166 and HTIPCOD=2 and HFECPRO=eomonth(@fecH)) c    
on a.HCODA=c.HCODREL  
left join (select * from [storage].[com].[VDMCOM01] where HCODVAR=10041 and HTIPCOD=2 and HFECPRO=eomonth(@fecH)) d    
on a.HCODA=d.HCODREL  
),  
cte_c as (  
select *,  
case when MetaGruDes=0 then 0 else (GrupRec+GrupNu)/MetaGruDes end  var1,   
case when MetaVarCli=0 then 0 else VariacionStock / MetaVarCli  end var2,  
case when MetaCliNu=0 then 0 else clinuev / MetaCliNu end var3  
from cte_b  
)     
insert into @result        
select row_number() over(order by b.rdester desc) AS [row],a.*,b.rdester,b.rdescor,b.rdesuni,b.RDESSEC   
from cte_c a    
inner join (select distinct rdester,rdescor,rdesuni,rcodsec,RDESSEC     
     from storage.[ref].WJERCOR03    
     where rfecpro=@fecH     
     and   case when @tip_cod=20 then ISNULL(cast(RCODTER as nvarchar(10)),'9999')      
     when @tip_cod=19 then cast(RCODCOR as nvarchar(10))    
     when @tip_cod=21 then cast(RCODGRU as nvarchar(5))          
     when @tip_cod=18 then cast(RCODUNI as varchar(50))
     when @tip_cod=17 then cast(RCODUCO as varchar(50))
      else '1' end=IIF(@tip_cod=7,'1',@cod_rel)    
           )   b     
on a.HCODA=b.rcodsec      
    
select * from @result ORDER BY [row] asc          
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS              
  FETCH NEXT @RowspPage ROWS ONLY;          
          
  select count(*) as Total from @result       
        
              
end
