-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-02 09:29:27.310000
CREATE procedure [com].[GPDM001]    
@tip_cod int,@cod_rel varchar(20)     
as    
BEGIN    
 SET NOCOUNT ON;      
    
 declare @p_fecha varchar(8)    
 declare @defs as rep.TTHCOLDEF;     
 select @p_fecha='20220531'--(select replace(max(sfecpro),'-','') from [storage].[com_act].[SDAF018])    
     
 SET LANGUAGE spanish;    
 insert into @defs      
 (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values      
 (1,1,2,1,'descripcion','Descripción','string',1)    
     
 insert into @defs      
 (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD)  values      
 (2,2,2,1,'nro_asesores','Nro de Asesores','number','.0-0'),    
 (3,3,2,1,'Total_gr_desemb_pdm','Total Grupos Desembolsados','number','.0-0'),    
 (4,4,2,1,'prom_desem','Promedio Desembolsados por Asesor','number','.0-0'),    
 (5,5,2,1,'gru_nuev_pdm','Grupos Nuevos','number','.0-0'),    
 (6,6,2,1,'grup_recu','Grupos Recurrentes','number','.0-0')    
    
 SET LANGUAGE english;      
 select rep.FFTHCOLDEF(@defs) result;      
    
     
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF    
    
 insert into @tvars    
 values ('nro_asesores',null,null,null,null,null),    
 ('tot_desemb_pdm',null,null,null,null,null),    
 ('gru_nuev_pdm',null,null,null,null,null)    
    
 insert into @tfil    
 values    
 --tabla,clave,valores (usar la doble comilla para valores texto/fecha)    
 ('todos','fec','"'+@p_fecha+'"'+'')    
 insert into @tconf    
 values    
 ('level_alias','style')    
 declare @jer varchar(100)    
 insert into @tfil     
 exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jer output    
    
 create table #report (fila int,cod_prod_tipo varchar(100),cod_prod_com varchar(50),style int,descripcion varchar(100),    
    nro_asesores int,Total_gr_desemb_pdm int,gru_nuev_pdm int,prom_desem float,grup_recu float    
   )  --drop table #report    
 insert into #report(fila,cod_prod_tipo,cod_prod_com,style,descripcion,    
    nro_asesores,Total_gr_desemb_pdm,gru_nuev_pdm)    
       
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1    
    
 update a    
 set a.prom_desem=b.prom_desem,a.grup_recu=b.grup_recu    
 from #report a inner join (select descripcion,case when isnull(Total_gr_desemb_pdm,0)=0 then 0 else isnull(nro_asesores,0)/isnull(Total_gr_desemb_pdm,0)end as prom_desem,isnull(Total_gr_desemb_pdm,0) - isnull(gru_nuev_pdm,0) as grup_recu   from #report)b
    
 on a.descripcion=b.descripcion    
    
 SELECT*FROM #report    
END
