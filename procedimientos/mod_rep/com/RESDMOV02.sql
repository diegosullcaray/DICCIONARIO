-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-05-20 12:41:40.483000

--SP para movilidad de recuperadores 

--exec [com].[RESDMOV02]  2,'77349070','now'
CREATE procedure [com].[RESDMOV02]  
@tip_cod int,@cod_rel varchar(20),@fec varchar(8)='NOW' 
     
 AS          
 BEGIN          
 SET NOCOUNT ON;  

 -- declare @tip_cod int = 2 ,@cod_rel varchar(20) = '77349070',@fec varchar(8)='NOW' 
 declare @cf as date,@cf_a as varchar(10)  
               
 if(@fec='NOW')          
 begin          
  select @cf=dateadd(day,-1,getdate())       
  end          
 else          
 begin          
  select @cf=@fec          
 end       
    
  select top 1 @cf_a=RFEC from storage.ref.RCALEN001 where RFEC<=cast(eomonth(@cf,-1) as date) order by rfec desc          
       
 declare @defs as rep.TTHCOLDEF;  

  insert into @defs        

    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values   
	(1,1,1,'HFECPRO','Fecha','date',null,null,null,null),
	--(1,1,1,'HTERRITORIO','Territorio','string',null,null,null,null),
	--(2,1,1,'HCORREDOR','Corredor','string',null,null,null,null),     
    (3,1,1,'HCODSEC','Usuario','string',null,null,null,null),
	(4,2,1,'HNOMBRE','Nombre','string',null,null,null,null), 
	(5,2,1,'HCARGO','Cargo','string',null,null,null,null),   
	--(6,3,1,'HTOT_DESPLAZAMIENTO','Desplazamientos Únicos','number','.0-0',null,null,null),  
 --   (7,3,1,'HDESPL_VALIDOG','Desplazamiento Válidos google','number','.0-0',null,null,null),  
    --(8,3,1,'HDISTPROMG','Distancia Promedio Google (km)','number','1.2-2',null,null,null),  
    (9,3,1,'HMONTOMOV','Monto Movilidad','number','1.2-2',null,null,null),  
    (10,3,1,'HPLANDATOS','Plan de Datos','number','1.2-2',null,null,null),  
    (11,3,1,'HRECLAMO','Reclamo','number','1.2-2',null,null,null),  
    (12,3,1,'HDESCTO','Descuento','number','1.2-2',null,null,null),  
    (13,3,1,'HPAGOFINAL','Pago Final','number','1.2-2',null,null,null),  
    (14,3,1,'HCOMETARIO','Comentario','string',null,null,null,null),  
    (15,3,1,'HCARTERA','Cartera al cierre','number','1.2-2',null,null,null)

	select rep.FFTHCOLDEF(@defs) result;
 

 -- declare @tip_cod int=2 , @cod_rel varchar(20)='77349070', @cant varchar='1',@cf_a varchar(10) =  '2025-04-30'  
    

	declare  @codbt as varchar (10),@mail as varchar (250),@es_rec as int=0
    select @codbt = HCODBT, @mail = HMAILPER from [storage].[gpr].[VPPH001] where HNUMDOC= @cod_rel

	select @es_rec = count (*) from [mod_sys_admin].[dbo].[VUSEPROF02] /*mod_sys_admin.[dbo].[SUSEPROF01] */  where SCODPROFN in ('PROF_RECUPERADOR','PROF_SEC') and SCODUSE = @mail
 
 
	if (@es_rec='0')
	   begin
			select
				HFECPRO, HCODSEC, HNOMBRE, HCARGO, HTERRITORIO, HCORREDOR, isnull(B.HTOT_DESPLAZAMIENTO,0) HTOT_DESPLAZAMIENTO, 
				isnull(B.HDESPL_VALIDOG,0)HDESPL_VALIDOG, isnull(B.HDISTPROMG,0)HDISTPROMG, isnull(B.HMONTOMOV,0)HMONTOMOV, 
				isnull(B.HPLANDATOS,0)HPLANDATOS, isnull(B.HRECLAMO,0)HRECLAMO, isnull(B.HDESCTO,0)HDESCTO, 
				isnull(B.HPAGOFINAL,0)HPAGOFINAL, B.HCOMETARIO, isnull(B.HCARTERA,0)HCARTERA	
				from storage.[com_act].[HBMOV002] B 
				where HCARGO like '%cobranza%' AND B.HFECPRO = @cf_a or  HCARGO like '%mora%'  AND B.HFECPRO = @cf_a order by HNOMBRE asc
		 end
	else 
		 begin
			select
				HFECPRO, HCODSEC, HNOMBRE, HCARGO, HTERRITORIO, HCORREDOR, isnull(B.HTOT_DESPLAZAMIENTO,0) HTOT_DESPLAZAMIENTO, 
				isnull(B.HDESPL_VALIDOG,0)HDESPL_VALIDOG, isnull(B.HDISTPROMG,0)HDISTPROMG, isnull(B.HMONTOMOV,0)HMONTOMOV, 
				isnull(B.HPLANDATOS,0)HPLANDATOS, isnull(B.HRECLAMO,0)HRECLAMO, isnull(B.HDESCTO,0)HDESCTO, 
				isnull(B.HPAGOFINAL,0)HPAGOFINAL, B.HCOMETARIO, isnull(B.HCARTERA,0)HCARTERA		
				from storage.[com_act].[HBMOV002] B 
				--where HCODSEC = 'TNBUP100'  AND B.HFECPRO = '2025-04-30'
				where HCODSEC = @codbt AND B.HFECPRO = @cf_a order by HNOMBRE asc
		end
	

end



select * from storage.[com_act].[HBMOV002]
