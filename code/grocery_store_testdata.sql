-- =================================================================
-- Populating tables with no foreign key dependencies first
-- =================================================================

-- Populating the 'roles' table
INSERT INTO roles (role_id, name, description) VALUES
(1, 'Store Manager', 'Manages overall store operations and staff.'),
(2, 'Sales Associate', 'Assists customers and processes sales transactions.'),
(3, 'Warehouse Clerk', 'Manages inventory, shipping, and receiving.'),
(4, 'Marketing Coordinator', 'Creates and manages promotional campaigns.');

-- Populating the 'categories' table
INSERT INTO categories (category_id, name, description) VALUES
(1, 'Electronics', 'Gadgets and devices like smartphones, laptops, and accessories.'),
(2, 'Apparel', 'Clothing, shoes, and fashion accessories.'),
(3, 'Home & Kitchen', 'Appliances, cookware, and home decor.'),
(4, 'Books', 'Fiction, non-fiction, and educational books.');

-- Populating the 'fulfillment_methods' table
INSERT INTO fulfillment_methods (method_id, name) VALUES
(1, 'Standard Shipping'),
(2, 'Express Shipping'),
(3, 'In-Store Pickup');

-- Populating the 'payment_methods' table
INSERT INTO payment_methods (payment_method_id, name, description) VALUES
(1, 'Credit Card', 'Payment via Visa, MasterCard, or AMEX.'),
(2, 'PayPal', 'Payment through PayPal account.'),
(3, 'Gift Card', 'Payment using a store-issued gift card.');

-- Populating the 'customers' table
INSERT INTO customers (customer_id, first_name, last_name, email, phone, street, housenumber, postal_code, city, loyalty_points) VALUES
(1, 'Alice', 'Williams', 'alice.w@email.com', '555-0101', 'Main St', 123, 12345, 'Anytown', 150),
(2, 'Bob', 'Brown', 'bob.b@email.com', '555-0102', 'Oak Ave', 45, '67890', 'Someville', 20),
(3, 'Charlie', 'Davis', 'charlie.d@email.com', '555-0103', 'Pine Ln', 8, '54321', 'Otherplace', 500);

-- Populating the 'employees' table (must be populated before suppliers)
-- Note: Supervisor can be NULL for top-level employees
INSERT INTO employees (employee_id, first_name, last_name, role_id, hire_date, leave_date, salary, supervisor) VALUES
(1, 'Diana', 'Prince', 1, '2020-01-15', NULL, 75000, NULL),
(2, 'Bruce', 'Wayne', 2, '2021-03-10', NULL, 45000, 1),
(3, 'Clark', 'Kent', 2, '2021-03-10', NULL, 48000, 1),
(4, 'Barry', 'Allen', 3, '2022-06-01', NULL, 42000, 1);

-- =================================================================
-- Populating tables with foreign key dependencies
-- NOTE: Order is important to respect constraints.
-- =================================================================

-- Populating the 'suppliers' table (depends on employees)
INSERT INTO suppliers (supplier_id, supplier_name, description, contact_name, contact_details, account_manager) VALUES
(101, 'Global Tech Inc.', 'Electronics Supplier', 'John Smith', 'john.s@globaltech.com', 1),
(102, 'Fashion Forward LLC', 'Apparel Wholesaler', 'Jane Doe', 'jane.d@fashionforward.com', 2),
(103, 'Home Essentials Co.', 'Home Goods Distributor', 'Peter Jones', 'p.jones@homeessentials.co', 1),
(104, 'Book Distributors', 'Book Wholesaler', 'Mark Read', 'm.read@bookdist.com', 3);

-- Populating the 'products' table (depends on suppliers and categories)
INSERT INTO products (product_id, name, supplier_id, category_id, price) VALUES
(1001, 'Quantum Laptop', 101, 1, 1200.00),
(1002, 'Smart Watch V2', 101, 1, 250.50),
(2001, 'Denim Jacket', 102, 2, 89.99),
(3001, 'Smart Coffee Maker', 103, 3, 150.00),
(4001, 'The Last Question', 104, 4, 15.99); -- Corrected: Assigned a valid supplier_id

-- Populating the 'inventory' table
INSERT INTO inventory (location_id, product_id, quantity, last_updated, min_stock, min_order) VALUES
(1, 1001, 50, NOW(), 10, 20),
(2, 1002, 200, NOW(), 25, 50),
(3, 2001, 150, NOW(), 20, 30),
(4, 3001, 80, NOW(), 15, 15),
(5, 4001, 300, NOW(), 50, 100);

-- Populating the 'promotions' table
INSERT INTO promotions (promo_id, promo_name, description, product_id, discount_rate, start_date, end_date) VALUES
(1, 'Summer Sale', 'Summer discount on select electronics', 1002, 0.15, '2025-06-01', '2025-08-31'),
(2, 'Clearance', 'Clearance on last season jackets', 2001, 0.50, '2025-08-01', '2025-09-15');

-- Populating the 'product_history' table (e.g., a price change)
INSERT INTO product_history (history_id, product_id, name_old, description_old, price_old, category_old, valid_from, valid_to, change_type) VALUES
(1, 1001, 'Quantum Laptop', NULL, 1250.00, '1', '2023-01-01 00:00:00', '2024-01-15 09:00:00', 'PRICE_UPDATE');

-- Populating the 'orders' table
INSERT INTO orders (order_id, order_date, fulfillment_date, total_amount, payment_method_id, customer_id, employee_id, fulfillment_method) VALUES
(1, '2025-08-10 10:30:00', NULL, 266.49, 1, 1, 2, 1),
(2, '2025-08-11 14:00:00', '2025-08-11 14:30:00', 150.00, 2, 3, 2, 3),
(3, '2025-08-12 11:00:00', NULL, 15.99, 1, 2, 3, 1);

-- Populating the 'order_items' table
-- Order 1: Smart Watch + Jacket
INSERT INTO order_items (order_id, order_item_id, product_id, quantity, price_sold, subtotal) VALUES
(1, 1, 1002, 1, 250.50, 250.50),
(1, 2, 2001, 1, 15.99, 15.99);

-- Order 2: Coffee Maker
INSERT INTO order_items (order_id, order_item_id, product_id, quantity, price_sold, subtotal) VALUES
(2, 3, 3001, 1, 150.00, 150.00);

-- Order 3: Book
INSERT INTO order_items (order_id, order_item_id, product_id, quantity, price_sold, subtotal) VALUES
(3, 4, 4001, 1, 15.99, 15.99);
