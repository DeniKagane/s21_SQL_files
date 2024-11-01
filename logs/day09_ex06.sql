CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(pperson VARCHAR DEFAULT 'Dmitriy',
pprice numeric DEFAULT 500, pdate date DEFAULT '2022-01-08')
RETURNS TABLE(name varchar) AS 
$$
BEGIN
  RETURN QUERY
  SELECT DISTINCT pizzeria.name
  FROM pizzeria
  JOIN menu ON menu.pizzeria_id = pizzeria.id
  JOIN person_visits ON person_visits.pizzeria_id = pizzeria.id
  JOIN person ON person_visits.person_id = person.id
  WHERE menu.price < pprice AND person.name = pperson AND person_visits.visit_date = pdate;
END;
$$
LANGUAGE plpgsql;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
