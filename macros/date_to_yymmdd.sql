{% macro date_to_yymmdd(date) %}
  SELECT
    CAST(TO_CHAR({{ date }}, 'YYMMDD') AS INTEGER) AS date_int
{% endmacro %}