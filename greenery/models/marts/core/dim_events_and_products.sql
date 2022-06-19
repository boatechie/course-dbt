
{{
  config(
    materialized='table'
  )
}}

select 
e.*
--, p.product_id as productid
, p.name as product_name
, p.price as price_usd
, p.inventory as inventory_qty

from {{ ref('stage_events') }} e
left join {{ ref('stage_products') }} p on p.product_id = e.product_id 