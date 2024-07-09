/* 
tsql : transaction is a single unit of work
tcL commands
acid properties 

transactions are manageed at the connection level query file is known as connections

begin transaction or tran
end empty or transactions

commit is important
to save data permanently


implicit : done by server
explicit : done by DBA

set isolation level to read uncommited


lifecycle 
begin - > partially commited - > full commit / fail
	- > 


	either we have to commit the transaction or rollback
	try catch in multi line transaction 
	set transaction isolation level read uncommited : not a good practice dirty read


	exception handling

	begin try
	end try

	begin catch
	end catch



	error_number()
	error_siveverity(): how much error percentage
	error_state():  
	erorr_procedure(): kis procedure ko call krr raha hai
	error_line(): error line 
	error_message(): message display

	savepoints 
	save transaction savet1

*/

use practiceT;
select * from MyEmployees;



---------------------------TRANSACTION IN SQL---------------------------
/*
	- Whenever we perform any operation (CRUD) 
	inside the database, these operations are treated as 
	  TRANSACTIONS.
	- Also known as T-SQL.
*/
-- 1. T-SQL - transaction is a single unit of work.
-- 2. TCL - TCL commands COMMIT and ROLLBACK, SAVEPOINTS
-- 3. ACID Properties
-- 4. Transactions are managed at 
	--Connection(Query File is known as connection) Level.




BEGIN TRANSACTION
	UPDATE STUDENTS SET NAME = 'HARDIK' WHERE ID = 9

COMMIT TRANSACTION --TO SAVE DATA PERMANENTLY

--OR - READ(DATA- UNCOMMITTED)
-- SET THE ISOLATION LEVEL TO READ UNCOMMITETED

	-- DIRTY READ
	--READ UNCOMMITED

/*
	IMPLICIT TRANSACTION: DONE BY SERVER ITSELF
		UPDATE STUDENTS SET NAME = 'HARDIK' WHERE ID = 9

	EXPLICIT TRANSACTION: DONE BY DBA
		BEGIN TRANSACTION
		UPDATE STUDENTS SET NAME = 'HARDIK' WHERE ID = 9


	BEGIN TRANSACTION -> PARTIALLY COMMITTED ->FULL COMMIT/ FAIL
					  -> FULLY COMMITTED -> SUCCESSFULLY COMPLETED


	BEGIN TRANS
		DATA
		
		ROLLBACK TRAN
*/








--For normal statements like update, if i am updating some data in the table then it cannot be undone.
--eg: 
	update Students set Name = 'Ayush' where Id = 6;        --IMPLICIT TRANSACTION
--Now if i want to rollback/undo this command i cannot do it.
--I should have some UNDO mechanism. for that we have TRANSACTION in SQL

-- CASE 1: Without Commit
-- We can write that update command inside a Transaction
Begin Transaction                              --EXPLICIT TRANSACTION
	update Students set Name = 'Ayush' where Id = 6; 

/*
NOTE: If i open a new query tab (new connection) and try to do select * from Students in it. It will not
	  run as we have not commited the transaction. So we have to commit it.
*/


-- CASE 2: With Commit
Begin Transaction
	update Students set Name = 'Ayush' where Id = 6; 
Commit Transaction -- it will commit the changes done by update command inside the transaction.



--Suppose I want to rollback the transaction.
-- CASE 2: With Rollback
Begin Transaction
	update Students set Name = 'Ayush' where Id = 6; 

Rollback Transaction; -- UNDO

Commit Transaction; -- Permanent Commit in table




--NOTE: Either you should do the commit OR rollback to the transaction. (MUST ACTION)


-- We can have multiple operations inside a transaction. The condition is all the commands
-- should be correct and working. If any of the command fails, transaction will  be rollbacked.

Begin Transaction
	update Students set Name = 'Ayush' where Id = 5; 
	delete from Students where Id = 6;

-- after doing this transaction I have two options, either i can rollback the transaction or i can commit the changes permanently.

Rollback Transaction; -- UNDO

Commit Transaction ;


--Setting the ISOLATION LEVEL to READ UNCOMMITED by defaultt it is READ COMMITED.
/*
NOTE: If i open a new query tab (new connection) and try to do select * from Students in it. It will not
	  run as we have not commited the transaction. So we have to commit it.

	  we can make it visible in another connection

	  if we want to see the uncommited data in another connection, in that case we have to use :
*/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;   --In  a seperate connection file, if we write this then we can se uncommited data.


--EXCEPTIONAL HANDLING
		
		BEGIN TRY
			SELECT 10/0
			PRINT 'EXCEPTION OCCURED'
		END TRY

		BEGIN CATCH
			PRINT 'CANNOT DIVIDE BY ZERO'
		END CATCH













--------------------------[TRY CATCH]--------------
--1.  Demonstrate try-catch
		BEGIN TRY
			select 10/0
			print 'New Line for testing'
		END TRY

		BEGIN CATCH
			print 'Cannot divide by zero'
		END CATCH


--2. Example: Storing varchar in Age column
		BEGIN TRY
			Update Students set Age = 'abc' where id = 1
		END TRY

		BEGIN CATCH
			SELECT 
			ERROR_NUMBER() AS [ERROR_NUMBER]
			print 'You cannot insert string value in this attribute'
		END CATCH


/*
	We can get the information about the error like, error number, error severity etc.
	we have fucntions for this

	1. ERROR_NUMBER()
	2. ERROR_SEVERITY()
	3. ERROR_STATE()
	4. ERROR_PROCEDURE()
	5. ERROR_LINE()
	6. ERROR_MESSAGE()
*/

CREATE TABLE Students (
    ID INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    Name VARCHAR(50) NOT NULL,        -- Student's name (up to 50 characters)
    Age INT NOT NULL,                 -- Student's age
    Class VARCHAR(10) NOT NULL        -- Class/grade of the student
);


INSERT INTO Students (Name, Age, Class)
VALUES ('Anisha', 16, '8'),
       ('Neha', 17, '8'),
       ('Mayank', 18, '9'),
       ('Ayush', 15, '7'),
       ('Raman', 23, '10');


		BEGIN TRY
			select 10/0
			print 'New Line for testing'
		END TRY

		BEGIN CATCH
		print 'cannot divide by zero'
		select
			ERROR_NUMBER() as [ERROR NUMBER],
			ERROR_SEVERITY() as [ERROR SEVERITY],
			ERROR_STATE() as [ERROR STATE],
			ERROR_PROCEDURE() as [ERROR PROCEDURE],
			ERROR_LINE() as [ERROR LINE],
			ERROR_MESSAGE() as [ERROR MESSAGE]
		END CATCH



-- For a Procedure
create Procedure ErrorProcedure1
as
BEGIN
		BEGIN TRY
			select 10/0
			print 'New Line for testing'
		END TRY

		BEGIN CATCH
		print 'cannot divide by zero'
		select
			ERROR_NUMBER() as [ERROR NUMBER],
			ERROR_SEVERITY() as [ERROR SEVERITY],
			ERROR_STATE() as [ERROR STATE],
			ERROR_PROCEDURE() as [ERROR PROCEDURE],
			ERROR_LINE() as [ERROR LINE],
			ERROR_MESSAGE() as [ERROR MESSAGE]
		END CATCH
END
	
execute ErrorProcedure1



-----------------------------[TRANSACTIONS WITH TRY CATCH]----------------------
select *from Students;

/*
	write 3 insert statements inside a transaction, if last transaction fails then, you have to rollback
	the transaction to its original state.
*/

SELECT *FROM STUDENTS

BEGIN TRY
	BEGIN TRANSACTION
		insert into Students(Name, Age, Class) values ('Anisha',16,8);
		insert into Students(Name, Age, Class) values ('Neha',17,8);
		insert into Students(Name, Age, Class) values ('Mayank',18,9);
	COMMIT TRANSACTION --permanent data save
	print 'Transaction Successfully Done'
END TRY

BEGIN CATCH
--if any error occurs in any of the 3 lines then transaction will be rolled back.
	ROLLBACK TRANSACTION
	print 'Transaction Failed..!'
	select ERROR_MESSAGE() as [ERROR MESSAGE]
END CATCH

--this will execute successfully..!


BEGIN TRY
	BEGIN TRANSACTION
		insert into Students(Name, Age, Class) values ('ANUJ',17,9);
		insert into Students(Name, Age, Class) values ('SHIVANSH','Meena',9); -- this line will not execute, and it will rollback
																		   -- all the above lines.
		
	COMMIT TRANSACTION --permanent data save
	print 'Transaction Successfully Done'
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION
	print 'Transaction Failed..!'
	select ERROR_MESSAGE() as [ERROR MESSAGE]
END CATCH


delete from Students where id = 10



-----------------------SAVE POINTS IN TRANSACTIONS-----------------------------------

BEGIN TRANSACTION
	insert into Students(Name, Age, Class) values ('Nitasha',21,9);
	SAVE TRANSACTION SAVE_PT1



BEGIN TRANSACTION
	insert into Students(Name, Age, Class) values ('Raman',23,10);
	SAVE TRANSACTION SAVE_PT2


insert into Students(Name, Age, Class) values ('Vanshika',20,8);


--ROLLING BACK TO THE SPECIFIC SAVE POINT

BEGIN TRANSACTION
	ROLLBACK TRANSACTION SAVE_PT1


----student table with marks return average
----id name marks
--1 A 85,86,84,82,74
--2 B 94,58,65,25,54
--3 C 52,65,........
--4 D .....
--5 E .......
drop table students;

--CREATE TABLE student (
--    id INT PRIMARY KEY,
--    name VARCHAR(50),
--    marks VARCHAR(255)
--);

---- Insert sample data into the student table
--INSERT INTO student (id, name, marks) VALUES
--(1, 'A', '85,86,84,82,74'),
--(2, 'B', '94,58,65,25,54'),
--(3, 'C', '52,65,70,75,60'),
--(4, 'D', '88,72,91,85,79'),
--(5, 'E', '75,81,67,68,74');

--CREATE FUNCTION fn_CalculateAverageMarks (@marks VARCHAR(MAX))
--RETURNS FLOAT
--AS
--BEGIN
--    DECLARE @start INT, @end INT, @value INT, @sum INT, @count INT
--    SET @start = 1
--    SET @sum = 0
--    SET @count = 0

--    WHILE @start <= LEN(@marks)
--    BEGIN
--        SET @end = CHARINDEX(',', @marks, @start)
--        IF @end = 0
--            SET @end = LEN(@marks) + 1

--        SET @value = CAST(SUBSTRING(@marks, @start, @end - @start) AS INT)
--        SET @sum = @sum + @value
--        SET @count = @count + 1

--        SET @start = @end + 1
--    END

--    RETURN CAST(@sum AS FLOAT) / @count
--END

SELECT
    id,
    name,
    dbo.fn_CalculateAverageMarks(marks) AS average_marks
FROM student;


--SELECT
--    id,
--    name,
--    (SELECT AVG(CAST(value AS FLOAT))
--     FROM STRING_SPLIT(marks, ',')
--    ) AS average_marks
--FROM student;
