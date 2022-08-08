{% snapshot snapshot_no_updated_at %}
  {{
    config(
      target_database='jordan_analytics',
      target_schema='snapshots',
      unique_key='id',
      invalidate_hard_deletes=True,
      strategy='check',
      check_cols='all'
    )
  }}

  -- Pro-Tip: Use sources in snapshots!
  select * from {{ ref('snapshot_data') }}

{% endsnapshot %}