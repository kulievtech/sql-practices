

-- 1: Find the domestic and international sales for each movie


SELECT title, domestic_sales, international_sales 
FROM movies m
JOIN boxoffice b
ON m.id = b.movie_id;


-- 2: Show the sales numbers for each movie that did better internationally rather than domestically


SELECT title, domestic_sales, international_sales 
FROM movies m
JOIN boxoffice b
ON m.id = b.movie_id
WHERE international_sales > domestic_sales;



-- 3: List all the movies by their ratings in descending order 


SELECT title
FROM movies m
JOIN boxoffice b
ON m.id = b.movie_id
ORDER BY b.rating DESC;