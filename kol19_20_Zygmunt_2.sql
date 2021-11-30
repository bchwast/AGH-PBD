/* Wypisa? wszystkich czytelników, którzy nigdy nie wypo?yczyli ksi??ki dane
adresowe i podzia? czy ta osoba jest dzieckiem (joiny, in, exists) */

USE library
(SELECT m.member_no,  CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip), 
	'juvenile' FROM member AS m
INNER JOIN juvenile AS j ON m.member_no = j.member_no
INNER JOIN adult AS a ON j.adult_member_no = a.member_no
LEFT OUTER JOIN loanhist AS lh ON m.member_no = lh.member_no
WHERE lh.out_date IS NULL
INTERSECT
SELECT m.member_no, CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip), 
	'juvenile' FROM member AS m
INNER JOIN juvenile AS j ON m.member_no = j.member_no
INNER JOIN adult AS a ON j.adult_member_no = a.member_no
LEFT OUTER JOIN loan AS l ON m.member_no = l.member_no
WHERE l.out_date IS NULL)
UNION
(SELECT m.member_no,  CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip), 
	'adult' FROM member AS m
INNER JOIN adult AS a ON m.member_no = a.member_no
LEFT OUTER JOIN loanhist AS lh ON m.member_no = lh.member_no
WHERE lh.out_date IS NULL
INTERSECT
SELECT m.member_no,  CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip), 
	'adult' FROM member AS m
INNER JOIN adult AS a ON m.member_no = a.member_no
LEFT OUTER JOIN loan AS l ON m.member_no = l.member_no
WHERE l.out_date IS NULL)

USE library
SELECT m.member_no, (SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a
	WHERE (SELECT j.adult_member_no FROM juvenile AS j WHERE m.member_no = j.member_no) = a.member_no), 
	'juvenile' FROM member AS m
WHERE m.member_no IN (SELECT j.member_no FROM juvenile AS j) AND
	m.member_no NOT IN (SELECT lh.member_no FROM loanhist AS lh) AND
	m.member_no NOT IN (SELECT l.member_no FROM loan AS l)
UNION
SELECT m.member_no, (SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a
	WHERE m.member_no = a.member_no), 
	'adult' FROM member AS m
WHERE m.member_no IN (SELECT a.member_no FROM adult AS a) AND
	m.member_no NOT IN (SELECT lh.member_no FROM loanhist AS lh) AND
	m.member_no NOT IN (SELECT l.member_no FROM loan AS l)

USE library
SELECT m.member_no, (SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a
	WHERE (SELECT j.adult_member_no FROM juvenile AS j WHERE m.member_no = j.member_no) = a.member_no), 
	'juvenile' FROM member AS m
WHERE EXISTS (SELECT j.member_no FROM juvenile as j WHERE m.member_no = j.member_no) AND
	NOT EXISTS (SELECT lh.member_no FROM loanhist AS lh WHERE m.member_no = lh.member_no) AND
	NOT EXISTS (SELECT l.member_no FROM loan AS l WHERE m.member_no = l.member_no)
UNION
SELECT m.member_no, (SELECT CONCAT(a.street, ' ', a.city, ' ', a.state, ' ', a.zip) FROM adult AS a
	WHERE m.member_no = a.member_no), 
	'adult' FROM member AS m
WHERE EXISTS (SELECT a.member_no FROM adult as a WHERE m.member_no = a.member_no) AND
	NOT EXISTS (SELECT lh.member_no FROM loanhist AS lh WHERE m.member_no = lh.member_no) AND
	NOT EXISTS (SELECT l.member_no FROM loan AS l WHERE m.member_no = l.member_no)



/* Najcz??ciej wybierana kategoria w 1997 dla ka?dego klienta */

USE Northwind
SELECT C.CompanyName, (SELECT TOP 1 Ca.CategoryName FROM Customers AS C2
	INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
	INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
	INNER JOIN Products AS P ON OD.ProductID = P.ProductID
	INNER JOIN Categories AS Ca ON P.CategoryID = Ca.CategoryID
	WHERE YEAR(O.OrderDate) = 1997
	GROUP BY Ca.CategoryName
	ORDER BY COUNT(*) DESC) FROM Customers AS C


/* Dla ka?dego czytelnika imi? nazwisko, suma ksi??ek wypo?yczony przez t? osob? i
jej dzieci, który ?yje w Arizona ma mie? wi?cej ni? 2 dzieci lub kto ?yje w Kalifornii
ma mie? wi?cej ni? 3 dzieci */

USE library
SELECT m.member_no, m.firstname, m.lastname, 
	((SELECT COUNT(*) FROM loanhist AS lh WHERE m.member_no = lh.member_no)
		+ (SELECT COUNT(*) FROM loan AS l WHERE m.member_no = l.member_no))
	+ ((SELECT COUNT(*) FROM loanhist AS lh WHERE lh.member_no IN (SELECT j.member_no FROM juvenile AS j 
		WHERE m.member_no = j.adult_member_no)) + 
		(SELECT COUNT(*) FROM loan AS l WHERE l.member_no IN (SELECT j.member_no FROM juvenile AS j
		WHERE m.member_no = j.adult_member_no))), (SELECT a.state FROM adult AS a WHERE m.member_no = a.member_no) 
	FROM member AS m
WHERE m.member_no IN (SELECT j.adult_member_no FROM juvenile AS j) AND
	(((m.member_no IN (SELECT a.member_no FROM adult AS a WHERE a.state = 'AZ') 
		AND (SELECT COUNT(*) FROM juvenile AS j WHERE m.member_no = j.adult_member_no) > 2)) OR
	((m.member_no IN (SELECT a.member_no FROM adult AS a WHERE a.state = 'CA') 
		AND (SELECT COUNT(*) FROM juvenile AS j WHERE m.member_no = j.adult_member_no) > 3)))