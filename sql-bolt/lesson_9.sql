

-- 1: List all movies and their combined sales in millions of dollars


SELECT title, (b.domestic_sales + b.international_sales) / 1000000 as TotalSales
FROM movies m
JOIN boxoffice b
ON m.id = b.movie_id;



-- 2: List all movies and their ratings in percent

SELECT title, b.rating * 10 as rating_percent
FROM movies m
JOIN boxoffice b
ON m.id = b.movie_id;



-- 3: List all movies that were released on even number years


SELECT title, year
FROM movies
WHERE year % 2 = 0;