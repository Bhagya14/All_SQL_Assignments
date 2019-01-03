create database batch8_ado
use batch8_ado

create table tbl_employees
(
employeeid int identity(1000,1) primary key,
employeename varchar(100) not null,
employeecity varchar(100) not null,
employeesalary int not null,
employeepassword varchar(100)
)

--insert
create proc proc_addemployee
(@name varchar(100),@city varchar(100),@salary int,@password varchar(100))
as
begin
insert tbl_employees values(@name,@city,@salary,@password)
return @@identity
end

--update
create proc proc_updateemployee(@id int,@city varchar(100),@salary int)
as
begin
update tbl_employees set employeecity=@city,employeesalary=@salary
where employeeid=@id
return @@rowcount
end

--delete
create proc proc_deleteemployee(@id int)
as
begin
delete tbl_employees where employeeid=@id
return @@rowcount
end

--find 
create proc proc_findemployee(@id int)
as
begin
select * from tbl_employees where employeeid=@id
end

--search

create proc proc_searchemployee(@key varchar(100))
as
begin
select * from tbl_employees where employeeid like '%'+@key+'%' or
								  employeename like '%'+@key+'%' or
								  employeecity like '%'+@key+'%'
end

--login
create proc proc_login(@id int,@password varchar(100))
as
begin
declare @count int
select @count=count(*) from tbl_employees
where employeeid=@id and employeepassword=@password
return @count
end

select * from tbl_employees


