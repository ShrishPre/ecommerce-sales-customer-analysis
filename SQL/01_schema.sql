-- E-Commerce Capstone Project
-- Database Schema

CREATE TABLE customers (customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),age INT,gender VARCHAR (10),
city VARCHAR(50),state VARCHAR(50),signup_date DATE);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(50),
    price DECIMAL(10,2),sub_category VARCHAR(50) ,cost INT );

CREATE TABLE orders (order_id INT PRIMARY KEY,
customer_id INT,order_date DATE,order_status VARCHAR(30),payment_mode VARCHAR(30),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id))

CREATE TABLE order_details (order_id INT,product_id INT,quantity INT,
discount_percent DECIMAL(5,2),revenue INT , FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id));

CREATE TABLE reviews (review_id INT PRIMARY KEY, order_id INT ,
rating INT Feedback VARCHAR (50),FOREIGN KEY (order_id) REFERENCES orders(order_id));



-- BASIC QUERY

-- Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;


-- Total Quantity Sold
SELECT SUM(quantity) AS total_quantity_sold
FROM order_details;


-- Orders with Customer Details
SELECT o.order_id,c.customer_name,o.order_date,o.order_status,o.payment_mode
FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id;


-- Total Unique Products
SELECT COUNT(DISTINCT product_id) AS total_products
FROM products;
