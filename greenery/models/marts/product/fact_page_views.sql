{{
  config(
    materialized='table'
  )
}}


select 
session_id 
, user_id
, product_name
, count(distinct case when event_type = 'add_to_cart' then 1  end ) add_to_cart
, count(distinct case when event_type = 'checkout' then 1 end ) checkout
, count(distinct case when event_type = 'page_view' then 1  end ) page_view
, count(distinct case when event_type = 'package_shipped' then 1 end ) package_shipped
, min(created_at) search_session_start
, max(created_at) search_session_stop

FROM {{ ref('dim_events_and_products') }} e

group by session_id,user_id,product_name