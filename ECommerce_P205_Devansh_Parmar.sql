CREATE DATABASE ECommerce;
use ECommerce;

CREATE TABLE customers (
    customerID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(200) NOT NULL,
	password NVARCHAR(100) NOT NULL
);
-- Since there was no column named password in the Product Table, we have created a column for password on our own

INSERT INTO customers(customerID, name, Email, address, password)
VALUES
(1, 'John Doe', 'johndoe@example.com', '123 Main St, City', 'password123'),
(2, 'Jane Smith', 'janesmith@example.com', '456 Elm St, Town', 'wessword923'),
(3, 'Robert Johnson', 'robert@example.com', '789 Oak St, Village', 'securepass333'),
(4, 'Sarah Brown', 'sarah@example.com', '101 Pine St, Suburb', 'shopper123'),
(5, 'David Lee', 'david@example.com', '234 Cedar St, District', 'passpass333'),
(6, 'Laura Hall', 'laura@example.com', '567 Birch St, County', 'passwordpass999'),
(7, 'Michael Davis', 'michael@example.com', '890 Maple St, State', 'wordpassword123'),
(8, 'Emma Wilson', 'emma@example.com', '321 Redwood St, Country', 'password12345'),
(9, 'William Taylor', 'william@example.com', '432 Spruce St, Province', 'passpass123'),
(10, 'Olivia Adams', 'olivia@example.com', '765 Fir St, Territory', 'shoppingid123');
CREATE TABLE products (
    productID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
	Description VARCHAR(500) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stockQuantity INT NOT NULL
);

INSERT INTO products(productID, name, Description, price, stockQuantity)
VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);


CREATE TABLE cart (
    cartID INT PRIMARY KEY,
    customerID INT NOT NULL,
    productid INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (productid) REFERENCES products(productID)
);

INSERT INTO cart(cartID, customerID, productid, quantity)
VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);


CREATE TABLE orders (
    orderID INT PRIMARY KEY,
    customerID INT NOT NULL,
    orderDate DATETIME,
    totalAmount DECIMAL(10, 2) NOT NULL,
    shipping_address VARCHAR(200) NOT NULL,
	FOREIGN KEY (customerID) REFERENCES customers(customerID),
);
-- As there was no column named shipping address in the Orders table, we have added the column for the shipping address

INSERT INTO orders(orderID, customerID, orderDate, totalAmount, shipping_address)
VALUES
(1, 1, 2023-01-05, 1200.00, '123 Main St, City'),
(2, 2, 2023-02-10, 900.00, '456 Elm St, Town'),
(3, 3, 2023-03-15, 300.00, '789 Oak St, Village'),
(4, 4, 2023-04-20, 150.00, '101 Pine St, Suburb'),
(5, 5, 2023-05-25, 1800.00, '234 Cedar St, District'),
(6, 6, 2023-06-30, 400.00, '567 Birch St, County'),
(7, 7, 2023-07-05, 700.00, '890 Maple St, State'),
(8, 8, 2023-08-10, 160.00, '321 Redwood St, Country'),
(9, 9, 2023-09-15, 140.00, '432 Spruce St, Province'),
(10, 10, 2023-10-20, 1400.00, '765 Fir St, Territory');


CREATE TABLE order_items (
    orderItemID INT PRIMARY KEY,
    orderID INT NOT NULL, 
    productID INT NOT NULL,
    quantity INT NOT NULL,
	itemAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);
-- We have added a new column named itemAmount as it was present in the table

INSERT INTO order_items(orderItemID, orderID, productID, quantity, itemAmount)
VALUES
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);


-- 1. Update refrigerator product price to 800
UPDATE products 
SET price = 800 
WHERE name = 'Refrigerator';

-- 2. Remove all cart items for a specific customer
DELETE FROM cart 
WHERE customerID = 5;

-- 3. Retrieve products priced below $100
SELECT * 
FROM products 
WHERE price < 100;

-- 4. Find products with stock quantity greater than 5
SELECT * 
FROM products 
WHERE stockQuantity > 5;

-- 5. Retrieve orders with total amount between $500 and $1000
SELECT * 
FROM orders 
WHERE totalAmount BETWEEN 500 AND 1000;

--6. Find products which name ends with letter ‘r’
SELECT * 
FROM products 
WHERE name LIKE '%r';

-- 7. Retrieve cart items for customer 5
SELECT * 
FROM cart 
WHERE customerID = 5;

-- 8. Find customers who placed orders in 2023
SELECT DISTINCT c.* 
FROM customers c 
JOIN orders o ON c.customerID = o.customerID 
WHERE YEAR(o.orderDate) = 2023;


-- 9. Determine the minimum stock quantity for each product category
SELECT MIN(stockQuantity) AS min_stock_quantity 
FROM products;

-- 10. Calculate the total amount spent by each customer
SELECT c.customerID, name, SUM(o.totalAmount) AS total_spent 
FROM customers c 
JOIN orders o ON c.customerID = o.customerID 
GROUP BY c.customerID, c.name;

-- 11. Find the average order amount for each customer
SELECT c.customerID, name, AVG(o.totalAmount) AS avg_order_amount 
FROM customers c 
JOIN orders o ON c.customerID = o.customerID 
GROUP BY c.customerID, c.name;

-- 12. Count the number of orders placed by each customer
SELECT c.customerID, name, COUNT(o.orderID) AS order_count 
FROM customers c 
JOIN orders o ON c.customerID = o.customerID 
GROUP BY c.customerID, c.name;

-- 13. Find the maximum order amount for each customer
SELECT c.customerID, name, MAX(o.totalAmount) AS max_order_amount 
FROM customers c 
JOIN orders o ON c.customerID = o.customerID 
GROUP BY c.customerID, c.name;

-- 14. Get customers who placed orders totaling over $1000
SELECT c.customerID, name 
FROM customers c 
JOIN orders o ON c.customerID = o.customerID 
GROUP BY c.customerID, c.name 
HAVING SUM(o.totalAmount) > 1000;

-- 15. Subquery to find products not in the cart
SELECT * 
FROM products p 
WHERE p.productID NOT IN (SELECT productID FROM cart);

-- 16. Subquery to find customers who haven't placed orders
SELECT * 
FROM customers c 
WHERE c.customerID NOT IN (SELECT customerID FROM orders);

-- 17. Subquery to calculate the percentage of total revenue for a product
SELECT p.name, 
       (SUM(oi.quantity * p.price) / (SELECT SUM(totalAmount) FROM orders)) * 100 AS revenue_percentage 
FROM products p 
JOIN order_items oi ON p.productID = oi.productID 
GROUP BY p.name;

-- 18. Subquery to find products with low stock
SELECT * 
FROM products p 
WHERE p.stockQuantity < (SELECT AVG(stockQuantity) FROM products);

-- 19. Subquery to find customers who placed high-value orders
SELECT DISTINCT c.* 
FROM customers c 
WHERE c.customerID IN (SELECT o.customerID FROM orders o WHERE o.totalAmount > 500);