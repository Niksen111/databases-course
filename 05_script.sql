-- 1.
SELECT mark FROM order1 o WHERE o.is_done = 1 AND o.employee_id IN
    (SELECT employee_id FROM employee WHERE spec = 'student');

-- 2.
SELECT last_name FROM person p JOIN employee e on p.person_id = e.person_id
    WHERE employee_id NOT IN (SELECT employee_id FROM order1 GROUP BY employee_id);

-- 3.
SELECT s.name, o.time_order, p.last_name, p2.nick, o_p.last_name FROM order1 o
    JOIN service s on o.service_id = s.service_id
    JOIN employee e on o.employee_id = e.employee_id
    JOIN person p on p.person_id = e.person_id
    JOIN pet p2 on o.pet_id = p2.pet_id
    JOIN owner o2 on o.owner_id = o2.owner_id
    JOIN person o_p on o_p.person_id = o2.person_id;

-- 4.
SELECT comments FROM order1 WHERE comments IS NOT null AND comments != ''
UNION
SELECT description FROM owner WHERE description IS NOT null AND description != ''
UNION
SELECT description FROM pet WHERE description IS NOT null AND description != ''
ORDER BY comments;

-- 5.
SELECT first_name, last_name FROM employee e JOIN person p on p.person_id = e.person_id
    WHERE EXISTS(SELECT * FROM order1 o WHERE mark = 5 AND e.employee_id = o.employee_id);