CREATE DATABASE QuickDelivery;
Go

USE QuickDelivery;
Go


CREATE TABLE UserType(
TypeUserID int IDENTITY (1,1) PRIMARY KEY,
TypeUser nvarchar NOT NULL,
);


CREATE TABLE Users(
UserID int IDENTITY (1,1) PRIMARY KEY,
UserFName nvarchar (15) NOT NULL,
UserLName nvarchar (15) NOT NULL,
Username nvarchar (25) NOT NULL,
UserPassword nvarchar (25) NOT NULL,
UserPhone int NOT NULL,
UserEmail nvarchar (30) NOT NULL UNIQUE,
UserBirthDate datetime,
IsAdmin bit NOT NULL default(0),
HasDiscount bit default(0),
UserAdress nvarchar NOT NULL,
UserCity nvarchar NOT NULL,
NumCreditCard int,
NumCode int,
ValidityCreditCard int,
);


CREATE TABLE DelPersons(
DelPersonID int PRIMARY KEY FOREIGN KEY REFERENCES Users(UserID),


);


CREATE TABLE ShopManagers(
ShopManagerID int PRIMARY KEY FOREIGN KEY REFERENCES Users(UserID),
Bank int NOT NULL,
Branch int NOT NULL,
AccountNumber int NOT NULL,
);



CREATE TABLE Shop(
ShopID int IDENTITY (1,1) PRIMARY KEY,
ShopName nvarchar NOT NULL,
ShopAdress nvarchar NOT NULL,
ShopManagerID int FOREIGN KEY REFERENCES ShopManagers(ShopManagerID),
ShopCity nvarchar NOT NULL, 
ShopPhone int NOT NULL,
);

CREATE TABLE StatusOrder(
StatusOrderID int IDENTITY (1,1) PRIMARY KEY,
TypeStatus nvarchar NOT NULL,
);


CREATE TABLE Products(
ProductID int IDENTITY (1,1) PRIMARY KEY,
ProductName nvarchar NOT NULL,
ShopID int FOREIGN KEY REFERENCES Shop(ShopID),
CountProductInShop int NOT NULL,
ProductPrice int NOT NULL,
);


CREATE TABLE Orders(
OrderID int IDENTITY (1,1) PRIMARY KEY,
UserID int FOREIGN KEY REFERENCES Users(UserID),
DelPersonID int FOREIGN KEY REFERENCES DelPersons(DelPersonID),
StatusOrderID int FOREIGN KEY REFERENCES StatusOrder(StatusOrderID),
OrderDate datetime NOT NULL,
);


CREATE TABLE OrderProducts(
OrderID int FOREIGN KEY REFERENCES Orders(OrderID),
ProductID int FOREIGN KEY REFERENCES Products(ProductID),
Quantity int NOT NULL,
Price int,
CONSTRAINT PK_OrderProducts PRIMARY KEY (OrderID,ProductID)
);


CREATE TABLE ProductType(
ProductTypeID int IDENTITY (1,1) PRIMARY KEY,
ProductType nvarchar NOT NULL,
);


CREATE TABLE AllTypesOfPrduct(
AllTypesOfPrductID int IDENTITY (1,1) PRIMARY KEY,
ProductID int FOREIGN KEY REFERENCES Products(ProductID),
ProductTypeID int FOREIGN KEY REFERENCES ProductType(ProductTypeID),
);


CREATE TABLE AllStatusOfOrder(
AllStatusOfOrderID int IDENTITY (1,1) PRIMARY KEY,
OrderID int FOREIGN KEY REFERENCES Orders(OrderID),
StatusOrderID int FOREIGN KEY REFERENCES StatusOrder(StatusOrderID),
StatusTime datetime,
);

ALTER TABLE Users 
ALTER COLUMN UserPhone nvarchar(10)

DROP TABLE UserType

ALTER TABLE Users 
ALTER COLUMN UserAdress nvarchar (30) NOT NULL
ALTER TABLE Users 
ALTER COLUMN UserCity nvarchar (15) NOT NULL

ALTER TABLE Shop
ALTER COLUMN ShopName nvarchar (15) NOT NULL
ALTER TABLE Shop
ALTER COLUMN ShopAdress nvarchar (30) NOT NULL
ALTER TABLE Shop
ALTER COLUMN ShopCity nvarchar (15) NOT NULL 

ALTER TABLE StatusOrder
ALTER COLUMN TypeStatus nvarchar (30) NOT NULL

ALTER TABLE Products
ALTER COLUMN ProductName nvarchar (15) NOT NULL

ALTER TABLE ProductType
ALTER COLUMN ProductType nvarchar (15) NOT NULL

INSERT INTO StatusOrder (TypeStatus)
VALUES ('waiting');
INSERT INTO StatusOrder (TypeStatus)
VALUES ('approved');
INSERT INTO StatusOrder (TypeStatus)
VALUES ('taken');
INSERT INTO StatusOrder (TypeStatus)
VALUES ('brought');
INSERT INTO StatusOrder (TypeStatus)
VALUES ('canceled');

INSERT INTO ProductType (ProductType)
VALUES ('Kids');
INSERT INTO ProductType (ProductType)
VALUES ('Women');
INSERT INTO ProductType (ProductType)
VALUES ('Men');
INSERT INTO ProductType (ProductType)
VALUES ('Tops');
INSERT INTO ProductType (ProductType)
VALUES ('TShirts');
INSERT INTO ProductType (ProductType)
VALUES ('Pants');
INSERT INTO ProductType (ProductType)
VALUES ('Jeans');
INSERT INTO ProductType (ProductType)
VALUES ('Dresses');
INSERT INTO ProductType (ProductType)
VALUES ('Skirts');


INSERT INTO Shop (TypeStatus)
VALUES ('');
ShopName nvarchar NOT NULL,
ShopAdress nvarchar NOT NULL,
ShopManagerID int FOREIGN KEY REFERENCES ShopManagers(ShopManagerID),
ShopCity nvarchar NOT NULL, 
ShopPhone int NOT NULL,
