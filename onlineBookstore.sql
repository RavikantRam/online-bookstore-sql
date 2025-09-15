-- create database
create database OnlineBookstore;

-- Switch to database
\c OnlineBookstore

-- create tables 
drop table if exists Books;
create table Books (
	Book_ID serial primary key,
	Title varchar(100),
	Author varchar(100),
	Genre varchar(100),
	Published_Year int,
	Price  numeric(10,2),
	Stock int
);

drop table if exists customers;
create table customers(
	Customer_ID serial primary key,
	Name varchar(100),
	Email varchar(100),
	Phone varchar(100),
	City varchar(100),
	Country varchar(100)
);

drop table if exists Orders;
create table Orders(
	Order_ID serial primary key,
	Customer_ID int references Customers(Customer_ID),
	Book_ID int references Books (Book_ID),
	Order_Date date,
	Quantity int,
	Total_Amount numeric(10,2)
);

select * from Books;

select * from Customers;

select* from Orders;

-- import data in the Books table
COPY Books (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:/PostgressSQL/SQL project/Books.csv'
DELIMITER ','
CSV HEADER;


-- import data in the customer table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'D:/PostgressSQL/SQL project/Customers.csv'
DELIMITER ','
CSV HEADER;


-- import data in the Orders
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'D:/PostgressSQL/SQL project/Orders.csv'
DELIMITER ','
CSV HEADER;
---------------------------------------------------------------------------------------------------------

-- retrive all the books in the 'fiction genre'
select * from books 
where genre ='Fiction';

-- find the book which published after 1950
select * from books
where published_year>'1950';

-- list all customers from the canada
select * from customers
where country='Canada';

-- show the orders placed in november 2023
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

--retrive the total stock of books available.
select sum(stock) as total_stocks_of_books
from Books;

-- find the details of most expensive books
select * from Books order by price  desc limit 1;

-- show all customers who order more then 1 books
select * from orders
where quantity>1;

-- retrive all orders where the total amount exceeds $20
select * from orders;
where total_amount>20;

-- list all genre available in books table
select distinct genre from books;

-- find the book by with lowest stock
select * from Books order by stock  asc limit 1;

-- calcuate total revenue genrated from all orders
select sum(total_amount) as tota_revenue
from orders;

--Adavaced Questions

--retrive the total number of  books sold for each genre
select * from orders;
select * from books;

select b.genre,sum(o.quantity) as total_books_sold
from orders o
join books b on o.book_id=b.book_id
group by b.genre;

-- find the avg price of books in the "Fantasy " genre
select avg(price) as avg_price
from books
where genre='Fantasy';

--list customers who has placed at list 2 orders;
select customer_id, count(order_id)as order_count
from orders
group by customer_id
having count(order_id) >=2;

-- find the most frequently ordered book

select b.title, sum(o.quantity) as total_quantity_sold
from orders o
join books b on o.book_id=b.book_id
group by b.title
order by total_quantity_sold
limit 1;

select book_id,count(order_id) as order_count
from orders
group by book_id
order by order_count desc limit 1;

--show the top 3 most expensive books of 'Fantasy' genre
select *from books
where genre='Fantasy'
order by price desc limit 3 ;

--retrive the total quantity of books sold by each author
select b.author, sum(o.quantity) as total_books_sold
from orders o
join books b on o.book_id=b.book_id
group by b.author;

-- list the cities whre customers who spent over $30 are located
select distinct c.city,total_amount
from orders o
join customers c on o.customer_id=c.customer_id
where o.total_amount>30;

-- find the customers who spent most on orders
select c.customer_id,c.name,sum(o.total_amount) as total_spent
from orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_id,c.name
order by total_spent desc;

--calculate the stock reasoinig after fulfillling all orders
SELECT 
    b.book_id, 
    MAX(b.title) AS title, 
    MAX(b.stock) AS stock,
    COALESCE(SUM(o.quantity), 0) AS order_quantity,
    MAX(b.stock) - COALESCE(SUM(o.quantity), 0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;
