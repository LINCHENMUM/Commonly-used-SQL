  
--1. For sys25_module  

Chris: ������裬��ÿ����ҳ�涼��Ҫ�ģ����ǲ�����ص�ģ�����ݣ�Ȩ�޿��Ƶ�ҳ�棬Ҫ����ModuleLeve=2��,������������ݣ������γ�ҳ������ͽṹ��ModuleLeve=2��ҳ���Ӧ��MODULEID,��Ȩ�޿��Ƶ�SYS30_PERMISSION��������Ҫ��������MODULEID=12��CUSOTMER CAREҳ����׷��.MODULEID��PARENTIDһ�𹹳����ĸ��ӽڵ㡣

insert into SYS25_MODULE values(
(SELECT ISNULL(MAX(ModuleID),1000000000)+1 FROM SYS25_MODULE WHERE ModuleID LIKE '100%'),
(select ParentID from SYS25_MODULE WHERE ModuleForm='ETalk.CRM.UI.Customer' AND ModuleFullPath='ETalk.CRM.UI.Customer.E88telecom.ProductsInformation'),
'DepositInformation','ETalk.CRM.UI.Customer','ETalk.CRM.UI.Customer.E88telecom.DepositInformation',2,null,GETDATE(),14,0,null,null,null)



--2. For sys25_module_mvno
Chris��������裬�ǽ�����ɫ���������ҳ�����ͽṹ�ı�Ҫ���̡��������Ҳ��ÿ��MVNO����Ҫ�ģ���ÿ��MVNO����Ҫ����������ҳ�����ͽṹ���ݡ�������������ֶ�����۱����£�

SHOWMODULEID: �µ�ҳ����룬�ǵ�ǰ SHOWMODULEID+1������ֶθ���3��SYS25_MODULE_ELEMENTS��SHOWMODULEID��һ�µġ�
PARENTID: ����¼����ҳ���Ӧ��PARENTҳ���ID
MODULELEVEL: ����ҳ��ļ���parentid=-1����0��Ȩ�޿��Ƶ�ҳ�棬Ҫ����MODULELEVEL=2;
MODULENAME: ҳ������ƣ�ͨ��ȡCLASSNAME��������ƣ�
MODULEFULLNAME: ҳ���FULLL CLASS NAME
MVNOID: ����ҳ����Ǹ�MVNO���ӵ�MVNOID,ͨ����ͬ��ҳ�棬ÿ��MVNO������һ����¼������ID��MVNOID֮�⣬�����ֶζ���ͬ��
CREATEUSER: 14����ADMIN
CREATEDATE�� getdate()

declare @showmoduleid int
set @showmoduleid=(SELECT ISNULL(MAX(SHOWMODULEID),1000000000)+1 FROM SYS25_MODULE_MVNO WHERE SHOWMODULEID LIKE '100%')
insert into SYS25_MODULE_MVNO values
 ((SELECT ISNULL(MAX(ID),1000000000)+1 FROM SYS25_MODULE_MVNO WHERE ID LIKE '100%'),
 @showmoduleid,1000000010,2,'DepositInformation','ETalk.CRM.UI.Customer.E88telecom.DepositInformation',350000,14,GETDATE())
 
 --select * from SYS25_MODULE_ELEMENTS where SHOWMODULEID=1000002320
 --select * from SYS25_MODULE_MVNO where MODULEFULLNAME='ETalk.CRM.UI.Customer.Telecombination.Provisioning.TCResourceEdit'
 --update SYS25_MODULE_ELEMENTS set SHOWMODULEID=1000002282 where FULLCLASSNAME='ETalk.CRM.UI.Customer.Telecombination.Provisioning.TCResourceEdit' and SHOWMODULEID=1000002320
 
 
 --3. For sys25_module_element

Chris: ������裬�����ӵ�2����MODULELEVEL=2��ҳ���Ԫ�ء�������ͬ��ҳ�棬��2�����裬ÿ��MVNO����Ҫ����һ����¼���������裬
����ͬ��ҳ�棬ÿ��Ԫ��ֻ��Ҫ����һ����¼�����ֶ���˼���£�

SHOWMODULEID: ���ڵ�2����MODULELEVEL=2��SHOWMODULEID
ELEMENTID: Ԫ������
ELEMENTTYPE: Ԫ�����ͣ����Դӱ��ĵ�����ȡ���������δ��������ͣ���Ӵ����ȡ���µ����͡�

 insert into SYS25_MODULE_ELEMENTS
 values((SELECT ISNULL(MAX(ID),1000000000)+1 FROM SYS25_MODULE_ELEMENTS WHERE ID LIKE '100%'),
 @showmoduleid,	N'ETalk.CRM.UI.Customer.E88telecom.DepositInformation'	,	N'etlblOriDepositAmount'	,	8	)

--4. For sys30_permission
Chris��������裬�����Ӿ���Ԫ�ص�Ȩ�޿��ƣ�Ȩ�ް����ɶ�����д���������֡��ֶ���˼��
ROLEID: -1��������Ԫ�ظ�¼�룬������-1��
MODULEID: ���ǵ�1��������sys25_module ���ӦModuleLeve=2��ҳ���MODULEID;
FORMNAME: ҳ��CLASS����ҳ�����֣�
FULLCLASSNAME: ҳ��CLASSNAME.
ELEMENTID: Ԫ�����ƣ�
ELEMENTNAME: ͨ��=ELEMENTID
ISREAD: 1=true,0=false,�����=1����ʾ��Ԫ����ҳ��ֻ����
ISWRITE:��ͬISREAD;
ISHIDE: ��ͬISREAD;
ISMandetory: ���ֶ�Ŀǰδ��ЧӦ�ã�
FORMAT, EVENT, DEFAULTVALUES: �ֶ�Ŀǰδ��ЧӦ�ã�
XAXIS, YAXIS: �ֶ���ҳ��ĺ����꣬������,ĿǰΪ�ա�



insert into SYS30_PERMISSION
 values((SELECT ISNULL(MAX(PermissionID),1000000000)+1 FROM SYS30_PERMISSION WHERE PermissionID LIKE '100%'),	-1	,	
 (select ModuleID from SYS25_MODULE WHERE ModuleFullPath='ETalk.CRM.UI.Customer.E88telecom.DepositInformation')	,
 	N'DepositInformation'	,	N'ETalk.CRM.UI.Customer.E88telecom.DepositInformation'	,	N'etlblOriDepositAmount'	,	N'etlblOriDepositAmount'	,
 		0	,	1	,	0	,	0	,	NULL	,	NULL	,	NULL	,	null	,	null	)

--5. For sys_multilingual
Chris��������裬�ǲ���Ȩ�޿��Ƶ�Ԫ�صĶ����Է��롣����ͨ�Ķ����Խű�������ͬ��Ψһ�������SHOWTYPE=2

INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'ETalk.CRM.UI.Customer.E88telecom.DepositInformation', 'etlblOriDepositAmount', NULL, 'Original Deposit Amount',
  NULL, NULL, NULL, NULL, GETDATE(), NULL, NULL, NULL, NULL, 'ETalk.CRM.UI.ControlLibrary.ETLabel', 1)

��¼��Ԫ�����ͣ�

    --ETCheckBox  =1 
    --ETComboBox  = 2 
    --ETcontextMenuStrip = 3
    --ETdataGridView = 4
    --ETDataGridViewPager  =5
    --ETDateTimePicker =6
    --ETGroupBox=7
    --ETLabel=8
    --ETlistView =9
    --ETRadioButton =10
    --ETTabControl =11
    --ETTextBox =12 
    --ETToolStrip = 13
    --ETTreeView =14
    --VistaButton =15
    --ETToolButton=16

