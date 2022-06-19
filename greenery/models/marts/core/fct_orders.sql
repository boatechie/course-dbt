{{
  config(
    materialized='table'
  )
}}

select o.*

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

from {{ ref('stage_orders') }} o
left join {{ ref('stage_users') }} u on u.user_id = o.user_id
left join {{ ref('stage_addresses') }} a on a.address_id = o.address_id
left join {{ ref('stage_promos') }}p on p.promo_id = o.promo_id