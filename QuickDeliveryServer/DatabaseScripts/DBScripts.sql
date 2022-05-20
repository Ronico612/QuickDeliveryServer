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
UserStreet nvarchar (30) NOT NULL,
UserHouseNum int NOT NULL,
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
ShopStreet nvarchar (30) NOT NULL,
ShopHouseNum int NOT NULL,
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
OrderStreet nvarchar (30) NOT NULL,
OrderHouseNum int NOT NULL,
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
VALUES ('נשים');
INSERT INTO AgeProductType (AgeProductTypeName)
VALUES ('גברים');
INSERT INTO AgeProductType (AgeProductTypeName)
VALUES ('בנות');
INSERT INTO AgeProductType (AgeProductTypeName)
VALUES ('בנים');

INSERT INTO ProductType (ProductTypeName)
VALUES ('הלבשה תחתונה');
INSERT INTO ProductType (ProductTypeName)
VALUES ('חולצות');
INSERT INTO ProductType (ProductTypeName)
VALUES ('מכנסיים');
INSERT INTO ProductType (ProductTypeName)
VALUES ('גינסים');
INSERT INTO ProductType (ProductTypeName)
VALUES ('שמלות');
INSERT INTO ProductType (ProductTypeName)
VALUES ('חצאיות');
INSERT INTO ProductType (ProductTypeName)
VALUES ('זקטים');

insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('רוני', 'כהן', '1234', '0509989898', 'ronico612@gmail.com', '6-DEC-1998',1, 0, 'כינור', 6,'הוד השרון', '9999999999999999', '234', '1-DEC-2040')
insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('פאני', 'פוקס', '1234', '0527459988', 'fani@gmail.com', '12-JAN-1995',0, 0, 'השומר', 21,'הרצליה', '8888888888888888', '121', '4-JAN-2031')
insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('בר', 'פולק', '1234', '0548765643', 'bar@gmail.com', '11-APR-1981',0, 0, 'הצבר', 12,'כפר סבא', '7777777777777777', '343', '6-DEC-2033')
insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('אודי', 'סול', '1234', '0508976541', 'udi@gmail.com', '9-JUN-1987',0, 0, 'תל חי', 32,'נס ציונה', '5555555555555555', '656', '9-FEB-2027')
insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('שרה', 'כהן', '1234', '0527778899', 'sara@gmail.com', '26-JUL-1970',0, 0, 'מרגלית', 15,'פתח תקווה', '1111111111111111', '111', '18-APR-2026')
insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('עדי', 'לוי', '1234', '0545955643', 'adi@gmail.com', '18-DEC-1979',0, 0, 'הבשן', 10,'תל אביב - יפו', '2222222222222222', '214', '19-DEC-2025')
insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('אמה', 'וייס', '1234', '0507654421', 'ema@gmail.com', '22-APR-1988',0, 0, 'הבוסתן', 24,'הוד השרון', '3333333333333333', '256', '12-JAN-2027')

Insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('שי', 'עמרני', '1234', '0507455521', 'shay@gmail.com', '28-APR-1990',0, 0, 'הבבלי', 3,'הוד השרון', '4444444444444444', '111', '12-JAN-2027')
Insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('שחר', 'פאר', '1234', '0507885521', 'shahar@gmail.com', '29-APR-1990',0, 0, 'הבנאי', 5,'הוד השרון', '5555555555555555', '222', '13-JAN-2027')
Insert users (UserFName, UserLName, UserPassword, UserPhone, UserEmail, UserBirthDate, IsAdmin, HasDiscount,
UserStreet, UserHouseNum, UserCity, NumCreditCard, NumCode, ValidityCreditCard) values 
('שני', 'דרוקר', '1234', '0507775521', 'shany@gmail.com', '30-APR-1990',0, 0, 'הבנים', 7,'הוד השרון', '6666666666666666', '333', '14-JAN-2027')
Go

insert ShopManagers(ShopManagerID, Bank, Branch, AccountNumber)
values (2,0,0,0);
insert ShopManagers(ShopManagerID, Bank, Branch, AccountNumber)
values (3,0,0,0);
insert ShopManagers(ShopManagerID, Bank, Branch, AccountNumber)
values (4,0,0,0);
insert ShopManagers(ShopManagerID, Bank, Branch, AccountNumber)
values (5,0,0,0);
insert ShopManagers(ShopManagerID, Bank, Branch, AccountNumber)
values (6,0,0,0);
insert ShopManagers(ShopManagerID, Bank, Branch, AccountNumber)
values (7,0,0,0);
Go

insert DeliveryPersons(DeliveryPersonId)
values (8);
insert DeliveryPersons(DeliveryPersonId)
values (9);
insert DeliveryPersons(DeliveryPersonId)
values (10);
Go

INSERT INTO Shop (ShopName, ShopStreet, ShopHouseNum, ShopCity ,ShopPhone, ShopManagerID)
VALUES ('פוקס', 'המלאכה', 2, 'רעננה', '097418039',2);
INSERT INTO Shop (ShopName, ShopStreet, ShopHouseNum, ShopCity ,ShopPhone, ShopManagerID)
VALUES ('פול אנד בר', 'שבעת הכוכבים', 8, 'הרצליה', '099587176',3);
INSERT INTO Shop (ShopName, ShopStreet, ShopHouseNum, ShopCity ,ShopPhone, ShopManagerID)
VALUES ('הודיס', 'רוטשילד', 45, 'ראשון לציון', '039400115',4);
INSERT INTO Shop (ShopName, ShopStreet, ShopHouseNum, ShopCity ,ShopPhone, ShopManagerID)
VALUES ('זארה', 'ויצמן', 207, 'כפר סבא', '035386328',5);
INSERT INTO Shop (ShopName, ShopStreet, ShopHouseNum, ShopCity ,ShopPhone, ShopManagerID)
VALUES ('עדיקה', 'דיזנגוף', 50, 'תל אביב - יפו', '038001000',6);
INSERT INTO Shop (ShopName, ShopStreet, ShopHouseNum, ShopCity ,ShopPhone, ShopManagerID)
VALUES ('אייץ אנד אם', 'הרצל', 60, 'נתניה', '0547155777',7);
Go

SET IDENTITY_INSERT Products ON;  
GO  
-- פוקס
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1001, 'טי שירט עם הדפס', 1, 2, 1, 100, 49.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1002, 'טי שירט עם הדפס', 1, 2, 1, 100, 49.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1003, 'טי שירט קרופ עם הדפס', 1, 2, 1, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1004, 'טי שירט קרופ בנות הפאוור פאף', 1, 2, 1, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1005, 'טי שירט קרופ עם הדפס MTV', 1, 2, 1, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1006, 'טי שירט קרופ עם הדפס כיתוב', 1, 2, 1, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1007, 'טי שירט קרופ עם הדפס MARVEL', 1, 2, 1, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1008, 'טי שירט קרופ דיסני', 1, 2, 1, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1100, 'מכנסיים ארוכים בגזרה רחבה', 1, 3, 1, 100, 179.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1101, 'מכנסי פוטר טרנינג רחבים', 1, 3, 1, 100, 64.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1102, 'מכנסיים ארוכים עם הדפס', 1, 3, 1, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1103, 'מכנסי טרנינג בהדפס לוני טונס', 1, 3, 1, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1104, 'מכנסיים רחבים בטקסטורת ריב', 1, 3, 1, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1105, 'מכנסי טרנינג עם הדפס כיתוב', 1, 3, 1, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1106, 'מכנסי טרנינג עם כיסים', 1, 3, 1, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1107, 'מכנסי טרנינג בייסיק', 1, 3, 1, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1108, 'מכנסיים סרוגים בגיזרה מתרחבת', 1, 3, 1, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1109, 'טייץ בהדפס טאי דאי', 1, 3, 1, 100, 49.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1200, 'גינס קצר בסיומת פרנזים', 1, 4, 1, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1201, 'גינס סקיני ארוך', 1, 4, 1, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1202, 'גינס ברמודה שיפשופים סיומת פרומה', 1, 4, 1, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1203, 'גינס אסיד ווש קצר', 1, 4, 1, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1204, 'גינס קצר ווש עם קיפול', 1, 4, 1, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1205, 'גינס קצר ווש בסיומת קיפול', 1, 4, 1, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1206, 'גינס מתרחב בגיזרה גבוהה', 1, 4, 1, 100, 179.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1207, 'מכנסי גינס קצרים', 1, 4, 1, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1208, 'גינס קצר פייפרבאג', 1, 4, 1, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1209, 'גינס קצר ווש עם שסעים', 1, 4, 1, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1210, 'גינס קצר בהדפס וסיומת גזורה', 1, 4, 1, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1300, 'שמלת מידי מכופתרת בהדפס', 1, 5, 1, 100, 169.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1301, 'שמלת מידי מכופתרת בהדפס', 1, 5, 1, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1302, 'שמלת מידי קומות', 1, 5, 1, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1303, 'שמלת מיני בייסיק', 1, 5, 1, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1400, 'טי שירט עם הדפס חוף ים', 1, 2, 2, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1401, 'טי שירט עם הדפס כיתוב', 1, 2, 2, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1402, 'טי שירט עם הדפס מדבר', 1, 2, 2, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1403, 'חולצת פולו בהדפס פסים', 1, 2, 2, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1404, 'טי שירט עם הדפס MTV', 1, 2, 2, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1405, 'טי שירט עם הדפס כיתוב', 1, 2, 2, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1406, 'טי שירט עם הדפס Bronx', 1, 2, 2, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1407, 'טי שירט עם הדפס MARVEL', 1, 2, 2, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1408, 'חולצת פולו קולורבלוק', 1, 2, 2, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1409, 'טי שירט עם הדפס ריק ומורטי', 1, 2, 2, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1500, 'מכנסי טרנינג קצרים עם כיתוב', 1, 3, 2, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1501, 'מכנסי טרנינג עם כיסים', 1, 3, 2, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1502, 'מכנסי טרנינג קצרים', 1, 3, 2, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1503, 'מכנסי טרנינג בהדפס קמופלאז', 1, 3, 2, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1504, 'מכנסי טרנינג עם כיסים', 1, 3, 2, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1505, 'מכנסי טרנינג עם כיסים', 1, 3, 2, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1506, 'מכנסי אקטיב קצרים עם כיתוב', 1, 3, 2, 100, 119.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1507, 'מכנסי דגמח קצרים', 1, 3, 2, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1600, 'גינס בגיזרת סקיני', 1, 4, 2, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1601, 'גינס ווש בגיזרת Slim', 1, 4, 2, 100, 159.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1602, 'גינס חלק בגיזרת סקיני', 1, 4, 2, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1603, 'גינס ארוך בגיזרה ישרה', 1, 4, 2, 100, 139.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1604, 'גינס קצר עם עיטורי הבהרות', 1, 4, 2, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1605, 'גינס קצר עם כיסים', 1, 4, 2, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1606, 'גינס ווש קצר', 1, 4, 2, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1607, 'גינס ברמודה קצר', 1, 4, 2, 100, 159.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1608, 'גקט גינס עם כיסים', 1, 7, 2, 100, 159.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1609, 'גקט קפוצון קולור בלוק', 1, 7, 2, 100, 199.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1610, 'גקט אימון בשילוב קפוצון', 1, 7, 2, 100, 189.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1620, 'טי שירט קרופ אומברה מיקי מאוס', 1, 2, 3, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1621, 'טי שירט טאי דאי עם הדפס', 1, 2, 3, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1622, 'טי שירט עם הדפס Rolling Stones', 1, 2, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1623, 'חולצת קרופ עם תחרה', 1, 2, 3, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1624, 'טי שירט קרופ עם הדפס כיתוב', 1, 2, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1625, 'טי שירט קרופ עם הדפס טניס', 1, 2, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1626, 'טי שירט קרופ עם הדפס Friends', 1, 2, 3, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1627, 'טי שירט ריב עם הדפס כיתוב', 1, 2, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1628, 'טי שירט עם הדפס דיסני', 1, 2, 3, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1629, 'טי שירט טאי דאי קרופ סטיץ', 1, 2, 3, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1630, 'מכנסיים קצרים בהדפס טאי דאי', 1, 3, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1631, 'מכנסיים קצרים בהדפס באגס באני', 1, 3, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1632, 'מכנסי טרנינג ארוכים', 1, 3, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1633, 'מכנסי טרנינג קצרים', 1, 3, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1634, 'טיץ 7/8 בהדפס', 1, 3, 3, 100, 49.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1635, 'מכנסיים קצרים עם שוליים מודגשים', 1, 3, 3, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1636, 'טיץ קצר בהדפס בנות', 1, 3, 3, 100, 39.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1637, 'מכנסי טרנינג קצרים בהדפס', 1, 3, 3, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1638, 'מכנסיים ארוכים בטקסטורת פסים', 1, 3, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1640, 'מכנסי גינס קצרים עם גומי', 1, 4, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1641, 'גינס קצרים בהדפס חרציות', 1, 4, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1642, 'גינס קצר עם קיפול', 1, 4, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1643, 'מכנסי גינס ווש קצרים', 1, 4, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1644, 'גינס קצרים עם סיומת גזורה', 1, 4, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1650, 'שמלת קומות בהדפס פרחים', 1, 5, 3, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1651, 'שמלת טול קומות', 1, 5, 3, 100, 119.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1652, 'שמלת קומות שרוול', 1, 5, 3, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1653, 'שמלת קומות בהדפס עלים', 1, 5, 3, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1654, 'שמלה בהדפס פחיות', 1, 5, 3, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1655, 'שמלת קומות בשילוב כיווצים', 1, 5, 3, 100, 149.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1660, 'חצאית קומות בהדפס פרחים', 1, 6, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1661, 'חצאית קומות בהדפס עלים', 1, 6, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1662, 'חצאית עם עיטורי רקמת פרחים', 1, 6, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1663, 'חצאית קומות בהדפס חרציות', 1, 6, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1664, 'חצאית מיני בהדפס פרחים', 1, 6, 3, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1700, 'טי שירט בהדפס אוטובוס', 1, 2, 4, 100, 39.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1701, 'חולצת פולו קולורבלוק', 1, 2, 4, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1702, 'חולצת פולו בהדפס פסים', 1, 2, 4, 100, 69.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1703, 'טי שירט בהדפס טאי דאי', 1, 2, 4, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1704, 'טי שירט עם הדפס', 1, 2, 4, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1705, 'טי שירט עם כיס', 1, 2, 4, 100, 59.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1720, 'מכנסי ברמודה עם כיסים', 1, 3, 4, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1721, 'מכנסי טרנינג עם כיסים', 1, 3, 4, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1722, 'מכנסי טרנינג עם הדפס', 1, 3, 4, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1723, 'מכנסי ברמודה בהדפס קיץ', 1, 3, 4, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1724, 'מכנסי ברמודה בהדפס דקלים', 1, 3, 4, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1725, 'מכנסי גלישה בהדפס גולשים', 1, 3, 4, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1726, 'מכנסי טרנינג ברמודה', 1, 3, 4, 100, 79.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1727, 'מכנסי צינו ארוכים', 1, 3, 4, 100, 129.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1728, 'מכנסי ברמודה עם גומי', 1, 3, 4, 100, 89.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1740, 'גינס ברמודה עם קיפול', 1, 4, 4, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1741, 'גינס ברמודה ווש עם סיומת קיפול', 1, 4, 4, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1742, 'גינס ברמודה ווש עם סיומת פרומה', 1, 4, 4, 100, 99.90 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (1743, 'גינס ווש עם כיתוב', 1, 4, 4, 100, 79.90 );
-- פול אנד בר
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2001,'טי שירט עם הדפס סרט מצויר', 2, 2, 1, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2002,'טי שירט בסגנון קולז עם כיתוב', 2, 2, 1, 80, 65.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2003,'טי שירט עם הדפס Stranger Things', 2, 2, 1, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2004,'טי שירט cropped עם צווארון V', 2, 2, 1, 80, 45.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2005,'טי שירט לוס אנגלס', 2, 2, 1, 80, 89.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2006,'טי שירט עם שרוולים קצרים והדפס', 2, 2, 1, 80, 35.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2007,'טי שירט BURGER KING', 2, 2, 1, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2008,'טי שירט עם כיתוב משולב', 2, 2, 1, 80, 35.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2010,'מכנסי דגמח', 2, 3, 1, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2011,'מכנסיים מתרחבים בגיזרה נמוכה', 2, 3, 1, 80, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2012,'מכנסיים עם הדפס פרחים', 2, 3, 1, 80, 159.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2013,'מכנסיים מבד rustic בגזרה רפויה', 2, 3, 1, 80, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2014,'מכנסי דגמח straight fit', 2, 3, 1, 80, 159.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2015,'מכנסיים אלגנטיים בסגנון גאוצו', 2, 3, 1, 80, 159.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2016,'מכנסי קורדרוי בגיזרה מתרחבת', 2, 3, 1, 80, 159.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2017,'מכנסיים בגיזרה רפויה עם קשירה', 2, 3, 1, 80, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2018,'מכנסיים עם פסים צבעוניים', 2, 3, 1, 80, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2019,'מכנסיים עם הדפס בסגנון רטרו', 2, 3, 1, 80, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2020, 'גינס HIGH WAIST בגזרה ישרה', 2, 4, 1, 100, 199.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2021, 'גינס mom fit basic', 2, 4, 1, 100, 119.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2022, 'מכנסי גינס high weist', 2, 4, 1, 100, 159.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2023, 'מכנסי mom fit בגזרת slim fitfit', 2, 4, 1, 100, 119.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2024, 'גינס mid waist בגזרה ישרה', 2, 4, 1, 100, 159.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2025, 'גינס super high waist', 2, 4, 1, 100, 139.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2026, 'גינס wide leg', 2, 4, 1, 100, 159.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2027, 'גינס straight fit high west', 2, 4, 1, 100, 199.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2028, 'גינס wide leg בגזרת high west', 2, 4, 1, 100, 199.00 );
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2030,'שימלה ארוכה מבד rustic', 2, 5, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2031,'שימלה ארוכה עם כתפיות דקות', 2, 5, 1, 100, 169.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2032,'שימלה קצרה פרחונית עם קיפול', 2, 5, 1, 100, 149.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2033,'שימלה עם הדפס וכתפיות', 2, 5, 1, 100, 129.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2034,'שימלת בלרינה קצרה עם הדפס צבעוני', 2, 5, 1, 100, 129.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2035,'שימלה קצרה עטופה', 2, 5, 1, 100, 129.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2036,'שימלה ארוכה עם הדפס', 2, 5, 1, 100, 169.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2037,'שימלה קצרה צבעונית בצבע כחול', 2, 5, 1, 100, 149.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2038,'שימלה עם מחשוף V', 2, 5, 1, 100, 149.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2039,'שימלה באורך מידי עם הדפס', 2, 5, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2060,'עליונית BASIC עם כפתורים', 2, 7, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2061,'זקט בסגנון פועלים עם כיסים קדמיים', 2, 7, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2062,'זקט חתוך עם גימור פרום', 2, 7, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2063,'עליונית גינס', 2, 7, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2064,'זקט קליל קצר', 2, 7, 1, 100, 129.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2065,'זקט גינס בסגנון וינטאג', 2, 7, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2066,'בלייזר מכופתר דמוי עור', 2, 7, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2067,'גקט בסגנון פועלים עם תפירה גלויה', 2, 7, 1, 100, 259.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2068,'עליונית דמוי עור עם כיס', 2, 7, 1, 100, 169.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2069,'גקט מרופד עם כיסים', 2, 7, 1, 100, 199.00); 
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2070,'טי שירט עם הדפס דמעות מנדלה', 2, 2, 2, 80, 89.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2071,'טי שירט פסים עם שרוול ארוך', 2, 2, 2, 80, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2072,'טי שירט Nirvana בצבע ירוק', 2, 2, 2, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2073,'טי שירט עם הדפס בחזית', 2, 2, 2, 80, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2074,'טי שירט עם הדפס STWD', 2, 2, 2, 80, 89.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2075,'טי שירט כותנה עם הדפס', 2, 2, 2, 80, 69.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2076,'טי שירט Biggie', 2, 2, 2, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2077,'טי שירט Easy-e', 2, 2, 2, 80, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2078,'טי שירט Mona Lisa', 2, 2, 2, 80, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2100,'מכנסי טרנינג עם כיסים מרוכסנים', 2, 3, 2, 80, 149.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2101,'מכנסי דגמח מסריג דק', 2, 3, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2102,'מכנסי טרנינג באפקט דהוי', 2, 3, 2, 80, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2103,'מכנסי טרנינג Basic', 2, 3, 2, 80, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2104,'Basic slim fit מכנסי ', 2, 3, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2105,'מכנסיים מחיוטים בגירסה רפויה ', 2, 3, 2, 80, 169.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2106,'מכנסי Chions Basic', 2, 3, 2, 80, 149.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2107,'מכנסי טרנינג עם עיטורים', 2, 3, 2, 80, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2110,'גינס carrot fit', 2, 4, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2111,'גינס straight fit', 2, 4, 2, 80, 259.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2112,'גינס slim fit עם קרעים', 2, 4, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2113,'גינס slim fit', 2, 4, 2, 80, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2114,'גינס סקיני עם קרעים', 2, 4, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2115,'גינס בייסיק סקיני', 2, 4, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2116,'גינס slim fit comfort', 2, 4, 2, 80, 149.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2117,'גינס בגיזרה רפויה', 2, 4, 2, 80, 169.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2118,'גינס סופר סקיני', 2, 4, 2, 80, 189.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2130,'גקט גינס בייסיק', 2, 7, 2, 80, 169.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2131,'גקט Tampa Bay', 2, 7, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2132,'עליונית קלילה מבד דמוי זמש', 2, 7, 2, 80, 149.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2133,'זקט NFL Miami Dolphins', 2, 7, 2, 80, 269.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2134,'זקט בייסיק עם קפוצון', 2, 7, 2, 80, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2135,'זקט בסגנון קולאז', 2, 7, 2, 80, 169.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2136,'זקט Bomber מרופד עם כיסים', 2, 7, 2, 80, 229.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (2137,'זקט גינס מרופד', 2, 7, 2, 80, 249.90);
-- הודיס
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3000,'חולצה דגם ליאנה', 3, 2, 1, 80, 59.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3001,'טי שירט מודפס', 3, 2, 1, 80, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3002,'חולצה דגם יוליה', 3, 2, 1, 80, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3003,'חולצה חתוכה V', 3, 2, 1, 80, 59.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3004,'טי שירט ירוקה', 3, 2, 1, 80, 49.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3005,'טי שירט poeple', 3, 2, 1, 80, 59.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3006,'טי שירט דגם מגנוליה', 3, 2, 1, 80, 29.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3010,'מכנסיים דגם גוליאן', 3, 3, 1, 80, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3011,'ברמודה Mom', 3, 3, 1, 80, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3012,'מכנס קצר דגם ליבי', 3, 3, 1, 80, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3013,'מכנס קצר דגם בילי', 3, 3, 1, 80, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3014,'מכנס קצר עם הדפס', 3, 3, 1, 80, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3015,'מכנס טרנינג דגם פלאזה', 3, 3, 1, 80, 149.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3016,'מכנס טייץ קצר', 3, 3, 1, 80, 59.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3050,'חולצה מודפסת', 3, 2, 2, 80, 59.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3051,'חולצה דגם ברוקלין', 3, 2, 2, 80, 69.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3052,'חולצה דגם כריש', 3, 2, 2, 80, 69.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3053,'חולצה דגם נירוונה', 3, 2, 2, 80, 69.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3054,'חולצה דגם בייסיק V', 3, 2, 2, 80, 59.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3055,'טי שירט עם כיתוב', 3, 2, 2, 80, 69.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3060,'מכנסי נבדה', 3, 3, 2, 80, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3061,'מכנסי קנטוקי', 3, 3, 2, 80, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3062,'מכנסי סן אנטוניו', 3, 3, 2, 80, 109.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3063,'מכנסי OAK', 3, 3, 2, 80, 79.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3064,'מכנסי אונטריו', 3, 3, 2, 80, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3070,'טי שירט מודפסת', 3, 2, 3, 80, 49.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3071,'טי שירט דגם אריאל', 3, 2, 3, 80, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3072,'טי שירט עם לימונים', 3, 2, 3, 80, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3073,'טי שירט אהבה', 3, 2, 3, 80, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3080,'שימלה עם פרחים', 3, 5, 3, 80, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3081,'שימלה עם פלמינגו', 3, 5, 3, 80, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3082,'שימלה עם הדפסה', 3, 5, 3, 80, 69.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3083,'שימלה ירוקה עם הדפסה', 3, 5, 3, 80, 69.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3090,'טי שירט כחולה מודפסת', 3, 2, 4, 80, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3091,'טי שירט ירוקה מודפסת', 3, 2, 4, 80, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3092,'טי שירט בייסיק V', 3, 2, 4, 80, 49.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3095,'מכנסיים עם שרוך', 3, 3, 4, 80, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (3096,'מכנסיים דגם אלון', 3, 3, 4, 80, 89.90)
-- זארה
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4000,'חולצת כיווצים וולנים בכתפיים', 4, 2, 1, 80, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4001,'חולצת צוארון תלתן', 4, 2, 1, 80, 169.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4002,'חולצה מבד חצי שקוף עם רקמה', 4, 2, 1, 80, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4003,'חולצה מסאטן עם שסעים', 4, 2, 1, 80, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4004,'חולצה עם קשרים', 4, 2, 1, 80, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4005,'חולצת פשתן עם כיס', 4, 2, 1, 80, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4010,'מכנסי סריג בגיזרת פעמון', 4, 3, 1, 80, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4011,'מכנסי מיני מתרחבים', 4, 3, 1, 80, 109.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4012,'מכנסי תערובת פשתן בגיזרה רפויה', 4, 3, 1, 80, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4013,'מכנסי טיץ משובצים', 4, 3, 1, 80, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4014,'מכנסי דגמח', 4, 3, 1, 80, 109.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4015,'מכנסי high west', 4, 3, 1, 80, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4050,'גינס mom fit', 4, 4, 1, 80, 169.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4051,'גינס חתוך בגיזרה מתרחבת', 4, 4, 1, 80, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4052,'גינס סקיני גבוה', 4, 4, 1, 80, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4053,'גינס mom fit rigid', 4, 4, 1, 80, 159.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4054,'גינס slim fit עם קרעים', 4, 4, 1, 80, 159.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4055,'גינס straight fit', 4, 4, 1, 80, 169.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4060,'שמלת מידי עם עיטור חרוזים', 4, 5, 1, 80, 349.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4061,'שמלת סאטן עם פתח', 4, 5, 1, 80, 249.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4062,'שמלה בסגנון מחוך', 4, 5, 1, 80, 209.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4063,'שמלה עם חיתוכים', 4, 5, 1, 80, 229.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4064,'שמלה עם שיבוץ אבנים בכתפיות', 4, 5, 1, 80, 329.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4065,'שמלה אלסטית עטופה', 4, 5, 1, 80, 219.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4070,'חצאית עפרון תערובת פשתן', 4, 6, 1, 80, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4071,'חצאית מיני עם תערובת פשתן וחרוזים', 4, 6, 1, 80, 169.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4072,'מכנסי חצאית אסימטריים', 4, 6, 1, 80, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4073,'חצאית מיני מוצלבת', 4, 6, 1, 80, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4074,'חצאית מיני עם כיווצים', 4, 6, 1, 80, 109.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4075,'חצאית מיני בסגנון עטוף', 4, 6, 1, 80, 109.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4076,'חצאית באורך ביניים עם קשר', 4, 6, 1, 80, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4100,'חולצת פשתן - כותנה', 4, 2, 2, 80, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4101,'חולצת פשתן מתערובת פשתן/כותנה', 4, 2, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4102,'חולצת פשתן/כותנה עם טקסטורה', 4, 2, 2, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4103,'חולצה בגיזרה אוברסייז', 4, 2, 2, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4104,'חולצת פסים', 4, 2, 2, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4105,'חולצת טוויל פרימיום', 4, 2, 2, 100, 269.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4106,'חולצה עם טקסטורה', 4, 2, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4107,'טי שירט בייסיק heavy weight', 4, 2, 2, 100, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4108,'טי שירט סריג עם הדפס משולב', 4, 2, 2, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4109,'טי שירט אוברסייז עם כיס', 4, 2, 2, 100, 169.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4110,'טי שירט בייסיק עם פסים', 4, 2, 2, 100, 79.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4111,'טי שירט עם מרקם', 4, 2, 2, 100, 109.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4112,'טי שירט עם הדפס כיתוב', 4, 2, 2, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4120,'מכנס טרנינג בייסיק', 4, 3, 2, 100, 159.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4121,'מכנסי Jogger עם פס בצד', 4, 3, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4122,'מכנסיים מחויטים פשתן', 4, 3, 2, 100, 269.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4123,'מכנסיים מפשתן ויסקוזה', 4, 3, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4124,'מכנסי דגמח כותנה פשתן', 4, 3, 2, 100, 239.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4125,'מכנסיים עם כפלים', 4, 3, 2, 100, 209.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4126,'מכנסי דגמח בגזרת flexed fit', 4, 3, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4127,'מכנסי דגמח מבד דנים רך', 4, 3, 2, 100, 269.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4130,'מכנסי גינס סייסיק סלים', 4, 4, 2, 100, 169.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4131,'מכנסי גינס cropped skinny', 4, 4, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4132,'מכנסי גינס basic straight', 4, 4, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4133,'מכנסי גינס basic skinny', 4, 4, 2, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4134,'מכנסי גינס low rise slim', 4, 4, 2, 100, 159.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4135,'מכנסי גינס ripped skinny', 4, 4, 2, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4136,'מכנסי גינס ripped slim', 4, 4, 2, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4140,'זקט Bomber Basic', 4, 7, 2, 100, 279.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4141,'זקט בומבר עם טלאים', 4, 7, 2, 100, 239.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4142,'זקט מתערובת צמר', 4, 7, 2, 100, 259.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4143,'זקט בומבר עם טקסטורה', 4, 7, 2, 100, 239.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4144,'זקט עם כיסים', 4, 7, 2, 100, 269.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4145,'זקט עם פסים', 4, 7, 2, 100, 239.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4147,'זקט בומבר עם עיטור', 4, 7, 2, 100, 299.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4148,'זקט עם משבצות', 4, 7, 2, 100, 329.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4200,'טי שירט הוואי', 4, 2, 3, 100, 49.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4201,'טי שירט היביסקוס', 4, 2, 3, 100, 49.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4202,'טי שירט חתוכה בעיצוב חלק', 4, 2, 3, 100, 39.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4203,'טי שירט חלקה', 4, 2, 3, 100, 39.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4204,'טי שירט Havadar University', 4, 2, 3, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4205,'טי שירט Lily', 4, 2, 3, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4206,'טי שירט בעיצוב פרחוני', 4, 2, 3, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4207,'טי שירט עם הדפס', 4, 2, 3, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4208,'טי שירט Happy', 4, 2, 3, 100, 49.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4210,'מכנסי חצאית מפשתן', 4, 3, 3, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4211,'מכנסיים עם כפלים', 4, 3, 3, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4212,'מכנסיים פרחוניים עם גיזרה רפויה', 4, 3, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4213,'מכנסיים משובצים', 4, 3, 3, 100, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4214,'מכנסיים רחבים עם הדפס', 4, 3, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4215,'מכנסיים משוחררים עם טקסטורה', 4, 3, 3, 100, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4216,'מכנסי כותנה ופשתן פרחוניים', 4, 3, 3, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4220,'גינס עם עיצוב', 4, 4, 3, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4221,'גינס straight fit', 4, 4, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4222,'גינס straight fit עם כפתורים', 4, 4, 3, 100, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4223,'גינס extreme wide leg', 4, 4, 3, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4224,'גינס מתרחב', 4, 4, 3, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4225,'גינס מתרחב עם תפר מודגש', 4, 4, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4226,'גינס slim fit', 4, 4, 3, 100, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4227,'גינס סקיני', 4, 4, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4230,'שימלה עם ריקמה', 4, 5, 3, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4231,'שימלה עם טקסטורה ופתחים', 4, 5, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4232,'שימלה בסגנון סרבל', 4, 5, 3, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4233,'שימלת סריג עם יהלומים', 4, 5, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4234,'שימלה בדוגמת קולור בלוק', 4, 5, 3, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4235,'שימלת אינדיגו עם פתח', 4, 5, 3, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4236,'שימלת זקארד', 4, 5, 3, 100, 159.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4237,'שימלת עם פסים', 4, 5, 3, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4238,'שימלת פתחים עם עיטורים', 4, 5, 3, 100, 199.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4240,'חצאית עם כפלים ואבזם', 4, 6, 3, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4241,'חצאית משולבת ריקמה', 4, 6, 3, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4242,'חצאית באורך ביניים עם טקסטורה', 4, 6, 3, 100, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4243,'חצאית מידי פרחונית עם טקסטורה', 4, 6, 3, 100, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4244,'חצאית עם כפלים וגימור פרום', 4, 6, 3, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4245,'חצאית בעיצוב משובץ', 4, 6, 3, 100, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4250,'בלייזר פשתן חתוך', 4, 7, 3, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4251,'זקט דנים גדול', 4, 7, 3, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4252,'זקט ארוך', 4, 7, 3, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4253,'זקט גינס טאי דאי', 4, 7, 3, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4254,'זקט מרופד עם טקסטורה', 4, 7, 3, 100, 179.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4255,'וסט עם טקסטורה ושוליים פרומים', 4, 7, 3, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4260,'חולצת פולו בייסיק', 4, 2, 4, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4261,'טי שירט ספורטיבית עם הדפס גרפיטי', 4, 2, 4, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4262,'טי שירט עם כיס', 4, 2, 4, 100, 69.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4263,'טי שירט עם פסים', 4, 2, 4, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4264,'טי שירט עם הדפס גרפיטי', 4, 2, 4, 100, 49.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4265,'טי שירט spary', 4, 2, 4, 100, 39.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4266,'טי שירט עם הדפס טאי דאי', 4, 2, 4, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4267,'טי שירט טוקיו פרימיום', 4, 2, 4, 100, 49.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4268,'טי שירט משולב', 4, 2, 4, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4270,'מכנסי ברמודה עם תוית', 4, 3, 4, 100, 59.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4271,'מכנסי ברמודה ספורטיבים עם הדפס', 4, 3, 4, 100, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4272,'מכנסי ברמודה עם הדפס פסיכדלי', 4, 3, 4, 100, 79.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4273,'מכנסי ברמודה סופר סטרץ', 4, 3, 4, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4274,'מכנסי ברמודה עם הדפס כיתוב', 4, 3, 4, 100, 69.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4275,'מכנסי ברמודה עם הדפס עץ דקל', 4, 3, 4, 100, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4280,'גינס סקיני', 4, 4, 4, 100, 89.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4281,'גינס straight fit', 4, 4, 4, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4282,'גינס חתוך relaxed fit', 4, 4, 4, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4283,'גינס relaxed fit', 4, 4, 4, 100, 129.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4284,'גינס relaxed fit עם צביעה', 4, 4, 4, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4285,'גינס relaxed fit wash', 4, 4, 4, 100, 119.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4286,'גינס The Bleach Authentic', 4, 4, 4, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4287,'גינס Loose Fitting', 4, 4, 4, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4288,'גינס סופר סטרץ', 4, 4, 4, 100, 99.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4290,'גקט ניילון Keep Ready', 4, 7, 4, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4291,'גקט מרופד בדוגמת יהלומים', 4, 7, 4, 100, 149.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4292,'בלייזר בייסיק', 4, 7, 4, 100, 249.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4293,'מעיל רוח מודפס', 4, 7, 4, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4294,'מעיל רוח משולב', 4, 7, 4, 100, 159.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4295,'זקט כותנה', 4, 7, 4, 100, 139.90)
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (4296,'זקט קל משולב', 4, 7, 4, 100, 149.90)
-- עדיקה
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (5000, 'מכנסי טרנינג BYE דיטייל רקום', 5, 3, 1, 95, 79.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (5001,'מכנסי טרנינג טאי-דאי ספלאש', 5, 3, 1, 98, 99);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (5002,'טי-שירט ווש WHATEVER', 5, 2, 1, 5, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (5003,'טי-שירט אוברסייז PALM SPRINGS', 5, 2, 1, 94, 79);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (5004,'סווטשירט אול-סקוורס טקסטורה צמרירית', 5, 7, 3, 92, 129);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (5005,'מכנסי טרנינג סקרלט', 5, 3, 3, 194, 89);
-- אייץ אנד אם
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6000,'חולצת כותנה עם כיס', 6, 2, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6001,'חולצה משובצת', 6, 2, 1, 500, 119.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6002,'חולצה מכופתרת עם פסים', 6, 2, 1, 500, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6003,'חולצה עם מלמלה', 6, 2, 1, 500, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6004,'חולצה פרחונית', 6, 2, 1, 500, 119.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6005,'חולצת Cropped', 6, 2, 1, 500, 149.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6006,'חולצה מנומרת', 6, 2, 1, 500, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6007,'טי שירט הדפס קצרה', 6, 2, 1, 500, 69.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6010,'מכנס מתרחב', 6, 3, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6011,'מכנס דגמח קצר', 6, 3, 1, 500, 119.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6012,'מכנס רחב עם פסים', 6, 3, 1, 500, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6013,'מכנס קצר עם שרוך', 6, 3, 1, 500, 59.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6014,'מכנס דגמח ברמודה', 6, 3, 1, 500, 129.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6020,'גינס רחב עם שסע', 6, 4, 1, 500, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6021,'גינס קצר חתוך', 6, 4, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6022,'גינס מתרחב עם קרעים', 6, 4, 1, 500, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6023,'גינס ברמודה', 6, 4, 1, 500, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6024,'גינס קצר נמוך', 6, 4, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6025,'גינס ארוך קרעים', 6, 4, 1, 500, 159.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6026,'גינס קצר קרעים', 6, 4, 1, 500, 139.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6040,'שימלה שחורה עם עיטורים', 6, 5, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6041,'שימלת תחרה', 6, 5, 1, 500, 119.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6042,'שימלת מיני', 6, 5, 1, 500, 89.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6043,'שימלה עם קשירה', 6, 5, 1, 500, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6044,'שימלת מיני משובצת', 6, 5, 1, 500, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6045,'שימלה פרחונית עם X', 6, 5, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6046,'שימלה עם טקסטורת פסים', 6, 5, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6047,'שימלה קלאסית', 6, 5, 1, 500, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6048,'שימלה דגם נסיכה', 6, 5, 1, 500, 139.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6060,'חצאית מידי עם שסע', 6, 6, 1, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6061,'חצאית מדרגה', 6, 6, 1, 500, 119.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6063,'חצאית מיני מתרחבת', 6, 6, 1, 500, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6064,'חצאית גינס', 6, 6, 1, 500, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6065,'חצאית ארוכה', 6, 6, 1, 500, 89.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6066,'חצאית ארוכה עם קשירה', 6, 6, 1, 500, 109.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6070,'חולצה מכופתרת קלאסית', 6, 2, 2, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6071,'חולצת פסים מכופתרת', 6, 2, 2, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6072,'חולצה מכופתרת עם כיס', 6, 2, 2, 500, 119.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6073,'חולצה משובצת', 6, 2, 2, 500, 99.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6074,'חולצת מכופתרת עם הדפס', 6, 2, 2, 500, 119.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6075,'חולצה עם הדפס', 6, 2, 2, 500, 99.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6076,'מכנס דגמח קצר', 6, 3, 2, 500, 109.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6077,'מכנס דגמח ארוך', 6, 3, 2, 500, 149.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6078,'מכנס ארוך קלאסי', 6, 3, 2, 500, 179.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6079,'מכנס ארוך משובץ', 6, 3, 2, 500, 119.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6080,'גינס ברמודה עם קרעים', 6, 4, 2, 500, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6081,'גינס ארוך עם קרעים', 6, 4, 2, 500, 139.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6082,'גינס ארוך סקיני', 6, 4, 2, 500, 129.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6083,'גינס ארוך ישר', 6, 4, 2, 500, 149.90);

INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6090,'גקט משובץ', 6, 7, 2, 500, 199.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6091,'גקט קורדרוי עם כיס', 6, 7, 2, 500, 209.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6092,'גקט עם רוכסן', 6, 7, 2, 500, 219.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6093,'גקט גינס משולב', 6, 7, 2, 500, 189.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6094,'גקט עם כיסים', 6, 7, 2, 500, 239.90);
INSERT INTO Products (ProductID, ProductName, ShopID, ProductTypeID, AgeProductTypeID, CountProductInShop, ProductPrice)
VALUES (6095,'גקט משובץ ארוך', 6, 7, 2, 500, 259.90);
GO
GO

--UPDATE Shop set ShopManagerID = 1 
--Where ShopID = 5;

--Scaffold-Dbcontext "Server=localhost\sqlexpress03;Database=QuickDelivery;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models –force


