-- LIKE AND WILD CARD IN SQL


--day 12 june 
--Q1. NAME START FROM A
select * from MYEMPLOYEE where empname like 'A%'

--Q2. NAME CONTAINS N
select * from MYEMPLOYEE where empname like '%n%'

-- Q3. NAME SECOND LETTER I
select * from MYEMPLOYEE where empname like '_i%'

-- Q4. NAME SECOND LETTER NI
select * from MYEMPLOYEE where empname like '%ni%'

-- Q5. NAME HAVE 4 LETTERS
select * from MYEMPLOYEE where empname like '____'
select * from MYEMPLOYEE where len(empname)=4


-- Q6. NAME NOT STARTING WITH A
select * from MYEMPLOYEE where empname not like 'A%'

-- Q7. NAME START WITH S AND END WITH A
select * from MYEMPLOYEE where empname like 's%' and empname like '%a'

-- Q8. NAME CONTAINS E
select * from MYEMPLOYEE where empname like '%e%'

-- Q9. NAME COTAINS PATTERN L
select * from MYEMPLOYEE where empname like '%l%'

-- Q10. NAME NOT CONTAINS A
select * from MYEMPLOYEE where empname not like '%A%'

-- Q11. NAME IN THE RANGE A TO M
SELECT *
FROM MYEMPLOYEE
WHERE empname LIKE '[A-M]%'

-- Q12. NAME NAME START WITH A OR R
select * from MYEMPLOYEE where empname like 'A%' or empname like 'R%'

-- Q13. NAME ENDS WITH I AND DOES NOT CONTAINS A 
select * from MYEMPLOYEE where empname like '%i' and empname like '_%A%'

-- Q14. NAME START WITH S,A,N
select * from MYEMPLOYEE where empname like 'S%' or empname LIKE 'A%' or EMPNAME like 'N%'

SELECT *
FROM MYEMPLOYEE
WHERE empname LIKE '[S,A,N]%'
