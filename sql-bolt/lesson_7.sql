

-- 1: Find the list of all buildings that have employees


SELECT DISTINCT building_name 
FROM employees e
JOIN buildings b
ON e.building = b.building_name;


-- 2: Find the list of all buildings and their capacity

SELECT building_name, capacity 
FROM buildings;


-- 3: List all buildings and the distinct employee roles in each building (including empty buildings)


SELECT DISTINCT building_name, role 
FROM buildings b
LEFT JOIN employees e
ON b.building_name = e.building;