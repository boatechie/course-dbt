# Week 2 answers
## What is our user repeat rate? repeat Rate = Users who purchased 2 or more times / users who purchased
```
with base_calc as (
select user_id
, count(distinct order_id) as user_orders
from dbt.dbt_emmanuel_ob.stage_orders
group by user_id
)

,
 users_order_quantity as (
select user_id
, (user_orders = 1)::int as one_order
, (user_orders >= 2)::int as twoplus_orders
from base_calc
)
select (sum(twoplus_orders)::float / count(distinct user_id)) as repeat_rate
from users_order_quantity
```

Answer:99/124 ---> 0.7983 --> 79.83%

## What are good indicators of a user who will likely purchase again? 
answers: 
indicators that may suggest a likelyhood of a purchase re-occorruing are having a user with abandoned items in their shopping cart,after
visiting the same article page several times. Also, a user who has purchased more than twice already has nealy 89% probablility of purchasing again.

## What about indicators of users who are likely NOT to purchase again? 

answer: if a user has made no orders and  added to cart without and a checkout event occuring during the transaction we could assume that they may not return 

## If you had more data, what features would you want to look into to answer this question?
it would be interesting knowing how they engage with pre-sales/ email campaigns.
For example, if they click and tends to purchase more whenever promo materials are sent out. 
##  Create a marts folder, so we can organize our models, with the following subfolders for business units
 please check within the marts folders
## Explain the marts models you added. Why did you organize the models in the way you did?
the goal was to have few core mart tables within the core folder which will represent the source of truth that over time could be re-used together with seveeral other tables.
I added a user_order fact table within the marketing subfolder.This can support us in finding out average order costs and quantity of pieces purchased my consumers.
Location information could also be a base for future geospatial analysis.
On the other hand within the product subfolder i created a fact page view table specifically with the intention of conducting behavioural analysis on purchasing events types.

# 2.
##  Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above
I created a core_schema yml file within the core subfolders with the latest tests.
## What assumptions are you making about each model? (i.e. why are you adding each test?
Test were predominantely to validate absence of duplicates key ids(such asorder_id and product_id).Also implemented a check to ensure that our inventory quantity would not be negative
## Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

I have added tests that have the scope of running on a daily basis to ensure the checks implemented do not fail against any new data coming in. Whenever a test fails, 
I can opt to be notified. This allow us to keep the data in good shape before it is picked up by stakeholders/users of our models.
