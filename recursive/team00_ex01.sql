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
WHERE lvl = 4 AND point2 = 'a'
ORDER BY 1, 2;