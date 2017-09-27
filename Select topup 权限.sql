select * from SYS25_MODULE_MVNO where MODULEFULLNAME ='ETalk.CRM.UI.Customer.Base.PromotionSelectNumber'

select * from SYS25_MODULE_MVNO where PARENTID=1000000040
select * from SYS25_MODULE_MVNO where PARENTID=1000000268 and mvnoid=150000
select * from SYS25_MODULE_MVNO where PARENTID=1000000273 and mvnoid=150000
select * from SYS25_MODULE_ELEMENTS where SHOWMODULEID=1000000273

select * from SYS25_MODULE where ModuleFullPath='ETalk.CRM.UI.Customer.Base.TopUpSelectNumber'

select * from SYS30_PERMISSION where FullClassName='ETalk.CRM.UI.Customer.Base.TopUpSelectNumber'


select * from sys_multilingual where FormFullName='ETalk.CRM.UI.Customer.Base.TopUpSelectNumber' and ShowType=2

select * from SYS25_MODULE_MVNO where MODULEFULLNAME ='ETalk.CRM.UI.Customer.Base.PromotionSelectNumber'

-- delete the page
--delete from SYS25_MODULE_MVNO where MODULEFULLNAME ='ETalk.CRM.UI.Customer.Base.PromotionSelectNumber'
--delete from SYS25_MODULE_ELEMENTS where FullClassName='ETalk.CRM.UI.Customer.Base.PromotionSelectNumber' and SHOWMODULEID=1000000272
--delete from SYS30_PERMISSION where FullClassName='ETalk.CRM.UI.Customer.Base.PromotionSelectNumber'
--delete from sys_multilingual where FormFullName='ETalk.CRM.UI.Customer.Base.PromotionSelectNumber' and ShowType=2


insert into SYS30_PERMISSION
 values((SELECT ISNULL(MAX(PermissionID),1000000000)+1 FROM SYS30_PERMISSION WHERE PermissionID LIKE '100%'),	-1	,	
 9999,
 	N'TopUpSelectNumber'	,	N'ETalk.CRM.UI.Customer.Base.TopUpSelectNumber'	,	N'vsbOK'	,	N'vsbOK'	,
 		0	,	1	,	0	,	0	,	NULL	,	NULL	,	NULL	,	null	,	null	)
 		
 		insert into SYS30_PERMISSION
 values((SELECT ISNULL(MAX(PermissionID),1000000000)+1 FROM SYS30_PERMISSION WHERE PermissionID LIKE '100%'),	-1	,	
 9999,
 	N'TopUpSelectNumber'	,	N'ETalk.CRM.UI.Customer.Base.TopUpSelectNumber'	,	N'vsbCancel'	,	N'vsbCancel'	,
 		0	,	1	,	0	,	0	,	NULL	,	NULL	,	NULL	,	null	,	null	)
 		
 		insert into SYS30_PERMISSION
 values((SELECT ISNULL(MAX(PermissionID),1000000000)+1 FROM SYS30_PERMISSION WHERE PermissionID LIKE '100%'),	-1	,	
 9999,
 	N'TopUpSelectNumber'	,	N'ETalk.CRM.UI.Customer.Base.TopUpSelectNumber'	,	N'etlblNumberTitle'	,	N'etlblNumberTitle'	,
 		0	,	1	,	0	,	0	,	NULL	,	NULL	,	NULL	,	null	,	null	)
 		
 		
 		INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'ETalk.CRM.UI.Customer.Base.TopUpSelectNumber', 'vsbOK', NULL, 'OK',
  NULL, NULL, NULL, NULL, GETDATE(), NULL, NULL, NULL, NULL, 'ETalk.CRM.UI.ControlLibrary.VistaButton', 2)
  
  INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'ETalk.CRM.UI.Customer.Base.TopUpSelectNumber', 'vsbCancel', NULL, 'Cancel',
  NULL, NULL, NULL, NULL, GETDATE(), NULL, NULL, NULL, NULL, 'ETalk.CRM.UI.ControlLibrary.VistaButton', 2)
  
  INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'ETalk.CRM.UI.Customer.Base.TopUpSelectNumber', 'etlblNumberTitle', NULL, 'OK',
  NULL, NULL, NULL, NULL, GETDATE(), NULL, NULL, NULL, NULL, 'ETalk.CRM.UI.ControlLibrary.ETLabel', 2)
  
  
  SELECT TOP 10 * FROM SYS_MULTILINGUAL WHERE ControlType LIKE '%VistaButton%'