create database e_commerce_retails;
use e_commerce_retails;

-- DATA preparation and understanding 

# 1.What is the total number of rows in each of the 3 tables in the database? 

select count(*) from Transactions T;
select count(*) from Customers C ;
select count(*) from prod_cat_info P ;

# 2.What is the total number of transactions that have a return?

select count(*) as return_transactions from Transactions T where total_amt < 0;
 
# 3.you would have noticed, the dates provided across the datasets are not in a correct format. 
# As first steps, pls convert the date variables into valid date formats before proceeding ahead.
SET SQL_SAFE_UPDATES = 0; 
desc transactions;
desc customers;

update transactions
set tran_date = STR_TO_DATE(tran_date, '%d-%m-%Y')
where tran_date is not null;

alter table transactions
change column tran_date tran_date  date not null;

update customers
set DOB = STR_TO_DATE(DOB, '%d-%m-%Y')
where DOB is not null;

alter table customers
change column DOB DOB  date not null;

# 4.What is the time range of the transaction data available for analysis? 
# Show the output in number of days, months and years simultaneously in different columns.

select
    MIN(tran_date) AS start_date,
    MAX(tran_date) AS end_date,
    DATEDIFF(MAX(tran_date), MIN(tran_date)) AS range_tran_days,
    TIMESTAMPDIFF(MONTH, MIN(tran_date), MAX(tran_date)) AS range_tran_months,
    TIMESTAMPDIFF(YEAR, MIN(tran_date), MAX(tran_date)) AS range_tran_years
from transactions;

# 5.Which product category does the sub-category "DIY" belong to?

select prod_cat, prod_subcat from prod_cat_info where prod_subcat = 'DIY';


-- DATA ANALYSIS

# 1.Which channel is most frequently used for transactions?

select Store_type, count(transaction_id) as Most_Used_Channel from transactions 
group by Store_type order by Most_Used_Channel desc limit 1;

# 2.What is the count of Male and Female customers in the database?

select Gender, count(distinct customer_id) as customer_count from customers
where Gender in ('M','F') group by Gender;

# 3.From which city do we have the maximum number of customers and how many?

select city_code,count(distinct customer_Id) as No_of_Customers from customers
group by city_code order by No_of_Customers desc limit 1;
   
# 4.How many sub-categories are there under the Books category?

select prod_cat, count(prod_subcat) as No_of_Subcategories 
from prod_cat_info where prod_cat  = 'Books' group by prod_cat;

# 5.What is the maximum quantity of products ever ordered?

select max(Qty) as max_qty from transactions; 

# 6.What is the net total revenue generated in categories Electronics and Books?

select P.prod_cat, round(sum(T.total_amt),2) as net_total_revenue from transactions T
join prod_cat_info P on P.prod_cat_code = T.prod_cat_code and P.prod_sub_cat_code = T.prod_subcat_code 
group by P.prod_cat 
having P.prod_cat in('Electronics', 'Books');

# 7.How many customers have > 10 transactions with us, excluding returns?

with count_customers as
(
select cust_id, count(transaction_id) as no_of_transactions from transactions T
where total_amt > 0 
group by cust_id 
having count(transaction_id) > 10
)
select count(*) as no_of_customers from count_customers;
	
# 8. What is the combined revenue earned from the "Electronics" & "Clothing" categories, from "Flagship stores"?

select T.Store_type, round(sum(total_amt),2) as combined_revenue from transactions T
join prod_cat_info P on T.prod_subcat_code = P.prod_sub_cat_code and T.prod_cat_code = P.prod_cat_code 
where P.prod_cat in ('Electronics', 'Clothing') and T.total_amt > 0
group by T.Store_type
having T.Store_type = 'Flagship store';   

# 9.What is the total revenue generated from "Male" customers in "Electronics" category? 
# Output should display total revenue by prod sub-cat.

select P.prod_cat, P.prod_subcat , round(sum(T.total_amt),2) as total_revenue from transactions T 
join customers C on C.customer_Id  = T.cust_id 
join prod_cat_info P on T.prod_subcat_code = P.prod_sub_cat_code and T.prod_cat_code = P.prod_cat_code 
where C.gender = 'M' and T.total_amt > 0 
group by P.prod_cat, P.prod_subcat
having P.prod_cat = 'Electronics'; 

# 10.What is percentage of sales and returns by product sub category; 
# display only top 5 sub categories in terms of sales?

# Top 5 subcategories 
    select P.prod_subcat, round(sum(T.total_amt),2) as total_sales
    from transactions T join prod_cat_info P on t.prod_subcat_code = p.prod_sub_cat_code and T.prod_cat_code = P.prod_cat_code
    where T.total_amt > 0
    group by P.prod_subcat
    order by total_sales desc
    limit 5;
    
#Percentage sales and returns
  with Sales_Returns as
  (
  select P.prod_subcat,
  sum(case when T.Qty > 0 then T.Qty else 0 end) as sales_value,
  abs(sum(case when T.Qty < 0 then T.Qty else 0 end)) as returns_value
  from Transactions T inner join Prod_cat_info P
  on T.prod_cat_code = P.prod_cat_code AND T.prod_subcat_code = P.prod_sub_cat_code
  group by P.prod_subcat
  order by sales_value desc
  )
  select prod_subcat, round(((Returns_value / (Returns_value + Sales_value))*100), 2) as Returns_Percentage,
  round(((Sales_value / (Returns_value + Sales_value))*100), 2) as Sales_Percentage
  from Sales_Returns;

# 11.For all customers aged between 25 to 35 years find what is the net total revenue generated by 
# these consumers in last 30 days of transactions from max transaction date available in the data?
   
with max_tran_date as 
  (select max(tran_date) as max_date from transactions),
last_30days_trans as (
    select T.cust_id, T.tran_date, T.total_amt, M.max_date
    from transactions T cross join max_tran_date M
    where T.tran_date between DATE_SUB(M.max_date, interval 30 day) and M.max_date
),
age_25_30 as (
    select C.customer_id, year(M.max_date) - year(C.DOB) as age
    from customers C
    cross join max_tran_date M
    where year(M.max_date) - year(C.DOB) between 25 and 35
),
net_rev as (
    select sum(T.total_amt) AS net_total_revenue
    from last_30days_trans T
    join age_25_30 A ON T.cust_id = A.customer_id
)
select net_total_revenue from net_rev;

# 12.Which product category has seen the max value of returns in the last 3 months of transactions?

with max_tran_date as 
	(select max(tran_date) as max_date from Transactions),
last_90days_returns as (
    select P.prod_cat, sum(case when T.total_amt < 0 then T.total_amt else 0 end) as return_amount 
    from transactions T
    join max_tran_date M on T.tran_date between DATE_SUB(M.max_date, interval 90 day) and M.max_date
    left join prod_cat_info P on T.prod_subcat_code = P.prod_sub_cat_code and T.prod_cat_code = P.prod_cat_code 
    group by P.prod_cat
)
select prod_cat, return_amount
from last_90days_returns
order by return_amount
limit 1;

# 13.Which store-type sells the maximum products; by value of sales amount and by quantity sold?

select Store_type, round(sum(total_amt),2) as total_sales, count(Qty) as qty_sold from transactions T
where total_amt > 0 
group by Store_type 
order by total_sales desc, qty_sold desc
limit 1;

# 14.What are the categories for which average revenue is above the overall average.

select  p.prod_cat, avg(t.total_amt) as avg_cat_rev from transactions T
join prod_cat_info P on T.prod_cat_code = P.prod_cat_code and T.prod_subcat_code = P.prod_sub_cat_code
where total_amt > 0
group by P.prod_cat
having avg(T.total_amt) > (select avg(total_amt) as overall_avg_rev from transactions where total_amt > 0);

# 15. Find the average and total revenue by each subcategory for the categories
# which are among top 5 categories in terms of quantity sold.
   
with TopCategories as (
    select P.prod_cat, T.prod_cat_code, count(Qty) as qty_sold 
    from transactions T inner join prod_cat_info P 
    on T.prod_cat_code = P.prod_cat_code and T.prod_subcat_code = P.prod_sub_cat_code
    where T.total_amt > 0
    group by P.prod_cat, T.prod_cat_code
    order by qty_sold desc
    limit 5
)
select  P.prod_cat, round(avg(T.total_amt),2) as avg_revenue, round(sum(T.total_amt),2) as total_revenue 
from transactions T join prod_cat_info P 
on T.prod_cat_code = P.prod_cat_code and T.prod_subcat_code = P.prod_sub_cat_code
join TopCategories TC on T.prod_cat_code  = TC.prod_cat_code
group by P.prod_cat;


