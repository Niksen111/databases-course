CREATE PROCEDURE AddNewCardOwner(name1 VARCHAR(30), name2 VARCHAR(30), city INTEGER)
LANGUAGE sql
BEGIN ATOMIC
    WITH default_discount as (
        SELECT 0.1 AS val
    )
    INSERT INTO card_owner(card_owner_id, first_name, last_name, discount, city_id)
        VALUES ((SELECT MAX(card_owner_id) FROM card_owner) + 1, name1, name2, default_discount, city);
END;

CREATE PROCEDURE GetProductListing(id_product INTEGER, date1 TIMESTAMP, date2 TIMESTAMP)
LANGUAGE plpgsql
BEGIN ATOMIC
    SELECT amount, date, co.card_owner_id, s.store_id as date FROM product p
        JOIN purchase_product pp on p.product_id = pp.product_id
        JOIN purchase p2 on p2.purchase_id = pp.purchase_id
        JOIN card_owner co on p2.card_owner_id = co.card_owner_id
        JOIN store s on p2.store_id = s.store_id
            WHERE p.product_id = id_product AND p2.date BETWEEN date1 AND date2
            ORDER BY p2.date;
END;

CREATE FUNCTION GetAmountSpent(id_customer INTEGER, date1 TIMESTAMP, date2 TIMESTAMP)
LANGUAGE plpgsql
BEGIN ATOMIC
    SELECT SUM(cost * pp.amount) FROM card_owner
        JOIN purchase p on card_owner.card_owner_id = p.card_owner_id
        JOIN purchase_product pp on p.purchase_id = pp.purchase_id
        JOIN product p2 on p2.product_id = pp.product_id
        WHERE card_owner.card_owner_id = id_customer AND p.date BETWEEN  date1 AND date2;
END;

CREATE VIEW product_info AS
    SELECT product.name as name, cost, category, mu.name as measurement_unit FROM product
        JOIN product_type pt on pt.product_type_id = product.product_type_id
        JOIN measurement_unit mu on mu.measurement_unit_id = product.measurement_unit_id;

CREATE VIEW card_owners_purchases AS
    SELECT * FROM card_owner
        JOIN purchase p on card_owner.card_owner_id = p.card_owner_id
        JOIN purchase_product pp on p.purchase_id = pp.purchase_id
        JOIN product p2 on pp.product_id = p2.product_id
        JOIN store s on p.store_id = s.store_id;

CREATE VIEW card_owners_stores AS
    SELECT first_name, last_name, discount, s.name as store, address, c.name as city FROM card_owner
        JOIN store s on card_owner.city_id = s.city_id
        JOIN city c on card_owner.city_id = c.city_id;

CREATE INDEX idx_purchases ON purchase(card_owner_id, date, store_id);
CREATE INDEX idx_purchase_product ON purchase_product(product_id, amount, purchase_id);

/*
CREATE TRIGGER tr_kek ON FOR UPDATE
    AS
    BEGIN
    END
; /*

/*
DROP TRIGGER tr_kek;
*/