-- DATABASE ON E-COMMERCE 
CREATE DATABASE Ecommerce;
-- Step 1: Select the database
USE Ecommerce;
-- Step 2: Create the Customer table
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT
);
DESCRIBE Customer;
SELECT * FROM Customer;

-- Step 3: Create the Product Table
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

-- Step 4: Create the Order Table
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Step 4: Create the Payment Table 
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50), -- e.g., UPI, Credit Card, COD
    amount DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'Paid',
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

-- Step 5: Create the OrderItem Table (junction table between Order and Product)
CREATE TABLE OrderItem (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

SHOW TABLES;

-- Insert into customer
INSERT INTO Customer (name, email, phone, address) VALUES
('Aman Sharma', 'aman.sharma@example.com', '9876543210', 'Delhi'),
('Priya Verma', 'priya.verma@example.com', '8765432109', 'Mumbai'),
('Ravi Kumar', 'ravi.kumar@example.com', '7654321098', 'Bangalore'),
('Sneha Reddy', 'sneha.reddy@example.com', '9988776655', 'Hyderabad'),
('Aditya Mehta', 'aditya.mehta@example.com', '9090909090', 'Ahmedabad');

-- Insert into Product
INSERT INTO Product (name, description, price, stock) VALUES
('Laptop', 'HP Pavilion 15 - 11th Gen Intel i5', 58999.00, 15),
('Smartphone', 'Redmi Note 13 Pro', 23999.00, 30),
('Headphones', 'boAt Airdopes 141', 1499.00, 50),
('Bluetooth Speaker', 'JBL Flip 6', 8999.00, 20),
('Backpack', 'Wildcraft 35L Laptop Backpack', 1599.00, 25);

-- Insert into Order
INSERT INTO `Order` (customer_id, order_date, status) VALUES
(1, NOW(), 'Confirmed'),
(2, NOW(), 'Shipped'),
(3, NOW(), 'Pending'),
(4, NOW(), 'Delivered'),
(5, NOW(), 'Cancelled');

-- Insert into Payment
INSERT INTO Payment (order_id, payment_method, amount, status) VALUES
(1, 'UPI', 62197.00, 'Paid'),
(2, 'Credit Card', 23999.00, 'Paid'),
(3, 'COD', 2998.00, 'Pending'),
(4, 'UPI', 10598.00, 'Paid'),
(5, 'Credit Card', 23999.00, 'Refunded');

-- Insert into orderItem
INSERT INTO OrderItem (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 58999.00),
(1, 5, 2, 1599.00),
(2, 2, 1, 23999.00),
(3, 3, 2, 1499.00),
(4, 4, 1, 8999.00),
(4, 5, 1, 1599.00),
(5, 2, 1, 23999.00);

SELECT 
    o.order_id,
    c.name AS customer_name,
    p.name AS product_name,
    oi.quantity,
    oi.price_at_purchase,
    o.status,
    o.order_date
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN OrderItem oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id;

SELECT 
    o.order_id,
    c.name AS customer_name,
    o.status AS order_status,
    pmt.payment_method,
    pmt.amount,
    pmt.status AS payment_status,
    o.order_date
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
LEFT JOIN Payment pmt ON o.order_id = pmt.order_id;

SHOW DATABASES;