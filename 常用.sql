-- QUERY THE PERMISSION BY THE USER NAME
SELECT * FROM SYS30_PERMISSION  WHERE ROLEID IN (SELECT RoleID FROM SYS25_USER_ROLE WHERE UserID IN (SELECT USERID FROM SYS25_USER WHERE USERNAME LIKE '%ADMIN@DEFAULT.COM%')) AND ElementID LIKE 'TSB%' AND FormName='Infoform'
--Find the password
select * from CRM_EMAIL_HISTORY where EMAILTO in (select EMAILTO from CRM_EMAIL_HISTORY where emailsubject='New Password' group by EMAILTO having COUNT(emailid)>1) order by EMAILTO,CREATEDATE desc

select * from SYS25_USER where USERNAME like '%john.tubbing@elephanttalk.com%'
select * from SYS25_USER_ROLE where UserID=1400000054
select * from SYS25_ROLE where RoleID in 
(
1000000001,
1000000013,
1000000041,
1000000045,
1000000049,
1610000001,
1000000037,
1000000005,
1000000017,
1000000021,
1000000009
)

john.tubbing@elephanttalk.com  and j.rademaker@uts.an

select * from SYS30_PERMISSION where RoleID=1000000001 and FullClassName like '%bank%' and ElementID='ettxtParentId'

delete from SYS30_PERMISSION where RoleID=1000000001 and FullClassName like '%bank%' and ElementID='ettxtParentId'
select * from SYS30_PERMISSION where RoleID=-1 and FullClassName like '%simp%' and ElementID='ettxtParentId'

select * from sys25_module where moduleid=1000000344
select * from sys25_module where ModuleFullPath like 'ETalk.CRM.UI.Customer.Youfone.BankInformation'

1000000344	1000000581
1000000590	1000000579
select * from sys25_module_bk where ModuleID=1000000581
select * from sys25_module_bk where ModuleID=1000000579

1000000344

select * from SYS25_USER where USERNAME='john.tubbing@elephanttalk.com'
select * from SYS25_USER where USERNAME='j.rademaker@uts.an'

update SYS25_USER set ACCOUNT_CHANGE_ALERTING=90 where USERNAME='john.tubbing@elephanttalk.com'
update SYS25_USER set ACCOUNT_CHANGE_ALERTING=90 where USERNAME='j.rademaker@uts.an'