

--                                      world
-- name	            continent	    area	        population	        gdp
-- Afghanistan	        Asia	        652230	        25500100	        20343000000
-- Albania	            Europe	        28748	        2831741	            12960000000
-- Algeria	            Africa	        2381741	        37100000	        188681000000
-- Andorra	            Europe	        468	            78115	            3712000000
-- Angola	            Africa	        1246700	        20609294	        100990000000

-- In this tutorial we will use the SELECT command on the table world:


-- 1: Introduction


-- Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries.

SELECT name, continent, population 
FROM world;


-- 2: Large Countries


-- How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.

SELECT name
FROM world
WHERE population >= 200000000;


-- 3: Per capita GDP


-- Give the name and the per capita GDP for those countries with a population of at least 200 (200000000) million.
-- HELP: How to calculate per capita GDP
-- per capita GDP is the GDP divided by the population GDP/population

SELECT name, gdp/population
FROM world
where population >= 200000000;


-- 4: South America In millions


-- Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.

SELECT name, population / 1000000
FROM world
WHERE continent = "South America";


-- 5: France, Germany, Italy


-- Show the name and population for France, Germany, Italy

SELECT name, population
FROM world
WHERE name IN ("France", "Germany", "Italy");


-- 6: United


-- Show the countries which have a name that includes the word 'United'



-- The % wildcard in the LIKE clause does not require "United" to be strictly in the middle of the string. Here's how it works:

-- %United% means:

-- Any sequence of characters (including none) can appear before "United".

-- Any sequence of characters (including none) can appear after "United".

-- So, "United" can appear anywhere in the string: at the beginning, in the middle, or at the end. The % wildcard is flexible and matches any number of characters (including zero characters).


SELECT name
FROM world
WHERE name LIKE "%United%";


-- 7: Two ways to be big


-- Two ways to be big: A country is big if it has an area of more than 3 (3000000) million sq km or it has a population of more than 250 (250000000) million.
-- Show the countries that are big by area or big by population. Show name, population and area.

SELECT name, population, area
FROM world
WHERE area > 3000000 or population > 250000000;


-- 8: One or the other (but not both)


-- Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
    -- Australia has a big area but a small population, it should be included.
    -- Indonesia has a big population but a small area, it should be included.
    -- China has a big population and big area, it should be excluded.
    -- United Kingdom has a small population and a small area, it should be excluded.

SELECT name, population, area
FROM world
WHERE area > 3000000 xor population > 250000000;


-- 9: Rounding


-- Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

-- For Americas show population in millions and GDP in billions both to 2 decimal places.

-- Millions and billions:
-- Divide by 1000000 (6 zeros) for millions. Divide by 1000000000 (9 zeros) for billions.

-- Missing decimals:
-- For some version of SQL the division of an integer by an integer will be an integer. One way to prevent this is to divide by a floating point number such as 1000000.0.


SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = "South America";


-- 10: Trillion dollar economies
-- Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.


SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000;


-- 11: Name and capital have the same length


-- Greece has capital Athens.
-- Each of the strings 'Greece', and 'Athens' has 6 characters.
-- Show the name and capital where the name and the capital have the same number of characters.
-- You can use the LENGTH function to find the number of characters in a string
-- For Microsoft SQL Server the function LENGTH is LEN

SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);



-- 12: Matching name and capital


-- The capital of Sweden is Stockholm. Both words start with the letter 'S'.
-- Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
-- You can use the function LEFT to isolate the first character.
-- You can use <> as the NOT EQUALS operator.


SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) and name <> capital;



-- 13: All the vowels


-- Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.

-- Find the country that has all the vowels and no spaces in its name.
    -- You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
    -- The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'


SELECT name
FROM world
WHERE name NOT LIKE "% %" and name LIKE "%a%" and name LIKE "%e%" and name LIKE "%i%" and name LIKE "%o%" and name LIKE "%u%";