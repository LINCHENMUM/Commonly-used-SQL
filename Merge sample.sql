create table test1 (
ID INT,
NAME VARCHAR(10)
)

insert into test1 values (1, 'a')
insert into test1 values(2, 'b')
insert into test1 values(3, 'c')
insert into test1 values(4, 'd')
insert into test1 values(5, 'e')
insert into test1 values(8, 'ii')

CREATE TABLE TEST2(
ID INT,
NAME VARCHAR(10),
)

insert into test2 values(1, 'aa')
insert into test2 values(2, 'bb')
insert into test2 values(3, 'cc')
insert into test2 values(4, 'dd')
insert into test2 values(5, 'ee')
insert into test2 values(6, 'ff')
insert into test2 values(7, 'hh')


--drop table test1
--drop table test2
--1
Merge into test1 t1
using (
select ID, NAME FROM TEST2
) T2
ON T1.ID =T2.ID
WHEN MATCHED THEN 
UPDATE SET T1.NAME=T2.NAME 
WHEN NOT MATCHED BY SOURCE THEN 
--INSERT VALUES( T2.ID, T2.NAME);
DELETE;

SELECT * FROM test1

SELECT * FROM TEST2


UPDATE test1 SET NAME='' 
--2
Merge into test1 t1
using (
select ID, NAME FROM TEST2
) T2
ON T1.ID =T2.ID
WHEN MATCHED AND T1.ID=1 THEN 
UPDATE SET T1.NAME=T2.NAME 
WHEN NOT MATCHED THEN 
INSERT VALUES( T2.ID, T2.NAME);

SELECT * FROM test1

SELECT * FROM TEST2


--递归

WITH bd_corp2 (fathercorp, pk_corp, unitname, unitcode, Level)
AS
(
-- Anchor member definition，最顶级，我们用0级来表示
    SELECT e.fathercorp, e.pk_corp, e.unitname, e.unitcode,
        0 AS Level
    FROM bd_corp AS e
    where e.fathercorp is NULL --and pk_corp='1048'

    UNION ALL
-- Recursive member definition，其他各级，我们用1，2，3……级来表示
    SELECT e.fathercorp, e.pk_corp, e.unitname, e.unitcode,
        Level + 1
    FROM bd_corp AS e
    INNER JOIN bd_corp2 AS d
        ON e.fathercorp = d.pk_corp
)

SELECT * FROM CRM_DEALERS;

WITH CRM_DEALERS_ID (DEALERID, PARENTID, DEALERNODE,DEALERTYPEID,LEVEL)
AS
(
select D1.DEALERID,D1.PARENTID,D1.DEALERNODE,D1.DEALERTYPEID,
0 AS LEVEL 
from CRM_DEALERS AS D1 
WHERE D1.DEALERID=150000
UNION ALL
SELECT D1.DEALERID,D1.PARENTID,D1.DEALERNODE,D1.DEALERTYPEID,
LEVEL +1 
FROM CRM_DEALERS AS D1
INNER JOIN CRM_DEALERS_ID AS D2 
ON D1.PARENTID=D2.DEALERID

)


WITH CRM_DEALERS_ID (DEALERID, PARENTID, DEALERNODE,DEALERTYPEID)
AS
(
select D1.DEALERID,D1.PARENTID,D1.DEALERNODE,D1.DEALERTYPEID
from CRM_DEALERS AS D1 
WHERE D1.DEALERID=150000
UNION ALL
SELECT D1.DEALERID,D1.PARENTID,D1.DEALERNODE,D1.DEALERTYPEID
FROM CRM_DEALERS AS D1
INNER JOIN CRM_DEALERS_ID AS D2 
ON D1.PARENTID=D2.DEALERID

)

SELECT * FROM CRM_DEALERS_ID