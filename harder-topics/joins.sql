


-- Let's go through examples of INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL OUTER JOIN using two simple tables: Employees and Departments.

-- Tables:




--                      Employees:

--      EmployeeID	    Name	        DepartmentID
--      1	            Alice	        101
--      2	            Bob	            102
--      3	            Charlie	        103
--      4	            David	        NULL



--                      Departments:

--      DepartmentID	    DepartmentName
--      101	                HR
--      102	                IT
--      104	                Finance




----------------------------------------------------------------------------



-- 1. INNER JOIN
-- An INNER JOIN returns only the rows that have matching values in both tables.

-- Query:

-- SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
-- FROM Employees
-- INNER JOIN Departments 
-- ON Employees.DepartmentID = Departments.DepartmentID;


-- Output:

-- EmployeeID	    Name	        DepartmentName
-- 1	            Alice	        HR
-- 2	            Bob	            IT




----------------------------------------------------------------------------

-- 2. LEFT JOIN (or LEFT OUTER JOIN)



-- A LEFT JOIN returns all rows from the left table (Employees), and the matched rows from the right table (Departments). If there is no match, NULL values are returned for columns from the right table.

-- Query:


-- SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
-- FROM Employees
-- LEFT JOIN Departments 
-- ON Employees.DepartmentID = Departments.DepartmentID;



-- Output:

-- EmployeeID	    Name	        DepartmentName
-- 1	            Alice	        HR
-- 2	            Bob	            IT
-- 3	            Charlie	        NULL
-- 4	            David	        NULL




----------------------------------------------------------------------------



-- 3. RIGHT JOIN (or RIGHT OUTER JOIN)



-- A RIGHT JOIN returns all rows from the right table (Departments), and the matched rows from the left table (Employees). If there is no match, NULL values are returned for columns from the left table.

-- Query:



-- SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
-- FROM Employees
-- RIGHT JOIN Departments 
-- ON Employees.DepartmentID = Departments.DepartmentID;



-- Output:


-- EmployeeID	        Name	        DepartmentName
-- 1	                Alice	        HR
-- 2	                Bob	            IT
-- NULL	                NULL	        Finance




----------------------------------------------------------------------------



-- 4. FULL OUTER JOIN


-- A FULL OUTER JOIN returns all rows when there is a match in either left (Employees) or right (Departments) table. Rows that do not have a match in one of the tables will have NULL values for columns from that table.

-- Query:


-- SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
-- FROM Employees
-- FULL OUTER JOIN Departments 
-- ON Employees.DepartmentID = Departments.DepartmentID;



-- Output:



-- EmployeeID	        Name	        DepartmentName
-- 1	                Alice	        HR
-- 2	                Bob	IT
-- 3	                Charlie	        NULL
-- 4	                David	        NULL
-- NULL	                NULL	        Finance







----------------------------------------------------------------------------




-- In SQL, a FULL OUTER JOIN can be simulated using a combination of LEFT JOIN, RIGHT JOIN, and the UNION operator if the database you're using (e.g., MySQL) does not natively support FULL OUTER JOIN. Here's how you can achieve it:



-- FULL OUTER JOIN Using UNION



-- A FULL OUTER JOIN can be achieved by combining the results of a LEFT JOIN and a RIGHT JOIN using the UNION operator. The UNION operator removes duplicate rows, which is perfect for this use case.



-- SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
-- FROM Employees
-- LEFT JOIN Departments 
-- ON Employees.DepartmentID = Departments.DepartmentID
-- UNION
-- SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
-- FROM Employees
-- RIGHT JOIN Departments 
-- ON Employees.DepartmentID = Departments.DepartmentID;



-- Explanation:
-- LEFT JOIN: Returns all rows from Employees and matching rows from Departments. If there is no match, NULL is returned for Departments columns.

-- RIGHT JOIN: Returns all rows from Departments and matching rows from Employees. If there is no match, NULL is returned for Employees columns.

-- UNION: Combines the results of the LEFT JOIN and RIGHT JOIN, removing duplicates.





-- Output:


-- EmployeeID	        Name	        DepartmentName
-- 1	                Alice	        HR
-- 2	                Bob	            IT
-- 3	                Charlie	        NULL
-- 4	                David	        NULL
-- NULL	                NULL	        Finance



--Breakdown of the Output:

-- Alice and Bob have matching rows in both tables, so they appear with their respective department names.

-- Charlie and David do not have matching department IDs in the Departments table, so their DepartmentName is NULL.

-- The Finance department does not have any matching employees, so the EmployeeID and Name are NULL.



-- Summary:


-- INNER JOIN: Only matching rows from both tables.

-- LEFT JOIN: All rows from the left table and matching rows from the right table.

-- RIGHT JOIN: All rows from the right table and matching rows from the left table.

-- FULL OUTER JOIN: All rows from both tables, with NULLs where there are no matches.