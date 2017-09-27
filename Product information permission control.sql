1. update sys25_module set ModuleFullPath ='ETalk.CRM.UI.Customer.Bundle.ProductsInformation' where ModuleFullPath like '%ProductsInformation%'

2. update SYS25_MODULE_MVNO set showmoduleid=1000000039 where modulefullname like '%ProductsInformation%'
update SYS25_MODULE_MVNO set modulefullname='ETalk.CRM.UI.Customer.Bundle.ProductsInformation' where modulefullname like '%ProductsInformation%'

3.delete from SYS25_MODULE_elements where showmoduleid IN (1000001979,
1000002264,
1000002273,
1000002300)
update SYS25_MODULE_elements set fullclassname='ETalk.CRM.UI.Customer.Bundle.ProductsInformation' where fullclassname like '%ProductsInformation%'


update SYS25_MODULE_elements set ELEMENTID='ETalk.CRM.UI.Customer.Bundle.ProductsInformation' where ELEMENTID='ETalk.CRM.UI.Customer.Youfone.ProductsInformation'

4. UPDATE SYS30_PERMISSION SET fullclassname ='ETalk.CRM.UI.Customer.Bundle.ProductsInformation' WHERE fullclassname IN 
(
'ETalk.CRM.UI.Customer.E88telecom.ProductsInformation',
'ETalk.CRM.UI.Customer.Telecombination.Product.ProductsInformation',
'ETalk.CRM.UI.Customer.Vodafone.ProductsInformation',
'ETalk.CRM.UI.Customer.Youfone.ProductsInformation'
)



EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','btnAdd','Add',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','btnDelete','Delete',16;
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','vsbEdit','Edit',16;
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblProductInformation','Production Information',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblBalance','Balance',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtBalance','Balance',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblBalanceInclVAT','Balance incl VAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etTextBox1','Balance incl VAT',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','label1','--',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','vsbPromotion','Promotion',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','vsbExtraUsage','Extra Usage',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','vsbLoyaltyPoints','Loyalty Points',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblBalanceWithVAT','BalanceWithVAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtBalanceWithVAT','BalanceWithVAT',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblCreditLimit','CreditLimit',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtCreditLimit','CreditLimit',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblCreditLimitVAT','CreditLimitVAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtCreditLimitVAT','CreditLimitVAT',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblUnbilledBalance','UnbilledBalance',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtUnbilledBalance','UnbilledBalance',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblUnbilledBalanceVAT','UnbilledBalanceVAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtUnbilledBalanceVAT','UnbilledBalanceVAT',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblDepositAmount','DepositAmount',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtDepositAmount','DepositAmount',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblDepositAmountVAT','DepositAmountVAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtDepositAmountVAT','DepositAmountVAT',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblTotalCreditLimitAmount','TotalCreditLimitAmount',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtTotalCreditLimitAmout','TotalCreditLimitAmount',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblTotalCreditLimitAmountVAT','TotalCreditLimitAmountVAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtTotalCreditLimitAmountVAT','TotalCreditLimitAmountVAT',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblFreeMinutes','FreeMinutes',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtFreeMinutes','FreeMinutes',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblBonusWithVAT','BonusWithVAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtBonusWithVAT','BonusWithVAT',12
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','vsbtnChangeCreditLimit','ChangeCreditLimit',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','vsbtnResetUnbilledBalance','ResetUnbilledBalance',16





select * from  sys30_permission  where elementid in (
 'etlblDepositAmount','ettxtDepositAmount',
 'etlblDepositAmountVAT','ettxtDepositAmountVAT',
 'etlblTotalCreditLimitAmount','ettxtTotalCreditLimitAmout',
 'etlblTotalCreditLimitAmountVAT','ettxtTotalCreditLimitAmountVAT',
 'etlblUnbilledBalance','ettxtUnbilledBalance',
 'etlblUnbilledBalanceVAT','ettxtUnbilledBalanceVAT',
 'etlblBonusWithVAT','ettxtBonusWithVAT'
) and roleid in (select  roleid from sys25_role where dealerid=350000)


update sys30_permission set iswrite=1,ishide=0,isread=0,ismandetory=0 where elementid in (
 'etlblDepositAmount','ettxtDepositAmount',
 'etlblDepositAmountVAT','ettxtDepositAmountVAT',
 'etlblTotalCreditLimitAmount','ettxtTotalCreditLimitAmout',
 'etlblTotalCreditLimitAmountVAT','ettxtTotalCreditLimitAmountVAT',
 'etlblUnbilledBalance','ettxtUnbilledBalance',
 'etlblUnbilledBalanceVAT','ettxtUnbilledBalanceVAT',
 'etlblBonusWithVAT','ettxtBonusWithVAT'
) and roleid in (select  roleid from sys25_role where dealerid=350000)





 

select * from sys30_permission where elementid in (
 'etlblBalanceWithVAT','ettxtBalanceWithVAT',
 'etlblBalance','ettxtBalance'
) and roleid in (select  roleid from sys25_role where dealerid=320000)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblBalanceWithVAT','BalanceWithVAT',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtBalanceWithVAT','BalanceWithVAT',12

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','etlblBalance','Balance',8
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtBalance','Balance',12

select * from CRM_DEALERS where parentid=-1

select * from sys_multilingual where text ='zipconde'

select * from sys_multilingual where FormFullName ='ETalk.CRM.UI.Customer.Bundle.ProductsInformation' 
and (ControlID='etlblFreeMinutes' or ControlID='ettxtFreeMinutes') and ShowType=1

update sys_multilingual set DealerID=320000,UpdateDate=GETDATE() where ID=1000002645
update sys_multilingual set DealerID=-1,UpdateDate=GETDATE() where ID=2000000727

update sys_multilingual set DealerID=320000,UpdateDate=GETDATE() where ID in (1000002809,1000002808) 
update sys_multilingual set DealerID=-1,UpdateDate=GETDATE() where ID=1000005096
update sys_multilingual set DealerID=-1,UpdateDate=GETDATE(),text='Bonus balance(TextBox)' where ID=1000005114
EXEC USPOUTPUT_FORM_MULTILINGUAL 'ETalk.CRM.UI.Customer.Bundle.ProductsInformation','ettxtFreeMinutes','Bonus Without VAT(TextBox)',-1

update sys_multilingual set ShowType=2,dealerid=380000 where id=1000005983


select * from sys30_permission where elementid in (
 'etlblHandSet','etTxtHandSet'
) and roleid in (select  roleid from sys25_role where dealerid=380000)

select * from SYS30_PERMISSION where ElementID like '%handset%'

select * from SYS25_ROLE where RoleID in (
select RoleID from sys25_user_role where userid =(select userid from sys25_user where username='john.tubbing@elephanttalk.com'))