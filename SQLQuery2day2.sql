create database db_invoices

use db_invoices

create table tbl_customers
(
customeremailid varchar(100) primary key,
customername varchar(100) not null,
customercity varchar(100) not null,
customercontactno varchar(15) not null unique,
customeraddress varchar(max) not null
)
create table tbl_items
(
itemid int identity(1,1) primary key,
itemname varchar(100) not null,
itemprice int not null check(itemprice>0)
)
create table tbl_invoices
(
invoiceid int identity(1000,1) primary key,
customeremailid varchar(100) not null
foreign key references tbl_customers(customeremailid),
invoicecity varchar(100) not null,
invoicedate datetime not null
)

create table tbl_invoiceitems
(
invoiceid int foreign key references tbl_invoices(invoiceid),
itemid int foreign key references tbl_items(itemid),
itemqty int not null check(itemqty>0),
itemprice int not null check(itemprice>0),
primary key(invoiceid,itemid)
) 

select * from tbl_customers

insert tbl_customers values('bhagya@gmail.com','bhagya','bang','9704236688','JPN')
insert tbl_customers values('surya@gmail.com','surya','bang','9809238688','JPN')
insert tbl_customers values('ramya@gmail.com','ramya','hyd','9764326928','Gandhi Nagar')
insert tbl_customers values('mouni@gmail.com','mouni','hyd','9706783648','Jayadeva')
insert tbl_customers values('sai@gmail.com','sai','bang','9704267888','JPN')

insert tbl_items values('samsung',20000)
insert tbl_items values('vivo',25000)
insert tbl_items values('oppo',30000)
insert tbl_items values('blackberry',40000)
insert tbl_items values('Iphone',60000)
insert tbl_items values('samsung',20000)
insert tbl_items values('motorola',35000)
insert tbl_items values('oppo',28000)
insert tbl_items values('vivo',18000)
insert tbl_items values('honor',21000)
insert tbl_items values('mobile',10000)

select * from tbl_invoices

select * from tbl_items

insert tbl_invoices values('bhagya@gmail.com','bang',GETDATE())
insert tbl_invoices values('surya@gmail.com','bang',GETDATE())
insert tbl_invoices values('ramya@gmail.com','bang',GETDATE())
insert tbl_invoices values('mouni@gmail.com','hyd',GETDATE())
insert tbl_invoices values('sai@gmail.com','bang',GETDATE())

select * from tbl_invoiceitems

insert tbl_invoiceitems values(1000,1,1,100)
insert tbl_invoiceitems values(1001,2,2,200)
insert tbl_invoiceitems values(1002,3,1,150)
insert tbl_invoiceitems values(1003,4,2,250)
insert tbl_invoiceitems values(1004,5,1,200)
insert tbl_invoiceitems values(1000,6,2,100)
insert tbl_invoiceitems values(1001,7,1,170)
insert tbl_invoiceitems values(1002,8,2,300)
insert tbl_invoiceitems values(1003,9,1,130)
insert tbl_invoiceitems values(1004,10,1,120)

--subqueries

select * from  tbl_customers where customeremailid not in(
select distinct customeremailid from tbl_invoices)

select * from tbl_items where itemid not in(
select distinct itemid from tbl_invoiceitems)

select * from tbl_items where itemid=(select top 1 itemid from tbl_invoiceitems group by itemid
order by sum(itemqty) desc) 

--joins //types of joins

select  tbl_invoices.invoiceid, tbl_invoices.invoicecity,tbl_invoices.invoicedate,
tbl_invoices.customeremailid,tbl_customers.customername
from tbl_invoices join tbl_customers
on 
tbl_invoices.customeremailid=tbl_customers.customeremailid



--invoiceid,invoicedate,invoicecity,itemid,itemqty,itemprice.

select tbl_invoices.invoiceid,tbl_invoices.invoicedate,tbl_customers.customername,tbl_invoices.customeremailid,
tbl_invoices.invoicecity,tbl_invoiceitems.itemid,tbl_invoiceitems.itemqty,
tbl_invoiceitems.itemprice,tbl_items.itemname from tbl_invoices join tbl_invoiceitems
on
tbl_invoices.invoiceid=tbl_invoiceitems.invoiceid
join tbl_items
on
tbl_invoiceitems.itemid=tbl_items.itemid
join tbl_customers
on
tbl_invoices.customeremailid=tbl_invoices.customeremailid

--Inner join //common data in between two tables//matching data

select tbl_customers.customeremailid,tbl_customers.customername,tbl_invoices.invoiceid,
tbl_invoices.invoicecity from tbl_customers
join tbl_invoices
on
tbl_customers.customeremailid=tbl_invoices.customeremailid

--left outer join
select tbl_customers.customeremailid,tbl_customers.customername,tbl_invoices.invoiceid,
tbl_invoices.invoicecity from tbl_customers
left outer join tbl_invoices
on
tbl_customers.customeremailid=tbl_invoices.customeremailid

--right outer join
select tbl_customers.customeremailid,tbl_customers.customername,tbl_invoices.invoiceid,
tbl_invoices.invoicecity from tbl_customers
right outer join tbl_invoices
on
tbl_customers.customeremailid=tbl_invoices.customeremailid

--full join
select tbl_customers.customeremailid,tbl_customers.customername,tbl_invoices.invoiceid,
tbl_invoices.invoicecity from tbl_customers
full join tbl_invoices
on
tbl_customers.customeremailid=tbl_invoices.customeremailid

--cross join
select * from tbl_customers cross join tbl_invoices


