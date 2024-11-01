CREATE VIEW v_symmetric_union AS

WITH t1 AS (
SELECT person_id
FROM person_visits
WHERE visit_date = '2022-01-02'
),

t2 AS (
SELECT person_id
FROM person_visits
WHERE visit_date = '2022-01-06'
),

exc1 AS (SELECT * FROM t1 EXCEPT SELECT * FROM t2),

exc2 AS (SELECT * FROM t2 EXCEPT SELECT * FROM t1)

SELECT * FROM exc1
UNION
SELECT * FROM exc2
ORDER BY person_id;
