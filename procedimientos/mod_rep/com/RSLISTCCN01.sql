-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-15 15:03:24.060000
--EXEC [com].[RSLISTCCN01] 7,'231',1,'Nuevo'                  
CREATE  PROCEDURE [com].[RSLISTCCN01]                                  
@tip_cod int,@cod_rel nvarchar(100),@pagen int ,@tipcuota varchar(250)                        
AS                                  
BEGIN                            
  SET NOCOUNT ON;                     
                  
                  
 declare @fecha date=dateadd(day,-1,GETDATE());                    
 declare @fec date=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)                    
 declare @defs as rep.TTHCOLDEF                      
 insert into @defs                    
                                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values                   
 (1,1,1,'HFECPRO','Fecha_Cierre','string',null,null),                    
 (2,2,1,'HCODOPE','Operación','string',null,null),                    
 (3,3,1,'HCTACLI','Cta_Cliente','string',null,null),                    
 (4,4,1,'HDESCLI','Nombre Cliente','string',null,null),                   
 (5,5,1,'IndCartera','Indicador Cartera','string',null,null),                
 (6,6,1,'IndIngreso','Indicador Ingreso','string',null,null),                     
 (7,7,1,'RDESSEC','Asesor','string',null,null),                  
 (8,8,1,'RDESADM','Unidad Negocio','string',null,null),                    
 (9,9,1,'RDESCOR','Corredor','string',null,null),                    
 (10,10,1,'RDESTER','Territorio','string',null,null),                    
 (11,11,1,'HSALCAPMN','Sal_Cap_MN','number','.0-0',null),                    
 (12,12,1,'HSALVENMN','Sal_Ven_MN','number','.0-0',null),                    
                
 (13,13,1,'HDSUCCLI','Agencia','string',null,null),                    
 (14,14,1,'HFECDES','Fecha Desembolso','string',null,null),                    
 (15,15,1,'HDESCIIU','Giro de Negocio','string',null,'30px'),                    
 (16,16,1,'HMONDES','Monto Desembolsado','number','.0-0',null),                                  
 (18,18,1,'HSITCRE','Situación de Crédito','string',null,null) ,                   
 (19,19,1,'HDIAATR','D. de Atraso','string',null,null),          
 (20,20,1,'HFCFGEST','Fecha Última Gestión','string',null,null) ,      
 (21,21,1,'HFCCOM','Reacción','string',null,null)                    
                 
                     
 select rep.FFTHCOLDEF(@defs) result;                    
                     
--declare @tip_cod int=15,@cod_rel nvarchar(100)='3'                    
--declare @tramof varchar(20)='TODO',@prod varchar(50)='TODO',@comp_r varchar(20)='TODO',@zcuo varchar(20)='TODO',@ucuo varchar(20)='TODO',@nom varchar(150)='%%',                        
--@resp varchar(250)='TODO',@tdcr varchar(50)='TODO',@pagen int=1                        
                         
 DECLARE @PageNumber AS INT, @RowspPage AS INT ,@count AS INT                       
 SET @PageNumber = @pagen                        
 SET @RowspPage = 30;                      
 declare @result as table([row] int,                    
 HFECPRO varchar(250)null,HCODOPE varchar(250)null,RCODSEC varchar(250)null,HSALCAPMN varchar(250)null,HSALVENMN varchar(250)null,                  
 RDESSEC varchar(250)null,RDESADM varchar(250)null,RDESCOR varchar(250)null,                  
 RDESTER varchar(250)null,HDSUCCLI varchar(250)null,HCTACLI varchar(250)null,HDESCLI varchar(250)null,                  
 HFECDES varchar(250)null,HMONDES varchar(250)null,HDESCIIU varchar(250)null,HSITCRE varchar(250)null,IndCartera varchar(250)null,                  
 IndIngreso varchar(250)null,HDIAATR VARCHAR(250)NULL ,HFCFGEST varchar(250), HFCCOM varchar(250)null                 
 )                    
                    
 ;with a as (                    
  select --a.*          
  a.HFECPRO,a.HCODOPE ,a.HCODSEC ,a.HSALCAPMN ,a.HSALVENMN , b.RDESSEC ,b.RDESUNI ,b.RDESCOR ,b.RDESTER ,a.HDSUCCLI ,a.HCTACLI ,a.HDESCLI ,                  
a.HFECDES,a.HMONDES ,a.HDESCIIU ,a.HSITCRE ,a.IndCartera ,a.IndIngreso ,a.HDIAATR  ,a.HFCFGEST,a.HFCCOM             
 from  storage.[com_act].[WCCLISTADO01] A    --select DISTINCT HFECPRO from  storage.[com_act].[WCCLISTADO01]    
 --UPDATE             storage.[com_act].[WCCLISTADO01] SET HFECPRO='20220531' WHERE HFECPRO='2022-06-01'    
 /*left join storage.[ref].WJERCOR01 B ON A.HCODSEC=B.RCODSEC and B.RFECPRO=@fec                     
 where  case when @tip_cod=15 then  ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')                     
     when @tip_cod=14 then cast(B.RCODCOR as nvarchar(10))                  
     when @tip_cod=13 then B.RCODGRU                    
     --when @tip_cod=12 then B.RCODSUBC                    
      when @tip_cod=11 then B.RCODADM else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                    
  and case when @tipcuota='TODO' then '1' else A.IndIngreso end =case when @tipcuota='TODO' then '1' else @tipcuota end                          
          */ --SELECT TOP 5 * FROM storage.[ref].WJERCOR03    
        
  left join storage.[ref].WJERCOR03 B ON A.HCODSEC=B.RCODSEC and B.RFECPRO=@fec                     
 where  case when @tip_cod=21 then  ISNULL(cast(B.RCODGRU as nvarchar(10)),'9999')                     
     when @tip_cod=20 then cast(B.RCODTER as nvarchar(10))                  
     when @tip_cod=19 then B.RCODCOR                    
     --when @tip_cod=12 then B.RCODSUBC                    
      when @tip_cod=18 then B.RCODUNI else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                    
  and case when @tipcuota='TODO' then '1' else A.IndIngreso end =case when @tipcuota='TODO' then '1' else @tipcuota end                          
             
               
 )insert into @result                    
   select                     
   row_number() over(order by HSALCAPMN desc) AS [row],                    
   *                     
   from a                    
                        
                     
     select * from @result ORDER BY [row] asc                    
  OFFSET ((@PageNumber - 1) * @RowspPage) ROWS                        
  FETCH NEXT @RowspPage ROWS ONLY;                    
                    
  select count(*) as Total from @result                    
                    
END
