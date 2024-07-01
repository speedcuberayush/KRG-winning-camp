use db_HOME_TASK;
-- Drop tables if they exist (useful for rerunning the script without errors)
DROP TABLE IF EXISTS Employee_tbl1;
DROP TABLE IF EXISTS department;

-- Create Employee_tbl1 table
CREATE TABLE Employee_tbl1 (
    EmpId INT UNIQUE NOT NULL,
    EmpName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Designation VARCHAR(50) NOT NULL,
    ManagerId INT NULL
);

-- Insert data into Employee_tbl1
INSERT INTO Employee_tbl1 VALUES (11, 'Alok', 'alok@xyx', 'Manager', NULL);
INSERT INTO Employee_tbl1 VALUES (12, 'Raman', 'raman@xyx', 'Assistant', 11);
INSERT INTO Employee_tbl1 VALUES (13, 'Nisha', 'nisha@xyx', 'IT Incharge', 11);
INSERT INTO Employee_tbl1 VALUES (14, 'Ashok', 'ashok@xyx', 'Operator', NULL);
INSERT INTO Employee_tbl1 VALUES (15, 'Naman', 'naman@xyx', 'AD', 14);
INSERT INTO Employee_tbl1 VALUES (16, 'Ayush', 'ayush@xyx', 'Professor', 14);

-- Create department table
CREATE TABLE department (
    DeptId INT UNIQUE NOT NULL,
    DeptName VARCHAR(50),
    Dept_salary BIGINT NOT NULL,
    EmpId INT UNIQUE NOT NULL
);

-- Insert data into department table
INSERT INTO department VALUES (111, 'Admin', 50000, 13);
INSERT INTO department VALUES (222, 'Accounts', 45000, 12);
INSERT INTO department VALUES (333, 'IT', 66000, 11);
INSERT INTO department VALUES (444, 'Academics', 40000, 14);
INSERT INTO department VALUES (555, 'ERP', 70000, 17);
INSERT INTO department VALUES (666, 'Management', 80000, 18);

-- Queries to answer the questions

-- 1. Display pairs of employees who have the same manager.
SELECT e1.EmpName AS Employee1, e2.EmpName AS Employee2, e1.ManagerId
FROM Employee_tbl1 e1
JOIN Employee_tbl1 e2 ON e1.ManagerId = e2.ManagerId
WHERE e1.EmpId < e2.EmpId AND e1.ManagerId IS NOT NULL;

-- 2. Display the count of employees under each manager.
SELECT ManagerId, COUNT(EmpId) AS EmployeeCount
FROM Employee_tbl1
WHERE ManagerId IS NOT NULL
GROUP BY ManagerId;

-- 3. Display all employees along with their department names. Include employees who do not have a department.
SELECT e.EmpName, d.DeptName
FROM Employee_tbl1 e
LEFT JOIN department d ON e.EmpId = d.EmpId;

-- 4. Display department names, their employee names, and the total salary of each department.
SELECT d.DeptName, e.EmpName, d.Dept_salary AS TotalSalary
FROM Employee_tbl1 e
JOIN department d ON e.EmpId = d.EmpId;

-- 5. Display employee names, their department names, and their manager names.
SELECT e.EmpName AS EmployeeName, d.DeptName, m.EmpName AS ManagerName
FROM Employee_tbl1 e
LEFT JOIN department d ON e.EmpId = d.EmpId
LEFT JOIN Employee_tbl1 m ON e.ManagerId = m.EmpId;

-- 6. Display the names of employees who do not belong to any department.
SELECT e.EmpName
FROM Employee_tbl1 e
LEFT JOIN department d ON e.EmpId = d.EmpId
WHERE d.DeptId IS NULL;

-- 7. Display department names and their corresponding employee names where the department salary is greater than 60000.
SELECT d.DeptName, e.EmpName
FROM Employee_tbl1 e
JOIN department d ON e.EmpId = d.EmpId
WHERE d.Dept_salary > 60000;

-- 8. Display the names of employees who work in the IT department in ascending order.
SELECT e.EmpName
FROM Employee_tbl1 e
JOIN department d ON e.EmpId = d.EmpId
WHERE d.DeptName = 'IT'
ORDER BY e.EmpName ASC;

-- 9. Display employee names and department names where the department salary is greater than 50000 order by descending.
SELECT e.EmpName, d.DeptName
FROM Employee_tbl1 e
JOIN department d ON e.EmpId = d.EmpId
WHERE d.Dept_salary > 50000
ORDER BY d.Dept_salary DESC;

-- 10. Display the names of employees who do not belong to any department in ascending order.
SELECT e.EmpName
FROM Employee_tbl1 e
LEFT JOIN department d ON e.EmpId = d.EmpId
WHERE d.DeptId IS NULL
ORDER BY e.EmpName ASC;

-- 11. Display department names, salaries, and their corresponding employee names. Include departments without employees in descending order.
SELECT d.DeptName, d.Dept_salary, e.EmpName
FROM department d
LEFT JOIN Employee_tbl1 e ON d.EmpId = e.EmpId
ORDER BY d.DeptName DESC, d.Dept_salary DESC;

-- 12. Display records where there is a mismatch between employees and departments having order as employee name and department name in descending order.
SELECT e.EmpName, d.DeptName
FROM Employee_tbl1 e
FULL OUTER JOIN department d ON e.EmpId = d.EmpId
WHERE e.EmpId IS NULL OR d.EmpId IS NULL
ORDER BY e.EmpName DESC, d.DeptName DESC;
