-- Create Schema
DROP SCHEMA IF EXISTS library_management CASCADE;
CREATE SCHEMA IF NOT EXISTS library_management;

-- User Login Table
DROP TABLE IF EXISTS library_management.user_login;
CREATE TABLE library_management.user_login (
	userid TEXT PRIMARY KEY,
	userpassword TEXT,
	firstName TEXT,
	lastName TEXT,
	signupon_date DATE,
	emailid TEXT
);

-- Publisher Table
DROP TABLE IF EXISTS library_management.publisher;
CREATE TABLE library_management.publisher (
	publisherid TEXT PRIMARY KEY,
	publisher TEXT,
	distributor TEXT,
	releasesCount INT,
	lastRelease DATE
);

-- Author Table
DROP TABLE IF EXISTS library_management.author;
CREATE TABLE library_management.author (
	authorId TEXT PRIMARY KEY,
	firstName TEXT,
	lastName TEXT,
	publicationsCount INT
);

-- Books Table
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

-- Staff Table
DROP TABLE IF EXISTS library_management.staff;
CREATE TABLE library_management.staff (
	staffId TEXT PRIMARY KEY,
	firstName TEXT,
	lastName TEXT,
	staffRole TEXT,
	startDate DATE,
	lastDate DATE,
	isActive BOOLEAN,
	workShiftStart TIME,
	workShiftEnd TIME
);

-- Readers Table
DROP TABLE IF EXISTS library_management.readers;
CREATE TABLE library_management.readers (
	readerId TEXT PRIMARY KEY,
	firstName TEXT,
	lastName TEXT,
	registeredOn DATE,
	booksIssuedTotal INT,
	booksIssuedCurrent INT,
	isIssued BOOLEAN,
	lastIssueDate DATE,
	totalFine FLOAT,
	currentFine FLOAT
);

-- Books Issue Table
DROP TABLE IF EXISTS library_management.books_issue;
CREATE TABLE library_management.books_issue (
	issueId SERIAL PRIMARY KEY,
	bookId TEXT REFERENCES library_management.books (bookId),
	issuedTo TEXT,-- REFERENCES library_management.readers (issuedTo),
	issuedOn DATE,
	returnOn DATE,
	currentFine FLOAT,
	finePaid BOOLEAN,
	paymentTransactionId TEXT
);

-- Settings Table
DROP TABLE IF EXISTS library_management.settings;
CREATE TABLE library_management.settings (
	bookIssueCountPerReader INT,
	finePerDay FLOAT,
	bookReturnInDays INT
);

-- insert data into Settings table 
INSERT INTO library_management.settings (bookIssueCountPerReader, finePerDay, bookReturnInDays)
VALUES
  (5, 0.50, 14),  
  (3, 1.00, 7),   
  (10, 0.25, 21), 
  (7, 0.75, 30),  
  (4, 0.60, 10);  

-- inert data in User Login Table
INSERT INTO library_management.user_login (userid, userpassword, firstName, lastName, signupon_date, emailid)
VALUES
  ('U001', '$2a$12$1aWm7/9iOpDA7TZtLbdbwO1Ujz1.ytiR7W0hz.cGL70Vynq9eykIu', 'Alice', 'Williams', '2024-01-01', 'alice.williams@example.com'),  
  ('U002', '$2a$12$XqF4W9xfg9uBhnc1BwZAGFhTP3YX0jV0ALlLvA8zN5FfLw9rYvATa', 'Bob', 'Johnson', '2023-12-15', 'bob.johnson@example.com'),      
  ('U003', '$2a$12$wOpNlDZ7Od.kgqH0vI0yA5wRG9A4vW7vXI0wy3cb63ZZiD7/jfuyu', 'Charlie', 'Brown', '2023-11-10', 'charlie.brown@example.com'),  
  ('U004', '$2a$12$XHl3Zl10FdBc79EVGyXITqVX9gIbqTh1npFsM7GRuWws2zG5p/jA2', 'David', 'Martinez', '2022-05-20', 'david.martinez@example.com'), 
  ('U005', '$2a$12$ZTzDPyQYih1WoP4f2we5v65SyX8RhAP5xkHt/KMRVoz8zF0S.2K0G', 'Eve', 'Taylor', '2023-08-01', 'eve.taylor@example.com');        

-- insert data for Publisher Table

INSERT INTO library_management.publisher (publisherid, publisher, distributor, releasesCount, lastRelease)
VALUES
  ('P001', 'Penguin Random House', 'Random House Distribution', 200, '2024-01-15'), 
  ('P002', 'HarperCollins', 'Harper Distribution', 150, '2023-11-10'),              
  ('P003', 'Macmillan', 'Macmillan Distribution', 100, '2023-12-05'),               
  ('P004', 'Simon & Schuster', 'Simon & Schuster Distribution', 75, '2024-01-02'),    
  ('P005', 'Oxford University Press', 'Oxford Distribution', 250, '2023-09-20');       

-- insert data into Author Table
INSERT INTO library_management.author (authorId, firstName, lastName, publicationsCount)
VALUES
  ('A001', 'J.K.', 'Rowling', 15),  
  ('A002', 'John', 'Doe', 5),       
  ('A003', 'Jane', 'Smith', 10),     
  ('A004', 'George', 'Martin', 8),  
  ('A005', 'Isaac', 'Asimov', 45); 

--insert data into Books Table

INSERT INTO library_management.books (bookId, bookCode, bookName, authorId, publisherId, bookVersion, releaseDate, availableFrom, isAvailable)
VALUES
  ('B001', 'BC001', 'The Great Adventure', 'A001', 'P001', '1st Edition', '2022-05-15', '2022-06-01', TRUE), 
  ('B002', 'BC002', 'Introduction to Programming', 'A002', 'P002', '2nd Edition', '2023-01-20', '2023-02-01', TRUE),  
  ('B003', 'BC003', 'Advanced Database Systems', 'A003', 'P003', '3rd Edition', '2021-11-10', '2021-12-01', FALSE),  
  ('B004', 'BC004', 'Machine Learning Basics', 'A004', 'P004', '1st Edition', '2024-03-05', '2024-03-15', TRUE),  
  ('B005', 'BC005', 'Data Structures and Algorithms', 'A005', 'P005', '1st Edition', '2023-08-25', '2023-09-01', TRUE);  



  -- insert data into books_issue table 

  INSERT INTO library_management.books_issue (bookId, issuedTo, issuedOn, returnOn, currentFine, finePaid, paymentTransactionId)
VALUES
  ('B001', 'R001', '2025-01-01', '2025-01-15', 3.00, FALSE, NULL),  
  ('B002', 'R002', '2025-01-05', '2025-01-19', 4.50, TRUE, 'T001'), 
  ('B003', 'R003', '2025-01-10', '2025-01-24', 2.25, FALSE, NULL),  
  ('B004', 'R004', '2025-01-12', '2025-01-26', 1.50, TRUE, 'T002'), 
  ('B005', 'R005', '2025-01-15', '2025-01-29', 5.00, FALSE, NULL);  

-- insert data into Readers Table

INSERT INTO library_management.readers (readerId, firstName, lastName, registeredOn, booksIssuedTotal, booksIssuedCurrent, isIssued, lastIssueDate, totalFine, currentFine)
VALUES
  ('R001', 'John', 'Doe', '2024-05-10', 5, 1, TRUE, '2025-01-01', 10.50, 3.00),  
  ('R002', 'Jane', 'Smith', '2023-09-15', 10, 2, TRUE, '2025-01-05', 25.00, 4.50),  
  ('R003', 'Michael', 'Johnson', '2022-03-22', 3, 0, FALSE, '2024-12-10', 5.00, 0.00),  
  ('R004', 'Emily', 'Davis', '2021-08-30', 7, 1, TRUE, '2025-01-12', 12.00, 1.50), 
  ('R005', 'William', 'Martinez', '2023-11-01', 4, 2, TRUE, '2025-01-15', 8.00, 5.00); 

-- insert data into Staff Table

INSERT INTO library_management.staff (staffId, firstName, lastName, staffRole, startDate, lastDate, isActive, workShiftStart, workShiftEnd)
VALUES
  ('S001', 'Alice', 'Williams', 'Librarian', '2020-02-10', NULL, TRUE, '09:00:00', '17:00:00'),  
  ('S002', 'Bob', 'Johnson', 'Assistant Librarian', '2021-06-15', NULL, TRUE, '10:00:00', '18:00:00'),  
  ('S003', 'Charlie', 'Brown', 'Library Manager', '2018-03-01', NULL, TRUE, '08:00:00', '16:00:00'),  
  ('S004', 'David', 'Martinez', 'Cleaner', '2019-11-01', '2024-12-31', FALSE, '14:00:00', '22:00:00'),  
  ('S005', 'Eve', 'Taylor', 'Security Officer', '2022-09-01', NULL, TRUE, '22:00:00', '06:00:00'); 


  

 
