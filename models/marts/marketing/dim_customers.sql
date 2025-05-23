{{
    config(
        materialized='table'
    )
}}
with customers as (
    select * from {{ ref('stg_jaffle__customer') }}
),

orders as (
    select * from {{ ref('stg_jaffle__orders') }}
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from orders
    group by 1
),
final as (
    select
        customers.customer_id,
        customers.customer_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0)
            as number_of_orders
    from customers
    left join
        customer_orders
        on customers.customer_id = customer_orders.customer_id
)

select * from final
