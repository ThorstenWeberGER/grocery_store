-- =================================================================
-- Test Query 1: Simple Select from a Single Table
-- =================================================================
-- Objective: Retrieve a list of all customers who have more than 100 loyalty points.
-- This is a basic check to ensure data can be filtered correctly from a single table.

SELECT 
    customer_id, 
    first_name, 
    last_name, 
    email, 
    loyalty_points
FROM 
    customers
WHERE 
    loyalty_points > 100
ORDER BY 
    loyalty_points DESC;

-- =================================================================
-- Test Query 2: Simple Select with a Join
-- =================================================================
-- Objective: Find all products and their corresponding category names.
-- This tests the basic JOIN functionality between 'products' and 'categories'.

SELECT 
    p.product_id,
    p.name AS product_name,
    c.name AS category_name,
    p.price
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
ORDER BY
    c.name, p.name;

-- =================================================================
-- Test Query 3: Advanced Query with Multiple Joins and Aggregation
-- =================================================================
-- Objective: Calculate the total sales amount for each employee.
-- This tests multiple JOINs (orders, employees) and aggregation (SUM).

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    r.name AS role_name,
    SUM(o.total_amount) AS total_sales_amount
FROM
    orders o
JOIN
    employees e ON o.employee_id = e.employee_id
JOIN
    roles r ON e.role_id = r.role_id
GROUP BY
    e.employee_id, e.first_name, e.last_name, r.name
ORDER BY
    total_sales_amount DESC;

-- =================================================================
-- Test Query 4: Advanced Query with Window Function (RANK)
-- =================================================================
-- Objective: Rank products within each category based on their price, from most to least expensive.
-- This tests the use of the RANK() window function partitioned by category.

SELECT
    p.name AS product_name,
    c.name AS category_name,
    p.price,
    RANK() OVER (PARTITION BY c.name ORDER BY p.price DESC) AS price_rank_in_category
FROM
    products p
JOIN
    categories c ON p.category_id = c.category_id;
    
-- =================================================================
-- Test Query 5: Advanced Query with Multiple Joins and Window Function (ROW_NUMBER)
-- =================================================================
-- Objective: Find the most recent order for each customer.
-- This query uses multiple JOINs and a window function to identify and filter for the latest order per customer.

WITH CustomerOrders AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        o.order_id,
        o.order_date,
        o.total_amount,
        ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY o.order_date DESC) as rn
    FROM
        customers c
    JOIN
        orders o ON c.customer_id = o.customer_id
)
SELECT
    customer_id,
    first_name,
    last_name,
    order_id,
    order_date,
    total_amount
FROM
    CustomerOrders
WHERE
    rn = 1
ORDER BY 
    last_name, first_name;
