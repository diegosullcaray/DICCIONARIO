/* ============================================================================
   TABLERO DE SEGUIMIENTO — v0.3 / SQL Server 2017
   07. SP de reporte: mod_rep.com.RTABSEG01 (no ejecutado)

   Resultset del tablero para una entidad, como los reportes MIS (RSTABCOMER):
   dada una fecha, un nivel (@tip_cod) y una entidad (@cod_rel), devuelve una
   fila con todo lo que muestran las tarjetas Cartera, Desembolsos,
   Recuperaciones y Mora, Clientes, Digital y Seguros.

   Lee las tablas cargadas por PSLHTABSEG001/PSLHTABSEG002 (03_tablas_destino.sql);
   no recalcula fuentes. Las comparaciones toman lo registrado en el cierre
   anterior t−1 (cie_ant), sin reconstruirlo (consideraciones §3.3). Metas de
   stock = valor de t−1 + meta de variación. Total de salidas y ratios se
   derivan aquí.

   Convenciones del resultset:
     Ratios como fracción (0,1912 = 19,12 %); el formato visual es del front.
     Variaciones de ratios en puntos porcentuales (_var_pp, diferencia × 100);
     de tasas en puntos básicos (_var_pbs, diferencia × 10 000).
     Sufijo _ant: valor registrado en t−1; _var: t − t−1. Sin fila de t−1
     (ind_cierre_ant = 0) los comparativos quedan NULL.
     Seguros pendiente (ind_seg_pendiente = 1): bloque NULL, no cero.
     Cartera y desembolsos se publican en base (la entidad hoy, incluidos sus
     heredados); _aju/_net = población ajustada (base + trasladado − heredado).

   La descripción de la entidad no se devuelve: la toma el tablero del
   componente que maneja la jerarquía.

   Niveles: 1 asesor, 17 coordinación, 18 unidad, 19 corredor, 20 territorio,
   7 financiera ('231'). Errores: 51400 corte no cargado, 51401 entidad sin fila
   en el corte, 51402 nivel inválido.
   ============================================================================ */

USE [mod_rep];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

/*
EXEC mod_rep.com.RTABSEG01 7, '231', '20261014';       -- financiera
EXEC mod_rep.com.RTABSEG01 1, 'ABC123', '20261014';    -- asesor
EXEC mod_rep.com.RTABSEG01 18, '45', NULL;             -- unidad, corte de ayer
*/
CREATE OR ALTER PROCEDURE com.RTABSEG01
    @tip_cod int,
    @cod_rel varchar(30),
    @fec date = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- ------------------------------------------------------------------------
    -- 1. Corte, cierre anterior y entidad
    -- ------------------------------------------------------------------------
    -- Misma resolución que la carga: NULL parte de ayer; el corte es el último
    -- hábil <= referencia y t−1 el cierre del mes anterior.
    DECLARE
        @Referencia date = ISNULL(@fec, CONVERT(date, DATEADD(day, -1, GETDATE()))),
        @Corte date,
        @Anterior date,
        @Codigo varchar(30) = LTRIM(RTRIM(ISNULL(@cod_rel, '')));

    IF @tip_cod NOT IN (1, 17, 18, 19, 20, 7)
        THROW 51402, 'Nivel inválido: usar 1, 17, 18, 19, 20 o 7.', 1;

    IF @tip_cod = 7
        SET @Codigo = '231';

    SELECT
        @Corte = MAX(CASE WHEN RORD = 1 THEN RFEC END),
        @Anterior = MAX(CASE WHEN RORD = 2 THEN RFEC END)
    FROM storage.util.FVECFEC01(@Referencia, 'hoy,cie_ant');

    IF NOT EXISTS (
        SELECT 1
        FROM storage.com_act.HTABSEG001
        WHERE HFECPRO = @Corte
            AND HTIPCOD = 7
    )
        THROW 51400, 'Corte no cargado en HTABSEG001: ejecutar antes PSLHTABSEG001.', 1;

    IF NOT EXISTS (
        SELECT 1
        FROM storage.com_act.HTABSEG001
        WHERE HFECPRO = @Corte
            AND HTIPCOD = @tip_cod
            AND HCODREL = @Codigo
    )
        THROW 51401, 'La entidad no tiene fila en el corte (sin cartera ni movimientos).', 1;

    -- ------------------------------------------------------------------------
    -- 2. Resultset: una fila por entidad
    -- ------------------------------------------------------------------------
    -- B base de t, A base registrada en t−1, T trasladados y H heredados de t.
    -- R calcula una vez los ratios que se comparan con t−1.
    SELECT
        -- Encabezado
        B.HFECPRO AS fec_corte,
        @Anterior AS fec_cierre_ant,
        B.HTIPCOD AS tip_cod,
        B.HCODREL AS cod_rel,
        CAST(CASE WHEN A.HFECPRO IS NULL THEN 0 ELSE 1 END AS bit) AS ind_cierre_ant,
        CAST(CASE WHEN B.HNUMPLZ IS NULL THEN 1 ELSE 0 END AS bit) AS ind_seg_pendiente,
        B.HDIAHABAVA AS dias_hab_ava,
        B.HDIAHABTOT AS dias_hab_tot,
        CAST(B.HDIAHABAVA AS decimal(19,10)) / NULLIF(B.HDIAHABTOT, 0) AS dias_hab_por,

        -- Cartera: saldo vigente (barra), con propia/heredada/trasladada y meta
        B.HSALCIEVIG AS car_sal_vig,
        B.HSALCIEVIG - ISNULL(H.HSALCIEVIG, 0) AS car_sal_vig_pro,
        ISNULL(H.HSALCIEVIG, 0) AS car_sal_vig_her,
        ISNULL(T.HSALCIEVIG, 0) AS car_sal_vig_tra,
        A.HSALCIEVIG AS car_sal_vig_ant,
        B.HSALCIEVIG + ISNULL(T.HSALCIEVIG, 0) - ISNULL(H.HSALCIEVIG, 0) AS car_sal_vig_aju,
        B.HMETVARVIG AS car_met_var_vig,
        A.HSALCIEVIG + B.HMETVARVIG AS car_met_sal_vig,
        A.HSALCIEVIG + B.HMETVARVIG - B.HSALCIEVIG AS car_fal_sal_vig,
        -- Operaciones de stock (barra); propia = base sin claves heredadas
        B.HOPECAR AS car_ope,
        B.HOPECARPRO AS car_ope_pro,
        ISNULL(H.HOPECAR, 0) AS car_ope_her,
        ISNULL(T.HOPECAR, 0) AS car_ope_tra,
        A.HOPECAR AS car_ope_ant,
        B.HOPECARNET AS car_ope_aju,
        -- Saldo total, ajustado y crecimiento neto (CAR18/CAR19)
        B.HSALCIE AS car_sal_tot,
        A.HSALCIE AS car_sal_tot_ant,
        R.CarSalAju AS car_sal_tot_aju,
        R.CarSalAju - A.HSALCIE AS car_var_net,
        (R.CarSalAju - A.HSALCIE) / NULLIF(A.HSALCIE, 0) AS car_cre_net,
        -- Saldo medio y TAPP stock
        B.HSALMEDTOT AS car_sal_med_tot,
        A.HSALMEDTOT AS car_sal_med_tot_ant,
        B.HSALMEDTOT - A.HSALMEDTOT AS car_sal_med_tot_var,
        B.HSALMEDVIG AS car_sal_med_vig,
        A.HSALMEDVIG AS car_sal_med_vig_ant,
        B.HSALMEDVIG - A.HSALMEDVIG AS car_sal_med_vig_var,
        B.HTASSTKTOT AS car_tas_stk_tot,
        A.HTASSTKTOT AS car_tas_stk_tot_ant,
        (B.HTASSTKTOT - A.HTASSTKTOT) * 10000 AS car_tas_stk_tot_var_pbs,
        B.HTASSTKVIG AS car_tas_stk_vig,
        A.HTASSTKVIG AS car_tas_stk_vig_ant,
        (B.HTASSTKVIG - A.HTASSTKVIG) * 10000 AS car_tas_stk_vig_var_pbs,
        B.HTASSTKTOTNET AS car_tas_stk_tot_net,
        B.HTASSTKVIGNET AS car_tas_stk_vig_net,

        -- Desembolsos: operaciones, productividad y meta (8070)
        B.HOPEDES AS des_ope,
        B.HASEDES AS des_ase,
        R.DesPro AS des_pro,
        B.HMETPRO AS des_met_pro,
        R.DesPro / NULLIF(B.HMETPRO, 0) AS des_ava_pro,
        -- Monto, ticket y tasas (meta de monto diferida: DIF02)
        B.HSALDES AS des_mon,
        CASE WHEN B.HOPEDES = 0 THEN 0 ELSE B.HSALDES / B.HOPEDES END AS des_tic,
        B.HTASDES AS des_tas,
        B.HTASMIN AS des_tas_min,
        -- Población ajustada
        B.HOPEDESNET AS des_ope_net,
        B.HASEDESNET AS des_ase_net,
        R.DesMonNet AS des_mon_net,
        CASE WHEN B.HOPEDESNET = 0 THEN 0 ELSE R.DesMonNet / B.HOPEDESNET END AS des_tic_net,
        B.HTASDESNET AS des_tas_net,
        B.HTASMINNET AS des_tas_min_net,

        -- Recuperación programada/efectiva: sin cartera de inicio y sin
        -- programación = 100 %; programación 0 con cartera de inicio: NULL (V01)
        B.HSALRECPRO AS rec_sal_pro,
        B.HSALRECEFE AS rec_sal_efe,
        CASE
            WHEN B.HSALRECPRO = 0 THEN CASE WHEN B.HINDSININI = 1 THEN 1 END
            ELSE B.HSALRECEFE / B.HSALRECPRO
        END AS rec_por_sal,
        B.HOPERECPRO AS rec_ope_pro,
        B.HOPERECEFE AS rec_ope_efe,
        CASE
            WHEN B.HOPERECPRO = 0 THEN CASE WHEN B.HINDSININI = 1 THEN 1 END
            ELSE CAST(B.HOPERECEFE AS decimal(28,10)) / B.HOPERECPRO
        END AS rec_por_ope,
        -- Efectividades y metas en la escala de la fuente (126/122/124)
        B.HEFETRAUNO AS rec_efe_uno,
        B.HMETEFEUNO AS rec_met_efe_uno,
        B.HEFETRADOS AS rec_efe_dos,
        B.HMETEFEDOS AS rec_met_efe_dos,
        B.HEFETRATRE AS rec_efe_tre,
        B.HMETEFETRE AS rec_met_efe_tre,
        -- Mora: base t frente a base t−1, sin netear traslados
        B.HCLIMOR AS rec_cli_mor,
        A.HCLIMOR AS rec_cli_mor_ant,
        B.HCLIMOR - A.HCLIMOR AS rec_cli_mor_var,
        B.HSALMOR AS rec_sal_mor,
        A.HSALMOR AS rec_sal_mor_ant,
        B.HSALMOR - A.HSALMOR AS rec_sal_mor_var,
        B.HOPEINGMOR AS rec_ope_ing_mor,
        B.HSALINGMOR AS rec_sal_ing_mor,
        -- Salidas del mes (titular a la salida) y su total
        B.HOPECAS AS sal_ope_cas,
        B.HSALCAS AS sal_sal_cas,
        B.HOPEVTA AS sal_ope_vta,
        B.HSALVTA AS sal_sal_vta,
        B.HOPECANPRE AS sal_ope_can_pre,
        B.HSALCANPRE AS sal_sal_can_pre,
        B.HOPECANCON AS sal_ope_can_con,
        B.HSALCANCON AS sal_sal_can_con,
        B.HOPECAS + B.HOPEVTA + B.HOPECANPRE + B.HOPECANCON AS sal_ope_tot,
        B.HSALCAS + B.HSALVTA + B.HSALCANPRE + B.HSALCANCON AS sal_sal_tot,

        -- Clientes: stock y movimiento del mes
        B.HCLICAR AS cli_car,
        A.HCLICAR AS cli_car_ant,
        B.HCLIING AS cli_ing,
        B.HCLISAL AS cli_sal,
        ISNULL(H.HCLICAR, 0) AS cli_her,
        ISNULL(T.HCLICAR, 0) AS cli_tra,
        B.HCLICARNET AS cli_car_aju,
        R.CliCreNet AS cli_cre_net,
        -- Meta de variación (10062), meta de stock, avance y faltante
        B.HMETVARCLI AS cli_met_var,
        A.HCLICAR + B.HMETVARCLI AS cli_met_car,
        R.CliCreNet / NULLIF(B.HMETVARCLI, 0) AS cli_ava_met,
        B.HMETVARCLI - R.CliCreNet AS cli_fal_met,
        -- Nuevos, bancarizados y retención
        B.HCLINUE AS cli_nue,
        A.HCLINUE AS cli_nue_ant,
        B.HCLINUE - A.HCLINUE AS cli_nue_var,
        B.HCLIBAN AS cli_ban,
        A.HCLIBAN AS cli_ban_ant,
        B.HCLIBAN - A.HCLIBAN AS cli_ban_var,
        B.HCLIRETINI AS cli_ret_ini,
        B.HCLIRETFIN AS cli_ret_fin,
        R.Ret AS cli_ret,
        R.RetAnt AS cli_ret_ant,
        (R.Ret - R.RetAnt) * 100 AS cli_ret_var_pp,
        1 - R.Ret AS cli_churn,

        -- Digital: enrolamiento (sin meta)
        B.HCLIENR AS dig_enr,
        A.HCLIENR AS dig_enr_ant,
        B.HCLIENR - A.HCLIENR AS dig_enr_var,
        R.PorEnr AS dig_por_enr,
        R.PorEnrAnt AS dig_por_enr_ant,
        (R.PorEnr - R.PorEnrAnt) * 100 AS dig_por_enr_var_pp,
        -- Transaccionales y usabilidad sobre enrolados / sobre cartera, con
        -- cumplimiento y semáforo de RSTABCOMER (1 verde, 0 ámbar, −1 rojo)
        B.HCLITRX AS dig_trx,
        A.HCLITRX AS dig_trx_ant,
        B.HCLITRX - A.HCLITRX AS dig_trx_var,
        R.UsaEnr AS dig_usa_enr,
        R.UsaEnrAnt AS dig_usa_enr_ant,
        (R.UsaEnr - R.UsaEnrAnt) * 100 AS dig_usa_enr_var_pp,
        B.HMETTRXENR AS dig_met_usa_enr,
        R.CumUsaEnr AS dig_cum_usa_enr,
        CASE WHEN R.CumUsaEnr >= 1 THEN 1 WHEN R.CumUsaEnr < 0.9 THEN -1 ELSE 0 END AS dig_sem_usa_enr,
        R.UsaCar AS dig_usa_car,
        R.UsaCarAnt AS dig_usa_car_ant,
        (R.UsaCar - R.UsaCarAnt) * 100 AS dig_usa_car_var_pp,
        B.HMETTRXCAR AS dig_met_usa_car,
        R.CumUsaCar AS dig_cum_usa_car,
        CASE WHEN R.CumUsaCar >= 1 THEN 1 WHEN R.CumUsaCar < 0.9 THEN -1 ELSE 0 END AS dig_sem_usa_car,
        -- Nuevos enrolados, monetarios, pago digital y transacciones
        B.HCLIENRNUE AS dig_enr_nue,
        A.HCLIENRNUE AS dig_enr_nue_ant,
        B.HCLIENRNUE - A.HCLIENRNUE AS dig_enr_nue_var,
        CASE WHEN B.HCLICAR = 0 THEN 0 ELSE CAST(B.HCLIENRNUE AS decimal(28,10)) / B.HCLICAR END AS dig_por_enr_nue,
        B.HCLITRXMON AS dig_trx_mon,
        A.HCLITRXMON AS dig_trx_mon_ant,
        B.HCLITRXMON - A.HCLITRXMON AS dig_trx_mon_var,
        CASE WHEN B.HCLIENR = 0 THEN 0 ELSE CAST(B.HCLITRXMON AS decimal(28,10)) / B.HCLIENR END AS dig_por_trx_mon,
        B.HCLIPAGDIG AS dig_pag_dig,
        A.HCLIPAGDIG AS dig_pag_dig_ant,
        B.HCLIPAGDIG - A.HCLIPAGDIG AS dig_pag_dig_var,
        CASE WHEN B.HCLICAR = 0 THEN 0 ELSE CAST(B.HCLIPAGDIG AS decimal(28,10)) / B.HCLICAR END AS dig_por_pag_dig,
        B.HNUMTRXMON AS dig_num_trx_mon,
        CASE WHEN B.HCLITRXMON = 0 THEN 0 ELSE CAST(B.HNUMTRXMON AS decimal(28,10)) / B.HCLITRXMON END AS dig_trx_mon_cli,

        -- Seguros optativos (NULL mientras ind_seg_pendiente = 1). Ingresos y
        -- ticket prima diferidos (DIF01): no se publican.
        B.HNUMPLZ AS seg_plz,
        B.HMETPLZ AS seg_met_plz,
        B.HNUMPLZ / NULLIF(B.HMETPLZ, 0) AS seg_ava_plz,
        B.HPLZMUL AS seg_plz_mul,
        B.HPLZPCU AS seg_plz_pcu,
        B.HPLZVID AS seg_plz_vid,
        B.HPLZONC AS seg_plz_onc,
        B.HPLZAGR AS seg_plz_agr,
        B.HPLZPTO AS seg_plz_pto,
        B.HOPEDESSEG AS seg_ope_des_seg,
        CAST(B.HOPEDESSEG AS decimal(28,10)) / NULLIF(B.HOPEDES, 0) AS seg_pen,
        B.HASESINVTA AS seg_ase_sin_vta
    FROM storage.com_act.HTABSEG001 B
    LEFT JOIN storage.com_act.HTABSEG001 A
        ON A.HFECPRO = @Anterior
        AND A.HTIPCOD = B.HTIPCOD
        AND A.HCODREL = B.HCODREL
    LEFT JOIN storage.com_act.HTABSEG002 T
        ON T.HFECPRO = B.HFECPRO
        AND T.HTIPCOD = B.HTIPCOD
        AND T.HCODREL = B.HCODREL
    LEFT JOIN storage.com_act.HTABSEG003 H
        ON H.HFECPRO = B.HFECPRO
        AND H.HTIPCOD = B.HTIPCOD
        AND H.HCODREL = B.HCODREL
    CROSS APPLY (
        SELECT
            -- Saldo total ajustado y monto neto de desembolsos (aditivos)
            B.HSALCIE + ISNULL(T.HSALCIE, 0) - ISNULL(H.HSALCIE, 0) AS CarSalAju,
            B.HSALDES + ISNULL(T.HSALDES, 0) - ISNULL(H.HSALDES, 0) AS DesMonNet,
            -- Productividad: el asesor se mide por operaciones; arriba, por asesor
            CAST(
                CASE
                    WHEN B.HTIPCOD = 1 THEN B.HOPEDES
                    WHEN B.HASEDES = 0 THEN 0
                    ELSE CAST(B.HOPEDES AS decimal(28,10)) / B.HASEDES
                END AS decimal(28,10)
            ) AS DesPro,
            -- Crecimiento neto de clientes: ajustada de t − stock registrado en t−1
            B.HCLICARNET - A.HCLICAR AS CliCreNet,
            -- Retención: sin cohorte y sin cartera de inicio = 100 %
            CASE
                WHEN B.HCLIRETINI = 0 THEN CASE WHEN B.HINDSININI = 1 THEN CAST(1 AS decimal(28,10)) END
                ELSE CAST(B.HCLIRETFIN AS decimal(28,10)) / B.HCLIRETINI
            END AS Ret,
            CASE
                WHEN A.HCLIRETINI = 0 THEN CASE WHEN A.HINDSININI = 1 THEN CAST(1 AS decimal(28,10)) END
                ELSE CAST(A.HCLIRETFIN AS decimal(28,10)) / A.HCLIRETINI
            END AS RetAnt,
            -- Digital: denominador cero = 0, como RSTABCOMER
            CASE WHEN B.HCLICAR = 0 THEN 0 ELSE CAST(B.HCLIENR AS decimal(28,10)) / B.HCLICAR END AS PorEnr,
            CASE WHEN A.HCLICAR = 0 THEN 0 ELSE CAST(A.HCLIENR AS decimal(28,10)) / A.HCLICAR END AS PorEnrAnt,
            CASE WHEN B.HCLIENR = 0 THEN 0 ELSE CAST(B.HCLITRX AS decimal(28,10)) / B.HCLIENR END AS UsaEnr,
            CASE WHEN A.HCLIENR = 0 THEN 0 ELSE CAST(A.HCLITRX AS decimal(28,10)) / A.HCLIENR END AS UsaEnrAnt,
            CASE WHEN B.HCLICAR = 0 THEN 0 ELSE CAST(B.HCLITRX AS decimal(28,10)) / B.HCLICAR END AS UsaCar,
            CASE WHEN A.HCLICAR = 0 THEN 0 ELSE CAST(A.HCLITRX AS decimal(28,10)) / A.HCLICAR END AS UsaCarAnt
    ) R0
    CROSS APPLY (
        SELECT
            R0.*,
            CASE WHEN ISNULL(B.HMETTRXENR, 0) = 0 THEN 0 ELSE R0.UsaEnr / B.HMETTRXENR END AS CumUsaEnr,
            CASE WHEN ISNULL(B.HMETTRXCAR, 0) = 0 THEN 0 ELSE R0.UsaCar / B.HMETTRXCAR END AS CumUsaCar
    ) R
    WHERE B.HFECPRO = @Corte
        AND B.HTIPCOD = @tip_cod
        AND B.HCODREL = @Codigo;
END;
GO
