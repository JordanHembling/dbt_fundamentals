{#
{{ union_tables_by_prefix(
    database='snowflake_sample_data',
    schema='TPCH_SF1',
    prefix='p'
    ) 
}}

#}
select 1 as my_column