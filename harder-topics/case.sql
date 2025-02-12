

-- The CASE statement in SQL is a conditional expression that allows you to perform conditional logic in your queries. It works similarly to if-else or switch statements in programming languages. You can use it to evaluate conditions and return specific values based on those conditions.


-- Syntax:
-- There are two forms of the CASE statement:




-- Simple CASE:

-- CASE expression
--    WHEN value1 THEN result1
--    WHEN value2 THEN result2
--
--    ELSE default_result
-- END



-- Searched CASE:

-- CASE
--    WHEN condition1 THEN result1
--    WHEN condition2 THEN result2
--    ELSE default_result
-- END



-- The CASE statement evaluates conditions in order and returns the corresponding result for the first true condition.

-- If no conditions are true, it returns the ELSE value (if specified) or NULL.


-- Simple Example:
-- Imagine you have a table called Students with the following data:

-- StudentID	Name	    Score
-- 1	        John	    85
-- 2	        Alice	    92
-- 3	        Bob	        78
-- 4	        Emma	    65


-- You want to categorize each student's score as "Excellent", "Good", "Average", or "Fail" based on the following rules:

-- Score >= 90: "Excellent"

-- Score >= 80: "Good"

-- Score >= 70: "Average"

-- Score < 70: "Fail"

-- You can use the CASE statement like this:

SELECT Name, Score,
    CASE
        WHEN Score >= 90 THEN 'Excellent'
        WHEN Score >= 80 THEN 'Good'
        WHEN Score >= 70 THEN 'Average'
        ELSE 'Fail'
    END AS Grade
FROM 
    Students;



-- Result:

-- Name	        Score	        Grade
-- John	        85	            Good
-- Alice	    92	            Excellent
-- Bob	        78	            Average
-- Emma	        65	            Fail




-- Explanation:

-- For Alice, the first condition (Score >= 90) is true, so it returns "Excellent".

-- For John, the second condition (Score >= 80) is true, so it returns "Good".

-- For Bob, the third condition (Score >= 70) is true, so it returns "Average".

-- For Emma, none of the conditions are true, so it returns the ELSE value, which is "Fail".