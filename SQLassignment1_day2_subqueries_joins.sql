create database BankDB
use BankDB
--. CustomersInfo with Auto gen CustomerID
--   (CustomerID(PK) , CustomerName, CustomerCity, CustomerAddress ,
-- CustomerMobileNo(U), PAN (U), CustomerPassword , CustomerEmailID (U) )
create table Customersinfo
(
customerid int identity(1000,1) primary key,
customername varchar(100) not null,
customercity varchar(100) not null,
customeraddress varchar(max) not null,
customermobileno varchar(15) not null,
PAN varchar(15) not null,
customerpassword varchar(100) not null,
customeremailid varchar(100) not null
)

--account table

create table Accountinfo
(
Accountid int identity(100000,1) primary key,
customerid int foreign key references customersinfo(customerid),
accounttype varchar(100) not null,
accountbalance int not null,
accountopendate datetime not null,
accountstatus varchar(100) not null
)
--transaction table
create table Transactioninfo
(
transactionid int identity(11000,1) primary key,
accountid int foreign key references Accountinfo(accountid),
transactiontype varchar(100) not null,
Amount int not null check(amount>0),
transactiondate datetime not null
)

--inserting data

select * from Customersinfo

insert Customersinfo values('bhagya','bang','JPN','9703654789','EPAN123','pass123','bhagya@gmail.com')
insert Customersinfo values('ramya','bang','JPN','9706894789','EPAN124','pass124','ramya@gmail.com')
insert Customersinfo values('surya','hyd','JYN','9703657899','EPAN125','pass125','surya@gmail.com')
insert Customersinfo values('mouni','hyd','GAN','9054654789','EPAN126','pass126','mouni@gmail.com')
insert Customersinfo values('sai','bang','BTM','9703656789','EPAN127','pass127','sai@gmail.com')
insert Customersinfo values('anil','chennai','BDA','9234594789','EPAN128','pass128','anil@gmail.com')
insert Customersinfo values('siri','chennai','BTM','9657854789','EPAN129','pass129','siri@gmail.com')
insert Customersinfo values('megha','bang','MTL','8500054789','EPAN121','pass121','megha@gmail.com')
insert Customersinfo values('sneha','kolkatta','BNK','9703611908','EPAN122','pass122','sneha@gmail.com')
insert Customersinfo values('sravani','surat','BNK','8700254789','EPAN120','pass120','sravani@gmail.com')

select * from Customersinfo
select * from Accountinfo

insert Accountinfo values(1001,'savings',10000,GETDATE(),'open')
insert Accountinfo values(1002,'current',20000,GETDATE(),'close')
insert Accountinfo values(1003,'savings',30000,GETDATE(),'open')
insert Accountinfo values(1004,'current',40000,GETDATE(),'open')
insert Accountinfo values(1005,'savings',50000,GETDATE(),'close')
insert Accountinfo values(1006,'current',10000,GETDATE(),'block')
insert Accountinfo values(1007,'savings',20000,GETDATE(),'block')
insert Accountinfo values(1001,'savings',30000,GETDATE(),'close')
insert Accountinfo values(1002,'current',40000,GETDATE(),'open')
insert Accountinfo values(1003,'savings',50000,GETDATE(),'open')

--insert transaction
select * from Transactioninfo

insert Transactioninfo values(100000,'credit',200,'12/13/2018')
insert Transactioninfo values(100001,'debit',200,'12/14/2018')
insert Transactioninfo values(100002,'credit',200,'12/14/2018')
insert Transactioninfo values(100002,'debit',200,'12/15/2018')
insert Transactioninfo values(100003,'credit',300,'12/15/2018')
insert Transactioninfo values(100003,'debit',400,'12/15/2018')
insert Transactioninfo values(100004,'credit',100,'12/14/2018')
insert Transactioninfo values(100001,'debit',300,'12/13/2018')
insert Transactioninfo values(100005,'credit',300,'12/14/2018')
insert Transactioninfo values(100006,'credit',500,'12/14/2018')


--last 5 transactions of an account

select top 5 * from transactioninfo
order by transactiondate desc

--transaction between two dates

select * from Transactioninfo
where transactiondate between GETDATE() and '12/15/2018' and accountid=100002

--customer accountsinfo

select * from Accountinfo
where customerid=1002

--join

select Customersinfo.customerid,Customersinfo.customername,Customersinfo.customeraddress,
Customersinfo.customermobileno,Accountinfo.Accountid,Accountinfo.accountbalance 
from Customersinfo join Accountinfo
on
Customersinfo.customerid=Accountinfo.customerid

--accounts with transactions

select Accountinfo.Accountid,Accountinfo.accountbalance,Transactioninfo.transactionid,
Transactioninfo.Amount,Transactioninfo.transactiontype from Accountinfo join Transactioninfo
on
Accountinfo.Accountid=Transactioninfo.accountid

--3 tables join\

select customersinfo.customerid,Customersinfo.customername,Customersinfo.customeraddress,
Customersinfo.customermobileno,Accountinfo.Accountid,Accountinfo.accountbalance,
Transactioninfo.transactionid,Transactioninfo.Amount,Transactioninfo.transactiontype
from Customersinfo join Accountinfo
on Customersinfo.customerid=Accountinfo.customerid
join Transactioninfo
on
Accountinfo.Accountid=Transactioninfo.accountid

--list who have accounts

