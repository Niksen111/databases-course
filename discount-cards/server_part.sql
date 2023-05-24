CREATE OR REPLACE PROCEDURE AddNewCardOwner(name1 VARCHAR(30), name2 VARCHAR(30), city INTEGER)
LANGUAGE plpgsql
BEGIN ATOMIC
    WITH default_discount as (
        SELECT 0.1 AS val
    )
    INSERT INTO card_owner(card_owner_id, first_name, last_name, discount, city_id, points)
        VALUES ((SELECT MAX(card_owner_id) FROM card_owner) + 1, name1, name2, default_discount, city, 0);
END;

CREATE OR REPLACE FUNCTION CalculatePoints(id_purchase_product INTEGER)
LANGUAGE plpgsql
BEGIN ATOMIC
    SELECT 10 * discount * amount FROM card_owners_purchases
        WHERE pp_id = id_purchase_product;
END;

CREATE OR REPLACE PROCEDURE UpdatePoints(id_purchase_product INTEGER)
LANGUAGE plpgsql
BEGIN ATOMIC
    UPDATE card_owner
    SET points = points + CalculatePoints(id_purchase_product)
    WHERE card_owner_id = (SELECT card_owner_id FROM card_owners_purchases
                                WHERE pp_id = id_purchase_product);
END;

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
        JOIN store s on card_owner.city_id = s.city_id
        JOIN city c on card_owner.city_id = c.city_id;

CREATE INDEX idx_purchases ON purchase(card_owner_id, date, store_id);
CREATE INDEX idx_purchase_product ON purchase_product(product_id, amount, purchase_id);
CREATE INDEX idx_card_owners_purchases ON card_owners_purchases(pp_id, cost, amount);

CREATE OR REPLACE TRIGGER tr_new_purchase_product
    AFTER INSERT ON purchase_product
    FOR EACH ROW
    EXECUTE PROCEDURE UpdatePoints(purchase_product_id);

/* CREATE OR REPLACE TRIGGER tr_ */

/*
DROP TRIGGER tr_kek;
*/