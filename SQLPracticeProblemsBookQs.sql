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

--Question 27) note that the order was placed late in the day, this only covers up to '20151231' at midnight!

--SELECT TOP 3 ShipCountry, AverageFreight = AVG(Freight) FROM Orders
--WHERE OrderDate between '20150101' AND '20160101' 
--GROUP BY ShipCountry
--ORDER BY AverageFreight desc;

--Question 28) !!! Very Key question - I sorta got this, we need to use max to find the last order, then
--use dateadd to shift back one year


--SELECT TOP 3 ShipCountry, AverageFreight = AVG(Freight) FROM Orders
--WHERE OrderDate > DATEADD(yy, -1, (SELECT MAX(OrderDate) FROM Orders))
--GROUP BY ShipCountry
--ORDER BY AverageFreight desc;

--Question 29) !!! Key joining question - Note that all columns must be given a source with the dot notation
--And remember the join syntax: JOIN [TableName] ON Table1.attribute1 = Table2.attribute1

--SELECT Employees.EmployeeID, Employees.LastName, Orders.OrderID, Products.ProductName, OrderDetails.Quantity FROM Employees
--JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
--JOIN Products ON OrderDetails.ProductID = Products.ProductID
--ORDER BY Orders.OrderID, Products.ProductID;

--Question 30) Important question - note the value of the left outer join, and that we are chosing 
-- the customers to be on the left LOJ preserves all the customers !  An inner join would drop them!

--SELECT Customers_CustomerID = Customers.CustomerID, Orders_CustomerID = Orders.CustomerID FROM Customers

--LEFT JOIN Orders ON Orders.customerID = Customers.CustomerID

--WHERE Orders.CustomerID IS NULL;

--Question 31) Very key - think layers of filters to get first all cust/order combos that have ID = 4
--Then another layer to find customers that are NULL

-- First
--SELECT Customers.CustomerID, Orders.CustomerID, Orders.EmployeeID FROM Customers
--LEFT JOIN Orders ON Orders.customerID = Customers.CustomerID
--AND Orders.EmployeeID = 4

--Second

--SELECT Customers.CustomerID, Orders.CustomerID, Orders.EmployeeID FROM Customers
--LEFT JOIN Orders ON Orders.customerID = Customers.CustomerID
--AND Orders.EmployeeID = 4
--WHERE Orders.CustomerID IS NULL

--Question 32) Another important question in GROUP BY - Here we group on OrderID as well
--This allows us to only look at orders where the condition holds try commenting out line 196 to see!

--SELECT Customers.CustomerID, Customers.CompanyName, Orders.OrderID, SUM(UnitPrice * Quantity) AS TotalOrderAmount FROM Customers
--JOIN Orders ON Orders.CustomerID = Customers.CustomerID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID

--WHERE OrderDate > '20160101'
--AND OrderDate < '20170101'

--GROUP BY Customers.CustomerID, Customers.CompanyName, Orders.OrderID 
--HAVING SUM(Quantity * UnitPrice) > 10000
--ORDER BY TotalOrderAmount desc;


--Question 33) In this one we remove some of the groupings, this allows us to look at all the orders rolled up
-- to each customer! Think drill up/down!!!
--SELECT Customers.CustomerID, Customers.CompanyName, SUM(UnitPrice * Quantity) AS TotalOrderAmount FROM Customers
--JOIN Orders ON Orders.CustomerID = Customers.CustomerID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID

--WHERE OrderDate > '20160101'
--AND OrderDate < '20170101'

--GROUP BY Customers.CustomerID, Customers.CompanyName
--HAVING SUM(Quantity * UnitPrice) > 15000
--ORDER BY TotalOrderAmount desc;

--Question 34) Slight modification - look at the changes we made to SELECT and HAVING

--SELECT Customers.CustomerID, Customers.CompanyName, SUM(UnitPrice * Quantity) AS TotalWithoutAmount, 
--SUM(Quantity * UnitPrice * (1 - Discount)) AS TotalWithDiscount FROM Customers
--JOIN Orders ON Orders.CustomerID = Customers.CustomerID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID

--WHERE OrderDate > '20160101'
--AND OrderDate < '20170101'

--GROUP BY Customers.CustomerID, Customers.CompanyName
--HAVING SUM(Quantity * UnitPrice * (1 - Discount)) > 10000
--ORDER BY TotalWithDiscount desc;

--Question 35) Basically got this one - just need the EOMONTH fn and the realization that the condition
--we wanted was order date = EOM of that date.

--SELECT Employees.EmployeeID, OrderID, OrderDate FROM Employees
--JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
--WHERE OrderDate = EOMONTH(OrderDate)
--ORDER BY Employees.EmployeeID, Orders.OrderID

--Question 36)

--SELECT TOP 10 OrderID, COUNT(*) AS TotalOrderDetails FROM OrderDetails
--GROUP BY OrderID
--ORDER BY TotalOrderDetails desc;

-- Question 37) this works, but may be slower based on stackoverflow comments

--SELECT TOP 2 percent OrderID FROM Orders
--ORDER BY NewID()

--Question 38)
--SELECT OrderID, Quantity FROM OrderDetails
--WHERE Quantity >= 60
--GROUP BY OrderID, Quantity
--HAVING COUNT(*) > 1

---- Use the below to understand this query!Or ass COUNT(*) to fields above

--SELECT * FROM OrderDetails
--WHERE OrderID = 10263

-- Question 39) First question on CTEs! This also uses a subquery - 

--WITH SpecificOrders AS (SELECT OrderID, Quantity FROM OrderDetails
--WHERE Quantity >= 60
--GROUP BY OrderID, Quantity
--HAVING COUNT(*) > 1)                --This is the CTE

--SELECT OrderID, ProductID, UnitPrice, Quantity, Discount
--FROM OrderDetails
--WHERE OrderID in (SELECT OrderID FROM SpecificOrders) --This is the subquery on the CTE, returns set of orderIDs
--ORDER BY OrderID; 

--Question 40) - Query correction Q

--Question 41) Got it, pretty simple query using a simple definition of late

--SELECT OrderID, OrderDate = CONVERT(date,OrderDate), RequiredDate = CONVERT(date, RequiredDate),  
--ShippedDate = CONVERT(date, ShippedDate) FROM Orders
--WHERE ShippedDate >= RequiredDate
--ORDER BY OrderID;

--Question 42) A fairly standard GROUP BY

--SELECT Employees.EmployeeID , LastName, COUNT(*) AS TotalLateOrders FROM Orders
--JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
--WHERE ShippedDate >= RequiredDate
--GROUP BY Employees.EmployeeID, Employees.LastName
--ORDER BY TotalLateOrders desc

--Question 43) Double CTE, greatly simplifes final query

--WITH All_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS TotalOrders FROM Orders
--GROUP BY EmployeeID), --NOTE the way multiple CTEs are formatted

--LATE_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS LateOrders FROM Orders
--WHERE RequiredDate <= ShippedDate
--GROUP BY EmployeeID)

--SELECT Employees.EmployeeID, LastName, All_Orders=All_Orders.TotalOrders, LATE_Orders = LATE_Orders.LateOrders FROM Employees
--JOIN All_Orders ON Employees.EmployeeID = All_Orders.EmployeeID
--JOIN LATE_Orders ON Employees.EmployeeID = LATE_Orders.EmployeeID;

-- Question 44) Fixing a query Q

--WITH All_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS TotalOrders FROM Orders
--GROUP BY EmployeeID), --NOTE the way multiple CTEs are formatted

--LATE_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS LateOrders FROM Orders
--WHERE RequiredDate <= ShippedDate
--GROUP BY EmployeeID)

--SELECT Employees.EmployeeID, LastName, All_Orders=All_Orders.TotalOrders, LATE_Orders = LATE_Orders.LateOrders FROM Employees
--LEFT OUTER JOIN All_Orders ON Employees.EmployeeID = All_Orders.EmployeeID
--LEFT OUTER JOIN LATE_Orders ON Employees.EmployeeID = LATE_Orders.EmployeeID;

-- Question 45) could do this with simple IS NULL, or a CASE
--WITH All_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS TotalOrders FROM Orders
--GROUP BY EmployeeID), --NOTE the way multiple CTEs are formatted

--LATE_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS LateOrders FROM Orders
--WHERE RequiredDate <= ShippedDate
--GROUP BY EmployeeID)

--SELECT Employees.EmployeeID, LastName, All_Orders=All_Orders.TotalOrders, LATE_Orders = ISNULL(LATE_Orders.LateOrders, 0) FROM Employees
--LEFT OUTER JOIN All_Orders ON Employees.EmployeeID = All_Orders.EmployeeID
--LEFT OUTER JOIN LATE_Orders ON Employees.EmployeeID = LATE_Orders.EmployeeID;

-- USING CASE WOULD BE: Late_Orders = CASE WHEN LATE_Orders.LateOrders IS NULL THEN O ELSE LATE_Orders.LateOrders) END

--Question 46)

--WITH All_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS TotalOrders FROM Orders
--GROUP BY EmployeeID), --NOTE the way multiple CTEs are formatted

--LATE_Orders AS (SELECT Orders.EmployeeID, COUNT(*) AS LateOrders FROM Orders
--WHERE RequiredDate <= ShippedDate
--GROUP BY EmployeeID)

--SELECT Employees.EmployeeID, LastName, All_Orders=All_Orders.TotalOrders, LATE_Orders = ISNULL(LATE_Orders.LateOrders, 0),
--Percent_Late_Orders = ISNULL((CONVERT(float, LATE_Orders.LateOrders)/CONVERT(float, All_Orders.TotalOrders)), 0.0000) FROM Employees
--LEFT OUTER JOIN All_Orders ON Employees.EmployeeID = All_Orders.EmployeeID
--LEFT OUTER JOIN LATE_Orders ON Employees.EmployeeID = LATE_Orders.EmployeeID;

-- Question 48)

--SELECT Customers.CustomerID, Customers.CompanyName, SUM(UnitPrice * Quantity) AS TotalOrderAmount,
--Customer_Group = CASE WHEN SUM(UnitPrice * Quantity) < 1000 THEN 'Low' WHEN SUM(UnitPrice * Quantity) < 5000 THEN 'Medium'
--WHEN SUM(UnitPrice * Quantity) < 10000 THEN 'High' ELSE 'Very High' END FROM Customers
--JOIN Orders ON Orders.CustomerID = Customers.CustomerID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID

--WHERE OrderDate > '20160101'
--AND OrderDate < '20170101'

--GROUP BY Customers.CustomerID, Customers.CompanyName
--ORDER BY TotalOrderAmount desc;

-- Question 49) Got this by default using my way of <>

--SELECT Customers.CustomerID, Customers.CompanyName, SUM(UnitPrice * Quantity) AS TotalOrderAmount,
--Customer_Group = CASE WHEN SUM(UnitPrice * Quantity) < 1000 THEN 'Low' WHEN SUM(UnitPrice * Quantity) < 5000 THEN 'Medium'
--WHEN SUM(UnitPrice * Quantity) < 10000 THEN 'High' ELSE 'Very High' END FROM Customers
--JOIN Orders ON Orders.CustomerID = Customers.CustomerID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID

--WHERE OrderDate > '20160101'
--AND OrderDate < '20170101'

--GROUP BY Customers.CustomerID, Customers.CompanyName
--ORDER BY TotalOrderAmount desc;

-- Question 50)  This is a key question - let's break it down - it uses two CTEs, which act as a 
-- series of sucessive filters. Once the data is correctly filtered, we select the columns we want.
-- This is just our basic table - creating our new column, filtering on year.
--WITH Orders2016 AS (
--SELECT Customers.CustomerID, Customers.CompanyName, TotalOrderAmount = SUM(Quantity * UnitPrice)
--FROM Customers
--JOIN Orders ON Orders.CustomerID = Customers.CustomerID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
--WHERE OrderDate >= '20160101'
--AND OrderDate < '20170101'
--GROUP BY Customers.CustomerID, Customers.CompanyName),
---- Now, we add a grouping column that will divide the customers into buckets
--CustomerGrouping AS (
--SELECT CustomerID, CompanyName, TotalOrderAmount, CustomerGroup = 
--CASE WHEN TotalOrderAmount < 1000 THEN 'Low'
--WHEN TotalOrderAmount < 5000 THEN 'Medium'
--WHEN TotalOrderAmount < 10000 THEN 'High'
--WHEN TotalOrderAmount > 10000 THEN 'Very High' END
--FROM Orders2016 ) -- Selecting this from the previous table!

--SELECT CustomerGroup, TotalInGroup = COUNT(*), PercentageInGroup = COUNT(*) * 1.0 / (SELECT COUNT(*) FROM
--CustomerGrouping)  --This is some kind of subquery that returns the total size of table!
--FROM CustomerGrouping
--GROUP BY CustomerGroup
--ORDER BY TotalInGroup;

-- Question 51) 

--WITH Orders2016 AS (
--SELECT Customers.CustomerID, Customers.CompanyName, TotalOrderAmount = SUM(Quantity * UnitPrice)
--FROM Customers
--JOIN Orders ON Orders.CustomerID = Customers.CustomerID
--JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
--WHERE OrderDate >= '20160101'
--AND OrderDate < '20170101'
--GROUP BY Customers.CustomerID, Customers.CompanyName),
---- Now, we add a grouping column that will divide the customers into buckets
--CustomerGrouping AS (
--SELECT CustomerID, CompanyName, 
--Percent_Rank = (SELECT TotalOrderAmount, PERCENT_RANK() OVER(ORDER BY TotalOrderAmount)),
--TotalOrderAmount, 
--CustomerGroup = 
--CASE WHEN TotalOrderAmount < 1000 THEN 'Low'
--WHEN TotalOrderAmount < 5000 THEN 'Medium'
--WHEN TotalOrderAmount < 10000 THEN 'High'
--WHEN TotalOrderAmount > 10000 THEN 'Very High' END
--FROM Orders2016 ) -- Selecting this from the previous table!

--SELECT CustomerGroup, TotalInGroup = COUNT(*), PercentageInGroup = COUNT(*) * 1.0 / (SELECT COUNT(*) FROM
--CustomerGrouping)  --This is some kind of subquery that returns the total size of table!
--FROM CustomerGrouping
--GROUP BY CustomerGroup
--ORDER BY TotalInGroup;


-- Question 52) This is a nice simple example of a union clause - we get the columns from two tables, and combine them
-- Here we're using union, which eliminates dups, we could also use UNION ALL, which preserves them

--SELECT Suppliers.Country FROM Suppliers
--UNION
--SELECT Customers.Country FROM Customers

-- Question 53) This is an interesting one, using two CTEs for ease of reading, and an outer join to preserve all values from each row
--WITH CustomerCountries AS (SELECT DISTINCT Country FROM Customers),

--SupplierCountries AS (SELECT DISTINCT Country FROM Suppliers)

--SELECT CustomerCountry = CustomerCountries.Country, SupplierCountry = SupplierCountries.Country FROM SupplierCountries
--FULL OUTER JOIN CustomerCountries ON SupplierCountries.Country = CustomerCountries.Country

-- Question 54) 

--WITH CustomerCountries AS (SELECT Country, Total = COUNT(*) FROM Customers GROUP BY COUNTRY),

--SupplierCountries AS (SELECT Country, Total = COUNT(*) FROM Suppliers GROUP BY Country)

--SELECT Country = ISNULL(SupplierCountries.Country, CustomerCountries.Country),
--TotalSuppliers = ISNULL(SupplierCountries.Total, 0),
--TotalCustomers = ISNULL(CustomerCountries.Total, 0)
--FROM SupplierCountries
--FULL OUTER JOIN CustomerCountries ON SupplierCountries.Country = CustomerCountries.Country

-- Question 55) This is a key use of the ranking functions - a special function that allows us to assign rankings to groups, we can partition these 
-- groups as desired - here we're using it to find rank the orders in each country. We're taking advantage of the fact that the default ordering is 
-- oldest -> newest date, and taking the first item from each partition

--With OrdersByCountry AS (SELECT ShipCountry, CustomerID, OrderID, Date =CONVERT(Date, OrderDate), 
---- First we set up a CTE with all the key data - including columns we don't want in final select
--RowNumberPerCountry = ROW_NUMBER() OVER(PARTITION BY ShipCountry ORDER BY ShipCountry, OrderID )
---- Here is the row numbering - note how we're chosing the columns to partition on!
--FROM Orders)

--SELECT ShipCountry, CustomerID, OrderID, Date FROM OrdersByCountry
--WHERE RowNumberPerCountry = 1 -- This is just selecting first from each partition
--ORDER BY ShipCountry

-- Question 56) - Example of a self join! Actually pretty self explanatory - need to do more research
-- So seems like a cartesian product - we want to compare all orders against each other - so need to form all pairs

--SELECT InitialOrder.CustomerID, InitialOrderID = InitialOrder.OrderID,InitialOrderDate = CONVERT(DATE, InitialOrder.OrderDate),
--NextOrderID = NextOrder.OrderID, NextOrderDate = CONVERT(DATE, NextOrder.OrderDate), DaysBetweenOrders = DATEDIFF(dd, InitialOrder.OrderDate, 
--NextOrder.OrderDate)
--FROM Orders InitialOrder
--JOIN Orders NextOrder ON InitialOrder.CustomerID = NextOrder.CustomerID
--WHERE InitialOrder.OrderID < NextOrder.OrderID
--AND DATEDIFF(dd, InitialOrder.OrderDate, NextOrder.OrderDate) <= 5
--ORDER BY InitialOrder.CustomerID, InitialOrder.OrderID;

-- Digression on the self join - it is highly useful in certain scenarios for example, if we have a table of employees, each with a manager field 
-- A self join on managerID = empID will show us who manages who - very useful with self-referencing hirar. data
-- Also handy here as a way to compare columns of the same table - for example, checking each pair of orders to see if there is a less
-- than 5 day spread.

-- Question 57) This is another great example of a window function - we're using lead to find the next order, and comparing it to find any with
-- a spacing greater than 5
WITH NextOrderDate AS (SELECT CustomerID, OrderDate = CONVERT(date, OrderDate), 
NextOrderDate = CONVERT(DATE, LEAD(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY CustomerID, OrderDate))
FROM Orders)
SELECT CustomerID, OrderDate, NextOrderDate, DaysBetweenOrders = DateDiff(dd, OrderDate, NextOrderDate)
FROM NextOrderDate
WHERE DateDiff(dd, OrderDate, NextOrderDate) <= 5