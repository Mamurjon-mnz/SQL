----Осон даража топшириқлари (10 та)
1.---	BULK INSERT нима эканини таърифланг ва мақсадини тушунтиринг.


BULK INSERT — bu SQL Server’да ташқи файлдан (масалан, CSV/TSV/TXT) маълумотни жуда тез равишда жадвалга юклаш (импорт qilish) учун мўлжалланган T-SQL буйруғи

2----SQL Server’га импорт қилиш мумкин бўлган тўртта файл форматини сананг

--1 CSV (Comma-Separated Values)
--2 TSV/TXT (таб/белги билан ажратилган матн)
--3 Excel (XLS/XLSX)
--4 JSON — OPENJSON


3.---	Қуйидаги устунлар билан Products жадвалини яратинг:
--ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2))

create table Products( ProductID INT PRIMARY KEY, ProductName VARCHAR(50),Price DECIMAL(10,2))
select * from Products

4----Products жадвалига INSERT INTO орқали учта ёзув киритинг

insert into Products values (1000,'TV',5000)
insert into Products values (2000,'Air condition',6000)
insert into Products values (3000,'wash machine',7000)

5--NULL ва NOT NULL ўртасидаги фарқни тушунтиринг.

NULL — “номаълум/йўқ” қиймат. Бу 0 ёки бўш қатор ('') эмас; “маълум эмас” дегани.

NOT NULL — устунда ҳар бир қаторда қиймат бўлиши шарт. NULL’га рухсат йўқ дегани.

6.---Products жадвалида ProductName устунига UNIQUE чеклов қўшинг

alter table Products
add constraint UQ_Products_ProductName UNIQUE (ProductName)

insert into Products values (3000,'TV',8000)

7---SQL сўровида мақсадини тушунтирувчи изоҳ (comment) ёзинг.


1)--Бир қаторли изоҳ: -- ... (ўша қатор охиригача амал қилади)

2)--Кўп қаторли изоҳ (блок): /* ... */

8.	Products жадвалига CategoryID устунини қўшинг

alter table Products
add CategoryID int

select * from Products

9.----Categories жадвалини яратинг: CategoryID — PRIMARY KEY, CategoryName — UNIQUE

create table Categories( CategoryID INT PRIMARY KEY, CategoryName varchar(30) UNIQUE)
select * from Categories

10---IDENTITY устунининг SQL Server’даги мақсадини тушунтиринг

1) Автоматик ID бериш: ҳар бир янги сатр қўшилганда сервер устунга яна бир янги рақам ёзиб беради (қўлдан киритиш шарт эмас).

2) Ягоналик ва тартиб: кўп ҳолда PRIMARY KEY сифатида ишлатилади (бироқ UNIQUE/PK чекловини алоҳида қўйиш керак).

3) Тайёрлашни соддалаштириш: қатор қўшишда ID ҳақида ўйламайсиз — фокус бизнес маълумотда.


----Ўрта даража топшириқлари (10 та)---



1.---BULK INSERT орқали матн (text) файлидан маълумотни Products жадвалига импорт қилинг

--Импорт: CSV матн файлидан Products’га

create table Enterprises_1 (Id int, Name varchar(30), Salary int)
bulk insert Enterprises_1
from 'C:\Users\m.satimov\Desktop\Enterprises.txt'
with(
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n')
	select* from Enterprises_1

2.----Products жадвалида FOREIGN KEY яратинг ва у Categories жадвалига ишора қилсин.


----Categories жадвалида PRIMARY KEY борлигини кафолатлаймиз

alter table Products
add constraint FK_Products_Categories
    foreign key (CategoryID)
    references Categories (CategoryID)

3.----PRIMARY KEY ва UNIQUE KEY ўртасидаги фарқларни тушунтиринг

PRIMARY KEY (PK) — жадвалдаги ҳар бир сатрни ягона тарзда идентификациялайдиган майдон(лар). Жадвалда фақат битта PK бўлиши мумкин. PK майдон(лар) NOT NULL ва UNIQUE бўлиши шарт.

UNIQUE KEY (UQ) — устундаги (ёки устунлар тўпламидаги) қийматларни қайтарилмас қилади, лекин жадвалда бир нечта UNIQUE бўлиши мумкин.

4.---Products жадвалига CHECK (Price > 0) чекловини қўшинг

select* from Products

alter table Products
alter column Price decinal(10,2) NOT NULL

select * 
from Products
where Price <= 0 OR Price IS NULL

alter table Products
add constraint CK_Products_Price_Positive
    check (Price > 0)

5.---Products жадвалига Stock (INT, NOT NULL) устунини қўшинг.

alter table Products
add Stock INT not null
constraint DF_Products_Stock default (50);

6.---CategoryID устунидаги NULL қийматларни 0 билан алмаштириш учун ISNULL функциясидан фойдаланинг.


if not exists (select 1 from Categories where CategoryID = 0)
    insert into Categories(CategoryID, CategoryName)
    values (0, N'Uncategorized')

update p
set CategoryID = isnull(CategoryID, 0)
from Products AS p
where p.CategoryID IS NULL

7.----FOREIGN KEY чекловларининг мақсади ва қўлланишини тушунтиринг

Референциал яхлитлик (referential integrity) ни таъминлайди: бола жадвалдаги қийматлар албатта ота жадвалда мавжуд бўлиши керак.
Масалан, Products.CategoryID → Categories.CategoryID.

“Етим” (orphan) қаторларни олдини олади: Products’да 9999 категория кўрсатилса, Categories’да 9999 бўлмаса — FK бундай қаторга рухсат бермайди.

Маълумот сифати ва ишончлилигини оширади: хато ID’лар, чалкаш боғланишлар йўқолади

---Қийин даража топшириқлари (10 та)----

1.---Customers жадвали учун скрипт ёзинг: CHECK чеклови Age >= 18 бўлсин.

create table Customers(
    CustomerID INT           NOT NULL,
    Name       VARCHAR(100)  NOT NULL,
    Age        INT           NOT NULL,
    constraint PK_Customers PRIMARY KEY (CustomerID),
    constraint CK_Customers_Age_18 CHECK (Age >= 18))

select* from Customers

2.----IDENTITY устунига эга жадвал яратинг: бошланиши 100, қадами 10

create table Orders(
    OrderID int IDENTITY(100, 10) NOT NULL,  -- 100, 110, 120, ...
    CustomerName varchar(100) NOT NULL,
    OrderDate    DATETIME2     NOT NULL DEFAULT SYSDATETIME(),
    constraint PK_Orders PRIMARY KEY (OrderID))

select* from Orders

3.---Янги OrderDetails жадвалида композицион PRIMARY KEY (бир неча устундан) яратиш учун сўров ёзинг

create table OrderDetails(
    OrderID    INT        NOT NULL,
    ProductID  INT        NOT NULL,
    Quantity   INT        NOT NULL DEFAULT (1),
    UnitPrice  DECIMAL(10,2) NOT NULL,
    -- Композицион бирламчи калит:
    constraint PK_OrderDetails PRIMARY KEY (OrderID, ProductID))

select* from OrderDetails

4.---	COALESCE ва ISNULL функцияларидан NULL қийматларни бошқаришда фойдаланишни тушунтиринг

ISNULL(expr, replacement) — агар expr NULL бўлса, replacementни қайтаради; акс ҳолда expr. Фақат 2 та аргумент.

COALESCE(a, b, c, …) — рўйхатдаги биринчи NULL эмас қийматни қайтаради. Кўп аргумент қабул қилади.

5.---Employees жадвалини тузинг: EmpID — PRIMARY KEY, Email — UNIQUE KEY.

-- Жадвал яратиш
CREATE TABLE Employees(
    EmpID  INT          NOT NULL,
    Name   VARCHAR(100) NOT NULL,
    Email  VARCHAR(100) NULL,           -- NULL бўлиши мумкин
    CONSTRAINT PK_Employees PRIMARY KEY (EmpID),
    CONSTRAINT UQ_Employees_Email UNIQUE (Email)) -- Email такрорланмас

select* from Employees

6.----FOREIGN KEY ни ON DELETE CASCADE ва ON UPDATE CASCADE параметрлари билан яратиш учун сўров ёзинг

--Ота жадвал
CREATE TABLE Categories(
    CategoryID   INT          PRIMARY KEY,
    CategoryName VARCHAR(50)  NOT NULL
);

-- Бола жадвал: FK каскад билан
CREATE TABLE Products(
    ProductID    INT           PRIMARY KEY,
    ProductName  VARCHAR(50)   NOT NULL,
    CategoryID   INT           NULL,
    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES dbo.Categories(CategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE)

