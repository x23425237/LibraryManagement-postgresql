SET search_path TO library_management

select upper(s.eircode),s.* from staff s

-- Alter staff table to include new columns 
ALTER TABLE library_management.staff
ADD COLUMN dateOfBirth DATE,
ADD COLUMN email TEXT,
ADD COLUMN phoneNumber TEXT,
ADD COLUMN address1 TEXT,
ADD COLUMN address2 TEXT,
ADD COLUMN eircode TEXT,
ADD COLUMN gender TEXT,
ADD COLUMN lastLogin TIMESTAMP,
ADD COLUMN workEmail TEXT;



-- update emails for staff id 
UPDATE staff
SET email = 'Alice.Williams@email.com',
dateOfBirth = '1988-09-11',  
    eircode = 'wet34b6',
	phonenumber = '0874223498',
	address1 = '4321 Maple Drive',
	address2 = 'New York, NY 10001'
WHERE staffid = 'S001'; 

UPDATE staff
SET email = 'Charlie.Brown@email.com',
dateOfBirth = '1982-01-12',  
    eircode = 'jrt6c79',
	phonenumber = '08548765498',
	address1 = '1011 Birch Boulevard',
	address2 = 'Chicago, IL 60601'
WHERE staffid = 'S002'; 

UPDATE staff
SET email = 'David.Martinez@email.com',
    dateOfBirth = '1980-04-12',  
    eircode = 'I64F6I9',
	phonenumber = '0654423498',
	address1 = '5678 Oak Avenue',
	address2 = 'Los Angeles, CA 90001'
WHERE staffid = 'S003';
 


 

