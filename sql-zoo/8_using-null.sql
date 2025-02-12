            -- teacher
-- id	    dept	    name	        phone	    mobile
-- 101	    1	        Shrivell	    2753	    07986 555 1234
-- 102	    1	        Throd	        2754	    07122 555 1920
-- 103	    1	        Splint	        2293	
-- 104		            Spiregrain	    3287	
-- 105	    2	        Cutflower	    3212	    07996 555 6574
-- 106		            Deadyawn	    3345	


                -- dept
--      id	                name
--      1	                Computing
--      2	                Design
--      3	                Engineering





-- Teachers and Departments
-- The school includes many departments. Most teachers work exclusively for a single department. Some teachers have no department.

-- Selecting NULL values.

-- NULL, INNER JOIN, LEFT JOIN, RIGHT JOIN



-- 1:

-- List the teachers who have NULL for their department.

-- Why we cannot use =
    -- You might think that the phrase dept=NULL would work here but it doesn't you can use the phrase dept IS NULL


SELECT t.name
FROM teacher t
LEFT JOIN dept d
ON t.dept = d.id
WHERE t.dept IS NULL;



-- 2:

-- Note the INNER JOIN misses the teachers with no department and the departments with no teacher.

SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept
ON (teacher.dept=dept.id)


-- 3:

-- Use a different JOIN so that all teachers are listed.


SELECT t.name, d.name
FROM teacher t
LEFT JOIN dept d
ON t.dept = d.id;



-- 4:

-- Use a different JOIN so that all departments are listed.

SELECT t.name, d.name
FROM teacher t
RIGHT JOIN dept d
ON t.dept = d.id;