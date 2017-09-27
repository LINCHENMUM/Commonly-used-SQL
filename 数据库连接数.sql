

SP_WHO ''

--查询数据库连接数
SELECT count(*) from master..sysprocesses where dbid=db_id('CRM25_CUSTOMER_LEBARA_Regressing')

--查询具体的数据库连接情况
SELECT * FROM
[Master].[dbo].[SYSPROCESSES] WHERE [DBID]
IN
(
  SELECT
   [DBID]
  FROM
   [Master].[dbo].[SYSDATABASES]
  WHERE
   NAME='CRM25_CUSTOMER_LEBARA_Regressing'
)
Lastwaittype Waittype Description 
LCK_M_SCH_S 0x01 Schema stability 
LCK_M_SCH_M 0x02 Schema modification 
LCK_M_S 0x03 Share 
LCK_M_U 0x04 Update 
LCK_M_X 0x05 Exclusive 
LCK_M_IS 0x06 Intent-Share 
LCK_M_IU 0x07 Intent-Update  
LCK_M_IX 0x08 Intent-Exclusive 
LCK_M_SIU 0x09 Shared intent to update 
LCK_M_SIX 0x0a Share-Intent-Exclusive 
LCK_M_UIX 0x0b Update-Intent-Exclusive 
LCK_M_BU 0x0c Bulk Update 
LCK_M_RS_S 0x0d Range-share-share 
LCK_M_RS_U 0x0e Range-share-Update 
LCK_M_RI_NL 0x0F Range-Insert-NULL 
LCK_M_RI_S 0x10 Range-Insert-Shared 
LCK_M_RI_U 0x11 Range-Insert-Update 
LCK_M_RI_X 0x12 Range-Insert-Exclusive 
LCK_M_RX_S 0x13 Range-exclusive-Shared 
LCK_M_RX_U 0x14 Range-exclusive-update 
LCK_M_RX_X 0x15 Range-exclusive-exclusive 


--查看配置数
sp_configure

--统计连接数
SELECT a.status,a.hostname,a.loginame,COUNT(1) AS number,GETDATE() AS genDate FROM
[Master].[dbo].[SYSPROCESSES] a WITH(NOLOCK) WHERE [DBID]
IN
(
  SELECT
   [DBID]
  FROM
   [Master].[dbo].[SYSDATABASES] b WITH(NOLOCK)
  WHERE
   NAME='CRM25_CUSTOMER'
) 
GROUP BY a.status,a.hostname,a.loginame
ORDER BY number DESC


SELECT TOP 10 a.spid,a.login_time,a.last_batch,a.status,a.hostname,a.loginame,a.cmd,qt.text FROM
[Master].[dbo].[SYSPROCESSES] a WITH(NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(a.sql_handle) AS qt
 WHERE a.[DBID]
IN
(
  SELECT
   [DBID]
  FROM
   [Master].[dbo].[SYSDATABASES] b WITH(NOLOCK)
  WHERE
   NAME='CRM25_CUSTOMER'
) 

SELECT qtt.text
FROM 
[Master].[dbo].[SYSPROCESSES] aa WITH(NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(aa.sql_handle) AS qtt
WHERE aa.sql_handle IN (

SELECT DISTINCT a.sql_handle FROM
[Master].[dbo].[SYSPROCESSES] a WITH(NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(a.sql_handle) AS qt
 WHERE a.[DBID]
IN
(
  SELECT
   [DBID]
  FROM
   [Master].[dbo].[SYSDATABASES] b WITH(NOLOCK)
  WHERE
   NAME='CRM25_CUSTOMER'
) 
AND a.status='sleeping'
)






--当前正在运行的脚本的内容.
SELECT  [Spid] = session_Id ,
        ecid ,
        [Database] = DB_NAME(sp.dbid) ,
        [User] = nt_username ,
        [Status] = er.status ,
        [Wait] = wait_type ,
        [Individual Query] = SUBSTRING(qt.text, er.statement_start_offset / 2,
                                       ( CASE WHEN er.statement_end_offset = -1
                                              THEN LEN(CONVERT(NVARCHAR(MAX), qt.text))
                                                   * 2
                                              ELSE er.statement_end_offset
                                         END - er.statement_start_offset ) / 2) ,
        [Parent Query] = qt.text ,
        Program = program_name ,
        Hostname ,
        nt_domain ,
        start_time
FROM    sys.dm_exec_requests er
        INNER JOIN sys.sysprocesses sp ON er.session_id = sp.spid
        CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS qt
WHERE   session_Id > 50 -- Ignore system spids. 
        AND session_Id NOT IN ( @@SPID ) -- Ignore this current statement. 
        AND spid=302
ORDER BY 1 ,
        2


