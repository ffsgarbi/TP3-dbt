{% test accepted_values_threshold(model, column_name, accepted_list, max_violations) %}

    SELECT *
    FROM (
        SELECT COUNT(*) AS qtd_violacoes
        FROM {{ model }}
        WHERE {{ column_name }} NOT IN ({% for v in accepted_list %}'{{ v }}'{% if not loop.last %}, {% endif %}{% endfor %})
    )
    WHERE qtd_violacoes > {{ max_violations }}

{% endtest %}