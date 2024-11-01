WITH t1 AS (SELECT pizzeria.id, pizzeria.name AS pizzeria_name_1, pizza_name, price
FROM pizzeria
JOIN menu ON menu.pizzeria_id = pizzeria.id),

t2 AS (SELECT pizzeria.id, pizzeria.name AS pizzeria_name_2, pizza_name, price
FROM pizzeria
JOIN menu ON menu.pizzeria_id = pizzeria.id)

SELECT t1.pizza_name, pizzeria_name_1, pizzeria_name_2, t1.price
FROM t1
JOIN t2 ON t1.pizza_name = t2.pizza_name AND t1.price = t2.price
WHERE t1.id > t2.id
ORDER BY pizza_name;	