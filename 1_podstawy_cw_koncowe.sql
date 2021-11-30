USE Library

SELECT title, title_no FROM title
SELECT title FROM title WHERE title_no = 10
SELECT member_no, fine_assessed FROM loanhist WHERE fine_assessed BETWEEN 8 AND 9
SELECT title_no, author FROM title WHERE author = 'Charles Dickens' OR author = 'Jane Austen'
SELECT title_no, title FROM title WHERE title LIKE '%adventures%'
SELECT member_no, fine_assessed, fine_paid FROM loanhist WHERE (ISNULL(fine_assessed, 0.00) + ISNULL(fine_waived, 0.00)) > ISNULL(fine_paid, 0.00)
SELECT DISTINCT city, state FROM adult

SELECT title FROM title ORDER BY title

SELECT member_no, isbn, fine_assessed, fine_assessed * 2 AS 'double fine' FROM loanhist WHERE ISNULL(fine_assessed, 0.00) <> 0

SELECT firstname + ' ' + middleinitial + '. ' + lastname AS 'email_name' FROM member WHERE lastname = 'Anderson'
SELECT LOWER(firstname + middleinitial + SUBSTRING(lastname, 1, 2)) AS 'email_name' FROM member WHERE lastname = 'Anderson'

SELECT 'The title is: ' + title + ', title number ' + CONVERT(varchar, title_no) FROM title