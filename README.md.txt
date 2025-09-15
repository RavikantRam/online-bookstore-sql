# 📚 Online Bookstore SQL Project

## 📌 Project Overview
This project demonstrates the design and implementation of an **Online Bookstore database system** using PostgreSQL.  
It includes database schema creation, data import from CSV files, and a set of SQL queries ranging from simple retrievals to advanced reporting using **JOINs, Aggregations, and Filtering**.

The purpose of this project is to showcase practical SQL skills useful for real-world data management and analytics.

---

## 🗂️ Database Design
The project database consists of 3 main tables:

1. **Books**
   - Stores book details such as Title, Author, Genre, Published Year, Price, and Stock.  

2. **Customers**
   - Stores customer information such as Name, Email, Phone, City, and Country.  

3. **Orders**
   - Stores order details including Customer_ID, Book_ID, Order_Date, Quantity, and Total Amount.  
   - Maintains relationships with **Books** and **Customers** using Foreign Keys.  

---

## 📂 Project Files
- `onlineBookstore.sql` → Database schema, data import commands, and SQL queries.  
- `Books.csv` → Sample dataset of books.  
- `Customers.csv` → Sample dataset of customers.  
- `Orders.csv` → Sample dataset of orders.  

---

## 🚀 How to Run
1. Open **PostgreSQL** client (psql).  
2. Create the database:
   ```sql
   CREATE DATABASE OnlineBookstore;
   \c OnlineBookstore
