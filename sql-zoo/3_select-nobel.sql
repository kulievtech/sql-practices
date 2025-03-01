-- This tutorial is concerned with a table of Nobel prize winners:

-- nobel(yr, subject, winner)
-- Using the SELECT statement.


--                              nobel
--                  yr	    subject	    winner
--                  1960	Chemistry	Willard F. Libby
--                  1960	Literature	Saint-John Perse
--                  1960	Medicine	Sir Frank Macfarlane Burnet
--                  1960	Medicine	Peter Madawar


-- 1: Winners from 1950


-- Change the query shown so that it displays Nobel prizes for 1950.
-- SELECT yr, subject, winner
-- FROM nobel
-- WHERE yr = 1960


SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;


-- 2: 1962 Literature


-- Show who won the 1962 prize for literature.

SELECT winner
FROM nobel
WHERE subject = "literature" and yr = 1962;



-- 3: Albert Einstein


-- Show the year and subject that won 'Albert Einstein' his prize.

SELECT yr, subject
FROM nobel
WHERE winner = "Albert Einstein";



-- 4: Recent Peace Prizes


-- Give the name of the 'peace' winners since the year 2000, including 2000.

SELECT winner
FROM nobel
WHERE subject = "peace" and yr >= 2000;



-- 5: Literature in the 1980's


-- Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.


SELECT yr, subject, winner
FROM nobel
WHERE subject = "literature" and yr between 1980 and 1989;



-- 6: Only Presidents


-- Show all details of the presidential winners:
    -- Theodore Roosevelt
    -- Thomas Woodrow Wilson
    -- Jimmy Carter
    -- Barack Obama


SELECT *
FROM nobel
WHERE winner IN ("Theodore Roosevelt", "Thomas Woodrow Wilson", "Jimmy Carter", "Barack Obama");



-- 7: John


-- Show the winners with first name John


SELECT winner
FROM nobel
WHERE winner LIKE "John%";



-- 8: Chemistry and Physics from different years


-- Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.

SELECT yr, subject, winner
FROM nobel
WHERE (subject = "physics" and yr = 1980) or subject = "chemistry" and yr = 1984;



-- 9: Exclude Chemists and Medics


-- Show the year, subject, and name of winners for 1980 excluding chemistry and medicine


SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980 and subject NOT IN ("chemistry", "medicine");



-- 10: Early Medicine, Late Literature


-- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)



SELECT yr, subject, winner
FROM nobel
WHERE (subject = "medicine" and yr < 1910) or (subject = "literature" and yr >= 2004);




-- HARDER QUESTIONS: 


-- 11: Umlaut


-- Find all details of the prize won by PETER GRÜNBERG

-- Non-ASCII characters
-- The u in his name has an umlaut. You may find this link useful

SELECT *
FROM nobel
WHERE winner = "PETER GRÜNBERG";



-- 12: Apostrophe


-- Find all details of the prize won by EUGENE O'NEILL


-- Escaping single quotes
-- You can't put a single quote in a quote string directly. You can use two single quotes within a quoted string.


SELECT *
FROM nobel
WHERE winner = "EUGENE O'NEILL";



-- 13: Knights of the realm


-- Knights in order
-- List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.


SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE "Sir %"
ORDER BY yr DESC, winner;



-- 14: Chemistry and Physics last


-- The expression subject IN ('chemistry','physics') can be used as a value - it will be 0 or 1.
-- Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.


SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('chemistry','physics'), subject, winner
