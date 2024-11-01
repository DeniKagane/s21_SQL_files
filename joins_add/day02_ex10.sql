WITH t1 AS (SELECT id, name AS person_name1, address AS common_address
FROM person),

t2 AS (SELECT id, name AS person_name2, address AS common_address
FROM person)

SELECT person_name1, person_name2, t1.common_address
FROM t1 JOIN t2 ON t1.common_address = t2.common_address
WHERE t1.id > t2.id
ORDER BY 1, 2, 3;