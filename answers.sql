--
-- E-commerce Database Schema
--
-- This script creates a relational database for a simple e-commerce store,
-- demonstrating various table relationships and constraints.

-- 1. CREATE DATABASE
-- -----------------------------------------------------------------------------
CREATE DATABASE e_commerce_db;
USE e_commerce_db;

-- 2. CREATE TABLES
-- -----------------------------------------------------------------------------

-- `Customers` Table: Stores customer information.
-- Establishes a One-to-Many relationship with the `Orders` table.
CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- `Categories` Table: Stores product categories.
-- Establishes a One-to-Many relationship with the `Products` table.
CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- `Products` Table: Stores product details.
-- Establishes a Many-to-Many relationship with the `Orders` table
-- (via the `OrderDetails` junction table) and a One-to-Many with `Categories`.
CREATE TABLE Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

-- `Orders` Table: Stores order information.
-- Establishes a One-to-Many relationship with `OrderDetails` and `Payments`,
-- and a One-to-Many with `Customers`.
CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Pending', 'Shipped', 'Delivered')),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- `OrderDetails` Table: A junction table to handle the Many-to-Many relationship
-- between `Orders` and `Products`. It stores the specific products within an order.
CREATE TABLE OrderDetails (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    UNIQUE (order_id, product_id) -- Ensures a product isn't added twice to the same order
);

-- `Payments` Table: Stores payment information for each order.
-- Establishes a One-to-One relationship with the `Orders` table.
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL UNIQUE, -- UNIQUE constraint enforces the One-to-One relationship
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- 3. SUMMARY OF RELATIONSHIPS
-- -----------------------------------------------------------------------------
-- - `Customers` to `Orders`: One-to-Many. One customer can have many orders.
-- - `Categories` to `Products`: One-to-Many. One category can have many products.
-- - `Orders` to `Products`: Many-to-Many, handled by `OrderDetails`. One order can have many products, and one product can be in many orders.
-- - `Orders` to `Payments`: One-to-One. Each order has exactly one payment.
