{% macro limit_data_in_dev(field, day_back = 3) -%}
{% if target.name != 'dev' -%}
where {{field}} between dateadd('day', -{{day_back}}, current_timestamp ) and current_timestamp
{% endif -%}    
{% endmacro -%}
{#where {{field}} >= dateadd('day', -{{day_back}}, current_timestamp )#}

{%- macro col_target() -%}
{{target.name}} 
{%- endmacro -%}