create database mvc_ejobportal_project

use mvc_ejobportal_project
--emailid,firstname,lastname,gender,city,password,mobileno,
--workingstatus,experience,highqualification,seekerphotoaddress
create table tbl_newseeker
(
seekerid int identity(1000,1) primary key,
seekeremail varchar(100) not null,
seekerfirstname varchar(100) not null,
seekerlastname varchar(100) not null,
seekergender varchar(100) not null,
seekercity varchar(100) not null,
seekerpassword varchar(100) not null,
seekermobileno varchar(15) not null,
seekerworkingstatus varchar(100) not null,
seekerexperience int ,
seekerhighestqualification varchar(100) not null,
seekerphotoaddress varchar(100) not null
)

create proc proc_login(@loginid int,@password varchar(100))
as
begin
declare @count int
select @count=count(*) from tbl_newseeker where
seekerid=@loginid and seekerpassword=@password
return @count
end

--emailid,firstname,lastname,gender,city,password,mobileno,
--workingstatus,experience,highqualification,seekerphotoaddress

create proc proc_addemployee(@email varchar(100),@fname varchar(100),
@lname varchar(100),@gender varchar(100),@city varchar(100),@password varchar(200),@mobileno varchar(15),@status varchar(100),
@experience int,@highestqualification varchar(100),@imgaddress varchar(200))
as
begin
insert tbl_newseeker values(@email,@fname,@lname,@gender,@city,@password,@mobileno,@status,@experience,@highestqualification,@imgaddress)
return @@identity
end

select * from tbl_newseeker
