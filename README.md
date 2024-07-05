# E-Commerce-Retail-Data-Analysis
E-Commerce Retail Data Analysis is to understand customer behavior and trend using their point of sales data.
![retail-anaytics](https://github.com/Jahnavi-kada/E-Commerce-Retail-Data-Analysis/assets/174793510/a7f94cb5-cd1b-42da-b451-9341d25c7cc3)
## Tools 
### 1.Database Management System: MySQL

## Dataset Description:

## Customers
### Variables:
* Customer_ID (int): Unique identifier for each customer.
* DOB (date): Date of birth of the customer.
* Gender (varchar): Gender of the customer.
* City_Code (int): City code of the customer.

## Schema:
* Number of variables: 4
* Number of records: 5647
### Purpose: This dataset is used to store customer demographics and information.

## Prod_cat_info
### Variables:
* Prod_cat_code (int): Product category code.
* Prod_cat (varchar): Product category.
* Prod_sub_cat_code (int): Product subcategory code.
* Prod_subcat (varchar): Product subcategory.

## Schema:
* Number of variables: 4
* Number of records: 23
### Purpose: This dataset is used for categorizing products based on their category and subcategory.

## Transactions
### Variables:
* transaction_id (int): Unique identifier for each transaction.
* cust_id (int): Customer ID associated with the transaction.
* tran_date (date): Date of the transaction.
* prod_subcat_code (int): Product subcategory code.
* prod_cat_code (int): Product category code.
* Qty (int): Quantity of products purchased (Negative if it is a return order).
* Rate (decimal): Unit rate of the product (Negative if it is a return order).
* Tax (decimal): Tax amount for the transaction.
* total_amt (decimal): Total amount of the transaction (Negative if it is a return order).
* Store_type (varchar): Type of store where the transaction occurred.

## Schema:
* Number of columns: 10
* Number of rows: 23053
### Purpose: This dataset is used for analyzing transactional data, including customer purchase behavior and store performance metrics.

## Objectives
The following objectives were addressed in this project:
### 1.Identify Sales Patterns: 
Analyze sales data to uncover trends and patterns over time, including seasonal fluctuations and peak sales periods.
### 2.Customer Behavior Analysis: 
Understand customer purchasing behavior, including frequency of purchases, average order value, and customer demographics.
### 3.Product Performance: 
Evaluate the performance of different products or categories, identifying bestsellers and underperforming items.
### 4.Revenue Analysis: 
Calculate total revenue, profit margins, and other key financial metrics to assess the overall financial health of the e-commerce business.
### 5.Market Segmentation: 
Segment the customer base into different groups based on purchasing habits, geographic location, and other relevant criteria to tailor marketing efforts.
### 6.Return Analysis: 
Analyze the reasons and frequency of product returns to identify potential issues with products or customer expectations.
### 7.Channel Performance: 
Compare the effectiveness of different sales channels (e.g., online store, mobile app) to understand where customers prefer to shop.
### 8.Customer Retention: 
Measure customer retention rates and identify strategies to improve customer loyalty and repeat purchases.
### 9.Logistics and Delivery: 
Evaluate the efficiency of the supply chain and delivery processes, including shipping times and costs, to optimize logistics.

## Data Preparation and Understanding:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### 1. What is the total number of rows in each of the 3 tables in the database?
   The query get the count of records in each table which can help to know data volume.
### 2. What is the total number of transactions that have a return?
   The query will display the number of returns which can help to improve product quality, inventory management
### 3. What is the time range of the transaction data available for analysis? Show the output in number of days, months and years simultaneously in different columns.
   Here we have the timespan of data in number of days, months, years which can be used for data analysis and documentation purpose.
### 4. Which product category does the sub-category “DIY” belong to?
   The Books category has DIY subcategory. Queries like this can be used to find which subcategory belongs to which category.

## Data Analysis:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### 1. Which channel is most frequently used for transactions?
   e-Shop channel is most frequently used by customers for transactions. This can help in planning channel-specific strategies and analysis for enhancing customer experiences etc.
### 2. What is the count of Male and Female customers in the database?
   This data shows the number of male customer and female customers which can be used to plan gender specific strategies, identifying trends.
### 3. From which city do we have the maximum number of customers and how many?
   This data shows the city with city_code 3 has maximum as in 595 customers which can help to plan market broadening in future.
### 4. How many sub-categories are there under the Books category?
   There are 6 subcategories under the Books category. Queries like this can be used to retrieve subcategory data.
### 5. What is the maximum quantity of products ever ordered?
   5 is the maximum quantity of products ever ordered. Queries like this can be used for to get data on products.
### 6. What is the net total revenue generated in categories Electronics and Books?
   10722463.635 is net total revenue generated in Electronics and 12822694.04 in Books which can used to get total revenue generated also considering the returns data. This can help to analysis category specific trends.
### 7. How many customers have >10 transactions with us, excluding returns?
   This data shows 6 customers who have more than 10 transactions excluding returns which can be helpful to understand customer preference,to improve customer satisfaction and introduce loyalty programs.
### 8. What is the combined revenue earned from the “Electronics” & “Clothing” categories, from “Flagship stores”?
   3851454.295 is the combined revenue earned from Electronics and Category from Flagship stores. This can be used to understand Flagship stores performance.
### 9. What is the total revenue generated from “Male” customers in “Electronics” category? Output should display total revenue by prod sub-cat.
   This data displays male customer purchases in Electronics which will help to understand gender specific customer satisfaction and to get category specific data analysis.
### 10. What is percentage of sales and returns by product sub category; display only top 5 sub categories in terms of sales?
   The data provides information on sales and returns percentages within the top product categories. This help in improving overall profitability and customer satisfaction.
### 11. For all customers aged between 25 to 35 years find what is the net total revenue generated by these consumers in last 30 days of transactions from max transaction date available in the data?
   The data gives revenue in last 30 days for customers aged 25-35. This can help in understanding purchasing behavior of the specific age group within the specified timeframe which can be used to improve     customer enagagement.
### 12. Which product category has seen the max value of returns in the last 3 months of transactions?
   Category Home and Kitchen has the maximum (1) returns in last 3 months. Queries like this can be used to improve product quality, customer satisfaction and customer interaction.
### 13. Which store-type sells the maximum products; by value of sales amount and by quantity sold?
   e-Shop store sells maximum products both by quantity and sales amount. Queries like this can help with Inventory management, planning future strategies for sales etc.
### 14. What are the categories for which average revenue is above the overall average.
   Categories Bags, Books, Clothing, Electronics whose average revenue (sales excluding returns) exceeds the overall average. This data can be used to plan strategies for high-performing categories which can maximize profit.
### 15. Find the average and total revenue by each subcategory for the categories which are among top 5 categories in terms of quantity sold.
   This analysis can be used to compare dynamics in revenue across subcategories within the most popular product categories, which can be helpful to plan strategies and broaden the sectors.

## SQL Queries
The SQL queries used for each objective are provided in the e_comm_retail.sql file. You can run these queries in MySQL Workbench to replicate the analysis.

## Conclusion:
The conclusion for an e-commerce retail data analysis project typically summarizes the insights gained, the effectiveness of the methodologies used, and potential recommendations for the business. Here are some key points often found in such conclusions:

* Insight Generation: The analysis usually identifies key patterns and trends in the data, such as peak sales periods, high-performing product categories, and customer demographics that drive the most revenue. For example, analyzing the sales data can reveal which marketing campaigns were the most successful and which customer segments are the most valuable.

* Performance Measurement: It often involves evaluating the effectiveness of various marketing channels, website performance, and new product launches. This includes metrics like conversion rates, return on investment for marketing campaigns, and customer acquisition costs.

* Optimization Opportunities: The conclusion may highlight areas where the business can optimize its operations, such as improving website user experience, targeting marketing efforts more effectively, or refining inventory management based on sales patterns.

* Future Recommendations: Based on the findings, the analysis may offer recommendations for future actions. These can include strategies for boosting sales during off-peak periods, enhancing customer retention through personalized marketing, or leveraging data analytics for more informed decision-making.
