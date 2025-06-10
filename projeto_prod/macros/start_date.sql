{% macro get_start_date() %}

    {% if not execute %}{{return('')}}{% endif %}

    {% set python_date = modules.datetime.date.fromisoformat %}
    {% set date = modules.datetime.date %}
    {% set timedelta = modules.datetime.timedelta %}

    {# Se nao for passado nada vai para o comeco do mes de ontem #}
    {% set ontem = date.today() - timedelta(days=1) %}
    {% set start_date_default = date(ontem.year, ontem.month, 1).strftime('%Y-%m-%d') %}

    {% set start_date_input = var('start_date', start_date_default) %}

    {{ return(start_date_input) }}

{% endmacro %}