
-- Total Revenue
SELECT SUM(p.price * od.quantity * (1 - od.discount_percent/100)) AS total_revenue
FROM order_details od JOIN products p ON od.product_id = p.product_id;


-- Average Order Value (AOV)
SELECT SUM(p.price * od.quantity * (1 - od.discount_percent / 100) ) / COUNT(DISTINCT o.order_id) 
AS avg_order_value FROM orders o 
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id;


-- Revenue by Customer
SELECT
    c.customer_name,
    SUM(p.price * od.quantity * (1 - od.discount_percent / 100)) AS customer_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY customer_revenue DESC;

--INSIGHTS : 

-- Top 5 customers by revenue
SELECT c.customer_name, SUM(p.price * od.quantity * (1 - od.discount_percent / 100)) 
AS revenue FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 5;

-- Revenue by city
SELECT c.city, SUM(p.price * od.quantity * (1 - od.discount_percent / 100)) 
AS city_revenue FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.city
ORDER BY city_revenue DESC;

--Average Orders per Customer
SELECT AVG(order_count) AS avg_orders_per_customer FROM (SELECT customer_id, COUNT(order_id) 
AS order_count FROM orders GROUP BY customer_id)AS customer_orders;

--Repeat vs One-Time Customers
SELECT CASE WHEN COUNT(o.order_id) > 1 THEN 'Repeat Customer' ELSE 'One-Time Customer'
END AS customer_type, COUNT(DISTINCT c.customer_id) AS total_customers FROM customers c
JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id;

-- Total Profit & Profit Margin %
SELECT SUM((p.price - p.cost) * od.quantity) AS total_profit,
SUM(p.price * od.quantity) AS total_revenue,
(SUM((p.price - p.cost) * od.quantity) / SUM(p.price * od.quantity)) * 100 AS profit_margin_percent
FROM order_details od JOIN products p ON od.product_id = p.product_id;

