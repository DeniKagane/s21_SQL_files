SELECT pizza_name, price, pizzeria.name AS pizzeria_name, visit_date
FROM person
JOIN person_visits ON person.id = person_visits.person_id
JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
JOIN menu ON pizzeria.id = menu.pizzeria_id
WHERE person.name = 'Kate' AND price BETWEEN 800 AND 1000
ORDER BY 1, 2, 3;