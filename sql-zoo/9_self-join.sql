-- Edinburgh Buses

-- stops(id, name)
-- route(num, company, pos, stop)



--              stops
--    id
--    name





--                  route
--      num
--      company
--      pos
--      stop






-- Edinburgh Buses
-- This database consists of two tables: stops and routes

-- stops
-- This is a list of areas served by buses. The detail does not really include each actual bus stop - just areas within Edinburgh and whole towns near Edinburgh.


-- Field	    Type	        Notes
-- id	        INTEGER	        Arbitrary value
-- name	        CHAR(30)	    The name of an area served by at least one bus





-- route
-- A route is the path through town taken by a bus.

-- Field	    Type	    Notes
-- num	        CHAR(5)	    The number of the bus - as it appears on the front of the vehicle. Oddly these numbers often include letters
-- company	    CHAR(3)	    Several bus companies operate in Edinburgh. The main one is Lothian Region Transport - LRT
-- pos	        INTEGER	    This indicates the order of the stop within the route. Some routes may revisit a stop. Most buses go in both directions.
-- stop	        INTEGER	    This references the stops table




-- 1:


-- How many stops are in the database.


SELECT COUNT(*)
FROM stops;





-- 2:



-- Find the id value for the stop 'Craiglockhart'


SELECT id
FROM stops
WHERE name = "Craiglockhart";




-- 3:



-- Give the id and the name for the stops on the '4' 'LRT' service.


SELECT id, name
FROM stops s
JOIN route r
ON s.id = r.stop
WHERE r.company = "LRT" and r.num = "4";





-- 4: Routes and stops


--  The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.

-- SELECT company, num, COUNT(*)
-- FROM route 
-- WHERE stop=149 OR stop=53
-- GROUP BY company, num;



SELECT company, num, COUNT(*)
FROM route 
WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) > 1;




-- 5: 



-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.



-- SELECT a.company, a.num, a.stop, b.stop
-- FROM route a JOIN route b 
-- ON (a.company=b.company AND a.num=b.num)
-- WHERE a.stop=53
