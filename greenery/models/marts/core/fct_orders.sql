{{
  config(
    materialized='table'
  )
}}

select 
     o.order_id
    ,o.user_id
    ,o.address_id as order_address_id
    ,o.created_at as order_created_at_utc
    ,o.order_cost 
    ,o.shipping_cost as order_shipping_cost
    ,o.order_total as order_total_cost
    ,o.tracking_id as order_tracking_id
    ,o.shipping_service
    ,o.estimated_delivery_at
    ,o.delivered_at
    ,o.status as order_status
    ,u.first_name
    ,u.last_name
    ,u.email
    ,u.phone_number
    ,a.address
    ,a.zipcode
    ,a.state
    ,a.country
    ,p.discount
    ,p.status as promo_status
    ,case when o.promo_id is not null then true else false end as has_promo_code

from {{ ref('stage_orders') }} o
left join {{ ref('stage_users') }} u on u.user_id = o.user_id
left join {{ ref('stage_addresses') }} a on a.address_id = o.address_id
left join {{ ref('stage_promos') }}p on p.promo_id = o.promo_id