use practiceT;

create table Invoices(
	invoiceId int identity primary key,
	salesRepId int,
	amount float,
	salesType varchar(20)
);


--insert into Invoices (salesRepId,amount,salesType) 
--values
--(1001,13454,'International'),
--(1001,3434,'International'),
--(2002,54645,'International'),
--(3003,234345,'International'),
--(4004,776,'International'),


--(1001,4564,'Domestic'),
--(2002,34534,'Domestic'),
--(2002,345,'Domestic'),
--(5005,6543,'Domestic'),
--(6006,67,'Domestic');

select * from Invoices;

--return sales repid as either 'Domestic' or 'International ' but not both

SELECT salesRepId
FROM Invoices
GROUP BY salesRepId
HAVING COUNT(distinct salesType) = 1;

select salestype, STRING_AGG(salesRepiD,',') as salesids from invoices group by salestype;



--creating the backup or copying the data of one table into another table (without using creat tables)
--select * into backupEmployees from MyEmployees;
--select * from backupEmployees;
--exec sp_help backupEmployees;


--creating specific columns
 --select 1,2,3,...

 --creating specific rows


SELECT e.*, d.*
INTO backuptt
FROM MyEmployees e
JOIN Departments d ON e.DepartmentId = d.DepartmentId;


/*
--block of code - specific task
--every time function returns something.
--input paramenter is must
--exception handling not in functions

--functions is called sp is executed
--user defined: scaler , inline table valued , multistatement

scaler :: returns 1
inline table valued : return table 
inline(only 1 table)
multivalued(more than 1 table)
--server takes it as a predefined function
*/



-----------------------------------------FUINCTIONS IN SQL--------------------------------------
-------------------------------[FUNCTIONS IN SQL]--------------------------------
-- If you have to repeatedly write large SQL scripts to perform the same task, you can create a function that perfroms that task.
--Next time instead of rewriting the SQL, you can simple call that function.
--A function accepts inputs in the form of parameters and returns a value. 
-- ofcourse, you can create a SP to group a set of SQL statements, however, SP cannot be called within SQL statements like SELECT etc.
-- Functions only work with INPUT PARAMETERS, TRY-CATCH cant be used with functions.

	/*
		1. user-defined Functions -  SCALAR, INLINE-TABLE-VALUED, MULTI-STATEMENT VALUES Functions
		2. system defined functions
	*/

	----------------------------------------[SCALER FUNCTIONS]---------------------------
	--Function without any parameter
	create function ShowMessage()
	returns varchar(100)
	AS
	BEGIN
		return 'Welcome to SSMS SQL SERVER'
	END

	select ShowMessage() --'ShowMessage' is not a recognized built-in function name.
	select dbo.ShowMessage() as Defined_Output


	--Function with single parameter
	create function takeNumber(@num as int)
	returns int
	AS
	BEGIN
		return (@num * @num)
	END

	select dbo.takeNumber(5) as Square_Function



	--Function with multiple parameter
	create function Addition(@num1 as int, @num2 as int)
	returns int
	AS
	BEGIN
		return (@num1 + @num2)
	END

	select dbo.Addition(5,4) as Addition_Function



	

	--Altering the function
	Alter function takeNumber(@num as int)
	returns int
	AS
	BEGIN
		return (@num * @num * @num)
	END

	select dbo.takeNumber(5) as CUBE_Function

	
	--Dropping the function
	drop function dbo.takeNumber;



	--calling an inbuilt function inside user defined function
		create function GetMyDate()
		returns DateTime
		AS
		BEGIN
			return GetDate()
		END

		select dbo.GetMyDate()



	--TASK: Create a funtion to check age for voters
create function fncheckVoterAge(@age as int)
	returns varchar(MAX)
	AS
	BEGIN
		declare @str varchar(30)
		if @age >= 18
		BEGIN
			set @str = 'Eligible'
		END
		else
		BEGIN
			set @str = 'Not Eligible'
		END
		return @str
END

	SELECT DBO.fncheckVoterAge(11) AS DEFINED_OUTPUT

	select dbo.fncheckVoterAge(14) as Age_Confirmation




----------------------------------------[INLINE TABLE VALUED FUNCTIONS]---------------------------
--1. SCALER FUNCTIONS were returning a single value only.
--2. INLINE TABLE VALUED FUNCTIONS returns a table in output. 
-- There is no BEGIN and END block. we only return
-- Creating students_tbl table
CREATE TABLE students_tbl (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    standard INT,
    teacher_id INT
);


INSERT INTO students_tbl (name, gender, age, standard, teacher_id)
VALUES
('Aarav', 'Male', 18, 11, 10),
('Bhavna', 'Female', 17, 10, 20),
('Chirag', 'Male', 20, 12, 30),
('Divya', 'Female', 16, 9, 15),
('Esha', 'Female', 17, 8, 25),
('Farhan', 'Male', 15, 7, 10),
('Gauri', 'Female', 18, 11, 20),
('Harsh', 'Male', 19, 12, 40),
('Isha', 'Female', 17, 10, 50);


select *from students_tbl;
	
	--CREATING ITVF without parameter
		create function fn_GetStudent()
		returns table --returning table
		AS
			return (select *from students_tbl)

		
		select *from students_tbl;
		select *from dbo.fn_GetStudent();

	
	--CREATING ITVF with a single parameter
		create function fun_GetStudentbyAge(@age as int)
		returns table
		As
		return (select *from students_tbl where age >= @age);


		select *from dbo.fun_GetStudentbyAge(17);





CREATE TABLE tbl_teacher(
    Tid INT PRIMARY KEY,
    TName VARCHAR(50),
    TQualification VARCHAR(50),
    TAge INT
);


INSERT INTO tbl_teacher (Tid, TName, TQualification, TAge)
VALUES
(10, 'Anjali', 'PhD', 28),
(15, 'Rajesh', 'MSc', 30),
(20, 'Sunita', 'MA', 28),
(25, 'Vikram', 'BEd', 26),
(30, 'Priya', 'MBA', 25);


----------Performing JOIN operation using INLINE TABLE VALUED FUNCTIONS-------------------------
	select *from students_tbl;
	select *from tbl_teacher;

--P.S: Return all those students who have age >= 17 and also return the teachers associated with them uisng function.
		select * from fun_GetStudentbyAge(17) as A
		INNER JOIN tbl_teacher as B
		ON
		A.teacher_id = B.Tid;



------------------------------------[MULTI STATEMENT TABLE VALUED FUNCTIONS]---------------------------
--1. A MSTVF is table-valued function that return the result of multiple statements.
--2. In inline functions we were using only 1 select statement, but in MSTVF we can use multiple select statements.
select *from students_tbl




create function fn_GetStudentsByGender(@gender as varchar(20))
returns @myTable table (std_id int, std_name varchar(50), std_gender varchar(50))
AS
BEGIN
	insert into @myTable
	select * from students_tbl where gender = @gender

	return 
END






create function fn_GetStudentsByGender(@gender as varchar(20))
returns @myTable table (std_id int, std_name varchar(50), std_gender varchar(50))
AS
BEGIN
	insert into @myTable
	select id, name, gender from students_tbl where gender = @gender

	return
END




--Doing the same task using INLINE TABLE VALUED FUNCTION
create function fn_GetStudentsByGender2(@gender as varchar(20))
returns table
AS
return (select id, name, gender from students_tbl where gender = @gender)
select * from MyEmployees;
	--1. Create a function to calculate the annual salary of an employee.
ALTER FUNCTION fnCalculateAnnualSalary ()
RETURNS table
AS
    RETURN select salary*12 from MyEmployees;
;


select fnCalculateAnnualSalary;

	--2. Create a SQL user-defined function named InsertEmployeeAndCheckDept in SSMS that inserts a new record into the MyEmployees table and ensures 
	--that the corresponding department exists in the Dept table before performing the insertion. The function should accept the following input parameters: 
	--EmpId, EmpName, Gender, Salary, City, and DeptId. If the department exists, the function should insert the new employee and return a message indicating 
	--successful insertion and department existence. If the department does not exist, the function should return a message indicating that the department does not 
	--exist and the employee was not inserted.
select * from MyEmployees;
CREATE FUNCTION fnInsertEmployeeAndCheckDept (
    @EmpId INT,
    @EmpName VARCHAR(50),
    @Gender CHAR(1),
    @Salary DECIMAL(10, 2),
    @City VARCHAR(50),
    @DeptId INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    BEGIN
        INSERT INTO MyEmployees (EmpId, firstname,lastname, Gender,DeptId, Salary, City)
        VALUES (@EmpId, @EmpName, @Gender, @Salary, @City, @DeptId);
        RETURN 'Employee inserted successfully.';
    END
END;




	--3. Create a function that retrieves employee details along with department name.
CREATE FUNCTION fnGetEmployeeDetailsWithDept ()
RETURNS TABLE
AS
RETURN
(
    SELECT e.EmpId, e.FirstName, e.Gender, e.Salary, e.City, d.id,d.dname
    FROM MyEmployees e
    INNER JOIN Dept d ON e.DepartmentId = d.id
);

select * from dbo.fnGetEmployeeDetailsWithDept();

	--4. Create a function that Calculates the average salary for a given department.
create FUNCTION fnAverage(@DeptId INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @AvgSalary DECIMAL(10, 2);

    SELECT @AvgSalary = AVG(Salary)
    FROM MyEmployees
    WHERE DepartmentId = @DeptId;
    RETURN @AvgSalary;
END;

select * from MyEmployees;
select dbo.fnAverage(2);

	--5. Create a SQL user-defined function named DeleteEmployee in SSMS that 
	--deletes a record from the MyEmployees table. The function should accept the 
	--employee ID (EmpId) as an input parameter and return a message indicating whether
	--the employee was successfully deleted or not found. Ensure that the function handles
	--cases where the employee ID does not exist in the table.
CREATE FUNCTION fnDelete(
    @EmpId INT,
    @EmpName NVARCHAR(50),
    @Gender CHAR(1),
    @Salary DECIMAL(10, 2),
    @City NVARCHAR(50),
    @DeptId INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @DeptExists INT;
    SELECT  @DeptExists = CASE WHEN EXISTS (SELECT 1 FROM Department WHERE id = @DeptId) THEN 1 ELSE 0 END;
    IF @DeptExists = 1
    BEGIN
        DELETE department WHERE DEPARTMENTID=@DeptId;
        RETURN 'Employee deleted. Department exists.';
    END
    ELSE
    BEGIN
        RETURN 'Department does not exist.';
    END
END;


	--6. Create a function that Finds the highest salary in each department.
CREATE FUNCTION fnFindHighestSalaryInEachDept ()
RETURNS TABLE
AS
RETURN
(
    SELECT DepartmentId, MAX(Salary) AS HighestSalary
    FROM MyEmployees
    GROUP BY DepartmentId
);

select * from fnFindHighestSalaryInEachDept()

	--7. Create a function that Retrieves employees who have a salary above the average salary of their department.
CREATE FUNCTION fnRetrieveEmployeesAboveAvgSalary ()
RETURNS TABLE
AS
RETURN
(
    SELECT e.EmpId, e.FirstName, e.Gender, e.Salary, e.City, d.dname
    FROM MyEmployees e
    INNER JOIN Dept d ON e.DepartmentId = d.id
    INNER JOIN (
        SELECT DepartmentId, AVG(Salary) AS AvgSalary
        FROM MyEmployees
        GROUP BY DepartmentId
    ) AS deptAvg ON e.DepartmentId = deptAvg.DepartmentId
    WHERE e.Salary > deptAvg.AvgSalary
);


select * from fnRetrieveEmployeesAboveAvgSalary();



	--8. Create a SQL user-defined function named InsertDeptAndUpdateEmployees in SSMS
	--that inserts a new record into the Dept table and updates the department ID for 
	--employees in the MyEmployees table. The function should accept the new department
	--ID (@DeptId), department name (@DeptName), and the old department ID (@OldDeptId) 
	--as input parameters. It should return a message indicating that the department 
	--was inserted and employees were updated.



	--9. Create a function that Retrieves employees who joined in the same month of different years.



	--10. Create a function that Calculates the total salary of employees in a given city.

	--11. Create a SQL user-defined function named UpdateEmployeeSalary in SSMS that 
	--updates the salary of an employee in the MyEmployees table. The function should 
	--accept the employee ID (@EmpId) and the new salary (@NewSalary) as input parameters
	--.It should return a message indicating that the employee's salary was updated.

	--12. Create a function that Retrieves the names of employees who have 'i' in their name.

	--13. Create a function that Finds the total number of employees in each department.

	--14. Create a function that Retrieves departments with no employees.

	--15. Create a function that Calculates the average salary of employees in each city.

	--16. Create a function that Inserts a new employee and return the updated employee list.

	--17. Create a function that Retrieves the employee with the minimum salary in each department.

	--18. Create a SQL user-defined function named DeleteLowSalaryEmployees in SSMS 
	--that deletes employees from the MyEmployees table whose salaries are below a 
	--given threshold. The function should accept the salary threshold (@Threshold) 
	--as an input parameter and return a message indicating that the low-salary 
	--employees were deleted.

	--19. Create a function that Retrieves employees whose names end with 'a'.

	--20. Create a function that Finds the maximum salary of employees in each city.