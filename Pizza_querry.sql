Use pizza_db;




select * from pizza_sales;

describe pizza_sales;



-- update pizza_sales
-- set order_date=str_to_date(order_date,"%d-%m-%Y");


-- Alter table pizza_sales
-- modify order_date date;



-- update pizza_sales
-- set order_time=str_to_date(order_time,'%H:%i:%s');

-- Alter table pizza_sales
-- modify order_time Time;


-- A.Key Performing Indicators

-- 1. Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;


-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;


-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;


-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;


-- 5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;



-- B. Hourly Trend for Total Pizzas Sold
SELECT HOUR(order_time) AS order_hours, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);


-- C. Weekly Trend for Orders
SELECT 
    WEEK(order_date, 3) AS WeekNumber,  -- The '3' indicates that weeks start on Monday and week 1 is the first week with a Thursday in it (ISO 8601)
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    pizza_sales
GROUP BY 
    YEAR(order_date),
    WEEK(order_date, 3)
ORDER BY 
    Year, WeekNumber;



-- D. % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;



-- E. % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


--  G. Top 5 Pizzas by Revenue
SELECT 
    pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    Total_Revenue DESC
LIMIT 5;


-- H. Bottom 5 Pizzas by Revenue
SELECT 
    pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    Total_Revenue ASC
LIMIT 5;
