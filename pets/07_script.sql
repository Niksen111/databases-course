-- 1.
CREATE VIEW dog(nick, breed, age, last_name, first_name) AS
    SELECT nick, breed, age, last_name, first_name FROM pet
        JOIN owner o on o.owner_id = pet.owner_id
        JOIN person p on p.person_id = o.person_id;
SELECT nick, last_name FROM dog WHERE breed = 'poodle';

-- 2.
CREATE VIEW employee_rating(last_name, first_name, count, avg_mark) AS
    SELECT last_name, first_name, count(*), avg(mark) FROM employee
        JOIN person p on p.person_id = employee.person_id
        JOIN order1 o on employee.employee_id = o.employee_id
            WHERE is_done = 1
            GROUP BY p.person_id
        ORDER BY avg(mark) DESC;

SELECT * FROM employee_rating;

-- 3.
CREATE VIEW customers(last_name, first_name, phone, address) AS
    SELECT last_name, first_name, phone, address FROM owner
        JOIN person p on p.person_id = owner.person_id;

CREATE OR REPLACE FUNCTION get_homeless () RETURNS INTEGER
LANGUAGE SQL AS $$
    SELECT count(*) FROM person
    WHERE address = '';
    ;
$$;

SELECT * FROM customers;
SELECT get_homeless();