-- home task 1 :
-- col1 col2 col3 
-- output:: col1 max(col2,col3)
USE DB1;
/*
CREATE TABLE HMT1(
	COL1 INT IDENTITY,
	COL2 INT,
	COL3 INT,
	);

INSERT INTO HMT1  (COL2,COL3) VALUES 
(5,1),
(1,4),
(2,3),
(3,5),
(1,1),
(2,6),
(3,2);
*/
SELECT 
    col1, 
    (CASE WHEN col2 > col3 THEN col2 ELSE col3 END) AS Larger
FROM HMT1;



-- home task 2: 
-- col1 col2
-- 1    a,b,c
-- 2    a,b
-- output:: col1 count(col2)	
--CREATE TABLE HMT2(col1 INT IDENTITY,
--					col2 VARCHAR(20));

--INSERT INTO HMT2 (col2) VALUES 
--('a,b,c,d'),
--('a,b'),
--('a,b,c'),
--('a'),
--('a,b,c,d,e');

--select * from HMT2;

select col1,col2 , len(replace(col2,',','')) as counting from HMT2;

-- home task 3:
-- col1 email
-- 1	vineet@gmail.com
-- 2	anish@outlook.com
-- 3 	vanelknasdf@hotmail.com

-- output :: col1 domain()

/*
CREATE TABLE HMT3(
	COL1 INT IDENTITY,
	EMAIL VARCHAR(40)
);

INSERT INTO HMT3 (EMAIL) VALUES 
('speedcuberayush@gmail.com'),
('21BCS9869@cuchd.in'),
('ayush@hotmail.com'),
('ayush@yahoo.in'),
('9724132257@paytm'),
('ayush@outlook.com');
*/
SELECT 
    col1, 
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS domain
FROM 
    HMT3;
