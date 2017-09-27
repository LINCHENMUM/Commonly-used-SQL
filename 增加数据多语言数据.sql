

insert SYS_MULTILINGUAL(ID,DealerID,LanguageID,FormFullName,ControlID,Value,Text,ToolTipText,ShowOrder,Link,Description,UpdateDate,State,DictionaryTypeID,REGEXTYPEID,DEFAULTTEXT,ControlType,ShowType) 
values(	(select isnull(MAX(id),1000000000)+1 from SYS_MULTILINGUAL where ID like '10%')	,	-1	,	1043	,	N'Common'	,	N'Common'	,	N'3007'	,	N'Mobile Callback'	,	N'Carrier Pre Select'	,	0	,	NULL	,	N'SUB SERVICE'	,	GETDATE()	,	1	,	12007	,	NULL	,	NULL	,	NULL	,	1	)