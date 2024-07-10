use practiceT;


--delimeter : content kha se shuru karna hai specifiy the block of function
/*
triggers are special king of sp which are executed automatically 
DML,DDL,OPERATION
server level triggers - database level triggers

after and instead of


magic table 
PREDEFINED TRIGGERS 

--INSERTED , DELETED	
sepecify id in views deletions
*/


create table studentsTbl(
uid int identity primary key,
sname varchar(20),
age int
);


create table saudit(
	aid int identity primary key,
	ainfo varchar(max)
);




alter trigger tr_AUDITINSERT
ON studentsTbl
AFTER INSERT
AS
	BEGIN
		Declare @id int
		Select @id = uid from INSERTED
		insert into saudit values('Student ID ' + Cast(@id as varchar(50))+ ' added at ' + Cast(GetDate() as varchar(50)));
	END

insert into studentsTbl(sname,age) values
('Ayush',21);
insert into studentsTbl(sname,age) values
('Anurag',19);
insert into studentsTbl(sname,age) values
('Mishra',20);
insert into studentsTbl(sname,age) values
('Saksham',21)
insert into studentsTbl(sname,age) values
('Mradul',21);
insert into studentsTbl(sname,age) values
('Aryan',19);

select * from saudit;


create trigger tr_AUDITDELETE
ON studentsTbl
AFTER DELETE
AS
	BEGIN
		Declare @id int
		Select @id = uid from INSERTED
		insert into saudit values('Student ID ' + Cast(@id as varchar(50))+ ' deleted at ' + Cast(GetDate() as varchar(50)));
	END


create trigger tr_AUDITUPDATE
ON studentsTbl
AFTER UPDATE
AS
	BEGIN
		Declare @id int
		Select @id = uid from INSERTED
		insert into saudit values('Student ID ' + Cast(@id as varchar(50))+ ' updated at ' + Cast(GetDate() as varchar(50)));
	END


create trigger tr_AUDITINSERTINSTEADOF
ON studentsTbl
AFTER INSERT
AS
	BEGIN
		Declare @id int
		Select @id = uid from INSERTED
		insert into saudit values('Student ID ' + Cast(@id as varchar(50))+ ' added at ' + Cast(GetDate() as varchar(50)));
	END




----------------------------------------------------------TRIGGERS IN SQL-------------------------------------------------

----------------------------------[TRIGGERS]---------------------------------------------
--1. triggers are special kind of SP which are automatically executes when an event occurs in database.
/* 
		There are 3 types of Triggers:
			1. DML Triggers
			2. DDL Triggers
			3. Database Operation Triggers: LOGON, LOGOFF, STARTUP, SHUTDOWN
		DML Triggers are fired automatically in response to DML events. (Insert,Update,Delete)

		DML Triggers are of two types:
			1. AFTER TRIGGER (ALSO CALLED FOR TRIGGERS)
			2. INSTEAD of TRIGGERS
*/	
		use batch_2021
		select *from students_tbl
-----------Creating Trigger(After Insert) - this trigger will execute if someone perfroms any insert operation
	create trigger tr_student_for_insert
	on students_tbl
	after insert
	as
	BEGIN
		print 'Something happened to student table please check..!'
	END


	drop trigger tr_student_for_insert



--now if we insert into students_tbl, this trigger will execute.
select *from students_tbl;
insert into students_tbl(name, gender, Age ,standard, teacher_id) values ('piyush','Male', 20, 11,10); -- trigger will execute

--WHERE THE TRIGGERS ARE STORED..!
--Db-> table -> triggers->


--Altering a trigger
	Alter trigger tr_student_for_insert
	on students_tbl
	after insert
	as
	BEGIN
		print 'Data has been inserted into Students Table, please check the student table..!'
	END


----------------------------------[MAGIC TABLES - INSERTED, DELETED]--------------------------------------
/*
	1. Select *from INSERTED -> whenever we create after insert trigger, and this line is written inside the trigger,
	 then every time when you perfrom insert operation, it will be stored in INSERTED magic table and also returned to console.

	2. Select *from DELETED -> whenever we create after delete trigger, and this line is written inside the trigger,
	 then every time when you perfrom delete operation, it will be stored in DELETED magic table and also returned to console.

	NOTE: these both can be used for auditing purpose, like which row has been deleted show it. same for insertion
*/

---Example of INSERTED
	create trigger tr_student_for_insertion
	on students_tbl
	AFTER INSERT
	AS
	Begin
		select *from INSERTED;
	End
	

insert into students_tbl(name, gender, Age ,standard, teacher_id) values ('Rutuja','Female', 18, 10,21); -- trigger will execute
--when this insertion is perfromed, the trigger will execute and it will return the Newly inserted row into the table.
SELECT *FROM STUDENTS_TBL


---Example of DELETED
	create trigger tr_student_for_deletion
	on students_tbl
	AFTER DELETE
	AS
	Begin
		select *from DELETED;
	End

	DROP TRIGGER tr_student_for_deletion

delete from students_tbl where id = 22;

--when this deletion is perfromed, the trigger will execute and it will return the deleted row into the table.

--NOTE:if we add 'n' number of rows than it will show the 'n' newly added rows. Same for deletetion


/* 
P.S -> We have to create an audit table, which preserves the record of the students for Students_tbl
	   whenever a new student is added or deleted with
	   the time of insertion and deletion.
*/

--1. Step 1: Create a student_audit table having Audit_id and Audit_Info
		create table student_audit(
			Audit_id int primary key identity,
			Audit_Info varchar(max)
		)

--2. Create trigger for insert
		Create trigger tr_student_for_insert_audit
		ON students_tbl
		AFTER INSERT
		AS
		BEGIN
			Declare @id int
			Select @id = id from INSERTED

			insert into student_audit values('Student with ID ' + Cast(@id as varchar(50))+ 'is added at ' + Cast(GetDate() as varchar(50)));
		END

--Testing this trigger by perfroming insert operation
insert into students_tbl(name, gender, Age ,standard, teacher_id) values ('Nisha','Female', 18, 11,20); -- trigger will execute

select *from student_audit;



--3. Create trigger for deletion audit
		Create trigger tr_student_for_delete_audit
		ON students_tbl
		AFTER DELETE
		AS
		BEGIN
			Declare @id int
			Select @id = id from DELETED

			insert into student_audit values('Existing Student with ID ' + Cast(@id as varchar(50))+ 'is deleted at ' + Cast(GetDate() as varchar(50)));
		END

--Testing the deletion audit trigger
		delete from students_tbl where id = 14;
		select *from student_audit;



--4. For update trigger
	create trigger tr_student_for_updation
	on students_tbl
	AFTER UPDATE
	AS
	Begin
		select *from INSERTED;
		select *from DELETED;
	End

--Performing the update operation
	update students_tbl set name='Akhil', gender = 'Male' where id = 9;

sp_helptext tr_student_for_updation








------------------------------------[INSTEAD OF TRIGGERS WITH VIEWS]-------------------------------------------

/*
According to the rule, if we do any INSERT/UPDATE/DELETE then it is also reflected in your original table.

P.S - we have to create a view by using two tables using join, but if we delete any record from view, the SQL engine gets confused
from which table it has to delete the data.

For this we will use DML INTEAD OF TRIGGERS with VIEWS 
*/

CREATE TABLE Employee_personal_details (
    EmpId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(50)
);

INSERT INTO Employee_personal_details (EmpId, FirstName, LastName, Address)
VALUES
(1, 'Rahul', 'Sharma', 'Delhi'),
(2, 'Priya', 'Singh', 'Mumbai'),
(3, 'Amit', 'Kumar', 'Bangalore'),
(4, 'Neha', 'Verma', 'Chennai');


CREATE TABLE Employee_salary_details (
    EmpId INT PRIMARY KEY,
    Designation VARCHAR(50),
    Salary INT,
);

INSERT INTO Employee_salary_details (EmpId, Designation, Salary)
VALUES
(1, 'Accountant', 60000),
(2, 'Manager', 80000),
(3, 'Admin', 55000),
(4, 'Incharge', 65000);

select *from Employee_personal_details;
select *from Employee_salary_details;



--creating view
create view vW_Employees
as
Select A.EmpId, A.FirstName, A.LastName, B.Designation, B.Salary from Employee_personal_details as A
INNER JOIN Employee_salary_details as B
ON A.EmpId = B.EmpId;

select * from vW_Employees;

--now if we do delete operation on this view, it will show error as this view is made by joining two tables.
delete from vW_Employees where EmpId = 4; -- View or function 'vW_Employees' 
										  -- is not updatable because the modification affects multiple base tables.
										  -- base tables (Employee_personal_details, Employee_salary_details)

--to resolve this we use INSTEAD OF TRIGGERS

create trigger tr_Insteadof_EmployeeDetails
ON vW_Employees
INSTEAD OF DELETE
AS
BEGIN
	delete from Employee_personal_details where EmpId IN (select EmpId from DELETED) 

	delete from Employee_salary_details where EmpId IN (select EmpId from DELETED) 
END

--Now if i do delete operation in view, the trigger tr_Insteadof_EmployeeDetails will invoked, and will delete the data from base tables.
-- eg:
	delete from vW_Employees where Empid = 1; -- 3 rows affected

--Checking the contents of original table as well as view
	select * from vW_Employees; --data is deleted

	select *from Employee_personal_details;  --data is deleted
	select *from Employee_salary_details;    --data is deleted




------------------------------------[DDL Triggers]------------------------------------------- [video no 49]
--1. CREATE, ALTER, DROP - DDL triggers execute SP when DDL events occur in the database.


--FOR CREATE_TABLE
create trigger tr_for_table_create
ON database
FOR CREATE_TABLE
AS
BEGIN
	print 'New table is created inside the database :'+DB_NAME()
END

--When you create a new table, this trigger will be invoked
create table test3(id int);
drop table test1;


--FOR ALTER_TABLE
create trigger tr_for_table_alter
ON database
FOR ALTER_TABLE
AS
BEGIN
	print 'You have altered the table..!'
END


alter table test add EmpName varchar(50);
select *from test;


--FOR DROP_TABLE
create trigger tr_for_table_drop
ON database
FOR DROP_TABLE
AS
BEGIN
	print 'You have dropped the table..!'
END

drop table test;

--Location of these triggers: database->programability->database triggers




-- we can create seperate trigger combining these three operations in one.
	create trigger tr_ddl_table
	on database
	FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
	AS
	BEGIN
		print 'you have created, altered and dropped the table..!'
	END

--NOTE: CREATE_TABLE, ALTER_TABLE, DROP_TABLE these are pre-defined operations. On internet we have more like these. 
--eg: FOR CREATE_PROCEDURE

	create trigger tr_ddl_table
	on database
	FOR CREATE_PROCEDURE
	AS
	BEGIN
		print 'you have created procedure..!'
	END


--Applying the restriction: You cannot create stored procedure - USING ROLLBACK COMMAND
	create trigger tr_ddl_table
	on database
	FOR CREATE_PROCEDURE
	AS
	BEGIN
		ROLLBACK
		print 'You are not allowed to create store procedure..!'
	END

	drop trigger tr_ddl_table on database;

--testing the trigger
	create procedure spGetEmployeeees
	AS
	BEGIN
		SELECT *FROM MyEmployees;
	END

-- Similarly we can ALTER the SP, similar for views, 
-- we can also apply triggers on SERVERS, VIEWS etc.

use batch_2021





------------------------------------[Setting the execution order of TRIGGERS]-------------------------------------------
--1. using SETTRIGGERORDER (@triggername, @order, @stmttype)
-- @order - FIRST, LAST, NONE
--@stmttype - specifies the type of SQL statement (INSERT, UPDATE, DELETE)

create table TestOrder(Id int, Name varchar(20));
insert into TestOrder values (1, 'Shreya');
insert into TestOrder values (2, 'Raman');
insert into TestOrder values (3, 'Priya');
insert into TestOrder values (4, 'Ashok');




create trigger tr_order_3
ON TestOrder
AFTER INSERT
AS
BEGIN
	print 'this is the 3rd trigger'
END



create trigger tr_order_2
ON TestOrder
AFTER INSERT
AS
BEGIN
	print 'this is the 2nd trigger'
END


create trigger tr_order_1
ON TestOrder
AFTER INSERT
AS
BEGIN
	print 'this is the 1st trigger'
END


--testing of the order
insert into TestOrder values (5, 'Aditya');

--Now i want to manually set the exection order of triggers. 1st trigger then 2nd then 3rd trigger.

	execute sp_settriggerorder
	@triggername = 'tr_order_1',
	@order = 'FIRST',
	@stmttype = 'INSERT'

	execute sp_settriggerorder
	@triggername = 'tr_order_3',
	@order = 'LAST',
	@stmttype = 'INSERT'

--testing of the order, after manually setting it
insert into TestOrder values (6, 'Manav');


--Disabling the trigger
disable trigger tr_ddl_table on database;


--Enabling the trigger