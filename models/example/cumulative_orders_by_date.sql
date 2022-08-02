select distinct
    o.o_orderdate as date
    , sum(o.o_totalprice) over (partition by date) as sales
    , sum(o.o_totalprice) over (order by date) as cumulative_sales
from snowflake_sample_data.tpch_sf1.orders o
order by date
