
select distinct ElementID from sys30_permission where FullClassName ='ETalk.CRM.UI.Customer.Youfone.SimpleSettingInformation'
and elementid like '%autotop%'

etchkAutoTopUp
etlblAUTOTOPUPAMOUNT
etlblAUTOTOPUPSTATUS
ettxtAutoTopUpAmount

select * from  sys30_permission  where elementid in (
 'etchkAutoTopUp','etlblAUTOTOPUPAMOUNT',
 'etlblAUTOTOPUPSTATUS','ettxtAutoTopUpAmount'
) and roleid in (select  roleid from sys25_role where dealerid=380000)


update sys30_permission set iswrite=1,ishide=0,isread=0,ismandetory=0 where elementid in (
 'etlblDepositAmount','ettxtDepositAmount',
 'etlblDepositAmountVAT','ettxtDepositAmountVAT',
 'etlblTotalCreditLimitAmount','ettxtTotalCreditLimitAmout',
 'etlblTotalCreditLimitAmountVAT','ettxtTotalCreditLimitAmountVAT',
 'etlblUnbilledBalance','ettxtUnbilledBalance',
 'etlblUnbilledBalanceVAT','ettxtUnbilledBalanceVAT',
 'etlblBonusWithVAT','ettxtBonusWithVAT'
) and roleid in (select  roleid from sys25_role where dealerid=350000)



SELECT * FROM CRM_EMAIL_HISTORY
SELECT * FROM CRM_SMS_HISTORY
UPDATE CRM_EMAIL_HISTORY SET STATUSID=0
UPDATE CRM_SMS_HISTORY set sentdate=null, ISSENT=0 where issent=0