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

