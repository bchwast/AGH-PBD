/* Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej
pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy */

USE Northwind
SELECT ProductName, UnitPrice, Suppliers.ContactName FROM Products INNER JOIN SUPPLIERS ON 
Products.SupplierID = Suppliers.SupplierID WHERE UnitPrice BETWEEN 20 AND 30 



/* Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów
dostarczanych przez firmę ‘Tokyo Traders’ */

SELECT ProductName, UnitsInStock FROM Products INNER JOIN SUPPLIERS ON
Products.SupplierID = Suppliers.SupplierID WHERE Suppliers.CompanyName = 'Tokyo Traders'



/* Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak
to pokaż ich dane adresowe */

SELECT Orders.CustomerID, CompanyName, Address, YEAR(Orders.OrderDate) FROM Customers LEFT OUTER JOIN Orders ON
Customers.CustomerID = Orders.CustomerID AND YEAR(Orders.OrderDate) = 1997
WHERE YEAR(Orders.OrderDate) IS NULL



/* Wybierz nazwy i numery telefonów dostawców, dostarczających produkty,
których aktualnie nie ma w magazynie */

SELECT CompanyName, Phone FROM Suppliers INNER JOIN Products ON
Suppliers.SupplierID = Products.SupplierID WHERE Products.UnitsInStock = 0



/* Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
library). Interesuje nas imię, nazwisko i data urodzenia dziecka. */

USE library
SELECT firstname, lastname, juvenile.birth_date FROM member
INNER JOIN juvenile ON member.member_no = juvenile.member_no



/* Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek */

SELECT title FROM title
INNER JOIN loan ON title.title_no = loan.title_no
GROUP BY title



/* Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao
Teh King’. Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką
zapłacono karę */

USE library
SELECT in_date, DAY(in_date - due_date), fine_paid, fine_assessed FROM loanhist
INNER JOIN title ON loanhist.title_no = title.title_no
WHERE title.title = 'Tao Teh King' AND in_date > due_date



/* Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych
przez osobę o nazwisku: Stephen A. Graff */

SELECT reservation.isbn FROM member INNER JOIN reservation
ON member.member_no = reservation.member_no
WHERE lastname = 'Graff' AND firstname = 'Stephen' AND middleinitial = 'A'



/* Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej
pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy,
interesują nas tylko produkty z kategorii ‘Meat/Poultry’ */

USE Northwind

SELECT ProductName, UnitPrice, Suppliers.Address,
Suppliers.City, Suppliers.Region, Suppliers.PostalCode, Suppliers.Country FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE (UnitPrice BETWEEN 20 AND 30) AND Categories.CategoryName = 'Meat/Poultry'



/* Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu
podaj nazwę dostawcy. */

USE Northwind
SELECT ProductName, UnitPrice, Suppliers.CompanyName FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Categories.CategoryName = 'Confections'



/* Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki
dostarczała firma ‘United Package’ */

USE Northwind
SELECT Customers.CompanyName, Customers.Phone FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE YEAR(Orders.ShippedDate) = 1997 AND Shippers.CompanyName = 'United Package'



/* Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii
‘Confections’ */

USE Northwind
SELECT DISTINCT CompanyName, Phone FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Confections'



/* Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
library). Interesuje nas imię, nazwisko, data urodzenia dziecka i adres
zamieszkania dziecka */

USE library
SELECT firstname, lastname, juvenile.birth_date, adult.city, adult.street FROM member
INNER JOIN juvenile ON member.member_no = juvenile.member_no
INNER JOIN adult ON juvenile.adult_member_no = adult.member_no



/* Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
library). Interesuje nas imię, nazwisko, data urodzenia dziecka, adres
zamieszkania dziecka oraz imię i nazwisko rodzica. */

USE library
SELECT a.firstname as 'child.firstname', a.lastname as 'child.lastname', juvenile.birth_date, adult.city,
adult.street, b.firstname as 'parent.firstname', b.lastname as 'parent.lastname' FROM member AS a
INNER JOIN juvenile ON a.member_no = juvenile.member_no
INNER JOIN adult ON juvenile.adult_member_no = adult.member_no
INNER JOIN member AS b ON adult.member_no = b.member_no



/* Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza
northwind) */

USE Northwind
SELECT a.FirstName as 'emp.fname', a.LastName as 'emp.lname', a.EmployeeID, 
b.FirstName as 'boss.fname', b.LastName as 'boss.lname', b.EmployeeID FROM Employees as a
LEFT OUTER JOIN Employees as b ON a.ReportsTo = b.EmployeeID



/* Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych
(baza northwind) */

SELECT a.FirstName, a.LastName, a.EmployeeID FROM Employees as a
LEFT OUTER JOIN Employees as b ON b.ReportsTo = a.EmployeeID
WHERE b.EmployeeID IS NULL



/* Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci
urodzone przed 1 stycznia 1996 */

USE library
SELECT DISTINCT adult_member_no, street, city FROM adult
INNER JOIN juvenile ON adult.member_no = juvenile.adult_member_no
WHERE juvenile.birth_date < '1996-01-01'



/* Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci
urodzone przed 1 stycznia 1996. Interesują nas tylko adresy takich członków
biblioteki, którzy aktualnie nie przetrzymują książek. */

SELECT DISTINCT adult_member_no, street, city FROM adult
INNER JOIN juvenile ON adult.member_no = juvenile.adult_member_no
LEFT OUTER JOIN loan ON adult.member_no = loan.member_no
WHERE juvenile.birth_date < '1996-01-01'
AND (loan.member_no IS NULL OR due_date > GETDATE())



/* Napisz polecenie które zwraca imię i nazwisko (jako pojedynczą kolumnę –
name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedynczą
kolumnę – address) dla wszystkich dorosłych członków biblioteki */

USE library
SELECT CONCAT_WS(' ', firstname, lastname) as name, CONCAT_WS(' ', adult.street, adult.city, adult.state, adult.zip) as address FROM member
INNER JOIN adult on member.member_no = adult.member_no



/* Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title, translation, cover,
dla książek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN */

SELECT copy.isbn, copy_no, on_loan, title.title, item.translation, item.cover FROM copy
INNER JOIN title ON copy.title_no = title.title_no
INNER JOIN item ON copy.isbn = item.isbn
WHERE copy.isbn IN (1, 500, 1000)
ORDER BY 1



/* Napisz polecenie które zwraca o użytkownikach biblioteki o nr 250, 342, i 1675
(dla każdego użytkownika: nr, imię i nazwisko członka biblioteki), oraz informację
o zarezerwowanych książkach (isbn, data) */

SELECT member.member_no, firstname, lastname, reservation.isbn, reservation.log_date FROM member
LEFT OUTER JOIN reservation ON member.member_no = reservation.member_no
WHERE member.member_no IN (250, 342, 1675)



/* Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają więcej niż
dwoje dzieci zapisanych do biblioteki */

USE library
SELECT firstname, lastname, COUNT(*) FROM member
INNER JOIN adult ON member.member_no = adult.member_no
INNER JOIN juvenile ON adult.member_no = juvenile.adult_member_no
WHERE adult.state = 'AZ'
GROUP BY member.member_no, firstname, lastname
HAVING COUNT(*) > 2



/* 1. Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają więcej
niż dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkają w Kaliforni
(CA) i mają więcej niż troje dzieci zapisanych do biblioteki */

USE library
SELECT firstname, lastname, COUNT(*) FROM member
INNER JOIN adult ON member.member_no = adult.member_no
INNER JOIN juvenile ON adult.member_no = juvenile.adult_member_no
WHERE adult.state = 'AZ'
GROUP BY member.member_no, firstname, lastname
HAVING COUNT(*) > 2
UNION
SELECT firstname, lastname, COUNT(*) FROM member
INNER JOIN adult ON member.member_no = adult.member_no
INNER JOIN juvenile ON adult.member_no = juvenile.adult_member_no
WHERE adult.state = 'CA'
GROUP BY member.member_no, firstname, lastname
HAVING COUNT(*) > 3



USE joindb
SELECT buyer_name, sales.buyer_id, qty
FROM buyers LEFT OUTER JOIN sales
ON buyers.buyer_id = sales.buyer_id