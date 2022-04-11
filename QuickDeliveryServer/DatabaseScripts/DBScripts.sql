--drop database QuickDelivery
--Go

--USE GameHighScores;
--GO

CREATE DATABASE QuickDelivery;
Go

USE QuickDelivery;
Go

CREATE TABLE Users(
UserID int IDENTITY (1,1) PRIMARY KEY,
UserFName nvarchar (30) NOT NULL,
UserLName nvarchar (30) NOT NULL,
UserPassword nvarchar (15) NOT NULL,
UserPhone nvarchar (20) NOT NULL,
UserEmail nvarchar (30) NOT NULL UNIQUE,
UserBirthDate datetime,
IsAdmin bit NOT NULL default(0),
HasDiscount bit default(0),
UserAddress nvarchar (30) NOT NULL,
UserCity nvarchar (30) NOT NULL,
NumCreditCard nvarchar (30) NOT NULL,
NumCode nvarchar (3) NOT NULL,
ValidityCreditCard datetime
);


CREATE TABLE DeliveryPersons(
DeliveryPersonID int PRIMARY KEY FOREIGN KEY REFERENCES Users(UserID),


);

CREATE TABLE ShopManagers(
ShopManagerID int PRIMARY KEY FOREIGN KEY REFERENCES Users(UserID),
Bank int NULL,
Branch int NULL,
AccountNumber int NULL,
);

CREATE TABLE Shop(
ShopID int IDENTITY (1,1) PRIMARY KEY,
ShopName nvarchar (30) NOT NULL,
ShopAdress nvarchar (30) NOT NULL,
ShopCity nvarchar (30) NOT NULL,
ShopPhone nvarchar (30) NOT NULL,
ShopManagerID int FOREIGN KEY REFERENCES ShopManagers(ShopManagerID),
IsDeleted bit NOT NULL default(0),
);

CREATE TABLE StatusOrder(
StatusOrderID int IDENTITY (1,1) PRIMARY KEY,
TypeStatus nvarchar (30) NOT NULL
);

CREATE TABLE ProductType(
ProductTypeID int IDENTITY (1,1) PRIMARY KEY,
ProductTypeName nvarchar (30) NOT NULL,
);

CREATE TABLE AgeProductType(
AgeProductTypeID int IDENTITY (1,1) PRIMARY KEY,
AgeProductTypeName nvarchar (30) NOT NULL,
);

CREATE TABLE Products(
ProductID int IDENTITY (1,1) PRIMARY KEY,
ProductName nvarchar(100) NOT NULL,
ShopID int FOREIGN KEY REFERENCES Shop(ShopID),
ProductTypeID int FOREIGN KEY REFERENCES ProductType(ProductTypeID),
AgeProductTypeID int FOREIGN KEY REFERENCES AgeProductType(AgeProductTypeID),
CountProductInShop int NOT NULL,
ProductPrice decimal(9,2) NOT NULL,
IsDeleted bit NOT NULL default(0),
);

CREATE TABLE Orders(
OrderID int IDENTITY (1,1) PRIMARY KEY,
UserID int FOREIGN KEY REFERENCES Users(UserID),
DeliveryPersonID int FOREIGN KEY REFERENCES DeliveryPersons(DeliveryPersonID),
StatusOrderID int FOREIGN KEY REFERENCES StatusOrder(StatusOrderID),
OrderDate datetime NOT NULL,
TotalPrice decimal(9,2),
OrderAddress nvarchar (30) NOT NULL,
OrderCity nvarchar (30) NOT NULL,
);

CREATE TABLE OrderProducts(
OrderID int FOREIGN KEY REFERENCES Orders(OrderID),
ProductID int FOREIGN KEY REFERENCES Products(ProductID),
Quantity int NOT NULL,
Price decimal(9,2),
CONSTRAINT PK_OrderProducts PRIMARY KEY (OrderID,ProductID)
);

CREATE TABLE AllStatusOfOrder(
AllStatusOfOrderID int IDENTITY (1,1) PRIMARY KEY,
OrderID int FOREIGN KEY REFERENCES Orders(OrderID),
StatusOrderID int FOREIGN KEY REFERENCES StatusOrder(StatusOrderID),
StatusTime datetime,
);



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

INSERT INTO AgeProductType (AgeProductTypeName)
VALUES ('Men');
INSERT INTO AgeProductType (AgeProductTypeName)
VALUES ('Women');
INSERT INTO AgeProductType (AgeProductTypeName)
VALUES ('Boys');
INSERT INTO AgeProductType (AgeProductTypeName)
VALUES ('Girls');

INSERT INTO ProductType (ProductTypeName)
VALUES ('Tops');
INSERT INTO ProductType (ProductTypeName)
VALUES ('TShirts');
INSERT INTO ProductType (ProductTypeName)
VALUES ('Pants');
INSERT INTO ProductType (ProductTypeName)
VALUES ('Jeans');
INSERT INTO ProductType (ProductTypeName)
VALUES ('Dresses');
INSERT INTO ProductType (ProductTypeName)
VALUES ('Skirts');
INSERT INTO ProductType (ProductTypeName)
VALUES ('Jackets');

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


SET IDENTITY_INSERT Products ON;  
GO  
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1000, 'מכנסי טרנינג BYE דיטייל רקום', 5, 3, 2, 5, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1001,'מכנסי טרנינג טאי-דאי ספלאש', 5, 3, 2, 8, 99);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1002,'טי-שירט ווש WHATEVER', 5, 2, 2, 5, 103.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1003,'טי-שירט אוברסייז PALM SPRINGS', 5, 2, 2, 4, 79);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1004,'סווטשירט אול-סקוורס טקסטורה צמרירית', 5, 7, 4, 12, 129);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1005,'מכנסי טרנינג סקרלט', 5, 3, 4, 14, 89);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1006, 'גינס HIGH WAIST בגזרה ישרה', 2, 4, 2, 100, 199.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1007,'טי שירט BURGER KING', 2, 2, 2, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1008,'עליונית BASIC עם כפתורים', 2, 7, 2, 100, 199.00); 
GO

insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserAddress, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('Roni', 'Cohen', '1234', '099989898', 'ronico612@gmail.com', '6-DEC-2004',1, 0, 'Kinor 6', 'Hod Hasharon', '9999999999999999', '234', '1-DEC-2040')
Go

insert ShopManagers(ShopManagerID, Bank, Branch, AccountNumber)
values (1, 0,0,0);

UPDATE Shop set ShopManagerID = 1 
Where ShopID = 5;

--DELETE FROM Products WHERE ProductID>=2029;
--DELETE FROM Shop WHERE ShopID=8;
--DELETE FROM ShopManagers WHERE ShopManagerID=2;


--Scaffold-Dbcontext "Server=localhost\sqlexpress03;Database=QuickDelivery;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models –force


