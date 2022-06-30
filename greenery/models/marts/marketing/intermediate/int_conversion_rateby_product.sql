
with session_product as 
(
select session_id,
    {{agg_event('add_to_cart')}} as pv,
    {{agg_event('checkout')}}  as atc    
from {{ ref('fct_events') }} 
group by session_id,product_id
)
select * from session_product 