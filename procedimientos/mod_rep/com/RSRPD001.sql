-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-05-06 08:42:37.993000
--exec mod_rep.com.RSRPD001 1      
--exec mod_rep.com.RSRPD001 2      
CREATE PROCEDURE com.RSRPD001      
    @Opt char(1)='1'      
AS      
BEGIN      
    IF @OPT='1'      
 BEGIN      
        DECLARE @Fecha DATE      
        SET @Fecha=(SELECT getdate())      
      
        /* Obtenemos la fecha calendarios(Lunes a sabado) Excepto Feriados */      
        SELECT @Fecha = MAX(RFEC)      
        FROM storage.[ref].RCALEN001      
        WHERE RFEC <= @Fecha AND RDIAFER=0      
       
declare @json varchar(max)='[      
    {      
      "level": 1,      
      "columns": [      
        {      
          "columnDef": "fec_pro",      
          "header": "Fecha Proceso",      
          "isdata": 1,      
          "sticky": true,      
          "format": {      
            "type": "string",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "cod_pro",      
          "header": "Cod Proceso",      
    "TSTDEWIDTH":"25%",      
          "isdata": 2,      
          "sticky": true,      
          "format": {      
            "type": "string",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "nom_pro",      
          "header": "Descripción",      
    "TSTDEWIDTH":"25%",      
          "isdata": 3,      
          "sticky": true,      
          "format": {      
            "type": "string",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "fec_ini",      
          "header": "Inicio",      
          "isdata": 4,      
          "format": {      
            "type": "date",      
            "mode": "yyyy-MM-dd HH:mm:ss",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "fec_fin",      
          "header": "Fin",      
          "isdata": 5,      
          "format": {      
            "type": "date",      
            "mode": "yyyy-MM-dd HH:mm:ss",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "dif_min",      
          "header": "Duración",      
          "isdata": 6,      
          "format": {      
            "type": "string",      
            "align": "center"      
          }      
        },      
  {      
          "columnDef": "est_pro",      
          "header": "Estado",      
    "cols": 2,      
          "isdata": 7,      
          "format": {      
            "type": "string",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "sem_est",      
          "header": "",      
          "isdata": 8,      
          "hidden": true,      
          "format": {      
            "type": "traffic-light",      
            "align": "center"      
          }      
        }      
      ]      
    }]'      
 select @json      
               
;with cte_a as(      
 select  HTIPPRO,HCODPRO,case when  HCODPRO like 'SRC%' then 'Carga '+lower(HDESPRO)  else 'Procesado '+HDESLOG end HDESLOG,HDESPRO      
 from  strategos.etl.ABPCONF01      
 where  HSTATUS=1 and HCODPRO not in ('SRC010','SUM010')      
 UNION      
 select  'SRC','SRC010-10','Carga Cartera Intradia 10:30','Carga Cartera Intradia 10:30'      
 UNION      
 select  'SRC','SRC010-14','Carga Cartera Intradia 14:30','Carga Cartera Intradia 14:30'      
 UNION      
 select  'SRC','SRC010-17','Carga Cartera Intradia 17:30','Carga Cartera Intradia 17:30'      
 UNION      
 select  'SUM','SUM010-10','Carga Cartera Intradia 10:30','Carga Cartera Intradia 10:30'      
 UNION      
 select  'SUM','SUM010-14','Carga Cartera Intradia 14:30','Carga Cartera Intradia 14:30'      
 UNION      
 select  'SUM','SUM010-17','Carga Cartera Intradia 17:30','Carga Cartera Intradia 17:30'      
)      
,cte_b as(      
 select  HFECPRO,HCODPRO,HDESTAD,HFECLOG,HDESPRO      
 from  strategos.etl.ABPEVLOG01      
 where  HFECPRO=@Fecha and HCODPRO not in ('SRC010-10','SRC010-14','SRC010-17','SUM010-10','SUM010-14','SUM010-17')      
 UNION ALL      
 select  HFECPRO,HCODPRO,HDESTAD,HFECLOG,HDESPRO       
 from  strategos.etl.ABPEVLOG01      
 where  HFECPRO=dateadd(dd,1,@Fecha) and HCODPRO in ('SRC010-10','SRC010-14','SRC010-17','SUM010-10','SUM010-14','SUM010-17','SRC017','SRC018','SRC019','SRC020','SRC021','SRC022','SRC023','SRC024','SRC025','SRC027','SRC028','SRC029','SRC030','SRC031','SRC
032','SRC033','SRC034','SRC035','SRC036','SRC037','SRC038','SRC040','SRC041','SRC042')      
 UNION ALL      
 select  HFECPRO,HCODPRO,HDESTAD,HFECLOG,HDESPRO       
 from  strategos.etl.ABPEVLOG01      
 where  HFECPRO=dateadd(dd,1,@Fecha) and HCODPRO in ('SUM010-10','SUM010-14','SUM010-17','SUM010-10','SUM010-14','SUM010-17','SUM017','SUM018','SUM019','SUM020','SUM021','SUM022','SUM023','SUM024','SUM025','SUM027','SUM028','SUM029','SUM030','SUM031','SUM
032','SUM033','SUM034','SUM035','SUM036','SUM037','SUM038','SUM040','SUM041','SUM042')      
      
)      
,cte_c as(      
 select  B.HFECPRO,A.HCODPRO,case when HTIPPRO='SRC' then A.HDESPRO else HDESLOG end HDESLOG,B.HDESTAD,B.HFECLOG       
 from  cte_a A      
 left join cte_b B      
 on   A.HCODPRO=B.HCODPRO       
)      
select  HFECPRO fec_pro,HCODPRO cod_pro,HDESLOG nom_pro      
   ,format(Iniciado,'yyyy-MM-dd HH:mm:ss') fec_ini      
   ,format(Finalizado,'yyyy-MM-dd HH:mm:ss') fec_fin      
   ,CONVERT(varchar, DATEADD(second, datediff(ss,Iniciado,Finalizado), 0), 108) dif_min      
   ,case when Iniciado is not null and Finalizado is null then 'Ejecutando'       
     when Iniciado is not null and Finalizado is not null then 'Finalizado' else 'Pendiente' end est_pro         
   ,case when Iniciado is not null and Finalizado is null then 0      
     when Iniciado is not null and Finalizado is not null then 1 else 0 end sem_est      
   ,case when Iniciado is not null and Finalizado is null then 1 else 0 end ind_ejec       
   ,case when convert(varchar(8),Iniciado,108)>'07:00:00' and HCODPRO not in ('SRC010-10','SRC010-14','SRC010-17','SUM010-10','SUM010-14','SUM010-17') then 1       
     when convert(varchar(8),Iniciado,108)>'10:35:00' and HCODPRO in ('SRC010-10','SUM010-10') then 1      
     when convert(varchar(8),Iniciado,108)>'14:35:00' and HCODPRO in ('SRC010-14','SUM010-14') then 1      
     when convert(varchar(8),Iniciado,108)>'17:35:00' and HCODPRO in ('SRC010-17','SUM010-17') then 1      
      else 0 end ind_retraso      
from  cte_c      
   pivot(max(HFECLOG) for HDESTAD in([Iniciado],[Finalizado])) PVT      
--order by HCODPRO asc      
order by Finalizado desc,HCODPRO asc
      
      
        
    END      
    IF @OPT='2'       
 BEGIN      
  declare @json1 varchar(max)      
  select @json1='[      
    {      
      "level": 1,      
      "columns": [      
        {      
          "columnDef": "des_pro",      
          "header": "Proceso",      
          "isdata": 1,      
          "sticky": true,      
          "format": {      
            "type": "string",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "fec_act",      
          "header": "Fecha de Actualización",      
          "isdata": 2,      
          "format": {      
            "type": "date",      
            "mode": "yyyy-MM-dd HH:mm:ss",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "fec_rep",      
          "header": "Fecha del Reporte",      
          "isdata": 3,      
          "format": {      
            "type": "date",      
            "mode": "yyyy-MM-dd",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "fec_rep_ant",      
          "header": "Fecha del Reporte Anterior",      
          "isdata": 4,      
          "format": {      
            "type": "date",      
            "mode": "yyyy-MM-dd",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "est_pro",      
          "header": "Estado",      
      "isdata": 5,      
          "cols": 2,      
          "format": {      
            "type": "string",      
            "align": "center"      
          }      
        },      
        {      
          "columnDef": "sem_fec",      
          "header": "",      
          "isdata": 6,      
          "hidden": true,      
          "format": {      
            "type": "traffic-light",      
            "align": "center"      
          }      
        }      
      ]      
    }]'      
  select @json1      
      
  DECLARE @FechaDiaAnterior DATE ,@FechaHoy DATE      
          
        SELECT  @FechaDiaAnterior = MAX(RFEC)      
        FROM  storage.[ref].RCALEN001      
        WHERE  RFEC < cast(getdate() as date) AND RDIAFER=0      
      
        SET   @FechaHoy =(select CAST(GETDATE() AS DATE))   
       
        SELECT id      
            ,CASE WHEN ID in(10) AND CONVERT(CHAR(5), fechaAct, 108)<'10:00' THEN 'Saldos cartera 10:30 AM'      
     WHEN ID in(10) AND convert(char(5), fechaAct, 108)<'12:00' THEN 'Saldos cartera 14:30 PM'      
     WHEN ID in(10) AND convert(char(5), fechaAct, 108)<'17:00' THEN 'Saldos cartera 17:30 PM'      
     ELSE UPPER(LEFT(descripcion,1))+LOWER(SUBSTRING(descripcion,2,LEN(descripcion)))       
   END AS des_pro      
   ,format(FechaAct,'yyyy-MM-dd HH:mm') AS fec_act  
   ,format(FechaRep,'yyyy-MM-dd') AS fec_rep      
   ,format(FechaRepAnt,'yyyy-MM-dd') AS fec_rep_ant  
   ,BitAct      
    ,case when cast(FechaAct as date)>=@FechaHoy and ID not in(10) then 'Finalizado'  
     when cast(FechaAct as date)>=@FechaHoy and ID in(10) and convert(char(5), fechaAct, 108)>'17:00'then 'Finalizado'  
     else 'Pendiente' end AS est_pro  
    ,case when cast(FechaAct as date)>=@FechaHoy and ID not in(10) then 1  
     when cast(FechaAct as date)>=@FechaHoy and ID in(10) and convert(char(5), fechaAct, 108)>'17:00'then 1  
     else 0 end AS sem_fec  
        from  LS_FCMIS_REP.FCMIS_REP.dbo.ControlCargaData  NOLOCK  
        ORDER BY 3 DESC      
      
    END      
END
