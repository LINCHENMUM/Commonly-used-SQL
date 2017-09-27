--获取SQL SERVER 所有表，字段名，主键，类型，长度，小数位数等信息

    --DROP TABLE CRM25_TABLES
      
     --CREATE TABLE CRM25_TABLES_NEW
     -- (
     -- TABLENAME VARCHAR(50),
     -- COLUMNORDER VARCHAR(10),
     -- COLUMNNAME VARCHAR(50),
     -- COLUMNFLAG VARCHAR(10),
     -- COLUMNPK   VARCHAR(10),
     -- COLUMNTYPE VARCHAR(30),
     -- COLUMNBYTENUM VARCHAR(30),
     -- COLUMNLENGTH VARCHAR(30),
     -- COLUMNDECIMAL VARCHAR(10),
     -- COLUMNNULL VARCHAR(5),
     -- COLUMNDEFAULT VARCHAR(50),
     -- DB VARCHAR(20)      
     -- )
INSERT INTO CRM25_TABLES_NEW 
SELECT (CASE WHEN a.colorder=1 THEN d.name ELSE d.name END)表名
      ,a.colorder 字段序号
      ,a.name 字段名
      ,(
           CASE 
                WHEN COLUMNPROPERTY(a.id ,a.name ,'IsIdentity')=1 THEN '√'
                ELSE ''
           END
       ) 标识
      ,(
           CASE 
                WHEN (
                         SELECT COUNT(*)
                         FROM   sysobjects
                         WHERE (
                                    NAME IN (SELECT NAME
                                             FROM   sysindexes
                                             WHERE (id=a.id)
                                                    AND (
                                                            indid IN (SELECT 
                                                                             indid
                                                                      FROM   
                                                                             sysindexkeys
                                                                      WHERE (id = a.id)
                                                                             AND (
                                                                                     colid IN (SELECT 
                                                                                                      colid
                                                                                               FROM   
                                                                                                      syscolumns
                                                                                               WHERE (id = a.id)
                                                                                                      AND (NAME = a.name))
                                                                                 ))
                                                        ))
                                )
                                AND (xtype='PK')
                     )>0 THEN '√'
                ELSE ''
           END
       ) 主键
      ,b.name 类型
      ,a.length 占用字节数
      ,COLUMNPROPERTY(a.id ,a.name ,'PRECISION') AS 长度
      ,ISNULL(COLUMNPROPERTY(a.id ,a.name ,'Scale') ,0) AS 小数位数
      ,(CASE WHEN a.isnullable=1 THEN '√' ELSE '' END) 允许空
      ,ISNULL(e.text ,'') 默认值
      ,'CRM25_CUSTOMER' DB 
FROM   syscolumns a
       LEFT JOIN systypes b
            ON a.xtype = b.xusertype
       INNER JOIN sysobjects d
            ON a.id = d.id
                AND d.xtype = 'U'
                AND d.name<>'dtproperties'
       LEFT JOIN syscomments e
            ON a.cdefault = e.id
ORDER BY
       d.name
       --a.id
      ,a.colorder



--2.0

drop table CRM20_TABLES_NEW
CREATE TABLE CRM20_TABLES_NEW
      (
      TABLENAME VARCHAR(50),
      COLUMNORDER VARCHAR(10),
      COLUMNNAME VARCHAR(50),
      COLUMNFLAG VARCHAR(10),
      COLUMNPK   VARCHAR(10),
      COLUMNTYPE VARCHAR(30),
      COLUMNBYTENUM VARCHAR(30),
      COLUMNLENGTH VARCHAR(30),
      COLUMNDECIMAL VARCHAR(10),
      COLUMNNULL VARCHAR(5),
      COLUMNDEFAULT VARCHAR(50),
      DB VARCHAR(20)      
      )
INSERT INTO CRM20_TABLES_NEW 
SELECT (CASE WHEN a.colorder=1 THEN d.name ELSE d.name END)表名
      ,a.colorder 字段序号
      ,a.name 字段名
      ,(
           CASE 
                WHEN COLUMNPROPERTY(a.id ,a.name ,'IsIdentity')=1 THEN '√'
                ELSE ''
           END
       ) 标识
      ,(
           CASE 
                WHEN (
                         SELECT COUNT(*)
                         FROM   sysobjects
                         WHERE (
                                    NAME IN (SELECT NAME
                                             FROM   sysindexes
                                             WHERE (id=a.id)
                                                    AND (
                                                            indid IN (SELECT 
                                                                             indid
                                                                      FROM   
                                                                             sysindexkeys
                                                                      WHERE (id = a.id)
                                                                             AND (
                                                                                     colid IN (SELECT 
                                                                                                      colid
                                                                                               FROM   
                                                                                                      syscolumns
                                                                                               WHERE (id = a.id)
                                                                                                      AND (NAME = a.name))
                                                                                 ))
                                                        ))
                                )
                                AND (xtype='PK')
                     )>0 THEN '√'
                ELSE ''
           END
       ) 主键
      ,b.name 类型
      ,a.length 占用字节数
      ,COLUMNPROPERTY(a.id ,a.name ,'PRECISION') AS 长度
      ,ISNULL(COLUMNPROPERTY(a.id ,a.name ,'Scale') ,0) AS 小数位数
      ,(CASE WHEN a.isnullable=1 THEN '√' ELSE '' END) 允许空
      ,ISNULL(e.text ,'') 默认值
      ,'CRM20_CUSTOMER' DB 
FROM   syscolumns a
       LEFT JOIN systypes b
            ON a.xtype = b.xusertype
       INNER JOIN sysobjects d
            ON a.id = d.id
                AND d.xtype = 'U'
                AND d.name<>'dtproperties'
       LEFT JOIN syscomments e
            ON a.cdefault = e.id
ORDER BY
       d.name
       --a.id
      ,a.colorder
      
  --Clear tables for 2.0
      
select distinct TABLENAME from CRM20_TABLES_NEW order by TABLENAME
--1.
delete from CRM20_TABLES_NEW where TABLENAME is null or LEN(tablename)=0
delete from CRM20_TABLES_NEW where TABLENAME ='category_test'
--2.
select * from CRM20_TABLES_NEW where TABLENAME like '%_0%' and TABLENAME not like '%lifecycle%'

delete from CRM20_TABLES_NEW where TABLENAME like '%_bak' and TABLENAME not like '%lifecycle%'
--3
select distinct TABLENAME from CRM20_TABLES_NEW where TABLENAME like '%0%'
delete from CRM20_TABLES_NEW where TABLENAME like '%0%'
--4
delete from CRM20_TABLES_NEW where tablename='sysdiagrams'
delete from CRM20_TABLES_NEW where tablename='taid'
delete from CRM20_TABLES_NEW where tablename='tbid'
delete from CRM20_TABLES_NEW where tablename='tblBatches'
delete from CRM20_TABLES_NEW where tablename='tblBatchPartialAggs'
delete from CRM20_TABLES_NEW where tablename='tblConnections'
delete from CRM20_TABLES_NEW where tablename='tblInterestingEvents'
delete from CRM20_TABLES_NEW where tablename='tblMiscInfo'
delete from CRM20_TABLES_NEW where tablename='tblPlanRows'
delete from CRM20_TABLES_NEW where tablename='tblPlans'
delete from CRM20_TABLES_NEW where tablename='tblProcedureNames'
delete from CRM20_TABLES_NEW where tablename='tblStatements'
delete from CRM20_TABLES_NEW where tablename='tblStmtPartialAggs'
delete from CRM20_TABLES_NEW where tablename='tblTimeIntervals'
delete from CRM20_TABLES_NEW where tablename='tblTracedEvents'
delete from CRM20_TABLES_NEW where tablename='tblTraceFiles'
delete from CRM20_TABLES_NEW where tablename='tblUniqueBatches'
delete from CRM20_TABLES_NEW where tablename='tblUniquePlanRows'
delete from CRM20_TABLES_NEW where tablename='tblUniquePlans'
delete from CRM20_TABLES_NEW where tablename='tblUniqueStatements'
delete from CRM20_TABLES_NEW where tablename='tblWarnings'
delete from CRM20_TABLES_NEW where tablename='tbTest'
delete from CRM20_TABLES_NEW where tablename='temp_trc'
delete from CRM20_TABLES_NEW where tablename='TMP_RATEPLANDETAILS_IMPORT'
delete from CRM20_TABLES_NEW where tablename='TraceTable'
delete from CRM20_TABLES_NEW where tablename='translog'
--5
select distinct TABLENAME from CRM20_TABLES_NEW where TABLENAME like '%temp%'
delete from CRM20_TABLES_NEW where tablename='mahome_temp'
delete from CRM20_TABLES_NEW where tablename='promotionFreeCallTemp'
delete from CRM20_TABLES_NEW where tablename='promotionFreeCallTemp2'
delete from CRM20_TABLES_NEW where tablename='SPAIN'



--Clear tables for 2.5


      
select distinct TABLENAME from CRM25_TABLES_NEW order by TABLENAME
--1.
delete from CRM25_TABLES_NEW where TABLENAME is null or LEN(tablename)=0
delete from CRM25_TABLES_NEW where tablename='sysdiagrams' 
--2.
select * from CRM25_TABLES_NEW where TABLENAME like '%_bak' and TABLENAME not like '%lifecycle%'

delete from CRM25_TABLES_NEW where TABLENAME like '%_bak' and TABLENAME not like '%lifecycle%'
--3
select distinct TABLENAME from CRM25_TABLES_NEW where TABLENAME like '%0%' and tablename !='sys30_permission'
delete from CRM25_TABLES_NEW where TABLENAME like '%0%' and tablename !='sys30_permission'
--4
delete from CRM25_TABLES_NEW where tablename='CRM_Rule_Parameter'
delete from CRM25_TABLES_NEW where tablename='sys25_module_bk'
delete from CRM25_TABLES_NEW where tablename='SYS25_MODULE_ELEMENTS_temp'
delete from CRM25_TABLES_NEW where tablename='SYS25_MODULE_MVNO_Customercare'
delete from CRM25_TABLES_NEW where tablename='SYS25_ROLE_admin'
delete from CRM25_TABLES_NEW where tablename='SYS25_ROLE_Guest'
delete from CRM25_TABLES_NEW where tablename='SYS25_ROLE_SuperUser'
delete from CRM25_TABLES_NEW where tablename='SYS25_ROLE_User'
delete from CRM25_TABLES_NEW where tablename='SYS_MULTILINGUAL_Rabi'
delete from CRM25_TABLES_NEW where tablename='SYS_CRM25_DATABASE_COLUMNS_SAM'
delete from CRM25_TABLES_NEW where tablename='SERVICE_NO'


--所有相同的表：242个

select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename

select * from CRM25_TABLES_NEW where tablename in (select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename) order by tablename
select * from CRM20_TABLES_NEW where tablename='CRM_CUSTOMER_POSTPAYMENT_CHARGE_HISTORY' in (select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename) order by tablename
--所有的表的合并记录

SELECT * INTO CRM2025_TABLES_NEW_ALL FROM CRM20_TABLES_NEW WHERE tablename in (select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename) order by tablename

INSERT INTO CRM2025_TABLES_NEW_ALL SELECT * FROM CRM25_TABLES_NEW WHERE tablename in (select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename) order by tablename
SELECT COUNT(1) FROM CRM2025_TABLES_NEW_ALL
SELECT COUNT(1) FROM CRM25_TABLES_NEW
SELECT COUNT(1) FROM CRM20_TABLES_NEW


--所有的相同的表的合并记录

SELECT * INTO CRM2025_TABLES_NEW_SAMETABLE FROM CRM20_TABLES_NEW WHERE tablename in (select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename) order by tablename

INSERT INTO CRM2025_TABLES_NEW_SAMETABLE SELECT * FROM CRM25_TABLES_NEW WHERE tablename in (select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename) order by tablename
SELECT COUNT(1) FROM CRM2025_TABLES_NEW_SAMETABLE
SELECT COUNT(1) FROM CRM25_TABLES_NEW
SELECT COUNT(1) FROM CRM20_TABLES_NEW

--相同的表，相同的字段的记录

select TABLENAME, COLUMNNAME from CRM2025_TABLES_NEW_SAMETABLE group by tablename,COLUMNNAME
select TABLENAME, COLUMNNAME,COLUMNTYPE from CRM2025_TABLES_NEW_SAMETABLE group by tablename,COLUMNNAME,COLUMNTYPE
select TABLENAME, COLUMNNAME,COLUMNTYPE,COLUMNLENGTH from CRM2025_TABLES_NEW_SAMETABLE group by tablename,COLUMNNAME,COLUMNTYPE,COLUMNLENGTH
select COLUMNNAME from CRM2025_TABLES_NEW_SAMETABLE group by tablename,COLUMNNAME,COLUMNTYPE,COLUMNLENGTH
select TABLENAME from CRM2025_TABLES_NEW_SAMETABLE group by tablename,COLUMNNAME,COLUMNTYPE,COLUMNLENGTH

select * from CRM2025_TABLES_NEW_SAMETABLE where tablename in (select TABLENAME from CRM2025_TABLES_NEW_SAMETABLE group by tablename,COLUMNNAME,COLUMNTYPE,COLUMNLENGTH)
 and COLUMNNAME in (select COLUMNNAME from CRM2025_TABLES_NEW_SAMETABLE group by tablename,COLUMNNAME,COLUMNTYPE,COLUMNLENGTH)




--Get the different 

CREATE TABLE CRM2025_TABLES_NEW
      (
      TABLENAME VARCHAR(50),
      COLUMNORDER VARCHAR(10),
      COLUMNNAME VARCHAR(50),
      COLUMNFLAG VARCHAR(10),
      COLUMNPK   VARCHAR(10),
      COLUMNTYPE VARCHAR(30),
      COLUMNBYTENUM VARCHAR(30),
      COLUMNLENGTH VARCHAR(30),
      COLUMNDECIMAL VARCHAR(10),
      COLUMNNULL VARCHAR(5),
      COLUMNDEFAULT VARCHAR(50),
      DB VARCHAR(20)      
      )
      
DECLARE @TABLENAME VARCHAR(50)

DECLARE TABLE_CUR CURSOR FOR select distinct b.tablename from CRM20_TABLES_NEW a, CRM25_TABLES_NEW b where a.TABLENAME=b.tablename
OPEN TABLE_CUR
FETCH NEXT FROM TABLE_CUR INTO @TABLENAME
	WHILE @@FETCH_STATUS=0
		BEGIN
	        SELECT @PUK1=PUK1,@PUK2=PUK2 FROM CRM_MOBILE_SIMCARDS WHERE ICCID=@ICC
			UPDATE CRM_CUSTOMERS_RESOURCEMB SET PUK=@PUK1+'/'+@PUK2 WHERE ICC=@ICC
     	    FETCH NEXT FROM RESOURCE_CUR INTO @TABLENAME
		END
DEALLOCATE TABLE_CUR

CRM_COIN_CRDB
