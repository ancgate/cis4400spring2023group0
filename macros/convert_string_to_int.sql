{% macro convert_string_to_int(string) %}
  SELECT
    CAST({{ string }} AS INTEGER) AS integer
{% endmacro %}