USE Northwind

SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) FROM [Order Details] GROUP BY OrderID ORDER BY 2 DESC
SELECT TOP 10 OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) FROM [Order Details] GROUP BY OrderID ORDER BY 2 DESC

SELECT ProductID, SUM(Quantity) FROM [Order Details] WHERE ProductID < 3 GROUP BY ProductID
SELECT ProductID, SUM(Quantity) FROM [Order Details] GROUP BY ProductID
SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) FROM [Order Details] GROUP BY OrderID HAVING SUM(Quantity) > 250

SELECT EmployeeID, COUNT(*) FROM Orders GROUP BY EmployeeID
SELECT ShipVia, SUM(Freight) AS 'opłata za przesyłkę' FROM Orders GROUP BY ShipVia
SELECT ShipVia, SUM(Freight) AS 'opłata za przesyłkę' FROM Orders WHERE YEAR(ShippedDate) BETWEEN 1996 AND 1997 GROUP BY ShipVia

SELECT EmployeeID, COUNT(*), YEAR(OrderDate), MONTH(OrderDate) FROM Orders GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate)
SELECT CategoryID, MAX(UnitPrice), MIN(UnitPrice) FROM Products GROUP BY CategoryID