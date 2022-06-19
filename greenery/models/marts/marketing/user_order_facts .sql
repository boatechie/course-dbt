{{
  config(
    materialized='table'
  )
}}

with users_with_address as (
  select 
    u.user_id
  , first_name
  , last_name
  , email
  , phone_number
  , u.address_id
  , a.address
  , a.zipcode
  , a.state
  , a.country
  from {{ref('stage_users')}} u
  left join {{ref('stage_addresses')}} a on a.address_id = u.address_id
),

order_base as (
  select 
  user_id
  , avg(order_cost) avg_order_cost
  , sum(order_total) lifetime_order_total
  , count(distinct order_id) quantity_orders_done
  , min(created_at) first_order_timestamp_utc
  , max(created_at) last_order_timestamp_utc
    
  from {{ ref('stage_orders') }}

  group by user_id 
)



select o.* 
  , first_name
  , last_name
  , email
  , phone_number
  , address_id
  , address
  , zipcode
  , state
  , country

from order_base o
left join users_with_address u on u.user_id = o.user_id
