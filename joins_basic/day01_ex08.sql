SELECT order_date,
FORMAT('%s (age:%s)', name, age) AS person_information
FROM person
NATURAL JOIN (SELECT person_id AS id, order_date FROM person_order)
ORDER BY order_date, person_information;