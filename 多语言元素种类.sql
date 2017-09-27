SELECT TOP 100 * FROM sys_multilingual_0317 where controltype='Permission control'

SELECT * FROM sys_multilingual_0317 WHERE (TEXT IS NOT NULL AND TEXT <>' ' AND ISNUMERIC(TEXT)<=0 AND LEFT(TEXT,1)<>'-') ORDER BY Text 
SELECT * FROM sys_multilingual_0317 WHERE (TEXT IS NOT NULL AND TEXT <>' ' AND ISNUMERIC(TEXT)<=0) ORDER BY Text 

select distinct controltype  from sys_multilingual_0317 

update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.VistaButton' where controlid like 'VB%' OR controlid like 'VSB%' or controlid like 'btn%'
update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.ETLabel' where controlid like 'etlbl%'
update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.ETDataGridView' where controlid like 'etdv%'
update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.ETListView' where controlid like 'lv%'
update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.ETRadioButton' where controlid like 'rb%'
update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.ETGroupBox' where controlid like 'gb%'
update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.ETCheckBox' where (controlid like 'etch%' or controlid like 'cb%')
update sys_multilingual_0317 set controltype='ETalk.CRM.UI.ControlLibrary.ETComboBox' where (controlid like 'etcmb%' or controlid like 'etcb%')

select * from sys_multilingual_0317 where controlID like 'VSB%' OR controlID like 'VB%' OR controlID like 'TRIP%'

ETalk.CRM.UI.ControlLibrary.VistaButton
Report
ETalk.CRM.UI.ControlLibrary.ETDataGridView
ETalk.CRM.UI.ControlLibrary.ETListView
ETalk.CRM.UI.ControlLibrary.ETRadioButton
NULL
ETalk.CRM.UI.ControlLibrary.ETGroupBox
ETalk.CRM.UI.ControlLibrary.ETCheckBox
ETalk.CRM.UI.ControlLibrary.ETLabel

Permission control
ETalk.CRM.UI.ControlLibrary.ETComboBox
May 18 2010 10:14AM