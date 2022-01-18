/* Jaki by? najpopularniejszy autor w?ród dzieci w Arizonie w 2001 */

USE library
SELECT TOP 1.author FROM title AS t
ORDER BY ((SELECT COUNT(*) FROM loan AS l WHERE t.title_no = l.title_no AND l.member_no IN 
		(SELECT j.member_no FROM juvenile AS j WHERE j.adult_member_no IN (
			SELECT a.member_no FROM adult AS a WHERE a.state = 'AZ')) AND YEAR(l.out_date) = 2001) + 
	(SELECT COUNT(*) FROM loanhist AS lh WHERE t.title_no = lh.title_no AND lh.member_no IN 
		(SELECT j.member_no FROM juvenile AS j WHERE j.adult_member_no IN (
			SELECT a.member_no FROM adult AS a WHERE a.state = 'AZ')) AND YEAR(lh.out_date) = 2001)) DESC



/* Dla ka?dego dziecka wybierz jego imi? nazwisko, adres, imi? i nazwisko rodzica i
ilo?? ksi??ek, które oboje przeczytali w 2001 */

USE library
SELECT j.member_no, 
	(SELECT CONCAT(m.firstname, ' ', m.lastname) FROM member AS m WHERE j.member_no = m.member_no), 
	(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE
		j.adult_member_no = a.member_no),
	(SELECT CONCAT(m.firstname, ' ', m.lastname) FROM member AS m WHERE m.member_no = j.adult_member_no),
	(SELECT COUNT(*) FROM loanhist AS lh WHERE lh.member_no = j.member_no AND YEAR(lh.out_date) = 2001) + 
	(SELECT COUNT(*) FROM loan AS l WHERE l.member_no = j.member_no AND YEAR(l.out_date) = 2001) + 
	(SELECT COUNT(*) FROM loanhist AS lh WHERE lh.member_no = j.adult_member_no AND YEAR(lh.out_date) = 2001) + 
	(SELECT COUNT(*) FROM loan AS l WHERE l.member_no = j.adult_member_no AND YEAR(l.out_date) = 2001)
FROM juvenile AS j



/* Kategorie które w roku 1997 grudzie? by?y obs?u?one wy??cznie przez ‘United
Package’ */USE NorthwindSELECT Ca.CategoryName FROM Orders AS OINNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderIDINNER JOIN Products AS P ON OD.ProductID = P.ProductIDINNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryIDINNER JOIN Shippers AS S ON O.ShipVia = S.ShipperID AND S.CompanyName = 'UnitedPackage'WHERE YEAR(ShippedDate) = 1997 AND MONTH(ShippedDate) = 12 AND Ca.CategoryName NOT IN 	(SELECT Ca.CategoryName FROM Orders AS O	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID	INNER JOIN Products AS P ON OD.ProductID = P.ProductID	INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID	INNER JOIN Shippers AS S ON O.ShipVia = S.ShipperID AND S.CompanyName != 'United Package'	WHERE YEAR(ShippedDate) = 1997 AND MONTH(ShippedDate) = 12	GROUP BY Ca.CategoryName)GROUP BY Ca.CategoryName/* Wybierz klientów, którzy kupili przedmioty wy??cznie z jednej kategorii w marcu
1997 i wypisz nazw? tej kategorii */

USE Northwind
SELECT C.CustomerID,
	(SELECT TOP 1 Ca.CategoryName FROM Customers AS C2
	INNER JOIN Orders AS O ON C2.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID
	WHERE C2.CustomerID = C.CustomerID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 3)
FROM Customers AS C
WHERE 
	(SELECT COUNT(DISTINCT Ca.CategoryName) FROM Customers AS C2
	INNER JOIN Orders AS O ON C2.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID
	WHERE C.CustomerID = C2.CustomerID AND YEAR(O.OrderDate) = 1997 AND MONTH(O.OrderDate) = 3) = 1
