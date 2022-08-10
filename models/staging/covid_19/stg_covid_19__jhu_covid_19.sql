{# The code block below generates all of the SQL displayed
{{ codegen.generate_base_model('covid_19', 'jhu_covid_19') }}
#} 

with source as (

    select * from {{ source('covid_19', 'jhu_covid_19') }}

),

renamed as (

    select
        country_region,
        province_state,
        county,
        fips,
        date,
        case_type,
        cases,
        long,
        lat,
        iso3166_1,
        iso3166_2,
        difference,
        last_updated_date,
        last_reported_flag

    from source

)

select * from renamed