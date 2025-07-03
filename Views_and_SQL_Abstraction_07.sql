USE Ecommerce;
-- Create veiw 
-- View 1: Customer Order Summary
CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(p.amount) AS total_paid
FROM Customer c
LEFT JOIN `Order` o ON c.customer_id = o.customer_id
LEFT JOIN Payment p ON o.order_id = p.order_id AND p.status = 'Paid'
GROUP BY c.customer_id, c.name;

-- View 2: Product Sales Summary
CREATE VIEW product_sales_summary AS
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.quantity * oi.price_at_purchase) AS revenue_generated
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;

-- View 3: Delivered Orders
CREATE VIEW delivered_orders AS
SELECT 
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.status = 'Delivered';

-- View 4: View for Active Payments
CREATE VIEW active_payments AS
SELECT 
    p.payment_id,
    p.order_id,
    c.name AS customer_name,
    p.payment_method,
    p.amount,
    p.status
FROM Payment p
JOIN `Order` o ON p.order_id = o.order_id
JOIN Customer c ON o.customer_id = c.customer_id
WHERE p.status = 'Paid';

-- 2. Queries Using Views
-- Total paid by each customer:
SELECT * FROM customer_order_summary;
-- Most sold products:
SELECT * 
FROM product_sales_summary 
ORDER BY total_sold DESC;
--  Recently delivered orders:
SELECT * 
FROM delivered_orders 
ORDER BY order_date DESC;

-- List of active payments above ₹10,000:
SELECT * 
FROM active_payments 
WHERE amount > 10000;

-- 3. Dropping Views
DROP VIEW IF EXISTS customer_order_summary;
DROP VIEW IF EXISTS product_sales_summary;
DROP VIEW IF EXISTS delivered_orders;
DROP VIEW IF EXISTS active_payments;


CREATE VIEW only_shipped_orders AS
SELECT * FROM `Order`
WHERE status = 'Shipped'
WITH CHECK OPTION;

DROP VIEW IF EXISTS only_shipped_orders;




