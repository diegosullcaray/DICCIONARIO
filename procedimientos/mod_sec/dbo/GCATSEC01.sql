-- Extraído de mish/mod_sec el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-07 16:17:07.797000
--exec dbo.GCATSEC01 'TNATT100'  
 
CREATE PROCEDURE [dbo].[GCATSEC01]  
@cod_bt varchar(20)  
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 declare @fec date  
  
 select @fec=max(HFECPRO) from storage.gpr.HBASCAT001  
  
  
 ;with a as (  
 select *  
 from storage.ref.FJERCOR02(format(getdate(),'yyyyMMdd'))  
 )  
 select HNUMDOC num_doc,  
 HDESSEC nom,  
 HCARSEC car,  
 HCATSEC cat,  
 HGENSEC gen,  
 B.RDESUNI uni,  
 B.RDESCOR corr,  
 B.RDESTER terr,
 B.RCODGRU codgru,
 HREQ001 r3,  
 HREQ002 r1,  
 HREQ003 r2,  
 HREQ004 r4,  
 iif(lower(HREQ001)='no apto',0,1) ri3,  
 iif(lower(HREQ002)='no apto',0,1) ri1,  
 iif(lower(HREQ003)='no apto',0,1) ri2,  
 iif(lower(HREQ004)='no apto',0,1) ri4,  
 HCOM001 c1,  
 HCOM002 c2,  
 HCOM003 c3,  
 HCOM004 c4,  
 HCOM005 c5,  
 HCOM006 c6,  
 iif(lower(HCOM001) in ('si','sí'),1,0) ci1,  
 iif(lower(HCOM002) in ('si','sí'),1,0) ci2,  
 iif(lower(HCOM003) in ('si','sí'),1,0) ci3,  
 iif(lower(HCOM004) in ('si','sí'),1,0) ci4,  
 iif(lower(HCOM005) in ('si','sí'),1,0) ci5,  
 iif(lower(HCOM006) in ('si','sí'),1,0) ci6,  
 HCOMFIN cf  ,
 isnull(c1_1,0)c1_1,--Saldo Vigente 
 isnull(c1_2,0)c1_2,--Cli Promedio
 isnull(c1_3,0)c1_3,--Var Saldo Vig  
 isnull(c1_4,0)c1_4,--Efec -30-0  
 isnull(c1_5,0)c1_5,--Efec 1-30  
 isnull(c1_6,0)c1_6,--Sin Bajar Stock 
 ---
 isnull(c2_1,0)c2_1, isnull(c2_2,0)c2_2, isnull(c2_3,0)c2_3, isnull(c2_4,0)c2_4, isnull(c2_5,0)c2_5, isnull(c2_6,0)c2_6,    
 isnull(c3_1,0)c3_1, isnull(c3_2,0)c3_2, isnull(c3_3,0)c3_3, isnull(c3_4,0)c3_4, isnull(c3_5,0)c3_5, isnull(c3_6,0)c3_6,    
 isnull(c4_1,0)c4_1, isnull(c4_2,0)c4_2, isnull(c4_3,0)c4_3, isnull(c4_4,0)c4_4, isnull(c4_5,0)c4_5, isnull(c4_6,0)c4_6,    
 isnull(c5_1,0)c5_1, isnull(c5_2,0)c5_2, isnull(c5_3,0)c5_3, isnull(c5_4,0)c5_4, isnull(c5_5,0)c5_5, isnull(c5_6,0)c5_6,    
 isnull(c6_1,0)c6_1, isnull(c6_2,0)c6_2, isnull(c6_3,0)c6_3, isnull(c6_4,0)c6_4, isnull(c6_5,0)c6_5, isnull(c6_6,0)c6_6

 from storage.gpr.HBASCAT001 A  
 left join a B  
 on A.HCODSEC=B.RCODSEC  
 where HCODSEC=@cod_bt and HFECPRO=@fec  
  
 ;with a as (  
 select top 6 concat(RMESNOM,'-',(RANI-2000)) nom,RFEC  
 from storage.ref.RCALEN001  
 where RFEC<='20260731' and RCIEBT=1  
 order by RFEC desc  
 )  
 select nom  
 from a order by RFEC  
   
    

END
