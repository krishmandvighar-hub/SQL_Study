------------------basic rules-----------------------
use kris
create database kris;

create table students(Id int,Name VARCHAR(50),Age int,Address VARCHAR(250));
insert into students(Id, Name, Age, Address)
values(5,'krishna',17,'Mumbai');
delete from students where Id=2;
select * from students

--Note: Most of the SQL database programs also have their own proprietary extensions in addition to the SQL standard!

------------------------------------create database and use-----------------
create database kris;
use kris
------------------------------------create table----------------------------

create table customers(CustomerID int,CustomerName VARCHAR(50),	ContactName VARCHAR(50),
Address VARCHAR(50),City VARCHAR(50),PostalCode VARCHAR(50),Country VARCHAR(50));

----------------------------------0.SQL insert into values-------------------
insert into customers (CustomerID ,CustomerName,ContactName,
Address,City,PostalCode,Country)
values(1,'Alfreds Futterkiste','Maria Anders','Obere Str. 57','Berlin','12209','Mexico'),
(2,'Ana Trujillo Emparedados y helados','Ana Trujillo','Avda. de la Constitución 2222','México D.F.','05021','Mexico'),
(3,'Antonio Moreno Taquería','Antonio Moreno','Mataderos 2312','México D.F.','05023','Mexico'),
(4,'Around the Horn','Thomas Hardy','120 Hanover Sq.','London','WA1 1DP','UK'),
(5,'Berglunds snabbköp','Christina Berglund','Berguvsvägen 8','Luleå','S-958 22',NULL);
--Notice that we did not insert any number into the CustomerID field!

--The CustomerID column is an auto-increment field and will be automatically generated when a new record is inserted.
-----------------------------------1.SQL select ------------------------------
select * from customers
select Country from Customers;

-----------------------------------2.SQL 0 with DISTINCT-----------------
select count(distinct Country )from customers
--Note: The COUNT(DISTINCT column_name) is not supported in Microsoft Access databases.
-----------------------------------3.SQL where--------------------------------
select * from customers
where country='Mexico';

select * from customers
where CustomerID>3;
--Note: The WHERE clause is not only used in SELECT statements, it is also used in UPDATE, DELETE, etc.
-----------------------------------4.SQL Order by(Sorting) -------------------
select * from customers
order by Country;

--multiple condition and also using asc,desc
select * from customers
order by City asc,CustomerName desc;

-----------------------------------5.SQL And----------------------------------
select * from customers
where country='Mexico' and CustomerName like 'a%' and CustomerID<5;
--Note: The AND operator displays a record if "all" the conditions are TRUE.
-----------------------------------6.SQL OR-----------------------------------
select * from customers
where country='Mexico' or CustomerName like 'a%' or CustomerID<5;
--Note: The OR operator displays a record if "any" of the conditions are TRUE.
--combining And,Or
select * from customers
where country='Mexico' and (CustomerName like 'a%' or CustomerID<4);

select * from customers
where country='Mexico' and CustomerName like 'a%' or CustomerID<4;

-----------------------------------7.SQL Not---------------------------------
select * from customers
where not Country ='Mexico';

--Not LIKE
select * from customers
where  CustomerName not like 'a%';

--Not between
select * from customers
where CustomerId not between 2 and 4 ;

--Not in
select * from customers
where City not in ('London','Paris');
----------------------------------8. SQL Null values---------------------------
select CustomerName,ContactName,Address from customers
where Address is null;

select CustomerName,ContactName,Address from customers
where Address is not null;
--Note: A NULL value is different from zero (0) or an empty string (''). A field with a
--NULL value is one that has been left blank upon record creation.
----------------------------------9.SQL update---------------------------------
select * from customers
update customers
set Country='UK'
where CustomerId=5;
---------------------------------10.SQL delete---------------------------------
DELETE FROM Orders;

-----------------------------new product and order data table------------------------
create table products(ProductID int, ProductName VARCHAR(50), SupplierID int, CategoryID int, Unit VARCHAR(50), Price int);
drop table products
insert into products
values(1,'Chais',1,1,'10 boxes x 20 bags',18),
(2,'Chang',2,1,'24 - 12 oz bottles',19),
(3,'Aniseed Syrup',3,2,'12 - 550 ml bottles',10),
(4,'Chef Antons Cajun Seasoning',4,2,'48 - 6 oz jars',22),
(5,'Chef Antons Gumbo Mix',5,2,'36 boxes',21);

select * from products;

create table Orders(OrderDetailID int,	OrderID int,ProductID int,	Quantity int,OrderDate VARCHAR(50),CustomerID int,EmployeeID int)
insert into Orders
values(1,10248,11,12,'1996-07-04',1,5),
(2,10248,42,10,'1996-07-05',2,6),
(3,10248,72,5,'1996-07-08',3,4),
(4,10249,14,9,'1996-07-08',4,3),
(5,10249,51,40,'1996-07-09',5,4),
(6,10250,41,10,'1996-07-10',9,3),
(7,10250,51,35,'1996-07-11',12,9),
(8,10250,65,15,'1996-07-12',13,3),
(9,10251,22,6,'1996-07-15',15,4),
(10,10251,57,15,'1996-07-16',16,1);

select * from Orders;

-----------------------------11.SQL SELECT TOP------------------------------------
select top 3 * from products;

-----------------------------12.SQL MIN()-----------------------------------------
select min(Price) as SmallestPrice
from products;

-----------------------------12.SQL MAX()-----------------------------------------
select max(Price) as [Highest Price]
from products;

-----------------------------12.SQL COUNT()---------------------------------------
select count(Price) as [No of records]
from products;

--for unique no , we previously used distinct with count

-----------------------------12.SQL SUM()-----------------------------------------
select sum(Quantity) as [Total Quantity]
from Orders;
--with sign
select sum(Quantity * 10) as [Total Quantity]
from Orders;

-----------------------------12.SQL AVG()-----------------------------------------
select avg(Price) as [Average of Price]
from products;
---Higher Than Average
select * from products
where Price > (select avg(Price) from products);

---------------------------13.SQL LIKE Operator-----------------------------------
--- starts with the letter "a" with wildcard %
select * from customers
where CustomerName like 'a%';

-- contains the character sequence 'on' with wildcard %
select * from customers
where city like '%on%';

-- ends with the letter "a" with wildcard %
select * from customers
where CustomerName like '%a';

-- combine start and end 
select * from customers
where CustomerName like 'b%s';

-- ' _ 'represents one, and only one, character with wildcard _
select * from customers
where City like 'l_nd__';

--combine wildcards
select * from customers
where CustomerName like 'a__%';

--without wildcards
select * from customers
where Country like 'London';

----------------------------14.SQL WILDCARDS-----------------------------------
--EXTRA WILDCARDS EXAMPLE
SELECT * FROM customers
WHERE CustomerName LIKE '[bsp]%';

SELECT * FROM customers
WHERE CustomerName LIKE '[a-f]%';
----------------------------15.SQL IN-----------------------------------------
SELECT * FROM customers
WHERE Country IN ('Germany', 'France', 'UK');

SELECT * FROM customers
WHERE CustomerID IN (SELECT CustomerID FROM orderdetails);
----------------------------16.SQL BETWEEN------------------------------------
SELECT * FROM products
WHERE Price BETWEEN 10 AND 20
----------------------------17.SQL ALIASES(rename as)-------------------------
SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM customers;
----------------------------18.SQL JOIN---------------------------------------
SELECT Orders.OrderID, customers.CustomerName, Orders.OrderDate
FROM Orders
JOIN customers
ON Orders.CustomerID=customers.CustomerID;

----------------------------19.SQL INNER JOIN---------------------------------
SELECT Orders.OrderID, customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN customers
ON Orders.CustomerID=customers.CustomerID;--condition

----------------------------20.SQL LEFT JOIN----------------------------------
SELECT customers.CustomerName, Orderds.OrderID
FROM customers
LEFT JOIN Orderds
ON customers.CustomerID = Orderds.CustomerID
WHERE Orderds.CustomerID IS NULL;

----------------------------21.SQL RIGHT JOIN---------------------------------
CREATE TABLE Employees(EmployeeID INT,LastName VARCHAR(50),FirstName VARCHAR(50),
BirthDate VARCHAR(50),Photo VARCHAR(50))
INSERT INTO Employees
VALUES(1,'Davolio','Nancy','1968-12-08','EmpID1.pic'),
(2,'Fuller','Andrew','1952-02-19','EmpID2.pic'),
(3,'Leverling','Janet','1963-08-30','EmpID3.pic'),
(4,'Peacock','Margaret','1958-09-19','EmpID4.pic'),
(5,'Buchanan','Steven','1955-03-04','EmpID5.pic');

SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;

----------------------------22.SQL FULL JOIN----------------------------------
SELECT customers.CustomerName, Orders.OrderID
FROM customers
FULL JOIN Orders
ON customers.CustomerID = Orders.CustomerID;
----------------------------23.SQL SELF JOIN----------------------------------
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;

----------------------------24.SQL UNION--------------------------------------
--new data base
Create table Suppliers(SupplierID int,SupplierName VARCHAR(50),ContactName VARCHAR(50),
Address VARCHAR(50),City VARCHAR(50),PostalCode VARCHAR(50),Country VARCHAR(50));

Insert into Suppliers
Values(1,'Exotic Liquid','Charlotte Cooper','49 Gilbert St.','London','EC1 4SD','UK'),
(2,'New Orleans Cajun Delights','Shelley Burke','P.O. Box 78934','New Orleans','70117','USA'),
(3,'Grandma Kellys Homestead','Regina Murphy','707 Oxford Rd.','Ann Arbor',	'48104','USA'),
(4,'Tokyo Traders','Yoshi Nagase','9-8 Sekimai Musashino-shi','Tokyo','100','Japan'),
(5,'Cooperativa de Quesos Las Cabras','Antonio del Valle Saavedra','Calle del Rosal 4','Oviedo','33007','Spain');

select * from Suppliers--display
--union
select Country from customers
Union
select Country from Suppliers 
Order By Country desc ;

SELECT City, Country FROM Customers
WHERE Country='UK'
UNION
SELECT City, Country FROM Suppliers
WHERE Country='UK'
ORDER BY City;
----------------------------25.SQL UNION ALL--------------------------------------
select Country from customers
Union all
select Country from Suppliers 
Order By Country desc ;

SELECT City, Country FROM Customers
WHERE Country='UK'
UNION all
SELECT City, Country FROM Suppliers
WHERE Country='UK'
ORDER BY City;


----------------------------26.SQL GROUP BY --------------------------------------
SELECT Country, COUNT(CustomerID) AS [Number of Customers]
FROM Customers
GROUP BY Country;

SELECT City, COUNT(CustomerID) AS [Number of Customers]
FROM Customers
GROUP BY City
ORDER BY City DESC;

----------------------------27.SQL HAVING -------------------------------------

SELECT Country, COUNT(CustomerID) AS [Number of Customers]
FROM customers
GROUP BY Country
HAVING COUNT(CustomerID) > 2
ORDER BY COUNT(CustomerID) DESC;

----------------------------28.SQL EXISTS -------------------------------------
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (
  SELECT ProductName
  FROM products
  WHERE products.SupplierID = Suppliers.SupplierID AND Price > 20
);

select * from products;
select * from Suppliers;
select * from Orders;
---------------------------29.SQL ANY------------------------------------------
select ProductName from products
where ProductId=any(select ProductId from Orders where Quantity>10);


----------------------------30.SQL ALL-----------------------------------------

select ProductName from products
where ProductId=all(select ProductId from Orders where Quantity=10);

---------------------------31.SQL SELECT INTO----------------------------------
SELECT * INTO CustomersBackup2026 
FROM customers;

--specific data if you want 
select SupplierID,SupplierName into Suppliersbackup2026
from Suppliers;

---MS Access 
--SELECT * INTO CustomersBackup IN 'KRISH.mdb' FROM customers; 

SELECT *
INTO KRISH.dbo.CustomersBackup
FROM Customers;

--------------------------32.SQL INSERT INTO SELECT-----------------------------
INSERT INTO customers(CustomerName, City, Country, Email)
SELECT SupplierName,City,Country,'unknown@example.com'
FROM Suppliers
WHERE Country = 'UK';
--------------------------33.SQL CASE-------------------------------------------
SELECT ProductName, Price,
CASE
  WHEN Price < 15 THEN 'Low Cost'
  WHEN Price BETWEEN 15 AND 20 THEN 'Medium Cost'
  ELSE 'High Cost'
END AS PriceCategory
FROM products;

--------------------------34.SQL NULL Functions---------------------------------
--COALESCE() - The preferred standard.
--IFNULL() - (MySQL)
--ISNULL() - (SQL Server)
--NVL() - (Oracle)
--IsNull() - (MS Access)

--------------------------35.SQL Stored Procedures------------------------------
CREATE PROCEDURE GetCustomersByCity
  @City nvarchar(50)
AS
BEGIN
  SELECT * FROM customers
  WHERE City = @City;
END;


EXEC GetCustomersByCity @City = 'London';

--------------------------36.SQL Comments---------------------------------------
SELECT * FROM customers -- WHERE City='Berlin';
/* Selects all German customers
from Berlin */
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin';

--------------------------37.SQL BACKUP-----------------------------------------
Backup database customers
to disk =''
with differential;

------------------------38.SQL DROP TABLE---------------------------------------
drop table customers;

--To prevent an error from occur
drop table if exists customers;

--note TRUNCATE TABLE 
--The TRUNCATE TABLE statement is used to delete all the records in a table,
--but it keeps the table structure, columns and constraints.

truncate table customers;

--------------------------39.SQL ALTER TABLE-------------------------------------
--ALTER TABLE - ADD Column

alter table customers
add email VARCHAR(50);

--ALTER TABLE - DROP COLUMN
alter table customers
drop column email;

--ALTER TABLE - RENAME COLUMN
EXEC sp_rename 'customers.email', 'Email', 'COLUMN';

--ALTER TABLE customers RENAME COLUMN Email TO email;

--ALTER TABLE - Rename table
--ALTER TABLE Customers RENAME TO Clients;
EXEC sp_rename 'customers', 'Clients';

--ALTER TABLE - MODIFY Datatype
update customers
set Email = 'kris@gmail.com';
ALTER TABLE Customers
ALTER COLUMN Email varchar(100) NOT NULL;

-----------------------------40.SQL CONSTRAINT -----------------------------------
/*
NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are unique
PRIMARY KEY - Uniquely identifies each row in a table (a combination of a NOT NULL and UNIQUE)
FOREIGN KEY - Establishes a link between data in two tables, and prevents action that will destroy the link between them
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
CREATE INDEX - Creates indexes on columns to retrieve data from the database faster
*/

----------------------------41.SQL NOT NULL----------------------------------------------
--The NOT NULL constraint enforces a column to NOT accept NULL values.
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int
);
insert into Persons
values(1,'Mandvighar','kris',19),(2,'Kharja','Delroy',14),
(3,'Kharja','Royan',11),(4,'Dudek','Alson',14);
----------------------------42.SQL UNIQUE Constraint---------------------------------------
--for singular 
CREATE TABLE Workers (
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);
-- for multiple 
CREATE TABLE Staffs (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT UC_Person UNIQUE (ID,LastName)
);

-------------43.SQL Primary key Constraint & 40.SQL Foreign key Constraint-------------------
CREATE TABLE Orders (
    OrderID int PRIMARY KEY,
    OrderNumber int NOT NULL,
    PersonID int,
    CONSTRAINT fk_Person
    FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID)
);
----------------------------44.SQL Check Constraint----------------------------------------
CREATE TABLE Persons (
    ID int PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT chk_PersonAge CHECK (Age >= 18 AND City = 'Sandnes')
);
----------------------------45.SQL Defualt Constraint--------------------------------------
CREATE TABLE Persons (
    ID int PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT 'Sandnes'
);
----------------------------46.SQL CreateIndex Constraint----------------------------------
CREATE INDEX idx_lname_fname
ON Persons (LastName, FirstName);

SELECT * FROM Persons
WHERE LastName = 'Dudek';

----------------------------47.SQL Auto increment Constraint-------------------------------
CREATE TABLE Persons (
    ID int identity (1,1) PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT 'Sandnes'
);
----------------------------48.SQL Date----------------------------------------------------
--SQL Server has the following date data types:

--DATE - format YYYY-MM-DD
--DATETIME - format: YYYY-MM-DD HH:MI:SS
--SMALLDATETIME - format: YYYY-MM-DD HH:MI:SS
--TIME - format: HH:MI:SS
--TIMESTAMP - format: a unique number


----------------------------49.SQL View----------------------------------------------------

CREATE VIEW [UK Customers] AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'UK';

select * from [UK Customers];

-----------------------------50.SQl Injection-------------------------------------------------
--SQL injection is a code injection technique that can destroy your database.
-- SQL injections are a common web hacking technique.

SELECT * FROM Customers WHERE CustomerName ='' or ''='' AND ContactName ='' or ''=''

SELECT * FROM Customers WHERE CustomerId = 7 OR 1=1;
---------------------------51.SQL Parameters--------------------------------------------------
--SQL Parameters :- Prevent SQL Injection
--SQL parameters (Parameterized Queries) can be used to protect a web site from SQL injections.
--Most databases support parameterized queries, but the syntax varies:

--MySQL use ? for parameters
--SQL Server uses @ for parameters
--PostgreSQL uses $ for parameters

-------------------------52.SQL Prepared Statements---------------------------------------------
--Defination :- Prepared Statements are precompiled SQL queries that use parameters instead of 
--              hard-coded values, providing better performance, reusability,
--              and protection against SQL injection attacks.

--Example :-
DECLARE @EmpID INT = 101;

SELECT *
FROM Employees
WHERE EmployeeID = @EmpID;

---------------------------53.SQL HOSTING-------------------------------------------------------
--Defination :-SQL Hosting is a service that hosts SQL databases on a server, allowing applications and 
--             users to access, manage, and store data through SQL queries over a network or the internet.
