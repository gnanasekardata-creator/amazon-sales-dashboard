CREATE DATABASE amazon_project;
USE amazon_project;
CREATE TABLE amazon_sales (
    order_id VARCHAR(50),
    order_date DATE,
    product_id VARCHAR(50),
    product_category VARCHAR(100),
    price DECIMAL(10,2),
    discount_percent INT,
    quantity_sold INT,
    customer_region VARCHAR(50),
    payment_method VARCHAR(50),
    rating DECIMAL(3,1),
    review_count INT,
    discounted_price DECIMAL(10,2),
    total_revenue DECIMAL(10,2)
);
SET SQL_SAFE_UPDATES = 1;
describe amazon_sales_dataset;

SELECT SUM(total_revenue) AS total_revenue
FROM amazon_sales_dataset;

SELECT product_category,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY revenue DESC;

SELECT customer_region,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY customer_region
ORDER BY revenue DESC;

SELECT product_id,
       SUM(quantity_sold) AS total_quantity
FROM amazon_sales_dataset
GROUP BY product_id
ORDER BY total_quantity DESC
LIMIT 10;

SELECT discount_percent,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY discount_percent
ORDER BY discount_percent;

SELECT payment_method,
       COUNT(*) AS total_orders,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY payment_method
ORDER BY revenue DESC;

ALTER TABLE amazon_sales_dataset
MODIFY order_date DATE;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(total_revenue) AS revenue
FROM amazon_sales_dataset
GROUP BY month
ORDER BY month;

CREATE TABLE analysis_table AS
SELECT 
    order_id,
    STR_TO_DATE(order_date, '%Y-%m-%d') AS order_date,

    YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) AS year,
    MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) AS month,
    DATE_FORMAT(STR_TO_DATE(order_date, '%Y-%m-%d'), '%b') AS month_name,

    product_id,
    product_category,

    price,
    discount_percent,
    discounted_price,

    quantity_sold,

    (price * quantity_sold) AS gross_sales,
    total_revenue,

    (price - discounted_price) AS discount_amount,

    customer_region,
    payment_method,

    rating,
    review_count

FROM amazon_sales_dataset;
SELECT COUNT(*) FROM analysis_table;
SELECT * FROM analysis_table;


select * from amazon_sales_dataset;
select * from analysis_table;