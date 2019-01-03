create database MVC_Productdb

use MVC_productdb

create table tbl_products
(
productid int identity(1000,1) primary key,
productname varchar(100) not null,
productprice int not null,
productcategory varchar(100) not null,
productimageaddress varchar(100)
)

create proc proc_addproduct(@name varchar(100),@price int,@category varchar(100),@imgaddress varchar(100))
as
begin
insert tbl_products values(@name,@price,@category,@imgaddress)
return @@identity
end

create proc proc_search(@key varchar(100))
as 
begin
select productid,productname,productcategory,productimageaddress from tbl_products
where productid like '%'+@key+'%' or
productname like '%'+@key+'%' or
productcategory like '%'+@key+'%' 
end      

create proc proc_find(@id int)
as
begin
select * from tbl_products where productid=@id
end

alter proc proc_update(@id int,@price int,@category varchar(100))
as
begin
update tbl_products set productprice=@price,productcategory=@category
where productid=@id
return @@rowcount
end
select * from tbl_products