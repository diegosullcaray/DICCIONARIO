-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.687000
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --exec [com].[GLISAUTRO05] 7,'231',''
 CREATE PROCEDURE [com].[GLISAUTRO05]
 @tip_cod int,    
 @cod_rel varchar(20),
 @cargo varchar(250)
 AS
 BEGIN
 SET NOCOUNT ON;     
 declare @fec varchar(250),@fecha date=eomonth(getdate(),-1)   
 declare @fecMax date =(select max(hfecpro) from [storage].[gpr].[HPPC001] )

 
select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)      
    
declare @defs as rep.TTHCOLDEF;      
SET LANGUAGE spanish;                    
 insert into @defs                      
 (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values      
 (1,1,2,1,'hdesper','Apellidos y Nombres','string',1),
 (2,2,2,1,'HDESCAR','Cargo','string',1)
     
 insert into @defs                           
 (TORDER,TLEV,TROWS,TKEY,TDESC,THIDDEN,TCOLS,TSTBACKGROUND)  values                          
 (6,1,1,'MRREGION','% MR APROBADOR',null,3,'#15BFA8'),    
 (7,1,1,'C3MREGION','C3M (N°) APROBADOR',null,3,'#B05A7A'),    
 (8,1,1,'c12MRREGION','C12M (N°) APROBADOR',null,3,'#EC0E0E')    
    
 insert into @defs                      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTBACKGROUND)  values                      
 (9,6,2,'MRAP_3',format(cast(dateadd(month,-2,@fec)as date),'MMM'),'percent','.2-2','#15BFA8'),    
 (10,7,2,'MRAP_2',format(cast(dateadd(month,-1,@fec)as date),'MMM'),'percent','.2-2','#15BFA8'),     
 (11,8,2,'MRAP_1',format(cast(@fec as date),'MMM'),'percent','.2-2','#15BFA8')  ,
    
 (13,10,2,'MCOS_3',format(cast(dateadd(month,-5,@fec)as date),'MMM'),'percent','.2-2','#B05A7A'),      
 (14,11,2,'MCOS_2',format(cast(dateadd(month,-4,@fec)as date),'MMM'),'percent','.2-2','#B05A7A'),     
 (15,12,2,'MCOS_1',format(cast(dateadd(month,-3,@fec)as date),'MMM'),'percent','.2-2','#B05A7A'),      
 --(16,13,2,'avg3c','AVG C3M APROB','percent','.2-2','#B05A7A'),      
    
 (17,14,2,'MCOS3_12',format(cast(dateadd(month,-14,@fec)as date),'MMM'),'percent','.2-2','#EC0E0E'),     
 (18,15,2,'MCOS2_12',format(cast(dateadd(month,-13,@fec)as date),'MMM'),'percent','.2-2','#EC0E0E'),     
 (19,16,2,'MCOS1_12',format(cast(dateadd(month,-12,@fec)as date),'MMM'),'percent','.2-2','#EC0E0E')--,     
 --(20,17,2,'avg12c','AVG C12M APROB','percent','.2-2','#EC0E0E') --

 insert into @defs                      
 (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP)  values      
 (20,17,2,1,'auto_sug','Autonomia sugerida','string')

 SET LANGUAGE english;                      
 select rep.FFTHCOLDEF(@defs) result;    
DECLARE @fec_act DATE
set @fec_act=(select eomonth(getdate(),-1))  

create table #CarteraPivot --drop table #CarteraPivot
(
ID int identity(1,1) primary key not null,
HCODSEC varchar(50)null,
--HCODUSAUT  varchar(50)null,
--HCODOPE INT NULL,
H3_HSALCAPMN numeric(17,2)  NULL,
H2_HSALCAPMN numeric(17,2) NULL,
H1_HSALCAMPN numeric(17,2) NULL,
HCODSEC_HSALVENMN varchar(50)null,
H3_HSALVENMN numeric(17,2)  NULL,
H2_HSALVENMN numeric(17,2) NULL,
H1_HSALVENMN numeric(17,2) NULL
)


select HFECPRO,HCODSEC, HCODUSAUT,
	   SUM(HSALCAPMN) HSALCAPMN,SUM(HSALVENMN) HSALVENMN	 
	   INTO #ResulCap  
FROM storage.com_act.VCAUT001
GROUP BY HFECPRO,HCODSEC, HCODUSAUT


DECLARE @cols AS NVARCHAR(MAX),@colsx AS NVARCHAR(MAX),
       @query  AS NVARCHAR(MAX);

select @cols = STUFF((SELECT distinct ',' + QUOTENAME(RFEC) 
               FROM mod_rep.[piv].[FEXTFEC01](eomonth(getdate(),-1),'{"set":"auto"}')
               FOR XML PATH(''), TYPE
               ).value('.', 'NVARCHAR(MAX)') 
           ,1,1,'')


select @colsx = STUFF((SELECT distinct ',' + QUOTENAME(cast(RFEC as varchar(250)))+'AS '+QUOTENAME(cast(RFEC as varchar(250))+'_HSALVENMN') 
               FROM mod_rep.[piv].[FEXTFEC01](eomonth(getdate(),-1),'{"set":"auto"}')
               FOR XML PATH(''), TYPE
               ).value('.', 'NVARCHAR(MAX)') 
           ,1,1,'')



set @query = ' with a as (
			  SELECT HCODSEC,' + @cols + ' from 
               (
                   select HFECPRO,HSALCAPMN,CASE WHEN '''+@cargo+'''=''Asesor'' then HCODSEC else HCODUSAUT end  HCODSEC
                   from /*storage.[com_act].VCAUT001*/ #ResulCap   WITH (NOLOCK )
				   WHERE CASE WHEN '''+@cargo+'''=''Asesor'' then HCODSEC else HCODUSAUT end is not null
 ) x
               pivot 
               (
                    sum(HSALCAPMN)
                   for HFECPRO in (' + @cols + ')
               ) p 
			   ),
			   b as (
			    SELECT  HCODSEC as HCODSEC_,' + @colsx + '  from 
               (
                   select HFECPRO,HSALVENMN,CASE WHEN '''+@cargo+'''=''Asesor'' then HCODSEC else HCODUSAUT end  HCODSEC
                   from /*storage.[com_act].VCAUT001*/ #ResulCap WITH (NOLOCK )
				   WHERE CASE WHEN '''+@cargo+'''=''Asesor'' then HCODSEC else HCODUSAUT end is not null
              ) y
               pivot 
               (
                    sum(HSALVENMN)
                   for HFECPRO in (' + @cols + ')
               ) p 
			   ),
			   c as (
			    select *
				from A
				inner join b 
				on a.HCODSEC=b.HCODSEC_
			   )
			   insert into #CarteraPivot
			   select *   from c
			   '			   

exec(@query)

--select*from #CarteraPivot where   HCODUSAUT ='TFFEV001'

create table #CastigoPivot --drop table #CastigoPivot
(
ID int identity(1,1) primary key not null,
HCODSEC varchar(50)null,
HCODUSAUT  varchar(50)null,
HCODOPE INT NULL,
H3_HSALCASMN numeric(17,2)  NULL,
H2_HSALCASMN numeric(17,2) NULL,
H1_HSALCASMN numeric(17,2) NULL
)

CREATE NONCLUSTERED INDEX [ixt_HCODSEC] ON #CastigoPivot
 (    
  HCODSEC ASC     
 )   
 
CREATE NONCLUSTERED INDEX [ixt_HCODOPE] ON #CastigoPivot
 (    
  HCODOPE ASC     
 ) 
 
CREATE NONCLUSTERED INDEX [ixt_HCODUSAUT] ON #CastigoPivot
 (    
  HCODUSAUT ASC     
 ) 
 
DECLARE @cols1 AS NVARCHAR(MAX),@colsx1 AS NVARCHAR(MAX),
       @query1  AS NVARCHAR(MAX);

select @cols1 = STUFF((SELECT distinct ',' + QUOTENAME(RFEC) 
               FROM mod_rep.[piv].[FEXTFEC01](eomonth(getdate(),-1),'{"set":"auto"}')
               FOR XML PATH(''), TYPE
               ).value('.', 'NVARCHAR(MAX)') 
           ,1,1,'')

set @query1 = ' with a as (
			  SELECT HCODSEC, HCODUSAUT, HCODOPE,' + @cols1 + ' from 
               (
                   select RFECJ,HSALCASMN,HCODSEC, HCODUSAUT, HCODOPE
                   from storage.[com_act].VCAUT003   WITH (NOLOCK ) --select  * from storage.[com_act].VCAUT003  where HCODSEC is not null order by HCODSEC asc
				    WHERE CASE WHEN '''+@cargo+'''=''Asesor'' then HCODSEC else HCODUSAUT end is not null
 ) x
               pivot 
               (
                    sum(HSALCASMN)
                   for RFECJ in (' + @cols1 + ')
               ) p 
			   )
			   insert into #CastigoPivot
			   select *   from a
			   '			   

exec(@query1)

;with a as 
(
SELECT HCODSEC as HCODUSAUT,
	   sum(H3_HSALCAPMN)H3_HSALCAPMN, sum(H2_HSALCAPMN) H2_HSALCAPMN,sum(H1_HSALCAMPN) H1_HSALCAMPN,
	   sum(H3_HSALVENMN) H3_HSALVENMN, sum(H2_HSALVENMN) H2_HSALVENMN,sum(H1_HSALVENMN) H1_HSALVENMN
FROM #CarteraPivot a
group by HCODSEC

),
b as (
 select distinct case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end HCODUSAUT,
 sum(H3_HSALCASMN) H3_HSALCASMN, sum(H2_HSALCASMN) H2_HSALCASMN, sum(H1_HSALCASMN) H1_HSALCASMN
 from #CastigoPivot a --select*from #CastigoPivot
 group by case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end
)
select  a.HCODUSAUT,b.HDESPER,b.HDESCAR,
	     case when ((ISNULL(a.H3_HSALCAPMN,0)) + (ISNULL(D.H3_HSALCASMN,0)))=0 then 0 else ((ISNULL(A.H3_HSALVENMN,0)) + (ISNULL(D.H3_HSALCASMN,0))) / ((ISNULL(a.H3_HSALCAPMN,0)) + (ISNULL(d.H3_HSALCASMN,0))) end r3, 
	   case when ((ISNULL(A.H2_HSALCAPMN,0)) + (ISNULL(D.H2_HSALCASMN,0)))=0 then 0 else ((ISNULL(A.H2_HSALVENMN,0)) + (ISNULL(D.H2_HSALCASMN,0))) / ((ISNULL(A.H2_HSALCAPMN,0)) + (ISNULL(D.H2_HSALCASMN,0))) end r2,
	   case when ((ISNULL(A.H1_HSALCAMPN,0)) + (ISNULL(D.H1_HSALCASMN,0)))=0 then 0 else ((ISNULL(A.H1_HSALVENMN,0)) + (ISNULL(D.H1_HSALCASMN,0))) / ((ISNULL(A.H1_HSALCAMPN,0)) + (ISNULL(D.H1_HSALCASMN,0))) end r1,
		(isnull(COS_3,0))COS_3,(isnull(COS_2,0))COS_2,(isnull(COS_1,0))COS_1, 
	   (isnull(COS_14,0))COS_14,(isnull(COS_13,0))COS_13,(isnull(COS_12,0))COS_12  
	   into #temp1 
from a a
left join (select HCODBT,HDESPER,HDESCAR from [storage].[gpr].[HPPC001] where hfecpro=@fecMax) b 
on a.HCODUSAUT=b.HCODBT 
left join b D 
on a.HCODUSAUT=d.HCODUSAUT
left join ( SELECT case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
		    cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_3 
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=3 AND HFECBAS=EOMONTH(GETDATE(),-6)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by case when @cargo='Asesor' then HCODSEC else HCODUSAUT end 
		  )G
ON a.HCODUSAUT=G.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			 cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float)  AS COS_2
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=3 AND HFECBAS=EOMONTH(GETDATE(),-5)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )H
ON a.HCODUSAUT=H.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_1
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=3 AND HFECBAS=EOMONTH(GETDATE(),-4)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT enD
		  )I
ON a.HCODUSAUT=I.HCODSEC

-------------
left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_14 
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=12 AND HFECBAS=EOMONTH(GETDATE(),-15)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )J
ON a.HCODUSAUT=J.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_13
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=12 AND HFECBAS=EOMONTH(GETDATE(),-14)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )K
ON a.HCODUSAUT=K.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_12
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=12 AND HFECBAS=EOMONTH(GETDATE(),-13)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )L
ON a.HCODUSAUT=L.HCODSEC

/*

select /* distinct A.hcodope,*/case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end HCODUSAUT,b.HDESPER,b.HDESCAR,
	   case when (sum(ISNULL(a.H3_HSALCAPMN,0)) + sum(ISNULL(D.H3_HSALCASMN,0)))=0 then 0 else (sum(ISNULL(A.H3_HSALVENMN,0)) + sum(ISNULL(D.H3_HSALCASMN,0))) / (sum(ISNULL(a.H3_HSALCAPMN,0)) + sum(ISNULL(d.H3_HSALCASMN,0))) end r3, 
	   case when (sum(ISNULL(A.H2_HSALCAPMN,0)) + sum(ISNULL(D.H2_HSALCASMN,0)))=0 then 0 else (sum(ISNULL(A.H2_HSALVENMN,0)) + sum(ISNULL(D.H2_HSALCASMN,0))) / (sum(ISNULL(A.H2_HSALCAPMN,0)) + sum(ISNULL(D.H2_HSALCASMN,0))) end r2,
	   case when (sum(ISNULL(A.H1_HSALCAMPN,0)) + sum(ISNULL(D.H1_HSALCASMN,0)))=0 then 0 else (sum(ISNULL(A.H1_HSALVENMN,0)) + sum(ISNULL(D.H1_HSALCASMN,0))) / (sum(ISNULL(A.H1_HSALCAMPN,0)) + sum(ISNULL(D.H1_HSALCASMN,0))) end r1,
	   
	   (isnull(COS_3,0))COS_3,(isnull(COS_2,0))COS_2,(isnull(COS_1,0))COS_1, 
	   (isnull(COS_14,0))COS_14,(isnull(COS_13,0))COS_13,(isnull(COS_12,0))COS_12  
	   into #temp1  --drop table #temp1 
from #CarteraPivot a  --select*from #CarteraPivot H1_HSALCAPMN
left join (select HCODBT,HDESPER,HDESCAR from [storage].[gpr].[HPPC001] where hfecpro=@fecMax) b 
on case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end=b.HCODBT 
left join #CastigoPivot D
on a.HCODOPE=D.HCODOPE

left join ( SELECT case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
		    cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_3 
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=3 AND HFECBAS=EOMONTH(GETDATE(),-6)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by case when @cargo='Asesor' then HCODSEC else HCODUSAUT end 
		  )G
ON case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end=G.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			 cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float)  AS COS_2
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=3 AND HFECBAS=EOMONTH(GETDATE(),-5)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )H
ON case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end=H.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_1
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=3 AND HFECBAS=EOMONTH(GETDATE(),-4)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT enD
		  )I
ON case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end=I.HCODSEC

-------------
left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_14 
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=12 AND HFECBAS=EOMONTH(GETDATE(),-15)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )J
ON case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end=J.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_13
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=12 AND HFECBAS=EOMONTH(GETDATE(),-14)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )K
ON case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end=K.HCODSEC

left join ( SELECT  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end HCODSEC, 
			cast(cast(sum(SNUMOPEMORH) as float)/cast(sum(SNUMOPEBAS) as float) as float) AS COS_12
		    FROM storage.[com_act].VCAUT002
		    WHERE HCOSECHA=12 AND HFECBAS=EOMONTH(GETDATE(),-13)
			and CASE WHEN @cargo='Asesor' then HCODSEC else HCODUSAUT end is not null
			group by  case when @cargo='Asesor' then HCODSEC else HCODUSAUT end
		  )L
ON case when @cargo='Asesor' then a.HCODSEC else a.HCODUSAUT end=L.HCODSEC
group by a.HCODSEC,a.HCODUSAUT,b.HDESPER,b.HDESCAR,COS_3,COS_2,COS_1,COS_14,COS_13,COS_12
  
*/

  select hdesper,HDESCAR,
		sum(isnull(r3,0)) as MRAP_3,sum(isnull(r2,0)) as MRAP_2,sum(isnull(r1,0)) as MRAP_1,
	    sum(isnull(cos_3,0)) as MCOS_3,sum(isnull(cos_2,0)) as MCOS_2,sum(isnull(cos_1,0)) as MCOS_1,
		sum(isnull(cos_14,0)) as MCOS3_12,sum(isnull(cos_13,0)) as MCOS2_12,sum(isnull(cos_12,0)) as MCOS1_12,
	    CASE WHEN HDESCAR IN('ASESOR COMERCIAL JUNIOR 2','ASESOR COMERCIAL JUNIOR 2 PALABRA DE MUJER','ASESOR COMERCIAL BANCA GRUPAL JUNIOR 2','ASESOR COMERCIAL BANCA INDIVIDUAL JUNIOR 2') AND sum(isnull(r1,0))<=0.023 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))=0 AND ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))=0 Then 'Hasta S/.1M'
		     when HDESCAR IN('ASESOR COMERCIAL SENIOR') AND sum(isnull(r1,0))<=0.048 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))=0 AND ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))<=0.027 THEN 'Hasta S/.2M'
			 WHEN HDESCAR like '%funcionario%' AND sum(isnull(r1,0))<=0.048 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))=0 AND ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))<=0.027 THEN 'Hasta S/.3M'
			 WHEN HDESCAR like '%MASTER%' AND sum(isnull(r1,0))<=0.048 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))=0 AND ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))<=0.027 THEN 'Hasta S/.3M'
			 WHEN HDESCAR IN('ASESOR COMERCIAL MASTER','ASESOR COMERCIAL FUNCIONARIO') AND sum(isnull(r1,0))<=0.048 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))=0 AND ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))<=0.027 THEN 'Hasta S/.3M'
			 
			 WHEN HDESCAR  LIKE '%ADMINISTRADOR%' AND sum(isnull(r1,0))>0.07 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))>0.033 AND ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Cambio autorizante'
			 when HDESCAR LIKE '%ADMINISTRADOR%' AND sum(isnull(r1,0))>0.07 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Plan de acción'
			 when HDESCAR LIKE '%ADMINISTRADOR%' and sum(isnull(cos_12,0))>0.012 then 'Monitoreo'
			 when HDESCAR LIKE '%ADMINISTRADOR%' then 'Autorizante'
			 when HDESCAR = 'GERENTE REGIONAL' AND  sum(isnull(r1,0))>0.07 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))>0.033 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Cambio utorizante'
			 when HDESCAR = 'GERENTE REGIONAL' and sum(isnull(r1,0))>0.07 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Plan de acción'
			 when HDESCAR = 'GERENTE REGIONAL' and ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.012 then 'Monitoreo'
			 when HDESCAR = 'GERENTE REGIONAL' then 'Autorizante'
			 when hdescar = 'GERENTE TERRITORIAL'  AND  sum(isnull(r1,0))>0.07 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))>0.033 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Cambio utorizante'
			 when HDESCAR = 'GERENTE TERRITORIAL' and sum(isnull(r1,0))>0.07 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Plan de acción'
			 when HDESCAR = 'GERENTE TERRITORIAL' and ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.012 then 'Monitoreo'
			 when HDESCAR = 'GERENTE TERRITORIAL' then 'Autorizante'

			 when hdescar = 'ANALISTA DE ADMISION DE RIESGO DE CREDITO'  AND  sum(isnull(r1,0))>0.07 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))>0.033 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Cambio utorizante'
			 when HDESCAR = 'ANALISTA DE ADMISION DE RIESGO DE CREDITO' and sum(isnull(r1,0))>0.07 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Plan de acción'
			 when HDESCAR = 'ANALISTA DE ADMISION DE RIESGO DE CREDITO' and ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.012 then 'Monitoreo'
			 when HDESCAR = 'ANALISTA DE ADMISION DE RIESGO DE CREDITO' then 'Autorizante'

			 when hdescar = 'JEFE TERRITORIAL DE ADMISION DE RIESGO DE CREDITO'  AND  sum(isnull(r1,0))>0.07 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))>0.033 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Cambio utorizante'
			 when HDESCAR = 'JEFE TERRITORIAL DE ADMISION DE RIESGO DE CREDITO' and sum(isnull(r1,0))>0.07 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Plan de acción'
			 when HDESCAR = 'JEFE TERRITORIAL DE ADMISION DE RIESGO DE CREDITO' and ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.012 then 'Monitoreo'
			 when HDESCAR = 'JEFE TERRITORIAL DE ADMISION DE RIESGO DE CREDITO' then 'Autorizante'

			 when hdescar = 'GERENTE DE ADMISION'  AND  sum(isnull(r1,0))>0.07 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))>0.033 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Cambio utorizante'
			 when HDESCAR = 'GERENTE DE ADMISION' and sum(isnull(r1,0))>0.07 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Plan de acción'
			 when HDESCAR = 'GERENTE DE ADMISION' and ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.012 then 'Monitoreo'
			 when HDESCAR = 'GERENTE DE ADMISION' then 'Autorizante'

			  when hdescar   like '%gerente general%'   AND  sum(isnull(r1,0))>0.07 AND ((sum(isnull(cos_3,0))*0.15)+  (sum(isnull(cos_2,0))*0.35) + (sum(isnull(cos_1,0)) * 0.5))>0.033 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Cambio utorizante'
			 when HDESCAR    like '%gerente general%' and sum(isnull(r1,0))>0.07 AND  ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.06 THEN 'Plan de acción'
			 when HDESCAR    like '%gerente general%' and ((sum(isnull(cos_14,0))*0.15) + (sum(isnull(cos_13,0))*0.35) + (sum(isnull(cos_12,0))*0.5))>0.012 then 'Monitoreo'
			 when HDESCAR    like '%gerente general%' then 'Autorizante' 
			 end 'auto_sug'

			  
			  into #Result
  from #temp1 WITH (NOLOCK)
   where HDESCAR like '%'+@cargo+'%'
  group by hdesper,HDESCAR

  select hdesper,HDESCAR,MRAP_3,MRAP_2,MRAP_1,MCOS_3,MCOS_2,MCOS_1,MCOS3_12,MCOS2_12,MCOS1_12,isnull(auto_sug,'Sin Autonomia')  auto_sug
  from #Result

  end
