use   master 
go 
exec   sp_renamedb   CRM25_CUSTOMER_NL_TEST_MERGE,CRM25_CUSTOMER_NL_TEST_MERGE_OLD


-- the following line sets the database to "Single User" mode
ALTER DATABASE DBNAME SET SINGLE_USER WITH ROLLBACK IMMEDIATE
-- the following line sets the new collation
ALTER DATABASE DBNAME COLLATE COLLATIONNAME
-- the following line sets the database back to "Multi User" mode
ALTER DATABASE CRM25_CUSTOMER_NL_TEST_MERGE SET MULTI_USER



use master
go
sp_who2

For whatever <spid> that is connected to the database, run:

kill 55;
kill 64;

When that is successful, run:

alter database CORE set multi_user;


sa|CRM25dbto
