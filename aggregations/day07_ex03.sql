WITH t1 AS (SELECT pizzeria.name, COUNT(pizzeria.name) AS total_count1
FROM pizzeria
JOIN menu ON menu.pizzeria_id = pizzeria.id
JOIN person_order ON person_order.menu_id = menu.id
GROUP BY pizzeria.name), 

t2 AS 
(SELECT pizzeria.name, COUNT(pizzeria.name) AS total_count2
FROM pizzeria
JOIN person_visits ON person_visits.pizzeria_id = pizzeria.id
GROUP BY pizzeria.name)

SELECT t1.name, total_count1 + total_count2 AS total_count
FROM t1 LEFT JOIN t2 ON t1.name = t2.name
ORDER BY total_count DESC, name;

