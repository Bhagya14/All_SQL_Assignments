Create Database db_pathfront

use db_pathfront

create table tbl_customers
(
customerid int ,
customerName varchar(100),
customercity varchar(100),
customerAge int
)

insert tbl_customers values(1001,'john','bgl',25)
insert tbl_customers values(1002,'amith','hyd',21)
insert tbl_customers values(1003,'mary','pune',23)
insert tbl_customers values(1004,'david','chennai',26)

select * from tbl_customers

insert tbl_customers values(1006,'sandy',null,30)

update tbl_customers set customercity='chennai',customerAge=35 
where customerid=1003

select * from tbl_customers

update tbl_customers set customerid=1005
where customerName='david'

delete tbl_customers where customerid=1002

select customerid,customername from tbl_customers

sp_help tbl_customers

alter table tbl_customers add customercontactno varchar(100)

select * from tbl_customers

alter table tbl_customers drop column customercontactno

select * from tbl_customers

alter table tbl_customers alter column customername varchar(200)

create table tbl_employees
(
Employeeid int,
EmployeeName varchar(100),
EmployeeCity varchar(100),
EmployeeSalary int,
EmployeeDOJ datetime
)

insert tbl_employees values(1000,'john','bgl',30000,'12/12/2017')
insert tbl_employees values(1001,'amit','hyd',25000,'11/12/2017')
insert tbl_employees values(1002,'smith','chennai',40000,'12/11/2017')
insert tbl_employees values(1003,'aloy','mumbai',23000,'11/11/2017')
insert tbl_employees values(1004,'mary','kolkatta',20000,'12/09/2017')
insert tbl_employees values(1005,'danny','delhi',30000,'12/09/2017')
insert tbl_employees values(1006,'miss','bgl',30000,'12/12/2017')
insert tbl_employees values(1007,'suman','bgl',25000,'12/11/2017')
insert tbl_employees values(1008,'johny','hyd',40000,'12/08/2017')
insert tbl_employees values(1010,'samit','chennai',30000,'11/09/2017')

select * from tbl_employees

select employeeid,employeename from tbl_employees

select * from tbl_employees where EmployeeSalary>25000

select * from tbl_employees where EmployeeSalary>25000 and EmployeeCity='bgl'

select * from tbl_employees where EmployeeCity='chennai' or EmployeeSalary>20000 

select * from tbl_employees where EmployeeCity in('bgl','chennai','pune') 

insert tbl_employees values(1013,'davidd','bgl',null,'12/11/2018')

select * from tbl_employees

select * from tbl_employees where EmployeeSalary is null

select * from tbl_employees where EmployeeSalary between 20000 and 50000

 select * from tbl_employees order by EmployeeSalary asc,EmployeeCity desc

select top 1 * from tbl_employees order by EmployeeSalary desc

select employeeid,len(employeename) from tbl_employees

select employeeid,SUBSTRING(employeename,1,2),lower(employeecity) from tbl_employees

select employeeid, isnull(employeesalary,0)from tbl_employees

select * from tbl_employees order by len(employeename) asc

select sum(employeesalary) from tbl_employees

select avg(employeesalary) from tbl_employees

select max(employeesalary) from tbl_employees

select min(employeesalary) from tbl_employees

select count(*) from tbl_employees

select * from tbl_employees

insert tbl_employees values(1020,'rosy','chennai',40000,getdate())

select employeeid,employeename,dateadd(yy,2,employeedoj) from tbl_employees

select employeeid,employeename,DATEDIFF(yy,employeedoj,getdate()) as 'exp' from tbl_employees

select employeeid,employeename,datename(mm,employeedoj)from tbl_employees 

select employeeid,employeename,datename(dw,employeedoj)from tbl_employees 

select DATENAME(dw,'06/14/95')

select employeeid,employeename,datepart(dw,employeedoj)from tbl_employees 

select employeecity,count(*),sum(employeesalary) from tbl_employees
where EmployeeSalary>20000
group by employeecity
having count(*) >2


