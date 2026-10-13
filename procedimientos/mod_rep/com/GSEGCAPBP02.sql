-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-06-24 09:35:12.160000
--exec mod_rep.[com].[GSEGCAPBP02] 7,'231','20250621'
CREATE PROCEDURE [com].[GSEGCAPBP02]                                      
@tip_cod int,@cod_rel varchar(20),@fec varchar(10) 
AS      
BEGIN     
  SET NOCOUNT ON;   
--declare @tip_cod int,@cod_rel varchar(250) ,@fec date='20250621'    

   
declare @defs as rep.TTHCOLDEF;                                      
  insert into @defs                                      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS)  values                                      
 (1,1,1,'descripcion','Descripción','string',null,1,2)       

  insert into @defs                                      
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND) values                                       
 (2,1,'m_SP','Saldo Medio Ahorro - RED',4,null),                                  
 (3,1,'m_FB','TPPP Mes DPF - RED',2,'#9d3ea6') 
 
 insert into @defs                                      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,thidden,TCOLS,TSTBACKGROUND)  values                                      
 (4,2,2,'SM4','Saldo','number','.0-0',null,null,null)   ,                                  
 (5,3,2,'VARANUAL','Variación Anual','number','.0-0',null,null,null) ,                                   
 (6,4,2,'vardiario','Variación Día','number','.0-0',null,null,null),        
 (7,5,2,'varmes','Variación Mes','number','.0-0',null,2,null) 

 insert into @defs                                      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS,TCOLS,thidden,TSTBACKGROUND)  values                                      

 (8,6,2,'TPPMES2','TPPP Mes BP (%)','percent','.2-2',null,2,null,null,'#3ab61b'),           
 (9,7,2,'VARMESTPP','Var. Mes','string',null,null,2,2,null,'#3ab61b')           

  select rep.FFTHCOLDEF(@defs) hdefs ;    

DECLARE @cols NVARCHAR(MAX) = '', @query nvarchar(max) 
create table #SMBP (HDESREL	VARCHAR(250)NULL,SM1 FLOAT NULL,SM2 FLOAT NULL,	SM3 FLOAT NULL,	SM4 FLOAT NULL )
CREATE TABLE #TPPMES(RDESBP VARCHAR(250)NULL,TPPMES1 FLOAT NULL,TPPMES2 FLOAT NULL)

SELECT @cols = STRING_AGG(  
    'MAX(CASE WHEN ord = ' + CAST(ord AS VARCHAR) + ' THEN HSALMEDMN END) AS SM' + CAST(ord AS VARCHAR),
    ',' + CHAR(10)
) 
FROM (  
    SELECT DISTINCT ord  
    FROM storage.com_pas.WJAS010  
) AS r;  

SET @query = '  
SELECT   
    HDESREL,  
    ' + @cols + '  
FROM storage.com_pas.WJAS010  
GROUP BY HDESREL  
ORDER BY HDESREL;';  
INSERT INTO #SMBP
EXEC sp_executesql @query; 

 
SELECT hdesrel,SM4,SM4 - SM1 VARANUAL,SM4-SM3 vardiario,SM4-SM2 varmes into #PRE FROM #SMBP

select * into #fec from storage.util.FVECFEC01(@fec,'cie_ant,cmg_6')  

;with cte_a as (
select b.rord,a.* from storage.[com_pas].SDPF007 a
inner join #fec b
on a.sfecpro=b.rfec
 
)
SELECT rord,sfecpro,
isnull(RDESBP,'SIN ASIGNAR') RDESBP,
sum(SINTMESSALMN)/case when sum(SSALMN)=0 then 1 else sum(SSALMN) end TPPMES
into #TPMESPRE
FROM cte_a A 
left join storage.ref.REABP01 C                                          
 on   C.RCODAGE=A.SSUCCLI                                          
 inner join (select * from storage.[com_pas].[RETP001] where RDESCPROD02='PLAZO FIJO') P     --select * from storage.[com_pas].[RETP001]                                     
 on P.RCODMOD=a.SSBMOD and P.RTIPOPE=a.SSBTOPE         
group by rord,sfecpro,RDESBP

SELECT @cols = STRING_AGG(  
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN TPPMES END) AS TPPMES' + CAST(rord AS VARCHAR),
    ',' + CHAR(10)
) 
FROM (  
    SELECT DISTINCT rord  
    FROM #TPMESPRE
) AS r;  


SET @query = '  
SELECT   
    RDESBP,  
    ' + @cols + '  
FROM #TPMESPRE
GROUP BY RDESBP  
ORDER BY RDESBP;';  

INSERT INTO #TPPMES
EXEC sp_executesql @query; 


SELECT A.*,B.TPPMES2,B.TPPMES1, B.TPPMES2 - B.TPPMES1 VARMESTPP  FROM #PRE A 
LEFT JOIN #TPPMES B
ON A.HDESREL=B.RDESBP
 
end
