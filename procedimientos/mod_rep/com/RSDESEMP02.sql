-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-10-09 02:21:36.377000
--EXEC [mod_rep].[com].[RSDESEMP02] '2','44856559'
CREATE procedure  [com].[RSDESEMP02]     
@tip_cod int,@cod_rel varchar(20)  
            
AS              
BEGIN              
 SET NOCOUNT ON;  
 --declare @tip_cod int = 2,@cod_rel varchar(20) ='44856559' 
 declare @hcodbt varchar(50),@cf varchar(10),@mesant varchar(10)   
  
 select  top 1 @hcodbt = HCODBT   
  from  [storage].[gpr].[VPPH001]     
  where  HNUMDOC=  @cod_rel --'00245492'   
     
select @cf=MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())         
select @mesant = RFEC from storage.[util].[FVECFEC01](@cf,'cmg_5')    
        
 declare @defs as rep.TTHCOLDEF;      
    
  insert into @defs            
    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TFORTYP,TFORMOD,TSTBACKGROUND,TSTDEWIDTH,THIDDEN)  values       
 (1,1,1,'DESVAL','Variable',1,1,'string',null,null,null,null),    
 (2,2,1,'col_3',@mesant,1,1,'number',null,null,null,null),         
 (3,3,1,'col_4',@cf,1,1,'number',null,null,null,null),    
 (4,4,1,'col_14','Variación',1,1,'number',null,null,null,null),     
 (5,5,1,'col_7','Meta',1,1,'number','.0-0',null,null,null),  
 (6,6,1,'col_12',NULL,1,NULL,'traffic-light',null,null,null,'TRUE'), 
 (7,7,1,'col_13','Distancia Meta',2,1,'number','.0-0',null,null,null)   
     
  
 select rep.FFTHCOLDEF(@defs) result;      
    
   --select * from storage.com_act.wacli007 where hcodsec = 'TEVID001'   
  -- drop table #fechas  
  -- declare @fec date = '2022-05-30', @hcodbt varchar (10) = 'TEVID001'     
      select RORD, format(RFEC,'yyyy-MM-dd') F, format(RFEC,'yyyyMMdd') F2 into #fechas  from storage.[util].[FVECFEC01](@cf,'cmg_1,cmg_4,cmg_5,cmg_6')          
  --select * from #fechas
-- declare @cf date = '2022-05-30', @hcodbt varchar (10) = 'TAGAM100' 
  create table #base_2 (Id int IDENTITY(1,1) NOT NULL,cod_fec varchar(10)null,[10054] float null, [10055] float null,[10056] float null,[10057] float null,    
  [10071] float null,[10072] float null,[10073] float null,[10074] float null,[166] float null)              
   insert into #base_2    
   select F,  
   count(distinct CASE WHEN HINDBANC=1 THEN HCODPER ELSE null END) [10054],  -------------
   CASE WHEN count(distinct HCODPER) >=1 then   
   cast(count(distinct CASE WHEN HINDBANC=1 THEN HCODPER ELSE null END)as float)/count(distinct HCODPER) else 0 end  [10071],  
   count(distinct CASE WHEN HINDGEN=1 THEN HCODPER ELSE null END) [10055],  ------------------
   CASE WHEN count(distinct HCODPER) >=1 then  
   cast(count(distinct CASE WHEN HINDGEN=1 THEN HCODPER ELSE null END)as float)/count(distinct HCODPER) else 0 end [10072],  
   count(distinct CASE WHEN HINDRUR=1 THEN HCODPER ELSE null END) [10056],  ----------------
   CASE WHEN count(distinct HCODPER) >=1 then  
   cast(count(distinct CASE WHEN HINDRUR=1 THEN HCODPER ELSE null END)as float)/count(distinct HCODPER) else 0 end [10073],  
   count(distinct CASE WHEN HINDMIGR=1 THEN HCODPER ELSE null END) [10057],  -----------------
   CASE WHEN count(distinct HCODPER) >=1 then  
   cast(count(distinct CASE WHEN HINDMIGR=1 THEN HCODPER ELSE null END)as float)/count(distinct HCODPER) else 0 end [10074],  
   count(distinct HCODPER) [166]  
   from #fechas A left join storage.com_act.wacli007 B  
   on A.F = b.hfecpro and hcodsec = @hcodbt  group by F  
   -- drop table  #base_2   select * from  #base_2  
  
  
--unpivot para darle forma al pivoteo posterior pasamos las columnas ds como una fila    
  select id RORD, descripcion variables,  resultado   valores  into #base_3 --select * from  #base_3   drop table #base_3    
   from #base_2    
   unpivot    
   (    
   resultado    
   for descripcion in ([10054],[10055],[10056],[10057],[10071],[10072],[10073],[10074],[166]) ) as b    
   order by id asc    
  
-- declare @tip_cod int = 2, @cod_rel varchar(10) = 'TAGAM100',@cf date  = '20230918'                
-->COLOCANDO LOS RESULTADOS DE LAS METAS     
          --select eomonth(@cf) ,@tip_cod, @cod_rel
select  RORD,variables,valores                
    into    #RESULTPRE     -- select * from #RESULTPRE where rord=7    drop table #RESULTPRE          
    from    #base_3               
    UNION                
    select 7 FORD, B.HCODVAR, B.HVALVAR                
    FROM    #base_3 A                
        LEFT join [storage].[com].[VDMCOM01] B     --SELECT* FROM [storage].[com].[VDMCOM01] where hcodrel = 'TAGAM100'  and HTIPCOD = 2      
        on A.variables= B.HCODVAR                
     and B.HTIPMETA = 1                
            and B.HFECPRO = eomonth(@cf)                
            and B.HTIPCOD = @tip_cod                
            and B.HCODREL = @hcodbt
  
  

 select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR                
    into     #AAA            
    from #RESULTPRE -- select*from    #AAA       drop table   #AAA        
    UNION ALL                
  select  case when concat(A.RORD,'-',B.RORD) = '4-2' then 9                
        when concat(A.RORD,'-',B.RORD) = '4-1' then 11                
        when concat(A.RORD,'-',B.RORD) = '4-7' then 13 end RORD                
        ,A.variables,     
  util.FFMTVAR(A.variables,A.valores-B.valores,iif(A.variables in(10071,10072,10073,10074,10075,10089),1,null)) SVALOR      --in(165,166,8680,8670/*,10055,10056*/),1,null)) SVALOR               
  from #RESULTPRE A -- select*from #RESULTPRE                
        join #RESULTPRE B                
        on A.variables=B.variables                
  where concat(A.RORD,'-',B.RORD) in('4-2','4-1','4-7')             
        UNION ALL                
   select  case            
            when concat(A.RORD,'-',B.RORD) ='4-7' then 12 end RORD                
            ,A.variables, cast(util.FSEMVAR(A.variables,b.valores,A.valores-B.valores) as varchar) SVALOR  --  ,A.valores,B.valores meta,A.valores-B.valores dif  
   from #RESULTPRE A                
   join #RESULTPRE B                
   on A.variables=B.variables                
   where concat(A.RORD,'-',B.RORD)  in('4-7')    

  
--pivotenado los resultados              
select *                
 into #RES  --  select*from #RES        drop table #RES                   
 from #AAA pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[7],[8],[9],[10],[11],[12],[13])) PVT                   
    
    

       

  --'TSPAG001'  
  create table #CMG      --drop table   #CMG          
(   RDESVAR varchar(250),  -- select * from #cmg              
    RCODVAR int                
)                
insert into #CMG             
values  
 ('Clientes Nuevos del Mes', 166),      
 ('  Nuevos Bancarizados por FC (1/.)', 10054),    
 ('  Nuevos Mujeres', 10055),         
 ('  Nuevos Rurales',10056),      
 ('  Nuevos Migrantes', 10057)     
  
  
 select     
 CASE      
  WHEN A.RCODVAR in (166)     
  THEN 1 ELSE 0 END AS style,    
 A.RDESVAR as DESVAL,   
 [1] as col_1, [2] as col_2, [3] as col_3, [4] as col_4, [7] as col_7,  
 [8] as col_8, [9] as col_9, [10] as col_10, [11] as col_11, [12] as col_12, [13] as col_13    
 into #resultado  
 from #CMG A            
    left join   #RES  B             
    on A.RCODVAR=B.variables     
  
 select *, cast(col_4 as float) - cast(col_3 as float) as col_14 from #resultado  
  
  drop table #fechas,#base_2,#base_3,#RESULTPRE,#AAA,#RES,#CMG,#resultado  

end
