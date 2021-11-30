USE Northwind

SELECT COUNT(*) FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20
SELECT MAX(UnitPrice) FROM Products WHERE UnitPrice < 20
SELECT MAX(UnitPrice), MIN(UnitPrice), AVG(UnitPrice) FROM Products WHERE QuantityPerUnit LIKE '%bottle%'
SELECT AVG(UnitPrice) FROM Products
SELECT * FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
SELECT SUM(UnitPrice*Quantity*(1 - Discount)) FROM [Order Details] WHERE OrderID = 10250

SELECT * FROM OrderHist

SELECT orderid, SUM(quantity) AS total_quantity FROM orderhist GROUP BY orderid

SELECT OrderID, MAX(UnitPrice) FROM [Order Details] GROUP BY OrderID
SELECT OrderID FROM [Order Details] ORDER BY UnitPrice
SELECT MAX(UnitPrice), MIN(UnitPrice) FROM [Order Details] GROUP BY OrderID
SELECT ShipVia, COUNT(*) FROM Orders GROUP BY ShipVia
SELECT TOP 1 ShipVia, COUNT(*) FROM Orders WHERE YEAR(ShippedDate) = 1997 GROUP BY ShipVia ORDER BY 2 DESC 

SELECT OrderID, COUNT(OrderID) FROM [Order Details] GROUP BY OrderID
SELECT OrderID FROM [Order Details] GROUP BY OrderID HAVING COUNT(*) > 5
SELECT CustomerID FROM Orders WHERE YEAR(ShippedDate) = 1998 GROUP BY CustomerID HAVING COUNT(*) > 8 ORDER BY SUM(Freight) DESC

SELECT * FROM orderhist

SELECT productid, orderid, SUM(quantity) FROM orderhist GROUP BY productid, orderid WITH ROLLUP ORDER BY productid, orderid
SELECT null, null, SUM(quantity) FROM orderhist
SELECT productid, null, SUM(quantity) FROM orderhist GROUP BY productid
SELECT productid, orderid, SUM(quantity) FROM orderhist GROUP BY productid, orderid
