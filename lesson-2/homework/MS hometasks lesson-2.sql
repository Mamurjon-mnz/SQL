1.--	Employees номли жадвал яратинг, устунлар: EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2)

create table Employees(EmpID  int, Name VARCHAR(50),Salary DECIMAL(10,2))

select* from Employees

2.-----	Employees жадвалига турли усулларда учта ёзув киритинг (бир қаторли INSERT ва кўп қаторли INSERT).

insert into Employees values(1, 'Neymar', 15000)
insert into Employees values(2, 'Suares', 11000)
insert into Employees values(3, 'Iniesta', 14000)

3.---	EmpID = 1 бўлган ходимнинг Salary қийматини 7000 га янгиланг (UPDATE).

update Employees
set Salary = 7000
where EmpID = 1

4.----	EmpID = 2 бўлган ёзувни Employees жадвалидан ўчиринг (DELETE)

delete Employees
where EmpID = 2

select* from Employees

5.---	DELETE, TRUNCATE ва DROP ўртасидаги фарқни қисқача таърифланг.

DELETE- жадваллардаги сатрларни ўчиради, where билан айнан сўралган сатрни усиз барчасини ўчиради

TRUNCATE- жадвалнинг барча сатрларини бирданига ўчириб тозалаб ташлайди

DROP- жадвални бутунлай ўчириб тозалаб ташлайди. сатрларини ҳам устунларини ҳам қўшиб ўчириб ташлайди

6.----	Employees жадвалидаги Name устуни типини VARCHAR(100) га ўзгартиринг




alter table Employees
alter column Name VARCHAR(100)

select* from Employees

7.---	Employees жадвалига Department (VARCHAR(50)) номли янги устун қўшинг.

alter table Employees
add Department varchar(50) 

8.---	Salary устунининг маълумот турини FLOAT га ўзгартиринг.


ALTER TABLE dbo.Employees
ALTER COLUMN Salary FLOAT 

9.---	Departments номли яна бир жадвал яратинг, устунлар: DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50)

create table Departments(DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50),Salary DECIMAL(10,2))
select* from Departments

10.---	Employees жадвалининг структурасини сақлаган ҳолда барча ёзувларни олиб ташланг (яъни жадвални ўчирмасдан “бўшатинг”).

select* from Employees

TRUNCATE table Employees




---Ўрта даража топшириқлари (6 та)--
1.---	Departments жадвалига INSERT INTO … SELECT усулида бешта ёзув киритинг (маълумотни ихтиёрингизга кўра ёзинг).

select* from Departments

insert into Departments values(10, 'Finance',6000)
insert into Departments values(20, 'Trade',7000)
insert into Departments values(30, 'Industry', 4000)
insert into Departments values(40, 'Construction', 3500)
insert into Departments values(50, 'Service', 8000)

2.---	Маоши 5000 дан юқори бўлган барча ходимлар учун Department қийматини 'Management' қилиб янгиланг.

update dbo.Departments
set DepartmentName = 'Management'
where Salary > 5000;

3.--	Employees жадвалидан барча ходимларни олиб ташлайдиган, аммо жадвал тузилмасини сақлаб қоладиган сўров ёзинг.



select* from Employees

truncate table dbo.Employees

4.----	Employees жадвалидан Department устунин и ўчиринг (DROP COLUMN)

select* from Employees

alter table Employees
drop column Department

5.---	Employees жадвали номини StaffMembers деб ўзгартиринг (SQL буйруқлари орқали)

sp_rename 'Employees', 'StaffMembers'
select* from StaffMembers

6.---	Departments жадвалини базадан бутунлай олиб ташланг (DROP TABLE)

drop table Departments

 -----Юқори даража топшириқлари (9 та)----
1.----Products номли жадвал яратинг; камида 5 та устун бўлсин, жумладан:
--ProductID (PRIMARY KEY),
--ProductName VARCHAR,
--Category VARCHAR,
--Price DECIMAL.

create table Products(ProductID int PRIMARY KEY,ProductName VARCHAR(50),Category VARCHAR(30),Price DECIMAL(10,2))

select* from Products

alter table Products
alter column Price decimal(10,2) not null

alter table Products
add constraint CK_Pruducts_Price_Positive
check (Price>0)

insert into Products values(10, 'food','low',-1)

3.---	Жадвалга StockQuantity номли устун қўшинг ва унинг DEFAULT қийматини 50 қилинг

alter table Products
add StockQuantity INT not null
    constraint DF_Products_StockQuantity DEFAULT (50)

4.--	Category устуни номини ProductCategory деб ўзгартиринг.


sp_rename 'Products.Category', 'ProductCategory', 'column'

select* from Products

5.---	Products жадвалига оддий INSERT INTO сўровлари билан 5 та ёзув киритинг.

insert into Products values(10, 'fruits','food',6000, 25)
insert into Products values(20, 'alcagol','beverages',7000, 35)
insert into Products values(30, 'tabacco','unfood', 4000, 15)
insert into Products values(40, 'milk','food', 3500, 10)
insert into Products values(50, 'potato','food', 8000, 50)

6.---SELECT INTO орқали Products маълумотларининг нусхасини сақлайдиган Products_Backup номли захира жадвал яратинг

select *
into Products_Backup
from Products

select* from Products_Backup

7.---	Products жадвали номини Inventory деб ўзгартиринг.

sp_rename 'Products', 'Inventory'

select* from Inventory

8.---Inventory жадвалидаги Price устуни турини DECIMAL(10,2) дан FLOAT га алмаштиринг

alter table Inventory
alter column Price float not null;  -- ёки NULL, талабга қараб

9.---Inventory жадвалига IDENTITY устуни қўшинг: номи ProductCode, бошланиши 1000, қадам +5 (масалан: 1000, 1005, 1010, …).

alter table Inventory
add ProductCode int IDENTITY(1000, 5) not null

