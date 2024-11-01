WITH visits AS (SELECT pizzeria.name AS pizzeria_name
FROM person
JOIN person_visits ON person.id = person_visits.person_id
JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
WHERE person.name = 'Andrey'),

orders AS (SELECT pizzeria.name AS pizzeria_name
FROM person
JOIN person_order ON person_order.person_id = person.id
JOIN menu ON menu.id = person_order.menu_id
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
WHERE person.name = 'Andrey')

SELECT * FROM visits EXCEPT SELECT * FROM orders
ORDER BY 1;
