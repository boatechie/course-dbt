# Week 1 Answers
### 1. How many users do we have?
<code>
select count (distinct user_id) 
  
from dbt_emmanuel_ob.stage_users;</code>

**Answer: 130**

### 2. On average, how many orders do we receive per hour?
<code>
with orders_per_hour as (
  
  select
    date_trunc('hour', created_at) as order_hour
    , count(distinct order_id) as orders
  from dbt_emmanuel_ob.stage_orders
  group by order_hour
)
select avg(orders)as count_avg_orders_per_hour
from orders_per_hour; 
</code>
 

**Answer: 7.5208333333333333**

### 3. On average, how long does an order take from being placed to being delivered?
<code>
with orders_delivery_timing as (
  select
  distinct order_id as orders
  ,(delivered_at -created_at) as order_delivery_time
  from dbt_emmanuel_ob.stage_orders
  where delivered_at is not null)

select avg(order_delivery_time)as avg_order_delivery_time
from orders_delivery_timing;</code>

**Answer: 2 days**

### 4. How many users have only made one purchase? Two purchases? Three+ purchases?
<code>
with base_calc as (
  select distinct user_id, 
  case 
    when count(*) = 1 then ' 1 order'
    when count(*) = 2 then '2 orders'
    when count(*) >= 3 then '3+ orders' 
  end total_orders_quantity
  from dbt_emmanuel_ob.stage_orders
  group by user_id
)
select 
  total_orders_quantity
  , count(user_id) as num_users
from base_calc
group by total_orders_quantity
order by total_orders_quantity; </code>

**Answer: ONE order: 25 , TWO orders: 28 , THREE+ orders: 71**

### 5. On average, how many unique sessions do we have per hour?
<code>
with base_calc as 
(
  select 
  date_trunc('hour', created_at) as created_hour,
  count(distinct session_id) AS num_sessions
  from dbt_emmanuel_ob.stage_events
  group by created_hour
)
select 
  round(avg(num_sessions),0) AS avg_sessions
from base_calc </code>

**Answer: 16**
