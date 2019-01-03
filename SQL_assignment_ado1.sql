create database batch_ado1
use batch_ado1

create table tbl_customers
(
customerid int identity(100,1) primary key,
customername varchar(100) not null,
customerpassword varchar(100) not null,
customercity varchar(100) not null,
customeraddress varchar(100) not null,
customermobileno varchar(15) not null,
customeremailid varchar(100) not null
)
select * from tbl_customers

--add customer
create proc proc_addcustomer
(@name varchar(100),@password varchar(100),@city varchar(100),
@address varchar(100),@mobileno varchar(15),@email varchar(100))
as
begin
insert tbl_customers values(@name,@password,@city,@address,@mobileno,@email)
return @@identity
end

--find customer
create proc proc_findcustomer(@id int)
as
begin
select * from tbl_customers where customerid=@id
end

--search customer

create proc proc_searchcustomer(@key varchar(100))
as
begin
select * from tbl_customers where customerid like '%'+@key+'%' or
								  customername like '%'+@key+'%' or
								  customercity like '%'+@key+'%' or
								  customeraddress like '%'+@key+'%' or
								  customermobileno like '%'+@key+'%'or
								  customeremailid like '%'+@key+'%'
end
--update
create proc proc_updatecustomer 
(@id int,@address varchar(100),@mobileno varchar(15))
as
begin
update tbl_customers set customeraddress=@address,customermobileno=@mobileno
return @@rowcount
end

--delete

create proc proc_deletecustomer(@id int)
as
begin
delete tbl_customers where customerid=@id
return @@rowcount
end

--Login
create proc proc_login(@id int,@password varchar(100))
as
begin
declare @count int
select @count=count(*) from tbl_customers
where customerid=@id and customerpassword=@password
return @count
end

select * from tbl_customers






