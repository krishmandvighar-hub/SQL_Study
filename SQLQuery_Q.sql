--1 .Give the Answers
--a. what is primary key ?
--ans: A primary key is a column that gives each row a unique identity.

--b. why is it important ?
--ans:I. It helps identify each record uniquely.
--II. It prevents duplicate records.
--III. Its makes finding data easier and faster.

--c. What is the difference between primary and foreign keys?
--| Primary Key                              | Foreign Key                            |
--| ---------------------------------------- | -------------------------------------- |
--| Uniquely identifies a record in a table. | Connects one table to another.         |
--| Must be unique.                          | Can have duplicate values.             |
--| Cannot be NULL.                          | Can be NULL (depending on the design). |


--2.What are Constraints in SQL Server?
--ans: Constraints are rules applied to columns to maintain data integrity.

--Types:

--PRIMARY KEY
--FOREIGN KEY
--UNIQUE
--NOT NULL
--DEFAULT
--CHECK
--UNIQUE Constraint

--Ensures all values in a column are unique.
--Data Integrity means the data stored in a database is accurate, correct, consistent, and reliable.

create database KRISH;

--Q2. Create Students Table

CREATE TABLE Student
    (ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);

--Q3. Insert 5 Records
INSERT INTO Student VALUES
(1,'Rahul',20,'Mumbai'),
(2,'Priya',21,'Delhi'),
(3,'Amit',19,'Mumbai'),
(4,'Neha',22,'Pune'),
(5,'Rohan',20,'Nashik');
 
--Q4. Display Records
--Display All Students
SELECT * FROM Student;

--Display Students from Mumbai
SELECT * FROM Student
WHERE City ='Mumbai';

--Q5. WHERE vs HAVING
--WHERE
SELECT * FROM Student
WHERE Age > 20;

--HAVING

SELECT City,COUNT(*)
FROM Student
GROUP BY City
HAVING COUNT(*) > 1;


--Q6. Orders and Customers Tables
CREATE TABLE Customer(
CustomerID INT PRIMARY KEY,
Name VARCHAR(50),
City VARCHAR(50)
);
insert into Customer
values(1,'Maria Anders','Berlin'),
(2,'Ana Trujillo','México D.F.'),
(3,'Antonio Moreno','México D.F.'),
(4,'Thomas Hardy','London'),
(5,'Christina Berglund','Luleå');


CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
Amount DECIMAL(10,2)
);
insert into Orders
values(1,11,45224.25),
(2,10,5423.021),
(3,5,85621.03),
(4,9,45862.98),
(5,4,50000.20);

--Q7. Types of Joins
--INNER JOIN
--ans:Returns matching records from both tables.

SELECT *
FROM Orders
INNER JOIN Customer
ON Orders.CustomerID=Customer.CustomerID;

--LEFT JOIN
--ans:Returns all records from left table.

SELECT *
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID=Orders.CustomerID;

--RIGHT JOIN
--ans:Returns all records from right table.

SELECT *
FROM Customer
RIGHT JOIN Orders
ON Customer.CustomerID=Orders.CustomerID;

--FULL JOIN
--ans:Returns all matching and non-matching rows.

SELECT *
FROM Customer
FULL JOIN Orders
ON Customer.CustomerID=Orders.CustomerID;

--Q8. Second Highest Salary
CREATE TABLE Employees(EmployeeID INT,LastName VARCHAR(50),FirstName VARCHAR(50),
BirthDate VARCHAR(50),Photo VARCHAR(50),Salary Int)

drop table Employees;
INSERT INTO Employees
VALUES(1,'Davolio','Nancy','1968-12-08','EmpID1.pic',25000),
(2,'Fuller','Andrew','1952-02-19','EmpID2.pic',56000),
(3,'Leverling','Janet','1963-08-30','EmpID3.pic',57820),
(4,'Peacock','Margaret','1958-09-19','EmpID4.pic',36520),
(5,'Buchanan','Steven','1955-03-04','EmpID5.pic',56200);

alter table Employees 
add Joindate date;

update Employees
set Joindate ='2026-5-15'
where EmployeeID = 1;

update Employees
set Joindate ='2026-5-16'
where EmployeeID = 2;
update Employees
set Joindate ='2026-5-17'
where EmployeeID = 3;
update Employees
set Joindate ='2026-5-18'
where EmployeeID = 4;
update Employees
set Joindate ='2026-6-15'
where EmployeeID = 5;


SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary <
(
    SELECT MAX(Salary)
    FROM Employees
);

SELECT *
FROM Employees

--Q9. Count Students in Each City
SELECT City,COUNT(*) AS TotalStudents
FROM Student
GROUP BY City;

--Q10. DELETE vs TRUNCATE vs DROP

--| DELETE                | TRUNCATE          | DROP                  |
--| --------------------- | ----------------- | --------------------- |
--| Deletes selected rows | Deletes all rows  | Deletes table         |
--| WHERE allowed         | WHERE not allowed | Removes structure     |
--| Can rollback          | Can rollback      | Cannot recover easily |
--| Slower                | Faster            | Removes entire object |

--Q11. Students Older than Average Age`
select * from student 
where Age >
(select AVG(Age) from student
);
--Q12.What is index ? Types  of index in SQL server? 
--ans:An index is a database object that helps the database find data faster without scanning every row in a table.
--ans;There are two types of indexes:
--CREATE INDEX - Creates a non-unique index (duplicate values are allowed)
--CREATE UNIQUE INDEX - Creates a unique index (duplicate values are not allowed)

--Q13. Write a query using:
--ROW_NUMBER() to rank employees by salary. 
select EmployeeID, 
    LastName,
    FirstName,
    Salary,
    row_number() over (order by Salary desc ) AS [Salary Rank] 
from Employees;

--Q14. What is a Stored Procedure? 
--ANS:A stored procedure is a precompiled SQL code that can be saved and reused.
--Create one to fetch students by city. 
CREATE PROCEDURE GetCustomerByCity
  @City nvarchar(50)
AS
BEGIN
  SELECT * FROM Customer
  WHERE City = @City;
END;

EXEC GetCustomerByCity @City = 'London';

--Q15. What is a View? 
--ans :View is virtual table which store Sql queries based on condition ,with showing a data table.
--Create a view for students above age 18. 
create view [Age above 18 students] as
select * from student
where age >18;

select * from [Age above 18 students];
--Q16.Write queries to: 
--Total sales per month 
drop table products;
create table products(
ID int identity(1,1) primary key,
Name VARCHAR(50) unique,
Month VARCHAR(50) not null,
Sales Decimal(10,2) not null);
insert into products
values('Yogiji','Jan',50000.00),
('Vijay','Feb',89653.23),
('Andan','Mar',45635.25),
('Mukesh','Apr',46899.25),
('Adani','May',96523.21),
('Vikram','Jan',5000.00),
('Chakram','Feb',8953.23),
('Virat','Mar',4565.25),
('Dhoni','Apr',4699.25),
('Ronaldo','May',9623.21);


select Month,sum(Sales) as [Total Sales]
from products
group by Month
order by [Total Sales] desc;

--Top 3 products by sales
SELECT TOP 3 Name, Month, Sales
FROM Products
ORDER BY Sales DESC;

--Q17. Find Duplicate Records
SELECT LastName,
       COUNT(*) AS DuplicateCount
FROM Employees
GROUP BY LastName
HAVING COUNT(*) > 1;

--Q18.Employees Joined in Last 30 Days
select EmployeeID,FirstName,JoinDate 
from Employees
where JoinDate >= Dateadd(DAY,-30,getdate());