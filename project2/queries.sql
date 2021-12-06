--1
 select * from
(SELECT production.products.product_id, store_name,product_name,count(sales.check_store.product_id)as quan,
       row_number() OVER (PARTITION BY store_name ORDER BY count(sales.check_store.product_id)  DESC) as row_number
FROM production.products,sales.check_store,sales.stores
where  check_store.product_id=products.product_id and stores.store_id=check_store.store_id
group by  product_name, stores.store_name,  production.products.product_id) x where x.row_number<21
--2
select *from (
SELECT  production.products.product_id, stores.city,product_name,count(sales.check_store.product_id)as quan,
      row_number() OVER (PARTITION BY stores.city  ORDER BY count(sales.check_store.product_id)  DESC) as row_number
FROM production.products,sales.check_store,sales.stores
where  check_store.product_id=products.product_id and stores.store_id=check_store.store_id
group by  product_name, stores.city,  production.products.product_id) x where x.row_number<21

---3

SELECT  product_name,count(sales.check_store.product_id) as  quan
FROM production.products,sales.check_store,sales.stores
where  check_store.product_id=products.product_id and stores.store_id=check_store.store_id
group by  product_name, stores.city,  production.products.product_id
order by count(sales.check_store.product_id) desc
limit 5
-------------4
create view a as
  select store_name , count(production.products.product_name) as coke, sales.stores.store_id
    from sales.stores,production.products,sales.check_store
    where check_store.product_id=products.product_id and stores.store_id=check_store.store_id and product_name='Cola'
    group by  stores.store_id

create view b as
  select store_name, count(production.products.product_name) as pepsi, sales.stores.store_id
    from sales.stores,production.products,sales.check_store
    where check_store.product_id=products.product_id and stores.store_id=check_store.store_id and product_name='Pepsi'
    group by  stores.store_id

select a.store_name, a.store_id,a.coke,b.pepsi
from a,b
where a.coke>b.pepsi and a.store_id=b.store_id and a.store_name=b.store_name
order by store_id
--------5
create view milk as
  select customer_id
    from sales.stores,production.products,sales.check_store
    where check_store.product_id=products.product_id and stores.store_id=check_store.store_id and product_name='Milk'
    group by  customer_id

select  product_name,count(sales.check_store.product_id)
from sales.stores,production.products,milk,sales.check_store,sales.customers
where milk.customer_id=check_store.customer_id
group by product_name,customers.customer_id
order by count(sales.check_store.product_id) desc
limit 3
