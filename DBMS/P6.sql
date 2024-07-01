use practiceT;

-- inner most query runs the first
/*
main query (q1 (q2 (q3)))
types of subqueries
1. scaler subqueries  : return only 1 value as output
	operaters used: >,<,>=,<=,<>

2. multi values subqieries :  return more than one row as output
	operators used: IN, ANY(OR), ALL(AND)	
	maximum value in any
	where salary > any (4500,5000) checks for all index seperately
	
	maximum value in all
	where salary > all (4500,5000) checks for all index in one type


3. self contained subqueries :	can run independent query Q1( Q2)

4. co related subqueries : cannot run independently query cannot run isolately


					types 
		scalar						multivalued
self-cont	correlated		self-cont		correlated
	*/


----------------------------SUB-QUERIES-------------------------------------
--EMPID EMPNAME GENDER SALARY CITY DEPT_ID
--1	Amit	Male	50000	Delhi	2
--2	Priya	Female	60000	Mumbai	1
--3	Rajesh	Male	47000	Agra	3
--5	Anil	Male	54000	Agra	2
--6	Sunita	Female	48000	Mumbai	1
--7	Vijay	Male	49000	Agra	3 
--8	Ritu	Female	62000	Mumbai	2
--9	Alok	Male	51000	Delhi	1
--10	Neha	Female	55000	Agra	4
--11	Simran	Female	35000	Agra	3


--ID DEPT_NAME
--1	Accounts
--2	HR
--3	Admin
--4	Counselling



create table empl(
empid int identity,
empname varchar(20),
gender char(1),
salary int,
city varchar(15),
deptid int
);

--insert into empl (empname,gender,salary,city,deptid) values 
--('Amit','M',50000,'Delhi',2),
--('Priya','F',60000,'Mumbai'	,1),
--('Rajesh','M',47000	,'Agra'	,3),
--('Anil'	,'M',54000	,'Agra',2),
--('Sunita','F',48000	,'Mumbai'	,1),
--('Vijay','M',49000	,'Agra'	,3),
--('Ritu','F',62000	,'Mumbai'	,2),
--('Alok'	,'M',51000	,'Delhi'	,1),
--('Neha','F',55000,'Agra'	,4),
--('Simran',	'F',	35000	,'Agra',	3);


create table dept(
id int identity,
dname varchar(20));

--insert into dept (dname) values 
--('Accounts'),
--('HR'),
--('Admin'),
--('Conselling');


	--Practice Set

	--1.Find employees who earn more than the average salary of their respective departments.
SELECT e.empname, e.salary, d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM empl
    WHERE deptid = e.deptid
);

	--2. List the employees who work in the same city as 'Priya'.
SELECT empname
FROM empl
WHERE city = (SELECT city FROM empl WHERE empname = 'Priya');

	--3. Find the employees whose salary is greater than the minimum salary in the 'HR' department.
SELECT e.empname, e.salary
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary > (
    SELECT MIN(salary)
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'HR')
);

	--4. Retrieve the names of employees who do not work in the 'Admin' department.
SELECT e.empname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE d.dname <> 'Admin';


	--5. List the employees who are in the same department as 'Alok' and earn more than 'Alok'.
SELECT empname, salary
FROM empl
WHERE deptid = (SELECT deptid FROM empl WHERE empname = 'Alok')
  AND salary > (SELECT salary FROM empl WHERE empname = 'Alok');

	--6. Find employees who have the same salary as 'Vijay'.
SELECT empname
FROM empl
WHERE salary = (SELECT salary FROM empl WHERE empname = 'Vijay');

	--7. List the employees whose salary is not the maximum in their respective departments.
SELECT e.empname, e.salary, d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary < (
    SELECT MAX(salary)
    FROM empl
    WHERE deptid = e.deptid
);

	--8. Retrieve the department names that have employees with a salary greater than 60000.
SELECT DISTINCT d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
WHERE e.salary > 60000;

	--9. Find the employees whose salary is greater than the average salary of all employees.
SELECT empname, salary
FROM empl
WHERE salary > (SELECT AVG(salary) FROM empl);

	--10. List the departments which have more than 2 employees.
SELECT d.dname
FROM empl e
JOIN dept d ON e.deptid = d.id
GROUP BY d.dname
HAVING COUNT(e.empid) > 2;

	--11. Retrieve the employees who have the second highest salary in their department.
SELECT max(salary) as maxm
FROM empl
WHERE salary < (SELECT MAX(salary) FROM empl);

SELECT * FROM empl where salary IN(
SELECT max(salary) as maxm
FROM empl
WHERE salary < (SELECT MAX(salary) FROM empl));

select * from empl order by salary desc;
	--12. Find the names of employees who work in departments that have a salary sum greater than 150000.
SELECT empname, salary
FROM empl
WHERE salary > (SELECT AVG(salary) FROM empl);

	--13. List the employees who have a salary greater than every employee in the 'Admin' department.
SELECT e.empname, e.salary
FROM empl e
WHERE e.salary > ALL (
    SELECT salary
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'Admin')
);

	--14. Retrieve the employees who joined before the employee with the highest salary in 'Counselling' department.
select * from dept;
select * from empl;


	--15. Find the departments where the minimum salary is greater than 40000.
SELECT d.dname
FROM dept d
JOIN empl e ON d.id = e.deptid
GROUP BY d.dname
HAVING MIN(e.salary) > 40000;

	--16. List employees who earn more than the average salary of the 'Accounts' department.
SELECT e.empname, e.salary
FROM empl e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'Accounts')
);

	--17. Retrieve the employees who have the same gender as 'Simran' and work in 'HR' department.
SELECT e.empname
FROM empl e
WHERE e.gender = (SELECT gender FROM empl WHERE empname = 'Simran')
  AND e.deptid = (SELECT id FROM dept WHERE dname = 'HR');


	--18. Find the employees whose salary is within the top 3 highest salaries in the 'Admin' department.
SELECT e.empname, e.salary
FROM empl e
WHERE e.deptid = (SELECT id FROM dept WHERE dname = 'Admin')
  AND e.salary IN (
    SELECT DISTINCT TOP 3 salary
    FROM empl
    WHERE deptid = (SELECT id FROM dept WHERE dname = 'Admin')
    ORDER BY salary DESC
);



	--19. List the departments where the average salary of employees is greater than 55000.
SELECT d.dname
FROM dept d
JOIN empl e ON d.id = e.deptid
GROUP BY d.dname
HAVING AVG(e.salary) > 55000;

	--20. Retrieve the employees whose salary is higher than the average salary of employees in their respective cities.
SELECT e.empname, e.salary, e.city
FROM empl e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM empl
    WHERE city = e.city
);
