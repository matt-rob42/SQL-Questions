-- Question 1) SELECT * FROM dbo.shippers;

--Question 2)
-- SELECT CategoryName, Description FROM Categories;

--Question 3)

--SELECT FirstName, LastName, HireDate FROM dbo.Employees
--WHERE Title = 'Sales Representative';

-- Question 4)

--SELECT * FROM employees

--SELECT FirstName, LastName, HireDate FROM dbo.Employees
--WHERE Title = 'Sales Representative' AND Country = 'USA';

--Question 5)

--SELECT OrderID, OrderDate FROM orders WHERE EmployeeID = 5;

--Question 6) use of not equals to

--SELECT SupplierID, ContactName, ContactTitle FROM Suppliers
--WHERE ContactTitle <> 'Marketing Manager';

--Question 7) 
--SELECT ProductID, ProductName FROM Products
--WHERE ProductName LIKE '%Queso%';

--Question 8) 

--SELECT OrderID, CustomerID, ShipCountry FROM Orders
--WHERE ShipCountry = 'France'
--OR ShipCountry = 'Belgium';

-- Question 9) Using 'IN'

--SELECT OrderID, CustomerID, ShipCountry FROM Orders
--WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela');

--Question 10) Use of ORDER BY 

--SELECT FirstName, LastName, Title, BirthDate FROM Employees
--ORDER BY BirthDate desc;   -- Note the asc/desc!

--Question 11)


--SELECT FirstName, LastName, Title, CONVERT(DATE, BirthDate) FROM Employees
--ORDER BY BirthDate asc;   -- Note the asc/desc!

--Question 12) Use of string concatenation

--SELECT FirstName, LastName, CONCAT(FirstName, ' ', LastName) FROM Employees;

--Question 13) Multiplying rows

--SELECT OrderID, ProductID, UnitPrice, Quantity, UnitPrice*Quantity AS TotalPrice FROM OrderDetails;

--Question 14)

--SELECT COUNT(*) FROM Customers;

--Question 15) Use of MIN function

--SELECT MIN(OrderDate) AS FirstOrder FROM ORDERS;

--Question 16) 2 ways to do this - think about how GROUP BY can be used to make distinct rows

--SELECT DISTINCT(country) FROM Customers;

--SELECT country from Customers 
--GROUP BY Country;

--Question 17) !!!!!!!!

--SELECT ContactTitle, COUNT(ContactTitle) AS TotalContactTitle FROM Customers
--GROUP BY ContactTitle;

--Question 18) Note the JOIN syntax 

--SELECT ProductID, ProductName, CompanyName FROM Products
--JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
--ORDER BY ProductID;

--Question 19) Joins, Casting, Alias, filter a join

--SELECT OrderID, CONVERT(Date, OrderDate), CompanyName AS Shipper FROM Orders
--JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
--WHERE OrderID  < 10270;

--Question 20) !!! Note the use of counting! - Which may not be needed!

--SELECT CategoryName, COUNT(PRODUCTID) AS TotalProducts FROM Categories
--JOIN Products ON Categories.CategoryID = Products.CategoryID
--GROUP BY CategoryName;

--Question 21) More count practice

--SELECT Country, City, COUNT(*) FROM Customers
--GROUP BY Country, City
--ORDER BY COUNT(*) desc;

--Question 22) Easy

--SELECT ProductID, ProductName, UnitsInStock, ReorderLevel FROM Products
--WHERE UnitsInStock < ReorderLevel
--ORDER BY ProductID;

--Question 23) Extension of 22 with multiple and more complex conditions

--SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued FROM Products
--WHERE (UnitsInStock + UnitsOnOrder) < ReorderLevel
--AND Discontinued = 0
--ORDER BY ProductID;

--Question 24) !!! Use of CASE to create a temp ID - very handy Note that we put case in order by so that it doesn't come up as a column

--SELECT CustomerID, CompanyName, Region FROM Customers
--ORDER BY CASE WHEN Region IS NULL THEN 0 ELSE 1 END desc, Region, CustomerID;

-- Question 25) !!! More group by, use of calc'd columns

--SELECT TOP 3 ShipCountry, AVG(Freight) AS AvgFreight FROM Orders
--GROUP BY ShipCountry
--ORDER BY AvgFreight desc;

-- Question 26) Extracting a year from a Date

--SELECT TOP 3 ShipCountry, AVG(Freight) AS AvgFreight FROM Orders
--WHERE YEAR(OrderDate) = '2015'
--GROUP BY ShipCountry
--ORDER BY AvgFreight desc;

--Question 27)

SELECT TOP 3 ShipCountry, AverageFreight = AVG(Freight) FROM Orders
WHERE OrderDate between '20150101' AND '20151231' 
GROUP BY ShipCountry
ORDER BY AverageFreight desc;