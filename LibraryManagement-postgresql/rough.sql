SET search_path TO library_management

-- update bookid's to be in line with books table 
update books_issue 
set bookid = 'B015'
where bookid='B005';

-- alter table to add a new column 
ALTER TABLE books_issue
ADD COLUMN actualReturnon DATE ;


-- drop column currentfine from books_issue as the column also present in readers. 
ALTER TABLE books_issue
DROP COLUMN currentfine;

-- update actual return date for reader 'R001'
update books_issue 
set actualreturnon = '2025-02-01'
where issuedto='R001';

-- update all the records so that total fine and current fine is 0 
UPDATE readers
SET totalfine = 0, currentfine = 0;




-- 

select * from books;
select * from books_issue;
select * from author;
select * from readers;


-- Calculate total fine due for books overdue 
WITH FineCalculation AS (
    SELECT 
        r.readerid,
        r.firstname,
        r.lastname,
        b.bookname,
        b.bookid,
        s.issuedon,
        s.returnon,
        r.totalfine,
        r.currentfine,
        s.actualreturnon,
        -- Calculate the delay in return
        EXTRACT(DAY FROM AGE(s.returnon, s.issuedon)) AS days,
		-- Add the CASE statement to calculate total fine
        CASE 
            WHEN EXTRACT(DAY FROM AGE(s.returnon, s.issuedon)) <= 14 THEN 0
            ELSE EXTRACT(DAY FROM AGE(s.returnon, s.issuedon)) * 0.50
        END AS calculated_totalfine
    FROM books b
    LEFT JOIN books_issue s ON b.bookid = s.bookid
    LEFT JOIN readers r ON r.readerid = s.issuedto
)

SELECT 
    readerid,
    firstname,
    lastname,
    bookname,
    bookid,
    issuedon,
    returnon,
    actualreturnon,
    days,
	calculated_totalfine, 
		-- set total fine and current fine 
		totalfine+calculated_totalfine as totalfine,
		calculated_totalfine as currentfine
FROM FineCalculation;


-- How many books are currently borrowed  by each user? 
WITH booksBorrowed AS (
    SELECT 
        r.readerid,
        r.firstname,
        r.lastname,
        COUNT(s.bookid) OVER (PARTITION BY r.readerid) AS books_borrowed
    FROM readers r
    LEFT JOIN books_issue s ON r.readerid = s.issuedto
    -- WHERE s.returnon IS NULL OR s.returnon > CURRENT_DATE
)
SELECT 
    readerid,
    firstname,
    lastname,
    MAX(books_borrowed) AS max_books_borrowed
FROM booksBorrowed
GROUP BY readerid, firstname, lastname
ORDER BY readerid;
