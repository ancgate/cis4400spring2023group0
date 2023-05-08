{{
  config(
    materialized='table'
  )
}}

WITH naics_cte AS (
 SELECT 
    NAICSCode
from DATA;
);

INSERT INTO dim_naics (NAICSKEY, CODE)
select DISTINCT {{ convert_string_to_int('NAICSCode') }} , NAICSCode
FROM naics_cte
