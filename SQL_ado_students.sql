create database ado_students

use ado_students

create table tbl_students
(
studentid int identity(1000,1) primary key,
studentname varchar(100) not null,
studentcity varchar(100) not null,
studentaddress varchar(100) not null,
studentemaild varchar(100) 
)
--add student
create proc proc_addstudent
(@name varchar(100),@city varchar(100),@address varchar(100),@emailid varchar(100))
as
begin
insert tbl_students values(@name,@city,@address,@emailid)
return @@identity
end

--find student
create proc proc_findstudent(@id int)
as
begin
select * from tbl_students where studentid=@id
end

--update student

create proc proc_updatestudent(@id int,@address varchar(100),@city varchar(100))
as
begin
update tbl_students set studentaddress=@address,studentcity=@city
where studentid=@id
return @@rowcount
end

--delete student

create proc proc_deletestudent(@id int)
as
begin
delete tbl_students where studentid=@id
return @@rowcount
end

--search student

create proc proc_searchstudent(@key varchar(100))
as
begin
select * from tbl_students where studentid like '%'+@key+'%' or
								  studentname like '%'+@key+'%' or
								  studentcity like '%'+@key+'%'
end
