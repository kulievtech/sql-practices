

-- 1: Find the name and role of all employees who have not been assigned to a building


SELECT e.name, e.role 
FROM employees e
LEFT JOIN buildings b
ON e.building = b.building_name
WHERE e.building IS NULL;



-- 2: Find the names of the buildings that hold no employees


SELECT b.building_name 
FROM buildings b
LEFT JOIN employees e
ON e.building = b.building_name
WHERE e.building IS NULL;