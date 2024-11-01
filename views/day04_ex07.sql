INSERT INTO person_visits(id, person_id, pizzeria_id, visit_date)
VALUES((SELECT MAX(id) + 1 FROM person_visits),
(SELECT id FROM person WHERE name = 'Dmitriy'),
(SELECT pizzeria.id FROM pizzeria JOIN menu ON menu.pizzeria_id = pizzeria.id 
WHERE price < 800 AND pizzeria.name NOT IN (SELECT pizzeria_name FROM mv_dmitriy_visits_and_eats)
ORDER BY 1 limit 1), '2022-01-08');

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;

