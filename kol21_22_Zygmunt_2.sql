/* Wypisz produkt, który zarobił najmniej w 1996 */

USE Northwind
SELECT TOP 1 P.ProductName FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1996
GROUP BY P.ProductName
ORDER BY SUM((1 - OD.Discount) * OD.Quantity * OD.UnitPrice)



/* wypisz wszystkich członków biblioteki, którzy nigdy nic nie wypożyczyli. 
	Stwierdz czy członek jest dzieckiem czy dorosłym, jeśli dorosłym, to wypisz liczbę jego dzieci */

USE library
SELECT CONCAT(m.firstname, ' ', m.lastname), 
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a), 'adult', 'juvenile'),
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a),
		(SELECT COUNT(*) FROM juvenile AS j WHERE j.adult_member_no = m.member_no), NULL),
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a),
		(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE a.member_no = m.member_no),
		(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE a.member_no = 
			(SELECT j.adult_member_no FROM juvenile AS j WHERE j.member_no = m.member_no)))
FROM member AS m
WHERE m.member_no NOT IN 
	(SELECT l.member_no FROM loan AS l)
	AND
	m.member_no NOT IN
	(SELECT lh.member_no FROM loanhist AS lh)



/* pracownicy, ilość zamówień, łączna kwota zamówień (uwzgl. przesyłkę). zamówienia, które liczymy są z 1997
	luty, listujemy wszystkich pracowników nawet jeśli nie obsługiwał zamówień (wtedy obsl. 0, suma 0) */

USE Northwind
SELECT E.EmployeeID, CONCAT(E.FirstName, ' ', E.LastName),
	(SELECT COUNT(*) FROM Orders AS O WHERE
		O.EmployeeID = E.EmployeeID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2),
	ISNULL((SELECT SUM((1 - OD.Discount) * OD.Quantity * OD.UnitPrice) FROM Orders AS O
			INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
			WHERE O.EmployeeID = E.EmployeeID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2) + 
		(SELECT SUM(O.Freight) FROM Orders AS O
			WHERE O.EmployeeID = E.EmployeeID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2), 0)
FROM Employees AS E