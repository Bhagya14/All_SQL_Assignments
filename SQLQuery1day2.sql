create table tbl_accounts
(
accountid int identity(100,1),
customername varchar(100),
accountbalance int 
)

insert tbl_accounts values('david',5000)
select @@IDENTITY

select * from tbl_accounts