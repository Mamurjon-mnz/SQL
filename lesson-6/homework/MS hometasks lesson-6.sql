---Puzzle 1: Такрорланмас қийматларни топиш
---Савол: Икки устунга таянилган ҳолда такрорланмас (distinct) қийматларни топишнинг камида икки усулини тушунтиринг.
---Киритма жадвал (InputTbl):
--col1	col2
--a	b
--a	b
--b	a
--c	d
--c	d
--m	n
--n	m

CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

select *from InputTbl

SELECT DISTINCT
    CASE WHEN col1 <= col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 <= col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
ORDER BY col1, col2;

---Puzzle 2: Барча устунлари нол бўлган қаторларни олиб ташлаш
---Савол: Агар барча устунлар нол қийматга эга бўлса, у қаторни кўрсатмаслик керак. Бу ҳолда, маълумот танлашда 5-қаторни олиб ташлашимиз керак.
---Жадвал схемаси:

CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select*
from TestMultipleZero

SELECT *
FROM TestMultipleZero
WHERE ISNULL(A,0) <> 0
   OR ISNULL(B,0) <> 0
   OR ISNULL(C,0) <> 0
   OR ISNULL(D,0) <> 0;


SELECT *
FROM TestMultipleZero
WHERE ISNULL(A,0) + ISNULL(B,0) + ISNULL(C,0) + ISNULL(D,0) <> 0

---Puzzle 3: ID си тоқ бўлганларни топиш

CREATE TABLE section1(id INT, name VARCHAR(20));
INSERT INTO section1 VALUES 
(1, 'Been'),
(2, 'Roma'),
(3, 'Steven'),
(4, 'Paulo'),
(5, 'Genryh'),
(6, 'Bruno'),
(7, 'Fred'),
(8, 'Andro');

SELECT * from section1

SELECT id, name
FROM section1
WHERE id % 2 = 1;   -- тоқ ID

-----Puzzle 4: Энг кичик ID’га эга шахс (Puzzle 3 даги жадвалдан фойдаланинг)

SELECT * from section1


SELECT id, name
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);

----Puzzle 5: Энг катта ID’га эга шахс (Puzzle 3 даги жадвалдан фойдаланинг)

SELECT TOP (1) id, name
FROM section1
ORDER BY id DESC;   -- энг катта ID

SELECT id, name
FROM section1
WHERE id = (SELECT MAX(id) FROM section1);


----Puzzle 6: Номи b ҳарфи билан бошланадиган одамлар (Puzzle 3 даги жадвалдан фойдаланинг)

SELECT id, name
FROM section1
WHERE name LIKE 'b%';

SELECT id, name
FROM section1
WHERE name COLLATE Latin1_General_CI_AS LIKE 'b%';

SELECT id, name
FROM section1
WHERE LOWER(name) LIKE 'b%';

---Puzzle 7: Код таркибида сўзма-сўз пастки чизиқ _ (wildcard сифатида эмас) бўлган қаторларни қайтарувчи сўров ёзинг.

CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

SELECT* from ProductCodes

SELECT Code
FROM ProductCodes
WHERE Code LIKE '%[_]%';

SELECT Code
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';

SELECT Code
FROM ProductCodes
WHERE CHARINDEX('_', Code) > 0;
