

----1. Икки жадвални бирлаштириш
----Жадваллар: Person, Address
---Вазифа: Person жадвалидаги ҳар бир шахс учун firstName, lastName, city, state ни қайтаринг. Агар ўша personId учун Address жадвалида манзил бўлмаса, city ва state учун NULL чиқсин.

Create table Person (personId int, firstName varchar(255), lastName varchar(255))

Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

SELECT
  p.firstName,
  p.lastName,
  a.city,
  a.[state]
FROM Person  AS p
LEFT JOIN Address AS a
  ON a.personId = p.personId
ORDER BY p.personId;

---2. Менежеридан кўпроқ маош олувчи ходимлар
---Жадвал: Employee(id, name, salary, managerId)
---Вазифа: Маоши ўз менежерикидан кўпроқ бўлган ходимларни топинг.
---Натижа: фақат Employee (name) устуни.

Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

SELECT e.name AS Employee
FROM Employee AS e
JOIN Employee AS m
  ON m.id = e.managerId
WHERE e.salary > m.salary
ORDER BY e.name;



---3. Дубликат (такрорий) e-mail’лар
---Жадвал: Person(id, email) — email NULL эмас, барча кичик ҳарфда.
---Вазифа: Такрорланган e-mail манзилларни қайтаринг.
---Натижа: Email устуни (масалан, a@b.com икки марта учрагани учун чиқади).

IF OBJECT_ID('dbo.PersonEmail','U') IS NOT NULL
    DROP TABLE dbo.PersonEmail;

CREATE TABLE dbo.PersonEmail (
    id    INT         NOT NULL PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

INSERT INTO dbo.PersonEmail (id, email) VALUES
(1, 'a@b.com'),
(2, 'c@d.com'),
(3, 'a@b.com');

select*from dbo.PersonEmail 

SELECT email AS [Email]
FROM dbo.PersonEmail
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY email;

----4. Дубликат e-mail’ларни ўчириш
----Жадвал: Person(id, email)
----Вазифа: Барча такрорий e-maillar’ни DELETE қилинг, ҳар бир уникал e-mail учун энг кичик id қолсин.

;WITH d AS (
    SELECT
        id,
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
    FROM dbo.PersonEmail
)
DELETE FROM d
WHERE rn > 1;
SELECT * FROM dbo.PersonEmail ORDER BY id;


---5. Фақат қизлари бор ота-оналар
---Жадваллар: boys(Id, name, ParentName), girls(Id, name, ParentName)
---Вазифа: Фақат қизлари бор (ўғли йўқ) ота-оналарни топинг.
---Натижа: Фақат ParentName (ота-она номи).

Return Parent Name only.

CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');


SELECT DISTINCT g.ParentName
FROM girls AS g
WHERE NOT EXISTS (
  SELECT 1
  FROM boys AS b
  WHERE b.ParentName = g.ParentName
)
ORDER BY g.ParentName;

---6. “50 дан ортиқ оғирлик ва энг кичик вазн”
---Манба: TSQL2012 базаси, Sales.Orders жадвали
---Вазифа: Вазни 50 дан юқори бўлган буюртмалар учун харидор кесимида жами Sales amount ни ва шу харидорнинг энг кичик вазнини чиқаринг.

IF OBJECT_ID('dbo.L12_OrderDetails','U') IS NOT NULL DROP TABLE dbo.L12_OrderDetails;
IF OBJECT_ID('dbo.L12_Orders','U')       IS NOT NULL DROP TABLE dbo.L12_Orders;
IF OBJECT_ID('dbo.L12_Customers','U')    IS NOT NULL DROP TABLE dbo.L12_Customers;

/* --- 2) Jadvallarni yaratish --- */
CREATE TABLE dbo.L12_Customers
(
    custid       INT           NOT NULL PRIMARY KEY,
    companyname  NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.L12_Orders
(
    orderid    INT            NOT NULL PRIMARY KEY,
    custid     INT            NOT NULL,
    orderdate  DATE           NOT NULL,
    freight    DECIMAL(12,2)  NOT NULL,
    CONSTRAINT FK_L12_Orders_Customers
        FOREIGN KEY (custid) REFERENCES dbo.L12_Customers(custid)
);

CREATE TABLE dbo.L12_OrderDetails
(
    orderid    INT            NOT NULL,
    productid  INT            NOT NULL,
    qty        INT            NOT NULL CHECK (qty > 0),
    unitprice  DECIMAL(12,2)  NOT NULL CHECK (unitprice >= 0),
    discount   DECIMAL(5,4)   NOT NULL CHECK (discount >= 0 AND discount <= 1),
    CONSTRAINT PK_L12_OrderDetails PRIMARY KEY (orderid, productid),
    CONSTRAINT FK_L12_OrderDetails_Orders
        FOREIGN KEY (orderid) REFERENCES dbo.L12_Orders(orderid)
);

/* --- 3) Ma'lumot kiritish --- */
INSERT INTO dbo.L12_Customers (custid, companyname) VALUES
(1, N'Contoso Ltd'),
(2, N'Northwind Traders'),
(3, N'Adventure Works');

INSERT INTO dbo.L12_Orders (orderid, custid, orderdate, freight) VALUES
(1001, 1, '2023-02-10',  45.00),  -- <= 50
(1002, 1, '2023-03-01',  55.00),  -- > 50
(1003, 1, '2023-03-15', 120.00),  -- > 50
(1004, 2, '2023-04-05',  75.50),  -- > 50
(1005, 2, '2023-04-18',  20.00),  -- <= 50
(1006, 3, '2023-05-01',  51.00);  -- > 50

INSERT INTO dbo.L12_OrderDetails (orderid, productid, qty, unitprice, discount) VALUES
(1001, 10,  2, 100.00, 0.00),
(1002, 11,  1, 200.00, 0.10),
(1002, 12,  3,  50.00, 0.00),
(1003, 13, 10,  20.00, 0.05),
(1004, 20,  4,  80.00, 0.00),
(1004, 21,  2, 120.00, 0.15),
(1005, 22,  1,  60.00, 0.00),
(1006, 30,  5,  40.00, 0.00);

/* --- 4) Vazifa yechimi (freight > 50 bo'lgandagi total va eng kichik freight) --- */
SELECT
  c.custid,
  c.companyname AS CustomerName,
  SUM(CASE WHEN o.freight > 50
           THEN od.qty * od.unitprice * (1 - od.discount)
           ELSE 0 END)                          AS TotalSales_Over50Freight,
  MIN(CASE WHEN o.freight > 50 THEN o.freight END) AS LeastFreight_Over50
FROM dbo.L12_Customers    AS c
JOIN dbo.L12_Orders       AS o  ON o.custid   = c.custid
JOIN dbo.L12_OrderDetails AS od ON od.orderid = o.orderid
GROUP BY c.custid, c.companyname
ORDER BY c.companyname;



---Жадваллар: Cart1(Item), Cart2(Item)
---Вазифа: Қуйидаги кутилган натижа каби икки саватни ёндош кўрсатинг: иккаласида ҳам борлар қарама-қарши қаторда бирга, фақат биттасида борлари эса бошқа тарафда бўш сақланади.

DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');

SELECT
  c1.Item AS [Item Cart 1],
  c2.Item AS [Item Cart 2]
FROM Cart1 AS c1
FULL OUTER JOIN Cart2 AS c2
  ON c2.Item = c1.Item
ORDER BY
  CASE WHEN c1.Item IS NOT NULL THEN 0 ELSE 1 END,
  COALESCE(c1.Item, c2.Item);

---8. Ҳеч нарса буюртма қилмаган мижозлар
---Жадваллар: Customers(id, name), Orders(id, customerId)
---Вазифа: Ҳеч қандай буюртма бермаган мижозларни топинг.
---Натижа: Customers (name) устунида ихтиёрий тартиб.


-- Tozalash (agar oldin mavjud bo'lsa)
IF OBJECT_ID('dbo.Orders','U')    IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Customers','U') IS NOT NULL DROP TABLE dbo.Customers;

-- Jadval yaratish
CREATE TABLE dbo.Customers (
    id   INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE dbo.Orders (
    id         INT PRIMARY KEY,
    customerId INT NOT NULL
        REFERENCES dbo.Customers(id)
);

-- Ma'lumot kiritish
INSERT INTO dbo.Customers (id, name) VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');

INSERT INTO dbo.Orders (id, customerId) VALUES
(1, 3),
(2, 1);

-- 8-masala: Hech narsa buyurtma qilmagan mijozlar
SELECT c.name AS Customers
FROM dbo.Customers AS c
LEFT JOIN dbo.Orders AS o
  ON o.customerId = c.id
WHERE o.id IS NULL
ORDER BY c.name;


----Талабалар ва имтиҳонлар
---Жадваллар:
---•	Students(student_id, student_name)
---•	Subjects(subject_name)
---	Examinations(student_id, subject_name) — дубликатлар бўлиши мумкин
---Қоидалар: Ҳар бир талаба барча фанлардан имтиҳон топшириши керак (теорияда). Examinations жадвалида қайд этилган ҳар бир қатор — шу фан имтиҳонида қатнашганини билдиради.
---Вазифа: Ҳар бир талаба × фан жуфтлиги бўйича неча марта имтиҳонда қатнашганини санаб чиқаринг.


Create table Students (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))
Truncate table Students
insert into Students (student_id, student_name) values ('1', 'Alice')
insert into Students (student_id, student_name) values ('2', 'Bob')
insert into Students (student_id, student_name) values ('13', 'John')
insert into Students (student_id, student_name) values ('6', 'Alex')
Truncate table Subjects
insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')
Truncate table Examinations
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')


SELECT
  s.student_id,
  s.student_name,
  sub.subject_name,
  COUNT(e.subject_name) AS attended_exams
FROM Students  AS s
INNER JOIN Subjects AS sub
  ON 1 = 1
LEFT JOIN Examinations AS e
  ON e.student_id   = s.student_id
 AND e.subject_name = sub.subject_name
GROUP BY
  s.student_id, s.student_name, sub.subject_name
ORDER BY
  s.student_id, sub.subject_name;
