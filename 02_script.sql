-- 1.
SELECT * FROM pet WHERE nick = 'Partizan';

-- 2.
SELECT nick, breed, age FROM pet ORDER BY age;

-- 3.
SELECT nick, description FROM pet WHERE description IS NOT NULL AND description != '';

-- 4.
SELECT AVG(age) FROM pet WHERE breed = 'poodle';

-- 5.
SELECT count(*) FROM owner;

-- 6.
SELECT * FROM pet WHERE age BETWEEN 3 AND 7;

-- 7.
SELECT * FROM person WHERE phone LIKE '+7%';

-- 8.
SELECT * FROM pet WHERE breed IN ('poodle', 'unknown');