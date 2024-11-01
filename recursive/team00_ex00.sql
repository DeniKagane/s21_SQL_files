CREATE TABLE nodes (
point1 VARCHAR NOT NULL, 
point2 VARCHAR NOT NULL, 
cost INT
);

INSERT INTO nodes(point1, point2, cost)
VALUES ('a', 'b', 10), 
('a', 'c', 15),
('a', 'd', 20),
('b', 'a', 10),
('b', 'd', 25),
('b', 'c', 35),
('c', 'b', 35),
('c', 'd', 30),
('c', 'a', 15),
('d', 'a', 20),
('d', 'b', 25),
('d', 'c', 30);

WITH RECURSIVE t1 AS (
SELECT ARRAY[point1] as tour, point1, point2, cost AS total_cost, 1 AS lvl
FROM nodes
WHERE point1 = 'a'
UNION
SELECT (t1.tour  || t2.point1), t2.point1, t2.point2, t1.total_cost + t2.cost as total_cost, t1.lvl + 1 as lvl
FROM t1
JOIN nodes t2 on t1.point2 = t2.point1
WHERE lvl < 4 AND t2.point1 <> 'a' AND t1.point1 <> t2.point2)

SELECT total_cost, (tour || point2) AS tour FROM t1 
WHERE lvl = 4 AND point2 = 'a' AND total_cost IN (SELECT total_cost FROM t1 WHERE lvl = 4 AND point2 = 'a' ORDER BY total_cost LIMIT 1)
ORDER BY 1, 2;