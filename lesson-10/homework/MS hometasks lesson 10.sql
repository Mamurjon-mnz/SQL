

	-----Дарс 10: Жойнлар-----

----Осон даража (10 та)------

----1.	Employees ва Departments жадвалларидан фойдаланиб, маоши 50 000 дан юқори бўлган ходимлар номини ва уларнинг маошларини, шу билан бирга бўлим номларини қайтарувчи сўров ёзинг.

SELECT
  e.Name AS EmployeeName,
  e.Salary,
  d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 50000;



-------2.	Customers ва Orders жадвалларидан фойдаланиб, 2023-йилда берган буюртмалар учун мижозлар номлари ва буюртма саналарини чиқаринг.

SELECT
  c.FirstName,
  c.LastName,
  o.OrderDate
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2023-01-01'
  AND o.OrderDate <  '2024-01-01';


------3.	Employees ва Departments жадвалларидан фойдаланиб, барча ходимларни уларнинг бўлим номлари билан кўрсатинг. Бўлими йўқ ходимлар ҳам чиқсин.

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID;


------4.	Products ва Suppliers жадвалларидан фойдаланиб, барча етказиб берувчилар ва улар таъминлайдиган маҳсулотлар рўйхатини беринг. Ҳеч қандай маҳсулот таъминламайдиган етказиб берувчилар ҳам кўринсин.

SELECT
  s.SupplierName,
  p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON p.SupplierID = s.SupplierID
ORDER BY s.SupplierName, p.ProductName;


------5.	Orders ва Payments жадвалларидан фойдаланиб, барча буюртмалар ва уларнинг мос тўловларини қайтаринг. Тўловсиз буюртмалар ҳам, буюртмага уланмаган тўловлар ҳам чиқсин.

SELECT
  COALESCE(o.OrderID, p.OrderID) AS OrderID,
  o.OrderDate,
  p.PaymentDate,
  p.Amount
FROM Orders   o
FULL OUTER JOIN Payments p ON p.OrderID = o.OrderID
ORDER BY OrderID, PaymentDate;


------6.	Фақат Employees жадвали: ҳар бир ходимнинг ўз менежери номи билан бирга кўрсатинг.

SELECT
  e.Name  AS EmployeeName,
  m.Name  AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON m.EmployeeID = e.ManagerID;


------7.	Students, Courses ва Enrollments жадвалларидан фойдаланиб, 'Math 101' курсiga рўйхатдан ўтган талабалар номларини чиқаринг

SELECT
  s.Name AS StudentName,
  c.CourseName
FROM Enrollments e
INNER JOIN Students s ON s.StudentID = e.StudentID
INNER JOIN Courses  c ON c.CourseID  = e.CourseID
WHERE c.CourseName = 'Math 101';


------8.	Customers ва Orders жадвалларидан фойдаланиб, 3 тадан кўп бирлик билан буюртма берган мижозларни топинг. Улар номи ва буюртмадаги Quantity ни қайтаринг.

SELECT
  c.FirstName,
  c.LastName,
  o.Quantity
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;


------9.	Employees ва Departments жадвалларидан фойдаланиб, 'Human Resources' бўлимида ишлайдиган ходимларни рўйхат қилинг.

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Human Resources';


---------Ўрта даража (9 та)---

--------1.	Employees ва Departments жадвалларидан фойдаланиб, 5 тадан ортиқ ходимга эга бўлимлар номларини қайтаринг.

SELECT
  d.DepartmentName,
  COUNT(*) AS EmployeeCount
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(*) > 5;


---------2.	Products ва Sales жадвалларидан фойдаланиб, ҳеч қачон сотилмаган маҳсулотларни топинг.

SELECT
  p.ProductID,
  p.ProductName
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
WHERE s.ProductID IS NULL;


--------3.	Customers ва Orders жадвалларидан фойдаланиб, камида битта буюртма берган мижозлар номларини чиқаринг.

SELECT
  c.FirstName,
  c.LastName,
  COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY c.FirstName, c.LastName;



-------4.	Employees ва Departments жадвалларидан фойдаланиб, ходим ҳам, бўлим ҳам мавжуд бўлган (NULL’сиз) ёзувларнигина кўрсатинг.

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID;


------5.	Фақат Employees жадвали: бир хил менежерга ҳисобот берадиган ходим жуфтликларини топинг.

SELECT
  a.Name AS Employee1,
  b.Name AS Employee2,
  a.ManagerID
FROM Employees a
INNER JOIN Employees b
  ON a.ManagerID = b.ManagerID
 AND a.EmployeeID < b.EmployeeID
WHERE a.ManagerID IS NOT NULL;


------6.	Orders ва Customers жадвалларидан фойдаланиб, 2022-йилда берилган барча буюртмаларни мижоз номи билан бирга рўйхат қилинг.

SELECT
  o.OrderID,
  o.OrderDate,
  c.FirstName,
  c.LastName
FROM Orders o
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2022-01-01'
  AND o.OrderDate <  '2023-01-01';


------7.	Employees ва Departments жадвалларидан фойдаланиб, 'Sales' бўлимидан бўлиб, маоши 60 000 дан юқори бўлган ходимларни чиқаринг.

SELECT
  e.Name AS EmployeeName,
  e.Salary,
  d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Sales'
  AND e.Salary > 60000;


------8.	Orders ва Payments жадвалларидан фойдаланиб, тўлови мавжуд бўлган буюртмаларнигина қайтаринг.

SELECT
  o.OrderID,
  o.OrderDate,
  p.PaymentDate,
  p.Amount
FROM Orders o
INNER JOIN Payments p ON p.OrderID = o.OrderID;


-----9.	Products ва Orders жадвалларидан фойдаланиб, ҳеч қачон буюртма қилинмаган маҳсулотларни топинг.

SELECT
  p.ProductID,
  p.ProductName
FROM Products p
LEFT JOIN Orders o ON o.ProductID = p.ProductID
WHERE o.ProductID IS NULL;


----------Қийин даража (9 та)-----

-----1.	Фақат Employees жадвали: ўз бўлимидаги ўртача маошдан юқори маош оладиган ходимларни топинг.

SELECT
  e.Name  AS EmployeeName,
  e.Salary
FROM Employees e
WHERE e.Salary >
     (SELECT AVG(e2.Salary)
      FROM Employees e2
      WHERE e2.DepartmentID = e.DepartmentID);


-----2.	Orders ва Payments жадвалларидан фойдаланиб, 2020-йилдан олдин берилган ва мос тўлови йўқ бўлган буюртмаларни рўйхат қилинг.

SELECT
  o.OrderID,
  o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON p.OrderID = o.OrderID
WHERE o.OrderDate < '2020-01-01'
  AND p.OrderID IS NULL;


-----3.	Products ва Categories жадвалларидан фойдаланиб, мос категорияси йўқ (категорияга уланмаган) маҳсулотларни қайтаринг.

SELECT
  p.ProductID,
  p.ProductName
FROM Products p
LEFT JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryID IS NULL;


----4.	Фақат Employees жадвали: бир хил менежерга ҳисобот берадиган ва маоши 60 000 дан юқори бўлган ходим жуфтликларини топинг.

SELECT
  a.Name AS Employee1,
  b.Name AS Employee2,
  a.ManagerID,
  CASE WHEN a.Salary < b.Salary THEN a.Salary ELSE b.Salary END AS Salary
FROM Employees a
INNER JOIN Employees b
  ON a.ManagerID = b.ManagerID
 AND a.EmployeeID < b.EmployeeID
WHERE a.ManagerID IS NOT NULL
  AND a.Salary > 60000
  AND b.Salary > 60000;


---5.	Employees ва Departments жадвалларидан фойдаланиб, номи 'M' ҳарфидан бошланадиган бўлимларда ишлайдиган ходимларни қайтаринг.

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName LIKE 'M%';



-----6.	Products ва Sales жадвалларидан фойдаланиб, суммаси 500 дан юқори бўлган сотувларни маҳсулот номи билан бирга рўйхат қилинг.


SELECT
  s.SaleID,
  p.ProductName,
  s.SaleAmount
FROM Sales s
INNER JOIN Products p ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 500;


----7.	Students, Courses ва Enrollments жадвалларидан фойдаланиб, 'Math 101' курсига рўйхатдан ўтмаган талабаларни топинг.

SELECT
  s.StudentID,
  s.Name AS StudentName
FROM Students s
WHERE NOT EXISTS (
  SELECT 1
  FROM Enrollments e
  INNER JOIN Courses c ON c.CourseID = e.CourseID
  WHERE e.StudentID = s.StudentID
    AND c.CourseName = 'Math 101'
);
-----8.	Orders ва Payments жадвалларидан фойдаланиб, тўлов тафсилотлари етишмаётган (яъни тўлови йўқ) буюртмаларни қайтаринг.

SELECT
  o.OrderID,
  o.OrderDate,
  p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON p.OrderID = o.OrderID
WHERE p.PaymentID IS NULL;


----9.	Products ва Categories жадвалларидан фойдаланиб, категорияси 'Electronics' ёки 'Furniture' бўлган маҳсулотларни рўйхат қилинг.

SELECT
  p.ProductID,
  p.ProductName,
  c.CategoryName
FROM Products p
INNER JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryName IN ('Electronics', 'Furniture');
