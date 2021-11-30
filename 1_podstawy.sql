USE Northwind

SELECT CompanyName, Address FROM Customers
SELECT LastName, HomePhone FROM Employees
SELECT ProductName, UnitPrice FROM Products
SELECT CategoryName, Description FROM Categories
SELECT CompanyName, HomePage FROM Suppliers

SELECT OrderID, CustomerID FROM Orders WHERE OrderDate < '1996-08-01 00:00:00.000'

SELECT CompanyName, Address FROM Customers WHERE City = 'London'
SELECT CompanyName, Address FROM Customers WHERE Country = 'France' OR Country = 'Spain'
SELECT ProductName, UnitPrice FrOM Products WHERE 20 <= UnitPrice AND UnitPrice <= 30
SELECT CategoryID FROM Categories WHERE CategoryName LIKE '%meat%'
SELECT ProductName, UnitPrice FROM Products WHERE CategoryID = 6
SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Tokyo Traders'
SELECT ProductName, UnitsInStock FROM Products WHERE SupplierID = 4
SELECT ProductName FROM Products WHERE UnitsInStock = 0

SELECT * FROM Products WHERE QuantityPerUnit LIKE '%bottle%'
SELECT Title FROM Employees WHERE LastName LIKE '[B-L]%'
SELECT Title FROM Employees WHERE LastName LIKE '[B,L]%'
SELECT CategoryName FROM Categories WHERE Description LIKE '%,%'
SELECT * FROM Customers WHERE CompanyName LIKE '%Store%'

SELECT * FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 AND 30

SELECT CompanyName, Country FROM Customers WHERE Country = 'Japan' OR Country = 'Italy'

SELECT OrderID, OrderDate, CustomerID FROM Orders WHERE (ShippedDate IS NULL OR GETDATE() < ShippedDate) AND ShipCountry = 'Argentina'

SELECT CompanyName, Country FROM Customers ORDER BY Country, CompanyName
SELECT CategoryID, ProductName, UnitPrice FROM Products ORDER BY CategoryID, UnitPrice DESC
SELECT CompanyName, Country FROM Customers WHERE Country = 'UK' OR Country = 'Italy' ORDER BY Country, CompanyName
