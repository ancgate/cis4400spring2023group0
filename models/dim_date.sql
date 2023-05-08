{{
  config(
    materialized='table'
  )
}}

WITH date_cte AS (
  SELECT DISTINCT DateApproved as date_value FROM DATA
  UNION
  SELECT DISTINCT LoanStatusDate as date_value  FROM DATA
  UNION 
  SELECT DISTINCT ForgivenessDate as date_value FROM DATA
)

insert into dim_date (iddate, datevalue, datestringformat, yearvalue, monthvalue, dayvalue, 
hourvalue, quartervalue, monthname, weekofyear, dayofweek, weekofthemonth )
SELECT
 {{ date_to_yymmdd('date_value') }} AS order_date_int
  date_value,
  {{ convert_date_to_iso('date_value') }} AS order_date_iso
  EXTRACT(year FROM date_value) AS year,
  EXTRACT(month FROM date_value) AS month,
  EXTRACT(day FROM date_value) AS day,
  EXTRACT(hour FROM date_value) AS hour,
  EXTRACT(quarter FROM date_value) AS quarter,
  TO_CHAR(date_value, 'Month') AS monthName,
  EXTRACT(isodow FROM date_value) AS dayofweek,
  FLOOR((EXTRACT(day FROM date_value) - 1) / 7) + 1 AS WeekofMonth,
FROM date_cte