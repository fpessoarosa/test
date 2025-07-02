{% set order_status -%}
select distinct O_ORDERSTATUS 
from {{ source('jaffle_shop', 'orders')}}
order by 1
{% endset -%}

{% set results = run_query(order_status) -%}

{% if execute -%}
{# Return the first column -#}
{% set order_status_list = results.columns[0].values() -%}
{% else -%}
{% set order_status_list = [] -%}
{% endif -%}

with orders as (
    select  
        O_ORDERKEY order_id,
        O_CUSTKEY customer_id,
        O_ORDERSTATUS,
        O_TOTALPRICE amount,
        O_ORDERDATE order_date,
        O_ORDERPRIORITY,
        O_CLERK,
        O_SHIPPRIORITY,
        O_COMMENT
    from {{ source('jaffle_shop', 'orders')}}
    /*where O_ORDERSTATUS not in('F')*/
),
daily as (
    select order_date, 
    count(1) orders_num,
    {% for order_status_tmp in order_status_list -%}
    sum( case O_ORDERSTATUS when '{{ order_status_tmp }}' then amount else 0 end ) {{order_status_tmp}}_amount
    {% if not loop.last -%} , {% endif -%}
    {% endfor -%}
    from orders 
    where O_ORDERSTATUS not in('F1')
    group by 1
),
compared  as(
    select *,
    lag(orders_num) over (order by order_date) as previous_day_orders
    from daily    
)
select * from compared