'ETalk.CRM.UI.Customer.Base.SelectResource'
'ETalk.CRM.UI.Customer.Vodafone.SelectResource'


select  * from sys25_module where modulefullpath='ETalk.CRM.UI.Customer.Vodafone.SelectResource'
select  * from sys25_module where modulefullpath='ETalk.CRM.UI.Customer.Base.SelectResource'

insert into sys25_module values(
(select max(moduleid)+1 from SYS25_MODULE where ModuleID like '10%'),1000000580,'SelectResource','ETalk.CRM.UI.Customer','ETalk.CRM.UI.Customer.Vodafone.SelectResource',
2,null,null,null,null,null,null,null
)

select * from SYS25_MODULE_MVNO where mvnoid in (150000,700000,500000) and MODULEFULLNAME like '%SelectResource%'
select * from SYS25_MODULE_MVNO where  MODULEFULLNAME like '%SelectResource%'

update SYS25_MODULE_elements set FULLCLASSNAME='ETalk.CRM.UI.Customer.Vodafone.SelectResource'   
where  FULLCLASSNAME ='ETalk.CRM.UI.Customer.Base.SelectResource'
update SYS25_MODULE_elements set ELEMENTID='ETalk.CRM.UI.Customer.Vodafone.SelectResource'   
where  ELEMENTID ='ETalk.CRM.UI.Customer.Base.SelectResource'

SELECT top 100* FROM SYS30_PERMISSION

SELECT * FROM SYS30_PERMISSION WHERE RoleID IN (
select RoleID from SYS25_ROLE WHERE DEALERID IN (
130000,
150000,
360000,
500000,
700000
)
) AND FullClassName='ETalk.CRM.UI.Customer.Base.SelectResource'




UPDATE SYS30_PERMISSION SET MODULEID=1000000616,FullClassName='ETalk.CRM.UI.Customer.Vodafone.SelectResource'
WHERE RoleID IN (
select RoleID from SYS25_ROLE WHERE DEALERID IN (
130000,
150000,
360000,
500000,
700000
)
) AND FullClassName='ETalk.CRM.UI.Customer.Base.SelectResource'

UPDATE SYS30_PERMISSION SET MODULEID=1000000616,ELEMENTID='ETalk.CRM.UI.Customer.Vodafone.SelectResource'
WHERE RoleID IN (
select RoleID from SYS25_ROLE WHERE DEALERID IN (
130000,
150000,
360000,
500000,
700000
)
) AND ELEMENTID='ETalk.CRM.UI.Customer.Base.SelectResource'


select * From CRM_DEALERS where parentid=-1
correct:
1000000616




select top 100 * from SYS25_MODULE_elements where FULLCLASSNAME like '%SelectResource%'

select * from crm_config_mvnoformname where classanme=


select * from sys25_module where ModuleID=1000000573
select * from sys25_module where ModuleID=20
select * from sys25_module where ModuleID=12
select * from sys25_module where ParentID=12
select * from sys25_module where ParentID=20
select * from sys25_module where ParentID=1000000580
select * from sys25_module where ParentID=1000000573