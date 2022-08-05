{{ config(
    materialized='incremental',
    unique_key='id'
)   
}}

{# Performant and mostly correct 
Just re-process last 3 days of data, it will account for 99.9% of use cases. Has some problems when it comes to inception to date window functions. 
#}

with events as (
    select * from {{ source('public', 'jhu_vaccines') }}
    {% if is_incremental() %}
    where last_update_date >= (select dateadd('day', -3, max(last_updated)) from {{this}})
    {% endif %}
),

aggregated_by_state as (
    select 
        {{ dbt_utils.surrogate_key(['province_state', 'date']) }} as id,
        province_state
        , date
        , sum(doses_shipped_total) as total_shipped
        , sum(doses_admin_total) as total_admin
        , sum(people_total) as total_people
        , max(last_update_date) as last_updated
    from events
    {{ group_by(3) }}
)

select * from aggregated_by_state