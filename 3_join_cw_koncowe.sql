/* Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz
nazwę klienta. */

USE Northwind
SELECT OD.OrderID, SUM(OD.Quantity), C.CompanyName FROM Orders
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
INNER JOIN Customers AS C ON Orders.CustomerID = C.CustomerID
GROUP BY OD.OrderID, C.CompanyName



/* Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
łączna liczbę zamówionych jednostek jest większa niż 250 */

USE Northwind
SELECT OD.OrderID, SUM(OD.Quantity), C.CompanyName FROM Orders
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
INNER JOIN Customers AS C ON Orders.CustomerID = C.CustomerID
GROUP BY OD.OrderID, C.CompanyName
HAVING SUM(OD.Quantity) > 250



/* Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę
klienta. */

USE Northwind
SELECT OD.OrderID, SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity), C.CompanyName FROM Orders
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
INNER JOIN Customers AS C ON Orders.CustomerID = C.CustomerID
GROUP BY OD.OrderID, C.CompanyName



/* Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
łączna liczba jednostek jest większa niż 250. */

USE Northwind
SELECT OD.OrderID, SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity), C.CompanyName FROM Orders
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
INNER JOIN Customers AS C ON Orders.CustomerID = C.CustomerID
GROUP BY OD.OrderID, C.CompanyName
HAVING SUM(OD.Quantity) > 250



/* Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko
pracownika obsługującego zamówienie */

USE Northwind
SELECT OD.OrderID, SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity), C.CompanyName, 
E.FirstName + ' ' + E.LastName FROM Orders
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
INNER JOIN Customers AS C ON Orders.CustomerID = C.CustomerID
INNER JOIN Employees AS E ON Orders.EmployeeID = E.EmployeeID
GROUP BY OD.OrderID, C.CompanyName, E.FirstName + ' ' + E.LastName
HAVING SUM(OD.Quantity) > 250



/* Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez
klientów jednostek towarów z tek kategorii. */

USE Northwind
SELECT CategoryName, SUM(OD.Quantity) FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN [Order Details] AS OD ON Products.UnitsOnOrder = OD.ProductID
GROUP BY CategoryName



/* Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych przez
klientów jednostek towarów z tek kategorii. */

USE Northwind
SELECT CategoryName, SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN [Order Details] AS OD ON Products.UnitsOnOrder = OD.ProductID
GROUP BY CategoryName



/* Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
a) łącznej wartości zamówień */

USE Northwind
SELECT CategoryName, SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN [Order Details] AS OD ON Products.UnitsOnOrder = OD.ProductID
GROUP BY CategoryName
ORDER BY 2



/* b) łącznej liczby zamówionych przez klientów jednostek towarów. */

USE Northwind
SELECT CategoryName, SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
INNER JOIN [Order Details] AS OD ON Products.UnitsOnOrder = OD.ProductID
GROUP BY CategoryName
ORDER BY SUM(OD.Quantity)



/* Dla każdego zamówienia podaj jego wartość uwzględniając opłatę za przesyłkę */

USE Northwind
SELECT SUM((1 - OD.Discount) * OD.Quantity * OD.UnitPrice) + Freight FROM Orders
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
GROUP BY OD.OrderID, Orders.Freight



/* Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r */

USE Northwind
SELECT S.CompanyName, COUNT(*) FROM Orders
INNER JOIN Shippers AS S ON Orders.ShipVia = S.ShipperID
WHERE YEAR(ShippedDate) = 1997
GROUP BY S.CompanyName



/* Który z przewoźników był najaktywniejszy (przewiózł największą liczbę
zamówień) w 1997r, podaj nazwę tego przewoźnika */

USE Northwind
SELECT TOP 1 S.CompanyName FROM Orders
INNER JOIN Shippers AS S ON Orders.ShipVia = S.ShipperID
WHERE YEAR(ShippedDate) = 1997
GROUP BY S.CompanyName
ORDER BY COUNT(*) DESC



/* Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
obsłużonych przez tego pracownika */

USE Northwind
SELECT E.FirstName + ' ' + E.LastName, SUM((1 - OD.Discount) * OD.Quantity * OD.UnitPrice) FROM Orders
INNER JOIN Employees AS E ON Orders.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
GROUP BY E.FirstName + ' ' + E.LastName, E.EmployeeID
ORDER BY 2 DESC



/* Który z pracowników obsłużył największą liczbę zamówień w 1997r, podaj imię i
nazwisko takiego pracownika */

USE Northwind
SELECT TOP 1 E.FirstName + ' ' + E.LastName FROM Orders
INNER JOIN Employees AS E ON Orders.EmployeeID = E.EmployeeID
WHERE YEAR(OrderDate) = 1997
GROUP BY E.FirstName + ' ' + E.LastName
ORDER BY COUNT(*) DESC



/* Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o
największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika */

USE Northwind
SELECT TOP 1 E.FirstName + ' ' + E.LastName FROM Orders
INNER JOIN Employees AS E ON Orders.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY E.FirstName + ' ' + E.LastName
ORDER BY SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) DESC



/* Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
obsłużonych przez tego pracownika
– Ogranicz wynik tylko do pracowników
a) którzy mają podwładnych */

USE Northwind
SELECT DISTINCT A.FirstName + ' ' + A.LastName, SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) FROM Employees AS A
INNER JOIN Employees AS B ON A.EmployeeID = B.ReportsTo
INNER JOIN Orders ON A.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
GROUP BY A.FirstName + ' ' + A.LastName, B.EmployeeID



/* b) którzy nie mają podwładnych */

USE Northwind
SELECT A.FirstName + ' ' + A.LastName, SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) FROM Employees AS A
LEFT OUTER JOIN Employees AS B ON A.EmployeeID = B.ReportsTo
INNER JOIN Orders ON A.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] AS OD ON Orders.OrderID = OD.OrderID
WHERE B.ReportsTo IS NULL
GROUP BY A.FirstName + ' ' + A.LastName, A.EmployeeID, B.EmployeeID
