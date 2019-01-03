create database OnlineFoodOrderingDB

use OnlineFoodOrderingDB

create table restaurants
(
retaurantid int identity(1000,1) primary key,
restaurantname varchar(100) not null,
restaurantaddress varchar(100) not null,
restaurantcity varchar(100) not null,
Contactno varchar(15) not null,
)

create table Rmenuitems
(
Menuid int identity(100,1) primary key,
Restaurantid int foreign key references restaurants(retaurantid),
Menuname varchar(100) not null,
menutype varchar(100) not null,
menucategory varchar(100) not null,
menuprice int not null,
menudesc varchar(100) not null
)

create table customers
(
customerid varchar(100) primary key,
customername varchar(100) not null,
customercity varchar(100) not null,
customerdob datetime not null,
customergender varchar(100) not null,
customerpassword varchar(100)
)

create table orders
(
orderid int identity(10,1) primary key,
customerid varchar(100) foreign key references customers(customerid),
orderdate datetime not null,
deliveryaddress varchar(100) not null,
orderstatus varchar(100) not null
)

create table ordermenus
(
orderid int foreign key references orders(orderid),
menuid int foreign key references Rmenuitems(menuid),
menuqty int not null,
menuprice int not null
)
select * from restaurants
insert restaurants values('parkvenue','BTM','bangalore','9702135577')
insert restaurants values('empire','BTM','bangalore','9702789077')
insert restaurants values('nandana','JPN','chennai','9706754377')
insert restaurants values('meghanas','MJS','chennai','9779652577')
insert restaurants values('ssparadise','BDA','hyderabad','989005577')

select * from Rmenuitems
insert Rmenuitems values(1000,'jeera rice','veg','southindian',100,'jeera,ghee,rice,onions')
insert Rmenuitems values(1001,'biriyani rice','veg','southindian',150,'vegetables,ghee,rice,spices')
insert Rmenuitems values(1002,'veg fried rice','veg','chineese',200,'vegetables,ghee,rice,sauces')
insert Rmenuitems values(1003,'tomato rice','veg','southindian',120,'tomato,ghee,rice,onions')
insert Rmenuitems values(1004,'lemon rice','veg','northindian',90,'lemon,rice')

select * from customers

insert customers values('bagyaliki@gmail.com','bhagya','bang','06/14/1995','female','pass123')
insert customers values('anil@gmail.com','anil','bangalore','07/24/1995','male','pass123')
insert customers values('sai@gmail.com','sai','hyderabad','03/14/1998','male','pass123')
insert customers values('surya@gmail.com','surya','hyderabad','08/16/1999','male','pass123')
insert customers values('ram@gmail.com','ramya','bangalore','06/19/1995','female','pass123')

select * from orders

insert orders values('bagyaliki@gmail.com',GETDATE(),'JPN','dispatched')
insert orders values('sai@gmail.com',GETDATE(),'BTM','delivered')
insert orders values('ram@gmail.com',GETDATE(),'JPN','preparing')
insert orders values('surya@gmail.com',GETDATE(),'BDA','dispatched')
insert orders values('surya@gmail.com',GETDATE(),'BDA','dispatched')

select * from ordermenus

insert ordermenus values(10,100,1,100)
insert ordermenus values(11,101,2,120)
insert ordermenus values(15,102,2,150)
insert ordermenus values(13,103,1,200)
insert ordermenus values(14,104,3,250)

--restaurants with specific city
select * from restaurants
where restaurantcity='bangalore'

--list of restaurants along with menus

select restaurants.retaurantid,restaurants.restaurantname,Rmenuitems.Menuid,
Rmenuitems.Menuname,Rmenuitems.menuprice from restaurants
join Rmenuitems
on
restaurants.retaurantid=Rmenuitems.Restaurantid

--list of restaurants along with menus

select restaurants.retaurantid,restaurants.restaurantname,Rmenuitems.Menuid,
Rmenuitems.Menuname,Rmenuitems.menuprice from restaurants
join Rmenuitems
on
 restaurants.retaurantid=rmenuitems.restaurantid
 where restaurantcity='bangalore'

 --list of orders of a customer
 select * from orders 
 where customerid='bagyaliki@gmail.com'

 --orders along with ordermenus
 select orders.orderid,orders.customerid,orders.orderdate,ordermenus.Menuid,ordermenus.menuqty,ordermenus.menuprice
 from orders
 join ordermenus
 on
 orders.orderid=ordermenus.orderid

 --5 orders of specific customers
 select top 5 * from orders
 where customerid='surya@gmail.com'

 --menus in price asc order
 select * from ordermenus
 order by menuprice asc

 --list of cities along with no of restaurants

 select restaurantcity,COUNT(*) from restaurants
 group by restaurantcity

 --list of customers who never placed any order

 select * from customers where customerid not in (select distinct customerid from orders) 

 --max price

 select top 1 * from Rmenuitems order by menuprice desc; 

 --second highest menu price
 select top 1 * from Rmenuitems
where Menuid in 
(select top 2 Menuid from Rmenuitems order by menuprice desc)
order by menuprice asc
