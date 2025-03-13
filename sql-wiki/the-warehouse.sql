-- https://en.wikibooks.org/wiki/File:Sql_warehouse.png


-- 1. Select all warehouses.


SELECT * 
FROM Warehouses;


-- 2. Select all boxes with a value larger than $150.

SELECT *
FROM Boxes
WHERE Value > 150;


-- 3. Select all distinct contents in all the boxes.

SELECT DISTINCT Contents
FROM Boxes;


-- 4. Select the average value of all the boxes.

SELECT AVG(Value)
FROM BOXES;


-- 5. Select the warehouse code and the average value of the boxes in each warehouse.


SELECT Warehouse, AVG(Value)
FROM Boxes
GROUP BY Warehouse;



-- 6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.

SELECT Warehouse, AVG(Value)
FROM Boxes
GROUP BY Warehouse
HAVING AVG(Value) > 150;


-- 7. Select the code of each box, along with the name of the city the box is located in.

SELECT b.code, w.location
FROM Boxes b
JOIN Warehouses w 
ON b.Warehouse = w.code;



-- 8. Select the warehouse codes, along with the number of boxes in each warehouse. Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).


SELECT Warehouse, COUNT(*)
FROM BOXES
GROUP BY Warehouse;



-- 9. Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).


SELECT b.Warehouse
FROM BOXES b
JOIN Warehouses w 
ON b.Warehouse = w.Code 
GROUP BY b.Warehouse, w.Capacity
HAVING COUNT(*) > w.Capacity;


-- In SQL, when you use aggregate functions like COUNT(*) in combination with the GROUP BY clause, you need to group by all non-aggregated columns that appear in the SELECT clause or the HAVING clause. This ensures that the query can correctly calculate the aggregate values for each group.



-- 10. Select the codes of all the boxes located in Chicago.

SELECT Code
FROM BOXES
WHERE Warehouse IN (
    SELECT Code
    FROM Warehouses
    WHERE Location = "Chicago"
);


-- OR


SELECT b.Code 
FROM BOXES b 
JOIN Warehouses w 
ON b.Warehouse = w.Code 
WHERE w.Location = "Chicago";


-- 11. Create a new warehouse in New York with a capacity for 3 boxes.

INSERT INTO Warehouses (Location, Capacity)
VALUES ("New York", 3)


-- 12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.

INSERT INTO Boxes (Code, Contents, Value, Warehouse)
VALUES ("H5RT", "Papers", 200, 2)


-- 13. Reduce the value of all boxes by 15%.

UPDATE Boxes
SET Value = Value - (Value * 0.15)


-- 14. Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.

UPDATE Boxes 
SET Value = Value - (Value * 0.20)
WHERE Value > (
    SELECT AVG(Value)
    FROM Boxes
);



-- 15. Remove all boxes with a value lower than $100.

DELETE FROM Boxes
WHERE Value < 100;


-- 16. Remove all boxes from saturated warehouses. (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity)

DELETE FROM Boxes
WHERE warehouse_id IN (
    SELECT w.warehouse_id
    FROM Warehouses w
    JOIN (
        SELECT warehouse_id, COUNT(box_id) AS box_count
        FROM Boxes
        GROUP BY warehouse_id
    ) b ON w.warehouse_id = b.warehouse_id
    WHERE b.box_count > w.capacity
);