{% macro converter_brl_para_usd(coluna, taxa=5.0) %}
    round({{ coluna }} / {{ taxa }}, 2)
{% endmacro %}