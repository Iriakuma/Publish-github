create table business.intermediate_orders as
/*(with unique_orders as (
select 
	orderID,
    row_number() over(partition by orderID order by orderID)
    from business.raw_orders
)
    select
		un.orderID as order_id,
        ro.customer_id,
		ro.order_amount,
		case when ro.currency = "US dollar" then "USD"
        else ro.currency
        end as currency,
		ro.full_country_name as country,
		ro.purchase_date,
		ro.product_category
	from business.raw_orders as ro
	inner join unique_orders as un
    on un.orderID = ro.orderID
)*/
/*1. A table containing the amount spent per customer for the past 12 months. If a customer is one
 of the top 10 spenders, indicate that they are a priority customer, otherwise indicate they are
 a normal customer*/
 
  /*Create a CTE with the top 10 spenders, then LEFT JOIN back to this CTE. 
  If the join returns a match you know it's a top 10 spender, else it's a normal 
  spender - a CASE statement can do this for you.*/
  
with top_spenders as (
select 
	customer_id,
	round(sum(order_amount),2) as total_sales
from business.intermediate_orders
where purchase_date > "2022-11-01"
group by customer_id
order by  total_sales desc
limit 10),  
total_amount as (
select
	bi.customer_id,
	round(sum(bi.order_amount),2) as total_sales,
	case when t.customer_id is not Null 
     then "top spender"
     else "regular spender"
     end as client_type
from business.intermediate_orders as bi
left join top_spenders as t
on bi.customer_id = t.customer_id
where bi.purchase_date > "2022-11-01"
group by bi.customer_id
)
select
	*
from total_amount
order by total_sales desc;


/*2. A report containing the average amount spent per year for each customer country. We only care about
 orders placed in the past three years and we are excluding the U.S. as we are 
an U.S. based company and this report to identify the biggest client countries outside of the home market.*/

select  
	bc.country,
    right(bo.purchase_date, 4) as purchase_year, 
    round(avg(bo.order_amount), 2) as 'avg_amount'
from business.intermediate_orders as bo
inner join business.intermediate_customers as bc
on bo.customer_id = bc.id
where bc.country != 'United States' and right(bo.purchase_date,4) >= "2020"
group by bc.country, right(bo.purchase_date, 4)
order by bc.country, purchase_year;

/*3. A report containing the lifetime purchases in USD per customer. Create a new table containing the exchange 
rates (you can Google the exchange rates for today and use it - columns would be source_currency,
 target_currency and ex_rate). The report should only contain the customer name, surname and the total 
 amount in the format: "$500.0".*/
 
 select 
	currency,
    count(1)
from business.intermediate_orders
group by currency;

create table business.exchange_rates (
source_currency varchar(10),
target_currency varchar(10),
ex_rate float);
insert into business.exchange_rates(source_currency,target_currency, ex_rate)
values('AUD','USD', 0.63),
	('EUR','USD', 1.06);
select *
from business.exchange_rates;
 select 
	customer_id,
    currency,
    round(avg(order_amount), 2)
 from business.intermediate_orders
 group by 1
 order by 3 desc;
	
with ex_calculations as (
select 
	order_amount,
    ex_rate,
    currency,
    round((order_amount * ex_rate),1) as lifetime_purchase
    from business.intermediate_orders as ir
    join business.exchange_rates as ec
    on ir.currency = ec.source_currency and ec.target_currency="USD"
)
select 
	c.first_name as 'name', 
    c.last_name as 'surname',
    concat('$', er.lifetime_purchase) as total_amount
from business.intermediate_customers as c
join business.intermediate_orders as o
on c.id = o.customer_id
join ex_calculations as er
on o.currency = er.currency
group by c.id
order by er.lifetime_purchase desc;