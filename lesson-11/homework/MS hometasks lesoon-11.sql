

-------Осон даража (7)----

-----Топшириқ: 2022-йилдан кейин берилган барча буюртмаларни ва уларни берган мижозлар исмларини кўрсатинг.
----Жадваллар: Orders, Customers

SELECT
  o.OrderID,
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  o.OrderDate
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2023-01-01'
ORDER BY o.OrderDate, o.OrderID;


-----Топшириқ: Sales ёки Marketing бўлимларида ишлайдиган ходимлар номларини чиқаринг.
-----Жадваллар: Employees, Departments

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
ORDER BY e.Name;


---Топшириқ: Ҳар бир бўлим бўйича энг юқори маошни кўрсатинг.
---Жадваллар: Departments, Employees

SELECT
  d.DepartmentName,
  MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees  e ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY d.DepartmentName;


---Топшириқ: 2023-йилда буюртма берган, АҚШ (USA) дан бўлган барча мижозларни рўйхат қилинг.
---Жадваллар: Customers, Orders

SELECT
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  o.OrderID,
  o.OrderDate
FROM Customers c
JOIN Orders    o ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'
  AND o.OrderDate >= '2023-01-01'
  AND o.OrderDate <  '2024-01-01'
ORDER BY o.OrderDate, o.OrderID;


---Топшириқ: Ҳар бир мижоз неча та буюртма берганини кўрсатинг.
---Жадваллар: Orders, Customers


SELECT
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY CustomerName;



---Топшириқ: Gadget Supplies ёки Clothing Mart томонидан таъминланган маҳсулотлар номларини чиқаринг.
---Жадваллар: Products, Suppliers

SELECT
  p.ProductName,
  s.SupplierName
FROM Products  p
JOIN Suppliers s ON s.SupplierID = p.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart')
ORDER BY s.SupplierName, p.ProductName;



---Топшириқ: Ҳар бир мижоз учун унинг энг сўнгги буюртмасини кўрсатинг. Буюртма бермаган мижозлар ҳам кирсин.
---Жадваллар: Customers, Orders

SELECT
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  oa.MostRecentOrderDate
FROM Customers c
OUTER APPLY (
    SELECT TOP (1) o.OrderDate AS MostRecentOrderDate
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
    ORDER BY o.OrderDate DESC
) oa
ORDER BY CustomerName;


--------Ўртача даража (6)

---Топшириқ: Жами суммаси 500 дан катта бўлган буюртма берган мижозларни кўрсатинг.
---Жадваллар: Orders, Customers

SELECT
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > 500
ORDER BY o.TotalAmount DESC, CustomerName;


---Топшириқ: 2022-йилда қилинган ёки суммаси 400 дан ошган сотувларни рўйхат қилинг.
---Жадваллар: Products, Sales

SELECT
  p.ProductName,
  s.SaleDate,
  s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE (s.SaleDate >= '2022-01-01' AND s.SaleDate < '2023-01-01')
   OR  s.SaleAmount > 400
ORDER BY s.SaleDate, p.ProductName;


---Топшириқ: Ҳар бир маҳсулот бўйича жами қанча суммага сотилганини кўрсатинг.
---Жадваллар: Sales, Products

SELECT
  p.ProductName,
  SUM(s.SaleAmount) AS TotalSalesAmount
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY p.ProductName;


---Топшириқ: HR бўлимида ишлаб, маоши 60000 дан катта бўлган ходимларни кўрсатинг.
---Жадваллар: Employees, Departments

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName,
  e.Salary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Human Resources'
  AND e.Salary > 60000
ORDER BY e.Salary DESC, e.Name;


---Топшириқ: 2023-йилда сотилган ва сотиш вақтида омбор захираси (StockQuantity) 100 дан кўп бўлган маҳсулотларни рўйхат қилинг.
---Жадваллар: Products, Sales

SELECT
  p.ProductName,
  s.SaleDate,
  p.StockQuantity
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE s.SaleDate >= '2023-01-01'
  AND s.SaleDate <  '2024-01-01'
  AND p.StockQuantity > 100
ORDER BY s.SaleDate, p.ProductName;


---Топшириқ: Sales бўлимида ишлайдиган ёки 2020-йилдан кейин ишга олинган ходимларни кўрсатинг.
---Жадваллар: Employees, Departments

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName,
  e.HireDate
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE (d.DepartmentName = 'Sales')
   OR (e.HireDate > '2020-12-31')
ORDER BY e.HireDate, e.Name;


--------Қийин даража (7)

---Топшириқ: Адреси 4та рақам билан бошланадиган, АҚШ (USA) мижозлари томонидан қилинган барча буюртмаларни рўйхат қилинг.
---Жадваллар: Customers, Orders

SELECT
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  o.OrderID,
  c.Address,
  o.OrderDate
FROM Customers c
JOIN Orders    o ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'
  AND c.Address LIKE '[0-9][0-9][0-9][0-9]%'  -- SQL Server pattern
ORDER BY o.OrderDate, o.OrderID;


---Топшириқ: Электроника (Electronics) тоифасига мансуб ёки сотув суммаcи 350 дан юқори бўлган маҳсулот сотувларини кўрсатинг.
---Жадваллар: Products, Sales

SELECT
  p.ProductName,
  COALESCE(c.CategoryName, CAST(p.Category AS VARCHAR(20))) AS Category,
  s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
LEFT JOIN Categories c ON c.CategoryID = p.Category
WHERE (c.CategoryName = 'Electronics')
   OR (s.SaleAmount > 350)
ORDER BY s.SaleAmount DESC, p.ProductName;



---Топшириқ: Ҳар бир тоифа бўйича мавжуд маҳсулотлар сонини кўрсатинг.
---Жадваллар: Products, Categories


SELECT
  c.CategoryName,
  COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p ON p.Category = c.CategoryID
GROUP BY c.CategoryName
ORDER BY c.CategoryName;



---Топшириқ: Мижози Los Angeles шаҳридан бўлиб, буюртма суммаси 300 дан катта бўлган буюртмаларни рўйхат қилинг.
---Жадваллар: Customers, Orders

SELECT
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  c.City,
  o.OrderID,
  o.TotalAmount AS Amount
FROM Customers c
JOIN Orders    o ON o.CustomerID = c.CustomerID
WHERE c.City = 'Los Angeles'
  AND o.TotalAmount > 300
ORDER BY o.OrderDate, o.OrderID;


---Топшириқ: HR ёки Finance бўлимида ишлайдиган ёки номида камида 4та унли ҳарф мавжуд бўлган ходимларни кўрсатинг.
---Жадваллар: Employees, Departments

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE (d.DepartmentName IN ('Human Resources', 'Finance'))
   OR (
        -- камида 4та унли (a, e, i, o, u) — case-insensitive
        (
          (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'a', ''))) +
          (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'e', ''))) +
          (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'i', ''))) +
          (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'o', ''))) +
          (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name), 'u', '')))
        ) >= 4
      )
ORDER BY e.Name;


---Топшириқ: Sales ёки Marketing бўлимларида ишлаб, маоши 60000 дан юқори бўлган ходимларни кўрсатинг.
---Жадваллар: Employees, Departments

SELECT
  e.Name AS EmployeeName,
  d.DepartmentName,
  e.Salary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
  AND e.Salary > 60000
ORDER BY e.Salary DESC, e.Name;
