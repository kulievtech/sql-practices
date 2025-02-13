

-- 1: Find the number of movies each director has directed 


SELECT director, COUNT(*) 
FROM movies
GROUP BY director;


-- 2: Find the total domestic and international sales that can be attributed to each director


SELECT m.director, 
SUM(domestic_sales + international_sales) as cumulative_sales_from_all_movies
FROM movies m
JOIN boxoffice b
ON m.id = b.movie_id
GROUP BY m.director;