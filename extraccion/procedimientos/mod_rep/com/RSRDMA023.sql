-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-05 23:19:49.630000
 

 --insert into mod_rep.[rep].[RREGREP01] values('R_APADRINA_01','Apadrinamiento','{"name":"mod_rep.[com].[RSRDMA023]","params":[{"order":1,"name":"tip_cod"},{"order":2,"name":"cod_rel"},{"order":3,"name":"fecha"}   ]}')
 --select * from mod_rep.[rep].[RREGREP01] where RCODREP = 'R_APADRINA_01' 

 --sp_helptext '[com].[RSRDMA023]'
 --use mod_rep
 --go

-- EXEC [com].[RSRDMA023] '231',7,'20220804'
CREATE procedure [com].[RSRDMA023]      
   --sp original storage.[com_act].[RSRDMA023]  
    @tipcod int, 
	@codrel varchar(10),     
    @fec date      
-- @CONFIG varchar(100) = 'RDA'      
as      
begin
SET NOCOUNT ON;

 declare @defs as rep.TTHCOLDEF   
 
  if  (@tipcod in(18,19)) 
  begin
	  insert into @defs      
	 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values  
	 (1,1,1,'HDSUCSEC','Unidad Negocio','string',null), 
	 (2,2,1,'RNOMSUB','Asesor','string',null),     
	 (3,3,1,'GESTION','Gestión','string',null),      
	 (4,4,1,'PAGO','Pago','string',null),      
	 (5,5,1,'HDESCLI','Cliente','string',null),      
	 (6,6,1,'HFECDES','F. Desembolso','string',null), 
	 (7,7,1,'HTOTCUO','Tot. Cuota','number','.0-0'), 
	 (8,8,1,'HMONDES','Monto Desem.','number','.2-2'),
	 (9,9,1,'HCODOPE','Operación','number','.2-2'),
	 (10,10,1,'HSALCAPMN','Saldo Capital','number','.2-2'),
	 (11,11,1,'HDIAATR_EFE','Dias Atraso','string',null),
	 (12,12,1,'HINDCAR','Ind. Cartera','string',null)
  end
  else
  begin
   
  
     
 declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int)      
 insert into @head values      
 (0,null,' ',null),
 (1,null,'Operaciones',11),
 (2,null,'Saldo',15)

 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values      
 (1,1,1,'HNOMREG','Descripción',1,3,1,'string',null),      
 (2,null,1,'Operaciones','Operaciones',8,null,null,null,null),      
 (3,null,1,'Saldos','Saldos',8,null,null,null,null)

 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values  
 --(1,1,2,'HNOMREG','Descripción',null,2,1,'string',null),       
 (2,null,2,'2','No Gestionado',3,null,null,null,null),      
 (3,null,2,'3','Si Gestionado',3,null,null,null,null), 
 (4,null,2,'4','Total General',2,null,null,null,null),
 (5,null,2,'5','No Gestionado',3,null,null,null,null),      
 (6,null,2,'6','Si Gestionado',3,null,null,null,null), 
 (7,null,2,'7','Total General',2,null,null,null,null)

 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values  
 (1,2,3,'NO_NO_Opers','No Pago','number','.0-0'),      
 (2,3,3,'NO_SI_Opers','Si Pago','number','.0-0'),
 (3,4,3,'NO_T_Opers','Total','number','.0-0'),  
 (4,5,3,'SI_NO_Opers','No Pago','number','.0-0'),      
 (5,6,3,'SI_SI_Opers','Si Pago','number','.0-0'),
 (6,7,3,'SI_T_Opers','Total','number','.0-0'), 
 (7,8,3,'T_T_Opers','Total','number','.0-0'),
 (8,9,3,'T_SI_%Opers','Total Efectividad','percent','.2-2'),
 
 (9,11,3,'NO_NO_Saldo','No Pago','number','.2-2'),   
 (10,12,3,'NO_SI_Saldo','Si Pago','number','.2-2'),
 (11,13,3,'NO_T_Saldo','Total','number','.2-2'),
 (12,14,3,'SI_NO_Saldo','No Pago','number','.2-2'),
 (13,15,3,'SI_SI_Saldo','Si Pago','number','.2-2'),
 (14,16,3,'SI_T_Saldo','Total','number','.2-2'),
 (15,17,3,'T_T_Saldo','Total','number','.2-2'),
 (16,18,3,'T_SI_%Saldo','Total Efectividad','percent','.2-2')



 end 



  select rep.FFTHCOLDEF(@defs) result;  


 

 /*    
 use storage;    
 go    
 declare @codrel varchar(10)='1',@tipcod int=14, @fec date ='20210310'
  drop table #tmpCCD  
   drop table #tmpFechas 
   drop table #tmpDatos
 */  
 -- declare @codrel varchar(10)='178',@tipcod int=18, @fec date ='20220804'
select  @fec = MAX(RFEC) from storage.[ref].[RCALEN001] where RDIAFER = 0   and RFEC <=  @fec      
declare @tFecs as [com].[TFECMES]      
insert into @tFecs values (1,@fec)      
      
 SELECT *      
 INTO #tmpFechas  --select*from #tmpFechas  drop table #tmpFechas  
 FROM com.FCMGFECMES(@tFecs,2)
 

  -- declare @codrel varchar(10)='178',@tipcod int=18, @fec date ='20220804' 
  -- declare @codrel varchar(10)='11',@tipcod int=19, @fec date ='20220804'       
select  HCODOPE, HSALCAPMN, HDIAATR, 
					  --case when @tipcod=7 then  RDESCOR       
       --               when @tipcod=21 then RDESCOR--rdesgru      
       --               when @tipcod=20 then RDESCOR--rdesTER     
       --               when @tipcod=19 then RDESCOR--rdesCOR     
       --               when @tipcod=18 then RDESCOR end--rdessec end 

HNOMREG, HCODSEC, HNUMDOC, HTIPDOC, HCTACLI,       
	HDESCLI, HDSUCSEC, HFECDES, HTOTCUO, HMONDES, HINDCAR,   
	ROW_NUMBER() over(partition by HNOMREG order by HSALCAPMN desc) OrdenSAL, HFECPRO      
	INTO #tmpCCD  --select*from #tmpCCD     drop table #tmpCCD  
	from [storage].[com_act].[VCAM001] A   --select * from storage.[com_act].[VCAM001]     
	join #tmpFechas B on A.HFECPRO = B.FFEC and B.FORD = 2 
	left join storage.[ref].WJERCOR03  C
	on A.HCODSEC = C.RCODSEC and C.RFECPRO = @fec  
	WHERE HDIAATR between 1 and 30      
    and HINDCAR <> 'JUDICIAL'
	and HNOMREG = C.RDESCOR
	and   case when @tipcod=7 then '1'    
       when @tipcod=20 then cast(RCODTER as varchar(250))    
     when @tipcod=19 then cast(RCODCOR as varchar(250))    
     when @tipcod=21 then cast(RCODGRU as varchar(250))    
     when @tipcod=18 then cast(RCODUNI as varchar(250)) end = case when @tipcod=7 then '1' else @codrel end  

	     
/*
	  -- declare @codrel varchar(10)='231',@tipcod int=7, @fec date ='20220804'          
select  HCODOPE, HSALCAPMN, HDIAATR, HNOMREG, HCODSEC, HNUMDOC, HTIPDOC, HCTACLI,         
 HDESCLI, HDSUCSEC, HFECDES, HTOTCUO, HMONDES, HINDCAR,        
 ROW_NUMBER() over(partition by HNOMREG order by HSALCAPMN desc) OrdenSAL, HFECPRO        
 --INTO #tmpCCD  --select*from #tmpCCD     drop table #tmpCCD    
 from [storage].[com_act].[VCAM001] A   --select HNOMREG from storage.[com_act].[VCAM001]       
 join #tmpFechas B on A.HFECPRO = B.FFEC and B.FORD = 2        
 WHERE HDIAATR between 1 and 30        
    and HINDCAR <> 'JUDICIAL'        
    and HNOMREG in(    
     select distinct case when @tipcod=7 then  RDESCOR       
                      when @tipcod=21 then RDESCOR      
                      when @tipcod=20 then RDESCOR--rdesgru      
                      when @tipcod=19 then RDESCOR--rdesadm      
                      when @tipcod=18 then RDESCOR end--rdessec end      
       from storage.[ref].WJERCOR03       
       where RINDFEC='ACTUAL' and rfecpro=@fec  and       
       case when @tipcod=7 then '1'      
       when @tipcod=20 then cast(RCODTER as varchar(250))      
     when @tipcod=19 then cast(RCODCOR as varchar(250))      
     when @tipcod=21 then cast(RCODGRU as varchar(250))      
     when @tipcod=18 then cast(RCODUNI as varchar(250)) end = case when @tipcod=7 then '1' else @codrel end      
     )        
*/   
         
  
	-- declare @codrel varchar(10)='11',@tipcod int=19, @fec date ='20220804'
	select  A.*, B.HDIAATR HDIAATR_EFE,      
	GESTION = IIF(B.HDIAATR is null or B.HDIAATR <= Day(@fec),'SI',B.HREGG),      
	PAGO = IIF(B.HDIAATR is null or B.HDIAATR <= Day(@fec),'SI','NO')      
	INTO #tmpDatos  --- drop table #tmpDatos  select*from #tmpDatos    
	FROM #tmpCCD A   --select* from storage.[com_act].[HBDE001]    
	left join storage.[com_act].[HBDE001] B  --insert into storage.[com_act].[HBDE001] select * from storage.[com_act].[HBDE001] where hfecpro='20220804'    
	on  A.HCODOPE = B.HCODOPE      
	AND B.HFECPRO = @fec      
	where A.OrdenSAL <= 20      
 


 -- EN TODOS LOS CASOS PRESENTARA LA DATA VISUALIZANDO LOS CORREDORES CON EXCEPCION DE LA UNIDAD N
 declare @Script as varchar(max) 
 if  (@tipcod in(7,21,20))-- COLOCAMOS LA JERARQUIA DE FC Y TERRITORIO     
	 BEGIN      
	   --   declare @Script as varchar(max)        
	  ;with ctePreDatos as(      
		  select  isnull(HNOMREG,'TOTAL') HNOMREG, isnull(GESTION,'T') GESTION, isnull(PAGO,'T') PAGO,       
		  convert(float,COUNT(HCODOPE)) Opers, convert(float,SUM(HSALCAPMN)) Saldo      
		  from #tmpDatos      
		  group BY cube (HNOMREG, GESTION, PAGO)),      
		  cteUnpivot as(      
		  select  HNOMREG,  GESTION, PAGO, DESVAL, VAL      
		  FROM ctePreDatos A      
		  unpivot(VAL for DESVAL in (Opers,Saldo)) B),         
	  cteDatos as(      
		  select  HNOMREG,  GESTION, PAGO, DESVAL, VAL      
		  FROM cteUnpivot      
		  union all      
		  select  A.HNOMREG, A.GESTION, A.PAGO, '%' + A.DESVAL, A.VAL / B.VAL      
		  FROM cteUnpivot A      
			join cteUnpivot B      
			 on  A.HNOMREG = B.HNOMREG      
			 and A.DESVAL = B.DESVAL      
			 and A.GESTION = 'T'      
			 and A.PAGO = 'SI'      
			 and B.GESTION = 'T'      
			 and B.PAGO = 'T'),      
	  cteVal as(        
		  select  HNOMREG,  GESTION + '_' + PAGO + '_' + DESVAL DESVAL,       
			 /*IIF(DESVAL like '%[%]%', format(VAL,'P'), format(VAL,'N0'))*/   VAL      
		  FROM cteDatos)  
   
        
	  select  0 style, *      
	  into #tmpDatosF   --select*from #tmpDatosF    drop table #tmpDatosF
	  FROM cteVal A      
	   pivot(MAX(VAL) for DESVAL in([NO_NO_Opers], [NO_SI_Opers], [NO_T_Opers],      
			  [SI_NO_Opers], [SI_SI_Opers], [SI_T_Opers], [T_T_Opers], [T_SI_%Opers],      
			  [NO_NO_Saldo], [NO_SI_Saldo], [NO_T_Saldo],       
			  [SI_NO_Saldo], [SI_SI_Saldo], [SI_T_Saldo], [T_T_Saldo], [T_SI_%Saldo])) B      
        
	  update #tmpDatosF set style=1 where HNOMREG='TOTAL'    
	  --update #tmpDatosF set [T_SI_%Opers]='05.00 %' where  [T_SI_%Opers]='5.00 %'    
	  set @Script =      
	  'select  *      
	  from #tmpDatosF  order by style,[T_SI_%Opers] asc    
	  '      
	  exec(@Script)      
         
	 END  
      
 ELSE     
  
	 BEGIN 
      
		  
		-- declare @codrel varchar(10)='40',@tipcod int=18, @fec date ='20220804' 
		-- declare @codrel varchar(10)='11',@tipcod int=19, @fec date ='20220804',@Script as varchar(max)  
		select  0 style , A.HNOMREG, A.HCODSEC,     
		B.RDESUNI as HDSUCSEC/*A.HDSUCSEC*/, /*B.RNOMSUB,*/ b.RDESSEC as RNOMSUB, GESTION, PAGO,          
		A.HDESCLI,      
		convert(varchar(10),A.HFECDES,111) HFECDES, format(A.HTOTCUO,'N0') HTOTCUO, /*format(A.HMONDES,'N0') */ A.HMONDES HMONDES,      
		convert(varchar(250),A.HCODOPE) HCODOPE, /*format(C.HSALCAPMN,'N0') */ C.HSALCAPMN HSALCAPMN, convert(varchar(250),A.HDIAATR_EFE) HDIAATR_EFE,      
		A.HINDCAR      
	   INTO #tmpDatosF2   --select*from #tmpDatosF2    drop table #tmpDatosF2  
	   from #tmpDatos A  --select HCODSEC,GESTION,PAGO,*from #tmpDatos    
	   inner join ( select  distinct RCODSEC,RDESSEC ,RDESUNI   
		  from storage.[ref].WJERCOR03   --select* from  storage.[ref].WJERCOR03   
			 where RINDFEC='ACTUAL' and rfecpro=@fec    
		  and case when @tipcod=7 then '1'    
			when @tipcod=20 then cast(RCODTER as varchar(250))    
			when @tipcod=19 then cast(RCODCOR as varchar(250))    
			when @tipcod=21 then cast(RCODGRU as varchar(250))    
			when @tipcod=18 then cast(RCODUNI as varchar(250)) end=    
		   case when @tipcod=7 then '1' else @codrel end    
       
	   )B 
	   on  A.HCODSEC = b.RCODSEC 
	   left join [storage].[com_act].[VCAH001] C      
	   on  A.HCODOPE = C.HCODOPE      
	   WHERE C.HFECPRO in (select FFEC from #tmpFechas where FORD = 1)   



		-- declare @Script as varchar(max)  
	  set @Script =      
	  '    
	  select  *      
	  from #tmpDatosF2 A      
	  order BY      
		4,6,13 desc       
		'      
        
	  exec(@Script)      
        
	 END      
      
END
