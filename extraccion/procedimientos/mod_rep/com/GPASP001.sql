-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.837000
--exec       [com].[GPASP001]        14,2   
CREATE procedure [com].[GPASP001]        
@tip_cod int,@cod_rel varchar(20) 
AS          
BEGIN      
 SET NOCOUNT ON;            
 declare @p_fecha varchar(8)          
 select @p_fecha=(select replace(max(sfecpro),'-','') from [storage].[com_pas].[SDPS002])          
 declare @p_fecha_ant varchar(250)          
 declare @defs as rep.TTHCOLDEF;            
 SELECT @p_fecha_ant=MAX(RFEC) FROM [storage].[ref].[RCALEN001] WHERE RDIAFER=0 AND EOMONTH(RFEC)=EOMONTH(@p_fecha,-1)          
           
 SET LANGUAGE spanish;          
 insert into @defs            
 (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values            
 (1,1,2,1,'descripcion','Descripción','string',1)          
           
          
 insert into @defs            
 (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values            
 (2,2,2,1,'TotalCapt','Total Captaciones','number','.0-0'),          
 (3,3,2,1,'Var_Mes','Variación Mes','number','.0-0')          
          
 insert into @defs           
 (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values          
 (4,1,'Aho','Ahorro',null,2),          
 (5,1,'cts','CTS',null,2),          
 (6,1,'DPF','DPF',null,2)          
          
 insert into @defs            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS)  values            
 (7,4,2,'ahorro_MA','Ahorro al <br>'+format(cast(@p_fecha_ant as date),'dd-MMM'),'number','.0-0',null,null),            
 (8,5,2,'var_ahorro','Variación Mes','number','.0-0',null,null),          
 (9,6,2,'cts_MA','CTS al <br>'+format(cast(@p_fecha_ant as date),'dd-MMM'),'number','.0-0',null,null),            
 (10,7,2,'var_cts','Variación Mes','number','.0-0',null,null),          
 (11,8,2,'dpl_MA','DPF al <br>'+format(cast(@p_fecha_ant as date),'dd-MMM'),'number','.0-0',null,null),            
 (12,9,2,'var_dpl','Variación Mes','number','.0-0',null,null)          
          
 SET LANGUAGE english;            
  select rep.FFTHCOLDEF(@defs) result;            
          
          
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF          
 insert into @tvars          
 values ('Sal_Cap_red',null,null,null,null,null)          
          
 insert into @tfil          
 values          
 --tabla,clave,valores (usar la doble comilla para valores texto/fecha)          
 ('todos','fec','"'+@p_fecha+'"'+'')          
          
 insert into @tconf          
 values          
 ('level_alias','style') -- ,
 --('insert_to','#pasFC'),
 -- ('fec_corr','true')        
 declare @jer varchar(100)          
 insert into @tfil           
 exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jer output    
   
      
 create table #pasAyer (fila int,cod_cod varchar(250)null,cod_cter varchar(50)null,cod_prod_capt VARCHAR(250)NULL,style INT NULL,descripcion VARCHAR(500)NULL,Sal_Cap_red FLOAT NULL)
 create table #pasMS (fila int,cod_cod varchar(250)null,cod_cter varchar(50)null,cod_prod_capt VARCHAR(250)NULL,style INT NULL,descripcion VARCHAR(500)NULL,Sal_Cap_red FLOAT NULL)
 
 set @jer=@jer + ',"prod_capt"'        
 insert into #pasAyer
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf
 
 delete from @tfil where TKEYFIL='fec'          
 insert into @tfil values ('todos','fec','"'+@p_fecha_ant+'"'+'')        
 insert into #pasMS
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf
 
 update #pasAyer set style=3 where style=0
 update #pasAyer set style=0 where style=1
 update #pasAyer set style=1 where style=2
 
 update #pasMS set style=3 where style=0
 update #pasMS set style=0 where style=1
 update #pasMS set style=1 where style=2

 
 ;with a as (
   select cod_cter,style,descripcion,sum(Sal_Cap_red)  Sal_Cap_red
   from #pasAyer where style in(0,1)
   group by cod_cter,style,descripcion
 ),
 b as (
   select cod_cter,style,descripcion,sum(Sal_Cap_red)  Sal_Cap_red
   from #pasMS where style in(0,1)
   group by cod_cter,style,descripcion
 ),
 var_mes as (
  select a.cod_cter,a.style,a.descripcion,a.Sal_Cap_red as TotalCapt,a.sal_cap_red - b.sal_cap_red as Var_Mes
  from a a
  inner join b b
  on a.descripcion=b.descripcion and isnull(a.cod_cter,0)=isnull(b.cod_cter,0)
 ) ,
 ahorro as (
 select '0' as COD_CTER,null descripcion,sum(a.Sal_Cap_red) as SAL_AYER,sum(B.Sal_Cap_red) as SAL_MA ,sum(a.Sal_Cap_red) - sum(b.Sal_Cap_red) as var_ahorro
 from #pasAyer a  --select*from #pasAyer
 left join (select cod_cter,descripcion,Sal_Cap_red from #pasMS where descripcion='AHORROS') b
 on a.cod_cter=b.cod_cter and a.descripcion=b.descripcion
 where a.descripcion='AHORROS'
 union all
 select A.COD_CTER,a.descripcion,a.Sal_Cap_red as SAL_AYER,B.Sal_Cap_red as SAL_MA ,a.Sal_Cap_red - b.Sal_Cap_red as var_ahorro
 from #pasAyer a  --select*from #pasAyer
 left join (select cod_cter,descripcion,Sal_Cap_red from #pasMS where descripcion='AHORROS') b
 on a.cod_cter=b.cod_cter and a.descripcion=b.descripcion
 where a.descripcion='AHORROS'
 ),
 cts as (
  select '0' as COD_CTER,null descripcion,sum(a.Sal_Cap_red) as SAL_AYER,sum(B.Sal_Cap_red) as SAL_MA ,sum(a.Sal_Cap_red) - sum(b.Sal_Cap_red) as var_cts
 from #pasAyer a  --select*from #pasAyer
 left join (select cod_cter,descripcion,Sal_Cap_red from #pasMS where descripcion='CTS') b
 on a.cod_cter=b.cod_cter and a.descripcion=b.descripcion
 where a.descripcion='CTS'
 union all
 select A.COD_CTER,a.descripcion,a.Sal_Cap_red as SAL_AYER,B.Sal_Cap_red as SAL_MA ,a.Sal_Cap_red - b.Sal_Cap_red as var_cts
 from #pasAyer a  --select*from #pasAyer
 left join (select cod_cter,descripcion,Sal_Cap_red from #pasMS where descripcion='CTS') b
 on a.cod_cter=b.cod_cter and a.descripcion=b.descripcion
 where a.descripcion='CTS'
 ),
 DPF AS (
 select '0' as COD_CTER,null descripcion,sum(a.Sal_Cap_red) as SAL_AYER,sum(B.Sal_Cap_red) as SAL_MA ,sum(a.Sal_Cap_red) - sum(b.Sal_Cap_red) as var_dpl
 from #pasAyer a  --select*from #pasAyer
 left join (select cod_cter,descripcion,Sal_Cap_red from #pasMS where descripcion='PLAZO FIJO') b
 on a.cod_cter=b.cod_cter and a.descripcion=b.descripcion
 where a.descripcion='PLAZO FIJO'
 union all
 select A.COD_CTER,a.descripcion,a.Sal_Cap_red as SAL_AYER,B.Sal_Cap_red as SAL_MA ,a.Sal_Cap_red - b.Sal_Cap_red as var_dpl
 from #pasAyer a  --select*from #pasAyer
 left join (select cod_cter,descripcion,Sal_Cap_red from #pasMS where descripcion='PLAZO FIJO') b
 on a.cod_cter=b.cod_cter and a.descripcion=b.descripcion
 where a.descripcion='PLAZO FIJO'
 )
 select a.* , b.SAL_MA as ahorro_MA,b.var_ahorro, c.SAL_MA as cts_MA,c.var_cts,d.SAL_MA as dpl_MA,d.var_dpl
 from var_mes a
 left join ahorro b
 on isnull(a.cod_cter,'0')=b.cod_cter
 left join  cts c 
 on isnull(a.cod_cter,'0')=c.cod_cter
 left join dpf d
 on isnull(a.cod_cter,'0')=d.cod_cter
 order by a.style  desc

 end
