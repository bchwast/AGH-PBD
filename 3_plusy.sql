USE Northwind

SELECT BirthDate, DATEDIFF(YEAR, BirthDate, GETDATE()) FROM Employees WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) >= 25

SELECT EmployeeID, COUNT(*), MIN(OrderDate) FROM Orders GROUP BY EmployeeID ORDER BY 2 DESC

SELECT CustomerID, SUM(Freight) FROM Orders WHERE ShippedDate > RequiredDate GROUP BY CustomerID

SELECT OrderID FROM [Order Details] GROUP BY OrderID HAVING SUM(ISNULL(Discount, 0)) = 0


USE library

SELECT adult_member_no, COUNT(*), MIN(birth_date) FROM juvenile GROUP BY adult_member_no HAVING COUNT(*) > 2 ORDER BY 2 DESC

SELECT SUBSTRING(firstname, 1, 1), COUNT(*) FROM member GROUP BY SUBSTRING(firstname, 1, 1) ORDER BY 2 DESC

SELECT AVG(DATEDIFF(DAY, due_date, in_date)) FROM loanhist WHERE in_date > due_date
SELECT YEAR(due_date), AVG(DATEDIFF(DAY, due_date, in_date)) FROM loanhist WHERE in_date > due_date GROUP BY YEAR(due_date)