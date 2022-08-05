with source_data as (

    select 1 as id, 'TX' as state, 'red' as color
    union all
    select 2 as id, 'CO' as state, 'blue' as color
    union all
    select 3 as id, 'VT' as state, 'red' as color 
    union all
    select 4 as id, 'WA' as state, 'blue' as color
)

select *
from source_data