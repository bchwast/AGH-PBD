/* Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył najwięcej jego zamówień, 
	podaj także liczbę tych zamówień (jeśli jest kilku pracowników to wystarczy podać imię i nazwisko jednego z nich).
	Zbiór wynikowy powinien zawierać nazwę klienta, imię i nazwisko pracownika oraz liczbę obsłużonych zamówień. */

USE Northwind
SELECT C.CompanyName,
	(SELECT CONCAT(E.FirstName, ' ', E.LastName) FROM Employees AS E WHERE E.EmployeeID = 
		(SELECT TOP 1 O.EmployeeID FROM Orders AS O 
		WHERE O.CustomerID = C.CustomerID AND YEAR(O.OrderDate) = 1997
		GROUP BY O.EmployeeID
		ORDER BY COUNT(*) DESC)),
	(SELECT TOP 1 COUNT(*) FROM Orders AS O
	WHERE O.CustomerID = C.CustomerID AND YEAR(O.OrderDate) = 1997
	GROUP BY O.EmployeeID
	ORDER BY COUNT(*) DESC)
FROM Customers AS C

