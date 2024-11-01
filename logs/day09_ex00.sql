CREATE TABLE IF NOT EXISTS person_audit (
created timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
type_event char(1) NOT NULL DEFAULT 'I',
CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'D', 'U')),
row_id bigint NOT NULL,
name varchar,
age integer,
gender varchar,
address varchar
);

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
  RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'INSERT') AND (NEW.id IS NOT NULL) THEN 
      INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
        VALUES (NOW(), 'I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_insert_audit AFTER INSERT ON person FOR EACH ROW EXECUTE PROCEDURE fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');