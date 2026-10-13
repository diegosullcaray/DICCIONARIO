-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:24.480000
--exec mod_rep.[com].[RSRDFCA050] 1,7,'231','TODOS'
CREATE procedure [com].[RSRDFCA050]        
@tipmet int,        
@tip_cod nvarchar(50),@cod_rel varchar(50),        
@prod varchar(250)        
as        
begin        
 SET NOCOUNT ON;                  
--declare  @tipmet INT=1,@tip_cod int=7,@cod_rel varchar(50) ='231',@prod varchar(250)='TODOS' --'Agua y Saneamiento' --'TODOS'           
        
 declare @p_fecha date,@fec_i date,@flag bit,@hor varchar(2),@TIPMETA int,@indcan int=0           
                
 select @p_fecha=max(HFECPRO) from [storage].[com_act].[HCDA001]                
 select @fec_i=max(SFECPRO) from [storage].[com_act].[SDAS010]                
 select @flag=case when @fec_i>@p_fecha then 1 else 0 end                
 select @p_fecha=case when @fec_i>@p_fecha then @fec_i else @p_fecha end                
 select @hor=max(SHORPRO) from   [storage].[com_act].[SDAS010] where SFECPRO=@p_fecha           
 set @TIPMETA=@tipmet          
          
 declare @defs as rep.TTHCOLDEF;             
          
insert into @defs                      
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN)  values                      
 (1,1,1,'dia_habil','D a',null,2,1,'string',null,null,null),                      
 (2,1,2,'Fecha','Fecha',2,2,1,'string',null,null,null),                      
 (3,1,3,'fecha_nombre','fecha_nombre',null,null,1,'string',null,null,1),            
 (4,1,null,'Diario','Diario',3,null,null,null,null,null,null),            
 (5,1,null,'Acumulado','Acumulado',4,null,null,null,null,null,null),                      
 --(6,1,10,'porc_dias','% D as Transcurridos',null,2,1,'percent','.1-2',null,null),                 
                      
 (7,2,4,'ope_diario','Operaciones',null,null,null,'number','.0-0',null,null),                      
 (8,2,5,'TMDIARIO1','Meta',null,null,null,'number','.0-0',null,null),             
 (9,2,6,'cumpl_ope_diario','%Cumplimiento',null,null,null,'percent','.1-2',null,null),             
 (10,2,7,'ope_acum','Operaciones',null,null,null,'number','.0-0',null,null),             
 (11,2,8,'meta_ope_acum','Meta',null,null,null,'number','.0-0',null,null),              
 (12,2,9,'cumpl_ope_acum','%Cumplimiento',null,null,null,'percent','.1-2',null,null)  ,                 
 (13,2,10,'porc_dias','% Requerido',null,2,1,'percent','.1-2',null,null)                                      
  select rep.FFTHCOLDEF(@defs) result;             
                    
 declare @p_fecha1 date                        
                          
 select @p_fecha1=MAX(SFECPRO) from storage.[com_act].[SDAF001] where SFECPRO<=@p_fecha                      
                    
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                    
                    
 insert into @tvars values                         
 ('Num_Ope_DDiario_flujo',null,null,null,null,null),                    
 ('Monto_DDiario_flujo_flujo',null,null,null,null,null)                     
                         
 insert into @tfil                  --select * from storage.com_act.RETP006  select * from storage.com_act.RETP010      
 values                        
 ('todos','fec','"'+cast(replace(@p_fecha1,'-','') as varchar(250))+'"')--,                        
                    
 insert into @tconf                        
 values                        
 ('level_alias','style'),                    
 ('insert_to','#SDAF001_Prev'),                    
 ('fec_corr','true')                    
                    
                    
 declare @jera varchar(100)                    
 insert into @tfil                        
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jera output                       
                    
 --select @jera = '"fec_dese"'+',"prod_mis_com"'+ ',' +@jera             
 select @jera = '"fec_dese"'+ ',' +@jera            
 create table #SDAF001_ (fila int null,fec varchar(50) null,cod varchar(50)null,cod_u varchar(250) null,style int null,descripcion varchar(250)null,        
 SMONDESMN_agua float null,num_ope_agua int null,        
 SMONDESMN_crededu float null,num_ope_crededu int null,        
 SMONDESMN_empmuj float null,num_ope_empmuj int null,        
 Monto_DDiario_flujo_flujo float null,        
 Num_Ope_DDiario_flujo  float null  ,      
 SMONDESMN_ProdVerde float null,num_ope_ProdVerde int null        
 )             
 create table #SDAF001_Prev(    
 fila int null,cod_fec_dese varchar(250)null,cod_fc varchar(250)null,cod_ugru varchar(250)null,style int null,descripcion varchar(250)null,    
 [Agua y Saneamiento_Monto_DDiario_flujo_flujo] float null,[Agua y Saneamiento_Num_Ope_DDiario_flujo] float null,    
 [Crédito Educativo_Monto_DDiario_flujo_flujo] float null,[Crédito Educativo_Num_Ope_DDiario_flujo] float null,    
 [Emprendimiento Mujer_Monto_DDiario_flujo_flujo]float null,[Emprendimiento Mujer_Num_Ope_DDiario_flujo] float null,    
 [Monto_DDiario_flujo_flujo] float null,[Num_Ope_DDiario_flujo] float null,    
 [Producto Verde_Monto_DDiario_flujo_flujo] float null,[Producto Verde_Num_Ope_DDiario_flujo] float null    
 )    
       
 --insert into #SDAF001_  --select * from #SDAF001        
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jera,@columns='"vars"',@config=@tconf--,@show_query=1                                   
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jera,@columns='"prod_mis_com","vars"',@config=@tconf--,@show_query=1                        
        
insert into #SDAF001_    
select fila,cod_fec_dese,cod_fc,cod_ugru,style,descripcion,[Agua y Saneamiento_Monto_DDiario_flujo_flujo],[Agua y Saneamiento_Num_Ope_DDiario_flujo],    
[Crédito Educativo_Monto_DDiario_flujo_flujo],[Crédito Educativo_Num_Ope_DDiario_flujo],    
[Emprendimiento Mujer_Monto_DDiario_flujo_flujo],[Emprendimiento Mujer_Num_Ope_DDiario_flujo],    
[Monto_DDiario_flujo_flujo],[Num_Ope_DDiario_flujo],    
[Producto Verde_Monto_DDiario_flujo_flujo],[Producto Verde_Num_Ope_DDiario_flujo]    
from #SDAF001_Prev    
    
 delete from #SDAF001_ where style<>1           
 create table #SDAF001 (fila int null,fec varchar(50) null,cod varchar(50)null,cod_u varchar(250) null,style int null,descripcion varchar(250)null,num_ope int null,SMONDESMN float null)                    
        
 if @prod='TODOS'  --        
 begin        
 insert into #SDAF001         
  select fila,fec,cod,cod_u,style,descripcion,         
 isnull(num_ope_agua,0) + isnull(num_ope_crededu,0) + isnull(num_ope_empmuj,0) + isnull(num_ope_ProdVerde,0) ,        
  isnull(SMONDESMN_agua,0) + isnull(SMONDESMN_crededu,0) + isnull(SMONDESMN_empmuj,0)   +  isnull(SMONDESMN_ProdVerde,0)      
  from #SDAF001_         
        
 end        
else        
begin        
insert into #SDAF001         
select fila,fec,cod,cod_u,style,descripcion,         
  case when @prod='Agua y Saneamiento' then  num_ope_agua        
    when @prod='Crédito Educativo' then num_ope_crededu         
    when @prod='Emprendimiento Mujer' then num_ope_empmuj       
 when @prod='Producto verde' then num_ope_ProdVerde      
 end,      
       
  case when @prod='Agua y Saneamiento' then SMONDESMN_agua         
       when @prod='Crédito Educativo' then SMONDESMN_crededu          
    when @prod='Emprendimiento Mujer' then SMONDESMN_empmuj      
 when @prod='Producto verde' then SMONDESMN_ProdVerde      
 end        
  from #SDAF001_         
        
end        
                        
 create table #T1 (SFECDES date null,SNUMOPE float null,SMONDESMN float null,SCODAGR int null,SSUCCLI int null,SCODSEC varchar(250)null)        
        
 --insert into #T1        
 if @prod='TODOS'        
 begin        
 ;with cte_a as (        
 select  SFECDES, SNUMOPE, SMONDESMN, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC ,SCODMOD,  STIPOPE,  SSUBTIP                              
 from  storage.[com_act].[SDAF003]  --select * from storage.[com_act].[SDAF003]                        
 where  SFECPRO = @p_fecha and SFECDES = @p_fecha and SHORPRO=@hor and 1=1  and @flag=1                    
 and scodagr=3  --select * from #T1             
 )        
 insert into #T1        
 select SFECDES, SNUMOPE, SMONDESMN, SCODAGR, SSUCCLI,SCODSEC         
 from cte_a a         
 inner join storage.com_act.RETP006  b   --select distinct RDESSUBP  from storage.com_act.RETP006        
 on a.SCODMOD=b.RCODMOD and a.STIPOPE=b.RTIPOPE and a.SSUBTIP=b.RSUBTIP          
 end        
 else        
 begin        
 ;with cte_a as (        
 select  SFECDES, SNUMOPE, SMONDESMN, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC ,SCODMOD,  STIPOPE,  SSUBTIP                              
 from  storage.[com_act].[SDAF003]  --select * from storage.[com_act].[SDAF003]                        
 where  SFECPRO = @p_fecha and SFECDES = @p_fecha and SHORPRO=@hor and 1=1  and @flag=1                    
 and scodagr=3  --select * from #T1             
 )        
 insert into #T1        
 select SFECDES, SNUMOPE, SMONDESMN, SCODAGR, SSUCCLI,SCODSEC         
 from cte_a a         
 inner join (select * from  storage.com_act.RETP006 where RDESSUBP=@prod) b          
 on a.SCODMOD=b.RCODMOD and a.STIPOPE=b.RTIPOPE and a.SSUBTIP=b.RSUBTIP         
        
 end        
        
 select * into #WJERCOR3   --select * from #WJERCOR3                    
 from  storage.[ref].WJERCOR03                     
 where RINDFEC='ACTUAL' and RFECPRO=@p_fecha1                    
 and case when @tip_cod=7 then '1'                      
                        when @tip_cod=21 then cast(RCODGRU as varchar(250))                      
      when @tip_cod=20 then cast(RCODTER as varchar(250))                      
      when @tip_cod=19 then cast(RCODCOR as varchar(250))                      
      when @tip_cod=18 then cast(RCODUNI as varchar(250))           
       when @tip_cod=17 then cast(RCODUCO as varchar(250)) end = case when @tip_cod=7 then '1' else @cod_rel end        
        
        
select distinct a.sfecdes,                    
        isnull(case when @tip_cod=7 then cast(RCODFC as varchar(250))                       
       when @tip_cod=21 then cast(RCODGRU as varchar(250))                        
    when @tip_cod=20 then cast(RCODTER as varchar(250))                
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                    
    when @tip_cod=18 then cast(RCODUNI as varchar(250))           
     when @tip_cod=17 then cast(RCODUCO as varchar(250))                      
  end,'9999') Cod,                    
  isnull(case when @tip_cod=7 then  RDESFC                     
       when @tip_cod=21 then        RDESGRU                     
    when @tip_cod=20 then        RDESTER                     
    when @tip_cod=19 then        RDESCOR                      
    when @tip_cod=18 then        RDESUNI           
    when @tip_cod=17 then        RDESUCO                    
  end,'SIN ASIGNAR') descr,                    
 sum(SNUMOPE)SNUMOPE,sum(SMONDESMN)SMONDESMN                     
 into #SDAF003  --select * from #SDAF003                    
 from #T1 a                    
 left join #WJERCOR3 _JC --select distinct RCODTER from #WJERCOR3                    
 on a.SCODSEC=_JC.RCODSEC                       
 group by a.sfecdes,                    
 case when @tip_cod=7 then cast(RCODFC as varchar(250))                       
       when @tip_cod=21 then cast(RCODGRU as varchar(250))                        
    when @tip_cod=20 then cast(RCODTER as varchar(250))                    
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                    
    when @tip_cod=18 then cast(RCODUNI as varchar(250))             
    when @tip_cod=17 then cast(RCODUCO as varchar(250))                     
  end,                    
 case when @tip_cod=7 then  RDESFC                     
       when @tip_cod=21 then        RDESGRU                     
    when @tip_cod=20 then        RDESTER                     
    when @tip_cod=19 then        RDESCOR                      
    when @tip_cod=18 then        RDESUNI            
    when @tip_cod=17 then        RDESUCO                   
  end                    
        
 select fec,cod,descripcion,num_ope,SMONDESMN                      
 into #SDAF  --SELECT * FROM #SDAF                    
 from #SDAF001 union all  --SELECT * FROM #SDAF001                    
 select * from #SDAF003 where cod=@cod_rel            
        
 create table #tmpCancelaciones (SFECPRO date null,SCODAGR int null,SSUCCLI int null,SCODSEC varchar(250)null,SCANMN float null)        
if @prod='TODOS'        
begin        
 ;with cte_a as (        
  select  SFECPRO, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC,                        
    SSCAPIMN + SMDESMN - SSCASMN - SSCAPFMN SCANMN, HCODMOD,HTIPOPE,HSUBTIP         
  from [storage].[com_act].[SDAS004]                            
  WHERE @indcan = 1 and SFECPRO between convert(date,convert(varchar(6),@p_fecha1,112) + '01') and @p_fecha1               
 )        
 insert into #tmpCancelaciones        
 select SFECPRO, SCODAGR, SSUCCLI, SCODSEC ,SCANMN        
 from cte_a a         
 inner join storage.com_act.RETP006  b   --select distinct RDESSUBP  from storage.com_act.RETP006        
 on a.HCODMOD=b.RCODMOD and a.HTIPOPE=b.RTIPOPE and a.HSUBTIP=b.RSUBTIP          
end        
else        
begin        
;with cte_a as (        
  select  SFECPRO, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC,                        
    SSCAPIMN + SMDESMN - SSCASMN - SSCAPFMN SCANMN, HCODMOD,HTIPOPE,HSUBTIP         
  from [storage].[com_act].[SDAS004]                            
  WHERE @indcan = 1 and SFECPRO between convert(date,convert(varchar(6),@p_fecha1,112) + '01') and @p_fecha1               
 )        
 insert into #tmpCancelaciones        
 select SFECPRO, SCODAGR, SSUCCLI, SCODSEC ,SCANMN        
 from cte_a a         
 inner join (select * from  storage.com_act.RETP006 where RDESSUBP=@prod) b          
 on a.HCODMOD=b.RCODMOD and a.HTIPOPE=b.RTIPOPE and a.HSUBTIP=b.RSUBTIP          
        
end        
        
set language spanish;                
        
 select      RORD dia_habil,                    
             RFEC Fecha,DATENAME(weekday,RFEC) fecha_nombre                    
 INTO #FecHabil --drop table #FecHabil                    
 from        storage.util.FVECFEC01(eomonth(@p_fecha1),'ini-hoy|hab') A                      
                    
 declare @CDiasHab int,@prodd varchar(max)                 
 set @CDiasHab =(select count(*) from #FecHabil)           
 select  @prodd= case when  @prod='TODOS' then '10035,10036,10037,10058'         
             when  @prod='Agua y Saneamiento' then '10036'        
       when  @prod='Crédito Educativo' then '10035'        
       when  @prod='Emprendimiento Mujer' then '10037'      
    when  @prod='Producto verde' then '10058' end        
                
        
declare @sql nvarchar(max)        
         
set @sql='                      
 select eomonth('''+cast(@p_fecha as varchar(250))+''') RNUM, ''meta_ope_acum''  DESVAL, sum(A.HVALVAR) VAL               
     into  ##cteDatMetas  ------drop table ##cteDatMetas        
  from  storage.[com].[VDMCOM01] A             
  where A.HCODVAR in('+cast(@prodd as varchar(250))+')                     
  and  A.HTIPMETA = '+cast(@TIPMETA as varchar(250))+'                       
  and a.htipcod='+cast(@tip_cod as varchar(250))+'                    
  and a.HCODREL ='''+cast(@cod_rel as varchar(250))+'''                    
   and eomonth(A.HFECPRO) = eomonth('''+cast(@p_fecha as varchar(250))+''')                    
         
        
'        
exec (@sql)        
         
   select * into #cteDatMetas from ##cteDatMetas  --drop table ##cteDatMetas        
   drop table ##cteDatMetas        
             
;with cteMetas as(                        
 select RNUM, meta_ope_acum                    
 FROM #cteDatMetas A                        
 pivot(MAX(VAL)                     
 FOR DESVAL in(meta_ope_acum)                    
      ) B                    
 ),        
 cteCan as(                        
 SELECT eomonth(@p_fecha) RNUM, dia_habil,                        
    SUM(IIF(B.Fecha <= @p_fecha and A.SCANMN is null, 0, IIF(B.Fecha > @p_fecha and A.SCANMN is not null,null,A.SCANMN))) can_diario                        
  FROM #tmpCancelaciones A      --select * from #tmpCancelaciones                      
 right join #FecHabil B on  A.SFECPRO = B.Fecha    --select * from #FecHabil                    
  group BY  dia_habil                    
 ),        
 cteCalc as(                    
 SELECT eomonth(@p_fecha) RNUM, dia_habil,Fecha,                         
    SUM(IIF(B.Fecha <= @p_fecha and A.num_ope is null, 0, IIF(B.Fecha > @p_fecha and A.num_ope is not null,null,A.num_ope))) ope_diario,                        
    SUM(IIF(B.Fecha <= @p_fecha and A.SMONDESMN is null, 0, IIF(B.Fecha > @p_fecha and A.SMONDESMN is not null, null,A.SMONDESMN))) des_diario                         
  FROM #SDAF A    --select * from #FecHabil               
   right join #FecHabil B on A.fec = B.Fecha                        
  group BY   dia_habil,fecha                    
 ),          
 cteAcum as(                        
  select  A.RNUM, B.dia_habil,b.Fecha, SUM(A.ope_diario) ope_acum, SUM(A.des_diario) des_acum                        
  FROM cteCalc A                        
   join cteCalc B                        
    on  A.RNUM = B.RNUM                        
    AND A.dia_habil <= B.dia_habil                        
  group by A.RNUM, B.dia_habil,b.fecha)         
        
,cteAcuMetas as(                        
  SELECT A.*, D.ope_acum,                     
  D.des_acum,                     
  @CDiasHab p_dias_habiles, --C.p_dias_habiles,                     
  --C.Factor,                         
    B.meta_ope_acum ,            
    MAX(IIF(A.ope_diario is not null, A.dia_habil, null)) over(partition by '') ult_dia_habil                        
  FROM cteCalc A                        
   join #FecHabil C    --select * from #FecHabil                    
    ON A.RNUM = eomonth(c.fecha)                    
    and A.dia_habil = C.dia_habil                        
   join cteAcum D                        
    ON A.RNUM = D.RNUM                        
    and A.dia_habil = D.dia_habil                        
   join cteCan E                        
    ON A.RNUM = E.RNUM                        
    and A.dia_habil = E.dia_habil                        
   left join cteMetas B                        
    on  A.RNUM = B.RNUM        
         
)         
  select  *                        
 INTO  #tmpAcuMetas                     
 FROM cteAcuMetas               
        
declare   @tDilOpe as [com].[TDILMETA], @n int = 1, @RNUM date, @m int           
        
  select distinct  RNUM, row_number() over(order by cod) N INTO #tmpParT FROM (select distinct cod,eomonth(fec)RNUM from  #SDAF001) A   --select* from  #SDAF001                      
 select @m = MAX(N) from #tmpParT          
        
  create table #tmpDILMDes (RNUM date, TDIA int, TMDIARIO float, primary key(RNUM, TDIA))                        
 create table #tmpDILMOpe (RNUM date, TDIA int, TMDIARIO float, primary key(RNUM, TDIA))            
        
 alter table #tmpAcuMetas                    
 add factor int null                    
                     
 alter table #tmpAcuMetas                    
 add fecha_nombre varchar(250) null                    
                    
 update a                    
 set a.fecha_nombre=b.fecha_nombre                    
 from #tmpAcuMetas a inner join #FecHabil b                     
 on a.fecha=b.Fecha                     
                    
                     
 update a                    
 set a.factor=b.factor                    
 from #tmpAcuMetas a inner join (select fecha,case when fecha_nombre='Sábado' then 2 else 1 end factor from #tmpAcuMetas) b                     
 on a.fecha=b.Fecha                     
        
 while @n <= @m                        
 begin                        
  select  @RNUM = RNUM                        
  FROM #tmpParT                        
WHERE N = @n                        
                                      
                          
  insert into @tDilOpe                        
  select  dia_habil, ope_diario, meta_ope_acum / p_dias_habiles, meta_ope_acum, Factor, ult_dia_habil                        
  FROM #tmpAcuMetas  --select * from #tmpAcuMetas                    
  WHERE RNUM = @RNUM                        
                                           
  insert into #tmpDILMOpe select @RNUM, TDIA, TMDIARIO from [com].[FDILMETA](@tDilOpe,0.5,0)                        
                                      
  delete from @tDilOpe                        
                        
  set @n = @n + 1                         
 end         
        
         
 select a.*, dia_habil / ( 1.0 * @CDiasHab ) porc_dias,                    
  X.TMDIARIO TMDIARIO1,                                
   IIF(X.TMDIARIO = 0, 1,round((1.0* A.ope_diario)/(1.0* X.TMDIARIO),4)) cumpl_ope_diario,                          
   IIF(X.TMDIARIO = 0 or (1.0*ope_diario)/(1.0* X.TMDIARIO) >=1 , 1 , 0 ) sem_cumpl_ope_diario,                    
  round( IIF(meta_ope_acum = 0,1,(1.0* ope_acum)/(1.0* meta_ope_acum)),4) cumpl_ope_acum,                         
   IIF(meta_ope_acum = 0 or (1.0*ope_acum)/(1.0*meta_ope_acum)>=1, 1 , 0 ) sem_cumpl_ope_acum                         
 from #tmpAcuMetas a --select * from #tmpAcuMetas                                 
 join #tmpDILMOpe X on A.RNUM = X.RNUM and A.dia_habil = X.TDIA          
  ---------------------------------------------------------------------------------             
             
  exec mod_rep.[com].[RSRDFCA050_2] @cod_rel,@p_fecha,@tip_cod,@tipmet,@flag,@hor,0,2,@prod          
end
