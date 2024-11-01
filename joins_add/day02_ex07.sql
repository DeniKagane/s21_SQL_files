WITH p AS (
SELECT id 
FROM person
WHERE name = 'Dmitriy'
),

pv AS (
SELECT person_id, pizzeria_id
FROM person_visits
WHERE visit_date = '2022-01-08'
),

m AS (
SELECT pizzeria_id
FROM menu
WHERE price < 800
)

SELECT pizzeria.name AS pizzeria_name
FROM p
INNER JOIN pv ON p.id = pv.person_id
INNER JOIN pizzeria ON pv.pizzeria_id = pizzeria.id
INNER JOIN m ON m.pizzeria_id = pizzeria.id