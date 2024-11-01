WITH men_visits AS (
SELECT pizzeria.name AS pizzeria_name
FROM person
JOIN person_order ON person_order.person_id = person.id
JOIN menu ON menu.id = person_order.menu_id
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
WHERE gender = 'male'
),

women_visits AS (
SELECT pizzeria.name AS pizzeria_name
FROM person
JOIN person_order ON person_order.person_id = person.id
JOIN menu ON menu.id = person_order.menu_id
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
WHERE gender = 'female'
),

man_no_woman AS (
SELECT * FROM men_visits EXCEPT SELECT * FROM women_visits
),

woman_no_man AS (
SELECT * FROM women_visits EXCEPT SELECT * FROM men_visits
)

SELECT * FROM man_no_woman UNION SELECT * FROM woman_no_man
ORDER BY pizzeria_name;
