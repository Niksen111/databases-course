-- 1.
INSERT INTO person VALUES ((SELECT max(person_id) FROM person) + 1, 'Ksenchik', 'Nikita', '+78005553535', 'Botanicheskaia 70');

-- 2.
UPDATE order1 SET comments = '(s)' || order1.comments
    WHERE employee_id IN (SELECT employee.employee_id FROM employee WHERE spec = 'student');

SELECT order_id, employee_id, comments FROM order1;

-- 3.
CREATE TABLE Document(
    Document_ID         INTEGER      NOT NULL,
    Name	            VARCHAR(20)  NOT NULL,
    Number	            VARCHAR(20)      NOT NULL,
    Person_ID            INTEGER      NOT NULL,
    CONSTRAINT Document_PK PRIMARY KEY (Document_ID)
)
;

ALTER TABLE Document ADD CONSTRAINT FK_Document_Person
    FOREIGN KEY (Person_ID)
        REFERENCES Person(Person_ID)
    ON DELETE CASCADE
;

INSERT INTO Document VALUES (1, 'Passport', '9999666666', 11);
INSERT INTO Document VALUES (2, 'INN', '123456123456', 11);
INSERT INTO Document VALUES (3, 'Passport', '0123456789', 4);
INSERT INTO Document VALUES (4, 'Passport', '5432112345', 5);
INSERT INTO Document VALUES (5, 'Passport', '9876543210', 6);

SELECT * FROM Document;

DELETE FROM person WHERE person_id = 11;