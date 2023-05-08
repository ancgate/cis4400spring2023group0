{% macro date_to_yyyy_mm_dd(date_string, date_format) %}
  SELECT
    TO_CHAR(TO_DATE({{ date_string }}, {{ date_format }}), 'YYYY-MM-DD') AS date_yyyy_mm_dd
{% endmacro %}