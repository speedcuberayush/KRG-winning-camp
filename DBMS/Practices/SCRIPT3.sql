use db1;

CREATE TABLE MYEMPLOYEE(
	EMPID INT PRIMARY KEY IDENTITY(1,1),
	EMPNAME VARCHAR(50),
	GENDER VARCHAR(10),
	SALARY INT,
	CITY VARCHAR(50),
	DEPTID INT

);

TRUNCATE TABLE MYEMPLOYEE


INSERT INTO MYEMPLOYEE (EMPNAME, GENDER, SALARY, CITY, DEPTID)
VALUES
('Amit', 'Male', 50000, 'Delhi', 2),
('Priya', 'Female', 60000, 'Mumbai', 1),
('Rajesh', 'Male', 45000, 'Agra', 3),
('Sneha', 'Female', 55000, 'Delhi', 4),
('Anil', 'Male', 52000, 'Agra', 2),
('Sunita', 'Female', 48000, 'Mumbai', 1),
('Vijay', 'Male', 47000, 'Agra', 3),
('Ritu', 'Female', 62000, 'Mumbai', 2),
('Alok', 'Male', 51000, 'Delhi', 1),
('Neha', 'Female', 53000, 'Agra', 4),
('Simran', 'Female', 33000, 'Agra', 3);


select * from myemployee
--D Q1 add new column email 
ALTER TABLE myemployee
ADD email VARCHAR(100);

--Q2 modify salary type
ALTER TABLE myemployee alter COLUMN salary BIGINT;

--D Q3 RENAME the column 'ename' to 'employeename'
exec sp_rename 'dbo.myemployee.email','email1', 'column'

--D Q4 ADD a new column date of joining 
ALTER TABLE myemployee
ADD dateofjoining DATE;

--D Q5 DROP THE COLUMN
ALTER TABLE myemployee
DROP COLUMN deptid;

--D Q6 ADD A CONSTRAINT  THE SALARY GREATER THAN 0
ALTER TABLE myemployee
ADD CONSTRAINT salary_check check (salary>0);

--Q7 ADD A UNIQUE CONSTRAINT
ALTER TABLE MYEMPLOYEE
ADD CONSTRAINT unique_email UNIQUE (email1);

--D Q8 CHANGE DATATYPE OF CITY 
ALTER TABLE myemployee
ALTER COLUMN CITY CHAR(20);

--D Q9 RENAME TABLE TO STAFF
--EXEC sp_rename 'myemployee','staff';
EXEC sp_rename 'STAFF','MYEMPLOYEE';

--D Q10 ADD NEW COLUMN PHONE NUMBER
ALTER TABLE MYEMPLOYEE
ADD PHONE VARCHAR(15) NOT NULL;


--Where clause
--Q1. Find all employees who are based in Delhi.
SELECT * FROM MYEMPLOYEE 
where CITY='Delhi'


--Q2. Retrieve the details of employees who work in department 2 or department 4.
SELECT * FROM MYEMPLOYEE 
WHERE DEPTID IN (2,4)

--Q3. Get the information of female employees.
SELECT * FROM MYEMPLOYEE
WHERE GENDER = 'FEMALE'

--Q4. Find employees whose salary is between 45,000 and 55,000.
SELECT * FROM MYEMPLOYEE 
WHERE SALARY BETWEEN 45000 AND 50000


--Q5. List the employees who are not from Agra.
SELECT * FROM MYEMPLOYEE 
WHERE CITY NOT IN ('AGRA')


--Q6. Find all employees whose names start with the letter 'S'.
SELECT * FROM MYEMPLOYEE 
WHERE EMPNAME LIKE 'S%'

--Q7. Get the details of male employees who earn more than 50,000.
SELECT * FROM MYEMPLOYEE 
WHERE SALARY>50000 AND GENDER='MALE'

--Q8. List employees who live in cities starting with the letter 'M'.
SELECT * FROM MYEMPLOYEE 
WHERE CITY LIKE 'M%'

--Q9. Find employees who are in departments other than 1 and 3.
SELECT * FROM MYEMPLOYEE 
WHERE DEPTID NOT IN (1,3)

--Q10. Retrieve details of employees whose names contain the substring 'it'.
SELECT * FROM MYEMPLOYEE 
WHERE EMPNAME LIKE '%it%'

--Q11. List the employees who are either from Delhi or Mumbai and have a salary less than 60,000.
SELECT * FROM MYEMPLOYEE 
WHERE CITY IN ('DELHI','MUMBAI') 
	AND SALARY > 60000

--Q12. Find employees who have a salary of exactly 55,000 or 60,000.
SELECT * FROM MYEMPLOYEE 
WHERE SALARY IN (55000,60000)


--Q13. Retrieve the details of employees who are not female and do not work in Mumbai.
SELECT * FROM MYEMPLOYEE 
	WHERE CITY NOT IN('MUMBAI') 
	AND 
	GENDER NOT IN ('FEMALE')

--Q14. List the employees whose names end with the letter 'a'
SELECT * FROM MYEMPLOYEE 
WHERE EMPNAME LIKE '%A'


--Q15. List the employees who are either from Agra or whose name contains the letter 'e'.
SELECT * FROM MYEMPLOYEE 
WHERE CITY='AGRA' OR EMPNAME LIKE '%E%'


--UPDATE COMMAND
--Q1. Update the salary to 60000 and the city to Pune for the employee with EmpId = 2.
UPDATE MYEMPLOYEE 
SET SALARY=60000,CITY='PUNE' 
WHERE EMPID=2;
SELECT * FROM MYEMPLOYEE

--Q2. Increase the salary by 5000 for all employees in the Delhi city.
UPDATE MYEMPLOYEE SET SALARY=SALARY+5000 
WHERE CITY='DELHI'
SELECT * FROM MYEMPLOYEE

--Q3. Set the city to Kolkata for employees with a salary between 45000 and 50000.
UPDATE MYEMPLOYEE SET CITY='KOLKATA' 
WHERE SALARY BETWEEN 45000 AND 50000
SELECT * FROM MYEMPLOYEE


--Q4. Change the city to Hyderabad for employees located in Mumbai or Agra.
UPDATE MYEMPLOYEE SET CITY = 'HYDERABAD' 
WHERE CITY IN ('MUMBAI', 'AGRA')
SELECT * FROM MYEMPLOYEE


--Q5. Update the city to Noida for employees whose name starts with 'A'.
UPDATE MYEMPLOYEE SET CITY = 'NOIDA' 
WHERE EMPNAME LIKE 'A%'
SELECT * FROM MYEMPLOYEE



--Q6. Set the salary to the average salary of all employees for the employee with EmpId = 3.
UPDATE MYEMPLOYEE SET 
SALARY=(SELECT AVG(SALARY) FROM MYEMPLOYEE) 
WHERE EMPID=3
SELECT * FROM MYEMPLOYEE

--Q7. Update the gender column to Non-binary for all employees where EmpId is even, and to Other where EmpId is odd.
UPDATE MYEMPLOYEE SET GENDER=
CASE 
	WHEN (EMPID%2=0) THEN
		 'NON BINARY'
	ELSE 
		'OTHER'
END;
/*
UPDATE MYEMPLOYEE SET GENDER=
CASE 
	WHEN (EMPID&1) THEN
		'OTHER'
	ELSE 
		 'NON BINARY'
END;
*/



SELECT * FROM MYEMPLOYEE

--Q8. Assuming there is a HireDate column, update the salary by adding 1000 for employees hired before 2022-01-01.
UPDATE MYEMPLOYEE SET SALARY=SALARY+1000 
WHERE HIREDATE>'2022-01-01'
SELECT * FROM MYEMPLOYEE


--Q9. Increase the salary of employees in each department to the maximum salary of that department.
-- Update each employee's salary to the maximum salary of their department
UPDATE MYEMPLOYEE
SET SALARY = (
    SELECT MAX(E2.SALARY)
    FROM MYEMPLOYEE E2
    WHERE MYEMPLOYEE.DEPTID = E2.DEPTID
);

SELECT * FROM MYEMPLOYEE

--ORDER BY CLAUSE
--Q1.  Retrieve the details of female employees from the Employees table, ordered by their Salary in descending order.
SELECT * FROM MYEMPLOYEE 
WHERE GENDER='FEMALE' 
ORDER BY SALARY DESC

--Q2.  Fetch the records of employees from the city 'Delhi' and department ID '2', ordered by their EmpName in ascending order.
SELECT * FROM MYEMPLOYEE 
WHERE CITY='DELHI' AND DEPTID=2
ORDER BY EMPNAME ASC

--Q3. Select the employees with a salary between 50000 and 60000, ordered by their EmpId in ascending order.
SELECT * FROM MYEMPLOYEE 
WHERE SALARY BETWEEN 50000 AND 60000
ORDER BY EMPID ASC

--Q4. Retrieve the male employees from department ID '3', ordered by their Salary in descending order.
SELECT * FROM MYEMPLOYEE 
WHERE DEPTID=3
ORDER BY SALARY DESC

--Q5. Retrieve the female employees from department ID '4', ordered by their Salary in descending order.
SELECT * FROM MYEMPLOYEE 
WHERE DEPTID =4 AND GENDER='FEMALE'
ORDER BY SALARY DESC

--Q6. Select the employees from the city 'Mumbai' with a salary greater than 50000, ordered by their EmpName in descending order.
SELECT * FROM MYEMPLOYEE 
WHERE CITY='MUMBAI' AND SALARY>50000 
ORDER BY EMPNAME DESC

--Q7. Fetch the details of employees from department ID '1' with a salary less than or equal to 55000, ordered by their EmpId in descending order.
SELECT * FROM MYEMPLOYEE 
WHERE DEPTID=1 AND SALARY<=55000
ORDER BY EMPID DESC

--Q8. Retrieve the male employees from the city 'Agra', ordered by their Salary in ascending order.
SELECT * FROM MYEMPLOYEE 
WHERE CITY='AGRA' 
ORDER BY SALARY ASC

--Q9. Select the employees with a salary between 45000 and 55000, who are male, ordered by their Dept_id in descending order.
SELECT * FROM MYEMPLOYEE 
WHERE SALARY BETWEEN 45000 AND 55000
ORDER BY DEPTID DESC


--GROUP BY CLAUSE

SELECT * FROM MYEMPLOYEE
--Q1. Group the employees by City and find the total salary for each city.
SELECT SUM(SALARY) AS TOTAL ,CITY 
FROM MYEMPLOYEE
GROUP BY CITY

--Q2. Group the employees by Dept_id and count the number of employees in each department.
SELECT COUNT(*) AS COUNT, DEPTID 
FROM MYEMPLOYEE 
GROUP BY DEPTID

--Q3. Group the employees by Gender and find the average salary for each gender.
SELECT AVG(SALARY) AS AVGSALART, GENDER 
FROM MYEMPLOYEE 
GROUP BY GENDER

--Q4. Group the employees by Dept_id and find the maximum salary in each department.
SELECT DEPTID,MAX(SALARY) AS MAXSALARY 
FROM MYEMPLOYEE 
GROUP BY DEPTID

--Q5. Group the employees by City and display cities where the total salary is greater than 150000.
SELECT CITY,SUM(SALARY) AS TOTALSALARY 
FROM MYEMPLOYEE 
GROUP BY CITY 
HAVING sum(SALARY)>150000

--Q6. Group the employees by Dept_id and display departments where the average salary is less than 55000.
SELECT DEPTID,AVG(SALARY) AS AVERAGE 
FROM MYEMPLOYEE 
GROUP BY DEPTID 
HAVING AVG(SALARY)<55000 

--Q7. Group the employees by Gender and display genders where the number of employees is more than 5.
SELECT GENDER,COUNT(*) AS TOTAL 
FROM MYEMPLOYEE 
GROUP BY GENDER 
HAVING COUNT(*)>5

--Q8. Group the employees by City and order the results by total salary in descending order.
SELECT CITY 
FROM MYEMPLOYEE 
GROUP BY CITY 
ORDER BY CITY DESC
	
--Q9. Group the employees by Dept_id and order the results by average salary in ascending order.
SELECT DEPTID,AVG(SALARY) 
FROM MYEMPLOYEE 
GROUP BY DEPTID 
ORDER BY AVG(SALARY)  

--Q10. Group the employees by City and Gender, and find the total salary for each group.
SELECT GENDER,CITY, SUM(SALARY) AS TOTAL FROM MYEMPLOYEE GROUP BY GENDER,CITY

--Q11. Group the employees by Dept_id and display departments where the maximum salary is greater than 60000.
SELECT DEPTID,MAX(SALARY) FROM MYEMPLOYEE GROUP BY DEPTID HAVING MAX(SALARY)>60000

--Q12. Group the employees by City and count the number of male employees in each city.
SELECT CITY,COUNT(*) AS TOTAL FROM MYEMPLOYEE WHERE GENDER='male' GROUP BY CITY 

--Q13. Group the employees by Dept_id, find the average salary, and display departments where the average salary is greater than 50000 for employees in 'Delhi'.
SELECT DEPTID,AVG(SALARY) FROM MYEMPLOYEE WHERE CITY='DELHI' GROUP BY DEPTID HAVING AVG(SALARY)>50000 

--Q14. Group the employees by City and Gender, and display groups where the total salary is less than 100000.
SELECT CITY,GENDER,SUM(SALARY) 
FROM MYEMPLOYEE GROUP BY CITY,GENDER HAVING SUM(SALARY)>100000

--Q15. Group the employees by Gender and count the number of employees, and display groups where the number of employees is greater than 2 in department ID '3'.
SELECT GENDER,COUNT(*) AS TOTAL 
FROM MYEMPLOYEE WHERE DEPTID=3 
GROUP BY GENDER 
HAVING COUNT(*)>=2

--Q16. Group the employees by Dept_id and order the results by maximum salary in descending order.
SELECT DEPTID,MAX(SALARY) AS MAXSALARY 
FROM MYEMPLOYEE GROUP BY DEPTID 
ORDER BY MAX(SALARY) DESC

--Q17. Group the employees by City and Gender, and order the results by the count of employees in descending order.
SELECT CITY,GENDER,COUNT(*) AS TOTAL 
FROM MYEMPLOYEE GROUP BY CITY,GENDER 
ORDER BY COUNT(*) DESC

--Q18. Group the employees by City, display groups where the total salary is greater than 120000, and order the results by City in ascending order.
SELECT CITY, SUM(SALARY) 
FROM MYEMPLOYEE GROUP BY CITY 
HAVING SUM(SALARY)>120000 
ORDER BY SUM(SALARY) ASC

--Q19. Group the employees by Gender, display groups where the average salary is less than 55000, and order the results by Gender in ascending order.
SELECT GENDER,AVG(SALARY) FROM MYEMPLOYEE 
GROUP BY GENDER 
HAVING AVG(SALARY)<55000 
ORDER BY AVG(SALARY) ASC


