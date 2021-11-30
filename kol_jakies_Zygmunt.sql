/*  Wy?wietl imi?, nazwisko, dane adresowe oraz ilo?? wypo?yczonych ksi??ek dla ka?dego cz?onka biblioteki. 
	Ilo?? wypo?yczonych ksi??ek nie mo?e by? nullem, co najwy?ej zerem. */

USE library
SELECT CONCAT(m.firstname, ' ', m.lastname),
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a), 
		(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE m.member_no = a.member_no), 
		(SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a WHERE a.member_no = 
			(SELECT j.adult_member_no FROM juvenile AS j WHERE j.member_no = m.member_no))),
	ISNULL((SELECT COUNT(*) FROM loan AS l WHERE l.member_no = m.member_no) + (SELECT COUNT(*) FROM loanhist AS lh WHERE lh.member_no = m.member_no), 0),
	IIF(m.member_no IN (SELECT a.member_no FROM adult AS a), 'adult', 'juvenile')
FROM member AS m



/* wy?wietl imiona i nazwiska osób, które nigdy nie wypo?yczy?y ?adnej ksi??ki */

USE library
SELECT CONCAT(m.firstname, ' ', m.lastname) FROM member AS m
LEFT OUTER JOIN loanhist AS lh ON m.member_no = lh.member_no
LEFT OUTER JOIN loan AS l ON m.member_no = l.member_no
WHERE l.title_no IS NULL AND lh.title_no IS NULL 

USE library
SELECT CONCAT(m.firstname, ' ', m.lastname) FROM member AS m
WHERE m.member_no NOT IN 
	(SELECT l.member_no FROM loan AS l)
	AND m.member_no NOT IN
	(SELECT lh.member_no FROM loanhist AS lh)



/* wy?wietl numery zamówie?, których cena dostawy by?a wi?ksza ni? ?rednia cena za przesy?k? w tym roku */

USE Northwind
SELECT O.OrderID FROM Orders AS O
CROSS JOIN Orders AS O2
WHERE YEAR(O2.OrderDate) = YEAR(O.OrderDate)
GROUP BY O.Freight, O.OrderID
HAVING O.Freight > AVG(O2.Freight)

USE Northwind
SELECT O.OrderID FROM Orders AS O
WHERE O.Freight > 
	(SELECT AVG(O2.Freight) FROM Orders AS O2 WHERE YEAR(O2.OrderDate) = YEAR(O.OrderDate))



/* 4. wy?wietl ile ka?dy z przewo?ników mia? dosta? wynagrodzenia w poszczególnych latach i miesi?cach. */

USE Northwind
SELECT Sh.CompanyName, SUM(O.Freight), YEAR(O.OrderDate), MONTH(O.OrderDate) FROM Shippers AS Sh
INNER JOIN Orders AS O ON Sh.ShipperID = O.ShipVia
GROUP BY Sh.CompanyName, YEAR(O.OrderDate), MONTH(O.OrderDate)

USE Northwind
SELECT 
	(SELECT Sh.CompanyName FROM Shippers AS Sh WHERE Sh.ShipperID = O.ShipVia),
	SUM(O.Freight), YEAR(O.OrderDate), MONTH(O.OrderDate)
FROM Orders AS O
GROUP BY O.ShipVia, YEAR(O.OrderDate), MONTH(O.OrderDate)
