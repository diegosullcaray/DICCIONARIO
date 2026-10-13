-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:23.737000
--exec [com].[RSRDFCA038] 7,'231',1,1     
--exec [com].[RSRDFCA037] 7,'231',1      
CREATE procedure [com].[RSRDFCA038]           
(                  
 @tipcod int,@cod_rel varchar(50),@tipmet int ,@prod int         
--declare  @tipmet INT=1,@TIPCOD int=7,@cod_rel varchar(50)  ='231'               
)                  
AS                      
BEGIN                      
 SET NOCOUNT ON;         
       
--declare  @tipmet INT=1,@TIPCOD int=7,@cod_rel varchar(50)  ='231' ,@prod int=1         
        
          
select '' as json          
          
declare @p_fecha date,@fec_i date,@flag bit,@hor varchar(2),@TIPMETA int,@indcan int=0  ,@jer int=2 ,@tasaMinima varchar(250),@fTasaMinima date,@pfecproc date        
        
        
                  
 select @p_fecha=max(HFECPRO) from [storage].[com_act].[HCDA001]                  
 select @fec_i=max(SFECPRO) from [storage].[com_act].[SDAS010]                  
 select @flag=case when @fec_i>@p_fecha then 1 else 0 end                  
 select @p_fecha=case when @fec_i>@p_fecha then @fec_i else @p_fecha end                  
  select @hor=max(SHORPRO) from   [storage].[com_act].[SDAS010] where SFECPRO=@p_fecha             
  set @TIPMETA=@tipmet            
  set @fTasaMinima=(select max(hfecpro) from storage.[com_act].[WGATH002] )    
  
  set @pfecproc=(select max(hfecpro) from storage.com_act.HCDA001)
         
           
  --select @cod_rel,@p_fecha,@TIPCOD,@tipmet,@flag,@hor,0,2               
          
                         
 -- exec mod_rep.[com].[RSRDFCA027_2] @cod_rel,@p_fecha,@TIPCOD,@tipmet,@flag,@hor,@indcan,@jer                 
-------------------------------------------------          
                
          
 declare @p_fecha1 date  ,@nivel int =1                
                    
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
 ('fec_corr','true')              
              
              
 declare @jera varchar(100)              
 insert into @tfil                  
 exec piv.GPIVLEV01 @tipcod,@cod_rel,@jera output                 
              
 select @jera = '"fec_dese"'+ ',' +@jera               
                 
 create table #SDAF001 (fila int null,fec varchar(50) null,cod varchar(50)null,cod_u varchar(250) null,style int null,descripcion varchar(250)null,num_ope int null,SMONDESMN float null)              
           
 insert into #SDAF001            
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jera,@columns='"vars"',@config=@tconf--,@show_query=1                  
                  
 delete from #SDAF001 where style<>1              
              
 select  SFECDES, SNUMOPE, SMONDESMN, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC                
 into #T1              
 from  storage.[com_act].[SDAF003]                  
 where  SFECPRO = @p_fecha and SFECDES = @p_fecha and SHORPRO=@hor and 1=1  and @flag=1              
 and scodagr=3  --select * from #T1              
              
 select * into #WJERCOR3   --select * from #WJERCOR3              
 from  storage.[ref].WJERCOR03               
 where RINDFEC='ACTUAL' and RFECPRO=@p_fecha1              
 and case when @tipcod=7 then '1'                
                        when @tipcod=21 then cast(RCODGRU as varchar(250))                
      when @tipcod=20 then cast(RCODTER as varchar(250))                
      when @tipcod=19 then cast(RCODCOR as varchar(250))                
      when @tipcod=18 then cast(RCODUNI as varchar(250))              
      when @tipcod=17 then cast(RCODUCO as varchar(250)) end = case when @tipcod=7 then '1' else @cod_rel end                
              
 select distinct a.sfecdes,              
        isnull(case when @TIPCOD=7 then cast(RCODFC as varchar(250))                 
       when @TIPCOD=21 then cast(RCODGRU as varchar(250))                  
    when @TIPCOD=20 then cast(RCODTER as varchar(250))              
    when @TIPCOD=19 then cast(RCODCOR as varchar(250))              
    when @TIPCOD=18 then cast(RCODUNI as varchar(250))              
    when @TIPCOD=17 then cast(RCODUCO as varchar(250))              
  end,'9999') Cod,              
  isnull(case when @TIPCOD=7 then  RDESFC               
       when @TIPCOD=21 then        RDESGRU            
    when @TIPCOD=20 then        RDESTER               
    when @TIPCOD=19 then        RDESCOR                
    when @TIPCOD=18 then        RDESUNI              
    when @TIPCOD=17 then        RDESUCO              
  end,'SIN ASIGNAR') descr,              
 sum(SNUMOPE)SNUMOPE,sum(SMONDESMN)SMONDESMN               
 into #SDAF003  --select * from #SDAF003              
 from #T1 a              
 left join #WJERCOR3 _JC --select distinct RCODTER from #WJERCOR3              
 on a.SCODSEC=_JC.RCODSEC                 
 group by a.sfecdes,              
 case when @TIPCOD=7 then cast(RCODFC as varchar(250))                 
       when @TIPCOD=21 then cast(RCODGRU as varchar(250))                  
    when @TIPCOD=20 then cast(RCODTER as varchar(250))              
    when @TIPCOD=19 then cast(RCODCOR as varchar(250))              
    when @TIPCOD=18 then cast(RCODUNI as varchar(250))              
    when @TIPCOD=17 then cast(RCODUCO as varchar(250))              
  end,              
 case when @TIPCOD=7 then  RDESFC          when @TIPCOD=21 then        RDESGRU               
    when @TIPCOD=20 then        RDESTER               
    when @TIPCOD=19 then        RDESCOR                
    when @TIPCOD=18 then        RDESUNI              
    when @TIPCOD=17 then        RDESUCO              
  end              
               
  select fec,cod,descripcion,num_ope,SMONDESMN                
 into #SDAF  --SELECT * FROM #SDAF              
 from #SDAF001 union all  --SELECT * FROM #SDAF001              
 select * from #SDAF003 where cod=@cod_rel              
                
  select eomonth(fec) rnum,sum(num_ope) ope_acum,sum(SMONDESMN)  des_acum              
  into #DESEMBOLSOS --select * from #DESEMBOLSOS              
  from #SDAF              
  group by eomonth(fec)              
                 
 /*CANCELACIONES*/              
 select  SFECPRO, SCODAGR, isnull(SSUCCLI,-1) SSUCCLI, isnull(SCODSEC,'N/A') SCODSEC,                  
   SSCAPIMN + SMDESMN - SSCASMN - SSCAPFMN SCANMN                  
 INTO #tmpCancelaciones  --drop table #tmpCancelaciones              
 from [storage].[com_act].[SDAS004]                      
 WHERE @indcan = 1 and SFECPRO between convert(date,convert(varchar(6),@p_fecha1,112) + '01') and @p_fecha1                  
               
 set language spanish;          
       
 DECLARE @OPE_ACUM float, @des_acum float       
                
 select      RORD dia_habil,              
             RFEC Fecha,DATENAME(weekday,RFEC) fecha_nombre              
 INTO #FecHabil --drop table #FecHabil              
 from        storage.util.FVECFEC01(eomonth(@p_fecha1),'ini-hoy|hab') A                
              
 declare @CDiasHab int               
 set @CDiasHab =(select count(*) from #FecHabil)              


 ;with cteDatMetas AS(                  
 select eomonth(@p_fecha) RNUM, case A.HCODVAR                  
       when 5006 then 'meta_ope_acum'                  
       when 133 then 'meta_des_acum'                  
       when 136 then 'meta_can_acum'                  
      end DESVAL, A.HVALVAR VAL                  
  from  storage.[com].[VDMCOM01] A                  
  where A.HCODVAR in(5006, 133, 136)               
  and  A.HTIPMETA = @TIPMETA                 
  and a.htipcod=@TIPCOD              
  and a.HCODREL =@cod_rel              
   and eomonth(A.HFECPRO) = eomonth(@p_fecha)              
 ),              
 cteMetas as(                  
 select RNUM, meta_ope_acum, meta_des_acum,meta_can_acum                  
 FROM cteDatMetas A                  
 pivot(MAX(VAL)               
 FOR DESVAL in(meta_ope_acum,meta_des_acum,meta_can_acum)              
      ) B              
 ),              
 cteCan as(                  
 SELECT eomonth(@p_fecha) RNUM, dia_habil,                  
    SUM(IIF(B.Fecha <= @p_fecha and A.SCANMN is null, 0, IIF(B.Fecha > @p_fecha and A.SCANMN is not null,null,A.SCANMN))) can_diario                  
  FROM #tmpCancelaciones A                     
 right join #FecHabil B on  A.SFECPRO = B.Fecha    --select * from #FecHabil              
  group BY  dia_habil              
 ),              
 cteCalc as(              
 SELECT eomonth(@p_fecha) RNUM, dia_habil,fecha,                   
    SUM(IIF(B.Fecha <= @p_fecha and A.num_ope is null, 0, IIF(B.Fecha > @p_fecha and A.num_ope is not null,null,A.num_ope))) ope_diario,                  
    SUM(IIF(B.Fecha <= @p_fecha and A.SMONDESMN is null, 0, IIF(B.Fecha > @p_fecha and A.SMONDESMN is not null, null,A.SMONDESMN))) des_diario                   
  FROM #SDAF A    --select * from #FecHabil              
   right join #FecHabil B on A.fec = B.Fecha                  
  group BY   dia_habil,fecha              
 ),              
 cteAcum as(                  
  select  A.RNUM, B.dia_habil,b.fecha, SUM(A.ope_diario) ope_acum, SUM(A.des_diario) des_acum                  
  FROM cteCalc A                  
   join cteCalc B                  
    on  A.RNUM = B.RNUM                  
    AND A.dia_habil <= B.dia_habil                  
  group by A.RNUM, B.dia_habil,b.fecha),              
  cteCanMetas as(                  
  select eomonth(@p_fecha) RNUM, A.dia_habil, B.meta_can_acum * null meta_can_diario                   
  FROM #FecHabil A join cteMetas B on eomonth(a.fecha) = B.RNUM              
  )              
  ,cteCanAcuMetas as(                  
  select  A.RNUM, B.dia_habil, SUM(A.meta_can_diario) meta_can_acum_2                  
  FROM cteCanMetas A                  
   join cteCanMetas B                  
    on  A.RNUM = B.RNUM                  
    and A.dia_habil <= B.dia_habil                  
  group by A.RNUM, B.dia_habil              
  )              
  ,cteAcuMetas as(                  
  SELECT A.*, D.ope_acum,               
  D.des_acum,               
  @CDiasHab p_dias_habiles, --C.p_dias_habiles,               
  --C.Factor,                   
    B.meta_ope_acum, B.meta_des_acum,                  
    dif_pos_can = IIF(@indcan = 0,0,1) * isnull(com.FLIMNEG(E.can_diario - F.meta_can_acum_2,0),0),                  
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
   left join cteCanAcuMetas F                  
    on  A.RNUM = F.RNUM                  
    and A.dia_habil = F.dia_habil                  
   left join cteMetas B                  
    on  A.RNUM = B.RNUM)                    

 select  *,            
   meta_des_acum_can = meta_des_acum + MAX(IIF(dia_habil = ult_dia_habil,dif_pos_can,null)) over(partition by ''),                
   meta_des_diario_can = meta_des_acum / p_dias_habiles + dif_pos_can                    
 INTO  #tmpAcuMetas             
 FROM cteAcuMetas   
 
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

 declare @tDilDes as [com].[TDILMETA], @tDilOpe as [com].[TDILMETA], @n int = 1, @RNUM date, @m int                
   select distinct  RNUM, row_number() over(order by cod) N INTO #tmpParT FROM (select distinct cod,eomonth(fec)RNUM from  #SDAF001) A   --select* from  #SDAF001              
 select @m = MAX(N) from #tmpParT                
                

  while @n <= @m 
  begin                
  select  @RNUM = RNUM                
  FROM #tmpParT                
  WHERE N = @n                
                  
  insert into @tDilDes                
  select  dia_habil, des_diario, meta_des_diario_can , meta_des_acum_can, Factor, ult_dia_habil                
  FROM #tmpAcuMetas  --select * from #tmpAcuMetas               
  WHERE RNUM = @RNUM                
                  
  insert into @tDilOpe                
  select  dia_habil, ope_diario, meta_ope_acum / p_dias_habiles, meta_ope_acum, Factor, ult_dia_habil                
  FROM #tmpAcuMetas    --select * from #tmpAcuMetas            
  WHERE RNUM = @RNUM                
                  
  insert into #tmpDILMDes select @RNUM, TDIA, TMDIARIO from [com].[FDILMETA](@tDilDes,0.5,8)                  
  insert into #tmpDILMOpe select @RNUM, TDIA, TMDIARIO from [com].[FDILMETA](@tDilOpe,0.5,0)                
                  
  delete from @tDilDes                
  delete from @tDilOpe                
                
  set @n = @n + 1      
  end
   
 ;with cte_a as ( select a.*,x.tmdiario tmdiarioope,w.tmdiario tmdiariomonto from #tmpAcuMetas a
  join #tmpDILMDes W on A.RNUM = W.RNUM and A.dia_habil = W.TDIA              
 join #tmpDILMOpe X on A.RNUM = X.RNUM and A.dia_habil = X.TDIA    
 )
 select * into #DatosDia from cte_a where fecha<=@pfecproc
  
select 
case when @prod in(2,3) then '0' else sum(isnull(ope_diario,0)) end ope_acum_,
case when @prod in(2,3) then '0' else sum(isnull(tmdiarioope,0)) end meta_ope_acum_, 
case when @prod in(2,3) then '0' else IIF(sum(isnull(tmdiarioope,0)) <> 0, round((1.0*sum(isnull(ope_diario,0)))/(1.0*sum(isnull(tmdiarioope,0))),4)*100,0) end cumpl_ope_acum,   
case when @prod in(2,3) then '0' else sum(isnull(des_diario,0)) end des_acum,
case when @prod in(2,3) then '0' else sum(isnull(tmdiariomonto,0)) end meta_des_acum ,
case when @prod in(2,3) then '0' else IIF(sum(isnull(tmdiariomonto,0)) <> 0,round(sum(isnull(des_diario,0))/sum(isnull(tmdiariomonto,0)),4)*100,0) end cumpl_des_acum
from #DatosDia

select * from #DatosDia   
end
