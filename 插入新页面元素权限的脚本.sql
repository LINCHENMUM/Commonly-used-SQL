  
--1. For sys25_module  

Chris: 这个步骤，是每个新页面都需要的，这是插入相关的模块数据，权限控制的页面，要求是ModuleLeve=2的,这样插入的数据，最终形成页面的树型结构。ModuleLeve=2的页面对应的MODULEID,在权限控制的SYS30_PERMISSION表至关重要。可以拿MODULEID=12的CUSOTMER CARE页面层层追溯.MODULEID和PARENTID一起构成树的父子节点。

insert into SYS25_MODULE values(
(SELECT ISNULL(MAX(ModuleID),1000000000)+1 FROM SYS25_MODULE WHERE ModuleID LIKE '100%'),
(select ParentID from SYS25_MODULE WHERE ModuleForm='ETalk.CRM.UI.Customer' AND ModuleFullPath='ETalk.CRM.UI.Customer.E88telecom.ProductsInformation'),
'DepositInformation','ETalk.CRM.UI.Customer','ETalk.CRM.UI.Customer.E88telecom.DepositInformation',2,null,GETDATE(),14,0,null,null,null)



--2. For sys25_module_mvno
Chris：这个步骤，是建立角色管理所需的页面树型结构的必要过程。这个过程也是每个MVNO所必要的，即每个MVNO都需要插入这样的页面树型结构数据。这个步骤插入的字段意义粉笔如下：

SHOWMODULEID: 新的页面加入，是当前 SHOWMODULEID+1，这个字段跟第3步SYS25_MODULE_ELEMENTS的SHOWMODULEID是一致的。
PARENTID: 这是录入新页面对应的PARENT页面的ID
MODULELEVEL: 这是页面的级别，parentid=-1的是0，权限控制的页面，要求是MODULELEVEL=2;
MODULENAME: 页面的名称，通常取CLASSNAME的最后名称；
MODULEFULLNAME: 页面的FULLL CLASS NAME
MVNOID: 这是页面给那个MVNO增加的MVNOID,通常相同的页面，每个MVNO都增加一条记录，除了ID，MVNOID之外，其它字段都相同；
CREATEUSER: 14代表ADMIN
CREATEDATE： getdate()

declare @showmoduleid int
set @showmoduleid=(SELECT ISNULL(MAX(SHOWMODULEID),1000000000)+1 FROM SYS25_MODULE_MVNO WHERE SHOWMODULEID LIKE '100%')
insert into SYS25_MODULE_MVNO values
 ((SELECT ISNULL(MAX(ID),1000000000)+1 FROM SYS25_MODULE_MVNO WHERE ID LIKE '100%'),
 @showmoduleid,1000000010,2,'DepositInformation','ETalk.CRM.UI.Customer.E88telecom.DepositInformation',350000,14,GETDATE())
 
 --select * from SYS25_MODULE_ELEMENTS where SHOWMODULEID=1000002320
 --select * from SYS25_MODULE_MVNO where MODULEFULLNAME='ETalk.CRM.UI.Customer.Telecombination.Provisioning.TCResourceEdit'
 --update SYS25_MODULE_ELEMENTS set SHOWMODULEID=1000002282 where FULLCLASSNAME='ETalk.CRM.UI.Customer.Telecombination.Provisioning.TCResourceEdit' and SHOWMODULEID=1000002320
 
 
 --3. For sys25_module_element

Chris: 这个步骤，是增加第2步骤MODULELEVEL=2的页面的元素。对于相同的页面，第2个步骤，每个MVNO都需要增加一条记录，但本步骤，
对相同的页面，每个元素只需要增加一条记录。各字段意思如下：

SHOWMODULEID: 等于第2步的MODULELEVEL=2的SHOWMODULEID
ELEMENTID: 元素名称
ELEMENTTYPE: 元素类型，可以从本文档最后获取，如果发现未定义的类型，请从代码获取最新的类型。

 insert into SYS25_MODULE_ELEMENTS
 values((SELECT ISNULL(MAX(ID),1000000000)+1 FROM SYS25_MODULE_ELEMENTS WHERE ID LIKE '100%'),
 @showmoduleid,	N'ETalk.CRM.UI.Customer.E88telecom.DepositInformation'	,	N'etlblOriDepositAmount'	,	8	)

--4. For sys30_permission
Chris：这个步骤，是增加具体元素的权限控制，权限包括可读，可写，隐藏三种。字段意思：
ROLEID: -1，所有新元素刚录入，都设置-1；
MODULEID: 这是第1步所属的sys25_module 表对应ModuleLeve=2的页面的MODULEID;
FORMNAME: 页面CLASS最后的页面名字；
FULLCLASSNAME: 页面CLASSNAME.
ELEMENTID: 元素名称；
ELEMENTNAME: 通常=ELEMENTID
ISREAD: 1=true,0=false,即如果=1，表示该元素在页面只读；
ISWRITE:如同ISREAD;
ISHIDE: 如同ISREAD;
ISMandetory: 该字段目前未有效应用；
FORMAT, EVENT, DEFAULTVALUES: 字段目前未有效应用；
XAXIS, YAXIS: 字段在页面的横坐标，纵坐标,目前为空。



insert into SYS30_PERMISSION
 values((SELECT ISNULL(MAX(PermissionID),1000000000)+1 FROM SYS30_PERMISSION WHERE PermissionID LIKE '100%'),	-1	,	
 (select ModuleID from SYS25_MODULE WHERE ModuleFullPath='ETalk.CRM.UI.Customer.E88telecom.DepositInformation')	,
 	N'DepositInformation'	,	N'ETalk.CRM.UI.Customer.E88telecom.DepositInformation'	,	N'etlblOriDepositAmount'	,	N'etlblOriDepositAmount'	,
 		0	,	1	,	0	,	0	,	NULL	,	NULL	,	NULL	,	null	,	null	)

--5. For sys_multilingual
Chris：这个步骤，是插入权限控制的元素的多语言翻译。跟普通的多语言脚本几乎相同，唯一区别的是SHOWTYPE=2

INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'ETalk.CRM.UI.Customer.E88telecom.DepositInformation', 'etlblOriDepositAmount', NULL, 'Original Deposit Amount',
  NULL, NULL, NULL, NULL, GETDATE(), NULL, NULL, NULL, NULL, 'ETalk.CRM.UI.ControlLibrary.ETLabel', 1)

附录：元素类型：

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

