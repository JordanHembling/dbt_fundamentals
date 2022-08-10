 {%- call statement('list_payment_method', fetch_result=True) -%}
    select distinct payment_method from {{ ref('stg_stripe_payments') }}
{%- endcall -%}
 
 {%- set payment_methods = load_result('list_payment_method')['data'] -%}

with payments as (
    select * from {{ ref('stg_stripe_payments') }}
),

pivoted as (
    select
        order_id,
        {% for method in payment_methods -%}
            sum(case when payment_method = '{{method[0]}}' then payment_amount else 0 end) as {{method[0]}}_amount
        {%- if not loop.last %}
        ,
        {%- endif -%}
        {% endfor %}
    from payments
    where payment_status = 'success'
    group by 1
)

select * from pivoted