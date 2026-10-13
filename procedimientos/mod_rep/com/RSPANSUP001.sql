-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-01-25 13:50:33.260000

CREATE procedure [com].[RSPANSUP001]    
                                 
@tip_cod int,@cod_rel nvarchar(10),@carg nvarchar(100)                                      
AS                                      
BEGIN                                            
 SET NOCOUNT ON;                                      
 -- Result Headers Multiple                                      
 exec [rep].[FTHEACOLS01] 'PANEL_SUP_01';                                      
                                      
-- declare @tip_cod int=18,@cod_rel nvarchar(10)='250',@carg nvarchar(100) ='1'       
-- declare @tip_cod int=11,@cod_rel nvarchar(10)='TEDEM001',@carg nvarchar(100) ='1'      
-- declare @tip_cod int=20,@cod_rel nvarchar(10)='1_3',@carg nvarchar(100) ='1'      
-- declare @tip_cod int=14,@cod_rel nvarchar(10)='1',@carg nvarchar(100) ='0'       
-- declare @tip_cod int=15,@cod_rel nvarchar(10)='2',@carg nvarchar(100) ='5'      
-- declare @tip_cod int=7,@cod_rel nvarchar(10)='231',@carg nvarchar(100) ='1'                                   
                                   
 declare @fecha date= (select MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE()))                                    
 declare @fec varchar(8) = (select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)          
    
      
    
 declare @defs as rep.TTHCOLDEF;                                      
                                      
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                                      
     
     
 insert into @tvars values                                       
 ('num_ope_pre',null,null,null,null,null),                                      
 ('num_ope_post',null,null,null,null,null),                                      
 ('num_ope_tot','num_ope_pre+num_ope_post','num_ope_tot','cal','dp','float'),    
                                       
 ('num_ope_conf',null,null,null,null,null),                                      
 ('part_ope_conf','cast(ISNULL(num_ope_conf,0) as float)/(num_ope_pre+num_ope_post)','part_ope_conf','cal','dp','float'),                                      
 ('num_ope_seal',null,null,null,null,null),                                      
 ('part_ope_seal','cast(num_ope_seal  as float)/(num_ope_pre+num_ope_post)','part_ope_seal','cal','dp','float'),                                      
 ('num_ope_regr',null,null,null,null,null),                                      
 ('part_ope_regr','cast(num_ope_regr  as float)/(num_ope_pre+num_ope_post)','part_ope_regr','cal','dp','float')                                      
    
                              
 insert into @tfil values                                      
 ('TODOS','fec','"'+@fec+'"')                                      
                                      
 if(@carg<>0)                                      
 begin                                      
  insert into @tfil values                                      
  ('TODOS','car_sup','"'+@carg+'"')                                      
 end                                      
                                       
 declare @jer varchar(100);                                      
 insert into @tfil                                      
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output                                      
                                      
 insert into @tconf                                      
 values                                      
 ('level_alias','style')       
     
 
                                   
                    -- DROP TABLE #SUPER         select * from #SUPER         
 create table #Super (fila int,cod_cadm varchar(250)null,cod_csec varchar(250)null,style int,descripcion varchar(250)null,num_ope_pre int null,                             
                      num_ope_post int null,num_ope_tot int null,num_ope_conf int null,part_ope_conf FLOAT null,num_ope_seal int null,part_ope_seal FLOAT null,                 
       num_ope_regr int null,part_ope_regr FLOAT null)              
 insert into #Super                                  
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf  -- ,@show_query=1      
  
  
  
 /*    
  alter table #Super     
 add cuo_pre int null,    
  cuo_pos int null,    
  cuo_tot int null,    
  sem_pre int null,    
  sem_pos int null,    
  sem_tot int null,    
  por_pre int null,    
  por_pos int null,    
  por_tot int  null*/    
    
     
    
--drop table #base_in, #HPVP001,#VDMCOM01    
-- declare @fecha date= '2022-12-19'    
--ADMINISTRADOR    
     
      
  -- declare @fecha date= '2022-07-25' --DROP TABLE  #HPVP001    
  select HCODBT, SUM(hdias) HDIAS into #HPVP001 from storage.[gpr].[HPVP001] where HFECPRO = EOMONTH(@fecha) group by HCODBT     
  
  select distinct HCODREL HCODSEC into #VDMCOM01  
  from [storage].[com].[VDMCOM01]  
  where eomonth(HFECPRO)=eomonth(@fecha) and HTIPCOD=2  
  
  SELECT * into #WJERCOR03 FROM storage.[ref].WJERCOR03 A  INNER JOIN #VDMCOM01 B ON A.RCODSEC = b.HCODSEC  
  where RFECPRO =@fecha  and RDESGRU = 'INDIVIDUAL' AND RINDFEC = 'ACTUAL'  
   
   
-- declare @fecha date= '2022-12-19'   
--ADMINISTRADOR    
   select distinct RCODADM, 1 as CARGO,      
   count(distinct   
  CASE WHEN rcodsec<>RCODADM THEN   
   CASE WHEN isnull(C.HDIAS,0)>29 and rcodsec=ADB.HCODPER THEN null   
   ELSE rcodsec  
   END  
  ELSE   null  END) NRO_SUBA,  
   RCODTER, A.RCODCOR, A.RCODUNI, A.RCODGRU, 3 as PRE,1 as POST, 1 as CARG, '0' as N_HIDDEN, 0.75 PORC,    
   isnull(C.HDIAS,0)HDIAS, (3+1) CUOXASESOR -- (3+1) números fijos dados por riesgos    
    into #base_in      
   from #WJERCOR03 A    
   left join storage.ref.RECUC001 B    
   on A.RCODUNI = B.RCODUNI    
   left join #HPVP001 C    
   on B.RCODADM = C.HCODBT   
   left join [storage].[gpr].[HPAD001] AD  
   on B.RCODADM = AD.HCODPER   
   left join (select * from mod_sys_login.[dbo].[SUSEALT01] where eomonth(SFECCRE)=EOMONTH(@fecha) ) SUP  
   on AD.HMAILPER = SUP.SCODALT  
   left join [storage].[gpr].[HPAD001] ADB  
   on SUP.SCODUSE = ADB.HMAILPER   
   where RFECPRO =@fecha and RDESGRU = 'INDIVIDUAL' AND RINDFEC = 'ACTUAL' and A.RCODUNI <>126 --GDP  
     --and rcodadm in ('TCPAR002','TJHUG002')  
   group by rcodadm, RCODTER,A.RCODUNI,A.RCODCOR, A.RCODGRU,AD.HMAILPER,SCODUSE,ADB.HCODPER  , c.HDIAS --ADMIN   
     
  union    
--GERENTE CORREDOR  declare @fecha date= '2022-02-22'    
  select distinct RCODADM, 3 as CARGO, 1 NRO_SUBA, A.RCODTER, A.RCODCOR, A.RCODUNI, A.RCODGRU, 2 as PRE,3 as POST, 3 as CARG, '11' as  N_HIDDEN, 0.40 PORC,    
  isnull(C.HDIAS,0)HDIAS, round(((30-isnull(C.HDIAS,0))/cast(30 as numeric))* (2 + 3) ,0) CUOXASESOR -- (2+3) números fijos dados por riesgos    
   from #WJERCOR03  A    
   left join storage.ref.RECUC001 E    
   on A.RCODUNI = E.RCODUNI    
   left join storage.ref.RECCT001 B    
   on a.rcodcor = b.rcodcor    
   left join #HPVP001 C    
   on B.RUSUADM = C.HCODBT    
  where RFECPRO = @fecha and RDESGRU = 'INDIVIDUAL' AND RINDFEC = 'ACTUAL' and A.RCODUNI <>126 group by rcodadm, A.RCODTER,A.RCODCOR, A.RCODUNI,A.RCODGRU,C.HDIAS    
    
  union    
--JEFE AGRO declare @fecha date= '2022-02-21'    
 -- se solicita que no se considere el correodr 15 sjl    
  select distinct B.RUSUADM, 5 CARGO, count (distinct RCODCOR) NRO_SUBA, A.RCODTER, A.RCODCOR, 0 RCODUNI, RCODGRU,     
     5 as PRE, 4 as POST, 5 as CARG, '0' as N_HIDDEN ,0.5555555555555556 PORC,    
  isnull(C.HDIAS,0)HDIAS, round(((30-isnull(C.HDIAS,0))/cast(30 as numeric))* (5 + 4),0) CUOXASESOR -- (5+4) números fijos dados por riesgos    
  from #WJERCOR03 a    
  inner join storage.ref.RECCA001 b     
  on SUBSTRING( a.RCODTER,3,1) = b.RCODTER    
  left join #HPVP001 C    
  on B.RUSUADM = C.HCODBT     
  where RFECPRO = @fecha and RDESGRU = 'INDIVIDUAL' AND RINDFEC = 'ACTUAL' and A.RCODUNI <>126  and a.rcodcor <> 15 group by B.RUSUADM,A.RCODTER,A.RCODCOR, A.RCODUNI,RCODGRU,C.HDIAS --AGRO    
     
   --drop table #basesup   
 select a.*,   
 CASE WHEN cargo =1 then 3 else  floor (CUOXASESOR*PORC) end  as hnumpre,     
 CASE WHEN cargo =1 then 1 else  CUOXASESOR - floor (CUOXASESOR*PORC)  end  as hnumpost,     
 CASE WHEN cargo =1 then 3* NRO_SUBA else floor (CUOXASESOR*PORC) * NRO_SUBA end as tot_cuo_pre,    
 CASE WHEN cargo =1 then 1* NRO_SUBA else (CUOXASESOR - floor (CUOXASESOR*PORC) ) * NRO_SUBA end as tot_cuo_post,    
 CUOXASESOR * NRO_SUBA as tot_cuo     
  into #basesup    
 from #base_in  a --where rcodadm in ('TEDEM001','TAALI001')    
    
   --select * from #base_in  where rcoduni in (160,273) and cargo =1  
   --select * from #basesup   where rcoduni in (160,273)  and cargo =1  
    
      
 -- declare @tip_cod int=7 , @cod_rel varchar(20)='231', @fec varchar(10)='2022-07-25',@carg nvarchar(100) ='0'    
 -- declare @tip_cod int=18 , @cod_rel varchar(20)='266', @fec varchar(10)='2022-07-23',@carg nvarchar(100) ='1'    
 -- declare @tip_cod int=15 , @cod_rel varchar(20)='2', @fec varchar(10)='2022-01-27',@carg nvarchar(100) ='5'    
 -- declare @tip_cod int=13 , @cod_rel varchar(20)='1_5', @fec varchar(10)='2022-01-25',@carg nvarchar(100) ='0'    
 -- declare @tip_cod int=14 , @cod_rel varchar(20)='5', @fec varchar(10)='2022-01-25',@carg nvarchar(100) ='1'    
 declare @select_campo1 varchar(20), @select_campo2 varchar(20), @select_campo3 varchar(20), @select_campo4 varchar(20),    
 @sql varchar(max),@where_campo1 varchar(20), @where_campo2 varchar(20), @grouping1 varchar(20), @grouping2 varchar(20)    
    
 declare @join1 varchar(max), @join2 varchar(max), @join3 varchar(max), @join4 varchar(max)      
    
 declare @wh3 varchar(max)    
 if(@carg=0)    
  begin   set @wh3 =' 1=1 '  end    
 if(@carg>=1)    
  begin   set @wh3 =' cargo = '+@carg+' '  end    
    

	 
    
 if(@tip_cod=7)--FC    
  Begin    
  select @select_campo1 ='_FC.RCODEMP', @select_campo2 ='_FC.RDESEMP',@select_campo3 ='RCODGRU',@select_campo4 ='RDESGRU',    
  @where_campo1 = '1', @grouping1='_FC.RCODEMP', @grouping2='RCODGRU'    
  --    
  select @join1 = 'select 7 as hcodrel, sum(tot_cuo_pre) as hnumpre, sum(tot_cuo_post) as hnumpost,sum(tot_cuo) as tot_cuo from #basesup where '+@wh3+' '    
  select @join2 = 'select RCODGRU hcodrel, SUM(tot_cuo_pre) as hnumpre, SUM(tot_cuo_post) as hnumpost, SUM(tot_cuo) as tot_cuo from #basesup where '+@wh3+' group by RCODGRU'  -- 7 231    

  select @join3 =  'select isnull(count(SOPEPRE),0) SOPEPRE, RCODGRU hcodrel from
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where SFECPRO in (cast('''+@fec+''' as varchar (10))) and SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPRE <3)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10))) group by RCODGRU'

  select @join4 =  'select isnull(count(SOPEPOST),0) SOPEPOST, RCODGRU hcodrel from 
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where SFECPRO in (cast('''+@fec+''' as varchar (10))) and SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPOST <1)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10))) group by RCODGRU'


  End    
 else if (@tip_cod=21)--GRU   
  Begin    
  select @select_campo1 ='RCODGRU', @select_campo2 ='RDESGRU',@select_campo3 ='RCODTER',@select_campo4 ='RDESTER',    
  @where_campo1 = 'RCODGRU', @grouping1='RCODGRU', @grouping2='RCODTER'    
  --    
  select @join1 = 'select RCODGRU as hcodrel,sum(tot_cuo_pre) as hnumpre, sum(tot_cuo_post) as hnumpost, sum(tot_cuo) as tot_cuo from #basesup where '+@wh3+' and RCODGRU = '''+@cod_rel+''' group by RCODGRU' --13 1_1    
  select @join2 = 'select RCODTER hcodrel, sum(tot_cuo_pre) as hnumpre, sum(tot_cuo_post) as hnumpost, sum(tot_cuo) as tot_cuo from #basesup where '+@wh3+' and RCODGRU = '''+@cod_rel+''' group by RCODTER '    
  
  select @join3 =  'select isnull(count(SOPEPRE),0) SOPEPRE, RCODTER hcodrel from
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where  SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPRE <3)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and RCODGRU = '''+@cod_rel+'''  group by RCODTER ' 

  select @join4 =  'select isnull(count(SOPEPOST),0) SOPEPOST, RCODTER hcodrel from 
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where  SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPOST <1)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and RCODGRU = '''+@cod_rel+''' group by RCODTER ' 


  End    
 else if (@tip_cod=20)--TERR    
  Begin    
  select @select_campo1 ='RCODTER', @select_campo2 ='RDESTER',@select_campo3 ='RCODCOR',@select_campo4 ='RDESCOR',    
  @where_campo1 = 'RCODTER', @grouping1='RCODTER', @grouping2='RCODCOR'    
  --    
  select @join1 = 'select RCODTER as hcodrel, sum(tot_cuo_pre) as hnumpre, sum(tot_cuo_post) as hnumpost, sum(tot_cuo) as tot_cuo from #basesup where '+@wh3+' and RCODTER = '''+@cod_rel+''' group by RCODTER' -- 15 1    
  select @join2 = 'select RCODCOR hcodrel, SUM(tot_cuo_pre) hnumpre, SUM(tot_cuo_post) hnumpost, SUM(tot_cuo) tot_cuo from #basesup where '+@wh3+' group by RCODCOR'    
  
 select @join3 =  'select isnull(count(SOPEPRE),0) SOPEPRE, RCODCOR hcodrel from
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where  SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPRE <3)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and RCODTER = '''+@cod_rel+'''  group by RCODCOR'

  select @join4 =  'select isnull(count(SOPEPOST),0) SOPEPOST, RCODCOR hcodrel from 
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where  SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPOST <1)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and RCODTER = '''+@cod_rel+'''  group by RCODCOR'

  End    
 else if (@tip_cod=19)--CORR    
  Begin    
  select @select_campo1 ='RCODCOR', @select_campo2 ='RDESCOR',@select_campo3 ='RCODUNI',@select_campo4 ='RDESUNI',    
  @where_campo1 = 'RCODCOR', @grouping1='RCODCOR', @grouping2='RCODUNI'    
  --    
  select @join1 = 'select RCODCOR as hcodrel, sum(tot_cuo_pre) as hnumpre, sum(tot_cuo_post) as hnumpost, sum(tot_cuo) as tot_cuo from #basesup where '+@wh3+' and RCODCOR = '''+@cod_rel+''' group by RCODCOR' --14 1    
  select @join2 = 'select RCODUNI  hcodrel, SUM(tot_cuo_pre) hnumpre, SUM(tot_cuo_post) hnumpost, SUM(tot_cuo) tot_cuo from #basesup where '+@wh3+' and RCODCOR = '''+@cod_rel+''' group by RCODUNI'    
  
  select @join3 =  'select isnull(count(SOPEPRE),0) SOPEPRE, RCODUNI hcodrel from
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where  SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPRE <3)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and RCODCOR = '''+@cod_rel+''' group by RCODUNI' 

  select @join4 =  'select isnull(count(SOPEPOST),0) SOPEPOST, RCODUNI hcodrel from 
  storage.ref.wjercor03 B left join (select * from storage.[com_act].[SDAS006] where  SCODAGR  =6 and SCARG in ('+@carg+') and SOPEPOST <1)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and RCODCOR = '''+@cod_rel+''' group by RCODUNI' 

  End    
 else if (@tip_cod=18)--UNI    
  Begin    
  select @select_campo1 ='RCODUNI', @select_campo2 ='RDESUNI',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',    
  @where_campo1 ='RCODUNI', @grouping1='RCODUNI', @grouping2='RCODSEC'    
  --    
  select @join1 = 'select RCODUNI as hcodrel,sum(tot_cuo_pre) as hnumpre, sum(tot_cuo_post) as hnumpost, sum(tot_cuo) as tot_cuo from #basesup where '+@wh3+' and RCODUNI = '''+@cod_rel+''' group by RCODUNI' --11 TAALI001    
  select @join2 = 'select rcodsec hcodrel, hnumpre, hnumpost, (hnumpre+hnumpost) as tot_cuo      
  from #WJERCOR03 a left join #basesup b on a.RCODUNI = b.RCODUNI    
  where   '+@wh3+' and RFECPRO= cast('''+@fec+''' as varchar (10))  and a.rcodUNI = '''+@cod_rel+''' and N_HIDDEN <> 11  AND RINDFEC = ''ACTUAL''  '    
  
  select @join3 =  'select iif(SOPEPRE>=3,0,1) SOPEPRE, RCODSEC hcodrel from storage.ref.wjercor03 B
  left join (select SFECPRO,isnull(SUM(SOPEPRE),0) SOPEPRE, SCODSEC from storage.[com_act].[SDAS006] 
  where SFECPRO in (cast('''+@fec+''' as varchar (10))) and SCODAGR  =6 
  and SCARG in ('+@carg+')  group by SCODSEC,SFECPRO)  A 
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and rcodUNI = '''+@cod_rel+'''  '

  select @join4 =  'select iif(SOPEPOST>=1,0,1) SOPEPOST, RCODSEC , RCODSEC hcodrel from storage.ref.wjercor03 B 
  left join (select SFECPRO,isnull(SUM(SOPEPOST),0) SOPEPOST, SCODSEC from storage.[com_act].[SDAS006] 
  where SFECPRO in (cast('''+@fec+''' as varchar (10))) and SCODAGR  =6 
  and SCARG in ('+@carg+')  group by SCODSEC,SFECPRO)  A
  on a.scodsec = b.rcodsec and a.sfecpro = b.rfecpro and b.RINDFEC=''ACTUAL'' 
  where RFECPRO in (cast('''+@fec+''' as varchar (10)))  and rcodUNI = '''+@cod_rel+'''  '

  End    
    
 
    
 declare @excluir as varchar (12) = 'ini'   
 if (@tip_cod=18)   
  begin   
  ;with a as (  
  select distinct RCODADM, 1 as CARGO,  RCODSEC,    
    count(distinct   
  CASE WHEN rcodsec<>RCODADM THEN   
   CASE WHEN isnull(C.HDIAS,0)>29 and rcodsec=ADB.HCODPER THEN null   
   ELSE rcodsec END  
  ELSE   null  END)  NRO_SUBA  
   from #WJERCOR03  A    
   left join storage.ref.RECUC001 B    
   on A.RCODUNI = B.RCODUNI    
   left join #HPVP001 C    
   on B.RCODADM = C.HCODBT   
   left join [storage].[gpr].[HPAD001] AD  
   on B.RCODADM = AD.HCODPER   
   left join (select * from mod_sys_login.[dbo].[SUSEALT01] where eomonth(SFECCRE)=EOMONTH(@fec) ) SUP  
   on AD.HMAILPER = SUP.SCODALT  
   left join [storage].[gpr].[HPAD001] ADB  
   on SUP.SCODUSE = ADB.HMAILPER   
   where RFECPRO =@fec and RDESGRU = 'INDIVIDUAL' AND RINDFEC = 'ACTUAL'   and A.RCODUNI = @cod_rel  
    group by rcodadm, RCODSEC   
   )  
   select @excluir = RCODSEC  from a where NRO_SUBA = 0  
 end   
  
  
   set @where_campo2 =     
 case when @tip_cod=7 then '=1' else     
 case when @cod_rel = '9999' then 'is null' else '='''+@cod_rel+'''' end    
 end    
    
  
  
   set @sql = '    
 ;with datos as (     
 select     
 isnull('+@select_campo1+',''9999'') id_prin ,max(isnull('+@select_campo2+',''SIN ASIGNAR'')) desc_prin,    
 isnull('+@select_campo3+',''9999'') id_sec ,max(isnull('+@select_campo4+',''SIN ASIGNAR'')) desc_sec    
     
 from  (values(7,''FINANCIERA CONFIANZA'')) _FC(RCODEMP,RDESEMP)    
 LEFT JOIN #WJERCOR03  C    
 on C.RFECPRO='''+@fec+''' and RINDFEC=''ACTUAL'' and RDESGRU = ''INDIVIDUAL''     
 where  C.RFECPRO = '''+@fec+''' and '+@where_campo1+'  '+@where_campo2+'    
       
 group by grouping sets((isnull('+@grouping1+',''9999'')),(isnull('+@grouping1+',''9999''),isnull('+@grouping2+',''9999'')))    
 )    
    
    
 select row_number() over(order by id_prin,id_sec) fila,    
   id_prin,id_sec,    
   case when id_sec is not null then 0 when id_prin is not null then 1 end style,    
   case when id_sec is not null then desc_sec  when id_prin is not null then desc_prin  end descripcion    
   into #base_jerar    
   from datos    
    
   if ( (select count (*) from #super)  = 0) begin    
   insert into #Super    
    select *, 0 num_ope_pre, 0 num_ope_post,0 num_ope_tot, 0 num_ope_conf, 0 part_ope_conf,0 num_ope_seal,0 part_ope_seal,0 num_ope_regr,0 part_ope_regr    
      from #base_jerar    
   end    
    
   if ((select count (*) from #base_jerar) > (select count (*) from #super)) begin    
   select a.*, 0 num_ope_pre, 0 num_ope_post,0 num_ope_tot, 0 num_ope_conf, 0 part_ope_conf,0 num_ope_seal,0 part_ope_seal,0 num_ope_regr,0 part_ope_regr    
   into #super1    
   from #base_jerar a left join #super b    
   on a.id_sec = b.cod_csec where b.fila is null and a.style = 0    
   insert into  #super    
   select * from #super1    
   end    
   
  if ('''+@excluir+''' <>''ini'')    
  begin  
   update #super set     
   num_ope_pre = num_ope_pre -(select num_ope_pre from #super  where cod_csec =  '''+@excluir+''' ),  
   num_ope_post = num_ope_post -(select num_ope_post from #super  where cod_csec ='''+@excluir+''' ),  
   num_ope_tot = num_ope_tot -(select num_ope_tot from #super  where cod_csec =  '''+@excluir+''' ),  
   num_ope_conf = num_ope_conf -(select num_ope_conf from #super  where cod_csec ='''+@excluir+''' ),  
   num_ope_seal = num_ope_seal -(select num_ope_seal from #super  where cod_csec ='''+@excluir+''' ),  
   num_ope_regr = num_ope_regr -(select num_ope_regr from #super  where cod_csec ='''+@excluir+''' )  
   where Style = 1   
 end   
  
   
  
                               
   select a.*,d.hnumpre as cuo_pre,d.hnumpost as cuo_pos,d.tot_cuo as cuo_tot,     
    --case when a.num_ope_pre < d.hnumpre and d.hnumpre > 0 then -1 else 1 end as sem_pre,      
    --case when a.num_ope_post < d.hnumpost and d.hnumpost > 0 then -1 else 1 end as sem_pos,
	--case when a.num_ope_pre+a.num_ope_post < d.hnumpre+d.hnumpost and d.hnumpre > 0 and d.hnumpost > 0 then -1 else 1 end as sem_tot,
	case when e.SOPEPRE  > 0  then -1 else 1 end as sem_pre,      
	case when f.SOPEPOST  > 0  then -1 else 1 end as sem_pos, 
    case when (e.SOPEPRE + f.SOPEPOST) >=1 then -1 else 1 end as sem_tot,                               
    CASE WHEN d.hnumpre > 0 THEN cast(cast(a.num_ope_pre as numeric)/cast(d.hnumpre as numeric) as decimal(18,2)) ELSE 0 END as por_pre,                                  
    CASE WHEN d.hnumpost > 0 THEN cast(cast(a.num_ope_post as numeric)/cast(d.hnumpost as numeric) as decimal(18,2)) ELSE 0 END as por_pos,                  
    CASE WHEN d.tot_cuo > 0 THEN cast(cast(a.num_ope_tot as numeric)/cast(d.tot_cuo as numeric) as decimal(18,2)) ELSE 0 END as por_tot       
    into #part2                                  
   from #super a                                  
   left join ('+@join2+') d                            
   on a.cod_csec = d.hcodrel  
   left join ('+@join3+') e                           
   on a.cod_csec = e.hcodrel 
   left join ('+@join4+') f                           
   on a.cod_csec = f.hcodrel 
   where a.style=0     
  
  
    if ('''+@excluir+''' <>''ini'')    
   begin   
   update #part2 set     
   num_ope_pre=0,num_ope_post=0,num_ope_tot=0,num_ope_conf=0,part_ope_conf=0,num_ope_seal=0,part_ope_seal=0,num_ope_regr=0,part_ope_regr=0,   
   cuo_pre=0,cuo_pos=0,cuo_tot=0,sem_pre=0,sem_pos=0,sem_tot=0,por_pre=0,por_pos=0,por_tot=0   
   where cod_csec =  '''+@excluir+'''  
 end   
  
     
  
  
    
   select a.*,d.hnumpre as cuo_pre,d.hnumpost as cuo_pos,d.tot_cuo as cuo_tot,    
   (select min(sem_pre) from #part2 where cod_csec <>'''+@excluir+''') as sem_pre,    
   (select min(sem_pos) from #part2 where cod_csec <>'''+@excluir+''') as sem_pos,    
    (select min(sem_tot) from #part2 where cod_csec <>'''+@excluir+''')as sem_tot,                               
   CASE WHEN d.hnumpre > 0 THEN cast(cast(a.num_ope_pre as numeric)/cast(d.hnumpre as numeric) as decimal(18,2)) ELSE 0 END  as por_pre,                                  
   CASE WHEN d.hnumpost > 0 THEN cast(cast(a.num_ope_post as numeric)/cast(d.hnumpost as numeric) as decimal(18,2)) ELSE 0 END  as por_pos,                                  
   CASE WHEN d.tot_cuo > 0 THEN cast(cast(a.num_ope_tot as numeric)/cast(d.tot_cuo as numeric) as decimal(18,2)) ELSE 0 END  as por_tot                        
   from #Super a                                  
   left join ('+@join1+') d                                 
   on a.cod_cadm = d.hcodrel                                   
   where a.style=1     
    
    UNION ALL          
    
   select * from #part2    
    
    
 '    
     
   print @sql     
    
 exec (@sql)    
            
        
end
