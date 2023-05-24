---------------------------------------
-- Views creation.
---------------------------------------

CREATE OR REPLACE VIEW product_info AS
    SELECT product.name as name, cost, category, mu.name as measurement_unit FROM product
        JOIN product_type pt on pt.product_type_id = product.product_type_id
        JOIN measurement_unit mu on mu.measurement_unit_id = product.measurement_unit_id;

CREATE OR REPLACE VIEW card_owners_purchases AS
    SELECT card_owner.card_owner_id as card_owner_id, first_name, last_name, discount, date, pp.purchase_product_id as pp_id, p2.name as product, cost, amount FROM card_owner
        JOIN purchase p on card_owner.card_owner_id = p.card_owner_id
        JOIN purchase_product pp on p.purchase_id = pp.purchase_id
        JOIN product p2 on pp.product_id = p2.product_id;

CREATE OR REPLACE VIEW card_owners_stores AS
    SELECT first_name, last_name, discount, s.name as store, address, c.name as city FROM card_owner
        JOIN store s on card_owner.store_id = s.store_id
        JOIN city c on s.city_id = c.city_id;


---------------------------------------
-- Procedures/functions creation.
---------------------------------------

CREATE OR REPLACE PROCEDURE AddNewCardOwner(name1 VARCHAR(30), name2 VARCHAR(30), store INTEGER)
LANGUAGE SQL
AS $$
    WITH default_discount as (
        SELECT 0.1 AS val
    )
    INSERT INTO card_owner(card_owner_id, first_name, last_name, store_id, points)
        VALUES ((SELECT MAX(card_owner_id) FROM card_owner) + 1, name1, name2, store, 0)
$$;

CREATE OR REPLACE FUNCTION CalculatePoints(id_purchase_product INTEGER) RETURNS INTEGER
LANGUAGE SQL
    RETURN (SELECT 10 * discount * amount FROM card_owners_purchases
        WHERE pp_id = id_purchase_product);

CREATE OR REPLACE PROCEDURE UpdatePoints(id_purchase_product INTEGER)
LANGUAGE SQL
AS $$
    UPDATE card_owner
    SET points = points + CalculatePoints(id_purchase_product)
    WHERE card_owner_id = (SELECT card_owner_id FROM card_owners_purchases
                                WHERE pp_id = id_purchase_product);
$$;

CREATE OR REPLACE PROCEDURE DefaultCardOwner(id_owner INTEGER, id_store INTEGER)
LANGUAGE SQL
AS $$
    UPDATE purchase
        SET card_owner_id = (SELECT max(co.card_owner_id) FROM card_owner co WHERE co.store_id = id_store AND first_name = 'Default')
        WHERE card_owner_id = id_owner;
$$;

CREATE OR REPLACE PROCEDURE AddDefaultOwner(id_store INTEGER)
LANGUAGE SQL
AS $$
    INSERT INTO card_owner(card_owner_id, first_name, last_name, discount, points, store_id)
        VALUES ((SELECT max(card_owner_id) FROM card_owner) + 1, 'Default', 'Default', 0, 0, id_store);
$$;

---------------------------------------
-- Triggers creation.
---------------------------------------

CREATE OR REPLACE TRIGGER tr_new_purchase_product
    AFTER INSERT ON purchase_product
    FOR EACH ROW
    EXECUTE PROCEDURE UpdatePoints(new.purchase_product_id);

CREATE OR REPLACE TRIGGER tr_new_store
    AFTER INSERT ON store
    EXECUTE PROCEDURE AddDefaultOwner(store_id);

CREATE OR REPLACE TRIGGER tr_remove_owner
    BEFORE DELETE ON card_owner
    FOR EACH ROW EXECUTE PROCEDURE DefaultCardOwner(card_owner_id, store_id);

---------------------------------------
-- Deleting additional functional.
---------------------------------------

/*
DROP VIEW product_info;
DROP VIEW card_owners_purchases;
DROP VIEW card_owners_stores;
DROP PROCEDURE AddNewCardOwner;
DROP PROCEDURE AddDefaultOwner;
DROP PROCEDURE DefaultCardOwner;
DROP PROCEDURE UpdatePoints;
DROP FUNCTION CalculatePoints;
DROP TRIGGER tr_new_purchase_product;
DROP TRIGGER tr_new_store;
DROP TRIGGER tr_remove_owner;
*/