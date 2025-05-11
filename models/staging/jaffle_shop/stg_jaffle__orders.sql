
    select 
    O_ORDERKEY as order_id,
    O_CUSTKEY as customer_id,
    O_ORDERDATE as order_date,
    O_ORDERSTATUS as status
    from 
    -- snowflake_sample_data.tpch_sf10.orders
    {{ source('jaffle_shop', 'orders') }}