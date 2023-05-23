--*************************************************************************--
-- Title: Mod06 Lab01 Answers
-- Author: RRoot
-- Desc: This file demonstrates how complete lab 01
-- Change Log: When,Who,What
-- 2030-01-01,RRoot,Created File
--**************************************************************************--
--Step 1: Review Database Tables
--Run the following code in a SQL query editor and review the names of the tables you have to work with.

Select * From Northwind.Sys.Tables Where type = 'u' Order By Name;
go

--Step 2: Create a Lab Database
--Create a new database for this lab called Mod06LabsYourNameHere (using your own name, of course!) Modify and use the following code to accomplish this:

Use Master;
go
If Exists(Select Name from SysDatabases Where Name = 'Mod06LabsRRoot')
 Begin 
  Alter Database [Mod06LabsRRoot] set Single_user With Rollback Immediate;
  Drop Database Mod06LabsRRoot;
 End
go

Create Database Mod06LabsRRoot;
go

Use Mod06LabsRRoot;
go

--Step 3: Create a Query
--Answer the following questions by writing and executing SQL code.

--Question 1: How can you create a view to show a list of customer names and their locations? 
--Use the IsNull() function to display null region names as the name of the customer's country? 
--Call the view vCustomersByLocation.
go
Create View vCustomersByLocation
 As
   Select
    CustomerName = CompanyName
   ,City
   ,Region = IsNull(Region, Country)
   ,Country
   From Northwind.dbo.Customers;
go
Select * From vCustomersByLocation Order By CustomerName;


--Question 2: How can you create a view to show a list of customer names, their locations, and the number of orders they have placed (hint: use the count() function)? Call the view vNumberOfCustomerOrdersByLocation.
go
Create View vNumberOfCustomerOrdersByLocation
 As
   Select
    CustomerName = CompanyName
   ,City
   ,Region = IsNull(Region, Country)
   ,Country
   ,NumberOfOrders = Count(OrderID)
   From Northwind.dbo.Customers as c
   Join Northwind.dbo.Orders as o
     On c.CustomerID = o.CustomerID
   Group By     
    CompanyName
   ,City
   ,Region
   ,Country;
go
Select * From vNumberOfCustomerOrdersByLocation Order By CustomerName;
 


--Question 3: How can you create a view to shows a list of customer names, their locations, and the number of orders they have placed (hint: use the count() function) on a given year (hint: use the year() function)? Call the view vNumberOfCustomerOrdersByLocationAndYears.
go
Create View vNumberOfCustomerOrdersByLocationAndYears
 As
   Select
    CustomerName = CompanyName
   ,City
   ,Region = IsNull(Region, Country)
   ,Country
   ,NumberOfOrders = Count(OrderID)
   ,OrderYear = Year(OrderDate)
   From Northwind.dbo.Customers as c
   Join Northwind.dbo.Orders as o
     On c.CustomerID = o.CustomerID
   Group By     
    CompanyName
   ,City
   ,Region
   ,Country
   ,Year(OrderDate);
go

Select * From vNumberOfCustomerOrdersByLocationAndYears Order By CustomerName, OrderYear;
 

 
