with no_of_orders as (
    select * from {{ ref('stg_jaffle__orders') }}
)
select customer_id, sum(1) as count_of_orders
from no_of_orders
group by customer_id
having count_of_orders <= 0