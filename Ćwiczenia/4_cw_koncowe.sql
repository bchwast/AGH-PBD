/* Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki
dostarczała firma United Package. */

USE Northwind	
SELECT DISTINCT CompanyName, Phone FROM Customers AS C
WHERE EXISTS
	(SELECT * FROM Orders AS O WHERE C.CustomerID = O.CustomerID
	AND YEAR(O.ShippedDate) = 1997
	AND O.ShipVia = (SELECT ShipperID FROM Shippers WHERE CompanyName = 'United Package'))

USE Northwind
SELECT DISTINCT C.CompanyName, C.Phone FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN Shippers AS S ON O.ShipVia = S.ShipperID
WHERE YEAR(O.ShippedDate) = 1997 AND S.CompanyName = 'United Package'



/* Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii
Confections. */

USE Northwind
SELECT CompanyName, Phone FROM Customers AS C
WHERE EXISTS
	(SELECT * FROM Orders AS O WHERE O.CustomerID = C.CustomerID AND EXISTS
		(SELECT * FROM [Order Details] AS OD WHERE OD.OrderID = O.OrderID AND EXISTS
			(SELECT * FROM Products AS P WHERE P.ProductID = OD.ProductID AND EXISTS
				(SELECT * FROM Categories AS Ca WHERE Ca.CategoryID	= P.CategoryID AND CategoryName = 'Confections'))))

USE Northwind
SELECT DISTINCT C.CompanyName, C.Phone FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN Products AS P ON OD.ProductID = P.ProductID
INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID
WHERE Ca.CategoryName = 'Confections'



/* Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z
kategorii Confections. */

USE Northwind
SELECT CompanyName, Phone FROM Customers AS C
WHERE NOT EXISTS
	(SELECT * FROM Orders AS O WHERE O.CustomerID = C.CustomerID AND EXISTS
		(SELECT * FROM [Order Details] AS OD WHERE OD.OrderID = O.OrderID AND EXISTS
			(SELECT * FROM Products AS P WHERE P.ProductID = OD.ProductID AND EXISTS
				(SELECT * FROM Categories AS Ca WHERE Ca.CategoryID = P.CategoryID AND CategoryName = 'Confections'))))

USE Northwind
SELECT DISTINCT C.CompanyName, C.Phone FROM Customers AS C
LEFT OUTER JOIN Orders AS O ON C.CustomerID = O.CustomerID
LEFT OUTER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
LEFT OUTER JOIN Products AS P ON OD.ProductID = P.ProductID
LEFT OUTER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID AND Ca.CategoryName = 'Confections'
GROUP BY C.CustomerID, C.CompanyName, C.Phone HAVING COUNT(Ca.CategoryID) = 0



/* Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek */

USE Northwind
SELECT ProductName, 
(SELECT MAX(Quantity) FROM [Order Details] AS OD WHERE OD.ProductID = P.ProductID)
FROM Products AS P
ORDER BY 2 DESC


USE Northwind
SELECT P.ProductName, MAX(OD.Quantity) FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY 2 DESC



/* Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu */

USE Northwind
SELECT ProductName FROM Products
WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products)

USE Northwind
SELECT P.ProductName FROM Products AS P
CROSS JOIN Products AS PP 
GROUP BY P.ProductName, P.UnitPrice
HAVING P.UnitPrice < AVG(PP.UnitPrice)	



/* Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu
danej kategorii */

USE Northwind
SELECT ProductName FROM Products AS P
WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products WHERE CategoryID = P.CategoryID)

USE Northwind
SELECT P.ProductName FROM Products AS P
INNER JOIN Products AS PP ON P.CategoryID = PP.CategoryID
GROUP BY P.ProductName, P.UnitPrice
HAVING P.UnitPrice < AVG(PP.UnitPrice)




/* Dla każdego produktu podaj jego nazwę, cenę, średnią cenę wszystkich
produktów oraz różnicę między ceną produktu a średnią ceną wszystkich
produktów */

USE Northwind
SELECT ProductName, UnitPrice, (SELECT AVG(UnitPrice) FROM Products), 
UnitPrice - (SELECT AVG(UnitPrice) FROM Products) FROM Products

USE Northwind
SELECT P.ProductName, P.UnitPrice, AVG(PP.UnitPrice), P.UnitPrice - AVG(PP.UnitPrice) FROM Products AS P
CROSS JOIN Products AS PP
GROUP BY P.UnitPrice, P.ProductName



/* Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu, cenę, średnią
cenę wszystkich produktów danej kategorii oraz różnicę między ceną produktu a
średnią ceną wszystkich produktów danej kategorii */

USE Northwind
SELECT (SELECT CategoryName FROM Categories AS C WHERE P.CategoryID = C.CategoryID), 
ProductName, UnitPrice, (SELECT AVG(UnitPrice) FROM Products WHERE CategoryID = P.CategoryID), 
UnitPrice - (SELECT AVG(UnitPrice) FROM Products WHERE CategoryID = P.CategoryID) FROM Products AS P

USE Northwind
SELECT C.CategoryName, P.ProductName, P.UnitPrice, AVG(PP.UnitPrice), P.UnitPrice - AVG(PP.UnitPrice) FROM Products AS P
INNER JOIN Categories AS C ON P.CategoryID = C.CategoryID
INNER JOIN Products AS PP ON P.CategoryID = PP.CategoryID
GROUP BY C.CategoryName, P.ProductName, P.UnitPrice



/* Podaj łączną wartość zamówienia o numerze 1025 (uwzględnij cenę za przesyłkę) */

USE Northwind
SELECT OrderID, 
SUM((1 - Discount) * UnitPrice * Quantity) + (SELECT Freight FROM Orders AS O WHERE O.OrderID = OD.OrderID)
FROM [Order Details] AS OD
GROUP BY OrderID
HAVING OrderID = 10250

USE Northwind
SELECT OD.OrderID, SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) + O.Freight FROM [Order Details] AS OD
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE OD.OrderID = 10250
GROUP BY OD.OrderID, O.Freight



/* Podaj łączną wartość zamówień każdego zamówienia (uwzględnij cenę za
przesyłkę) */

USE Northwind
SELECT OrderID, 
SUM((1 - Discount) * UnitPrice * Quantity) + (SELECT Freight FROM Orders AS O WHERE O.OrderID = OD.OrderID)
FROM [Order Details] AS OD
GROUP BY OrderID

USE Northwind
SELECT OD.OrderID, SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) + O.Freight FROM [Order Details] AS OD
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
GROUP BY OD.OrderID, O.Freight



/* Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak
to pokaż ich dane adresowe */

USE Northwind
SELECT CustomerID, Address FROM Customers AS C
WHERE NOT EXISTS 
	(SELECT * FROM Orders AS O WHERE O.CustomerID = C.CustomerID 
	AND YEAR(OrderDate) = 1997)

USE Northwind
SELECT C.CustomerID, C.Address FROM Customers AS C
LEFT OUTER JOIN Orders AS O ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) = 1997
GROUP BY C.CustomerID, C.Address
HAVING COUNT(O.CustomerID) = 0



/* Podaj produkty kupowane przez więcej niż jednego klienta */

USE Northwind
SELECT ProductName FROM Products AS P
WHERE 
	(SELECT COUNT(DISTINCT O.CustomerID) FROM Orders AS O
	INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID AND O.OrderID = OD.OrderID
	GROUP BY ProductID) > 1

USE Northwind
SELECT P.ProductName FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
GROUP BY P.ProductName
HAVING COUNT(DISTINCT CustomerID) > 1



/* Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
obsłużonych przez tego pracownika (przy obliczaniu wartości zamówień
uwzględnij cenę za przesyłkę */

USE Northwind
SELECT FirstName + ' ' + LastName, 
(SELECT SUM((1 - Discount) * UnitPrice * Quantity) FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND E.EmployeeID = O.EmployeeID) 
+ (SELECT SUM(Freight) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID) FROM Employees AS E

USE Northwind
SELECT E.FirstName + ' ' + E.LastName, SUM((1 - OD.Discount) * OD.Quantity * OD.UnitPrice) + SUM(O.Freight) FROM Employees AS E
INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY E.FirstName + ' ' + E.LastName



/* Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o
największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika */

USE Northwind
SELECT TOP 1 FirstName + ' ' + LastName FROM Employees AS E
ORDER BY (SELECT SUM((1 - Discount) * UnitPrice * Quantity) FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND YEAR(O.OrderDate) = 1997 AND E.EmployeeID = O.EmployeeID) 
+ (SELECT SUM(Freight) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID) DESC

USE Northwind
SELECT TOP 1 E.FirstName + ' ' + E.LastName FROM Employees AS E
INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY E.FirstName + ' ' + E.LastName
ORDER BY SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) + SUM(Freight) DESC



/* Ogranicz wynik z pkt 1 tylko do pracowników
a) którzy mają podwładnych */

USE Northwind
SELECT FirstName + ' ' + LastName, 
(SELECT SUM((1 - Discount) * UnitPrice * Quantity) FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND E.EmployeeID = O.EmployeeID) 
+ (SELECT SUM(Freight) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID) FROM Employees AS E
WHERE EXISTS
	(SELECT * FROM Employees AS EE WHERE EE.ReportsTo = E.EmployeeID)



/* b) którzy nie mają podwładnych */

USE Northwind
SELECT FirstName + ' ' + LastName, 
(SELECT SUM((1 - Discount) * UnitPrice * Quantity) FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND E.EmployeeID = O.EmployeeID) 
+ (SELECT SUM(Freight) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID) FROM Employees AS E
WHERE NOT EXISTS
	(SELECT * FROM Employees AS EE WHERE EE.ReportsTo = E.EmployeeID)



/* Zmodyfikuj rozwiązania z pkt 3 tak aby dla pracowników pokazać jeszcze datę
ostatnio obsłużonego zamówienia */

USE Northwind
SELECT FirstName + ' ' + LastName, 
(SELECT SUM((1 - Discount) * UnitPrice * Quantity) FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND E.EmployeeID = O.EmployeeID) 
+ (SELECT SUM(Freight) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID), 
(SELECT MAX(OrderDate) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID) 
FROM Employees AS E
WHERE EXISTS
	(SELECT * FROM Employees AS EE WHERE EE.ReportsTo = E.EmployeeID)

USE Northwind
SELECT FirstName + ' ' + LastName, 
(SELECT SUM((1 - Discount) * UnitPrice * Quantity) FROM [Order Details] AS OD
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND E.EmployeeID = O.EmployeeID) 
+ (SELECT SUM(Freight) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID), 
(SELECT TOP 1 OrderDate FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID ORDER BY OrderDate DESC) 
FROM Employees AS E
WHERE NOT EXISTS
	(SELECT * FROM Employees AS EE WHERE EE.ReportsTo = E.EmployeeID)