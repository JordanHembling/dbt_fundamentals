with 

source as (
    select * from {{ source('stripe', 'payment')}}
),

transformed as (

    select
        id as payment_id,
        orderid as order_id, 
        paymentmethod as payment_method,
        status as payment_status, 
        created as created_at,
        {{ cents_to_dollars('amount') }} as payment_amount
    
    from source
)

select * from transformed
{{ limit_data_in_dev('created_at', 13) }}

