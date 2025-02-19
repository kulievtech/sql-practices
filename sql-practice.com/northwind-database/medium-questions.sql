-- 1: Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table


SELECT p.product_name, s.company_name, c.category_name
FROM categories c
JOIN products p
ON c.category_id = p.category_id
JOIN suppliers s
ON p.supplier_id = s.supplier_id;


-- 2: Show the category_name and the average product unit price for each category rounded to 2 decimal places.


SELECT category_name, ROUND(AVG(unit_price), 2)
FROM categories c
JOIN products p
ON c.category_id = p.category_id
GROUP BY category_name;


-- 3: Show the city, company_name, contact_name from the customers and suppliers table merged together.
-- Create a column which contains 'customers' or 'suppliers' depending on the table it came from.


SELECT city, company_name, contact_name, 'customers' AS relationship 
FROM customers
UNION
SELECT city, company_name, contact_name, 'suppliers' AS relationship 
FROM suppliers



-- 4: Show the total amount of orders for each year/month.


SELECT year(order_date), month(order_date), COUNT(order_date)
FROM orders
GROUP BY YEAR(order_date), month(order_date);