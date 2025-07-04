with source as (
    select * from {{ source('stripe', 'payment') }}    
),
transformed as (
    select 
    id as payment_id,
    status as payment_status,
    orderid as order_id,
    {{ cents_to_dolar('amount', 3)}} as payment_amount,
    from source
)

select * from transformed