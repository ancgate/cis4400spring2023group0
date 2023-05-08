{% macro convert_date_to_iso(date_string) %}
  SELECT
    TO_DATE({{ date_string }}, 'MM/DD/YYYY') AS date_iso
{% endmacro %}