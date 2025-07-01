{#
{% for i in range(10) %}
  select {{ i }} as number {% if not loop.last %} union all {% endif %}
{% endfor %}

{% set my_cool_string = 'wow! cool!' %}
{{ my_cool_string }}


{% set my_animals = ["lemur", "wolf", "panther", "tardigrade"] %} 

{{ my_animals[1] }}

{% for animal in my_animals %}
    My favorite animal is the {{ animal }}
{% endfor %}

{% set temperature = 30 %}

{% if temperature <65 %}
    Time for cappuccino
{% else %}    
    Time for col d brew
{% endif %}

{% set foods = ['carrot', 'hotdog', 'cucumber', 'bell paper'] %}
{% for food in foods %}
    {% if food == 'hotdog' %}
        {% set food_type = 'snack' %}
    {%else%}
        {% set food_type = 'vegetable' %}
    {% endif %}
    The humble {{ food }} is my favorite {{ food_type }}
{% endfor %}


{%- set foods = ['carrot', 'hotdog', 'cucumber', 'bell paper'] -%}
{% for food in foods -%}
    {%- if food == 'hotdog' -%}
        {%- set food_type = 'snack' -%}
    {%- else -%}
        {%- set food_type = 'vegetable' -%}
    {%- endif -%}
    The humble {{ food }} is my favorite {{ food_type }}
{% endfor %}
#}

{% set websters_dict = {
    'word' : 'data',
    'speech_part': 'noun',
    'definition': 'if you know you know'
} -%}
{% websters_dict['word'] %}