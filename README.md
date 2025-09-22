# 🛒 E-commerce Database Schema

This repository contains the SQL script for a simple relational database designed for an e-commerce store.  
The schema is built to manage core functionalities, including **customer data, product listings, order processing, and payment tracking**.

---

## 📂 Database Schema

The database is composed of six interconnected tables, each serving a specific purpose in the e-commerce system:

- **Customers**: Stores customer details like name, email, and phone number.  
- **Categories**: Manages different product categories to organize the inventory.  
- **Products**: Contains information about each product, including its price, description, and stock quantity.  
- **Orders**: Tracks customer orders, including the order date and status.  
- **OrderDetails**: A junction table that links `Orders` and `Products` to handle a many-to-many relationship, storing details about the specific items in an order.  
- **Payments**: Records payment information for each order, ensuring a one-to-one relationship with the `Orders` table.  

---

## 🔗 Table Relationships

The schema is designed with proper **primary keys** and **foreign keys** to enforce data integrity and define relationships:

- **Customers → Orders**: One customer can place many orders (**One-to-Many**).  
- **Categories → Products**: One category can contain many products (**One-to-Many**).  
- **Orders ↔ Products**: Many-to-Many relationship, managed via `OrderDetails`.  
- **Orders → Payments**: Each order has exactly one payment (**One-to-One**).  

---

## ⚙️ How to Use

To set up this database on your local machine, you will need to have **MySQL** installed.

1. **Save the file**  
   Save the provided SQL script as `e_commerce_db.sql`.

2. **Run the script**  
   Open your MySQL client (e.g., MySQL Command Line Client, MySQL Workbench) and execute the following command to create the database and all tables:

   ```sql
   SOURCE /path/to/your/file/e_commerce_db.sql;
   <img width="1024" height="1536" alt="E-commerce Database README Overview" src="https://github.com/user-attachments/assets/b6010419-d454-44f5-93bd-97700a390314" />

