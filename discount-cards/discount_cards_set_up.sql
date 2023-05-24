/*
CREATE DATABASE discount_cards;
GO
USE discount_cards;
*/

CREATE TABLE Product_Type(
    Product_Type_ID         INTEGER         NOT NULL,
    Category	            VARCHAR(30)     NOT NULL,
    Coef_Discount           FLOAT           NOT NULL,
    CONSTRAINT Product_Type_PK PRIMARY KEY (Product_Type_ID)
);

CREATE TABLE Measurement_Unit(
    Measurement_Unit_ID     INTEGER         NOT NULL,
    Name	                VARCHAR(20)     NOT NULL,
    CONSTRAINT Measurement_Unit_PK PRIMARY KEY (Measurement_Unit_ID)
);

CREATE TABLE City(
    City_ID                 INTEGER          NOT NULL,
    Name	                VARCHAR(30)      NOT NULL,
    CONSTRAINT City_PK PRIMARY KEY (City_ID)
);

CREATE TABLE Store(
    Store_ID                 INTEGER          NOT NULL,
    Name	                 VARCHAR(30)      NOT NULL,
    Address                  VARCHAR(50)      NOT NULL,
    City_ID                  INTEGER          NOT NULL,
    CONSTRAINT Store_PK PRIMARY KEY (Store_ID),
    CONSTRAINT FK_Store_City FOREIGN KEY (City_ID)
        REFERENCES City(City_ID)
);

CREATE TABLE Card_Owner(
    Card_Owner_ID            INTEGER          NOT NULL,
    First_Name	             VARCHAR(30)      NOT NULL,
    Last_Name                VARCHAR(30)      NOT NULL,
    Discount                 FLOAT            NOT NULL CHECK ( Discount BETWEEN 0 AND 1),
    Points                   INTEGER          NOT NULL DEFAULT 0,
    City_ID                  INTEGER          NOT NULL,
    CONSTRAINT Card_Owner_PK PRIMARY KEY (Card_Owner_ID),
    CONSTRAINT FK_Card_Owner_City FOREIGN KEY (City_ID)
      REFERENCES City(City_ID)
);

CREATE TABLE Purchase(
    Purchase_ID              INTEGER          NOT NULL,
    Date                     TIMESTAMP        NOT NULL,
    Store_ID                 INTEGER          NOT NULL,
    Card_Owner_ID            INTEGER          NOT NULL,
    CONSTRAINT Purchase_PK PRIMARY KEY (Purchase_ID),
    CONSTRAINT FK_Purchase_Store_ID FOREIGN KEY (Store_ID)
        REFERENCES Store(Store_ID),
    CONSTRAINT FK_Purchase_Card_Owner FOREIGN KEY (Card_Owner_ID)
        REFERENCES Card_Owner(Card_Owner_ID)
);


CREATE TABLE Product(
    Product_ID              INTEGER         NOT NULL,
    Name	                VARCHAR(50)     NOT NULL,
    Cost                    FLOAT           NOT NULL CHECK ( Cost >= 0 ),
    Product_Type_ID         INTEGER         NOT NULL,
    Measurement_Unit_ID     INTEGER         NOT NULL,
    CONSTRAINT Product_PK PRIMARY KEY (Product_ID),
    CONSTRAINT FK_Product_Product_Type FOREIGN KEY (Product_Type_ID)
        REFERENCES Product_Type(Product_Type_ID),
    CONSTRAINT FK_Product_Measurement_Unit FOREIGN KEY (Measurement_Unit_ID)
        REFERENCES Measurement_Unit(Measurement_Unit_ID)
);

CREATE TABLE Purchase_Product(
    Purchase_Product_ID      INTEGER        NOT NULL,
    Amount	                 FLOAT          NOT NULL CHECK ( Amount > 0 ),
    Purchase_ID              INTEGER        NOT NULL,
    Product_ID               INTEGER        NOT NULL,
    CONSTRAINT Purchase_Product_PK PRIMARY KEY (Purchase_Product_ID),
    CONSTRAINT FK_Purchase_Product_Purchase FOREIGN KEY (Purchase_ID)
        REFERENCES Purchase(Purchase_ID),
    CONSTRAINT FK_Purchase_Product_Product FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
);

/*
DROP TABLE Purchase_Product;
DROP TABLE Product;
DROP TABLE Purchase;
DROP TABLE Card_Owner;
DROP TABLE Store;
DROP TABLE City;
DROP TABLE Measurement_Unit;
DROP TABLE Product_Type;
*/