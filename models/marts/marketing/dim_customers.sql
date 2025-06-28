with customers as (
    select * from {{ ref('stg_jaffle_shop__customers') }}
),
orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),
customer_orders_summary as (
    select
        orders.o_custkey as customer_id,
        count(distinct orders.o_orderkey) as count_lifetime_orders,
        count(distinct orders.o_orderkey) > 1 as is_repeat_buyer,
        min(orders.o_orderdate) as first_order_date,
        max(orders.o_orderdate) as last_order_date,
        sum(orders.o_totalprice) as lifetime_spend
    from orders
    group by 1
),
joined as (
    select
        customers.*,
        customer_orders_summary.count_lifetime_orders,
        customer_orders_summary.first_order_date,
        customer_orders_summary.last_order_date,
        customer_orders_summary.lifetime_spend,
        case
            when customer_orders_summary.is_repeat_buyer then 'returning'
            else 'new'
        end as customer_type
    from customers
    left join customer_orders_summary
        on customers.c_custkey = customer_orders_summary.customer_id
)

select * from joined
