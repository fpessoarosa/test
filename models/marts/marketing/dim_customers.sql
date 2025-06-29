with customers as (
    select * from {{ ref ('stg_jaffle_shop__customers')}}
),
orders as (
    select * from {{ ref ('fct_orders')}}
),
customer_orders as (
    select
        orders.customer_id,
        count(distinct orders.order_id) as count_lifetime_orders,
        count(distinct orders.order_id) > 1 as is_repeat_buyer,
        min(orders.order_date) as first_order_date,
        max(orders.order_date) as last_order_date,
        sum(orders.o_totalprice) as lifetime_spend
    from orders
    group by 1    
),
 final as (
    select
        customers.customer_id,
        customers.customer_name,
        customer_orders.first_order_date,
        coalesce (customer_orders.count_lifetime_orders, 0) as number_of_orders,
        customer_orders.lifetime_spend
    from customers
    left join customer_orders using (customer_id)
)
select * from final