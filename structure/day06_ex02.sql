SELECT person.name, pizza_name, price, ROUND(price / 100 * (100 - discount)) AS discount_price,
pizzeria.name AS pizzeria_name
FROM person
JOIN person_order ON person.id = person_order.person_id
JOIN menu ON menu.id = person_order.menu_id
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
JOIN person_discounts ON person_discounts.person_id = person.id 
AND person_discounts.pizzeria_id = pizzeria.id
ORDER BY 1,2;
