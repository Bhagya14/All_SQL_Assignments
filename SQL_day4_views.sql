select * from tbl_customers

alter view v_customers
with encryption,schemabinding
as
select customeremailid,customername,customeraddress from dbo.tbl_customers where customercity='bang'
with check option

select * from db_pathfront.dbo.tbl_customers

select * from v_customers 

update v_customers set customercity='mumbai' where customername='sai'

delete v_customers where customeremailid='sai@gmail.com'

insert v_customers values('yz@gmail.com','abcd','mumbai','9898','snp')

sp_helptext v_customers

create table t1
(
code int,
name varchar(100)
)

insert t1 values(1001,'a');
insert t1 values(1002,'b');
create table t2
(
code int,
city varchar(100)
)
insert t2 values(1001,'bang');
insert t2 values(1002,'chennai');
alter view v_joindata
as
select t1.code,t1.name,t2.city from t1 join t2 on t1.code=t2.code
--with check option

select * from v_joindata


insert v_joindata values(1003,'c','bang')

create trigger trg_v_joindata
on v_joindata
instead of insert
as
begin
declare @id int
declare @name varchar(100)
declare @city varchar(100)
select @id=code ,@name=name,@city=city from inserted
insert t1 values(@id,@name)
insert t2 values(@id,@city)
end

create table tbl_test1
(
code int identity(1,1) ,
name varchar(100),
city varchar(100),
)

declare @count int=0
while(@count<100000)
begin
insert tbl_test1 values('abcd','bang');
set @count=@count+1;
end

select * from tbl_test1 where code=51000

create clustered index idx
on
tbl_test1(code)

create table xyz
(
code int,
name varchar(5)
)

begin tran
begin try
insert xyz values(1,'abc');
insert xyz values(2,'bdb');
commit tran
end try
begin catch
rollback tran
end catch


begin tran

insert xyz values(111,'abcd');

rollback tran

commit tran
