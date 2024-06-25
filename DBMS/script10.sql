use db1;
--create table Employee_tbl (
--EmpId int UNIQUE NOT NULL,
--EmpName varchar(50) NOT NULL,
--Email varchar(50) NOT NULL,
--Designation varchar(50) NOT NULL
--)

--insert into Employee_tbl values(11, 'Alok', 'alok@xyx', 'Manager');
--insert into Employee_tbl values(12, 'Raman', 'raman@xyx', 'Assistant');
--insert into Employee_tbl values(13, 'Nisha', 'nisha@xyx', 'IT Incharge');
--insert into Employee_tbl values(14, 'Ashok', 'Ashok@xyx', 'Operator');
--insert into Employee_tbl values(15, 'Naman', 'Naman@xyx', 'AD');
--insert into Employee_tbl values(16, 'Ayush', 'Ayush@xyx', 'Professor');

--select *from Employee_tbl;


--create table department(
--	DeptId int UNIQUE NOT NULL,
--	DeptName varchar(50),
--	Dept_salary bigint NOT NULL,
--	EmpId int UNIQUE NOT NULL
--)

--insert into department values (111, 'Admin', 50000, 13);
--insert into department values (222, 'Accounts', 45000, 12);
--insert into department values (333, 'IT', 66000, 11);
--insert into department values (444, 'Academics', 40000, 14);
--insert into department values (555, 'ERP', 70000, 17);
--insert into department values (666, 'Management', 80000, 18);

--select * from department
--select *from Employee_tbl;
1. 
CREATE VIEW vw_EmployeeDepartmentView AS
SELECT 
    e.EmpId,
    e.EmpName,
    e.Email,
    e.Designation,
    d.DeptName,
    d.Dept_salary
FROM 
    Employee_tbl e
INNER JOIN 
    department d ON e.EmpId = d.EmpId;

--2.
CREATE VIEW vw_ITDepartmentEmployees AS
SELECT 
    e.EmpId,
    e.EmpName,
    e.Email,
    e.Designation,
    d.DeptName,
    d.Dept_salary
FROM 
    Employee_tbl e
INNER JOIN 
    department d ON e.EmpId = d.EmpId
WHERE 
    d.DeptName = 'IT';


--3.

CREATE VIEW vw_SALARY60 AS
SELECT 
    e.EmpId,
    e.EmpName,
    e.Email,
    e.Designation,
    d.DeptName,
    d.Dept_salary
FROM 
    Employee_tbl e
INNER JOIN 
    department d ON e.EmpId = d.EmpId
WHERE 
    d.Dept_salary > 60000;


--4. all by sorted names 
create view vw_SORTEDNAMES as 
select empname from Employee_tbl order by empname;



--5. dept and emp name for all managers
select * from department
select * from employee_tbl;

CREATE VIEW vw_ManagersDetails AS
SELECT 
    e.EmpName AS EmployeeName,
    d.DeptName AS DepartmentName
FROM 
    Employee_tbl e
INNER JOIN 
    department d ON e.EmpId = d.EmpId
WHERE 
    e.Designation = 'Manager';

--6. total salary of each department;

CREATE VIEW TotalSalaryByDepartment AS
SELECT
    d.DeptId,
    d.DeptName,
    SUM(d.Dept_salary) AS TotalSalary
FROM
    department d
GROUP BY
    d.DeptId, d.DeptName;


--7. show average salary of employee in each department
CREATE VIEW AverageSalaryByDepartment AS
SELECT
    d.DeptId,
    d.DeptName,
    AVG(d.Dept_salary) AS AvgSalary
FROM
    department d
GROUP BY
    d.DeptId, d.DeptName;

--8. Create a view to show the number of employees in each department.
CREATE VIEW vw_EmployeesCountByDepartment AS
SELECT
    d.DeptId,
    d.DeptName,
    COUNT(e.EmpId) AS NumEmployees
FROM
    department d
LEFT JOIN
    Employee_tbl e ON d.EmpId = e.EmpId
GROUP BY
    d.DeptId, d.DeptName;

--9. Create a view to show employees with email addresses containing 'xyx'.
CREATE VIEW vw_EmployeesWithEmailContainingXYX AS
SELECT
    EmpId,
    EmpName,
    Email,
    Designation
FROM
    Employee_tbl
WHERE
    Email LIKE '%xyx%';

--10. Create a view to show employees and their department names, sorted by salary in descending order.
--11. Create a view to show the departments with a total  s alary greater than 100,000.
CREATE VIEW vw_DepartmentsWithTotalSalaryGreaterThan100K AS
SELECT
    d.DeptId,
    d.DeptName,
    SUM(d.Dept_salary) AS TotalSalary
FROM
    department d
GROUP BY
    d.DeptId, d.DeptName
HAVING
    SUM(d.Dept_salary) > 100000;


--12. Create a view to show the average salary of employees in departments with more than one employee.
CREATE VIEW vw_AVGSAL AS
SELECT
    d.DeptId,
    d.DeptName,
    AVG(e.Dept_salary) AS AvgSalary
FROM
    department d
JOIN
    Employee_tbl e ON d.EmpId = e.EmpId
WHERE
    d.DeptId IN (
        SELECT d1.DeptId
        FROM department d1
        JOIN Employee_tbl e1 ON d1.EmpId = e1.EmpId
        GROUP BY d1.DeptId
        HAVING COUNT(e1.EmpId) > 1
    )
GROUP BY
    d.DeptId, d.DeptName;

select * from vw_AVGSAL;



	use db1

	-- Create the customer table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert sample data into the customer table
INSERT INTO customers (id, name) VALUES
(1, 'Nimit'),
(2, 'Rehansh'),
(3, 'Priya'),
(4, 'Naman');

-- Create the orders table
CREATE TABLE orderss (
    id INT PRIMARY KEY,
    c_id INT,
    FOREIGN KEY (c_id) REFERENCES customers(id)
);

-- Insert sample data into the orders table
INSERT INTO orderss (id, c_id) VALUES
(1, 3),
(2, 1);

-- Query to find customers who have never placed any orders
SELECT c.name AS Customers_Name
FROM customers c
LEFT JOIN orderss o ON c.id = o.c_id
WHERE o.id IS NULL;
