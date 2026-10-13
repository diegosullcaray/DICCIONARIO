-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 12:47:00.700000
CREATE procedure com.REXPAGRO01 
@col int,
@val varchar(100)
as 

declare @sql varchar(max)
declare @col_ varchar(20)

set @col_ = case @col when 0 then 'HCODUBI' when 1 then 'HDESDEP' when 2 then 'HDESPROV' when 3 then 'HDESDIS' end

set @sql='
select 
HCODUBI cod_ubi,
HDESDEP des_dep,
HDESPROV des_prov,
HDESDIS des_dist,
HEXPMAS exp_mas,
HEXPINU exp_inu,
HEXPSEQ exp_seq,
HEXPPRE exp_pre
from storage.com_act.HARE001
where '+@col_+' like ''%'+@val+'%''
'

select '' dummy

exec(@sql)
