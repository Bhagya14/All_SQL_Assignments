declare @count int=0;
select @count=count(*) from tbl_customers;
select @count;
if( @count=0)
begin
 select @count;
 end
 else
 begin
 
-- set @count=0
 select 'No Customers';
end

declare @c int=0;
while(@c<10)
begin
select @c;
set @c=@c+1;
end

create proc proc_customers
as
begin
select * from tbl_customers where customerAge>18;
end

exec proc_customers

create proc proc_addcustomer
(@cid int,@ccname varchar(100),@city varchar(100),@cage int)
as
begin
declare @count int=0;
select @count=count(*) from tbl_customers where customerid=@cid; 
iF(@count=0)
begin
insert tbl_customers values(@cid,@ccname,@city,@cage)
end
return @@rowcount;
end


select * from tbl_customers
--output param
create proc proc_customer_name_contact(@email varchar(100),@name varchar(100) output,@contact varchar(100) output)
as
begin
select @name=customername,@contact=customercontactno
from tbl_customers where customeremailid=@email;
end

declare @email varchar(100),@name varchar(100),@contact varchar(100)
set @email='bhagya@gmail.com'
exec proc_customer_name_contact @email,@name output,@contact output
select @name,@contact,@email;

select * from Customersinfo
--login check
create proc proc_login(@id int ,@password varchar(100))
as
 begin
 declare @count int=0;
 select @count=count(*) from Customersinfo where customerid=@id and customerpassword=@password;
 return @count;
 end

 declare @count int
 exec @count=proc_login 1000,'pass123'
 select @count;

 --count reaches to 5 account will be blocked

 --functions in SQL

 select  * from tbl_customers
 --scalar functions
 create function func_fulladdress
 (@name varchar(100),@address varchar(100),@contact varchar(100))
 returns varchar(max)
 as
 begin
 declare @fulladdress varchar(max)
 set @fulladdress=@name+' , '+@address+','+@contact;
 return @fulladdress;
 end

 select customeremailid,
 dbo.func_fulladdress(customername,customeraddress,customercontactno) as 'full address' from tbl_customers

 create function funcinvoiceamt(@invid int)
 returns int
 as
 begin
 declare @amt int
 select @amt=sum(itemqty*itemprice) from tbl_invoiceitems
 where invoiceid=@invid;
 return @amt
 end

 select invoiceid,customeremailid,dbo.funcinvoiceamt(invoiceid)
 as
 'Invaoice value' from tbl_invoices

 --table valued functions/INLINE

 create function func_custdata(@city varchar(100))
 returns table
 as
 return select customeremailid,customername,customercontactno
 from tbl_customers where customercity=@city;

 select * from dbo.func_custdata('bang')

  --MULTILINE functions

  create function func_multi_custdata(@city varchar(100))
  returns @tab table(emailid varchar(100),name varchar(100),city varchar(100))
  as
  begin
  insert @tab values('XYZ@aa.com','ABCD','bang');
  insert @tab select customeremailid,customername,customercity from tbl_customers where customercity=@city
  return
  end

  select * from dbo.func_multi_custdata('bang');
--to create a copy of one table
  select * into tbl_customersnew from tbl_customers

  --union
  select * from tbl_customers
  union
  select * from tbl_customersnew

  --union all(it shows all data together)
 select * from tbl_customers
  union all
  select * from tbl_customersnew

  --intersect(common data)
  select * from tbl_customers
  intersect
  select * from tbl_customersnew

  --except(uncommon data)
  select * from tbl_customers
  except
  select * from tbl_customersnew

  --Triggers
   create trigger trg_customers_insert on tbl_customers
  for insert
  as
  begin
  select 'customer inserted';
  end
  --magic tables
  alter trigger trg_customers_insert on tbl_customers
  for insert
  as
  begin
  select * from inserted
  select * from deleted
  select 'customer inserted';
  end

  insert tbl_customers values(1099,'xyz','bang',26)

  sp_helptrigger tbl_customers

  --drop trigger
  drop trigger trg_customers_insert

create table stock
(
itemid int primary key,
stock int
)

insert stock values(1,10)
insert stock values(2,10)
select * from stock

create table rec_items
(
recid int identity(100,1) primary key,
itemid int,
recqty int
)

create table orders 
(
orderid int identity(1000,1) primary key,
itemid int,
qty int
)

insert rec_items values(1,5)

create trigger trg_stock_rec_update
on rec_items
for insert
as
 begin
 declare @itemid int
 declare @recqty int 
 select @itemid=itemid,@recqty=recqty from inserted
 update stock set stock=stock+@recqty where itemid=@itemid
 end

 select * from stock

 insert orders values(1,3)

 select * from orders
 select * from stock

 create trigger trg_stock_orders
 on orders
 for insert
 as
 begin
 declare @itemid int
 declare @itemqty int
 select @itemid=itemid,@itemqty=qty from inserted
 declare @stockqty int 
 select @stockqty=stock from stock where itemid=@itemid;
 if(@stockqty>=@itemqty)
 begin
 update stock set stock=stock-@itemqty where itemid=@itemid;
 end
 else
 begin
 rollback tran;
 end
 end


















