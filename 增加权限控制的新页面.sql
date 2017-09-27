select * from SYS25_MODULE
select * from SYS25_MODULE_MVNO where MVNOID=350000 and PARENTID=1000000010
select * from CRM_CONFIG_MVNOFORMNAME where MVNOID=350000

insert into SYS25_MODULE_MVNO values( (select isnull(max(id),1000000000)+1 from SYS25_MODULE_MVNO where ID like '10%'),
(select isnull(max(SHOWMODULEID),1000000000)+1 from SYS25_MODULE_MVNO where SHOWMODULEID like '10%'),1000000010,2,'','',350000,14,GETDATE())

select * from SYS25_MODULE_ELEMENTS

select * from CRM_DEALERS_PACKAGE_MAPPING

select * from CRM_CONFIG_MVNOFORMNAME where MVNOID=350000


DECLARE @SHOWMODULEID INT
SET @SHOWMODULEID=(select isnull(max(SHOWMODULEID),1000000000)+1 from SYS25_MODULE_MVNO where SHOWMODULEID like '10%')

delete from SYS25_MODULE_MVNO where MODULEFULLNAME='ETalk.CRM.UI.Customer.Youfone.ParentControl.ParentControlInformation' and MVNOID=350000
delete from SYS25_MODULE_MVNO where MODULEFULLNAME='ETalk.CRM.UI.Customer.Youfone.ProductsInformation' and MVNOID=350000
insert into SYS25_MODULE_MVNO values( (select isnull(max(id),1000000000)+1 from SYS25_MODULE_MVNO where ID like '10%'),
,1000000010,2,'','',350000,14,GETDATE())

update SYS25_MODULE_MVNO set 