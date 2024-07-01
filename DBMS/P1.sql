--created table and checked the constraints
/*
--create table sc1.TB1(
--ID INT PRIMARY KEY, 
--NAME VARCHAR(20),
--EMAIL VARCHAR(15) NOT NULL,
--ADDRESS VARCHAR(30) UNIQUE,
--DOB DATE,
--AGE INT,
--SECTION VARCHAR(10) DEFAULT('NTPP-2'),
--SCORE INT CHECK(SCORE>=70),
--)
*/

--insert into sc1.TB1 values(1,'AYUSH','AYUSH@cuchd.in','NEK CHAND TOWER 5','2002-09-30',21,'KRG1',85);

--check constraint
--insert into sc1.TB1 values(2,'SAKSHAM','SAKS@cuchd.in','NEK CHAND TOWER 1','2003-11-13',20,'AIML1',65);

--default value
--insert into sc1.TB1 values(3,'AARYAN','AARYAN@cuchd.in','NEK CHAND TOWER 2','2004-10-20',19,DEFAULT,75);
--insert into sc1.TB1 values(4,'MRADUL','MRADUL@cuchd.in','NEK CHAND TOWER 3','2003-09-26',20,'ECE',95);

--primary key contraint, unique contraint
--insert into sc1.contraintTABLE values(4,'MISHRA','MISH@cuchd.in','NEK CHAND TOWER 2','2003-09-26',20,'ECE',95);



--select * from sc1.contraintTABLE;



--PROBLEMS 
--1. auto increment
--2. auto increment from 100 to 105..
--3. insert multiple values 
--4. foreign key constraints
--5. occurences and the counts
--6. find 2 and 3 max in the table salary


--Q1) auto increment
--create table TB1(
--ID INT PRIMARY KEY IDENTITY(100,5), 
--NAME VARCHAR(20),
--EMAIL VARCHAR(15) NOT NULL,
--ADDRESS VARCHAR(30) UNIQUE,
--DOB DATE,
--AGE INT,
--SECTION VARCHAR(10) DEFAULT('NTPP-2'),
--SCORE INT CHECK(SCORE>=70),
--)

--Q2) increment from 100 ++5

--create table TB1(
--ID INT PRIMARY KEY IDENTITY(100,5), 
--NAME VARCHAR(20),
--EMAIL VARCHAR(15) NOT NULL,
--ADDRESS VARCHAR(30) UNIQUE,
--DOB DATE,
--AGE INT,
--SECTION VARCHAR(10) DEFAULT('NTPP-2'),
--SCORE INT CHECK(SCORE>=70),
--)

--insert into TB1 values('AYUSH','AYUSH@cuchd.in','NEK CHAND TOWER 5','2002-09-30',21,'KRG1',85);
--insert into TB1 values('SAKSHAM','SAKS@cuchd.in','NEK CHAND TOWER 1','2003-11-13',20,'AIML1',75);
--insert into TB1 values('AARYAN','AARYAN@cuchd.in','NEK CHAND TOWER 2','2004-10-20',19,DEFAULT,75);
--insert into TB1 values('MRADUL','MRADUL@cuchd.in','NEK CHAND TOWER 3','2003-09-26',20,'ECE',95);


--Q3. multiple insertion 
--insert into TB1 (NAME,EMAIL,ADDRESS,DOB,AGE,SECTION,SCORE) values
	--				 ('AYUSH','AYUSH@cuchd.in','NEK CHAND TOWER 5','2002-09-30',21,'KRG1',85),
		--			   ('SAKSHAM','SAKS@cuchd.in','NEK CHAND TOWER 1','2003-11-13',20,'AIML1',75),
			--		   ('AARYAN','AARYAN@cuchd.in','NEK CHAND TOWER 2','2004-10-20',19,DEFAULT,75),
				--	   ('MRADUL','MRADUL@cuchd.in','NEK CHAND TOWER 3','2003-09-26',20,'ECE',95);



--select * from TB1;

--tables created 
/*
create table customer(
	CID int primary key,
	CNAME varchar(20),
	ADDRESS varchar(MAX) NOT NULL,
	CITY varchar(15),
);
*/
/*
create table orders(
	OID int primary key,
	ITEM varchar(20),
	QUANTITY INT,
	PRICE INT,
	CID INT foreign key references customer(CID)
	on update cascade
	on delete cascade
);
*/

--q.4) FOREIGN KEY ANOMALIES
--insert into customer (CID,CNAME,ADDRESS,CITY) values 
-- (1,'AYUSH','NC5','DELHI'),
 --(2,'SAKSHAM','NC3','REWARI'),
 --(3,'MRADUL','NC4','LUCKNOW');

 --insert into orders(OID,ITEM,QUANTITY,PRICE,CID) values 
 --(1,'TRIMMER',2,2400,1),
 --(2,'TSHIRT',1,500,3),
 --(3,'LAPTOP',2,77000,1),
 --(4,'PEN',5,500,1),
 --(5,'CANDY',4,1000,3);

 

 --anomalies
 --child table 
--insert
--insert into orders values (6,'BAG',1,750,6); --6 CID does not exist

--update(anomally)
--update orders set CID=7 where OID=3;

--delete (no anomally)
--delete from orders where OID=3;

--parent table 
--insert
--no anomally

-- update (anomally)
--update customer set CID=7 where CID=3;   updates the 3 to 7 due to cascade hence changes are reflected

--delete (anomally)
--delete from customer where CID=7;

--Q5) find the sum of single occurences in a table 
/*
create table OCC(
ID INT PRIMARY KEY IDENTITY,
val INT,
);
*/
--insert into OCC(val) values (1),(2),(2),(5),(3),(4),(3),(4);
/*
SELECT val
FROM OCC
GROUP BY val
HAVING COUNT(*) = 1;
*/
/*
SELECT SUM(val) AS ANS
FROM OCC
WHERE val IN (
    SELECT val
    FROM OCC
    GROUP BY val
    HAVING COUNT(*) = 1
);
*/

--Q6) find the 2nd and 3rd highest salary 
/*
create table SALARY(
ID INT PRIMARY KEY IDENTITY,
val float,
);
*/
--insert into SALARY (val) values (1000),(2000),(3000),(4000),(5000);
/*
	SELECT val AS ANS2
	FROM SALARY
	WHERE val = (
		SELECT MAX(val)
		FROM SALARY
		WHERE val < (
			SELECT MAX(val)
			FROM SALARY
    )
);

SELECT val AS ANS3
FROM SALARY
WHERE val = (
    SELECT MAX(val)
    FROM SALARY
    WHERE val < (
        SELECT MAX(val)
        FROM SALARY
        WHERE val < (
            SELECT MAX(val)
            FROM SALARY
        )
    )
);
*/