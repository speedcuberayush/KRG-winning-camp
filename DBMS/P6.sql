use practiceT;

-- inner most query runs the first
/*
main query (q1 (q2 (q3)))
types of subqueries
1. scaler subqueries  : return only 1 value as output
	operaters used: >,<,>=,<=,<>

2. multi values subqieries :  return more than one row as output
	operators used: IN, ANY(OR), ALL(AND)	
	maximum value in any
	where salary > any (4500,5000) checks for all index seperately
	
	maximum value in all
	where salary > all (4500,5000) checks for all index in one type


3. self contained subqueries :	can run independent query Q1( Q2)

4. co related subqueries : cannot run independently query cannot run isolately


					types 
		scalar						multivalued
self-cont	correlated		self-cont		correlated
	*/


----------------------------SUB-QUERIES-------------------------------------
--EMPID EMPNAME GENDER SALARY CITY DEPT_ID
--1	Amit	Male	50000	Delhi	2sp
--2	Priya	Female	60000	Mumbai	1
--3	Rajesh	Male	47000	Agra	3
--5	Anil	Male	54000	Agra	2
--6	Sunita	Female	48000	Mumbai	1
--7	Vijay	Male	49000	Agra	3 
--8	Ritu	Female	62000	Mumbai	2
--9	Alok	Male	51000	Delhi	1
--10	Neha	Female	55000	Agra	4
--11	Simran	Female	35000	Agra	3


--ID DEPT_NAME
--1	Accounts
--2	HR
--3	Admin
--4	Counselling



create table empl(
empid int identity,
empname varchar(20),
gender char(1),
salary int,
city varchar(15),
deptid int
);

--insert into empl (empname,gender,salary,city,deptid) values 
--('Amit','M',50000,'Delhi',2),
--('Priya','F',60000,'Mumbai'	,1),
--('Rajesh','M',47000	,'Agra'	,3),
--('Anil'	,'M',54000	,'Agra',2),
--('Sunita','F',48000	,'Mumbai'	,1),
--('Vijay','M',49000	,'Agra'	,3),
--('Ritu','F',62000	,'Mumbai'	,2),
--('Alok'	,'M',51000	,'Delhi'	,1),
--('Neha','F',55000,'Agra'	,4),
--('Simran',	'F',	35000	,'Agra',	3);


create table dept(
id int identity,
dname varchar(20));

--insert into dept (dname) values 
--('Accounts'),
--('HR'),
--('Admin'),
--('Conselling');


	--Practice Set

	--1.Find employees who earn more than the average salary of their respective departments.
SELECT e.empname, e.salary, d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM empl
    WHERE deptid = e.deptid
);

	--2. List the employees who work in the same city as 'Priya'.
SELECT empname
FROM empl
WHERE city = (SELECT city FROM empl WHERE empname = 'Priya');

	--3. Find the employees whose salary is greater than the minimum salary in the 'HR' department.
SELECT e.empname, e.salary
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary > (
    SELECT MIN(salary)
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'HR')
);

	--4. Retrieve the names of employees who do not work in the 'Admin' department.
SELECT e.empname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE d.dname <> 'Admin';


	--5. List the employees who are in the same department as 'Alok' and earn more than 'Alok'.
SELECT empname, salary
FROM empl
WHERE deptid = (SELECT deptid FROM empl WHERE empname = 'Alok')
  AND salary > (SELECT salary FROM empl WHERE empname = 'Alok');

	--6. Find employees who have the same salary as 'Vijay'.
SELECT empname
FROM empl
WHERE salary = (SELECT salary FROM empl WHERE empname = 'Vijay');

	--7. List the employees whose salary is not the maximum in their respective departments.
SELECT e.empname, e.salary, d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary < (
    SELECT MAX(salary)
    FROM empl
    WHERE deptid = e.deptid
);

	--8. Retrieve the department names that have employees with a salary greater than 60000.
SELECT DISTINCT d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary > 60000;

	--9. Find the employees whose salary is greater than the average salary of all employees.
SELECT empname, salary
FROM empl
WHERE salary > (SELECT AVG(salary) FROM empl);

	--10. List the departments which have more than 2 employees.
SELECT d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
GROUP BY d.dname
HAVING COUNT(e.empid) > 2;

	--11. Retrieve the employees who have the second highest salary in their department.
SELECT max(salary) as maxm
FROM empl
WHERE salary < (SELECT MAX(salary) FROM empl);

SELECT * FROM empl where salary IN(
SELECT max(salary) as maxm
FROM empl
WHERE salary < (SELECT MAX(salary) FROM empl));

	--12. Find the names of employees who work in departments that have a salary sum greater than 150000.
SELECT e.empname, d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.deptid IN (
    SELECT deptid
    FROM empl
    GROUP BY deptid
    HAVING SUM(salary) > 150000
);



	--13. List the employees who have a salary greater than every employee in the 'Admin' department.
SELECT e.empname, e.salary
FROM empl e
WHERE e.salary > ALL (
    SELECT salary
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'Admin')
);

	--14. Retrieve the employees who joined before the employee with the highest salary in 'Counselling' department.


	--15. Find the departments where the minimum salary is greater than 40000.
SELECT d.dname
FROM dept d
JOIN empl e ON d.id = e.deptid
GROUP BY d.dname
HAVING MIN(e.salary) > 40000;

	--16. List employees who earn more than the average salary of the 'Accounts' department.
SELECT e.empname, e.salary
FROM empl e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'Accounts')
);

	--17. Retrieve the employees who have the same gender as 'Simran' and work in 'HR' department.
SELECT e.empname
FROM empl e
WHERE e.gender = (SELECT gender FROM empl WHERE empname = 'Simran')
  AND e.deptid = (SELECT id FROM dept WHERE dname = 'HR');


	--18. Find the employees whose salary is within the top 3 highest salaries in the 'Admin' department.
SELECT e.empname, e.salary
FROM empl e
WHERE e.deptid = (SELECT id FROM dept WHERE dname = 'Admin')
  AND e.salary IN (
    SELECT DISTINCT TOP 3 salary
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'Admin')
    ORDER BY salary DESC
);



	--19. List the departments where the average salary of employees is greater than 55000.
SELECT d.dname
FROM dept d
JOIN empl e ON d.id = e.deptid
GROUP BY d.dname
HAVING AVG(e.salary) > 55000;

	--20. Retrieve the employees whose salary is higher than the average salary of employees in their respective cities.
SELECT e.empname, e.salary, e.city
FROM empl e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM empl
    WHERE city = e.city
);


--stored procedure
/*

why do we need stored procedure 
- stored procedures are faster in execution 
- stored queries
- group or set of commands


normal execution :
	first time sql query - > select plan -> query execution
sp:
	
sp_ : inbuilt stored procedure
sp : user created

create proc 
create procedure sp_...
as 
	begin 

	end

executing sp
1 : name 
2 : execute spName
3 : exec spName



altering sp 

alter procedure spName
as 
begin 
end


2 types of parameters
-- in ,out ,in-out
--input :: pass a paramaeter
--output :: get something from procedure

@id int-- variable init
as	
begin 
end


check content of sp

sp_helptext

securing the sp with encryption
drop procedure procedure name 

@varaiblename type (by default it is input)
output type
@variablename type OUTPUT


DECALRE KEYWORD OUTSIDE PROCEDURE SCOPE

find sp procedure 
--db-programmability-stored procedure 
*/


select * from Employee_tbl1;
select * from department;
	

-- 1. Insert a New Employee

CREATE PROCEDURE spInsertEmployee 
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Gender CHAR(1),
    @DepartmentId INT,
    @City VARCHAR(100),
    @Salary DECIMAL(10, 2),
    @JoiningDate DATE

AS
BEGIN
    INSERT INTO MyEmployees (FirstName, LastName, Gender, DepartmentId, City, Salary, JoiningDate)
    VALUES (@FirstName, @LastName, @Gender, @DepartmentId, @City, @Salary, @JoiningDate);
END;


-- 2. Update Employee's Salary by EmpId

CREATE PROCEDURE spUpdateEmployeeSalary 
    @EmpId INT,
    @NewSalary DECIMAL(10, 2)

AS
BEGIN
    UPDATE MyEmployees
    SET Salary = @NewSalary
    WHERE EmpId = @EmpId;
END;


-- 3. Delete Employee by EmpId

CREATE PROCEDURE spDeleteEmployee 
    @EmpId INT

AS
BEGIN
    DELETE FROM MyEmployees
    WHERE EmpId = @EmpId;
END;


-- 4. Retrieve Employee Details with Department Name
CREATE PROCEDURE spGetEmployeeDetailsWithDepartment
AS
BEGIN
    SELECT e.EmpId, e.FirstName, e.LastName, e.Gender, e.City, e.Salary, e.JoiningDate, d.DepartmentName
    FROM MyEmployees e
    JOIN Departments d ON e.DepartmentId = d.DepartmentId;
END;


-- 5. Retrieve Employees from a Specific City
CREATE PROCEDURE spGetEmployeesByCity 
    @City VARCHAR(100)

AS
BEGIN
    SELECT *
    FROM MyEmployees
    WHERE City = @City;
END;




-- 6. Count Number of Employees in Each Department
CREATE PROCEDURE spCountEmployeesByDepartment
AS
BEGIN
    SELECT d.DepartmentName, COUNT(e.EmpId) AS EmployeeCount
    FROM MyEmployees e
    JOIN Departments d ON e.DepartmentId = d.DepartmentId
    GROUP BY d.DepartmentName;
END;

-- 7. Find the Highest Salary in Each Department
CREATE PROCEDURE spGetHighestSalaryByDepartment
AS
BEGIN
    SELECT d.DepartmentName, MAX(e.Salary) AS HighestSalary
    FROM MyEmployees e
    JOIN Departments d ON e.DepartmentId = d.DepartmentId
    GROUP BY d.DepartmentName;
END;

	--8. Create a stored procedure to update the department of an employee based on their EmpId.
CREATE PROCEDURE spUpdateEmployeeDepartment 
    @EmpId INT,
    @NewDepartmentId INT

AS
BEGIN
    UPDATE MyEmployees
    SET DepartmentId = @NewDepartmentId
    WHERE EmpId = @EmpId;
END;

	--9. Create a stored procedure to retrieve employees who have a salary above a certain amount.
CREATE PROCEDURE spGetEmployeesWithSalaryAbove 
    @Salary DECIMAL
AS
BEGIN
    SELECT *
    FROM MyEmployees
    WHERE Salary > @Salary;
END;

	--10. Create a stored procedure to retrieve employees whose names start with a specific letter.
CREATE PROCEDURE spGetEmployeesByNameStart 
    @StartLetter CHAR(1)

AS
BEGIN
    SELECT *
    FROM MyEmployees
    WHERE FirstName LIKE @StartLetter + '%';
END;
	--11. Create a stored procedure to get the average salary of employees in a specific department.
CREATE PROCEDURE spGetAverageSalaryByDepartment 
    @DepartmentId INT
AS
BEGIN
    SELECT AVG(Salary) AS AverageSalary
    FROM MyEmployees
    WHERE DepartmentId = @DepartmentId;
END;
	--12. Create a stored procedure to get the total salary paid to employees in each city.

CREATE PROCEDURE spGetTotalSalaryByCity
AS
BEGIN
    SELECT City, SUM(Salary) AS TotalSalary
    FROM MyEmployees
    GROUP BY City;
END;

	--13. Create a stored procedure to delete all employees from a specific department.
CREATE PROCEDURE spDeleteEmployeesByDepartment 
    @DepartmentId INT
AS
BEGIN
    DELETE FROM MyEmployees
    WHERE DepartmentId = @DepartmentId;
END;


	--14. Create a stored procedure to find the employee with the highest salary in each city.
CREATE PROCEDURE spGetHighestSalaryByCity
AS
BEGIN
    SELECT City, MAX(Salary) AS HighestSalary
    FROM MyEmployees
    GROUP BY City;
END;

	--15. Create a stored procedure to retrieve employees who belong to a specific department.
CREATE PROCEDURE spGetEmployeesByDepartment 
    @DepartmentId INT
AS
BEGIN
    SELECT *
    FROM MyEmployees
    WHERE DepartmentId = @DepartmentId;
END;

select * from MyEmployees
select *from Departments
	--16. Create a stored procedure to find employees with the same salary in different departments.
CREATE PROCEDURE spGetEmployeesWithSameSalaryInDifferentDepartments
AS
BEGIN
    SELECT e1.FirstName, e1.salary, d1.departmentname AS department
    FROM MyEmployees e1
    JOIN departments d1 ON e1.departmentid = d1.departmentid
    WHERE e1.salary IN (
        SELECT salary
        FROM MyEmployees
        GROUP BY salary
        HAVING COUNT(DISTINCT departmentid) > 1
    )
    ORDER BY e1.salary, d1.departmentname;
END;

exec spGetEmployeesWithSameSalaryInDifferentDepartments

	--17. Create a stored procedure to get the total number of male and female employees.
CREATE PROCEDURE spGetEmployeeGenderCount
AS
BEGIN
    SELECT Gender, COUNT(*) AS Count
    FROM MyEmployees
    GROUP BY Gender;
END;

	--18. Create a stored procedure to find employees who joined after a certain date.
CREATE PROCEDURE spGetEmployeesJoinedAfter 
    @JoiningDate DATE

AS
BEGIN
    SELECT *
    FROM MyEmployees
    WHERE JoiningDate > @JoiningDate;
END;

	--19. Create a stored procedure to update the city of an employee based on their EmpId.
CREATE PROCEDURE spUpdateEmployeeCity 
    @EmpId INT,
    @NewCity VARCHAR(100)

AS
BEGIN
    UPDATE MyEmployees
    SET City = @NewCity
    WHERE EmpId = @EmpId;
END;

	--20. Create a stored procedure to retrieve employees who belong to departments with a specific name.
CREATE PROCEDURE spGetEmployeesByDepartmentName 
    @DepartmentName VARCHAR(100)

AS
BEGIN
    SELECT e.*
    FROM MyEmployees e
    JOIN Departments d ON e.DepartmentId = d.DepartmentId
    WHERE d.DepartmentName = @DepartmentName;
END;


select * from MyEmployees;

drop table Employees1111;
CREATE TABLE Employees1111 (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Execute the BULK INSERT command to load data from the text file
BULK INSERT Employees1111
FROM 'C:\Users\msdak\OneDrive\Desktop\Kargil-winning-camp\DBMS\insert.txt'  
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n', 
    FIRSTROW = 1  
);

TRUNCATE TABLE EMPLOYEES1111;

select * from Employees1111;


CREATE TABLE TEMPY (
    empId int cast(IDENTITY(65, 1) as char) PRIMARY KEY,
    empChar CHAR(1) NOT NULL
);



SELECT d.DepartmentName, MAX(e.Salary) AS HighestSalary
INTO [backupTable%^^&(!@#$%^&*()]
    FROM MyEmployees e
    JOIN Departments d ON e.DepartmentId = d.DepartmentId
    GROUP BY d.DepartmentName;


select * from [backupTable%^^&(!@#$%^&*()];


select * into backuptt from MyEmployees e join Departments d on e.DepartmentId=d.DepartmentId;
