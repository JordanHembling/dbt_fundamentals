{% docs __overview__ %}
# Monthly Recurring Revenue (MRR) playbook.
This dbt project is a worked example to demonstrate how to model subscription
revenue. **Check out the full write-up [here](https://blog.getdbt.com/modeling-subscription-revenue/),
as well as the repo for this project [here](https://github.com/dbt-labs/mrr-playbook/).**
...

{% enddocs %}


{% docs __dbt_utils__ %}
# Utility macros
Our dbt project heavily uses this suite of utility macros, especially:
- `surrogate_key`
- `test_equality`
- `pivot`
{% enddocs %}

{% docs __snowflake_spend__ %}
# Snowflake Spend
Our organization uses this package of transformations to understand snowflake spend.
{% enddocs %}