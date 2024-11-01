CREATE TABLE IF NOT EXISTS person_discounts(
id BIGINT PRIMARY KEY NOT NULL,
person_id BIGINT ,
pizzeria_id BIGINT,
discount NUMERIC,
CONSTRAINT fk_person_discounts_person_id FOREIGN KEY (person_id) REFERENCES person(id),
CONSTRAINT fk_pizzeria_discounts_pizzeria_id FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id)
);