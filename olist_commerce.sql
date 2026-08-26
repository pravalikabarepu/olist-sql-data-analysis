use olist_commerce;
show tables;
## Query-1 Basic SELECT
use olist_commerce;
select * 
from olist_customers_dataset
limit 10;
## Query-2 SELECT specific columns
select
customer_id,
customer_city,
customer_state
from olist_customers_dataset
limit 20;
## Query-3 WHERE
select
customer_id,
customer_city,
customer_state
from olist_customers_dataset
where customer_state='SP';
## Query-4 ORDER BY
select
order_id,
product_id,
price
from olist_order_items_dataset
order by price desc
limit 20;
## Query-5 COUNT
select count(*) as total_customers
from olist_customers_dataset;
## Query-6 GROUP BY
select
customer_state,
count(*) as customer_count
from olist_customers_dataset
group by customer_state
order by customer_count desc;
## Query-7 GROUP BY + HAVING
select
customer_state,
count(*) as customer_count
from olist_customers_dataset
group by customer_state
having count(*) > 1000
order by customer_count desc;
## Query-8 INNER JOIN
select
c.customer_id,
c.customer_city,
c.customer_state,
o.order_id,
o.order_status
from olist_customers_dataset c
inner join olist_orders_dataset o
on c.customer_id = o.customer_id
limit 20;
## Query-9 LEFT JOIN
select 
c.customer_id,
c.customer_city,
o.order_id
from olist_customers_dataset c
left join olist_orders_dataset o
on c.customer_id = o.customer_id
limit 20; 
## Query-10 Three-Table JOIN
select
c.customer_state,
o.order_id,
oi.product_id,
oi.price,
oi.freight_value
from olist_customers_dataset c
inner join olist_orders_dataset o
on c.customer_id = o.customer_id
inner join olist_order_items_dataset oi
on o.order_id = oi.order_id
limit 30;
## Query-11 Revenue By State
select
c.customer_state,
sum(oi.price) as total_revenue
from olist_customers_dataset c
inner join olist_orders_dataset o
on c.customer_id = o.customer_id
inner join olist_order_items_dataset oi
on o.order_id = oi.order_id
group by c.customer_state
order by total_revenue desc;
## Query-12 Average Order value
select 
avg(order_total) as average_order_value
from(
select
order_id,
sum(price + freight_value) as order_total
from olist_order_items_dataset
group by order_id
)
as order_summary;
## Query-13 Categorize Product Prices
select
order_id,
product_id,
price,
case
when price < 50 then 'Low'
when price between 50 and 200 then 'Medium'
else 'High'
end as price_category
from olist_order_items_dataset
limit 30;
## Query-14 Find Duplicate reviews IDs
select
review_id,
count(*) as duplicate_count
from olist_order_reviews_dataset
group by review_id
having count(*) > 1;
## Query-15 Top 10 product categories by revenue
select
coalesce(pt.product_category_name_english,'unknown') as category,
sum(oi.price) as total_revenue
from olist_order_items_dataset oi
inner join olist_products_dataset p
on oi.product_id = p.product_id
left join product_category_name_translation pt
on p.product_category_name = pt.product_category_name
group by coalesce(pt.product_category_name_english,'unknown')
order by total_revenue desc
limit 10;
