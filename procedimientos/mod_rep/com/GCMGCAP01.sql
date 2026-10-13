-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-09-25 10:50:13.240000
--sp_helptext '[com].[GCMGCAP01]'        
      --EXEC mod_rep.[com].[GCMGCAP01] '20220823',7,'231'     
--EXEC [com].[GCMGCAP01] '[{"tip_cod":7,"cod_rel":"231","order":0}]','20210927'      
--exec [com].[GCMGCAP01] '2022-06-15',7,'231'        
CREATE PROCEDURE [com].[GCMGCAP01]            
@fec date,@tip_cod int,@cod_rel varchar(250)='231'                    
AS                        
BEGIN                        
SET NOCOUNT ON;             
            
 declare @Fecha date            
             
 declare @tipcod varchar(10),@codrel varchar(20)          
         
           
 --select @tipcod = tip_cod, @codrel = cod_rel            
 --from (select RORD, RVAL, RVAR            
 --  from mod_rep.[rep].[FJSON](@seq,default,default,default,default) A) B            
 -- pivot(MAX(RVAL) for RVAR in(cod_rel,tip_cod,[order])) B            
 --where [order] = 0            
        
        
           /* 
  select @tipcod= 7        
  select @codrel = '231'        
          */
        
        
   --declare @fec date ='20220824',@tipcod int=7,@codrel varchar(250)='231' ,@Fecha date            
 select @Fecha=max(HFECPRO) from [storage].[com_act].[HCDA001]  where hfecpro<=@fec                 
            
 set @codrel = IIF(@tipcod = 7,'231',@codrel)              
            
 -----------------------------            
 declare @tTabla as [rep].[TCADS], @tTablaDef as [rep].[TCADS]            
 --declare @TabComp as table (VAL varchar(25),Filax int, Ord int) insert into @TabComp values ('TMM_Sem',-1,8),('TAM_Sem',-1,10),('Dist_Sem',-1,12),('TFM_Sem',-1,14)            
  declare @TabComp as table (VAL varchar(25),Filax int, Ord int) insert into @TabComp values ('TMM_Sem',-1,8),('TAM_Sem',-1,10),('Dist_Sem',-1,12),('TFM_Sem',-1,14) 
              
  ;with cteCab as(            
  select VAL, Filax = IIF(FORD in('DESVAL','9','11'),-1,FILA), Ord = convert(int,IIF(FORD = 'DESVAL',-1,FORD))            
  from [storage].[com].[FCMGCAB](@Fecha,1)            
  union all select VAL, Filax, Ord from @TabComp
  union all select 'TFM' VAL, -1,14  )            
                       
 insert into @tTabla            
 select STRING_AGG(VAL,'|') within group (order by Ord)            
 from cteCab where Filax = -1            
 UNION all            
 select '|' + (STRING_AGG(VAL,'|') within group (order by Ord)) + replicate('|',7)            
 from (select IIF(Ord <= 3,1,2) Ord,  STRING_AGG(VAL,';') within group (order by Ord) VAL            
   from cteCab where Filax = 0 and Ord between 1 and 6            
   group by IIF(Ord <= 3,1,2)) A            
            
 insert into @tTablaDef values ('DESVAL')            
 ;with cteRec as(select n = 1 union all select n = n + 1 from cteRec where n < 15)            
 insert into @tTablaDef select * from cteRec order by n            
             --select * from @tTablaDef
 declare @coldefs as rep.TTHCOLDEF            
 insert into @coldefs(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC, TSTBACKGROUND, THIDDEN)            
 select TORDER, TKEY, TLEV, TISDATA, TCOLS = IIF(TKEY in('9','11','13','15'),TCOLS + 1,TCOLS), TROWS, TSTICKY, IIF(TDESC like '%_Sem','traffic-light', IIF(TKEY in('7','9','11','13','15'),'number', isnull(TFORTYP,'number'))) TFORTYP, TDESC, IIF(TLEV = 2,'green',IIF(TDESC LIKE '%[%]%','#049ce4',null)), IIF(TDESC like '%_Sem',1,null)            
 from [rep].FCABTABDEF(@tTabla,@tTablaDef)
 
 --cambiamos el orden del campo y los datos
 update @coldefs set TORDER=11, TISDATA =15  where TDESC = 'Dist_Sem' 
 update @coldefs set TORDER=12, TISDATA =16  where TDESC = 'Distancia Metas' 
 update @coldefs set TORDER=9, TKEY = 14, TCOLS=1, TROWS=2, TISDATA =13 where TDESC = 'TFM_Sem'  
 update @coldefs set TORDER=10, TKEY = 15, TCOLS=2, TROWS=2, TISDATA =14, TFORTYP='number' where TDESC = 'TFM'          
 
 
  --select * from @coldefs

 select [rep].[FFTHCOLDEF](@coldefs)            
                
 --------------------------------------------            
 --EXEC [storage].[com_pas].RSCMGP001 @codrel, @fecha, @tipcod ,1,3            
    exec mod_rep.[com].RSCMGP002   @tip_cod ,@cod_rel ,@fecha  
END
