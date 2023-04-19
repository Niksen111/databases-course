-- 01.
SELECT pet.nick as Name, pt.name as Type FROM pet
    JOIN pet_type pt on pet.pet_type_id = pt.pet_type_id AND pet.nick = 'Partizan';

-- 02.
SELECT nick, breed, age FROM pet, pet_type
    WHERE pet.pet_type_id = pet_type.pet_type_id AND pet_type.name = 'DOG';

-- 03.
SELECT AVG(age) FROM pet JOIN pet_type ON pet.pet_type_id = pet_type.pet_type_id
    WHERE name = 'CAT';

-- 04.
SELECT time_order, last_name FROM order1 as o, employee as e, person as p
    WHERE o.employee_id = e.employee_id AND e.person_id = p.person_id AND is_done = 0;

-- 05.
SELECT first_name, last_name, phone FROM person as p
    JOIN owner o on p.person_id = o.person_id
    JOIN pet p2 on o.owner_id = p2.owner_id
    JOIN pet_type pt on p2.pet_type_id = pt.pet_type_id
    WHERE pt.name = 'DOG';

-- 06.
SELECT pt.name as Type, p.nick as Name FROM pet_type pt LEFT JOIN pet p on pt.pet_type_id = p.pet_type_id
    ORDER BY Type;

-- 07.
SELECT p.nick as  Nick, pt.name as Type, p.breed as Breed, vt.name as Vaccination_Type, p2.last_name as Surname, p2.first_name as Name, p2.phone as Phone FROM vaccination v
    JOIN vaccination_type vt on v.vaccination_type_id = vt.vaccination_type_id
    JOIN pet p on v.pet_id = p.pet_id
    JOIN pet_type pt on p.pet_type_id = pt.pet_type_id
    JOIN owner o on p.owner_id = o.owner_id
    JOIN person p2 on o.person_id = p2.person_id
    ORDER BY Surname, Name;