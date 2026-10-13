-- MOD-0001 · Activación: que el front muestre TAPP Mínima y Distancia (en pbs) en "Evolución de TAPP Mes"
--
-- El front (MIS-angular-front, Autonomía de Tasas › pestaña Evolutivo) NO se modifica: pide el reporte
-- GST_ACTIVAS_06 y dibuja las columnas que declara la cabecera del SP. Qué SP ejecuta cada RCODREP lo decide
-- el catálogo del backend, [mod_rep].[rep].[RREGREP01], en el campo RTPREP (mismo UPDATE que se usó para
-- GCOMCRE_02, ver el comentario al final de extraccion/procedimientos/mod_rep/com/GCOMCRE02.sql).
-- Este script cambia solo el nombre del SP de GST_ACTIVAS_06 y GST_ACTIVAS_M_06; los parámetros quedan iguales.
--
-- Antes de ejecutarlo: el paso 1 de 04-verificacion.sql debe decir "OK" y los pasos 2 a 4 deben cuadrar.
-- Si el paso 1 dice "YA APLICADO", el original ya muestra las columnas: NO ejecutar este script.
-- ESCRIBE en la base: lo ejecuta quien tenga permiso sobre el catálogo. Deja la transacción abierta: revisar el resultado y elegir COMMIT o ROLLBACK al final.
-- Volver atrás después del COMMIT: 05-rollback.sql.

USE mod_rep;
GO

IF OBJECT_ID(N'com.GDCGEST_ACTIVAST01_NEW', N'P') IS NULL
BEGIN
    RAISERROR('No existe com.GDCGEST_ACTIVAST01_NEW: ejecutar antes 03-GDCGEST_ACTIVAST01_NEW.create.sql.', 16, 1);
    SET NOEXEC ON;  -- no ejecuta nada más de este script
END;
GO

-- Antes: los dos deben apuntar a mod_rep.com.GDCGEST_ACTIVAST01.
SELECT RCODREP, RTPREP FROM rep.RREGREP01 WHERE RCODREP IN ('GST_ACTIVAS_06', 'GST_ACTIVAS_M_06');

BEGIN TRANSACTION;

-- Solo cambia el nombre del SP dentro de RTPREP: los parámetros y el resto del texto quedan como están.
UPDATE rep.RREGREP01
SET    RTPREP = REPLACE(RTPREP, '"mod_rep.com.GDCGEST_ACTIVAST01"', '"mod_rep.com.GDCGEST_ACTIVAST01_NEW"')
WHERE  RCODREP IN ('GST_ACTIVAS_06', 'GST_ACTIVAS_M_06')
  AND  CHARINDEX('"mod_rep.com.GDCGEST_ACTIVAST01"', RTPREP) > 0;   -- solo si siguen apuntando al original

-- Debe decir 2. Si dice 0, alguien ya los cambió: revisar el SELECT de "Antes".
SELECT @@ROWCOUNT AS filas_actualizadas;

-- Después: los dos deben apuntar a mod_rep.com.GDCGEST_ACTIVAST01_NEW; el resto de GST_ACTIVAS_* al original.
SELECT RCODREP, RTPREP FROM rep.RREGREP01 WHERE RCODREP LIKE 'GST[_]ACTIVAS[_]%' ORDER BY RCODREP;

-- Si está bien:   COMMIT TRANSACTION;
-- Si no:          ROLLBACK TRANSACTION;
--
-- Luego: abrir en el front Reportes › Actividad diaria › Cartera › Autonomía de Tasas › Evolutivo. La tabla
-- "Evolución de TAPP Mes (días hábiles)" muestra al final "TAPP Mínima" y "Distancia (en pbs)". Si el backend
-- guarda el catálogo en memoria, puede hacer falta reiniciarlo para que tome el cambio.
GO
SET NOEXEC OFF;
GO
