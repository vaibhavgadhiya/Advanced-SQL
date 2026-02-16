create database SQLADVANCED;

use SQLADVANCED

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

select * from Sales

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');




--Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?

A Common Table Expression (CTE) is a temporary result set defined within the execution scope of a single SQL statement. 
It is created using the with clause and can be referenced like a table in a select, insert, update, or delete statement.

--How CTEs Improve SQL Query Readability

Breaks Complex Queries into Logical Blocks
Eliminates Deeply Nested Subqueries
Improves Maintainability
Allows Reuse Within the Same Query
Supports Recursive Queries

--Q2. Why are some views updatable while others are read-only? Explain with an example.

A view in SQL is a virtual table based on the result of a SELECT query.
Whether a view is updatable or read-only depends on how clearly SQL can map changes in the view back to a single underlying base table.

create view department_salary as
select department, SUM(salary) as total_salary
from employees
group by department;


--Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?

Stored procedures offer better performance, reusability, security, maintainability, and reduced network traffic compared to repeatedly writing raw SQL queries. 
They centralize business logic inside the database and support complex operations with better control and efficiency.


--Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.

A trigger is a special type of stored program that automatically executes (or “fires”) in response to specific events on a table or view.

--Purpose of Triggers

1. Enforce Business Rules
2. Maintain Data Integrity
3. Auditing & Logging Changes
4. Automate Related Actions

--Q5. Explain the need for data modelling and normalization when designing a database.

Data modelling is needed to design a clear and logical database structure by defining entities, attributes, and relationships.
Normalization is needed to organize data efficiently by reducing redundancy and preventing anomalies.
Together, they ensure a database is structured, consistent, efficient, and scalable.

--6. Write a CTE to calculate the total revenue for each product
 (Revenues = Price × Quantity), and return only products where  revenue > 3000.
 
 
with ProductRevenue as (select p.ProductID, p.ProductName, sum(p.Price * s.Quantity) as Revenue
    from Products as p
    join Sales as s on p.ProductID = s.ProductID
    group by p.ProductID, p.ProductName)

select * from ProductRevenue
where Revenue > 3000;

--Q7. Create a view named that shows: Category, TotalProducts, AveragePrice.

create view vw_CategorySummary as
select Category, count(*) as TotalProducts,
AVG(Price) as AveragePrice
from Products
group by Category;

--Q8. Create an updatable view containing ProductID, ProductName, and Price. Then update the price of ProductID = 1 using the view.

create view vw_Products as
select ProductID, ProductName, Price
from Products;

--update the price of the product with ProductID = 1

update vw_Products
set Price = 1300
where ProductID = 1;


Q9. Create a stored procedure that accepts a category name and returns all products belonging to that
category.

	create procedure GetProductsByCategory
    @CategoryName varchar(50) as begin
    select ProductID, ProductName, Category, Price
    from Products
    where Category = @CategoryName;
end;


Q10. Create an AFTER DELETE trigger on the Products table that archives deleted product rows into a new
table ProductArchive. The archive should store ProductID, ProductName, Category, Price, and DeletedAt
timestamp.

create table ProductArchive (
    ProductID int,
    ProductName varchar(100),
    Category varchar(50),
    Price decimal(10,2),
    DeletedAt datetime
);

create trigger trg_AfterDelete_Product
on Products after delete
as begin
insert into ProductArchive (ProductID, ProductName, Category, Price, DeletedAt)
select d.ProductID, d.ProductName, d.Category, d.Price,
GETDATE() as DeletedAt
from DELETED d;
end;










 
 


