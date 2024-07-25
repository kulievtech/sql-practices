--Pattern Matching Strings
--This tutorial uses the LIKE operator to check names. We will be using the SELECT command on the table world:

-- 1: 

--You can use WHERE name LIKE 'B%' to find the countries that start with "B".
--The % is a wild-card it can match any characters
--Find the country that start with Y

SELECT name FROM world
  WHERE name LIKE 'Y%'