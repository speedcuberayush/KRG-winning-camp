use db1;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Position NVARCHAR(100),
    Salary DECIMAL(10, 2),
    Department NVARCHAR(50)
);

--INSERT INTO Employees (FirstName, LastName, BirthDate, HireDate, Position, Salary, Department)
--VALUES 
--('John', 'Doe', '1985-05-15', '2010-06-01', 'Software Engineer', 80000, 'IT'),
--('Jane', 'Smith', '1990-10-22', '2012-08-15', 'Data Analyst', 75000, 'Data'),
--('Emily', 'Jones', '1988-03-19', '2015-03-30', 'Project Manager', 90000, 'Management'),
--('Michael', 'Brown', '1982-11-02', '2008-09-15', 'HR Specialist', 60000, 'HR'),
--('Linda', 'Davis', '1975-07-25', '2005-05-20', 'Chief Financial Officer', 120000, 'Finance'),
--('Robert', 'Wilson', '1995-12-10', '2020-01-15', 'Software Engineer', 65000, 'IT'),
--('Patricia', 'Taylor', '1980-02-28', '2007-11-10', 'Marketing Director', 95000, 'Marketing'),
--('James', 'Anderson', '1978-06-17', '2004-04-22', 'Chief Operations Officer', 115000, 'Operations'),
--('Maria', 'Thomas', '1992-09-05', '2017-10-01', 'Sales Manager', 85000, 'Sales'),
--('William', 'Martinez', '1983-08-11', '2009-12-12', 'Business Analyst', 70000, 'Business');


select * from employees;

create view vw_V1 as select * from Employees where salary between 75000 and 130000;
select * from vw_V1;

INSERT INTO vw_V1 values ('AYUSH','MISHRA','2002-09-30','2021-10-25','SDE',900000,'IT');
select * from vw_V1;
select * from employees;



--create view vw_V2 
--as 
--select EmployeeID, FirstName,Salary,Department from employees;


--select * from employees


create view vw_DEPT as 
select DEPARTMENT from Employees group by Department;

select * from vw_DEPT



--ORDER BY 
select * from employees
create view vwSORTEDSALARY as 
select  employeeID, FirstName,Position, salary, Department order by Salary desc;
