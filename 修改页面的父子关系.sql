--For the 88 and Suri
select * from SYS25_MODULE_MVNO WHERE MVNOID=370000 --AND PARENTID=1000000008
select * from SYS25_MODULE_MVNO WHERE MVNOID=350000 --AND PARENTID=1000000008
select * from SYS25_MODULE_MVNO WHERE MVNOID=330000 --AND PARENTID=1000000008

DELETE FROM SYS25_MODULE_MVNO WHERE MVNOID=370000 AND PARENTID=1000000008
DELETE FROM SYS25_MODULE_MVNO WHERE MVNOID=350000 AND PARENTID=1000000008

UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000011 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000012 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000014 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000015 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000062 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000063 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000066 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000008 WHERE SHOWMODULEID=1000000051 AND MVNOID IN (350000,370000)

UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000004 WHERE SHOWMODULEID=1000000052 AND MVNOID IN (350000,370000)
UPDATE SYS25_MODULE_MVNO SET PARENTID=1000000004 WHERE SHOWMODULEID=1000000053 AND MVNOID IN (350000,370000)


