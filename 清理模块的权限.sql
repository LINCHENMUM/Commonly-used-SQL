--Back up data

SELECT * INTO SYS25_MODULE_MVNO_20100611 FROM SYS25_MODULE_MVNO
SELECT * INTO SYS25_MODULE_ELEMENTS_20100611 FROM SYS25_MODULE_ELEMENTS 

--For SIM CARD has been done in Live 
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbNewOrder', 'Add New Order', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbEditOrder', 'Edit Order', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbDeleteOrder', 'Delete Order', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbExportFile', 'Export File', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbImportResponseFile', 'Import Response File', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbAssignSIMCard', 'Assign SIM Card', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbReAssign', 'Re-Assign SIM Card', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbPreActivate', 'Pre-Activate', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbICCAndIMSIAdd', 'Add ICC/IMSI', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbICCAndIMSIEdit', 'Edit ICC/IMSI', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'tsbDelete', 'Delete ICC/IMSI', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SIMCard.SIMCard', 'vsbSearch', 'Search SIM Card', 15


--select * from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.SIMCard.SIMCard'

--select * from SYS25_MODULE_MVNO where PARENTID=1000000015 and MODULEFULLNAME ='ETalk.CRM.UI.SIMCard.SIMCard'
--select * from SYS25_MODULE_MVNO where PARENTID=1000000015 

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=1000000015 and MODULEFULLNAME <>'ETalk.CRM.UI.SIMCard.SIMCard'

--SELECT * FROM SYS25_MODULE_ELEMENTS WHERE SHOWMODULEID=1000000116


UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=1000000116 AND 
ELEMENTID  not in 
(
'tsbNewOrder',
'tsbEditOrder',
'tsbDeleteOrder',
'tsbExportFile',
'tsbImportResponseFile',
'tsbAssignSIMCard',
'tsbReAssign',
'tsbPreActivate',
'tsbICCAndIMSIAdd',
'tsbICCAndIMSIEdit',
 'tsbDelete',
 'vsbSearch'
)

--For NPM

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'tsbGenerate', 'Generate', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'tsbEdit', 'Modify', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'tsbUpdateSatus', 'Update Status', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'tsbExit', 'Exit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'tsbSearch', 'Search', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'tsbAdvanceSearch', 'Advance Search', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'vsbQuery', 'Advance Query', 15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.NPM.NumberPoolManagement', 'vsbQueryBatch', 'Query Batch', 15

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.NPM.NumberPoolManagement')
 and MODULEFULLNAME <>'ETalk.CRM.UI.NPM.NumberPoolManagement'
 
 UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.NPM.NumberPoolManagement')
  AND 
ELEMENTID  not in 
(
'tsbGenerate',
'tsbEdit',
'tsbUpdateSatus',
'tsbSearch',
'tsbAdvanceSearch',
'vsbQuery',
'vsbQueryBatch'
)

--(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.NPM.NumberPoolManagement')

--select  from SYS25_MODULE_MVNO where PARENTID=1000000072 and MODULEFULLNAME ='ETalk.CRM.UI.SIMCard.SIMCard'
--select * from SYS25_MODULE_MVNO where PARENTID=1000000015 



--For lifecycle

----EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Lifecycle.frmSetting', 'btnSaveSetting', 'Save', 16

----update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Lifecycle.frmSetting')
---- and MODULEFULLNAME <>'ETalk.CRM.UI.Lifecycle.frmSetting'
 
---- UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Lifecycle.frmSetting')
----  AND 
----ELEMENTID  not in 
----(
----'btnSaveSetting'
----)

------For lifecycle multilingual
----update SYS_MULTILINGUAL set Text='Confirm', UpdateDate=GETDATE() where FormFullName='ETalk.CRM.UI.Lifecycle.frmSmsTemplet' and ControlID='etbtnSave' and LanguageID=1033 and DealerID=-1
 
--For payment query

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Payment.QueryMain', 'tsbQuery', 'Query', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Payment.QueryMain', 'tsbAdvanceSearch', 'Advance Search', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Payment.QueryMain', 'vsbAdvanceSearch', 'Search', 15

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Payment.QueryMain')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Payment.QueryMain'
 
  UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Payment.QueryMain')
  AND 
ELEMENTID  not in 
(
'tsbQuery',
'tsbAdvanceSearch',
'vsbAdvanceSearch'
)


--Rating dictionary

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.Dictionary', 'tsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.Dictionary', 'tsbDelete', 'Delete', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.Dictionary', 'tsbModify', 'Modify', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.Dictionary', 'tsbImport', 'Import', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.Dictionary', 'tsbExport', 'Export', 16


update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Rating.Dictionary')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Rating.Dictionary'

  UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Rating.Dictionary')
  AND 
ELEMENTID  not in 
(
'tsbAdd',
'tsbDelete',
'tsbModify',
'tsbImport',
'tsbExport'
)

--Ratteplan

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.RatePlan', 'tsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.RatePlan', 'tsbDelete', 'Delete', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.RatePlan', 'tsbModify', 'Modify', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.RatePlan', 'tsbCopy', 'Copy', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.RatePlan', 'tsbExport', 'Export', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.RatePlan', 'tsbImport', 'Import', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Rating.RatePlan', 'tsbTerminate', 'Terminate', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Rating.RatePlan')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Rating.RatePlan'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Rating.RatePlan')
  AND 
ELEMENTID  not in 
(
'tsbAdd',
'tsbDelete',
'tsbModify',
'tsbImport',
'tsbExport',
'tsbCopy',
'tsbTerminate'
)
--Billing
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbBuild', 'Build', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbView', 'View Front', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbViewDetail', 'View Detail', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbExport', 'Export', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbEdit', 'Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbBatchEdit', 'Batch Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbMail', 'Mail', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Billing.Invoice', 'tsbDelete', 'Delete', 16


update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Billing.Invoice')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Billing.Invoice'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Billing.Invoice')
  AND 
ELEMENTID  not in 
(
'tsbBuild',
'tsbView',
'tsbViewDetail',
'tsbExport',
'tsbEdit',
'tsbBatchEdit',
'tsbMail',
'tsbDelete'
)

--Report
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Report.ReportViewList', 'tsbtnPreview', 'Preview', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Report.ReportViewList')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Report.ReportViewList'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Report.ReportViewList')
  AND 
ELEMENTID  not in 
(
'tsbtnPreview'
)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Report.ReportsManage', 'etTsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Report.ReportsManage', 'etTsbEdit', 'Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Report.ReportsManage', 'etTsbDelete', 'Delete', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Report.ReportsManage', 'etTsbPermission', 'Report Permission', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Report.ReportsManage')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Report.ReportsManage'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Report.ReportsManage')
  AND 
ELEMENTID  not in 
(
'etTsbAdd',
'etTsbEdit',
'etTsbDelete',
'etTsbPermission'
)

--Role management

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement', 'tsbAddRole', 'Add Role', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement', 'tsbDeleteRole', 'Delete Role', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement', 'tsbModifyRole', 'Modify Role', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement', 'tsbCopyRole', 'Copy Role', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement', 'tsbRolePermission', 'Set Role Permission', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement')
 and MODULEFULLNAME <>'ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.SystemManagement.RoleManagement.RoleManagement')
  AND 
ELEMENTID  not in 
(
'tsbAddRole',
'tsbDeleteRole',
'tsbModifyRole',
'tsbCopyRole',
'tsbRolePermission'
)


--Theme and Style
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Style.StyleMain', 'tsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Style.StyleMain', 'tsEdit', 'Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Style.StyleMain', 'tsbSave', 'Save', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Style.StyleMain', 'tsbDelete', 'Delete', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.ThemeManagement.Style.StyleMain')
 and MODULEFULLNAME <>'ETalk.CRM.UI.ThemeManagement.Style.StyleMain'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.ThemeManagement.Style.StyleMain')
  AND 
ELEMENTID  not in 
(
'tsbAdd',
'tsEdit',
'tsbSave',
'tsbDelete'
)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Theme.ThemeMain', 'tsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Theme.ThemeMain', 'tsEdit', 'Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Theme.ThemeMain', 'tsbSave', 'Save', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.ThemeManagement.Theme.ThemeMain', 'tsbDelete', 'Delete', 16


update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.ThemeManagement.Theme.ThemeMain')
 and MODULEFULLNAME <>'ETalk.CRM.UI.ThemeManagement.Theme.ThemeMain'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.ThemeManagement.Theme.ThemeMain')
  AND 
ELEMENTID  not in 
(
'tsbAdd',
'tsEdit',
'tsbSave',
'tsbDelete'
)

--Online management
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.OnlineManagement.OnlineManagement.OnlineManagement', 'etTsbQuery', 'Query', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.OnlineManagement.OnlineManagement.OnlineManagement', 'etTsbSend', 'Send', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.OnlineManagement.OnlineManagement.OnlineManagement', 'etTsbDelete', 'Delete', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.OnlineManagement.OnlineManagement.OnlineManagement')
 and MODULEFULLNAME <>'ETalk.CRM.UI.OnlineManagement.OnlineManagement.OnlineManagement'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.OnlineManagement.OnlineManagement.OnlineManagement')
  AND 
ELEMENTID  not in 
(
'etTsbQuery',
'etTsbSend',
'etTsbDelete'
)

--Dictionary
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI', 'etTsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI', 'etTsbSave', 'Save', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI', 'etTsbEdit', 'Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI', 'tsList', 'List', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI', 'etTsbExcel', 'Excel', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI', 'etTsbImport', 'Import', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI', 'etTsbDelete', 'Delete', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Dictionary.Dictionary.DictionaryUI')
  AND 
ELEMENTID  not in 
(
'etTsbAdd',
'etTsbSave',
'etTsbEdit',
'tsList',
'etTsbExcel',
'etTsbImport',
'etTsbDelete'
)


--Alerting
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Alert.Alert.AlertRuleNew', 'etTsbSave', 'Save', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Alert.Alert.AlertRuleNew')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Alert.Alert.AlertRuleNew'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Alert.Alert.AlertRuleNew')
  AND 
ELEMENTID  not in 
(
'etTsbSave'
)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Alert.AlertTemplateNew', 'etTsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Alert.AlertTemplateNew', 'etTsbModify', 'Modify', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Alert.AlertTemplateNew', 'etTsbSave', 'Save', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Alert.AlertTemplateNew', 'etTsbDelete', 'Delete', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Alert.AlertTemplateNew')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Alert.AlertTemplateNew'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Alert.AlertTemplateNew')
  AND 
ELEMENTID  not in 
(
'etTsbAdd',
'etTsbModify',
'etTsbSave',
'etTsbDelete'
)


--Flex alerting

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Telecombination.RestrictionSetForm', 'tsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Telecombination.RestrictionSetForm', 'tsbEdit', 'Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Telecombination.RestrictionSetForm', 'tsbDelete', 'Delete', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Customer.Telecombination.RestrictionSetForm', 'vsbSearch', 'Search', 15

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Customer.Telecombination.RestrictionSetForm')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Customer.Telecombination.RestrictionSetForm'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Customer.Telecombination.RestrictionSetForm')
  AND 
ELEMENTID  not in 
(
'tsbAdd',
'tsbEdit',
'tsbDelete',
'vsbSearch'
)
--DRE
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.DRE.DRE.DREForm', 'tsbQuery', 'Query', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.DRE.DRE.DREForm', 'tsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.DRE.DRE.DREForm', 'tsbEdit', 'Edit', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.DRE.DRE.DREForm', 'tsbDelete', 'Delete', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.DRE.DRE.DREForm')
 and MODULEFULLNAME <>'ETalk.CRM.UI.DRE.DRE.DREForm'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.DRE.DRE.DREForm')
  AND 
ELEMENTID  not in 
(
'tsbQuery',
'tsbAdd',
'tsbEdit',
'tsbDelete'
)
--Multilingual
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.MultiLingualManagement.SystemManagement', 'tsbAdd', 'Add', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.MultiLingualManagement.SystemManagement', 'tsbDelete', 'Delete', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.MultiLingualManagement.SystemManagement', 'tsbModify', 'Modify', 16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.SystemManagement.MultiLingualManagement.SystemManagement', 'tsbMVNOLanguage', 'MVNOLanguage', 16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.SystemManagement.MultiLingualManagement.SystemManagement')
 and MODULEFULLNAME <>'ETalk.CRM.UI.SystemManagement.MultiLingualManagement.SystemManagement'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.SystemManagement.MultiLingualManagement.SystemManagement')
  AND 
ELEMENTID  not in 
(
'tsbAdd',
'tsbDelete',
'tsbModify',
'tsbMVNOLanguage'
)

--Voucher card

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherManageForm','btnExport ','Export',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherManageForm','btnChange ','Change Status',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherManageForm','btnCommisionAssign ','Commision Assign',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherManageForm','btnAssign','Assign To',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherManageForm','btnFilter','Filter',15

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.VoucherCard.VoucherManageForm')
 and MODULEFULLNAME <>'ETalk.CRM.UI.VoucherCard.VoucherManageForm'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.VoucherCard.VoucherManageForm')
  AND 
ELEMENTID  not in 
(
'btnExport',
'btnChange',
'btnCommisionAssign',
'btnAssign',
'btnFilter'
)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherForm','btnActivate','Activate Batch(s)',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherForm','btnQuery','Query Voucher Batch',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherForm','btnCreate','Create',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.VoucherCard.VoucherForm','vsbQueryVoucher','Query Voucher',15

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.VoucherCard.VoucherForm')
 and MODULEFULLNAME <>'ETalk.CRM.UI.VoucherCard.VoucherForm'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.VoucherCard.VoucherForm')
  AND 
ELEMENTID  not in 
(
'btnActivate',
'btnQuery',
'btnCreate',
'vsbQueryVoucher'
)

--Promotion
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.frmPromotionManagement','tsAdd ','Add',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.frmPromotionManagement','tsEdit ','Edit',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.frmPromotionManagement','tsDelete ','Delete',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.frmPromotionManagement','tsbApply ','Apply',16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.frmPromotionManagement')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Promotion.frmPromotionManagement'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.frmPromotionManagement')
  AND 
ELEMENTID  not in 
(
'tsAdd',
'tsEdit',
'tsDelete',
'tsbApply'
)
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.FFManagementForm','tsbSave ','Save',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.FFManagementForm','tsbAdd ','Add',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.FFManagementForm','tsbEdit ','Edit',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.FFManagementForm','tsbDelete ','Delete',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.FFManagementForm','tsbEnabled ','Enabled',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.FFManagementForm','tsbDisabled ','Disabled',16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.FFManagementForm')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Promotion.FFManagementForm'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.FFManagementForm')
  AND 
ELEMENTID  not in 
(
'tsbSave',
'tsbAdd',
'tsbEdit',
'tsbDelete',
'tsbEnabled',
'tsbDisabled'
)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.PromotionPopup.SelectPromotion','tsbSave ','Save',16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.PromotionPopup.SelectPromotion')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Promotion.PromotionPopup.SelectPromotion'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.PromotionPopup.SelectPromotion')
  AND 
ELEMENTID  not in 
(
'tsbSave'
)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.Promotion.PopupPromotionForm','tsChangePromotion ','Change Promotion',16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.PopupPromotionForm')
 and MODULEFULLNAME <>'ETalk.CRM.UI.Promotion.PopupPromotionForm'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.Promotion.PopupPromotionForm')
  AND 
ELEMENTID  not in 
(
'tsChangePromotion'
)

--Coin

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinPorting','tsbSubmit ','Submit',15

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.COIN.Coin.CoinPorting')
 and MODULEFULLNAME <>'ETalk.CRM.UI.COIN.Coin.CoinPorting'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.COIN.Coin.CoinPorting')
  AND 
ELEMENTID  not in 
(
'tsbSubmit'
)

EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinMessage','toolStripButton1 ','Refresh',16
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinMessage','vsSend101 ','101 Reply',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinMessage','vsSend102 ','102 Send',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinMessage','vsSend113 ','113 Reply',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinMessage','vsSend114 ','114 Send',15
EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinMessage','vbArchive111 ','Archive',15


update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.COIN.Coin.CoinMessage')
 and MODULEFULLNAME <>'ETalk.CRM.UI.COIN.Coin.CoinMessage'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.COIN.Coin.CoinMessage')
  AND 
ELEMENTID  not in 
(
'toolStripButton1',
'vsSend101',
'vsSend102',
'vsSend113',
'vsSend114',
'vbArchive111'
)


EXEC USPOUTPUT_FORM_ELEMENT 'ETalk.CRM.UI.COIN.Coin.CoinQuery','etTsbQuery ','Query',16

update SYS25_MODULE_MVNO set MVNOID=MVNOID+1 where PARENTID=(select top 1 parentid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.COIN.Coin.CoinQuery')
 and MODULEFULLNAME <>'ETalk.CRM.UI.COIN.Coin.CoinQuery'
 
   UPDATE SYS25_MODULE_ELEMENTS SET ELEMENTID='CRM25DELETE'+ELEMENTID WHERE SHOWMODULEID=(select top 1 showmoduleid from SYS25_MODULE_MVNO WHERE MODULEFULLNAME='ETalk.CRM.UI.COIN.Coin.CoinQuery')
  AND 
ELEMENTID  not in 
(
'etTsbQuery'
)

