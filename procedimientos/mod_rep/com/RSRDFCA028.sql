-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-04 03:47:11.847000
--exec [com].[RSRDFCA028] 1,7,'231'    
CREATE procedure [com].[RSRDFCA028]     
(    
 @tipmet INT,@tip_cod int,@cod_rel varchar(50)      
)       
 /*(@cod_rel varchar(50),@p_fecha date, @tip_cod int,     
  @TIPMETA int, @flag bit,@hor varchar(2),     
  @indcan int = 0, @nivel int = 2,     
  @jer smallint = 1 )      
  */         
AS          
BEGIN          
 SET NOCOUNT ON;          
    
 declare @defs as rep.TTHCOLDEF;       
    
insert into @defs                
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN)  values                
 (1,1,1,'RNOMSUB','Descripción','string',null,null,null),                
 (2,1,2,'cumpl_des_acum','CUMPLIMIENTO MONTO DESEMBOLSADO','percent','.2-2',null,null),                
 (3,1,3,'cumpl_ope_acum','CUMPLIMIENTO OPERACIONES DESEMBOLSADAS','percent','.2-2',null,null)    
    
 select rep.FFTHCOLDEF(@defs) result;      
    
  declare @p_fecha date,@fec_i date,@flag bit,@hor varchar(2),@TIPMETA int,@indcan int=0,@nivel int=2     
          
 select @p_fecha=max(HFECPRO) from [storage].[com_act].[HCDA001]          
 select @fec_i=max(SFECPRO) from [storage].[com_act].[SDAS010]          
 select @flag=case when @fec_i>@p_fecha then 1 else 0 end          
 select @p_fecha=case when @fec_i>@p_fecha then @fec_i else @p_fecha end          
  select @hor=max(SHORPRO) from   [storage].[com_act].[SDAS010] where SFECPRO=@p_fecha     
  set @TIPMETA=@tipmet    
    
/*        
declare @cod_rel varchar(50)='1',        
     @p_fecha date='20220609',         
  @tip_cod int=21,        
  @TIPMETA int=1,        
  @flag bit=1,        
  @hor varchar(2)=14,        
  @indcan int = 0,        
  --@tipcodaux int = 1,        
  @nivel int =2        
  @jer smallint = 2        
  */        
          
        
declare @p_fecha1 date                
                  
 select @p_fecha1=MAX(SFECPRO) from storage.[com_act].[SDAF001] where SFECPRO<=@p_fecha              
            
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF            
            
 insert into @tvars values                 
 ('Num_Ope_DDiario_flujo',null,null,null,null,null),            
 ('Monto_DDiario_flujo_flujo',null,null,null,null,null)             
                 
 insert into @tfil                
 values                
 ('todos','fec','"'+cast(replace(@p_fecha1,'-','') as varchar(250))+'"')--,                
            
 insert into @tconf                
 values                
 ('level_alias','style'),            
 --('insert_to','#report'),            
 ('fec_corr','true')            
            
            
 declare @jera varchar(100)            
 insert into @tfil                
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jera output               
            
 select @jera = '"fec_dese"'+ ',' +@jera             
               
 create table #SDAF001 (fila int null,fec varchar(50) null,cod varchar(50)null,cod_u varchar(250) null,style int null,descripcion varchar(250)null,num_ope int null,SMONDESMN float null)            
             
 insert into #SDAF001 --drop table #SDAF001            
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jera,@columns='"vars"',@config=@tconf--,@show_query=1                
                
 delete from #SDAF001 where style<>0            
            
 select  SFECDES, SNUMOPE, SMONDESMN, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC              
 into #T1       ---select * from #T1      
 from  storage.[com_act].[SDAF003] --select * from storage.[com_act].[SDAF003]   where sfecpro='2022-06-20' and sfecdes='20220620'  and SHORPRO=17 and scodagr=3   order by 1 asc    
 where  SFECPRO = @p_fecha and SFECDES = @p_fecha and SHORPRO=@hor and @flag=1           
 and scodagr=3             
            
 select * into #WJERCOR3               
 from  storage.[ref].WJERCOR03             
 where RINDFEC='ACTUAL' and RFECPRO=@p_fecha1            
 and case when @tip_cod=7 then '1'              
                        when @tip_cod=21 then cast(RCODGRU as varchar(250))              
      when @tip_cod=20 then cast(RCODTER as varchar(250))              
      when @tip_cod=19 then cast(RCODCOR as varchar(250))              
      when @tip_cod=18 then cast(RCODUNI as varchar(250))
      when @tip_cod=17 then cast(RCODUCO as varchar(250)) end = case when @tip_cod=7 then '1' else @cod_rel end              
              
            
 select distinct a.sfecdes,            
        isnull(case when @tip_cod=7 then cast(RCODGRU as varchar(250))               
       when @tip_cod=21 then cast(RCODTER as varchar(250))                
    when @tip_cod=20 then cast(RCODCOR as varchar(250))            
    when @tip_cod=19 then cast(RCODUNI as varchar(250))     
    when @tip_cod=18 then cast(RCODUCO as varchar(250))       
    when @tip_cod=17 then cast(RCODSEC as varchar(250))            
  end,'9999') Cod,            
  isnull(case when @tip_cod=7 then  RDESGRU             
       when @tip_cod=21 then RDESTER             
    when @tip_cod=20 then RDESCOR             
    when @tip_cod=19 then RDESUNI              
    when @tip_cod=18 then RDESUCO 
    when @tip_cod=17 then RDESSEC            
  end,'SIN ASIGNAR') descr,            
 sum(SNUMOPE)SNUMOPE,sum(SMONDESMN)SMONDESMN             
 into #SDAF003            
 from #T1 a  --select * from #T1           
 left join #WJERCOR3 _JC --select distinct RCODTER from #WJERCOR3            
 on a.SCODSEC=_JC.RCODSEC               
 group by a.sfecdes,            
 case when  @tip_cod=7 then cast(RCODGRU as varchar(250))               
       when @tip_cod=21 then cast(RCODTER as varchar(250))                
    when @tip_cod=20 then cast(RCODCOR as varchar(250))            
    when @tip_cod=19 then cast(RCODUNI as varchar(250))  
     when @tip_cod=18 then cast(RCODUCO as varchar(250))             
    when @tip_cod=17 then cast(RCODSEC as varchar(250))            
              
 end,            
 case when @tip_cod=7 then  RDESGRU             
       when @tip_cod=21 then RDESTER             
    when @tip_cod=20 then RDESCOR             
    when @tip_cod=19 then RDESUNI             
    when @tip_cod=18 then RDESUCO  
    when @tip_cod=17 then RDESSEC             
 end            
               
select eomonth(fec) RNUM, fec,cod_u,descripcion,num_ope,SMONDESMN             
into #DESEMBOLSOS        --select * from #DESEMBOLSOS    
from #SDAF001             
union all            
select eomonth(sfecdes), * from #SDAF003      

SELECT RNUM,cod_u,descripcion,sum(num_ope)num_ope,sum(SMONDESMN) SMONDESMN
into #DESEMBOLSOS2 --drop table #DESEMBOLSOS2   select * from #DESEMBOLSOS2
FROM    #DESEMBOLSOS
group by RNUM,cod_u,descripcion       
             
/*CANCELACIONES*/            
 select  SFECPRO, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC,                
   SSCAPIMN + SMDESMN - SSCASMN - SSCAPFMN SCANMN                
 INTO #tmpCancelaciones  --drop table #tmpCancelaciones            
 from [storage].[com_act].[SDAS004]                    
 WHERE @indcan = 1  and SFECPRO = @p_fecha  and scodagr=3            
            
 select distinct a.sfecpro,eomonth(a.sfecpro) rnum,            
        isnull(case when @tip_cod=7 then cast(RCODGRU as varchar(250))               
       when @tip_cod=21 then cast(RCODTER as varchar(250))                
    when @tip_cod=20 then cast(RCODCOR as varchar(250))            
    when @tip_cod=19 then cast(RCODUNI as varchar(250))            
    when @tip_cod=18 then cast(RCODUCO as varchar(250))   
    when @tip_cod=17 then cast(RCODSEC as varchar(250))             
  end,'9999') Cod,            
  isnull(case when @tip_cod=7 then  RDESGRU             
       when @tip_cod=21 then RDESTER             
    when @tip_cod=20 then RDESCOR             
    when @tip_cod=19 then RDESUNI              
    when @tip_cod=18 then RDESUCO 
    when @tip_cod=17 then RDESSEC            
  end,'SIN ASIGNAR') descr,            
 sum(scanmn)scanmn             
 into #tmpCancelaciones2            
 from #tmpCancelaciones a            
 left join #WJERCOR3 _JC --select distinct RCODTER from #WJERCOR3            
 on a.SCODSEC=_JC.RCODSEC             
 group by a.sfecpro,            
 case when  @tip_cod=7 then cast(RCODGRU as varchar(250))               
       when @tip_cod=21 then cast(RCODTER as varchar(250))                
    when @tip_cod=20 then cast(RCODCOR as varchar(250))            
    when @tip_cod=19 then cast(RCODUNI as varchar(250))            
    when @tip_cod=18 then cast(RCODUCO as varchar(250))  
    when @tip_cod=17 then cast(RCODSEC as varchar(250))            
              
 end,            
 case when @tip_cod=7 then  RDESGRU             
       when @tip_cod=21 then RDESTER        
    when @tip_cod=20 then RDESCOR             
    when @tip_cod=19 then RDESUNI             
    when @tip_cod=18 then RDESUCO   
    when @tip_cod=17 then RDESSEC               
 end            
            
  set language spanish;            
            
  select      RORD dia_habil,            
             RFEC Fecha,DATENAME(weekday,RFEC) fecha_nombre            
 INTO #FecHabil1 --drop table #FecHabil            
 from        storage.util.FVECFEC01(eomonth(@p_fecha1),'ini-hoy|hab') A              
            
 select * into #FecHabil from #FecHabil1 where fecha between cast(DATEADD(MONTH, DATEDIFF(MONTH, 0,@p_fecha), 0) as date) and @p_fecha            
              
/* ;WITH CTE_A AS (                          
select *                     
from [storage].[com].[VDMCOM01]                   
where   hcodvar in(5006, 133, 136) and  HTIPCOD='2'               
and hfecpro=eomonth(@p_fecha) and HTIPMETA = @TIPMETA                                
),            
CTE_B AS (                          
SELECT eomonth(@p_fecha) RNUM,A.HCODREL ,HVALVAR VAL,            
       isnull(case when @tip_cod=7 then cast(b.RCODGRU as varchar(250))               
       when @tip_cod=21 then cast(b.RCODTER as varchar(250))                
    when @tip_cod=20 then cast(b.RCODCOR as varchar(250))            
    when @tip_cod=19 then cast(b.RCODUNI as varchar(250))            
    when @tip_cod=18 then cast(b.RCODSEC as varchar(250))            
  end,'9999')cod,            
       case A.HCODVAR                
       when 5006 then 'meta_ope_acum'                
       when 133 then 'meta_des_acum'                
       when 136 then 'meta_can_acum'                
      end DESVAL                           
FROM CTE_A A                          
LEFT JOIN #WJERCOR3 B              --select top 5 * from #WJERCOR3            
ON A.HCODREL=B.RCODSEC            
)     
, */
;with CTE_B as (                     
select  eomonth(@p_fecha) RNUM,  HCODREL , HVALVAR val,
     case HCODVAR              
       when 5006 then 'meta_ope_acum'              
       when 133 then 'meta_des_acum'              
       when 136 then 'meta_can_acum'              
      end DESVAL                  
from [storage].[com].[VDMCOM01]                 
where   hcodvar in(5006, 133, 136) -- and  HTIPCOD='2'             
and hfecpro=eomonth(@p_fecha) and HTIPMETA = @TIPMETA   
and HTIPCOD= case when @tip_cod=7 then 21
		          when @tip_cod=21 then 20
				  when @tip_cod=20 then 19
				  when @tip_cod=19 then 18
				  when @tip_cod=18 then 17
				  when @tip_cod=17 then 2 end
),          
cteDatMetas AS (                         
--SELECT RNUM, cod HCODREL,DESVAL,cod,SUM(VAL)  VAL     
SELECT RNUM, HCODREL HCODREL,DESVAL,SUM(VAL)  VAL                          
FROM CTE_B                        
WHERE HCODREL IS NOT NULL                        
--GROUP BY RNUM, cod,DESVAL,cod  
GROUP BY RNUM, HCODREL,DESVAL                      
),/*           
cteDatMetas AS (                           
SELECT RNUM, cod HCODREL,DESVAL,cod,SUM(VAL)  VAL                        
FROM CTE_B                          
WHERE HCODREL IS NOT NULL                          
GROUP BY RNUM, cod,DESVAL,cod                          
),    */        
cteMetas as(                
select RNUM,HCODREL, meta_ope_acum, meta_des_acum,meta_can_acum                
 FROM cteDatMetas A                
 pivot(MAX(VAL)             
 FOR DESVAL in(meta_ope_acum,meta_des_acum,meta_can_acum)            
                  
)B            
)           
,            
cteCan as(               
--select * from #tmpCancelaciones2   
select eomonth(@p_fecha) RNUM, dia_habil,      
    SUM(IIF(B.Fecha <= @p_fecha and A.SCANMN is null, 0, IIF(B.Fecha > @p_fecha and A.SCANMN is not null,null,A.SCANMN))) can_diario      
  from #tmpCancelaciones2    A 
 right join #FecHabil B on  A.SFECPRO = B.Fecha    --select * from #FecHabil  
  group BY  dia_habil               
),            
cteCanMetas as (            
 select  B.RNUM, A.dia_habil,a.fecha, B.meta_can_acum * null meta_can_diario--, A.idia_habil               
  FROM #FecHabil A, cteMetas B --select * from #FecHabil            
),            
cteCanAcuMetas as(               
select  B.RNUM, SUM(A.meta_can_diario) meta_can_acum_2              
  FROM cteCanMetas A              
   join cteCanMetas B              
    on  A.dia_habil <= B.dia_habil              
    and A.RNUM = B.RNUM              
  where B.fecha =@p_fecha               
  group BY              
    B.RNUM            
            
)            
    
/*OBTIENE LA META DE OPERACIONES Y MONTO*/               
 select  A.cod_u,a.descripcion,a.num_ope ope_acum,a.SMONDESMN des_acum,C.meta_ope_acum,               
    --meta_des_acum = C.meta_des_acum + IIF(@indcan = 0,0,1) * isnull(com.FLIMNEG(D.scanmn - E.meta_can_acum_2,0),0)              
 meta_des_acum = C.meta_des_acum + IIF(@indcan = 0,0,1) * isnull(com.FLIMNEG(D.can_diario - E.meta_can_acum_2,0),0)            
 into  #INI2  --select* from #INI2            
 from  #DESEMBOLSOS2 A  --select * from #DESEMBOLSOS            
  left join cteMetas C              
   on A.RNUM = C.RNUM     and a.cod_u =c.HCODREL         
  left JOIN cteCan D              
   on A.RNUM = D.RNUM              
  left JOIN cteCanAcuMetas E              
   on A.RNUM = E.RNUM              
            
  /* select cod_u,descripcion,            
   sum(ope_acum)ope_acum,sum(des_acum)des_acum,sum(meta_ope_acum)meta_ope_acum,sum(meta_des_acum)meta_des_acum            
   into #INI --select * from #INI            
   from #INI2            
   group by cod_u,descripcion   */         

    select distinct cod_u,descripcion,ope_acum,des_acum,meta_ope_acum,meta_des_acum 
		into #INI  --select * from #INI
		from #INI2  

/*    
 select  A.cod_u,a.descripcion, IIF(meta_des_acum <> 0,round(des_acum/meta_des_acum,4),0) cumpl_des_acum,              
    IIF(meta_des_acum <> 0 and des_acum/meta_des_acum >= 1,  1 , 0 ) sem_cumpl_des_acum,              
    IIF(meta_ope_acum <> 0, round((1.0*ope_acum)/(1.0*meta_ope_acum),4),0) cumpl_ope_acum,              
    IIF(meta_ope_acum <> 0 and (1.0*ope_acum)/(1.0*meta_ope_acum)>=1 , 1 , 0) sem_cumpl_ope_acum               
 INTO #tmpRes              
 from  #INI A      
*/  
  
select  A.cod_u,a.descripcion,IIF(meta_des_acum <> 0,round(des_acum/meta_des_acum,4),0) cumpl_des_acum,      
    IIF(meta_des_acum <> 0 and des_acum/meta_des_acum >= 1,  1 , 0 ) sem_cumpl_des_acum,      
    IIF(meta_ope_acum <> 0, round((1.0*ope_acum)/(1.0*meta_ope_acum),4),0) cumpl_ope_acum,      
    IIF(meta_ope_acum <> 0 and (1.0*ope_acum)/(1.0*meta_ope_acum)>=1 , 1 , 0) sem_cumpl_ope_acum       
 INTO #tmpRes      
 from  #INI A               
            
 if @nivel = 1               
  select  cumpl_des_acum, sem_cumpl_des_acum, cumpl_ope_acum, sem_cumpl_ope_acum              
    ,cast(cast(getdate() as date) as varchar) fecha,                
    IIF(@flag = 1, case @hor              
         when '10' then '10:30 AM'              
         when '14' then '2:30 PM'              
         when '17' then '5:30 PM'               
         else null               
        end, null) hora              
  FROM #tmpRes              
  order BY 1              
 else               
  select  cod_u,descripcion RNOMSUB, cumpl_des_acum, sem_cumpl_des_acum, cumpl_ope_acum, sem_cumpl_ope_acum              
  FROM #tmpRes               
  order by 4 desc                
        
  end
