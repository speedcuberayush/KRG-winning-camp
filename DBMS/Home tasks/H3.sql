--HM1
--CREATE TABLE hmEmp1 (
--    eid INT PRIMARY KEY,
--    dept VARCHAR(10),
--    scores DECIMAL(5, 2)
--);

--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (1, 'd1', 1.00);
--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (2, 'd1', 5.28);
--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (3, 'd1', 4.00);
--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (4, 'd2', 8.00);
--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (5, 'd1', 2.50);
--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (6, 'd2', 7.00);
--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (7, 'd3', 9.00);
--INSERT INTO hmEmp1 (eid, dept, scores) VALUES (8, 'd4', 10.20);


--UPDATE hmEmp1
--SET scores = (
--    SELECT MAX(sub.scores)
--    FROM hmEmp1 AS sub
--    WHERE sub.dept = hmEmp1.dept
--);


--or 
-- Update the scores for each department to the highest score in that department
UPDATE h1
SET h1.scores = h2.MaxScore
FROM hmEmp1 h1
INNER JOIN (
    SELECT
        dept,
        MAX(scores) AS MaxScore
    FROM hmEmp1
    GROUP BY dept
) h2
ON h1.dept = h2.dept;

--select * from hmEmp1

--HM2-
--CREATE TABLE hmEmp (
--    empid INT PRIMARY KEY,
--    ename VARCHAR(50),
--    salary DECIMAL(10, 2),
--    managerid INT
--);

--INSERT INTO hmEmp (empid, ename, salary, managerid) VALUES (1, 'aman', 50000, NULL);
--INSERT INTO hmEmp (empid, ename, salary, managerid) VALUES (2, 'shreya', 40000, 1);
--INSERT INTO hmEmp (empid, ename, salary, managerid) VALUES (3, 'piysuh', 70000, 1);
--INSERT INTO hmEmp (empid, ename, salary, managerid) VALUES (4, 'neha', 55000, NULL);
--INSERT INTO hmEmp (empid, ename, salary, managerid) VALUES (5, 'nitika', 65000, 4);
--INSERT INTO hmEmp (empid, ename, salary, managerid) VALUES (6, 'manish', 50000, 4);

--select * from hmEmp


SELECT e.empid,e.ename
FROM hmEmp e
JOIN hmEmp m
ON e.managerid = m.empid
WHERE e.salary > m.salary;


CREATE TABLE hmEmp3 (
    eid INT IDENTITY,
    empname CHAR(1),
	geneder CHAR(1),
);

select * from hmEmp3;

--insert into hmEmp3 (empname,geneder) values 
--('A','M'),
--('B','M'),
--('C','F'),
--('D','M'),
--('E','F'),
--('F','M'),
--('G','M'),
--('H','M'),
--('I','F'),
--('J','F');



SELECT
	geneder,(COUNT(*) * 100/10) AS Percentage
FROM
    hmEmp3
GROUP BY
	geneder;




select geneder,(
case 
when geneder = 'm' then 
          count(geneder)*100/(select count(*) from hmEmp3) 
	else count(geneder)*100/(select count(*) from hmEmp3)
	end )  as percentage
from hmEmp3 group by geneder;


drop table hmEmp3;

select * from v1;

create view v2 as select * from hmEmp1;

select * from v2

drop table hmEmp1
select * from v1
select * from hmEmp3
delete from hmEmp3 where eid = '1'
insert into v1 values ('A','M');

EXEC sp_rename 'hmEmp3.geneder', 'gender', 'COLUMN';



update v1 set geneder='F' where eid =1;

exec sp_help 'v2';