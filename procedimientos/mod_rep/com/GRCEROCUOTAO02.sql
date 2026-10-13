-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-24 08:44:45.343000
--exec [com].[GRCEROCUOTAO02]   7,'231'                                                  
CREATE  PROCEDURE [com].[GRCEROCUOTAO02]  
@tip_cod int,@cod_rel varchar(50) 
  --@tip_cod int=7,@cod_rel varchar(50)='231',@fec date='20220611'
as                                                                            
begin                                                                            
  SET NOCOUNT ON;  
--declare @tip_cod int=7,@cod_rel varchar(50)='231',@fec date='20220611'

declare @fec date
  set @fec=(select max(sfecpro) from storage.[com_act].[SDAS001])

declare @defs as rep.TTHCOLDEF                                                                  
 insert into @defs                                                                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,TFORUNI)  values                                                                   
 (1,1,1,'descripcion','Descripción','string',null,'20px',null),                                                                    
 (2,2,1,'num_ope_cc_2','Nro Operaciones','number','.0-0',null,null),                                                                    
 (3,3,1,'saldo_2','Monto','number','.0-0',null,null),                                                                    
 (4,4,1,'partNum','Variación Operaciones(a)','number','.0-0',null,null),                           
 (5,5,1,'partSaldo','Variación Monto(a)','number','.0-0',null,null),                                     
 (6,6,1,'VarPart','Variación % Participación(b)','number','.0-0',null,'pbs') 

 select rep.FFTHCOLDEF(@defs) result;  

declare @fec_a date,@fecs varchar(max)
 select top 1    
  @fec_a=RFECTXT    
 from storage.ref.RCALEN001    
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0    
 order by RFEC desc
 
 select @fec fec  into #Fec  union all select @fec_a  
  

 select @fecs=string_agg(convert(varchar(10),fec,112),',')  
from #Fec  

declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF


 insert into @tvars values     
 ('num_ope_uc',null,null,null,null,null), 
 ('saldo_uc',null,null,null,null,null) ,
 ('num_ope_cc' , null,null,null,null,null)
     
 insert into @tfil    
 values    
 ('todos','fec',@fecs)--,    

 insert into @tconf    
  values    
  ('level_alias','style'),
  --('insert_to','#report'),
  ('fec_corr','true')

  

	declare @jer varchar(100)
 insert into @tfil    
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output   
  
 create table #R1 (fila int null,cod varchar(250)null,cod_u varchar(250)null,style int null,descripcion varchar(250)null,
				   num_cero_1 int null,num_cero_2 int null,num_ope_cc_1 int null,num_ope_cc_2 int null,saldo_1 float null,saldo_2 float)  
 
  insert into #R1
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1    
 
  select style,descripcion,num_ope_cc_2,saldo_2,
	     num_ope_cc_2-num_ope_cc_1 partNum,saldo_2 - saldo_1 partSaldo,
		 ((num_ope_cc_1)/(1.* num_cero_1)) as Part1,
		 ((num_ope_cc_2)/(1.* num_cero_2)) as Part2,
		 ((((num_ope_cc_2)/(1.* num_cero_2))) - (((num_ope_cc_1)/(1.* num_cero_1))))*10000 VarPart
		 into #T --drop table #T
  from #R1  --select * from #T
   
select *
from  #T
 
end

--drop table #Fec,#R1,#T,#WJERCOR3,#MetSeg
