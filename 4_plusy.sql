/* Dla każego czytelnika podaj jego imię i nazwisko oraz łączną karę,
 którą zapłacił w 2001 */

 USE library
 SELECT m.firstname, m.lastname, (SELECT SUM(lh.fine_paid) FROM loanhist AS lh
	WHERE YEAR(lh.due_date) = 2001 AND lh.member_no = m.member_no) FROM member AS m
ORDER BY 3 DESC
 
 USE library
 SELECT m.firstname, m.lastname, SUM(lh.fine_paid) FROM member as m
 LEFT OUTER JOIN loanhist AS lh ON m.member_no = lh.member_no AND YEAR(lh.due_date) = 2001
 GROUP BY m.member_no ,m.firstname, m.lastname
 ORDER BY 3 DESC



 /* Który z tytułów był najczęściej wypożyczany w 2001r */

 USE library
 SELECT TOP 1 t.title, (SELECT COUNT(*) FROM loanhist AS lh WHERE YEAR(lh.out_date) = 2001 AND t.title_no = lh.title_no) +
 (SELECT COUNT(*) FROM loan AS l WHERE YEAR(l.out_date) = 2001 AND t.title_no = l.title_no) FROM title AS t
 ORDER BY 2 DESC


 
 /* Dla każdego członka biblioteki oprócz imienia i nazwiska podaj liczbę książek zwróconych przez
  niego w 2001r. Dodatkowo proszę podać informację, czy dana osoba jest dorosłym czytelnikiem,
  czy dzieckiem (union)*/

USE library
SELECT m.member_no, m.firstname, m.lastname, (SELECT COUNT(*) FROM loanhist AS lh WHERE YEAR(lh.in_date) = 2001
	AND m.member_no = lh.member_no), 'adult' FROM member AS m
WHERE EXISTS (SELECT a.member_no FROM adult AS a WHERE m.member_no = a.member_no)
UNION
SELECT m.member_no, m.firstname, m.lastname, (SELECT COUNT(*) FROM loanhist AS lh WHERE YEAR(lh.in_date) = 2001
	AND m.member_no = lh.member_no), 'juvenile' FROM member AS m
WHERE EXISTS (SELECT j.member_no FROM juvenile AS j WHERE m.member_no = j.member_no)
ORDER BY 4 DESC



/* Czy są jacyś czytelnicy, którzy nie przeczytali żadnej książki w 2001 roku?
 Podaj ich dane (identyfikator, imię, nazwisko) */

USE library
SELECT m.member_no, m.firstname, m.lastname FROM member AS m
LEFT OUTER JOIN loanhist AS lh ON m.member_no = lh.member_no AND YEAR(lh.out_date) = 2001
WHERE lh.out_date IS NULL
INTERSECT
SELECT m.member_no, m.firstname, m.lastname FROM member AS m
LEFT OUTER JOIN loan AS l ON m.member_no = l.member_no AND YEAR(l.out_date) = 2001
WHERE l.out_date IS NULL



/* Podaj wszystkie */

USE Northwind
SELECT O.OrderID FROM Orders AS O
WHERE O.Freight > (SELECT AVG(OO.Freight) FROM Orders AS OO WHERE YEAR(OO.OrderDate) = YEAR(O.OrderDate))
ORDER BY 1



/* Podaj pozycje zamówień, których wartość po uwzględnieniu rabatu jest mniejsza od średniej wartości
  pozycji wchodzących w skład danego zamówienia */

USE Northwind
SELECT OD.OrderID, OD.ProductID, ROUND((SELECT AVG((1 - OD2.Discount) * OD2.Quantity * OD2.UnitPrice) FROM [Order Details] AS OD2
	WHERE OD.OrderID = OD2.OrderID), 2) FROM [Order Details] AS OD
WHERE (1 - OD.Discount) * OD.Quantity * OD.UnitPrice < 
	(SELECT AVG((1 - OD2.Discount) * OD2.Quantity * OD2.UnitPrice) FROM [Order Details] AS OD2
	WHERE OD.OrderID = OD2.OrderID)