/* Wybierz dzieci wraz z adresem, które nie wypo?yczy?y ksi??ek w lipcu 2001
autorstwa ‘Jane Austin’ */

USE library
SELECT j.member_no, 
	(SELECT CONCAT(m.firstname, ' ', m.lastname) FROM member AS m WHERE j.member_no = m.member_no),
	(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE j.adult_member_no = a.member_no)
FROM juvenile AS j
WHERE j.member_no NOT IN 
	(SELECT l.member_no FROM loan AS l WHERE YEAR(l.out_date) = 2001 AND MONTH(l.out_date) = 7 AND l.title_no IN 
		(SELECT t.title_no FROM title AS t WHERE t.author = 'Jane Austin'))
	AND j.member_no NOT IN
	(SELECT lh.member_no FROM loanhist AS lh WHERE YEAR(lh.out_date) = 2001 AND MONTH(lh.out_date) = 7 AND lh.title_no IN
		(SELECT t.title_no FROM title AS t WHERE t.author = 'Jane Austin'))



/* Wybierz kategori?, która w danym roku 1997 najwi?cej zarobi?a, podzia? na miesi?ce */

USE Northwind
SELECT Ca.CategoryID, Ca.CategoryName, MONTH(O.OrderDate), SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) FROM Categories AS Ca
INNER JOIN Products AS P ON Ca.CategoryID = P.CategoryID
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND YEAR(O.OrderDate) = 1997
WHERE Ca.CategoryID IN 
	(SELECT TOP 1 Ca2.CategoryID FROM Categories AS Ca2
	INNER JOIN Products AS P ON Ca2.CategoryID = P.CategoryID
	INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID AND YEAR(O.OrderDate) = 1997
	GROUP BY Ca2.CategoryID
	ORDER BY SUM((1 - OD.Discount) * OD.UnitPrice * OD.Quantity) DESC)
GROUP BY Ca.CategoryID, Ca.CategoryName, MONTH(O.OrderDate)



/* Dane pracownika i najcz?stszy dostawca pracowników bez podw?adnych */

USE Northwind
SELECT E.EmployeeID, CONCAT(E.FirstName, ' ', E.LastName), 
	(SELECT S.CompanyName FROM Shippers AS S WHERE S.ShipperID = 
		(SELECT TOP 1 O.ShipVia FROM Orders AS O WHERE O.EmployeeID = E.EmployeeID
		GROUP BY O.EmployeeID, O.ShipVia
		ORDER BY COUNT(O.OrderID)))
FROM Employees AS E
WHERE E.EmployeeID NOT IN 
	(SELECT E2.ReportsTo FROM Employees AS E2 WHERE E.EmployeeID = E2.ReportsTo)



/* Wybierz tytu?y ksi??ek, gdzie ilo?? wypo?ycze? ksi??ki jest wi?ksza od ?redniej ilo?ci
wypo?ycze? ksi??ek tego samego autora. */

USE library
SELECT t.title
	FROM title AS t
WHERE 
	((SELECT COUNT(l.out_date) FROM loan AS l WHERE t.title_no = l.title_no) + 
	(SELECT COUNT(lh.out_date) FROM loanhist AS lh WHERE t.title_no = lh.title_no)) >
	(((SELECT COUNT(l.out_date) FROM loan AS l WHERE l.title_no IN 
		(SELECT t2.title_no FROM title AS t2 WHERE t2.author = t.author)) + 
	(SELECT COUNT(lh.out_date) FROM loanhist AS lh WHERE lh.title_no IN 
		(SELECT t2.title_no FROM title AS t2 WHERE t2.author = t.author))) / 
	(SELECT COUNT(t2.title_no) FROM title AS t2 WHERE t2.author = t.author))
