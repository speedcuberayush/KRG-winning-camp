use practiceT;
create table nemp(
	empid int identity,
	salary int

);

insert into nemp (salary) values 
(1000),
(8000),
(1000),
(2000),
(3000),
(4000),
(8000);

select * from nemp;

select empid,salary, DENSE_RANK() over(order by salary desc) as salrank from nemp;
select empid,salary, RANK() over(order by salary desc) as salrank from nemp;


--find the second highest
SELECT empid, salary
FROM (
    SELECT empid, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS salrank
    FROM nemp
) AS ranked_salaries
WHERE salrank = 2;

-- Create the Sales table
--CREATE TABLE Sale (
--    SaleID INT PRIMARY KEY,
--    EmployeeID INT,
--    SaleDate DATE,
--    SaleAmount DECIMAL(10, 2)
--);

---- Insert sample data into the Sales table
--INSERT INTO Sale (SaleID, EmployeeID, SaleDate, SaleAmount) VALUES
--(1, 1, '2023-01-01', 500),
--(2, 2, '2023-01-01', 300),
--(3, 1, '2023-01-02', 700),
--(4, 2, '2023-01-02', 200),
--(5, 1, '2023-01-03', 100),
--(6, 2, '2023-01-03', 400),
--(7, 3, '2023-01-04', 500),
--(8, 1, '2023-01-04', 300),
--(9, 2, '2023-01-04', 600),
--(10, 3, '2023-01-05', 800);

-- 1: Rank the sale amounts for each employee based on SaleAmount within their respective sales
SELECT 
*,
    RANK() OVER (PARTITION BY EmployeeID ORDER BY SaleAmount DESC) AS R
FROM 
    Sale; 

-- 2: Apply the DENSE_RANK function to rank the sale amounts for each employee based on SaleAmount within their respective sales
SELECT 
    SaleID,
    EmployeeID,
    SaleDate,
    SaleAmount,
    DENSE_RANK() OVER (PARTITION BY EmployeeID ORDER BY SaleAmount DESC) AS DR
FROM 
    Sale;

-- 3: Calculate the running total of SaleAmount for each employee ordered by SaleDate
SELECT 
    SaleID,
    EmployeeID,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) AS [totaltillnow]
FROM 
    Sale;

-- 4: Calculate the running average of SaleAmount for each employee ordered by SaleDate
SELECT 
    SaleID,
    EmployeeID,
    SaleDate,
    SaleAmount,
    ROUND(AVG(SaleAmount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate), 2) AS [average]
FROM	
    Sale;

SELECT 
    SaleID,
    EmployeeID,
    SaleDate,
    SaleAmount,
    CAST(AVG(SaleAmount) OVER (PARTITION BY EmployeeID ORDER  BY SaleDate) AS DECIMAL(10, 2)) AS [average]
FROM	
    Sale;
