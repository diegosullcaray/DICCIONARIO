-- MOD-0003 · Activación: registra el reporte TAB_SEG_01 (tablero de seguimiento) en el catálogo del backend.
-- Antes: 03-RTABSEG01.create.sql ejecutado y los pasos 1 a 3 de 04-verificacion.sql en verde.
-- ESCRIBE en la base: lo ejecuta quien tenga permiso. Deja la transacción abierta.
-- Inserta solo RCODREP, RDESREP y RTPREP (02-analisis.md §5): si RREGREP01 exige más columnas, completarlas.

USE mod_rep;
GO

IF OBJECT_ID(N'com.RTABSEG01', N'P') IS NULL
BEGIN
    RAISERROR('No existe com.RTABSEG01: ejecutar antes 03-RTABSEG01.create.sql.', 16, 1);
    SET NOEXEC ON;  -- no ejecuta nada más de este script
END;
GO

-- Antes: TAB_SEG_01 no debe aparecer; RS_TAB_COM_01 muestra la forma de RTPREP de un tablero hermano.
SELECT RCODREP, RTPREP FROM rep.RREGREP01 WHERE RCODREP IN ('TAB_SEG_01', 'RS_TAB_COM_01');

BEGIN TRANSACTION;

IF NOT EXISTS (SELECT 1 FROM rep.RREGREP01 WHERE RCODREP = 'TAB_SEG_01')
    INSERT INTO rep.RREGREP01 (RCODREP, RDESREP, RTPREP)
    VALUES ('TAB_SEG_01', 'Tablero de Seguimiento',
        N'{"name":"mod_rep.com.RTABSEG01","params":[{"order":1,"name":"tip_cod"},{"order":2,"name":"cod_rel"},{"order":3,"name":"fec"}]}');

-- Debe decir 1. Si dice 0, ya estaba registrado.
SELECT @@ROWCOUNT AS filas_insertadas;

SELECT RCODREP, RTPREP FROM rep.RREGREP01 WHERE RCODREP = 'TAB_SEG_01';

-- Si está bien:   COMMIT TRANSACTION;
-- Si no:          ROLLBACK TRANSACTION;
GO
SET NOEXEC OFF;
GO
