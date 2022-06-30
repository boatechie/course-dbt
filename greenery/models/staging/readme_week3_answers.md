# Week 3 answers
## What is our overall conversion rate? What is our conversion rate by product?
```
with session_counts as (
select session_id,
 max(case when event_type = 'add_to_cart'then 1.0 else 0 end)as pv,
 max(case when event_type = 'checkout' then 1.0 else 0 end) as atc,
 max(case when event_type = 'page_view' then 1.0 else 0 end) as ckt
from dbt.dbt_emmanuel_ob.fct_events
group by session_id
),

session_product as (
select 
session_id,
product_id,
 max(case when event_type = 'add_to_cart'then 1.0 else 0 end)as pv,
 max(case when event_type = 'checkout' then 1.0 else 0 end) as atc
 from dbt.dbt_emmanuel_ob.fct_events
group by session_id,product_id
)
select 
  sum(atc)/ sum(ckt) as conversion_rate
  from session_counts;

select * from dbt.dbt_emmanuel_ob.fct_events

```
answer: conversion rate :0.62
