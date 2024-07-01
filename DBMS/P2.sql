--use db1
--create table tt1(
--id int identity primary key,
--name varchar(20),
--managerID int,
--);


--insert into tt1(name,managerID) values
--insert into tt1(name,managerID) va 
--('Mishra',1),
--('Undertaker',4);

--('Virat',2),
--('Anushka',1),
--('Hrithik',4),
--('Dhoni',1),
--('Ayush',4);


select * from tt1;

select A.name as employee,B.name as manager
from tt1 as A
inner join tt1 as B
on 
A.managerid=B.id;


