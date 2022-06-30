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

## PART 2: We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project. Create a macro to simplify part of a model(s).
answer: int_conversion_rate & int_conversion_rateby_product

## PART 3: We’re starting to think about granting permissions to our dbt models in our postgres database so that other roles can have access to them.
answer: a  on- run-end post-hook can be found added within tjr dbt_project.yml file

## PART 4:  After learning about dbt packages, we want to try one out and apply some macros or tests. Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project
answer: within packages.yml you can see the dbt_utils package latest bversion installed

## PART 5: After improving our project with all the things that we have learned about dbt, we want to show off our work!

answer: the new DAG has been generated and attached into our answers
