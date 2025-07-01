select
    {{dbt_utils.generate_surrogate_key(['id', 'created'])}} as id_generate,
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    -- amount is stored in cents, convert it to dollars
    {{ cents_to_dolar('amount', 3)}} as amount,
    created as created_at,
    _BATCHED_AT 
from {{ source('stripe', 'payment')}}
{{limit_data_in_dev('_BATCHED_AT', 14)}}