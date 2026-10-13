-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-03-07 10:34:50.403000
  
--exec [com].[GCOSELIS001]  7,'231','20211130','CONSUMO','TODO','3',1 ,'%%'  
CREATE procedure [com].[GCOSELIS001]  
  @tip_cod int,  
  @cod_rel varchar(20),  
  @fec varchar(50),  
  @prod varchar(250),  
  @subpro varchar(250),  
  @madu varchar(20),  
  @pagen int=1,  
  @nom VARCHAR(500)  
AS                         
BEGIN  
  SET NOCOUNT ON;  
  --declare @fec varchar(10)='20211130',@madu varchar(20)='3',@pagen int=1, @tip_cod int=7, @cod_rel varchar(20)='231',@prod varchar(250)='TODO',@subpro varchar(250)='TODO',@nom VARCHAR(500) ='%%'            
  --declare @fec varchar(10)='20211130',@madu varchar(20)=3,@pagen int=1, @tip_cod int=15, @cod_rel varchar(20)='1',@prod varchar(250)='TODO',@subpro varchar(250)='TODO',@nom VARCHAR(500) ='%%'            
    
  select  @fec=convert(date,max(RFEC),112)  
  from    storage.ref.RCALEN001  
  where   RFEC<=@fec and RCIEBT=1  
  
  declare @defs as rep.TTHCOLDEF;  
    
  SET LANGUAGE spanish;  
  insert into @defs  
    (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  
  values  
    (1, 1, 2, 1, 'RDESPROD', 'PRODUCTO', 'string', 0),  
    (2, 2, 2, 1, 'HDTIPOPE', 'SUB PRODUCTO', 'string', 0),  
    (3, 3, 2, 1, 'RDESTER', 'TERRITORIO', 'string', 0),  
    (4, 4, 2, 1, 'RDESADM', 'ADMINISTRADOR', 'string', 0),--                        
    (5, 5, 2, 1, 'HDSUCCLI', 'OFICINA', 'string', 0),--                        
    (6, 6, 2, 1, 'HCTACLI', 'CTA CLIENTE', 'string', 0),--                        
    (7, 7, 2, 1, 'HTIPDOC', 'TIPO DE DOCUMENTO', 'string', 0),  
    (8, 8, 2, 1, 'HNUMDOC', 'N° DODUCMENTO', 'string', 0),  
    (9, 9, 2, 1, 'HDESCLI', 'NOMBRES CLIENTES', 'string', 0),  
    (10, 10, 2, 1, 'HCODOPE', 'OPERACION', 'string', 0),  
    (11, 11, 2, 1, 'numcuota', 'NRO CUOTA', 'string', 0),--                        
    (12, 12, 2, 1, 'HFECBAS', 'FECHA DESEMBOLSO', 'string', 0),  
    (13, 13, 2, 1, 'HMONDESMN', 'DESEMBOLSO', 'string', 0),  
    (14, 14, 2, 1, 'HRANDES', 'TRAMO DESEMBOLSO', 'string', 0)  
  
  
  insert into @defs  
    (TORDER,TLEV,TROWS,TKEY,TDESC,THIDDEN,TCOLS)  
  values  
    (15, 1, 1, 'cardtell', 'Cartera Detallada a <br>'+format(cast(@fec as date),'dd-MMM'), null, 6),  
    (16, 1, 1, 'sa2020', 'Situación a <br>'+format(cast(@fec as date),'dd-MMM'), null, 3),  
    (17, 1, 1, 'cosechaa', 'Cosechas a <br>'+format(cast(@fec as date),'dd-MMM'), null, 2),  
    (18, 1, 1, 'sfj', 'Sistema Financiero a <br> 30-Sep', null, 9)  
  
  insert into @defs  
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  
  values  
    (19, 15, 2, 'HSALCAPMN', 'SALDO CAPITAL', 'number', '.0-0'),  
    (20, 16, 2, 'HSALVENMN', 'SALDO VENCIDO', 'number', '.0-0'),  
    (21, 17, 2, 'HDIAATR', 'DIAS ATRASO', 'number', '.0-0'),  
    (22, 18, 2, 'HFECMOR', 'FECHA INGRESO MORA', 'string', ''),  
    (21, 17, 2, 'pla_meses', 'PLAZO MESES', 'number', '.0-0'),  
    (22, 18, 2, 'HDCODSEC', 'ANALISTA', 'string', ''),  
    (23, 19, 2, 'cuad', 'CUADRANTE', 'string', ''),  
    (24, 20, 2, 'NIVEL_RIESGO', 'NIVEL RIESGO', 'string', ''),  
    (25, 21, 2, 'NIVEL_SOB', 'NIVEL SOBREENDEUDAMIENTO', 'string', ''),  
    (26, 22, 2, 'HCOSECHA', 'MADURACION', 'string', ''),  
    (27, 23, 2, 'HFECMORs', 'PRIMER INGRESO MORA', 'string', ''),  
    (28, 24, 2, 'Nro_Empre', 'NRO ENTIDADES', 'number', '.0-0'),  
    (29, 25, 2, 'PNor', 'NORMAL', 'number', '.0-0'),  
    (30, 26, 2, 'PCPP', 'CON PROBLEMAS POTENCIALES', 'number', '.0-0'),  
    (31, 27, 2, 'PDef', 'DEFICIENTE', 'number', '.0-0'),  
    (32, 28, 2, 'PDud', 'DUDOSO', 'number', '.0-0'),  
    (33, 29, 2, 'PPer', 'PERDIDA', 'number', '.0-0'),  
    (34, 30, 2, 'Saldo', 'SALDO SF', 'number', '.0-0'),  
    (35, 31, 2, 'HDTIPOPEs', 'subproducto', 'string', ''),  
    (36, 32, 2, 'HRANDESs', 'Tramo_Desem', 'string', '')  
  
  SET LANGUAGE english;  
  select rep.FFTHCOLDEF(@defs) result;  
  
  DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT  
  SET @PageNumber = @pagen  
  SET @RowspPage = 10;  
  
  
  declare @result as table([row] int,  
    HCOSECHA int,  
    HFECBAS date,  
    HMONDESMN float,  
    HNUMDOC varchar(50),  
    HDESCLI varchar(100),  
    HTIPDOC int,  
    HFECPRO date,  
    HDSUCCLI varchar(100)  
  ,  
    HCODSEC varchar(10),  
    HCODMOD int,  
    HTIPOPE int,  
    HSUBTIP int,  
    HCODOPE int,  
    HDTIPOPE varchar(100),  
    HINDCAR varchar(20),  
    HSALCAPMN float,  
    HDIAATR int  
  ,  
    HSALVENMN float,  
    HFECMOR date,  
    HRANDES varchar(50),  
    RDESPROD varchar(50),  
    HCTACLI int,  
    HDCODSEC varchar(100),  
    RDESTER varchar(20),  
    RDESADM varchar(100)  
  ,  
    Ndoc_Ident varchar(20),  
    Nro_Empre int,  
    PNor float,  
    PCPP float,  
    PDef float,  
    PDud float,  
    PPer float,  
    Saldo float,  
    HDTIPOPEs varchar(100),  
    HRANDESs varchar(100)  
  ,  
    HFECMORs date,  
    NIVEL_SOB varchar(50),  
    NIVEL_RIESGO varchar(50))  
  --declare @fec varchar(10)='20211130',@madu varchar(20)=3      

  select * into #F from storage.ref.FJERCOR01(@fec)
  ;WITH  
    CTE_BASE  
    AS      
    (  
      SELECT *  
      FROM storage.[com_act].WBCH001 A  
      WHERE HFECBAS=@fec and hcosecha=@madu AND A.HINDMORH=1  
    )  
   ,  
    cte_a  
    as  
      
    (  
      select a.HCOSECHA, a.HFECBAS, case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end HMONDESMN,  
        aa.HNUMDOC, aa.HDESCLI, aa.HTIPDOC, a.HFECPRO, aa.HDSUCCLI, a.HCODSEC,  
        a.HCODMOD, a.HTIPOPE, a.HSUBTIP, a.HCODOPE, aa.HDTIPOPE,  
        aa.HINDCAR, a.HSALCAPMN, a.HDIAATR, aa.HSALVENMN, aa.HFECMOR,  
        case when  (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 3000 then '1.[0-3>'                  
     when  (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 3000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 5000 then '2.[3-5>'                  
     when  (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 5000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 20000 then '3.[5-20>'                  
     when  (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 20000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 50000 then '4.[20-50>'                  
     when  (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 50000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 70000 then '5.[50-70>'                  
     when  (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 70000 then '6.[70>' end      
   HRANDES,  T3.RCODPROD,
        T3.RDESPROD, aa.HCTACLI, aa.HDCODSEC,  
        aa.HDTIPOPE as HDTIPOPEs, a.HINDMORH,  
        case when  (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 3000 then '1.[0-3>'                  
     when   (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 3000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 5000 then '2.[3-5>'                  
     when   (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 5000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 20000 then '3.[5-20>'                  
     when   (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 20000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 50000 then '4.[20-50>'                  
     when   (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 50000 and (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) < 70000 then '5.[50-70>'                  
     when   (case when aa.HCODMON=0 then aa.HMONDES else aa.HMONDES*HTIPCMB end) >= 70000 then '6.[70>' end      
   HRANDESs, aa.HFECMOR as HFECMORs  
      from CTE_BASE A  
        left join storage.com_act.HCDA001 AA  
        on   A.HFECBAS=AA.HFECPRO and A.HCODOPE=AA.HCODOPE  
        left join storage.[com_act].RETP001 T1  
        on  T1.RCODMOD=a.HCODMOD and T1.RTIPOPE=a.HTIPOPE  
        left join storage.[com_act].RETP002 T2  
        on  T2.RCODMOD=a.HCODMOD and T2.RTIPOPE=a.HTIPOPE and T2.RSUBTIP=a.HSUBTIP  
        left join storage.[com_act].RETP003 T3  
        on  T3.RCODPROD=isnull(T2.RCODPROD,T1.RCODPROD)  
    )    
 ,   
    Datos  
    as  
    (  
      select a.HCOSECHA, a.HFECBAS, a.HMONDESMN HMONDESMN, a.HNUMDOC, a.HDESCLI, a.HTIPDOC, a.HFECPRO, a.HDSUCCLI, a.HCODSEC  
        ,a.HCODMOD, a.HTIPOPE, a.HSUBTIP, a.HCODOPE, a.HDTIPOPE,a.HINDCAR, a.HSALCAPMN, a.HDIAATR, a.HSALVENMN, a.HFECMOR, HRANDES HRANDES  
        ,RDESPROD RDESPROD, a.HCTACLI, a.HDCODSEC, b.RDESTER RDESTER, b.RDESADM RDESADM, c.Ndoc_Ident, c.[Nro_Empre]  
        ,c.[PNor] , c.[PCPP] , c.[PDef] , c.[PDud] , c.[PPer] , c.[Saldo], a.HDTIPOPE as HDTIPOPEs, HRANDES  as HRANDESs, a.HFECMOR as HFECMORs  
        ,d.NIVEL_SOB, d.NIVEL_RIESGO  
      from cte_a A  
      left join #F b  
      on          A.HFECBAS=B.RFECPRO and A.HCODSEC=b.RCODSEC  
      left join storage.com_act.[SRCC001] C on a.HNUMDOC=C.Ndoc_Ident --select*from storage.com_act.[SRCC001] where HFECPROB='20201031' and HCOSECHA in(3,6,9,12)                    
      left join storage.com_act.SRIESGO001 D on a.HCTACLI=d.cliente  
      where     
      case when @tip_cod='15' then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')                           
            when @tip_cod='14' then cast(B.RCODCOR as nvarchar(10))                           
            when @tip_cod='13' then B.RCODGRU                          
            when @tip_cod='11' then B.RCODADM else '1' end=IIF(@tip_cod=7,'1',@cod_rel)     
    and  iif(@prod='TODO','1',a.RDESPROD)= iif(@prod='TODO','1',@prod)  
    and  iif(@subpro='TODO','1',a.HDTIPOPE)=iif(@subpro='TODO','1',@subpro)  
            AND a.HDESCLI  like @nom  
    )  
  insert into @result  
  select  
    row_number() over(order by HCODOPE desc) AS [row],  
    *  
  from Datos  
  
  
  select *  
  from @result  
  ORDER BY [row] asc    
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS        
  FETCH NEXT @RowspPage ROWS ONLY;  
  
  select count(*) as Total  
  from @result  
  
END
