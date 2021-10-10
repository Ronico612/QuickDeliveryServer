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
TypeUserID int FOREIGN KEY REFERENCES UserType(TypeUserID),
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



