select distinct
  lower(regexp_replace(regexp_replace(trim(tms_type_desc), '([^A-Za-z0-9 //_-])', ''), '((( )+)|-|(\/))+', '_')) as syn,
  tms_type_code as code
from CDW.d_tms_type_mv
where tms_view_name = '##tms##'
and tms_type_desc not like '*%'
