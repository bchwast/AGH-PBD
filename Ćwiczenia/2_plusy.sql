use Northwind

SELECT UnitPrice*Quantity*(1 - Discount) FROM [Order Details] WHERE OrderID = 10250

SELECT * FROM Suppliers
SELECT ISNULL(Phone, '') + ',' + ISNULL(Fax, '') FROM Suppliers