SELECT pizza_name, pizzeria.name AS pizzeria_name
FROM person_order
INNER JOIN (SELECT id FROM person WHERE name IN ('Denis', 'Anna')) AS p
ON p.id = person_order.person_id
INNER JOIN menu ON person_order.menu_id = menu.id
INNER JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
ORDER BY 1, 2;