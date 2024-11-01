SELECT address, pizzeria.name, COUNT(pizzeria.name)
FROM person
JOIN person_order ON person_order.person_id = person.id
JOIN menu ON menu.id = person_order.menu_id
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
GROUP BY address, pizzeria.name
ORDER BY 1, 2;