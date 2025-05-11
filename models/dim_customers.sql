with customers as (

    select * from {{ ref('customer') }}
    -- select 
    -- C_CUSTKEY as customer_id,
    -- C_NAME as customer_name
    -- from 
    -- snowflake_sample_data.tpch_sf10.customer

),

orders as ( 

select * from {{ ref('orders') }}

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
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final