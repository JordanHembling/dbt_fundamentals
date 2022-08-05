with source as (
    select * from {{ source('public', 'jhu_vaccines') }}
),

transformed as (

    select 
        *
    from source

)

select * from transformed