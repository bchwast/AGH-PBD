/* dzieci, które 14 grudnia 2001 zwróciły książkę o tytule 'walking' */

USE library
SELECT j.member_no, 
	(SELECT CONCAT(m.firstname, ' ', m.lastname) FROM member AS m WHERE m.member_no = j.member_no)
FROM juvenile AS j
WHERE j.member_no IN 
	(SELECT lh.member_no FROM loanhist AS lh
	INNER JOIN title AS t ON lh.title_no = t.title_no
	WHERE t.title = 'Walking' AND CONVERT(DATE, lh.in_date) = '2001-12-14' )



/* produkty, dostawcy, kategorie, gdzie	zamówienie nie było w przedziale 1997 luty 20 do luty 25 */

USE Northwind
SELECT P.ProductName, S.CompanyName, Ca.CategoryName FROM Products AS P
INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID
INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID
WHERE P.ProductName NOT IN 
	(SELECT P2.ProductName FROM Products AS P2
	INNER JOIN [Order Details] AS OD ON P2.ProductID = OD.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
	WHERE YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2 AND DAY(O.OrderDate) BETWEEN 20 AND 25)

USE Northwind
SELECT P.ProductName,
	(SELECT S.CompanyName FROM Suppliers AS S WHERE P.SupplierID = S.SupplierID),
	(SELECT Ca.CategoryName FROM Categories AS Ca WHERE P.CategoryID = Ca.CategoryID)
FROM Products AS P
WHERE P.ProductName NOT IN
	(SELECT P2.ProductName FROM Products AS P2
	INNER JOIN [Order Details] AS OD ON P2.ProductID = OD.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
	WHERE YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 2 AND DAY(O.OrderDate) BETWEEN 20 AND 25)


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
	
select concat(FirstName, ' ', LastName), count(*), sum(quantity * UnitPrice * (1 - discount)) + max(freight)
from Employees E
left join Orders O on E.EmployeeID = O.EmployeeID
left join [Order Details] OD on O.OrderID = OD.OrderID
where year(OrderDate) = 1997 and month(OrderDate) = 2
group by FirstName, LastName
union
select concat(FirstName, ' ', LastName), 0, 0
from Employees E
left join Orders O on E.EmployeeID = O.EmployeeID
left join [Order Details] OD on O.OrderID = OD.OrderID
group by FirstName, LastName
except
select concat(FirstName, ' ', LastName), 0, 0
from Employees E
left join Orders O on E.EmployeeID = O.EmployeeID
left join [Order Details] OD on O.OrderID = OD.OrderID
where year(OrderDate) = 1997 and month(OrderDate) = 2
group by FirstName, LastName