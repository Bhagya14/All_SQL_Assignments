create database MybankDB
use MybankDB

create table tbl_employeees
(
employeeid int identity(100,5) primary key,
employeename varchar(100),
employeecity varchar(100),
employeesalary int,
employeedob datetime,
employeedoj datetime,
employeedesignation varchar(100)
)
insert tbl_employeees values('ram','hyd',42000,'05-27-1993','11-12-2017','HR')
select * from tbl_employeees


create table tbl_customers
(
customerid int identity(1,1) primary key,
customername varchar(100),
customercity varchar(100),
customeraddress varchar(100),
customermobileno varchar(100) unique,
pan varchar(100) unique,
customeremail varchar(100) unique,
customerpassword varchar(100),
employeeid int foreign key references tbl_employeees
)
insert tbl_customers values('mouni','blr','plot 140','8232483078','r6sdb83','mouni@gmail','sneha127',100)
select * from tbl_customers

create table tbl_accountinfo
(
accountid int identity(50,2) primary key,
customerid int foreign key references tbl_customers,
accounttype varchar(100),
accountbalance int,
accountopendate datetime,
accountstatus varchar(100)
)
insert tbl_accountinfo values(2,'saving',10000,'02-02-2018','open')
insert tbl_accountinfo values(3,'saving',20000,'02-02-2018','open')
insert tbl_accountinfo values(4,'current',30000,'02-02-2018','closed')
insert tbl_accountinfo values(6,'current',40000,'02-02-2018','closed')
insert tbl_accountinfo values(7,'saving',10000,'02-02-2018','open')
select * from tbl_accountinfo


create table tbl_transactioninfo
(
transactionid int identity(25,10) primary key,
accountid int foreign key references tbl_accountinfo,
transactiontype varchar(100),
amount int check(amount>0),
transactiondate datetime
)
insert tbl_transactioninfo values(56,'deposit',500,'10-04-2016')
insert tbl_transactioninfo values(52,'withdraw',500,'10-05-2016')

insert tbl_transactioninfo values(58,'deposit',500,'10-04-2016')
insert tbl_transactioninfo values(54,'withdraw',4500,'10-05-2016')
insert tbl_transactioninfo values(60,'deposit',500,'10-06-2016')

select * from tbl_transactioninfo




--latest 5 transactions
create procedure proc_latest_transactions(@id int)
as
begin
select top 5 * from tbl_transactioninfo where accountid=@id order by transactiondate desc
end

exec proc_latest_transactions 52


--transaction between two dates
alter procedure proc_transaction_betwndates(@id int)
as
begin
select * from tbl_transactioninfo where accountid=@id and
 transactiondate between '10-04-2016' and getdate()
 end

 exec proc_transaction_betwndates 60

 --list of accounts of a customer

 create procedure proc_accountinfo(@id int)
 as
 begin
 select * from tbl_accountinfo where customerid=@id
 end

 exec proc_accountinfo 3

 --join

 create procedure proc_join
 as
 begin
 select tbl_customers.customerid,tbl_customers.customername,tbl_customers.customeraddress,tbl_customers.customermobileno,
 tbl_accountinfo.accountid,tbl_accountinfo.accountbalance from tbl_customers join tbl_accountinfo
 on tbl_customers.customerid=tbl_accountinfo.customerid
 end

 exec proc_join

 --list of accounts with transactions

create procedure proc_join_2
as
begin
select tbl_accountinfo.accountid,tbl_accountinfo.accountbalance,tbl_transactioninfo.transactionid,
tbl_transactioninfo.amount,tbl_transactioninfo.transactiontype from tbl_accountinfo join
tbl_transactioninfo on tbl_accountinfo.accountid=tbl_transactioninfo.accountid
end

exec proc_join_2

--list of customers with accounts

create procedure proc_join_3
as
begin
select tbl_customers.customerid,tbl_customers.customername,tbl_customers.customeraddress,
tbl_customers.customermobileno,tbl_accountinfo.accountid,tbl_accountinfo.accountbalance,
tbl_transactioninfo.amount,tbl_transactioninfo.transactiontype from tbl_customers join
tbl_accountinfo on tbl_customers.customerid=tbl_accountinfo.customerid join tbl_transactioninfo
on tbl_accountinfo.accountid=tbl_transactioninfo.accountid
end

exec proc_join_3

--who have accounts

create procedure proc_accounts
as
begin
select * from tbl_customers where customerid in( 
select customerid from tbl_accountinfo)
end

exec proc_accounts

--who have no accounts
create procedure proc_no_accounts
as
begin
select * from tbl_customers where customerid not in( 
select customerid from tbl_accountinfo)
end

exec proc_no_accounts

--who have transactions
create procedure proc_transactions
as
begin
select * from tbl_accountinfo where accountid in(
select accountid from tbl_transactioninfo)
end

exec proc_transactions

--who have no transactions

create procedure proc_no_transactions
as
begin
select * from tbl_accountinfo where accountid not in(
select accountid from tbl_transactioninfo)
end

exec proc_no_transactions

--create a view for v_account_saving

create view v_account_current
with encryption
as
select * from tbl_accountinfo where accounttype='current' with check option

select * from v_account_current

--create a view for v_account_saving

create view v_account_saving
with encryption
as
select * from tbl_accountinfo where accounttype='saving' with check option

select * from v_account_saving

--account balance using output parameter

alter procedure proc_account_balance(@aid int,@accountbal int output)
as
begin
select @accountbal=accountbalance from tbl_accountinfo 
where accountid=@aid
end

declare  @accountbal int
exec proc_account_balance 52 ,@accountbal output 
select @accountbal;

select * from tbl_accountinfo

--trigger for updating account balance
delete trg_accountbalance_update
 create trigger trg_accountbalance
 on tbl_transactioninfo
  for insert
  as
  begin
  declare @aid int
  declare @amount int
  declare @atype varchar(100)
  select @aid=accountid,@amount=amount,@atype=transactiontype from inserted
  declare @accbal int
  select @accbal=accountbalance from tbl_accountinfo where accountid=@aid
  if(@atype='deposit')
  begin
  update tbl_accountinfo set accountbalance=@accbal+@amount where accountid=@aid;
  end
  if(@atype='withdraw')
  begin
  update tbl_accountinfo set accountbalance=@accbal-@amount where accountid=@aid;
  end
  else
  begin
  rollback tran;
  end
  end

  select * from tbl_accountinfo
  select * from tbl_transactioninfo;


--maximum salary

select top 1 * from tbl_employeees order by employeesalary desc; 
--second highest salary

select top 1 * from tbl_employeees
where employeeid in 
(select top 2 employeeid from tbl_employeees order by employeesalary desc)
order by employeesalary asc

--maximum account balance

select top 1 * from tbl_accountinfo order by accountbalance desc; 

--second highest account balance

select top 1 * from tbl_accountinfo
where accountid in 
(select top 2 accountid from tbl_accountinfo order by accountbalance desc)
order by accountbalance asc

--join

select tbl_employeees.employeeid,tbl_employeees.employeename,tbl_customers.customerid,
tbl_customers.customername,tbl_accountinfo.accountid,tbl_accountinfo.accountbalance from tbl_employeees
join tbl_customers 
on tbl_employeees.employeeid=tbl_customers.employeeid 
join tbl_accountinfo
on tbl_customers.customerid=tbl_accountinfo.customerid

--list of employees with designation wise

select employeedesignation,COUNT(*) from tbl_employeees
group by employeedesignation

--list of accountid,nooftransactions

select accountid,count(*) as nooftransactions from tbl_transactioninfo
group by accountid