# Views_and_SQL_Abstraction_07
SQL project focused on creating and using views for data abstraction, security, and report generation using an E-commerce database in advanced SQL learning series.
## Task 07: Creating Views  
### E-commerce SQL Project – Views and Abstraction

This project demonstrates how to create and use **SQL Views** for **data abstraction**, **security**, and **reporting** using an E-commerce database. It is part of Task 07 in an advanced SQL learning series.

---

##  Objective

- Define and use **views** in SQL
- Abstract complex SQL queries into reusable virtual tables
- Enhance data security by exposing only relevant information
- Practice reporting and summary generation through views
  
---

## Tools Used

- MySQL Workbench / DB Browser for SQLite  
- SQL (Structured Query Language)  
- Git & GitHub for version control  
- ER Diagram (optional visualization)

---

##  Files Included

| File Name                                      | Description                                               |
| ---------------------------------------------- | --------------------------------------------------------- |
| `ecommerce_database.sql`                       | Script to create and populate the E-commerce database     |
| `Views_and_SQL_Abstraction_07.sql`             | View definitions, view-based queries, and drop statements |
| `Total paid by each customer_07.csv`           | Output for customer summary view                          |
| `Most sold products_07.csv`                    | Output for product sales summary                          |
| `Recent delivery items _07.csv`                | Output for delivered orders view                          |
| `List of active payments above ₹10,000_07.csv` | Output for filtered payments view                         |
| `ER_Diagram.png`                               | Visual schema of the database (optional)                  |

---

## Key Concepts Covered

###  Views
- Virtual tables created using `SELECT` queries
- Simplify complex joins and filters
- Provide limited access to data (security layer)

###  Scalar Views & Abstraction
- Allows reusable components for frequent reports
- Keeps queries clean and manageable

###  WITH CHECK OPTION
-  Ensures that inserted/updated data through a view satisfies the view's condition
---

##  Sample Views

### 1. **Customer Order Summary**
``CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(p.amount) AS total_paid
FROM Customer c
LEFT JOIN `Order` o ON c.customer_id = o.customer_id
LEFT JOIN Payment p ON o.order_id = p.order_id AND p.status = 'Paid'
GROUP BY c.customer_id, c.name; ``

### 2. Product Sales Summary
``
CREATE VIEW product_sales_summary AS
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.quantity * oi.price_at_purchase) AS revenue_generated
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;
``
### 3. Delivered Orders View
`` CREATE VIEW delivered_orders AS
SELECT 
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.status = 'Delivered';
``
### 4. Active Payments View
`` 
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
``
## Usage Examples
-- Total paid by each customer
`SELECT * FROM customer_order_summary;`

-- Most sold products
`SELECT * FROM product_sales_summary ORDER BY total_sold DESC;`

-- Recent delivered orders
` SELECT * FROM delivered_orders ORDER BY order_date DESC;`

-- Active payments above ₹10,000
` SELECT * FROM active_payments WHERE amount > 10000;`

## Dropping Views
sql
``
DROP VIEW IF EXISTS customer_order_summary;
DROP VIEW IF EXISTS product_sales_summary;
DROP VIEW IF EXISTS delivered_orders;
DROP VIEW IF EXISTS active_payments;
``
## Securing Views with WITH CHECK OPTION
`` 
CREATE VIEW only_shipped_orders AS
SELECT * FROM `Order`
WHERE status = 'Shipped'
WITH CHECK OPTION;
``
