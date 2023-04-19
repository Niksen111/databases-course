-- 1.
SELECT age, count(*) FROM pet GROUP BY pet.age ORDER BY age;

-- 2.
SELECT age, pet_type.name as Type, count(*) FROM pet, pet_type
    WHERE pet_type.pet_type_id = pet.pet_type_id
    GROUP BY pet_type.name, age ORDER BY age;

-- 3.
SELECT name, avg(age) FROM pet, pet_type WHERE pet.pet_type_id = pet_type.pet_type_id
    GROUP BY name HAVING avg(age) < 6;

-- 4.
SELECT last_name, done_orders FROM employee e JOIN person p on p.person_id = e.person_id
    JOIN (SELECT employee_id, count(*) as done_orders FROM order1 o WHERE is_done = 1 GROUP BY o.employee_id) as cnt on cnt.employee_id = e.employee_id
    WHERE done_orders > 5;

-- 5.
SELECT p.last_name, p.first_name, count(*) as done_orders FROM order1 o JOIN employee e on o.employee_id = e.employee_id
    JOIN person p on p.person_id = e.person_id
    WHERE extract(YEAR FROM time_order) = 2020 AND extract(MONTH FROM time_order) = 9
    AND extract(DAY FROM time_order) = 10
    GROUP BY  p.last_name, p.first_name ORDER BY p.last_name;

-- 6.
SELECT last_name, first_name, person_id IN
    (SELECT person_id FROM employee e GROUP BY e.person_id) as is_employee
    FROM person WHERE position('VO' in address) > 0;