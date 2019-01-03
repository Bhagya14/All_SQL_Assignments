create database mvc5_employeedb

use mvc5_batch8

use mvc5_employeedb

create table tbl_employees
(
employeeid int identity(1000,1) primary key,
employeename varchar(100) not null,
employeecity varchar(100) not null,
employeeemail varchar(100) not null,
employeepassword varchar(100) not null,
employeegender varchar(100) not null,
employeeimageaddress varchar(100) not null
)

create proc proc_login(@loginid int,@password varchar(100))
as
begin
declare @count int
select @count=count(*) from tbl_employees where
employeeid=@loginid and employeepassword=@password
return @count
end

create proc proc_addemployee(@name varchar(100),@city varchar(100),
@email varchar(100),@password varchar(100),@gender varchar(100),@imgaddress varchar(200))
as
begin
insert tbl_employees values(@name,@city,@email,@password,@gender,@imgaddress)
return @@identity
end


select * from tbl_employees
