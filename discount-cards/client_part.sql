---------------------------
-- Client part.
---------------------------

-- 01 Удаление из базы владельцев карт не сделавших ни одной покупки за год.
DELETE FROM card_owner co WHERE date_part('year', age(CURRENT_DATE, (SELECT max(date) FROM card_owners_purchases cop
                          WHERE cop.card_owner_id = co.card_owner_id))) >= 1;

-- 02 Магазины в которые выдали не меньше 1 карты.
SELECT s.name as name, address, count(card_owner_id) as clients_number FROM card_owner co
    RIGHT JOIN store s on s.store_id = co.store_id
    GROUP BY s.store_id
    HAVING count(card_owner_id) > 1;

-- 03 Топ 5 клиентов по скидке / количеству баллов.
SELECT first_name, last_name, discount, points, store_id FROM card_owner
    ORDER BY discount DESC , points DESC limit 5;

-- 04 Выбор всех дефолтных клиентов.
SELECT * FROM card_owner co WHERE first_name = 'Default';

-- 05 Владельцы карт не сделавшие ни одного заказа.
SELECT * FROM card_owner WHERE card_owner_id
    NOT IN (SELECT cop.card_owner_id FROM card_owners_purchases cop);

-- 06 Прибыль от магазина за всё время.
SELECT sum(amount * p.cost) FROM purchase_product pp
    JOIN product p on p.product_id = pp.product_id
    JOIN purchase p2 on p2.purchase_id = pp.purchase_id
    JOIN store s on p2.store_id = s.store_id
    WHERE s.store_id = 1;

-- 07 Покупки в магазине за период.
SELECT * FROM purchase_product pp
    JOIN product p on p.product_id = pp.product_id
    JOIN purchase p2 on p2.purchase_id = pp.purchase_id
    JOIN store s on p2.store_id = s.store_id
    WHERE s.store_id = 2 AND date BETWEEN '2022-01-06' AND '2022-01-08';

-- 08 Продукты чья цена выше 120.
SELECT * FROM product_info WHERE cost > 120;

-- 09 Названия товаров и категории.
SELECT name, 'название товара' FROM product p
UNION
SELECT category, 'название категории' FROM product_type pt
ORDER BY 2;

-- 10 Топ 5 популярных товаров за последнюю неделю.
SELECT p.product_id, name, sum(amount * cost) FROM product p
    JOIN purchase_product pp on p.product_id = pp.product_id
    JOIN purchase p2 on pp.purchase_id = p2.purchase_id
    WHERE date > '2022-01-02'
    GROUP BY p.product_id
    ORDER BY sum(amount * cost) DESC
    LIMIT 5;

-- 11 Все клиенты из города 2.
SELECT first_name, last_name, discount, points, s.name, s.address FROM card_owner co
    JOIN store s on s.store_id = co.store_id
    JOIN city c on c.city_id = s.city_id
    WHERE c.city_id = 2;

-- 12 Полные цены покупок.
SELECT pp.purchase_id, sum(amount * cost)FROM purchase_product pp
    JOIN product p on p.product_id = pp.product_id
    GROUP BY pp.purchase_id;
