---------------------------------------
-- Filling tables with test data.
---------------------------------------

INSERT INTO product_type(product_type_id, category, coef_discount)
    VALUES (1, 'Groat', 1.);
INSERT INTO product_type(product_type_id, category, coef_discount)
    VALUES (2, 'Meat', 1.);
INSERT INTO product_type(product_type_id, category, coef_discount)
    VALUES (3, 'Beverage', 1.);
INSERT INTO product_type(product_type_id, category, coef_discount)
    VALUES (4, 'Dairy', 1.);
INSERT INTO product_type(product_type_id, category, coef_discount)
    VALUES (5, 'Vegetables', 1.5);
INSERT INTO product_type(product_type_id, category, coef_discount)
    VALUES (6, 'Fruits', 1.5);
INSERT INTO product_type(product_type_id, category, coef_discount)
    VALUES (7, 'Other', 1);

INSERT INTO measurement_unit(measurement_unit_id, name)
    VALUES (1, 'kilograms');
INSERT INTO measurement_unit(measurement_unit_id, name)
    VALUES (2, 'pieces');
INSERT INTO measurement_unit(measurement_unit_id, name)
    VALUES (3, 'meters');
INSERT INTO measurement_unit(measurement_unit_id, name)
    VALUES (4, 'liters');

INSERT INTO city(city_id, name)
    VALUES (1, 'Moscow');
INSERT INTO city(city_id, name)
    VALUES (2, 'Saint-Petersburg');
INSERT INTO city(city_id, name)
    VALUES (3, 'Pskov');

INSERT INTO store(store_id, name, address, city_id)
    VALUES (1, 'Walmart', '123 Main St', 1);
INSERT INTO store(store_id, name, address, city_id)
    VALUES (2, 'Target', '456 Elm St', 1);
INSERT INTO store(store_id, name, address, city_id)
    VALUES (3, 'Best Buy', '789 Oak St', 1);
INSERT INTO store(store_id, name, address, city_id)
    VALUES (4, 'Home Depot', '101 Maple Ave', 2);
INSERT INTO store(store_id, name, address, city_id)
    VALUES (5, 'Lowes', '222 Pine St', 2);
INSERT INTO store(store_id, name, address, city_id)
    VALUES (6, 'Super-Giper', '22 Best St', 3);

INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (1, 'John', 'Doe', 0.2, 2, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (2, 'Jane', 'Smith', 0.1, 3, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (3, 'Bob', 'Johnson', 0.3, 4, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (4, 'Samantha', 'Lee', 0.15, 5, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (5, 'Michael', 'Nguyen', 0.25, 6, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (6, 'Emily', 'Wang', 0.2, 1, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (7, 'David', 'Kim', 0.1, 2, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (8, 'Jessica', 'Garcia', 0.3, 3, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (9, 'Kevin', 'Chen', 0.15, 4, 0);
INSERT INTO Card_Owner (Card_Owner_ID, First_Name, Last_Name, Discount, Store_id, Points)
    VALUES (10, 'Sarah', 'Park', 0.25, 5, 0);

INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (1, '2022-01-01 10:00:00', 1, 1);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (2, '2022-01-02 14:30:00', 1, 2);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (3, '2022-01-03 09:15:00', 1, 3);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (4, '2022-01-04 16:45:00', 1, 4);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (5, '2022-01-05 11:20:00', 1, 5);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (6, '2022-01-06 13:00:00', 2, 6);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (7, '2022-01-07 15:10:00', 2, 7);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (8, '2022-01-08 12:30:00', 2, 8);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (9, '2022-01-09 17:00:00', 3, 9);
INSERT INTO Purchase (Purchase_ID, Date, Store_ID, Card_Owner_ID)
    VALUES (10, '2022-01-10 10:45:00', 1, 1);

INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (1, 'Apple', 150, 6, 1);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (2, 'Banana', 80, 6, 1);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (3, 'Orange', 180, 6, 1);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (4, 'Milk', 90, 4, 4);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (5, 'Cheese', 300, 4, 1);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (6, 'Apple juice', 30, 3, 4);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (7, 'Pasta', 200, 7, 2);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (8, 'Chicken', 300, 2, 1);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (9, 'Beef', 400, 2, 1);
INSERT INTO Product (Product_ID, Name, Cost, Product_Type_ID, Measurement_Unit_ID)
    VALUES (10, 'Fish', 350, 2, 1);

INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (1, 1.1, 1, 1);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (2, 0.7, 1, 2);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (3, 0.6, 1, 3);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (4, 1.5, 2, 4);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (5, 0.4, 2, 5);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (6, 2, 3, 6);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (7, 2, 4, 7);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (8, 2.3, 5, 8);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (9, 3.1, 5, 9);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (10, 1.6, 6, 10);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (11, 0.4, 7, 1);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (12, 0.8, 8, 2);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (13, 0.65, 8, 3);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (14, 1, 9, 4);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (15, 0.6, 10, 5);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (16, 3, 10, 6);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (17, 1, 10, 7);
INSERT INTO purchase_product(purchase_product_id, amount, purchase_id, product_id)
    VALUES (18, 1.25, 10, 8);