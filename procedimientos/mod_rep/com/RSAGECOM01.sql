-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-06-23 11:46:54.717000
--exec [com].[RSAGECOM01]   7,'231','20240625',2,0,0
--exec [com].[RSAGECOM01]   17,'1163','20240904',2,0,0
CREATE  PROCEDURE [com].[RSAGECOM01]     
@tip_cod int,@cod_rel varchar(20),@fecha date,@mode int,@fuga int,@prop int
AS  
BEGIN    
 set nocount on;    
 -- declare @tip_cod int =7,@cod_rel varchar(20) = '231',@fecha date = '20240625',@mode int=2,@fuga int =0,@prop int =0
 
 select    @fecha = max (rfecpro) from storage.ref.wjercor03
 declare @fec varchar(8) = (select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0);  

 
declare @columns varchar(100);  
declare @f int,@i int=1
declare @defs as rep.TTHCOLDEF  
declare @head_1 as table(id int,ord int,color nvarchar(20),name nvarchar(200),cols int);    
declare @head_2 as table(ord int,color nvarchar(20),name nvarchar(200),[key] nvarchar(200),ftype varchar(100),fmode varchar(100),actvar varchar(100));  

set @columns='"vars","age_com"'; 

----------------------------- -- declare @tip_cod int =21,@cod_rel varchar(20) = '1'
 select HEVTO, case when count(distinct case when HINDBASE=1 then HNUMCON else null end) >0 then	
		cast ( count(distinct case when HINDDESB=1 then HNUMCON else null end) as float)/ count(distinct case when HINDBASE=1 then HNUMCON else null end)
		end   porce 
		into #sort
		from storage.[com_act].WABDC001 A
		left join storage.ref.wjercor03 B on A.HCODSEC = B.RCODSEC and a.HFECPRO = b.RFECPRO and b.RINDFEC = 'actual'
		 where HFECPRO in (@fecha) and 
		  case when @tip_cod=7 then '1'  
		  when @tip_cod=20 then cast (RCODTER as varchar)
		  when @tip_cod=19 then cast (RCODCOR as varchar)
		  when @tip_cod=21 then cast (RCODGRU as varchar) 
		  when @tip_cod=18 then cast (RCODUNI as varchar)
		  when @tip_cod=17 then cast (RCODUCO as varchar)
		  end = case when @cod_rel='231' then '1' else @cod_rel  end
		group by HEVTO order by 2 asc
		 --drop table #sort,#sort2,#Def select * from  #sort2
		 select *, DENSE_RANK() OVER (ORDER BY porce DESC)  Rowsort  into #sort2   from #sort 
		 select HEVTO, porce ,ROW_NUMBER() OVER( ORDER BY Rowsort ASC) AS Rowsort into #sort3  from #sort2 
-----------------------------

;with a as (    
 select distinct HEVTO from storage.[com_act].WABDC001    
 )    
  insert into @head_1     
 select A.HEVTO,
 --row_number() over(order by A.HEVTO),
 Rowsort,
 null,isnull(B.HDSC,CONCAT('BASE ',A.HEVTO)) HDSC, 8    
 from a A    
 left join storage.[com_act].[VABRE001] B    
 on A.HEVTO=B.HEVTO 
 left join #sort3 C   
 on A.HEVTO=C.HEVTO
 where A.HEVTO<>-999  

 

insert into @head_2 values    
 (1,null,'Total Base','vari_1:_ord','number','.0-0',null),    
 (2,null,'Agendados','vari_2:_ord','number','.0-0',null),    
 (3,null,'% Agendados','vari_3:_ord','ratio',null,'vari_2:_ord-vari_1:_ord'),    
 (4,null,'Gestionados','vari_4:_ord','number','.0-0',null),    
 (5,null,'% Gestionados','vari_5:_ord','ratio',null,'vari_3:_ord-vari_1:_ord'),    
 (6,null,'Desembolsos','vari_6:_ord','number','.0-0',null),    
 (7,null,'% Desembolso','vari_7:_ord','ratio',null,'vari_4:_ord-vari_1:_ord'),  
 (8,null,'Intensidad Gest','vari_8:_ord','ratio','.2-2',null)  

  

 select @f=count(*) from @head_1      
  
 declare @id int     
 while @i<=@f    
	 begin     
	 select @id=id from @head_1 where ord=@i;    
      --select * 	 from @head_1 where ord=@i;   
	 insert into @defs ( TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TORDER)    
	 select  1,'a_'+cast(@i as varchar),name,cols,color ,ord    
	 from @head_1 where ord=@i   
    
	 insert into @defs ( TISDATA,TLEV,TKEY,TDESC,TFORTYP,TACTDESC)    
	 select ord+(8*@i),  3,  replace([key],':_ord',iif(@mode=1,'','_'+cast(@id as varchar))),    
	 name,ftype, (SELECT name  from @head_1 where ord=@i )
	 from @head_2    
     set @i=@i+1   
	 
	   --SELECT name  from @head_1 where ord=@i
	 end
 

select 0 TLEV,'descripcion' TKEY,'Descripción' TDESC ,1 TCOLS,NULL TROWS,NULL TISDATA,NULL THIDDEN,NULL TSTICKY,NULL TFORTYP,NULL TFORMOD,NULL TFORUNI,
NULL TORDER,NULL TSTICKYEND,NULL TSTBACKGROUND,NULL TSTDEWIDTH, NULL TACTVAR,NULL TACTDESC,NULL TACTCOLOR,NULL TACTICON into #Def 
union
select * from @defs order by TLEV,TORDER 
 

  --select * from #Def order by TLEV,TORDER 


 declare @head as nvarchar(max)
 
  if(@mode=1)  
 begin  
 set @columns='"vars"';   
 set @head = '[{ "label":"Descripción","key":"descripcion","cellStyle":{"min-width":"250px"}}, 
 {"label":"Total", "subs":[
 {"label":"Total Base","key":"vari_1","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
 {"label":"Agendado","key":"vari_2","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
 {"label":"% Agendado","key":"vari_3","format":{"type":"percent"},"cellStyle":{"text-align":"right"}},
 {"label":"Gestionados","key":"vari_4","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
 {"label":"% Gestionados","key":"vari_5","format":{"type":"percent"},"cellStyle":{"text-align":"right"}},
 {"label":"Desembolsos","key":"vari_6","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
 {"label":"% Desembolsos","key":"vari_7","format":{"type":"percent"},"cellStyle":{"text-align":"right"}},
 {"label":"Intensidad Gest","key":"vari_7","format":{"type":"percent"},"cellStyle":{"text-align":"right"}}
 ] }]'

 
 end  
 else if(@mode=2)  
 begin  
	  --declare @head as nvarchar(max)
 	select  @head = (
	select	 
	--select * from #Def
	'label'= TDESC,
	'key'  = TKEY,
	'subs'= (
				  select  'label'= TDESC,
						 'key'  = TKEY,
						 'format' =  case when TFORTYP = 'number' then 'integer' when  TFORTYP ='ratio'  then 'percent' else '' end,
						 'cellStyle' = 'right'
				  from #Def B
				  where  B.TACTDESC = A.TDESC
				  and B.TACTDESC is not null
				  order by b.TISDATA asc
				  for json path
			  )
	from (select  TDESC,TKEY from #Def where TLEV in (0,1)    ) a
	for json PATH
	)

	select @head = replace (@head,'"format":"integer"','"format":{"type":"integer"}')
  	select @head = replace (@head,'"format":"percent"','"format":{"type":"percent"}')
	select @head = replace (@head,'"cellStyle":"right"','"cellStyle":{"text-align":"right"}')
	select @head = replace (@head,'"Descripción","key":"descripcion"','"Descripción","key":"descripcion","cellStyle":{"min-width":"250px"}') 
	--select @head = replace (@head,'"key":"descripcion"','"key":"descripcion","sticky":"true"')

 
 end
  --left join storage.[com_act].[VABRE001] B  
 
  

 /*
 --declare @head as nvarchar(max)
 	select  @head = (
	select	 
	--select * from #Def
	'label'= TDESC,
	'key'  = TKEY,
	'subs'= (
				  select  'label'= TDESC,
						 'key'  = TKEY,
						 'format' =  case when TFORTYP = 'number' then 'integer' when  TFORTYP ='ratio'  then 'percent' else '' end,
						 'cellStyle' = 'right'
				  from #Def B
				  where  B.TACTDESC = A.TDESC
				  and B.TACTDESC is not null
				  order by b.TISDATA asc
				  for json path
			  )
	from (select  TDESC,TKEY from #Def where TLEV in (0,1)    ) a
	for json PATH
	)

	select @head = replace (@head,'"format":"integer"','"format":{"type":"integer"}')
  	select @head = replace (@head,'"format":"percent"','"format":{"type":"percent"}')
	select @head = replace (@head,'"cellStyle":"right"','"cellStyle":{"text-align":"right"}')
	select @head = replace (@head,'"Descripción","key":"descripcion"','"Descripción","key":"descripcion","cellStyle":{"min-width":"250px"}') 

	select @head = replace (@head,'"key":"descripcion"','"key":"descripcion","sticky":"true"')
	*/
 select @head  

--drop table #Def

 --select 1 hola  
 --declare @fec varchar(8)='20200805'    
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF    
    
  insert into @tvars values     
 ('num_cli_bas_ac1',null,'vari_1',null,null,null),  
 ('num_cli_age_ac1',null,'vari_2',null,null,null), 
 ('num_cli_por_age_ac1',null,'vari_3',null,null,null),
 ('num_cli_ges_ac1',null,'vari_4',null,null,null), 
 ('num_cli_por_ges_ac1',null,'vari_5',null,null,null), 
 ('num_cli_des_ac1',null,'vari_6',null,null,null), 
 ('num_cli_por_des_ac1',null,'vari_7',null,null,null), 
 ('num_cli_int_ges_ac1',null,'vari_8',null,null,null)
 --('num_cli_gesT_ac1','case when num_cli_ges_ac1 > 0 then ( cast(num_cli_gesT_ac1  as float)/cast(num_cli_ges_ac1 as float)) else 0 end ','vari_5',null,null,'float')   
  
 insert into @tfil    
 values    
 ('todos','fec',''+@fec+'')  
 
  if(@fuga<>0)                                  
 begin                                  
  insert into @tfil values                                  
  ('todos','Fuga',''+@fuga+'')                                 
 end  
 if(@prop<>0)                                  
 begin                                  
  insert into @tfil values                                  
  ('todos','Propension',''+@prop+'')                                 
 end  

 declare @jer varchar(100);  
 insert into @tfil  
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output  

	

 insert into @tconf    
 values    
 ('level_alias','style')    
  
 ----los valores rows y columnas van separados por comas y cada valor entre doble comilla    
 ----'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion   
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns=@columns,@config=@tconf --    ,@show_query=1    
   
   drop table #sort,#sort2,#Def

END
