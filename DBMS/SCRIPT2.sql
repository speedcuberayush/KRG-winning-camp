--creating a db
/*
create database tempdatabase; 

--rename db using alter
alter database tempdatabase modify name = newdatabase; 

use newdatabase
--using stored procedure
exec sp_rename 'newdatabase', 'tempdatabase';
*/

--ALTER TABLE COMMANDS
/*
-- Create the student2 table
CREATE TABLE student2 (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    grade_level INT
);

-- Add a new column
ALTER TABLE student2
ADD email VARCHAR(100);

-- Drop an existing column
ALTER TABLE student2
DROP COLUMN grade_level;

-- Modify an existing column
ALTER TABLE student2
MODIFY COLUMN first_name VARCHAR(100);

-- Rename a column
ALTER TABLE student2
RENAME COLUMN last_name TO surname;

-- Add a UNIQUE constraint
ALTER TABLE student2
ADD CONSTRAINT unique_email UNIQUE (email);

-- Remove the UNIQUE constraint
ALTER TABLE student2
DROP CONSTRAINT unique_email;

*/

/*
--task1:: happines table :: last 2 
/*
HM1(ranking, cname);
1	A
2	B
3	C
4	D
5	E
128 F
129 G


BOTTOM 2 UP AND A,B,C,D,E ONE TIME SORTED ANOTHER TIME DECREASING MONOTONIC
*/

/*
CREATE TABLE HM1 (
    ranking INT,
    cname CHAR(1)
);

INSERT INTO HM1 (ranking, cname) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E'),
(128, 'F'),
(129, 'G');

/*

/*
SELECT * FROM HM1
ORDER BY
    CASE
        WHEN cname IN ('F', 'G') THEN 0
        ELSE 1
    END, 
    ranking;
*/
/*
SELECT * FROM HM1
ORDER BY
    CASE
        WHEN cname IN ('F', 'G') THEN 0
        ELSE 1
    END, 
    CASE
        WHEN cname IN ('F', 'G') THEN ranking
        ELSE -ranking
    END;
*/



--task2
/*
STUDENT TABLE (ROLL,NAME,MARKS)
1. DISPLAY THE GRADE ASSOCIATED USING ALIAS
2. ADD THE COLUMN GRADE ALTER COMMAND
*/


/*

-- Create the STUDENT table
CREATE TABLE STUDENT (
    ROLL INT,
    NAME VARCHAR(50),
    MARKS INT
);

--Insert sample data into the STUDENT table
INSERT INTO STUDENT (ROLL, NAME, MARKS) VALUES
(1, 'AYUSH', 85),
(2, 'SAKSHAM', 72),
(3, 'MRADUL', 93),
(4, 'AARYAN', 60),
(5, 'HRITHIK', 78),
(6, 'VIRAT', 45);

-- Step 3: Display the Grade Associated Using Alias
SELECT ROLL, 
       NAME, 
       MARKS,
       CASE
           WHEN MARKS >= 90 THEN 'A+'
           WHEN MARKS >= 80 THEN 'A'
           WHEN MARKS >= 70 THEN 'B'
           WHEN MARKS >= 60 THEN 'C'
           WHEN MARKS >= 50 THEN 'D'
           ELSE 'F'
       END AS GRADE
FROM STUDENT

-- ADD the Column 
ALTER TABLE STUDENT
ADD COLUMN GRADE CHAR(2);

ALTER TABLE STUDENT
ADD GRADE AS 
CASE
	           WHEN MARKS >= 90 THEN 'A+'
               WHEN MARKS >= 80 THEN 'A'
               WHEN MARKS >= 70 THEN 'B'
               WHEN MARKS >= 60 THEN 'C'
               WHEN MARKS >= 50 THEN 'D'
               ELSE 'F'
           END;

-- Display the contents of the STUDENT table
SELECT * FROM STUDENT;

*/							