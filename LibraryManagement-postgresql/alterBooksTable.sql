DROP TABLE IF EXISTS library_management.books CASCADE ;


-- Re-create Books Table to generate sequence of numbers for bookID column  
-- Create the sequence
CREATE SEQUENCE library_management.book_id_seq
  START WITH 1
  INCREMENT BY 1;

DROP TABLE IF EXISTS library_management.books;
CREATE TABLE library_management.books (
	bookId TEXT PRIMARY KEY,
	bookCode TEXT,
	bookName TEXT,
	authorId TEXT REFERENCES library_management.author (authorId),
	publisherId TEXT REFERENCES library_management.publisher (publisherId),
	bookVersion TEXT,
	releaseDate DATE,
	availableFrom DATE,
	isAvailable BOOLEAN
);




-- Inserting 10 records into the books table
INSERT INTO library_management.books (
    bookId, 
    bookCode, 
    bookName, 
    authorId, 
    publisherId, 
    bookVersion, 
    releaseDate, 
    availableFrom, 
    isAvailable
) VALUES
('B' || LPAD(nextval('library_management.book_id_seq')::TEXT, 3, '0'), 'BKC001', 'The Great Adventure', 'A001', 'P001', '1st Edition', '2020-01-01', '2020-01-10', TRUE),
('B' || LPAD(nextval('library_management.book_id_seq')::TEXT, 3, '0'), 'BKC002', 'Science for Kids', 'A002', 'P002', '2nd Edition', '2021-05-15', '2021-05-20', TRUE),
('B' || LPAD(nextval('library_management.book_id_seq')::TEXT, 3, '0'), 'BKC003', 'The History of Rome', 'A003', 'P003', '1st Edition', '2019-07-21', '2019-08-01', FALSE),
('B' || LPAD(nextval('library_management.book_id_seq')::TEXT, 3, '0'), 'BKC004', 'Advanced Mathematics', 'A004', 'P004', '3rd Edition', '2022-02-10', '2022-02-15', TRUE),
('B' || LPAD(nextval('library_management.book_id_seq')::TEXT, 3, '0'), 'BKC005', 'Introduction to Programming', 'A005', 'P005', '1st Edition', '2020-09-01', '2020-09-05', TRUE);

SET search_path TO library_management

select * from books

