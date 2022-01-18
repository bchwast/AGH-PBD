/* Wypisz wszystkich cz?onków biblioteki z adresami i info czy jest dzieckiem czy nie i
ilo?? wypo?ycze? w poszczególnych latach i miesi?cach. */

USE library
SELECT m.member_no, m.firstname, m.lastname, 'adult', 
	a.street + ' ' + a.city + ' ' + a.state +  a. zip, COUNT(MONTH(lh.out_date)), MONTH(lh.out_date), YEAR(lh.out_date)
	FROM member AS m
INNER JOIN adult AS a ON m.member_no = a.member_no
LEFT OUTER JOIN loanhist AS lh ON m.member_no = lh.member_no
GROUP BY MONTH(lh.out_date), YEAR(lh.out_date), m.member_no, m.firstname, m.lastname, 
	a.street + ' ' + a.city + ' ' + a.state +  a. zip
UNION
SELECT m.member_no, m.firstname, m.lastname, 'juvenile', 
	a.street + ' ' + a.city + ' ' + a.state +  a. zip, COUNT(MONTH(lh.out_date)), MONTH(lh.out_date), YEAR(lh.out_date)
	FROM member AS m
INNER JOIN juvenile AS j ON m.member_no = j.member_no
INNER JOIN adult AS a ON j.adult_member_no = a.member_no
LEFT OUTER JOIN loanhist AS lh ON m.member_no = lh.member_no
GROUP BY MONTH(lh.out_date), YEAR(lh.out_date), m.member_no, m.firstname, m.lastname, 
	a.street + ' ' + a.city + ' ' + a.state +  a. zip
ORDER BY 1



/* Zamówienia z Freight wi?kszym ni? AVG danego roku */

USE Northwind
SELECT O.OrderID, O.Freight FROM Orders AS O
WHERE O.Freight > (SELECT AVG(O2.Freight) FROM Orders AS O2 WHERE YEAR(O2.OrderDate) = YEAR(O.OrderDate))



/* Klienci, którzy nie zamówili nigdy nic z kategorii 'Seafood' w trzech wersjach. */

USE Northwind
SELECT C.CustomerID, C.CompanyName FROM Customers AS C
WHERE NOT EXISTS 
	(SELECT O.OrderID FROM Orders AS O WHERE C.CustomerID = O.CustomerID AND EXISTS
		(SELECT OD.OrderID FROM [Order Details] AS OD WHERE O.OrderID = OD.OrderID AND EXISTS
			(SELECT P.ProductID FROM Products AS P WHERE OD.ProductID = P.ProductID AND EXISTS
				(SELECT Ca.CategoryID FROM Categories AS Ca WHERE P.CategoryID = Ca.CategoryID AND 
					Ca.CategoryName = 'Seafood'))))

USE Northwind
SELECT C.CustomerID, C.CompanyName FROM Customers AS C
WHERE C.CustomerID NOT IN 
	(SELECT C2.CustomerID FROM Customers AS C2
	INNER JOIN Orders AS O ON C2.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID AND Ca.CategoryName = 'Seafood')

USE Northwind
SELECT C.CustomerID, C.CompanyName FROM Customers AS C
LEFT OUTER JOIN Orders AS O ON C.CustomerID = O.CustomerID
LEFT OUTER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
LEFT OUTER JOIN Products AS P ON OD.ProductID = P.ProductID
LEFT OUTER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID AND Ca.CategoryName = 'Seafood'
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(Ca.CategoryID) = 0

USE Northwind
SELECT C2.CustomerID, C2.CompanyName FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN Products AS P ON OD.ProductID = P.ProductID
INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID AND Ca.CategoryName = 'Seafood'
RIGHT OUTER JOIN Customers AS C2 ON C.CustomerID = C2.CustomerID
WHERE C.CustomerID IS NULL


/* Dla ka?dego klienta najcz??ciej zamawian? kategori? w dwóch wersjach. */

USE Northwind
SELECT C.CustomerID, C.CompanyName, (SELECT TOP 1 Ca.CategoryName FROM Customers AS C2
	INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID
	GROUP BY Ca.CategoryName
	ORDER BY COUNT(*) DESC) FROM Customers AS C 

USE Northwind
SELECT C.CustomerID, C.CompanyName FROM Customers AS C