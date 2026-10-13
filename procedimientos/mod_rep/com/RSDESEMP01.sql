-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-01-02 08:11:46.107000
--exec  [com].[RSDESEMP01]   7,'231','20230913'  
--exec  [com].[RSDESEMP01]   21,'2','20230831'  
CREATE PROCEDURE [com].[RSDESEMP01]        
@tip_cod int, @cod_rel varchar(10), @fec  varchar(8)     
AS        
BEGIN          
 set nocount on;    
  
  
-- declare @tip_cod int =7,@cod_rel nvarchar(10) ='231',  @fec varchar(8) ='20230913'      
-- declare @tip_cod int =21,@cod_rel nvarchar(10) ='2',  @fec varchar(8) ='20230831'    --grupal  
  
--FECHAS PARA MOSTRAR EN EL REPORTE  
select RORD, format(RFEC,'yyyy-MM-dd') F, format(RFEC,'yyyyMMdd') F2  into #fechas   from storage.[util].[FVECFEC01](@fec,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')     
-- select * from #fechas  drop table #fechas  
   
  
  
 declare @fecs varchar(250);       
 select @fecs=string_agg(F2,',') from #fechas      
 declare @fecha1 as date, @fecha2 as date, @fecha3 as date, @fecha4 as date, @fecha5 as date, @fecha6 as date  
 select @fecha1 = F2 from #fechas where RORD=1      
 select @fecha2 = F2 from #fechas where RORD=2      
 select @fecha3 = F2 from #fechas where RORD=3      
 select @fecha4 = F2 from #fechas where RORD=4  
 select @fecha5 = F2 from #fechas where RORD=5   
 select @fecha6 = F2 from #fechas where RORD=6   
       
 declare @defs as rep.TTHCOLDEF;        
        
  insert into @defs            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN)  values         
  
 (0,1,1,'DESVAL','Variable (en miles PEN, %, y número)',NULL,2,1,'string',null,null),     
 (1,null,1,'2021',format(@fecha1,'yyyy'),3,1,NULL,NULL,null,null),     
 (2,null,1,'2022',format(@fecha6,'yyyy'),3,1,NULL,NULL,null,null),     
 (3,8,1,'col_7','META',1,2,NULL,'number',null,null),     
 (4,9,1,'col_8',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),     
 (5,10,1,'col_9','TMM',2,2,NULL,'number',null,null),    
 (6,11,1,'col_10',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),     
 (7,12,1,'col_11','TAM',2,2,NULL,'number',null,null),     
 (8,13,1,'col_12',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),     
 (9,14,1,'col_13','Distancia Meta',2,2,NULL,'number',null,null),     
    
 (10,2,2,'col_1',format(@fecha1,'dd-MMM'),null,null,null,'number',null,null),     
 (11,3,2,'col_2',format(@fecha2,'dd-MMM'),null,null,null,'number',null,null),     
 (12,4,2,'col_3',format(@fecha3,'dd-MMM'),null,null,null,'number',null,null),     
 (13,5,2,'col_4',format(@fecha4,'dd-MMM'),null,null,null,'number',null,null),     
 (14,6,2,'col_5',format(@fecha5,'dd-MMM'),null,null,null,'number',null,null),     
 (15,7,2,'col_6',format(@fecha6,'dd-MMM'),null,null,null,'number',null,null)    
    
  
  
 select rep.FFTHCOLDEF(@defs) result;    
  
--select * from #wjercor03  --drop table #wjercor03  
--PASAMOS JERARQUIA A UNA TABLA TEMP  
-- declare @tip_cod int =7,@cod_rel nvarchar(10) ='231',  @fec varchar(8) ='20230831'      
-- declare @tip_cod int =21,@cod_rel nvarchar(10) ='2',  @fec varchar(8) ='20230831'    --grupal  
  
 select a.RORD, b.*  into  #wjercor03     
 from  #fechas  A left join storage.ref.wjercor03 b on a.F = b.Rfecpro  and rindfec = 'actual'  
 where    
    CASE cast(@tip_cod as varchar (3))  
        WHEN 7 THEN cast(RCODFC as varchar (3))  
        WHEN 21 THEN cast(RCODGRU as varchar (3))  
        WHEN 20 THEN cast(RCODTER as varchar (3))  
        WHEN 19 THEN cast(RCODCOR as varchar (3))  
     WHEN 18 THEN cast(RCODUNI as varchar (3))
	 WHEN 17 THEN cast(RCODUCO as varchar (10))
    END =@cod_rel  
  
   
--PASAMOS WACLI007 A UNA TABLA TEMP   select * from #wacli007_mes  drop table #wacli007_mes  
select  HFECPRO, CASE WHEN HCODSEC='' THEN '0' ELSE HCODSEC END HCODSEC,  
 count(distinct HCODPER)HCODPER,  
  count(distinct CASE WHEN HINDBANC=1 THEN HCODPER ELSE null END)HINDBANC ,  
  count(distinct CASE WHEN HINDGEN=1 THEN HCODPER ELSE null END)HINDGEN ,  
  count(distinct CASE WHEN HINDMIGR=1 THEN HCODPER ELSE null END)HINDMIGR ,  
  count(distinct CASE WHEN HINDRUR=1 THEN HCODPER ELSE null END)HINDRUR    
  into #wacli007_mes  
 from  storage.com_act.WACLI007 WHERE HFECPRO in (select F2 from #fechas)  
 group by HFECPRO,HCODSEC    
  
  
 --drop table #base     select * from #base  
--CREAMOS LA TABLA BASE CON LOS CALCULOS  
create table #base (ID int,cod_fec varchar(10)null,HTOTSEC int null,  
[166] float null,[166001] float null,[166002] float null,[166003] float null, [166004] float null, [166005] float null,[166006] float null,[166007] float null,[166008] float null,   
[10055] float null,[10055001] float null,[10055002] float null,[10055003] float null, [10055004] float null, [10055005] float null,[10055006] float null,[10055007] float null,[10055008] float null,   
[10054] float null,[10054001] float null,[10054002] float null,[10054003] float null, [10054004] float null, [10054005] float null,[10054006] float null,[10054007] float null,[10054008] float null,   
[10056] float null,[10056001] float null,[10056002] float null,[10056003] float null, [10056004] float null, [10056005] float null,[10056006] float null,[10056007] float null,[10056008] float null,   
[10057] float null,[10057001] float null,[10057002] float null,[10057003] float null, [10057004] float null, [10057005] float null,[10057006] float null,[10057007] float null,[10057008] float null )  
  
  
  
-- declare @tip_cod int =7,@cod_rel nvarchar(10) ='231',  @fec varchar(8) ='20230627'   
 insert into #base  
-- declare @tip_cod int =7,@cod_rel nvarchar(10) ='231',  @fec varchar(8) ='20230831'      
-- declare @tip_cod int =21,@cod_rel nvarchar(10) ='2',  @fec varchar(8) ='20230831'    --grupal  
  
select _CAL.RORD,_CAL.F,  
COUNT(distinct  rcodsec)HTOTSEC   
,SUM(HCODPER) [166]  --HCLINU,   
,SUM(HCODPER)/COUNT(distinct b.rcodsec)   [166001] --HPROMCLI  
,cast(COUNT(distinct CASE WHEN HCODPER IS NULL OR HCODPER=0   THEN b.RCODSEC  ELSE null END )as float) / COUNT(distinct b.rcodsec) [166002], --HCLINU_0, -- COUNT(distinct b.rcodsec)  
cast(COUNT(distinct CASE WHEN HCODPER >=1 and   HCODPER<=2  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [166003], --HCLINU_1_2,  
cast(COUNT(distinct CASE WHEN HCODPER >=3 and   HCODPER<=4  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [166004], --HCLINU_3_4,  
cast(COUNT(distinct CASE WHEN HCODPER >=5 THEN  b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [166005], --HCLINU_5,  
cast(COUNT(distinct CASE WHEN HCODPER >=1 and   HCODPER<=10  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [166006], --HCLINU_1_10,  
cast(COUNT(distinct CASE WHEN HCODPER >=11 and  HCODPER<=20  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [166007], --HCLINU_11_20,  
cast(COUNT(distinct CASE WHEN HCODPER >=21 THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [166008], --HCLINU_21,  
  
SUM(HINDGEN) [10055], --HCLI_MUJ,  
SUM(HINDGEN)/COUNT(distinct b.rcodsec), --HPROMCLI_MUJ,  
cast(COUNT(distinct CASE WHEN HINDGEN IS NULL OR HINDGEN=0  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10055002], --HCLIMUJ_0,  
cast(COUNT(distinct CASE WHEN HINDGEN >=1 and   HINDGEN<=2  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10055003], --HCLIMUJ_1_2,  
cast(COUNT(distinct CASE WHEN HINDGEN >=3 and   HINDGEN<=4  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10055004], --HCLIMUJ_3_4,  
cast(COUNT(distinct CASE WHEN HINDGEN >=5 THEN  b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10055005], --HCLIMUJ_5,  
cast(COUNT(distinct CASE WHEN HINDGEN >=1 and   HINDGEN<=10  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10055006], --HCLIMUJ_1_10,  
cast(COUNT(distinct CASE WHEN HINDGEN >=11 and  HINDGEN<=20  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10055007], --HCLIMUJ_11_20,  
cast(COUNT(distinct CASE WHEN HINDGEN >=21 THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10055008], --HCLIMUJ_21,  
  
  
SUM(HINDBANC) [10054], --HCLI_BANC,  
SUM(HINDBANC)/COUNT(distinct b.rcodsec), --HPROMBANC,   
cast(COUNT(distinct CASE WHEN HINDBANC IS NULL OR HINDBANC=0   THEN b.RCODSEC  ELSE null END)as float) / COUNT(distinct b.rcodsec) [10054002],-- HCLIBANC_0,  
cast(COUNT(distinct CASE WHEN HINDBANC >=1 and   HINDBANC<=2   THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10054003], --HCLIBANC_1_2,  
cast(COUNT(distinct CASE WHEN HINDBANC >=3 and   HINDBANC<=4   THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10054004], --HCLIBANC_3_4,  
cast(COUNT(distinct CASE WHEN HINDBANC >=5  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec)  [10054005], --HCLIBANC_5,  
cast(COUNT(distinct CASE WHEN HINDBANC >=1 and   HINDBANC<=10  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10054006], --HCLIBANC_1_10,  
cast(COUNT(distinct CASE WHEN HINDBANC >=11 and  HINDBANC<=20  THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec) [10054007], --HCLIBANC_11_20,  
cast(COUNT(distinct CASE WHEN HINDBANC >=21 THEN b.RCODSEC ELSE null END)as float) / COUNT(distinct b.rcodsec)  [10054008], --HCLIMBANC_21,  
  
  
SUM(HINDRUR) [10056], --HCLI_RU,  
SUM(HINDRUR)/COUNT(distinct b.rcodsec), --HPROMRUR,   
cast( COUNT(distinct CASE WHEN HINDRUR IS NULL OR HINDRUR=0   THEN b.RCODSEC  ELSE null END) as float) / COUNT(distinct b.rcodsec)[10056002], -- HCLIRU_0,  
cast( COUNT(distinct CASE WHEN HINDRUR >=1 and   HINDRUR<=2   THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10056003], --HCLIRU_1_2,  
cast( COUNT(distinct CASE WHEN HINDRUR >=3 and   HINDRUR<=4   THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10056004], --HCLIRU_3_4,  
cast( COUNT(distinct CASE WHEN HINDRUR >=5  THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10056005], --HCLIRU_5,  
cast( COUNT(distinct CASE WHEN HINDRUR >=1 and   HINDRUR<=10  THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec)  [10056006], --HCLIRU_1_10,  
cast( COUNT(distinct CASE WHEN HINDRUR >=11 and  HINDRUR<=20  THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec)  [10056007], --HCLIRU_11_20,  
cast( COUNT(distinct CASE WHEN HINDRUR >=21 THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10056008], --HCLIRU_21,  
   
  
SUM(HINDMIGR) [10057],--HCLI_MIG,  
SUM(HINDMIGR)/COUNT(distinct b.rcodsec), --HPROMMIG,    
cast( COUNT(distinct CASE WHEN HINDMIGR IS NULL OR HINDMIGR=0 THEN b.RCODSEC  ELSE null END) as float) / COUNT(distinct b.rcodsec)  [10057002],-- HCLIMIG_0,   
cast( COUNT(distinct CASE WHEN HINDMIGR >=1 and   HINDMIGR<=2   THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10057003],--  HCLIMIG_1_2,  
cast( COUNT(distinct CASE WHEN HINDMIGR >=3 and   HINDMIGR<=4   THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10057004],--  HCLIMIG_3_4,  
cast( COUNT(distinct CASE WHEN HINDMIGR >=5  THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10057005],--  HINDMIGR_5,  
cast( COUNT(distinct CASE WHEN HINDMIGR >=1 and   HINDMIGR<=10  THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec)  [10057006],-- HCLIMIG_1_10,  
cast( COUNT(distinct CASE WHEN HINDMIGR >=11 and  HINDMIGR<=20  THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec)  [10057007],-- HCLIMIG_11_20,  
cast( COUNT(distinct CASE WHEN HINDMIGR >=21 THEN b.RCODSEC ELSE null END) as float) / COUNT(distinct b.rcodsec) [10057008] -- HCLIMIG_21  
   
  
from #wjercor03 B  
left join #fechas _CAL on B.RFECPRO=_CAL.F2  
left join #wacli007_mes A on A.hcodsec =b.rcodsec and a.hfecpro = b.rfecpro    
where    
CASE cast(@tip_cod as varchar (3))  
        WHEN 7 THEN cast(b.RCODFC as varchar (3))  
        WHEN 21 THEN cast(b.RCODGRU as varchar (3))  
        WHEN 20 THEN cast(b.RCODTER as varchar (3))  
        WHEN 19 THEN cast(b.RCODCOR as varchar (3))  
     WHEN 18 THEN cast(b.RCODUNI as varchar (3))  
	 WHEN 17 THEN cast(b.RCODUCO as varchar (13))  
    END =@cod_rel  
group by  _CAL.RORD, _CAL.F order by 1  
  
  
  
  
  
--unpivot para darle forma al resultado posterior pasamos las columnas ds como una fila      
    select RORD, descripcion variables,  resultado   valores  into #base_3 --select * from  #base_3   drop table #base_3      
   from #fechas a left join  #base b on a.f= b.cod_fec       
   unpivot      
   (      
   resultado      
   for descripcion in (  
   [166], [166001]    
   ,[166002],[166003],[166004],[166005],[166006],[166007],[166008],  
   [10055],[10055001],[10055002],[10055003],[10055004],[10055005],[10055006],[10055007],[10055008],  
   [10054],[10054001],[10054002],[10054003],[10054004],[10054005],[10054006],[10054007],[10054008],  
   [10056],[10056001],[10056002],[10056003],[10056004],[10056005],[10056006],[10056007],[10056008],  
   [10057],[10057001],[10057002],[10057003],[10057004],[10057005],[10057006],[10057007],[10057008]  
   )  
   ) as b   
   order by RORD asc     
  
   update #base_3 set valores  = case when valores = 0 then null else valores end  
   where variables  = 10054  
  
  
   
select  RORD,variables,valores                
    into    #RESULTPRE     -- select * from #RESULTPRE where rord=7    drop table #RESULTPRE          
    from    #base_3               
    UNION     
    select 7 FORD, cast (B.HCODVAR as int) , B.HVALVAR                
    FROM    #base_3 A                
        LEFT join [storage].[com].[VDMCOM01] B     --SELECT* FROM [storage].[com].[VDMCOM01]            
        on A.variables=  cast (B.HCODVAR as int)              
            and B.HTIPMETA = 1                
            and B.HFECPRO = eomonth(@fec)                
            and B.HTIPCOD = @tip_cod                
            and B.HCODREL = @cod_rel  
     
  
  
  
--METAS MENSUAL   
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20230624'          
    select F.RORD,  A.variables , B.HVALVAR    
 into    #RESULTPRE_M --drop table #RESULTPRE_M   select * from #RESULTPRE_M   
    FROM   
 #fechas F left join #base_3 A     
 on F.RORD =a.RORD  
        LEFT join [storage].[com].[VDMCOM01] B   --SELECT* FROM [storage].[com].[VDMCOM01]              
        on A.variables= B.HCODVAR                  
            and B.HTIPMETA = 1                  
            and B.HFECPRO = eomonth(F.F)             
            and B.HTIPCOD = @tip_cod               
            and B.HCODREL = @cod_rel   
   where variables in(166,10055,10054,10056,10057)  
    
  
--CUMPLIMIENTO DE META MENSUAL  
insert  into  #RESULTPRE     
 select A.RORD,   
 CASE  
    WHEN B.variables = 166  THEN 10092 --nuevos%mes  
    WHEN B.variables = 10054  THEN 10071 --banc%mes  
    WHEN B.variables = 10055  THEN 10072 --muj%mes  
    WHEN B.variables = 10056  THEN 10073 --rur%mes  
    WHEN B.variables = 10057  THEN 10074 /*mig%mes*/end variables,  
    case when a.HVALVAR >0 then  b.valores/a.HVALVAR end valores from #RESULTPRE_M A   
 left join #RESULTPRE B  on a.variables = b.variables and A.RORD= B.RORD   
 where  B.variables in ('166','10054','10055','10056','10057')  
  
  
  
 select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                
    into #RESULTPRE2 --#AAA                
    from #RESULTPRE -- select*from    #AAA       drop table  #RESULTPRE2      
    UNION ALL                
  select  case when concat(A.RORD,'-',B.RORD) = '6-4' then 9                
        when concat(A.RORD,'-',B.RORD) = '6-1' then 11                
        when concat(A.RORD,'-',B.RORD) = '6-7' then 13 end RORD                
        ,A.variables,     
  util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in  
  (  
  10092,166002,166003,166004,166005,  
  10071,10054002,10054003,10054004,10054005,  
  10072,10055002,10055003,10055004,10055005,  
  10073,10056002,10056003,10056004,10056005,  
  10074,10057002,10057003,10057004,10057005  
  ),1,null)) SVALOR        
  from #RESULTPRE A --select*from #RESULTPRE                
        join #RESULTPRE B                
        on A.variables=B.variables                
  where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')             
        UNION ALL                
   select  case when concat(A.RORD,'-',B.RORD) ='6-4' then 8                
            when concat(A.RORD,'-',B.RORD) ='6-1' then 10    
            when concat(A.RORD,'-',B.RORD) ='6-7' then 12 end RORD                
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR    
   from #RESULTPRE A                
   join #RESULTPRE B                
   on A.variables=B.variables                
   where concat(A.RORD,'-',B.RORD) in('6-4','6-1','6-7')     
  
  
  
  
--AGREGAMOS FILA PARA MOSTRAR META MENSUAL  
insert  into  #RESULTPRE2     
 select A.RORD,   
 CASE  
    WHEN B.variables = 166  THEN 166010 --nuevos_meta  
    WHEN B.variables = 10054  THEN 10071010 --banc_meta  
    WHEN B.variables = 10055  THEN 10072010 --muj_meta  
    WHEN B.variables = 10056  THEN 10073010 --rur_meta  
    WHEN B.variables = 10057  THEN 10074010  end variables, --mig_meta  
    format(a.HVALVAR,'N0')  valores from #RESULTPRE_M A   
 left join #RESULTPRE B  on a.variables = b.variables and A.RORD= B.RORD   
 where  B.variables in ('166','10054','10055','10056','10057')  
  
  
  
----pivotenado los resultados    
 select *                
 into #RES  --  select*from #RES        drop table #RES                   
 from #RESULTPRE2    
 pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])) PVT                
    
  
   
-->CREAMOS LA TABLA A PUBLICAR           
create table #CMG      --drop table   #CMG          
(   RDESVAR varchar(250),                
    RCODVAR int                
)      
  
--se filtra por grupal?  buscamos si hay individuales  
declare @ind int  
select @ind = count(*) from #wjercor03 where RCODGRU=1  
    
    
   
IF @ind >0  
   begin  
    insert into #CMG             
  values     
   ('Clientes Nuevos del Mes', 166),   
   ('Meta Clientes Nuevos del Mes', 166010),  
   ('Cumplimiento de meta del mes (%)', 10092),  
   ('Promedio de clientes captados por asesor (N°)',166001),  
   ('Asesores con 0 cllientes captados (%)',166002),  
   ('Asesores con 1-2 cllientes captados (%)',166003),  
   ('Asesores con 3-4 cllientes captados (%)',166004),  
   ('Asesores con 5 o más cllientes captados (%)',166005),  
   ('Mujeres',10055),  
   ('Meta Mujeres',10072010),  
   ('Cumplimiento de meta del mes (%)',10072),  
   ('Promedio de clientes captados por asesor (N°)',10055001),  
   ('Asesores con 0 cllientes captados (%)',10055002),  
   ('Asesores con 1-2 cllientes captados (%)',10055003),  
   ('Asesores con 3-4 cllientes captados (%)',10055004),  
   ('Asesores con 5 o más cllientes captados (%)',10055005),  
   ('Bancarizados *',10054),  
   ('Meta Bancarizados',10071010),  
   ('Cumplimiento de meta del mes (%)',10071),  
   ('Promedio de clientes captados por asesor (N°)',10054001),  
   ('Asesores con 0 cllientes captados (%)',10054002),  
   ('Asesores con 1-2 cllientes captados (%)',10054003),  
   ('Asesores con 3-4 cllientes captados (%)',10054004),  
   ('Asesores con 5 o más cllientes captados (%)',10054005),  
   ('Rural',10056),  
   ('Meta Rural',10073010),  
   ('Cumplimiento de meta del mes (%)',10073),  
   ('Promedio de clientes captados por asesor (N°)',10056001),  
   ('Asesores con 0 cllientes captados (%)',10056002),  
   ('Asesores con 1-2 cllientes captados (%)',10056003),  
   ('Asesores con 3-4 cllientes captados (%)',10056004),  
   ('Asesores con 5 o más cllientes captados (%)',10056005),  
   ('Migrantes',10057),  
   ('Meta Migrantes',10074010),  
   ('Cumplimiento de meta del mes (%)',10074),  
   ('Promedio de clientes captados por asesor (N°)',10057001),  
   ('Asesores con 0 cllientes captados (%)',10057002),  
   ('Asesores con 1-2 cllientes captados (%)',10057003),  
   ('Asesores con 3-4 cllientes captados (%)',10057004),  
   ('Asesores con 5 o más cllientes captados (%)',10057005)  
  
   end  
   else  
   begin   
   insert into #CMG    
    
  values     
   ('Clientes Nuevos del Mes', 166),    
   ('Meta Clientes Nuevos del Mes', 166010),  
   ('Cumplimiento de meta del mes (%)', 10092),  
   ('Promedio de clientes captados por asesor (N°)',166001),  
   ('Asesores con 0 cllientes captados (%)',166002),  
   ('Asesores con 1-10 cllientes captados (%)',166006),  
   ('Asesores con 11-20 cllientes captados (%)',166007),  
   ('Asesores con 21 o más cllientes captados (%)',166008),  
   ('Mujeres',10055),  
   ('Meta Mujeres',10072010),  
   ('Cumplimiento de meta del mes (%)',10072),  
   ('Promedio de clientes captados por asesor (N°)',10055001),  
   ('Asesores con 0 cllientes captados (%)',10055002),  
   ('Asesores con 1-10 cllientes captados (%)',10055006),  
   ('Asesores con 11-20 cllientes captados (%)',10055007),  
   ('Asesores con 21 o más cllientes captados (%)',10055008),  
   ('Bancarizados *',10054),  
   ('Meta Bancarizados',10071010),  
   ('Cumplimiento de meta del mes (%)',10071),  
   ('Promedio de clientes captados por asesor (N°)',10054001),  
   ('Asesores con 0 cllientes captados (%)',10054002),  
   ('Asesores con 1-10 cllientes captados (%)',10054006),  
   ('Asesores con 11-20 cllientes captados (%)',10054007),  
   ('Asesores con 21 o más cllientes captados (%)',10054008),  
   ('Rural',10056),  
   ('Meta Rural',10073010),  
   ('Cumplimiento de meta del mes (%)',10073),  
   ('Promedio de clientes captados por asesor (N°)',10056001),  
   ('Asesores con 0 cllientes captados (%)',10056002),  
   ('Asesores con 1-10 cllientes captados (%)',10056006),  
   ('Asesores con 3-4 cllientes captados (%)',10056007),  
   ('Asesores con 21 o más cllientes captados (%)',10056008),  
   ('Migrantes',10057),  
   ('Meta Migrantes',10074010),  
   ('Cumplimiento de meta del mes (%)',10074),  
   ('Promedio de clientes captados por asesor (N°)',10057001),  
   ('Asesores con 0 cllientes captados (%)',10057002),  
   ('Asesores con 1-10 cllientes captados (%)',10057006),  
   ('Asesores con 11-20 cllientes captados (%)',10057007),  
   ('Asesores con 21 o más cllientes captados (%)',10057008)  
   end  
  
   
 select     
 CASE WHEN A.RCODVAR in (166,10055,10054,10056,10057) THEN 1 ELSE 0 END AS style,    
 A.RDESVAR as DESVAL, [1] as col_1, [2] as col_2, [3] as col_3,   
 [4] as col_4,   
 [5] as col_5,   
 [6] as col_6,   
 [7] as col_7, [8] as col_8, [9] as col_9, [10] as col_10, [11] as col_11, [12] as col_12, [13] as col_13     
  into #RESULTADO             --drop table #RESULTADO  
 from #CMG A  
 left join      
 #RES  B                 
    on A.RCODVAR=B.variables           
         
  
select * from #RESULTADO  
drop table #CMG,#RESULTADO,#RES,#RESULTPRE,#RESULTPRE2,#RESULTPRE_M,#base_3,#base,#fechas,#wjercor03,#wacli007_mes  
  
  
END
