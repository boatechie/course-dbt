with session_counts as 
(
select session_id,
    {{agg_event('add_to_cart')}} as pv,
    {{agg_event('checkout')}}  as atc,
    {{agg_event('page_view')}} as ckt
from {{ ref('fct_events') }} 
group by session_id
)
select 
  sum(atc)/ sum(ckt) as conversion_rate
  from session_counts