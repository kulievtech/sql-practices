-- https://en.wikibooks.org/wiki/File:Computer-store-db.png





-- 1. Select the names of all the products in the store.

SELECT name
FROM products;


-- 2. Select the names and the prices of all the products in the store.

SELECT name, price
FROM products;


-- 3. Select the name of the products with a price less than or equal to $200.

SELECT name
FROM products
WHERE price <= 200;


-- 4. Select all the products with a price between $60 and $120.

SELECT *
FROM products
WHERE price between 60 and 120;


-- OR

SELECT *
FROM products
WHERE price >= 60 and price <= 120;



-- 5. Select the name and price in cents (i.e., the price must be multiplied by 100).

SELECT name, price * 100 AS price_cents
FROM products;


-- 6. Compute the average price of all the products.

SELECT AVG(price)
FROM products;


-- 7. Compute the average price of all products with manufacturer code equal to 2.

SELECT AVG(price)
FROM products
WHERE manufacturer = 2;


-- 8. Compute the number of products with a price larger than or equal to $180.

SELECT COUNT(*)
FROM products
WHERE price >= 180;


-- 9. Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).

SELECT name, price
FROM products
WHERE price >= 180
ORDER BY price DESC, name;


-- 10. Select all the data from the products, including all the data for each product's manufacturer.

SELECT * 
FROM products p
LEFT JOIN manufacturers m
ON p.manufacturer = m.code;


-- 11. Select the product name, price, and manufacturer name of all the products.

SELECT p.name, p.price, m.name
FROM products p
JOIN manufacturers m 
ON p.manufacturer = m.code;


-- 12. Select the average price of each manufacturer's products, showing only the manufacturer's code.

SELECT AVG(price), manufacturer
FROM products
GROUP BY manufacturer;


-- 13. Select the average price of each manufacturer's products, showing the manufacturer's name.

SELECT AVG(p.price), m.name
FROM products p 
JOIN manufacturers m 
ON p.manufacturer = m.code
GROUP BY m.name;



-- 14. Select the names of manufacturer whose products have an average price larger than or equal to $150.

SELECT AVG(p.price), m.name
FROM products p 
JOIN manufacturers m 
ON p.manufacturer = m.code
GROUP BY m.name
HAVING AVG(p.price) >= 150;



-- 15. Select the name and price of the cheapest product.

SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 1;


-- OR


SELECT name, price
FROM products
WHERE price = (SELECT MIN(price) FROM products);


-- 16. Select the name of each manufacturer along with the name and price of its most expensive product.


SELECT m.name, p.name, p.price
FROM products p 
JOIN manufacturers m 
ON p.manufacturer = m.code
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.manufacturer = p.manufacturer
);



-- 17. Select the name of each manufacturer which have an average price above $145 and contain at least 2 different products.


SELECT m.name, AVG(p.price) AS avg_price, COUNT(DISTINCT p.code) AS product_count
FROM products p 
JOIN manufacturers m
ON p.manufacturer = m.code
GROUP BY m.name
HAVING AVG(p.price) > 145 AND COUNT(DISTINCT p.code) >= 2;


-- 18. Add a new product: Loudspeakers, $70, manufacturer 2.

INSERT INTO products (Code, Name, Price, Manufacture)
VALUES (11, "Loudspeakers", 70, 2);


-- 19. Update the name of product 8 to "Laser Printer".

UPDATE products
SET name = "Laser Printer"
WHERE code = 8;


-- 20. Apply a 10% discount to all products.

UPDATE products
SET price = price - (price * 0.10);


-- 21. Apply a 10% discount to all products with a price larger than or equal to $120.

UPDATE products
SET price = price - (price * 0.10)
WHERE price >= 120;