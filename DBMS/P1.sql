create database practiceT;
use practiceT;


create table Employee (
EmpId int UNIQUE NOT NULL,
EmpName varchar(50) NOT NULL,
Email varchar(50) NOT NULL,
Designation varchar(50) NOT NULL
)


insert into Employee values(11, 'Alok', 'alok@xyx', 'Manager');
insert into Employee values(12, 'Raman', 'raman@xyx', 'Assistant');
insert into Employee values(13, 'Nisha', 'nisha@xyx', 'IT Incharge');
insert into Employee values(14, 'Ashok', 'Ashok@xyx', 'Operator');
insert into Employee values(15, 'Naman', 'Naman@xyx', 'AD');
insert into Employee values(16, 'Ayush', 'Ayush@xyx', 'Professor');

select * from Employee;x

create table department(
	DeptId int UNIQUE NOT NULL,
	DeptName varchar(50),
	Dept_salary bigint NOT NULL,
	EmpId int UNIQUE NOT NULL);

insert into department values (111, 'Admin', 50000, 13);
insert into department values (222, 'Accounts', 45000, 12);
insert into department values (333, 'IT', 66000, 11);
insert into department values (444, 'Academics', 40000, 14);
insert into department values (555, 'ERP', 70000, 17);
insert into department values (666, 'Management', 80000, 18);
 
 
 

 
------------------------------STRING PRACTICE SET--------------------------------------
--Extract the first 3 characters of each employee's name.
select left(Empname,3) as first3 from Employee;

--Find the position of the '@' character in each employee's email address.
select charindex('@',Email) as postion from Employee;


--Replace 'xyx' with 'example.com' in each employee's email address.
select email,replace(email,'xyz','example') as replaced from employee;
select * from employee;

--Remove leading and trailing spaces from each employee's name.
select ltrim(empname) as lT,
rtrim(empname) as rT, 
trim(empname) as trimmed 
from employee;

--Extract the domain (part after '@') from each employee's email address.
select email,substring(email,CHARINDEX('@',email)+1,len(email))as domain from employee;

--Repeat each employee's name twice.
SELECT CONCAT(empname, ' ', empname) AS repeated_name FROM Employee;

--Insert 'Employee: ' at the beginning of each employee's name.
SELECT CONCAT('Employee: ', empname) AS prefixed_name FROM Employee;

--Find employees whose names contain the letter 'KA' using a pattern search.
select empname from Employee where patindex(empname,'%ka%') >0;



--Concatenate each employee's name with their designation, separated by a hyphen.
select CONCAT(Empname,'-',Designation) from employee;

select * from employee;

--Format the department salary as a currency value.
SELECT DeptName, FORMAT(Dept_salary, 'c') AS formatted_salary
FROM Department;

select * from department;


--Concatenate all employee names into a single string, separated by commas.
select STRING_AGG(empname,', ') as allemp 
from Employee;



CREATE TABLE Employee_tbl1 (
    EmpId INT UNIQUE NOT NULL,
    EmpName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Designation VARCHAR(50) NOT NULL,
    ManagerId INT NULL
);

INSERT INTO Employee_tbl1 VALUES (11, 'Alok', 'alok@xyx', 'Manager', NULL);
INSERT INTO Employee_tbl1 VALUES (12, 'Raman', 'raman@xyx', 'Assistant', 11);
INSERT INTO Employee_tbl1 VALUES (13, 'Nisha', 'nisha@xyx', 'IT Incharge', 11);
INSERT INTO Employee_tbl1 VALUES (14, 'Ashok', 'ashok@xyx', 'Operator', NULL);
INSERT INTO Employee_tbl1 VALUES (15, 'Naman', 'naman@xyx', 'AD', 14);
INSERT INTO Employee_tbl1 VALUES (16, 'Ayush', 'ayush@xyx', 'Professor', 14);

	--11. Write a query to display pairs of  employees who have the same manager.
SELECT e1.empname, e2.empname as managername, e1.Managerid
FROM Employee_tbl1 e1
INNER JOIN Employee_tbl1 e2 ON e1.managerid = e2.managerId AND e1.empid <> e2.empid;
select * from Employee_tbl1;



	--12. Write a query to display the count of employees under each manager.
SELECT Managerid, COUNT(EmpId) AS EmployeeCount
FROM Employee_tbl1
GROUP BY Managerid
having managerid is not null;


	--13. Write a query to display all employees along with their department names. Include employees who do not have a department.

	--14. Write a query to display department names, their employee names, and the total salary of each department.

	--15. Write a query to display employee names, their department names, and their manager names.

	--16. Write a query to display the names of employees who do not belong to any department.

	--17. Write a query to display department names and their corresponding employee names where the department salary is greater than 60000.

	--18. Write a query to display the names of employees who work in the IT department in ascending order.

	--19. Write a query to display employee names and department names where the department salary is greater than 50000 order by descending.

	--20. Write a query to display the names of employees who do not belong to any department in ascending order.

	--21. Write a query to display department names, salaries, and their corresponding employee names. Include departments without employees in descending order.

	--22. Write a query to display records where there is a mismatch between employees and departments having order as employee name and department name in descending order.
