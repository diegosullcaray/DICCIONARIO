-- Dependencias según el motor: base mod_gpa · 2 procedimiento(s)
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera.
--
-- Qué devuelve: una fila por (SP, tabla, columna) que SQL Server tiene registrada.
-- Cómo se usa: ejecutar, "Guardar resultados como…" CSV CON encabezados en
--   extraccion/fuente/dependencias/mod_gpa.csv  y correr  npm run generar.
--
-- Límites del motor (ver skill dic-analisis-dependencias):
--   · Las columnas de tablas de OTRA base no se resuelven (ref_columna queda vacía):
--     para esas, manda el analizador estático.
--   · SQL dinámico (EXEC(@sql), sp_executesql) y tablas #temporales no aparecen.
--   · Si un SP no compila contra el esquema actual, `error` lo dice y se sigue con el resto.

USE mod_gpa;
GO
SET NOCOUNT ON;

DECLARE @catalogo TABLE (esquema sysname, nombre sysname);
INSERT INTO @catalogo (esquema, nombre) VALUES
     (N'vac', N'GRESEJE01')
    ,(N'vac', N'GRESEJE02')
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
