WITH men_visits AS (
SELECT pizzeria.name AS pizzeria_name
FROM person
JOIN person_visits ON person_visits.person_id = person.id
JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
WHERE gender = 'male'
),

woman_visits AS (
SELECT pizzeria.name AS pizzeria_name
FROM person
JOIN person_visits ON person_visits.person_id = person.id
JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
WHERE gender = 'female'
),

man_no_woman AS (
SELECT * FROM men_visits EXCEPT ALL SELECT * FROM woman_visits
),

woman_no_man AS (
SELECT * FROM woman_visits EXCEPT ALL SELECT * FROM men_visits
)

SELECT * FROM woman_no_man UNION ALL SELECT * FROM man_no_woman
ORDER BY pizzeria_name;