CREATE VIEW v_price_with_discount AS

SELECT person.name, pizza_name, price, CAST (0.9 * price AS int) AS discount_price
FROM person
JOIN person_order ON person_order.person_id = person.id
JOIN menu ON person_order.menu_id = menu.id
ORDER BY 1,2;