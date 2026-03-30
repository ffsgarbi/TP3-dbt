{% macro real_dolar(coluna, taxa=5.0) %}
    round(({{ coluna }}) / {{ taxa }}, 2)
{% endmacro %}