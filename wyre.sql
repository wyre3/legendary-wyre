select * from accounts;

select *from region;

select * from orders;

select *
from web_events;


select *
from sales_reps;



---Question 1--- 

"Day of the week that had the highest orders and who was the primry POC"

select *
from
(select "primary_POC", to_char("Highest_sales_week", 'day'), "Highest_sales_week", sum("amount") as "sum_total"
from
(select distinct a.primary_poc "primary_POC", a.id, o.account_id, o.standard_qty "amount", occurred_at "Highest_sales_week"
from "accounts" a
join "orders" o
on a.id = o.account_id) as "table_one"
group by "primary_POC", "Highest_sales_week"
order by "sum_total" asc) as "table_two";

---Question 2--- "Total sales made by walmart on saturday"
select "name", to_char(occurred_at, 'day'), sum("total") as "total_quantity"
from "accounts" a
join "orders" o
on o.account_id = a.id
where trim(to_char(occurred_at, 'day')) = 'saturday' and "name" = 'Walmart'
group by "name", "occurred_at"
order by "total_quantity";

---Questipon 3--- "sales rep that made the highest sales which week, day and what month"
select *
from
(select distinct("name"), "week_day", to_char("week_day", 'month') "months", to_char("week_day", 'day') "day",  sum("total_sales") as "sales_total"
from
(select s.name, o.occurred_at "week_day", o.total "total_sales"
 from "sales_reps" s
 join "orders" o
 on s.region_id = o.id) as "table_one"
 group by "name", "week_day"
 order by "sales_total" desc) "table_two";