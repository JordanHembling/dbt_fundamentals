{% macro limit_data_in_dev(column_name, days) %}
  {%- if target.name == 'default' -%}
  where {{ column_name }} >= dateadd('day', -{{ days }}, current_timestamp())
  {% endif -%}
{% endmacro %}