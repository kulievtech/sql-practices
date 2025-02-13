

-- 1: Find the longest time that an employee has been at the studio


SELECT MAX(DISTINCT years_employed) 
FROM employees;


-- 2: For each role, find the average number of years employed by employees in that role


SELECT role, AVG(years_employed) 
FROM employees
GROUP BY role;


-- 3: Find the total number of employee years worked in each building


SELECT building, SUM(years_employed) 
FROM employees
GROUP BY building;