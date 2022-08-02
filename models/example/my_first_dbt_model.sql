{{ config(alias='first_model')}}

with source_data as (

    select 1 as id
    union all
    select 2 as id
    union all
    select 3 as id

)

select *
from source_data
--where id >= {{ var('my_third_variable') }}

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
