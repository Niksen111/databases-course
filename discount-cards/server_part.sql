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

CREATE OR REPLACE VIEW stores_clients_number AS
    SELECT s.name as name, s.address as address, count(card_owner_id) as clinets_number FROM card_owner c
        RIGHT JOIN store s on s.store_id = c.store_id
        JOIN city c2 on s.city_id = c2.city_id
        GROUP BY s.store_id;

---------------------------------------
-- Procedures/functions creation.
---------------------------------------

-- Adding new card owner.
CREATE OR REPLACE PROCEDURE AddNewCardOwner(name1 VARCHAR(30), name2 VARCHAR(30), store INTEGER)
LANGUAGE SQL
AS $$
    WITH default_discount as (
        SELECT 0.1 AS val
    )
    INSERT INTO card_owner(card_owner_id, first_name, last_name, store_id, points)
        VALUES ((SELECT MAX(card_owner_id) FROM card_owner) + 1, name1, name2, store, 0)
$$;

-- Calculating of the points of a purchase_product entry.
CREATE OR REPLACE FUNCTION CalculatePoints(id_purchase_product INTEGER) RETURNS INTEGER
LANGUAGE SQL
    RETURN (SELECT 10 * discount * amount FROM card_owners_purchases
        WHERE pp_id = id_purchase_product);

-- Updating of the points by the query.
CREATE OR REPLACE PROCEDURE UpdatePoints(id_purchase_product INTEGER)
LANGUAGE SQL
AS $$
    UPDATE card_owner
    SET points = points + CalculatePoints(id_purchase_product)
    WHERE card_owner_id = (SELECT card_owner_id FROM card_owners_purchases
                                WHERE pp_id = id_purchase_product);
$$;

-- Replace the owner with the default one.
CREATE OR REPLACE PROCEDURE DefaultCardOwner(id_owner INTEGER, id_store INTEGER)
LANGUAGE SQL
AS $$
    UPDATE purchase
        SET card_owner_id = (SELECT max(co.card_owner_id) FROM card_owner co WHERE co.store_id = id_store AND first_name = 'Default')
        WHERE card_owner_id = id_owner;
$$;

-- Create default owner for the store.
CREATE OR REPLACE PROCEDURE AddDefaultOwner(id_store INTEGER)
LANGUAGE SQL
AS $$
    INSERT INTO card_owner(card_owner_id, first_name, last_name, discount, points, store_id)
        VALUES ((SELECT max(card_owner_id) FROM card_owner) + 1, 'Default', 'Default', 0, 0, id_store);
$$;

---------------------------------------
-- Triggers creation.
---------------------------------------

-- Updating of the points of a new purchase.
CREATE OR REPLACE TRIGGER tr_new_purchase_product
    AFTER INSERT ON purchase_product
    FOR EACH ROW
    EXECUTE PROCEDURE UpdatePoints(new.purchase_product_id);
-- check: INSERT INTO purchase_product VALUES ((SELECT max(purchase_product_id) FROM purchase_product) + 1, 1, 1, 1);

-- Creating default owner for the new store.
CREATE OR REPLACE TRIGGER tr_new_store
    AFTER INSERT ON store
    EXECUTE PROCEDURE AddDefaultOwner(store_id);
-- check: INSERT INTO store VALUES ((SELECT max(store_id) FROM store) + 1, 1, 'ABCD', 'EFGH');

-- Default a deleted cardholder.
CREATE OR REPLACE TRIGGER tr_remove_owner
    BEFORE DELETE ON card_owner
    FOR EACH ROW EXECUTE PROCEDURE DefaultCardOwner(card_owner_id, store_id);
-- check: DELETE FROM card_owner WHERE card_owner_id = 1;

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