-- Dependencias según el motor: base mod_rep · 258 procedimiento(s)
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera.
--
-- Qué devuelve: una fila por (SP, tabla, columna) que SQL Server tiene registrada.
-- Cómo se usa: ejecutar, "Guardar resultados como…" CSV CON encabezados en
--   extraccion/fuente/dependencias/mod_rep.csv  y correr  npm run generar.
--
-- Límites del motor (ver skill dic-analisis-dependencias):
--   · Las columnas de tablas de OTRA base no se resuelven (ref_columna queda vacía):
--     para esas, manda el analizador estático.
--   · SQL dinámico (EXEC(@sql), sp_executesql) y tablas #temporales no aparecen.
--   · Si un SP no compila contra el esquema actual, `error` lo dice y se sigue con el resto.

USE mod_rep;
GO
SET NOCOUNT ON;

DECLARE @catalogo TABLE (esquema sysname, nombre sysname);
INSERT INTO @catalogo (esquema, nombre) VALUES
     (N'com', N'DINCEPDM01')
    ,(N'com', N'GCMCNUE001')
    ,(N'com', N'GCMCNUE002')
    ,(N'com', N'GCMGCAP01')
    ,(N'com', N'GCMGCARTAS001')
    ,(N'com', N'GCMGMORA001')
    ,(N'com', N'GCMGMORA001_SIMP')
    ,(N'com', N'GCMGMORA003')
    ,(N'com', N'GCOMCRE01')
    ,(N'com', N'GCOMCRE02')
    ,(N'com', N'GCOSELIS001')
    ,(N'com', N'GCOSEMAF002')
    ,(N'com', N'GDACDESEM01')
    ,(N'com', N'GDASHCLI01')
    ,(N'com', N'GDASHKAY03')
    ,(N'com', N'GDASHKAY05')
    ,(N'com', N'GDASHKAY06')
    ,(N'com', N'GDCEROCN003')
    ,(N'com', N'GDCEROCN004')
    ,(N'com', N'GDCGEST_ACTIVAST01')
    ,(N'com', N'GDCGEST_ACTIVAST02')
    ,(N'com', N'GDCGEST_ACTIVAST03')
    ,(N'com', N'GDCGEST_ACTIVAST04')
    ,(N'com', N'GDCGEST_PASIVAST01')
    ,(N'com', N'GDCLIOPE01')
    ,(N'com', N'GDMREP001')
    ,(N'com', N'GLIMOVO01')
    ,(N'com', N'GLIMOVO02')
    ,(N'com', N'GLIMOVO05')
    ,(N'com', N'GLIMOVO06')
    ,(N'com', N'GLIMOVRO01')
    ,(N'com', N'GLIMOVRO05')
    ,(N'com', N'GLIMOVRO06')
    ,(N'com', N'GLISAUTO01')
    ,(N'com', N'GLISAUTRO05')
    ,(N'com', N'GLISCAPRET01')
    ,(N'com', N'GLISDETCLI01')
    ,(N'com', N'GLISDETCLIPDM01')
    ,(N'com', N'GLISPROSP01')
    ,(N'com', N'GMOVCLI01')
    ,(N'com', N'GPASP001')
    ,(N'com', N'GPDM001')
    ,(N'com', N'GPRECOSCUAD001')
    ,(N'com', N'GPRECOSELIS001')
    ,(N'com', N'GRCEROCUOTAO01')
    ,(N'com', N'GRCEROCUOTAO02')
    ,(N'com', N'GRESCAMCOND01')
    ,(N'com', N'GRESCAMCOND03')
    ,(N'com', N'GRESCAMIMP01')
    ,(N'com', N'GRESCLIREP01')
    ,(N'com', N'GRESDESCRE02')
    ,(N'com', N'GRESPDATOS01')
    ,(N'com', N'GRESPDATOS02')
    ,(N'com', N'GRESPROGOB01')
    ,(N'com', N'GRESPROGOB02')
    ,(N'com', N'GRESREAGRO01')
    ,(N'com', N'GRESREPSEG_01')
    ,(N'com', N'GRESREPSEG01')
    ,(N'com', N'GRESREPSEG02')
    ,(N'com', N'GRESREPSEG03')
    ,(N'com', N'GRESREPSEG04')
    ,(N'com', N'GRESREPSEG05')
    ,(N'com', N'GRESREPSEG06')
    ,(N'com', N'GRESTOPIMP01')
    ,(N'com', N'GRGCTABDIGO02')
    ,(N'com', N'GRGCTABDIGO03')
    ,(N'com', N'GRMENTOR001')
    ,(N'com', N'GRMENTOR002')
    ,(N'com', N'GRTABAPPO01')
    ,(N'com', N'GRTABCORRO01')
    ,(N'com', N'GRTABDIGO01')
    ,(N'com', N'GRTABDIGO02')
    ,(N'com', N'GRVGENCORO01')
    ,(N'com', N'GRVGENCORO02')
    ,(N'com', N'GSCAMP01')
    ,(N'com', N'GSCASEG01')
    ,(N'com', N'GSEGCAPBP01')
    ,(N'com', N'GSEGCAPBP02')
    ,(N'com', N'GSEGCAPRED01')
    ,(N'com', N'GSEGUIINC001')
    ,(N'com', N'GSELCIUT001')
    ,(N'com', N'GSELCIUT002')
    ,(N'com', N'GSELJERAR001')
    ,(N'com', N'GSELJERAR002')
    ,(N'com', N'GSELREP001')
    ,(N'com', N'GSELREP002')
    ,(N'com', N'GSMODAGEN01')
    ,(N'com', N'GTOPCERCUO001')
    ,(N'com', N'GTOPCERCUO002')
    ,(N'com', N'GTOPCERCUO003')
    ,(N'com', N'GTOPCERCUO004')
    ,(N'com', N'GTOPCERCUO005')
    ,(N'com', N'RACTGP01')
    ,(N'com', N'RAGROMIX')
    ,(N'com', N'RCARDZCUO01')
    ,(N'com', N'RCDATREACT01')
    ,(N'com', N'RCORRES01')
    ,(N'com', N'RCORRES05')
    ,(N'com', N'RCORRES06')
    ,(N'com', N'RDETCORR01')
    ,(N'com', N'RENRCOLAB01')
    ,(N'com', N'RENRDESEM01')
    ,(N'com', N'RENROPE01')
    ,(N'com', N'RENRPAS01')
    ,(N'com', N'RENRPAS02')
    ,(N'com', N'RESDMOV01')
    ,(N'com', N'RESDMOV02')
    ,(N'com', N'REXPAGRO01')
    ,(N'com', N'RFECREPMEN')
    ,(N'com', N'RFECREPMEN02')
    ,(N'com', N'RGRAFGESTCOM01')
    ,(N'com', N'RGRAFGESTCOM02')
    ,(N'com', N'RGRAFGESTCOM03')
    ,(N'com', N'RGRAFGESTCOM04')
    ,(N'com', N'RGRAFGESTCOM05')
    ,(N'com', N'RGRAFGESTCOM06')
    ,(N'com', N'RGRAFGESTCOM07')
    ,(N'com', N'RGRAFSEGPAS01')
    ,(N'com', N'RGRAFSEGPAS02')
    ,(N'com', N'RGRAFZCUO01')
    ,(N'com', N'RGRAFZCUO02')
    ,(N'com', N'RGRAFZCUO03')
    ,(N'com', N'RGRAFZCUO04')
    ,(N'com', N'RINCEGP01')
    ,(N'com', N'RINCEPDM01')
    ,(N'com', N'RMESA01')
    ,(N'com', N'RMONINTCOM01')
    ,(N'com', N'RMORAGP01')
    ,(N'com', N'RPROSCORR002')
    ,(N'com', N'RPROSCORR004')
    ,(N'com', N'RPROSCORR005')
    ,(N'com', N'RPROSCORR006')
    ,(N'com', N'RRANKM01')
    ,(N'com', N'RRANKM02')
    ,(N'com', N'RREPGESTCOM02')
    ,(N'com', N'RREPGESTCOM03')
    ,(N'com', N'RS_AGE_COM_CR_01')
    ,(N'com', N'RS_AGE_COM_CR_02')
    ,(N'com', N'RS_AGE_COM_CR_M_01')
    ,(N'com', N'RS_AGE_COM_CR_M_02')
    ,(N'com', N'RS_AGE_COM_CR_M_03')
    ,(N'com', N'RS_AGE_COM_CR_M_04')
    ,(N'com', N'RS_AGROMIX_CHART')
    ,(N'com', N'RS_AGROMIX_CHART2')
    ,(N'com', N'RS_AGROMIX_CHART3')
    ,(N'com', N'RS_AGROMIX_CHART4')
    ,(N'com', N'RSAGECOM01')
    ,(N'com', N'RSAGECOM02')
    ,(N'com', N'RSAGECOM03')
    ,(N'com', N'RSAPPUSO001')
    ,(N'com', N'RSAVAPOR01')
    ,(N'com', N'RSBASENEG01')
    ,(N'com', N'RSCALCAR01')
    ,(N'com', N'RSCALCAR02')
    ,(N'com', N'RSCAPCOME01')
    ,(N'com', N'RSCLIVULNER01')
    ,(N'com', N'RSCMGCF001')
    ,(N'com', N'RSCMGCLIPAS01')
    ,(N'com', N'RSCMGCLIPAS02')
    ,(N'com', N'RSCMGCLIPAS03')
    ,(N'com', N'RSCMGFCA002')
    ,(N'com', N'RSCOMPAS01')
    ,(N'com', N'RSDATPRO01')
    ,(N'com', N'RSDATPRO02')
    ,(N'com', N'RSDATPRO03')
    ,(N'com', N'RSDATPRO04')
    ,(N'com', N'RSDEPGSOLID01')
    ,(N'com', N'RSDESEMB')
    ,(N'com', N'RSDESEMB02')
    ,(N'com', N'RSDESEMP01')
    ,(N'com', N'RSDESEMP02')
    ,(N'com', N'RSDESEMPAS01')
    ,(N'com', N'RSEGASE01')
    ,(N'com', N'RSEGSECTOR001')
    ,(N'com', N'RSGESMOEF001')
    ,(N'com', N'RSGETCOM01')
    ,(N'com', N'RSHHCARB001')
    ,(N'com', N'RSIMR01')
    ,(N'com', N'RSLISTCCN01')
    ,(N'com', N'RSMONEFE01')
    ,(N'com', N'RSMONEFE02')
    ,(N'com', N'RSMONEFE03')
    ,(N'com', N'RSMONEFE05')
    ,(N'com', N'RSMONEFER01')
    ,(N'com', N'RSMONEFER02')
    ,(N'com', N'RSMONEFER03')
    ,(N'com', N'RSMONEFEREPRO01')
    ,(N'com', N'RSMONEFETRC01')
    ,(N'com', N'RSMONRENT01')
    ,(N'com', N'RSPANSUP001')
    ,(N'com', N'RSPANSUP002')
    ,(N'com', N'RSPANSUP003')
    ,(N'com', N'RSPANSUP004')
    ,(N'com', N'RSPANSUP005')
    ,(N'com', N'RSPROYCOLDES001')
    ,(N'com', N'RSPROYCOLDES002')
    ,(N'com', N'RSPROYCOLDES003')
    ,(N'com', N'RSPROYCOLDES004')
    ,(N'com', N'RSPROYCOLDES005')
    ,(N'com', N'RSPROYCOLDES006')
    ,(N'com', N'RSPROYCOLDES007')
    ,(N'com', N'RSPROYCOLDES008')
    ,(N'com', N'RSPROYCOLDES009')
    ,(N'com', N'RSPROYCOLDES010')
    ,(N'com', N'RSRANKCOM01')
    ,(N'com', N'RSRDFCA007')
    ,(N'com', N'RSRDFCA011')
    ,(N'com', N'RSRDFCA021')
    ,(N'com', N'RSRDFCA022')
    ,(N'com', N'RSRDFCA023')
    ,(N'com', N'RSRDFCA024')
    ,(N'com', N'RSRDFCA025')
    ,(N'com', N'RSRDFCA026')
    ,(N'com', N'RSRDFCA027')
    ,(N'com', N'RSRDFCA028')
    ,(N'com', N'RSRDFCA029')
    ,(N'com', N'RSRDFCA030')
    ,(N'com', N'RSRDFCA031')
    ,(N'com', N'RSRDFCA032')
    ,(N'com', N'RSRDFCA035')
    ,(N'com', N'RSRDFCA036')
    ,(N'com', N'RSRDFCA037')
    ,(N'com', N'RSRDFCA038')
    ,(N'com', N'RSRDFCA050')
    ,(N'com', N'RSRDFCA050_3')
    ,(N'com', N'RSRDFCA050_4')
    ,(N'com', N'RSRDMA023')
    ,(N'com', N'RSROPERA001')
    ,(N'com', N'RSROPERA002')
    ,(N'com', N'RSRPD001')
    ,(N'com', N'RSRSRV001')
    ,(N'com', N'RSRTOP001')
    ,(N'com', N'RSRTOPMIS001')
    ,(N'com', N'RSRTOPMIS002')
    ,(N'com', N'RSRTOPMIS003')
    ,(N'com', N'RSRTOPMIS004')
    ,(N'com', N'RSRTOPPOMIS001')
    ,(N'com', N'RSRTOPPOMIS002')
    ,(N'com', N'RSRTOPPOMIS003')
    ,(N'com', N'RSRTOPPOMIS004')
    ,(N'com', N'RSRTOPV001')
    ,(N'com', N'RSSALCAR01')
    ,(N'com', N'RSSALCAR02')
    ,(N'com', N'RSSALCAR03')
    ,(N'com', N'RSSALCARVIGE01')
    ,(N'com', N'RSSALCARVIGE02')
    ,(N'com', N'RSSEGPAS01')
    ,(N'com', N'RSSEGPAS02')
    ,(N'com', N'RSSEGPAS03')
    ,(N'com', N'RSSEGPAS04')
    ,(N'com', N'RSSEGPDM01')
    ,(N'com', N'RSTABCOMER')
    ,(N'com', N'RSTABCOMER02')
    ,(N'com', N'RTABDIGCOM01')
    ,(N'com', N'RTOPZCUO01')
    ,(N'dbo', N'REPORTE_DEMO')
    ,(N'rep', N'GSREVA01')
    ,(N'rep', N'RTABCUERES01')
;

DECLARE @resultado TABLE (
    sp_base sysname, sp_esquema sysname, sp_nombre sysname,
    ref_servidor sysname NULL, ref_base sysname NULL, ref_esquema sysname NULL,
    ref_entidad sysname NULL, ref_columna sysname NULL, ref_tipo nvarchar(60) NULL, ref_objeto_tipo nvarchar(60) NULL,
    es_lectura bit NULL, es_escritura bit NULL, es_select_todo bit NULL,
    origen varchar(30), error nvarchar(2000) NULL);

DECLARE @esquema sysname, @nombre sysname, @objeto nvarchar(520);
DECLARE c CURSOR LOCAL FAST_FORWARD FOR SELECT esquema, nombre FROM @catalogo;
OPEN c;
FETCH NEXT FROM c INTO @esquema, @nombre;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @objeto = QUOTENAME(@esquema) + N'.' + QUOTENAME(@nombre);
    IF OBJECT_ID(@objeto) IS NULL
        INSERT INTO @resultado (sp_base, sp_esquema, sp_nombre, origen, error)
        VALUES (DB_NAME(), @esquema, @nombre, 'catalogo', N'El SP no existe en esta base');
    ELSE
    BEGIN
        BEGIN TRY
            -- Nivel columna (misma base). Puede fallar si el SP referencia objetos inexistentes.
            INSERT INTO @resultado
            SELECT DB_NAME(), @esquema, @nombre,
                   r.referenced_server_name, ISNULL(r.referenced_database_name, DB_NAME()),
                   r.referenced_schema_name, r.referenced_entity_name, r.referenced_minor_name,
                   r.referenced_class_desc, o.type_desc, r.is_selected, r.is_updated, r.is_select_all,
                   'dm_sql_referenced_entities', NULL
            FROM sys.dm_sql_referenced_entities(@objeto, N'OBJECT') r
            LEFT JOIN sys.objects o ON o.object_id = r.referenced_id;  -- tipo real (tabla, vista, función…); NULL si es de otra base
        END TRY
        BEGIN CATCH
            INSERT INTO @resultado (sp_base, sp_esquema, sp_nombre, origen, error)
            VALUES (DB_NAME(), @esquema, @nombre, 'dm_sql_referenced_entities', ERROR_MESSAGE());
        END CATCH;

        -- Nivel tabla, nunca falla e incluye referencias a otras bases.
        INSERT INTO @resultado (sp_base, sp_esquema, sp_nombre, ref_servidor, ref_base, ref_esquema,
                                ref_entidad, ref_tipo, ref_objeto_tipo, origen)
        SELECT DB_NAME(), @esquema, @nombre, d.referenced_server_name,
               ISNULL(d.referenced_database_name, DB_NAME()), d.referenced_schema_name,
               d.referenced_entity_name, d.referenced_class_desc, o.type_desc, 'sql_expression_dependencies'
        FROM sys.sql_expression_dependencies d
        LEFT JOIN sys.objects o ON o.object_id = d.referenced_id
        WHERE d.referencing_id = OBJECT_ID(@objeto);
    END;
    FETCH NEXT FROM c INTO @esquema, @nombre;
END;
CLOSE c;
DEALLOCATE c;

SELECT sp_base, sp_esquema, sp_nombre, ref_servidor, ref_base, ref_esquema, ref_entidad,
       ref_columna, ref_tipo, ref_objeto_tipo, es_lectura, es_escritura, es_select_todo, origen, error
FROM @resultado
ORDER BY sp_esquema, sp_nombre, ref_base, ref_esquema, ref_entidad, ref_columna;
