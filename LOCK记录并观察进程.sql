--�������̱��������������Ϣ
USE CRM25_CUSTOMER
CREATE TABLE sp_lock_records
    (
    ID INT,
    FLAG NVARCHAR(100),
    SPID SMALLINT,
    KPID SMALLINT,
    BLOCKED SMALLINT,
    DBID SMALLINT,
    DB_NAME NVARCHAR(50),
    UID SMALLINT,
    LOGINAME VARCHAR(50),
    CPU INT,
    LOGIN_TIME DATETIME,
    OPEN_TRAN SMALLINT,
    STATUS NCHAR(60),
    HOSTNAME NCHAR(256),
    PROGRAM_NAME NCHAR(256),
    --HOSTPROCESS NCHAR(20),
    HOSTPROCESS INT,
    NT_DOMAIN NCHAR(256),
    NET_ADDRESS NCHAR(24),
    SQLSCRIPT NVARCHAR(4000),
    DATE DATETIME
    )
--�����洢���̣������̱���������Ϣ

alter proc USPlockinfo

@kill_lock_spid bit=1,            --�Ƿ�ɱ�������Ľ���,1 ɱ��,0����ʾ
@show_spid_if_nolock bit=1        --���û�������Ľ���,�Ƿ���ʾ����������Ϣ,1 ��ʾ,0����ʾ
as
declare @count int,@s nvarchar(4000),@i int
select id=identity(int,1,1),��־,
����ID=spid,�߳�ID=kpid,�����ID=blocked,���ݿ�ID=dbid,
���ݿ���=db_name(dbid),�û�ID=uid,�û���=loginame,�ۼ�CPUʱ��=cpu,
��½ʱ��=login_time,��������=open_tran, ����״̬=status,
����վ��=hostname,Ӧ�ó�����=program_name,����վ����ID=hostprocess,
����=nt_domain,������ַ=net_address
into #t from(
select ��־='DeadlockProcess',
spid,kpid,a.blocked,dbid,uid,loginame,cpu,login_time,open_tran,
status,hostname,program_name,hostprocess,nt_domain,net_address,
s1=a.spid,s2=0
from master..sysprocesses a join (
select blocked from master..sysprocesses group by blocked
)b on a.spid=b.blocked where a.blocked=0
union all
select 'BeLockedProcess',
spid,kpid,blocked,dbid,uid,loginame,cpu,login_time,open_tran,
status,hostname,program_name,hostprocess,nt_domain,net_address,
s1=blocked,s2=1
from master..sysprocesses a where blocked<>0
)a order by s1,s2

select @count=@@rowcount,@i=1

if @count=0 and @show_spid_if_nolock=1
begin
insert #t
select ��־='NormalProcess',
spid,kpid,blocked,dbid,db_name(dbid),uid,loginame,cpu,login_time,
open_tran,status,hostname,program_name,hostprocess,nt_domain,net_address
from master..sysprocesses
set @count=@@rowcount
end

if @count>0
begin
create table #t1(id int identity(1,1),a nvarchar(1000),
b Int,EventInfo nvarchar(4000))
if @kill_lock_spid=1
begin
declare @spid varchar(100),@��־ varchar(500)
while @i<=@count
begin
select @spid=����ID,@��־=��־ from #t where id=@i
insert #t1 exec('dbcc inputbuffer('+@spid+')')
if @��־='DeadlockProcess' exec('kill '+@spid)
set @i=@i+1
end
end
else
while @i<=@count
begin
select @s='dbcc inputbuffer('+cast(����ID as varchar)+')'
from #t where id=@i
insert #t1 exec(@s)
set @i=@i+1
end
--select a.*,���̵�SQL���=b.EventInfo
--from #t a join #t1 b on a.id=b.id

insert sp_lock_records
   select   a.*,���̵�SQL���=b.EventInfo ,getdate() 
   from   #t   a   join   #t1   b   on   a.id=b.id     
   
end
go

--����Job,���д洢����
exec USPlockinfo --Ĭ��ɱ���������̼���¼��������
exec p_lockinfo '1','1'  --ɱ���������̼���¼��������
exec p_lockinfo '1','0'  --ɱ���������̲���¼��������
exec p_lockinfo '0','0'  --��ɱ���������̲���¼��������
exec USPlockinfo '0','1'  --��ɱ���������̼�¼��������

--��������

--1. �ֱ������SQL�ͻ��ˣ��ֱ�ִ��������䣨192.168.30.202��
use CRM25_CUSTOMERV10
declare @i int
set @i=1
while @i<1000000 
begin 
 update CRM_CUSTOMERS set CONTACT='test provision prov' where CUSTOMERID=1100000005
end

CREATE TABLE Lock1(C1 int default(0));
CREATE TABLE Lock2(C1 int default(0));
INSERT INTO Lock1 VALUES(1);
INSERT INTO Lock2 VALUES(1);

--2. ������һ��SQL�ͻ��ˣ�ִ��������䣬�۲�������

delete from sp_lock_records
exec p_lockinfo --Ĭ��ɱ���������̼���¼��������
--exec p_lockinfo '1','1'  --ɱ���������̼���¼��������
--exec p_lockinfo '1','0'  --ɱ���������̲���¼��������
--exec p_lockinfo '0','0'  --��ɱ���������̲���¼��������
--exec p_lockinfo '0','1'  --��ɱ���������̼�¼��������
select * from sp_lock_records where FLAG='�����Ľ���'
select * from sp_lock_records where FLAG='�����Ľ���'


select COUNT(id),DealerID from SYS_NPM_DEALER where DealerID like '50%' group by DealerID

1
select * from CRM_DEALERS where DEALERID=500036
500037