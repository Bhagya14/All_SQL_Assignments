create database students_db

use students_db
create table tbl_students
(
studentid int,
studentname varchar(100),
studentcity varchar(100),
studentdept varchar(100),
studentdob datetime,
studentdoj datetime,
studentstatus varchar(100),
marks10th int,
marks12th int
)
select * from tbl_students
insert tbl_students values(1001,'bhagya','bang','cse','06/14/1995','12/12/2017','completed',550,980)
insert tbl_students values(1002,'kavya','bang','cse','05/14/1996','12/12/2016','studying',540,970)
insert tbl_students values(1003,'megha','hyd','cse','06/16/1995','12/12/2017','completed',555,929)
insert tbl_students values(1004,'suma','hyd','cse','05/14/1996','12/12/2016','studying',68,97)
insert tbl_students values(1005,'latha','chennai','cse','02/18/1994','12/12/2017','completed',75,98)
insert tbl_students values(1006,'mouna','chennai','cse','03/24/1996','12/12/2016','studying',79,89)
insert tbl_students values(1007,'suryaa','bang','cse','07/23/1995','12/12/2017','completed',55,48)
insert tbl_students values(1008,'chaitra','hyd','cse','09/24/1995','12/12/2017','completed',50,83)
insert tbl_students values(1009,'sravs','bang','cse','07/04/1995','12/12/2017','completed',40,80)
insert tbl_students values(1010,'siri','bang','cse','10/17/1995','12/12/2017','completed',89,98)
select * from tbl_students

--list of bang city
select * from tbl_students
where studentcity='bang'

--12th marks between 60 and 75

select * from tbl_students
where marks12th between 60 and 75

--student details

select studentid,studentname,studentdob,studentstatus
from tbl_students

--12th desc 10th asc
select * from tbl_students
order by marks12th desc,marks10th asc 

--total no of students

select COUNT(*) from tbl_students

--list who joined in january

select * from tbl_students
where datename(mm,studentdoj) in ('january')

--who joined 2 years ago //

select * from tbl_students
where DATENAME(YYYY,studentdoj)<DATENAME(yyyy,getdate())

--deptnames no of employees

select studentdept,COUNT(*) from tbl_students
group by studentdept

--cities count

select studentcity,COUNT(*) from tbl_students
group by studentcity




