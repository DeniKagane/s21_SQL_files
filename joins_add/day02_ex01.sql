SELECT gs::date AS missing_date
FROM generate_series('2022-01-01', '2022-01-10', interval  '1 day') AS gs
LEFT JOIN 
(SELECT visit_date FROM person_visits
WHERE person_visits.person_id = 1 OR person_visits.person_id = 2) AS pv
ON pv.visit_date = gs::date
WHERE pv.visit_date IS NULL
ORDER BY missing_date;