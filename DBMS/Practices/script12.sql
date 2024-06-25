use db_Home_Task;
create table Employee (
EmpId int UNIQUE NOT NULL,
EmpName varchar(50) NOT NULL,
Email varchar(50) NOT NULL,
Designation varchar(50) NOT NULL
)

/*
insert into Employee values(11, 'Alok', 'alok@xyx', 'Manager');
insert into Employee values(12, 'Raman', 'raman@xyx', 'Assistant');
insert into Employee values(13, 'Nisha', 'nisha@xyx', 'IT Incharge');
insert into Employee values(14, 'Ashok', 'Ashok@xyx', 'Operator');
insert into Employee values(15, 'Naman', 'Naman@xyx', 'AD');
insert into Employee values(16, 'Ayush', 'Ayush@xyx', 'Professor');

select * from Employee;
*/
create table department(
	DeptId int UNIQUE NOT NULL,
	DeptName varchar(50),
	Dept_salary bigint NOT NULL,
	EmpId int UNIQUE NOT NULL);
	/*
insert into department values (111, 'Admin', 50000, 13);
insert into department values (222, 'Accounts', 45000, 12);
insert into department values (333, 'IT', 66000, 11);
insert into department values (444, 'Academics', 40000, 14);
insert into department values (555, 'ERP', 70000, 17);
insert into department values (666, 'Management', 80000, 18);
 
 select * from department;
 */


 select * from employee;
 select * from department;
--1. Create a view to show the employee details and their corresponding department names.
CREATE VIEW vw_DEPTNAME AS 
SELECT e.*,d.deptName,d.DeptId 
FROM employee as e
INNER JOIN department as d 
on e.empID=d.empID;


select * from vw_DEPTNAME;

--2. Create a view to show only employees in the 'IT' department.
CREATE VIEW vw_ITDEPT AS 
SELECT e.empID,e.EmpName, d.Dept_salary
FROM employee as e
INNER JOIN department as d 
on e.empID=d.empID
where d.deptName='IT';

select * from vw_ITDEPT;


--3. Create a view to show employees whose salary is greater than 60,000.
CREATE VIEW vw_SALARY60 AS 
SELECT e.empID,e.EmpName, d.Dept_salary
FROM employee as e
INNER JOIN department as d 
on e.empID=d.empID
where d.Dept_salary>60000;

select * from vw_SALARY60;


--4. Create a view to show all employees sorted by their names.
CREATE VIEW vw_SORTEDNAMES AS 
SELECT TOP 1000 * FROM Employee
ORDER BY EmpName;

select * from vw_SORTEDNAMES;


--5. Create a view to show the department and employee name for all 'Managers'.
CREATE VIEW vw_MANAGERNAMES AS 
SELECT e.EmpName, d.DeptName,d.DeptId
FROM employee as e
INNER JOIN department as d 
on e.empID=d.empID
where e.Designation='Manager';

select * from vw_MANAGERNAMES;

--6. Create a view to show the total salary of each department.
CREATE VIEW vw_TOTALDEPTSALARY AS 
SELECT
    d.DeptId,
    d.DeptName,
    SUM(d.Dept_salary) AS TotalSalary
FROM
    department d
GROUP BY
    d.DeptId, d.DeptName;

select * from vw_TOTALDEPTSALARY;


--7. Create a view to show the average salary of employees in each department.
CREATE VIEW vw_AVGDEPTSALARY AS 
SELECT
    d.DeptId,
    d.DeptName,
    AVG(d.Dept_salary) AS AvgSalary
FROM
    department d
GROUP BY
    d.DeptId, d.DeptName;

select * from vw_AVGDEPTSALARY;
--8. Create a view to show the number of employees in each department.
CREATE VIEW vw_EmployeesCountByDepartment AS
SELECT
    d.DeptId,
    d.DeptName,
    COUNT(e.EmpId) AS NumEmployees
FROM
    department d
LEFT JOIN
    Employee e ON d.EmpId = e.EmpId
GROUP BY
    d.DeptId, d.DeptName;

select * from vw_EmployeesCountByDepartment;

--9. Create a view to show employees with email addresses containing 'xyx'.
CREATE VIEW vw_XYZMAIL AS 
SELECT *
FROM employee 
WHERE
    Email LIKE '%xyx%';

select * from vw_XYZMAIL;

--10. Create a view to show employees and their department names, sorted by salary in descending order.
CREATE VIEW vw_DSCSALAY AS 
SELECT top 1000 e.EmpName, d.DeptName,d.Dept_salary
FROM employee as e
INNER JOIN department as d 
on e.empID=d.empID
order by d.Dept_salary

select * from vw_DSCSALAY;

--11. Create a view to show the departments with a total salary greater than 100,000.
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


select * from vw_DepartmentsWithTotalSalaryGreaterThan100K;

--12. Create a view to show the average salary of employees departments with more than one employee.
CREATE VIEW vw_AVGSAL AS
SELECT 
    d.DeptId,
    d.DeptName,
    AVG(d.Dept_salary) AS AvgSalary,
    COUNT(e.EmpId) AS NumberOfEmployees
FROM 
    Department d
JOIN 
    Employee e ON d.EmpId = e.EmpId
GROUP BY 
    d.DeptId, d.DeptName
HAVING 
    COUNT(e.EmpId) > 1;

select * from vw_AVGSAL