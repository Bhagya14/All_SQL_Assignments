--adding a row in tbl_customers
create proc proc_addcustomersinfo
(@acid int,@accname varchar(100),@city varchar(100),@age int)
as
begin
declare @count int=0;
select @count=count(*) from tbl_customers where customerid=@acid
if(@count=0)
begin
insert tbl_customers values(@acid,@accname,@city,@age)
end 
return @@rowcount
end


declare @s int 
exec @s=proc_addcustomersinfo 1089,'bhagi','chennai',23
select @s;

select * from tbl_customers
--update city
alter proc proc_update_customer
(@id int ,@city varchar(100))
as
begin
update tbl_customers set customercity=@city where customerid=@id;
end

declare @count int
exec @count=proc_update_customer 1004,mumbai
select @count
--updating customer mobileno
select * from Customersinfo
alter proc proc_updates_customermobilenum
(@id int ,@password varchar(100),@newmobileno int)
as
begin
update customersinfo set customermobileno=@newmobileno where customerid=@id and customerpassword=@password
return @@rowcount
end

declare @count int
exec @count=proc_updates_customermobilenum 1000,'pass123',9704236
select @count

select * from Customersinfo

alter proc proc_join
(@cid int)
as 
begin
select Customersinfo.customerid,Customersinfo.customername,Accountinfo.Accountid,Accountinfo.accountbalance
from Customersinfo 
join accountinfo on Customersinfo.customerid=Accountinfo.customerid where Customersinfo.customerid=@cid
end

exec proc_join 1001

select * from Accountinfo
select * from Customersinfo

--procedure for login
create table tbl_cust
(
customerid int,
cpassword varchar(100),
customername varchar(100),
passwordcount int,
cstatus varchar(100),
wrongpasswordattemptdate datetime
)

select * from tbl_cust
insert tbl_cust values(1031,'sri','sri123',0,'active',GETDATE())
update tbl_cust set passwordcount=0,cstatus='active'
 
alter procedure proc_block(@cid int,@cpassword varchar(100))
as
begin
declare @custpass varchar(100);
declare @passcount int;
select @custpass=cpassword,@passcount=passwordcount from tbl_cust where @cid=customerid
if( @custpass!=@cpassword )
begin
update tbl_cust set passwordcount=passwordcount+1,wrongpasswordattemptdate=getdate()
 where @cid=customerid
 update tbl_cust set passwordcount=1 where datediff(dd,wrongpasswordattemptdate,getdate())!=0
if(@passcount=3)
begin
update tbl_cust set cstatus='blocked' where @cid=customerid
return -1
end
return 0
end
else
begin
return 1
end
end

exec proc_block 1021,'s13'

select * from tbl_cust
select * from tbl_cust


--output parameters
create proc proc_customer_output(@cid int,@name varchar(100) output,@city varchar(100) output)
as
begin
select @name=customername,@city=customercity
from Customersinfo where customerid=@cid
end

declare @cid int,@name varchar(100),@city varchar(100)
set @cid=1004
exec proc_customer_output @cid,@name output,@city output
select @cid,@name,@city

--create procedure to getdata

alter procedure proc_getdata(@cid int)
as
begin
select CustomerName,CustomerCity from tbl_customers where customerId=@cid
end

declare @s int
exec @s=proc_getdata 1005

select * from tbl_customers

--function to cancatenate customer details

create function func_getfulldetail
(@customername varchar(100),@customercity varchar(100),@customerage varchar(100))
returns varchar(max)
as
begin
declare @fulldetails varchar(max)
set @fulldetails=@customername +','+@customercity +','+@customerage
return @fulldetails;
end

select customerId,dbo.func_getfulldetail(CustomerName,CustomerCity,CustomerAge)
as 'full details' from tbl_customers

--fuction to return account table

create function func_return_table(@cid int)
returns table
as
return select * from tbl_customers where customerId=@cid

select * from dbo.func_return_table(1005)

--create a trigger for updating account balance

select * from transactioninfo
insert transactioninfo values(100002,'withdraw',100,getdate())
select * from accountinfo
select * from customersinfo

alter trigger trig_account_balance
on transactioninfo for insert
as
begin
declare @amount int
declare @accountid int
declare @transactiontype varchar(100)
select @amount=amount,@accountid=accountid,@transactiontype=transactiontype from inserted
if(@transactiontype='deposit')
begin
update accountinfo set accountbalance=accountbalance+@amount where accountid=@accountid
end
if(@transactiontype='withdraw')
begin
update accountinfo set accountbalance=accountbalance-@amount where accountid=@accountid
end
end





