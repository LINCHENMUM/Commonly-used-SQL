
 
 
  select * from SYS25_ROLE where 
 RoleID in (select RoleID from SYS25_USER_ROLE where 
 UserID=(select USERID from SYS25_USER where USERNAME='john.tubbing@elephanttalk.com'))
 
 1300000353	20	210000	NPL Customer  care Admin


1300000705	20	370000	Suri Customer care Admin


1400000179	20	320000	dUTS Customer  care Admin


 
 
 select * from SYS25_ROLE where 
 RoleID in (select RoleID from SYS25_USER_ROLE where 
 UserID=(select USERID from SYS25_USER where USERNAME='marcel@88tele.com'))
 
 
 
 select * from SYS30_PERMISSION where RoleID='1300000353' and FullClassName = 'ETalk.CRM.UI.Customer.Youfone.ProductsInformation'
  select * from SYS30_PERMISSION where RoleID='1300000705' and FullClassName = 'ETalk.CRM.UI.Customer.Youfone.ProductsInformation'
    select * from SYS30_PERMISSION where RoleID='1400000179' and FullClassName = 'ETalk.CRM.UI.Customer.Youfone.ProductsInformation'
        select * from SYS30_PERMISSION where RoleID='1400000179' and FullClassName like '%product%'
    
     
    
    
    
    select * from SYS25_MODULE_MVNO where MVNOID=350000 and PARENTID=1000000010
    
    select * from crm_mvno_voicemail_setting
    
    select * from CRM_CONFIG_MVNOFORMNAME where MVNOID IN (320000,210000,370000)
    
    select * from CRM_DEALERS where PARENTID=-1