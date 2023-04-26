/*
CREATE DATABASE discount_cards;
GO
USE discount_cards;
 */

CREATE TABLE Product_Type(
    Product_Type_ID        INTEGER         NOT NULL,
    Category	           VARCHAR(50)     NOT NULL ,
    Coef_Discount          FLOAT           NOT NULL,
    CONSTRAINT Product_Type_PK PRIMARY KEY (Product_Type_ID)
);

CREATE TABLE Measurement_Unit(
    Measurement_Unit_ID        INTEGER         NOT NULL,
    Name	               VARCHAR(20)     NOT NULL ,
    CONSTRAINT Product_Type_PK PRIMARY KEY (Measurement_Unit_ID)
);