{{ config(
    materialized='incremental',
    unique_key='id'
)   
}}

{# Always correct & slow
This helps ensure we re-process all data associated with any entity who has had an event in the last 3 days. 
Imagine what would happen if we tried to run a window function to get first_event_date() for an entity. This window function 
would only run over the last 3 days of events and miss any events prior to that window providing an incorrect result. 

Option #3: whenver a user has a new session, pull the user"s most recent session only, and perform relative calculations. (Requires some hard thinking)
#}

with events as (
    select * from {{ source('public', 'jhu_vaccines') }}
    {% if is_incremental() %}
    where province_state || date in (
       select distinct province_state || date from {{ source('public', 'jhu_vaccines') }} 
       where last_update_date >= (select dateadd('day', -3, max(last_updated)::date) from {{this}})
    )
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