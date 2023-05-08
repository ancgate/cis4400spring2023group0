{{
  config(
    materialized='table'
  )
}}

WITH project_cte AS (
 SELECT 
ProjectCity,
ProjectCountyName,
ProjectState,
ProjectZip,
CD
from DATA;
)

insert into dim_project (ProjectCity, ProjectCountyName, ProjectState, ProjectZip, CD)
select DISTINCT ProjectCity, ProjectCountyName, ProjectState, ProjectZip, CD 
FROM project_cte 