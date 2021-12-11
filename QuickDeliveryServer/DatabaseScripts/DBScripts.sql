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
ALTER TABLE Shop
ALTER COLUMN ShopPhone nvarchar (15) NOT NULL

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

ALTER TABLE ProductType ADD ProductTypeName nvarchar(20);
ALTER TABLE ProductType drop column ProductType;
update ProductType set ProductTypeName='Men' where ProductTypeID=1;
update ProductType set ProductTypeName='Women' where ProductTypeID=2;
update ProductType set ProductTypeName='Boys' where ProductTypeID=3;
update ProductType set ProductTypeName='Girls' where ProductTypeID=4;
update ProductType set ProductTypeName='Tops' where ProductTypeID=5;
update ProductType set ProductTypeName='TShirts' where ProductTypeID=6;
update ProductType set ProductTypeName='Jeans' where ProductTypeID=7;
update ProductType set ProductTypeName='Dresses' where ProductTypeID=8;
update ProductType set ProductTypeName='Skirts' where ProductTypeID=9;
INSERT INTO ProductType (ProductTypeName)
VALUES ('Jackets');
INSERT INTO ProductType (ProductTypeName)
VALUES ('Pants');
ALTER TABLE ProductType
ALTER COLUMN ProductTypeName nvarchar (20) NOT NULL


INSERT INTO Shop (ShopName, ShopAdress, ShopCity ,ShopPhone)
VALUES ('Pull and Bear', 'המלאכה 6', 'רעננה', '059-951-0510');
INSERT INTO Shop (ShopName, ShopAdress, ShopCity ,ShopPhone)
VALUES ('Pull and Bear', 'שדרות שבעת הכוכבים 8', 'הרצליה', '09-958-7176');
INSERT INTO Shop (ShopName, ShopAdress, ShopCity ,ShopPhone)
VALUES ('Pull and Bear', 'זבוטינסקי 72', 'פתח תקווה', '03-603-2547');
INSERT INTO Shop (ShopName, ShopAdress, ShopCity ,ShopPhone)
VALUES ('Adika', 'דרך מנחם בגין 132', 'תל אביב יפו', '03-800-1000');
INSERT INTO Shop (ShopName, ShopAdress, ShopCity ,ShopPhone)
VALUES ('Adika', 'דיזנגוף 50', 'תל אביב יפו', '03-800-1000');
INSERT INTO Shop (ShopName, ShopAdress, ShopCity ,ShopPhone)
VALUES ('Adika', 'בני ברמן', 'נתניה', '03-800-1000');



--מפה להריץ
ALTER TABLE Products 
ALTER COLUMN ProductPrice decimal(5,2) NOT NULL

INSERT INTO Products (ProductName, ShopID, CountProductInShop, ProductPrice)
VALUES ('מכנסי טרנינג BYE דיטייל רקום', 1, 5, 79.90);
INSERT INTO Products (ProductName, ShopID, CountProductInShop, ProductPrice)
VALUES ('מכנסי טרנינג טאי-דאי ספלאש', 1, 8, 99);
INSERT INTO Products (ProductName, ShopID, CountProductInShop, ProductPrice)
VALUES ('טי-שירט ווש WHATEVER', 1, 5, 103.90);
INSERT INTO Products (ProductName, ShopID, CountProductInShop, ProductPrice)
VALUES ('טי-שירט אוברסייז PALM SPRINGS', 1, 4, 79);
--לבדוק מידות 
INSERT INTO AllTypesOfPrduct (ProductID, ProductTypeID)
VALUES (1, 5);
CREATE TABLE AllTypesOfPrduct(
AllTypesOfPrductID int IDENTITY (1,1) PRIMARY KEY,
ProductID int FOREIGN KEY REFERENCES Products(ProductID),
ProductTypeID int FOREIGN KEY REFERENCES ProductType(ProductTypeID),
);

