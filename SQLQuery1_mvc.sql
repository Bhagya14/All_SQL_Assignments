create database mvc5_batch8
use mvc5_batch8

create table tbl_students
(
studentID int identity(1000,1) primary key,
studentname varchar(100) not null,
studentemailid varchar(1000) not null,
studentpassword varchar(100) not null,
studentmobileno varchar(15) not null,
studentcity varchar(100) not null,
studentgender varchar(100) not null,
studentimageaddress varchar(200) not null
)

create proc proc_login(@loginid int,@password varchar(100))
as
begin
declare @count int
select @count=count(*) from tbl_students where
studentid=@loginid and studentpassword=@password
return @count
end

select * from tbl_students

create proc proc_addstudent(@name varchar(100),@email varchar(100),
@password varchar(100),@mobile varchar(100),@city varchar(100),@gender varchar(100),@imgaddress varchar(200))
as
begin
insert tbl_students values(@name,@email,@password,@mobile,@city,@gender,@imgaddress)
return @@identity
end

select * from tbl_students
create proc proc_search(@key varchar(100))
as 
begin
select studentid,studentname,studentgender,studentimageaddress from tbl_students
where studentID like '%'+@key+'%' or
studentname like '%'+@key+'%' or
studentmobileno like '%'+@key+'%' or
studentemailid like '%'+@key+'%' or
studentcity like '%'+@key+'%' 
end      

create proc proc_find(@id int)
as
begin
select * from tbl_students where studentID=@id
end

create proc proc_update(@id int,@password varchar(100),@mobileno varchar(100))
as
begin
update tbl_students set studentpassword=@password,studentmobileno=@mobileno
where studentID=@id
return @@rowcount
end

create proc proc_delete(@id int)
as 
begin
delete tbl_students where studentID=@id
return @@rowcount
end
