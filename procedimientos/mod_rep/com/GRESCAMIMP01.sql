-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.067000
CREATE procedure [com].[GRESCAMIMP01]  
    @cod_rel varchar(10),  
    @tip_cod int,  
 @tipmeta int = 1,  
 @fec date = null  
as  
begin  
 set nocount on  
  
 CREATE TABLE #tmpDATOS(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)  
  
 declare @json varchar(max) =  
 '[{"variables":"NroClientesGesReac,NroClientesIniReac,NroClientesDesReac,NroClientesIniReac,NroClientesCont,NroClientesRepro","elementos":[{"TIPCOD":' + convert(varchar(50),@tip_cod) + ',"CODREL":"' + @cod_rel +'","niveles":' + IIF(@tip_cod = 4,'3','2') 
+ '}],"fechas":[1]}]'  
  
 insert into #tmpDATOS  
 EXEC mod_rep.[rep].[RCALC] @json  
    
 declare @Variables as table(ORD int identity(1,1), NVAR int, NOMV varchar(50), CODS int)  
 insert into @Variables values  
 (20,'Clientes gestionados',1),  
 (40,'Total Créd. Reactivados',1),  
 (41,'Gestión Créd. Reactivados (%)',1),  
 (60,'Clientes desembolsados',2),  
 (80,'Total Créd. Reactivados',2),  
 (81,'Efectividad Créd. Reactivados (%)',2)  
 --(100,'Clientes contactados',2),  
 --(120,'Total clientes reprogramados',2),  
 --(121,'Contactabilidad reprogramados (%)',2)  
  
 declare @tTabla as [rep].[TCADS], @tTablaDef as [rep].[TCADS]  
 insert into @tTabla  
 select 'NIVEL|' + STRING_AGG(NOMV,'|') within group (order by ORD)  
 from @Variables  
 UNION all  
 select distinct   
   replicate('|' +  convert(varchar(10),TFEC,103), (SELECT count(*) FROM @Variables ) )  
 from #tmpDATOS  
  
 insert into @tTablaDef values ('RNOMSUB')  
 insert into @tTablaDef select NVAR from @Variables order by ORD  
   
 declare @coldefs as rep.TTHCOLDEF  
 insert into @coldefs(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC, TSTBACKGROUND,TSTDEWIDTH)  
 select TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, isnull(TFORTYP,'number') TFORTYP, TDESC, IIF(TLEV = 2,'green',IIF(TDESC LIKE '%[%]%','#049ce4',null)),IIF(TISDATA>1,'130px',null) 
 from [rep].FCABTABDEF(@tTabla,@tTablaDef)  
  
 select [rep].[FFTHCOLDEF](@coldefs)  
   
 declare @piv varchar(max), @cScript varchar(max)  
 select @piv = STRING_AGG('[' + convert(varchar(10),NVAR) + ']',',') within group (order by ORD)  
 from @Variables  
   
 set @cScript = '  
  ;with cteDatos as(   
   select style = MAX(RNIVEL) over(partition by TORD) - RNIVEL, NVAR, RNUM, TORD, RNOMSUB, VAL  
   from #tmpDATOS),  
  cteDatosF as(  
   select style, NVAR, RNUM, RNOMSUB, TORD, VAL = FORMAT(VAL,''N0'')  
   from cteDatos  
   union all  
   select A.style, A.NVAR + 21, A.RNUM, A.RNOMSUB, A.TORD, FORMAT(IIF(B.VAL <> 0, A.VAL / B.VAL, null),''P'')  
   from cteDatos A  
    left join cteDatos B  
     on A.NVAR + 20 = B.NVAR  
     and A.RNUM = B.RNUM  
     and A.TORD = B.TORD  
   where A.NVAR in(20,60,100))  
  
 select *  
 from (select style, NVAR, RNUM, RNOMSUB, VAL from cteDatosF) A  
  pivot(MAX(VAL) for NVAR in(' + @piv + ') ) B  
 order by  
   RNUM'  
  
 exec(@cScript)  
  
END
