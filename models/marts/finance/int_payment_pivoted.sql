{% set payment_methods_query %}
select distinct payment_method from {{ ref("stg_stripe__payments")}}
order by 1
{% endset %}

{% set results = run_query(payment_methods_query) %}

{% if execute %}
{# Return the first column #}
{% set payments = results.columns[0].values() %}
{% else %}
{% set payments = [] %}
{% endif %}

{{log('Check all payment_method : '  ~ payments, info=True )}}

with payment_tmp as (
    select * from {{ ref("stg_stripe__payments")}}
),
pivoted as (
    select 
    payment_id,
    {% for payment in payments -%}
    sum( case payment_method when '{{ payment }}' then amount else 0 end ) {{payment}}_amount
    {% if not loop.last -%} , {% endif -%}
    {% endfor -%}
    from payment_tmp
    where status = 'success'
    group by 1
)
/*
pivoted as (
    select 
    payment_id,
    sum( case payment_method when 'bank_transfer' then amount else 0 end ) bank_transfer_amount,
    sum( case payment_method when 'credit_card' then amount else 0 end ) credit_card_amount,
    sum( case payment_method when 'coupon' then amount else 0 end ) coupon_amount,
    sum( case payment_method when 'gift_card' then amount else 0 end ) gift_card_amount
    from payment_tmp
    where status = 'success'
    group by 1
)
*/
select * from pivoted
