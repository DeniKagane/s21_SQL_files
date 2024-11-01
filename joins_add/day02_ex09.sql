WITH t1 AS (SELECT person.name AS name, person_id
FROM person
JOIN person_order ON person.id = person_order.person_id
JOIN menu ON menu.id = person_order.menu_id
WHERE person.gender = 'female'
AND menu.pizza_name = 'pepperoni pizza'

INTERSECT 

SELECT person.name AS name, person_id
FROM person
JOIN person_order ON person.id = person_order.person_id
JOIN menu ON menu.id = person_order.menu_id
WHERE person.gender = 'female'
AND menu.pizza_name = 'cheese pizza')

SELECT name FROM t1
ORDER BY name;