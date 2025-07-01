with payment as (
    select * from {{ ref('stg_stripe__payments') }}
)
select order_id, sum(amount) total_amont
from payment
group by order_id
having total_amont < -10