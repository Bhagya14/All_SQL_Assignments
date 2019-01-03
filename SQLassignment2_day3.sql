create database EmployeeManagementDB

use EmployeeManagementDB

create table tbl_Employees
(
employeeid int identity(1000,1) primary key ,
employeename varchar(100) not null,
employeecity varchar(100) not null,
employeesalary int not null,
employeeDOB datetime,
employeeDOJ datetime,
employeemobileno varchar(15) not null unique,
employeeemailid varchar(100) not null unique,
employeepassword varchar(100) not null,
employeedept varchar(100) not null
)

create table tbl_employee_available_leaves
(
employeeid int foreign key references tbl_employees(employeeid),
sickleave int not null,
Casualleave int not null,
vacationleave int not null,
compoff int not null
)

create table tbl_employeeleaves
(
leaveid int identity(100,1) primary key,
employeeid int foreign key references tbl_employees(employeeid),
leavetype varchar(100) not null,
leaveapplydate datetime not null,
leavedate datetime not null,
noofdays int not null
)

create table tbl_employeesalary
(
employeeid int foreign key references tbl_employees(employeeid),
employeesalary int not null,
salarymonth int,
salaryyear int,
salarydate int
)

select * from tbl_Employees
insert tbl_Employees values('sri','bang',10000,'06/14/1997','04/17/2018','9870234509','sri@gmail.com','pass123','HR')
insert tbl_Employees values('shanu','hyd',20000,'06/15/1996','04/17/2018','9870808509','shanu@gmail.com','pass123','Manager')
insert tbl_Employees values('isha','bang',50000,'03/18/1994','08/27/2017','988904509','isha@gmail.com','pass123','CEO')
insert tbl_Employees values('sandhya','hyd',30000,'04/24/1998','07/29/2018','9000234509','sandhya@gmail.com','pass123','HR')

select * from tbl_employee_available_leaves

insert tbl_employee_available_leaves values(1001,10,10,10,10)
insert tbl_employee_available_leaves values(1002,10,10,10,10)
insert tbl_employee_available_leaves values(1003,10,10,10,10)
insert tbl_employee_available_leaves values(1000,10,10,10,10)

select * from tbl_employeeleaves
insert tbl_employeeleaves values(1001,'vacation',getdate(),'12/19/2018',2)
insert tbl_employeeleaves values(1002,'casual',getdate(),'12/20/2018',2)
insert tbl_employeeleaves values(1003,'sick',getdate(),'12/20/2018',1)
insert tbl_employeeleaves values(1000,'vacation',getdate(),'12/19/2018',4)

select * from tbl_employeesalary
insert tbl_employeesalary values(1000,10000,12,2018,31)
insert tbl_employeesalary values(1001,18000,12,2018,31)
insert tbl_employeesalary values(1002,40000,12,2018,31)
insert tbl_employeesalary values(1003,28000,12,2018,31)

--employees joined in current month
select * from tbl_Employees
where datename(mm,employeeDOJ)=DATENAME(mm,getdate());
--employee salary more than 20000
select * from tbl_Employees
where employeesalary>20000
--list of employeedept with no of employees 
select employeedept,count(*),sum(employeesalary),AVG(employeesalary) from tbl_Employees
group by employeedept
--join
select tbl_Employees.employeeid,tbl_Employees.employeename,tbl_Employees.employeesalary,tbl_employeesalary.salarymonth,tbl_employeesalary.salarydate from tbl_Employees 
join tbl_employeesalary
on tbl_Employees.employeeid=tbl_employeesalary.employeeid where tbl_Employees.employeeid=1000

--join
select tbl_Employees.employeeid,tbl_Employees.employeename,tbl_employee_available_leaves.sickleave,tbl_employee_available_leaves.Casualleave,tbl_employee_available_leaves.vacationleave,tbl_employee_available_leaves.compoff
from tbl_Employees 
join tbl_employee_available_leaves
on tbl_Employees.employeeid=tbl_employee_available_leaves.employeeid

select * from tbl_employee_available_leaves
select * from tbl_Employees

alter proc proc_addemployee
(@ename varchar(100),@ecity varchar(100),@esalary int,@empDOB datetime,@emobileno varchar(15),
@eemailid varchar(100),@epassword varchar(100),@edept varchar(100),
@esickleave int,@ecasualleave int,@evacationleave int,@compoff int)
as
begin
begin tran
begin try
insert tbl_Employees values(@ename,@ecity,@esalary,@empDOB,getdate(),@emobileno,@eemailid,@epassword,@edept)
declare @id int= @@IDENTITY;
insert tbl_employee_available_leaves values(@@IDENTITY,@esickleave,@ecasualleave,@evacationleave,@compoff)
commit tran
return @id
end try
begin catch
rollback tran
return -1
end catch
end

declare @e int
exec @e=proc_addemployee 'bagya1','bang',10000,'07/12/1997','6261176319','b5agya1@gmail.com',
'pass123','HR',10,10,10,10
select @e

select * from tbl_employeeleaves
--create a procedure for adding leave in levaes table
alter proc proc_addleave
(@eid int,@leavetype varchar(100),@leavedate datetime,@noofdays int)
as
begin
insert tbl_employeeleaves values(@eid,@leavetype,getdate(),@leavedate,@noofdays)
return @@rowcount
end

declare @e int=0;
exec @e=proc_addleave 1003,'casualleave','02/01/2019',1
select @e

select * from tbl_employeeleaves
select * from tbl_employee_available_leaves
--create a trigger for updating leave in the tbl_employeeleaves when employee take leave.
create trigger trg_leave
on tbl_employeeleaves
for insert
as
begin
declare @leaveid int
declare @employeeid int
declare @leavetype varchar(100)
declare @leaveapplydate datetime
declare @leavedate datetime
declare @noofdays int
select @employeeid=employeeid,@leavetype=leavetype,@noofdays=noofdays from inserted
if(@leavetype='sickleave')
begin
update tbl_employee_available_leaves set sickleave=sickleave-@noofdays where employeeid=@employeeid
end
if(@leavetype='casualleave')
begin
update tbl_employee_available_leaves set Casualleave=Casualleave-@noofdays where employeeid=@employeeid
end
if(@leavetype='vacationleave')
begin
update tbl_employee_available_leaves set vacationleave=vacationleave-@noofdays where employeeid=@employeeid
end
if(@leavetype='Compoff')
begin
update tbl_employee_available_leaves set compoff=compoff-@noofdays where employeeid=@employeeid
end
end

--create a trigger checking monthly salary
alter trigger trg_salarymonth
on tbl_employeesalary for insert
as 
begin
declare @salarymonth int
declare @salaryyear int
declare @salary int
declare @eid int
select @salarymonth=salarymonth,@salaryyear=salaryyear,@salary=employeesalary,@eid=employeeid from inserted
declare @empsalary int
select @empsalary=employeesalary from  tbl_employees where employeeid=@eid
if(datepart(yy,getdate())!= @salaryyear and datepart(mm,getdate())!= @salarymonth and @empsalary<=@salary )
begin
rollback tran
end
end

insert tbl_employeesalary values(1001,25000,12,2018,30)
select * from tbl_employeesalary
select * from tbl_Employees




