-- COALESCE is a function used in SQL that returns the first non-null value from a list of arguments. It is commonly used to handle null values in databases by providing a default value when a column contains null.

-- COALESCE(x,y,z) = y if x is NULL and y is not NULL
-- COALESCE(x,y,z) = x if x is not NULL
-- COALESCE(x,y,z) = z if x and y are NULL but z is not NULL
-- COALESCE(x,y,z) = NULL if x and y and z are all NULL



-- Syntax:

-- COALESCE(value1, value2, value3, ..., valueN) 
-- The function evaluates the arguments in order and returns the first non-null value.
-- If all arguments are null, it returns null.


-- Simple Example:
-- Imagine you have a table called Employees with the following data:

-- EmployeeID	Name	    Phone	        Email
-- 1	        John	    NULL	        john@example.com
-- 2	        Alice	    123-456-789	    NULL
-- 3	        Bob	        NULL	        NULL

-- You want to retrieve the contact information for each employee, prioritizing the phone number over the email. If both are null, you want to return "No Contact Info".

-- You can use COALESCE like this:

SELECT Name, COALESCE(Phone, Email, 'No Contact Info') AS ContactInfo
FROM Employees;


-- Result:
-- Name	            ContactInfo
-- John	            john@example.com
-- Alice	        123-456-789
-- Bob	            No Contact Info



-- Explanation:
-- For John, Phone is null, so it checks Email and returns john@example.com.

-- For Alice, Phone is not null, so it returns 123-456-789.

-- For Bob, both Phone and Email are null, so it returns the default value 'No Contact Info'.

