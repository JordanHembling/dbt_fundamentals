with source as (
    select * from {{ source('covid_19', 'jhu_vaccines') }}
),

transformed as (

    select 
        *
    from source

)

select * from transformed