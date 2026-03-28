{% macro limpar_texto(coluna) %}
    upper(trim({{ coluna }}))
{% endmacro %}