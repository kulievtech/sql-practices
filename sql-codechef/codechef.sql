-- 1. Write a query to output all the columns from the Products table.

SELECT * 
FROM products;


-- 2. Write a query to find all product_name and category that have a price greater than 100.00 from the Products table.

SELECT product_name, category
FROM products
WHERE price > 100;


-- 3. Write a query to calculate the average salary across all companies combined. Rename the column as avg_salary.


SELECT AVG(salary) as avg_salary
FROM works;


-- 4. Write a query to retrieve the department_name and location of people who live in location that starts with 'S'.


SELECT department_name, location
FROM departments
WHERE location LIKE "S%";


-- 5. Write a query to select all the distinct companies (company_name) in the Works table.


SELECT DISTINCT company_name
FROM works;


-- 6. Write a query to find the total count of books whose genre is Fiction.
-- Note: Output column name should be fiction_count.


SELECT COUNT(*)  AS fiction_count
FROM books
WHERE genre = "Fiction";


-- 7. Write a query to select only the movie names where the ratings are greater than 7 but less than 9.


SELECT movie_name
FROM cinema
WHERE rating > 7 and rating < 9;


-- 8. Write a query to retrieve book_id, title, author and published_year of the books which have NULL rating for their books.

SELECT book_id, title, author, published_year 
FROM library
WHERE rating IS NULL;


-- 9. Create a query to retrieve the employee_name, company, and salary for employees in the full-time category, ordered by salary in descending order


SELECT employee_name, company, salary
FROM employees
WHERE category = "Full-Time"
ORDER BY salary DESC;



-- 10. Write a query to group the employees by their department and display the total number of employees (as total_employees) in each department.


SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;


-- 11. Write a query to retrieve the author_id, author_name, and publication_name for authors whose articles got zero views. The result should be sorted by author_id in ascending order.


SELECT author_id, author_name, publication_name
FROM views
WHERE view_count = 0
ORDER BY author_id;


-- 12. Write a query to find the names of the top 3 distinct players by highest score who have won matches, including their scores.

SELECT DISTINCT player_name, score
FROM players p 
JOIN matches m 
ON p.player_name = m.winner
ORDER BY score DESC 
LIMIT 3;


-- 13. Write a query to retrieve the details of the last five matches played, including the match ID, the names of the players who participated, the name of the winning player, match date, and the final score of the winner.


SELECT m.match_id, m.player_1, m.player_2, m.winner, m.match_date, p.score
FROM matches m 
JOIN players p 
ON m.winner = p.player_name
ORDER BY m.match_date desc
LIMIT 5;