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


SELECT
    id,
    name,
    (SELECT AVG(CAST(value AS FLOAT))
     FROM STRING_SPLIT(marks, ',')
    ) AS average_marks
FROM student;



create table products(
product_ID int identity primary key,
productName varchar(20),
category varchar(20)
);


create table sales(
saleID int identity primary key ,
product_id int foreign key references products(product_id),
sale_date date,
amount int
);


insert into products (productName,category) values 
('KEYBOARD','ELECTRONICS'),
('MOUSE','ELECTRONICS'),
('JUICE','FOOD'),
('EGG','FOOD'),
('BOOK','STATIONARY'),
('PEN','STATIONARY');

insert into sales (product_id,sale_date,amount) values 
(2,'2024-07-10',2000),
(2,'2024-02-05',1000),
(5,'2024-03-11',2400),
(4,'2024-06-12',1200),
(3,'2024-07-10',1100),
(1,'2024-01-11',200),
(1,'2024-03-12',1400),
(2,'2024-07-09',1500),
(6,'2024-03-10',20),
(2,'2024-07-10',2000),
(6,'2024-07-10',10);


select * from sales;
select * from products;

select s.*,p.* from sales s 


--procedure should accept the start date as input and return the totla sales amount within the spefic category in given range;



SELECT SUM(s.amount) AS TotalSalesAmount
FROM sales s
INNER JOIN products p ON s.product_id = p.product_ID
WHERE p.category = 'ELECTRONICS'
      AND s.sale_date >= '2023-09-30';



CREATE PROCEDURE spGetTotalSalesAmount
    @StartDate DATE,
    @Category VARCHAR(20)
AS
BEGIN
    SELECT SUM(s.amount) AS TotalSalesAmount
    FROM sales s
    INNER JOIN products p ON s.product_id = p.product_ID
    WHERE p.category = @Category
      AND s.sale_date >= @StartDate;
END;


CREATE PROCEDURE spGetTotalSalesAmount1
    @StartDate DATE,
	@EndDate DATE,
    @Category VARCHAR(20),
	@ans float output
AS
BEGIN
set @ans=(
    SELECT SUM(s.amount) AS TotalSalesAmount
    FROM sales s
    INNER JOIN products p ON s.product_id = p.product_ID
    WHERE p.category = @Category
      AND s.sale_date between @StartDate and @EndDate
	  );
END;

exec spGetTotalSalesAmount '2023-09-30','ELECTRONICS';

--subquery
 SELECT SUM(s.amount)
         FROM sales s
         WHERE s.product_id IN (SELECT p.product_ID
                                FROM products p
                                WHERE p.category = 'ELECTRONICS')
           AND s.sale_date between '2023-09-30' and '2024-09-30';

--ORDERS(ORDERID,CUSTOMERID,ORDERDATE,ORDERAMOUNT)
--CUSTOMERSTAS(customerid,ordercount);


create table customerstats(
customerid int primary key identity,
ordercount int default(0)
);

create table orders(
	orderid int identity primary key,
	customerid int foreign key references customerstats(customerid),
	orderamount int
);

-- Insert dummy data into customerstats
INSERT INTO customerstats (ordercount) VALUES (2);
INSERT INTO customerstats (ordercount) VALUES (2);
INSERT INTO customerstats (ordercount) VALUES (1);

-- Insert dummy data into orders
INSERT INTO orders (customerid, orderamount) VALUES (1, 100);
INSERT INTO orders (customerid, orderamount) VALUES (1, 150);
INSERT INTO orders (customerid, orderamount) VALUES (1, 200);
INSERT INTO orders (customerid, orderamount) VALUES (2, 300);
INSERT INTO orders (customerid, orderamount) VALUES (2, 250);
INSERT INTO orders (customerid, orderamount) VALUES (2, 200);
INSERT INTO orders (customerid, orderamount) VALUES (2, 150);
INSERT INTO orders (customerid, orderamount) VALUES (2, 100);
INSERT INTO orders (customerid, orderamount) VALUES (3, 500);
INSERT INTO orders (customerid, orderamount) VALUES (3, 450);


--ORDERS(ORDERID,CUSTOMERID,ORDERDATE,ORDERAMOUNT)
--CUSTOMERSTAS(customerid,ordercount);


UPDATE customerstats
SET ordercount = (
    SELECT COUNT(*)
    FROM ORDERS
    WHERE ORDERS.CUSTOMERID = customerstats.customerid
);

select * from customerstats;
select * from orders;



select * from customerstats;
select * from orders;


CREATE PROCEDURE spInsertOrderAndUpdateStats
    @cid INT,
    @amount DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        INSERT INTO orders (customerid, orderamount) VALUES (@cid, @amount);
        UPDATE customerstats
        SET ordercount = (
            SELECT COUNT(*)
            FROM orders
            WHERE orders.customerid = customerstats.customerid
        )
        WHERE customerstats.customerid = @cid;
    END TRY
    BEGIN CATCH
        PRINT 'NOT INSERTING';
    END CATCH
END;

select * from customerstats;
exec spInsertOrderAndUpdateStats 2,100;
select * from customerstats;

exec spInsertOrderAndUpdateStats 1,300;
select * from customerstats;

exec spInsertOrderAndUpdateStats 3,150;
select * from customerstats;

exec spInsertOrderAndUpdateStats 1,120;
select * from customerstats;

exec spInsertOrderAndUpdateStats 1,110;
select * from customerstats;


