/* Zad.1 */

USE Northwind
SELECT TOP 1 P.ProductName FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1996
GROUP BY P.ProductName
ORDER BY SUM((1 - OD.Discount) * OD.Quantity * OD.UnitPrice)



/* Zad.2 */

USE library
SELECT CONCAT(m.firstname, ' ', m.lastname) AS 'Name',
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a), 
		(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE a.member_no = m.member_no),
		(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE a.member_no = 
			(SELECT j.adult_member_no FROM juvenile AS j WHERE j.member_no = m.member_no))) AS 'Address',
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a), 'Adult', 'Juvenile') AS 'Adult or Juvenile',
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a), 
		(SELECT COUNT(*) FROM juvenile AS j WHERE j.adult_member_no = m.member_no), NULL) AS 'Number of children if adult'
FROM member AS m
WHERE m.member_no NOT IN
	(SELECT l.member_no FROM loan AS l
	UNION
	SELECT lh.member_no FROM loanhist AS lh)



/* Zad.3 */

USE Northwind
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS 'Name',
	(SELECT COUNT(*) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2) AS 'Number of orders',
	ISNULL((SELECT SUM((1 - OD.Discount) * OD.Quantity * OD.UnitPrice) FROM Orders AS O
		INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
		WHERE O.EmployeeID = E.EmployeeID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2) +
		(SELECT SUM(O.Freight) FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2), 0) AS 'Generated income'
FROM Employees AS E