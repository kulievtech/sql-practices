-- 1: Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late, "Not Shipped" if shipped_date is null.

-- Order by employee last_name, then by first_name, and then descending by number of orders.


SELECT e.first_name, e.last_name, COUNT(o.order_id) AS num_orders,
CASE
	WHEN o.shipped_date <= o.required_date THEN "On Time"
    WHEN o.shipped_date > o.required_date THEN "Late"
    ELSE "Not shipped"
END AS shipped
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY e.first_name, e.last_name, shipped
ORDER BY last_name, first_name, num_orders DESC;



-- 2: Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places



SELECT YEAR(o.order_date) AS order_year, 
ROUND(SUM(od.discount * p.unit_price * quantity), 2) AS discount_amount
FROM orders o 
JOIN order_details od 
ON o.order_id = od.order_id
JOIN products p 
ON od.product_id = p.product_id
GROUP BY order_year
ORDER BY order_year DESC;
