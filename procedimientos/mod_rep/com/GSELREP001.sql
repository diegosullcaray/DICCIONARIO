--exec com.GSELREP001  
CREATE PROCEDURE [com].[GSELREP001] AS BEGIN
SET
    NOCOUNT ON;

SET
    NOCOUNT ON;

exec mod_rep.rep.[FTHEACOLS01] 'SEL_EFEC_01';

with cte_e as(
    select
        distinct HFCRES
    from
        storage.[com_act].[WCED001]
    where
        HFCRES is not null
),
cte_r as(
    select
        ROW_NUMBER() over(
            order by
                HFCRES
        ) row,
        *
    from
        cte_e
),
cte_f as (
    select
        0 a,
        cast('TODO' as varchar(250)) r
    UNION
    select
        999999,
        cast('VACÍO' as varchar(250)) r
    UNION
    select
        row + 1,
        HFCRES
    from
        cte_r
)
select
    r id,
    r [desc]
from
    cte_f
order by
    a
END
