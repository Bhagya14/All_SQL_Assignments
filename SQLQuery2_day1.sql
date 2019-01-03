create database Emp_db

use Emp_db

create table employees
(
employeeid int,
employeefname varchar(100),
employeelname varchar(100),
employeecity varchar(100),
employeedob datetime,
employeesalary int,
employeestatus varchar(100)
)

--add columns empdept and empdoj

alter table employees add employeedept varchar(100),employeedoj datetime 

select * from employees

--inserting some records

insert employees values(1001,'bhagya','sree','bangalore','06/14/1995',20000,'working','HR','11/12/2018')
insert employees values(1002,'mouni','ka','bangalore','10/11/1996',40000,'working','CEO','11/11/2018')
insert employees values(1003,'anil','sai','hyderabad','06/14/1985',25000,'working','developer','06/12/20')
insert employees values(1004,'sure','kha','chennai','05/15/1996',30000,'working','HR','05/01/20')
insert employees values(1005,'ram','koushik','bangalore','04/14/1985',30000,'resigned','tester','01/11/07')
insert employees values(1006,'kamal','nath','mumbai','05/15/1989',40000,'working','manager','08/12/09')
insert employees values(1007,'liki','tha','kolkatta','05/24/1998',25000,'working','team leader','11/14/19')
insert employees values(1008,'joshi','ka','chennai','06/19/1998',20000,'working','developer','09/12/20')
insert employees values(1009,'kavya','sree','surat','05/17/1995',28000,'working','HR','11/12/18')
insert employees values(1010,'natesh','setty','hyderabad','06/14/1975',60000,'resigned','HR','01/18/18')

select * from employees
--create the list of employees from chennai

select * from employees 
where employeecity='chennai'

--create a list whose salary between 25000 and 50000

select * from employees
where employeesalary between 25000 and 50000

--employee fullname,id,city

select employeefname+employeelname as employeefullname,employeeid,employeecity 
from employees

--ascending order based on length of fname


select * from employees
order by LEN(employeefname) asc 
--sum of salary

select sum(employeesalary) from employees

--total no of employees

select count(*) from employees

--january month

select * from employees
where datename(mm,employeedoj) in('january','december')

--experience is more than 5

select employeeid,DATEDIFF(yy,employeedoj,getdate()) as 'exp',COUNT(*)
from employees
group by employeeid
having COUNT(*)>5

--deptnames with no of employees

select  employeedept,COUNT(*) from employees
group by employeedept

--cities with no of employees

select  employeecity,COUNT(*) from employees
group by employeecity

--update chennai to pune

select * from employees

update employees set employeecity='pune'
where employeecity='chennai'

--sum>50000

select employeedept,sum(employeesalary) from employees
group by employeedept
having SUM(employeesalary)>50000

--create empproject

create table employeeproject
(
employeeid int,
projectname varchar(100),
duration int,
skillset varchar(100)
)

insert employeeproject values(1001,'hyperspectral images',2,'matlab')
insert employeeproject values(1001,'chat bots',2,'java')
insert employeeproject values(1002,'hyperspectral images',3,'matlab')
insert employeeproject values(1002,'voice texting',2,'java')
insert employeeproject values(1003,'Gaming',2,'java')

--empid no of projects
select employeeid,COUNT(*) as noofprojects from employeeproject
group by employeeid

--working to resigned

update employees set employeestatus='resigned'
where employeeid=1002
select * from employees

--who joined in current month

select * from employees
where datename(mm,employeedoj)=DATENAME(mm,getdate())

select * from employeeproject
