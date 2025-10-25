use PortfolioProject

--Get sum of total price of all the pizza orderss
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

--Get avg amount spent per order
--total revenue / total number of orders
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales

--The sum of the quantities of all pizzas sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales

--Total amount of orders placed
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

--Average number of pizzas sold per order
--total number of pizzas sold/total number of orders
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_pizzas_per_order
FROM pizza_sales

--Data for chart to show daily trend of total orders over a specific time period
--Will show daily trend for total orders
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--Data for chart to show hourly trend for total orders
--Will show peak hours of high order activity
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

--Data for chart to show percentage of sales by pizza category
--Will show the popularity of different pizza categories and their contibution to overall sales
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS percentage_sales
FROM pizza_sales
GROUP BY pizza_category

--Data for chart to show percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS percentage_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--Data for chart to show total pizzas sold by pizza category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--Data for chart to show top 5 total pizzas sold
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--Data for chart to show bottom 5 total pizzas sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
