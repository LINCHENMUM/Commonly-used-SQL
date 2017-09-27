--创建进程表，用来保存进程信息
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
--创建存储过程，往进程表插入进程信息

alter proc USPlockinfo

@kill_lock_spid bit=1,            --是否杀掉死锁的进程,1 杀掉,0仅显示
@show_spid_if_nolock bit=1        --如果没有死锁的进程,是否显示正常进程信息,1 显示,0不显示
as
declare @count int,@s nvarchar(4000),@i int
select id=identity(int,1,1),标志,
进程ID=spid,线程ID=kpid,块进程ID=blocked,数据库ID=dbid,
数据库名=db_name(dbid),用户ID=uid,用户名=loginame,累计CPU时间=cpu,
登陆时间=login_time,打开事务数=open_tran, 进程状态=status,
工作站名=hostname,应用程序名=program_name,工作站进程ID=hostprocess,
域名=nt_domain,网卡地址=net_address
into #t from(
select 标志='DeadlockProcess',
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
select 标志='NormalProcess',
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
declare @spid varchar(100),@标志 varchar(500)
while @i<=@count
begin
select @spid=进程ID,@标志=标志 from #t where id=@i
insert #t1 exec('dbcc inputbuffer('+@spid+')')
if @标志='DeadlockProcess' exec('kill '+@spid)
set @i=@i+1
end
end
else
while @i<=@count
begin
select @s='dbcc inputbuffer('+cast(进程ID as varchar)+')'
from #t where id=@i
insert #t1 exec(@s)
set @i=@i+1
end
--select a.*,进程的SQL语句=b.EventInfo
--from #t a join #t1 b on a.id=b.id

insert sp_lock_records
   select   a.*,进程的SQL语句=b.EventInfo ,getdate() 
   from   #t   a   join   #t1   b   on   a.id=b.id     
   
end
go

--创建Job,运行存储过程
exec USPlockinfo --默认杀死死锁进程及记录正常进程
exec p_lockinfo '1','1'  --杀死死锁进程及记录正常进程
exec p_lockinfo '1','0'  --杀死死锁进程不记录正常进程
exec p_lockinfo '0','0'  --不杀死死锁进程不记录正常进程
exec USPlockinfo '0','1'  --不杀死死锁进程记录正常进程

--测试例子

--1. 分别打开两个SQL客户端，分别执行以下语句（192.168.30.202）
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

--2. 打开另外一个SQL客户端，执行以下语句，观察进程情况

delete from sp_lock_records
exec p_lockinfo --默认杀死死锁进程及记录正常进程
--exec p_lockinfo '1','1'  --杀死死锁进程及记录正常进程
--exec p_lockinfo '1','0'  --杀死死锁进程不记录正常进程
--exec p_lockinfo '0','0'  --不杀死死锁进程不记录正常进程
--exec p_lockinfo '0','1'  --不杀死死锁进程记录正常进程
select * from sp_lock_records where FLAG='死锁的进程'
select * from sp_lock_records where FLAG='正常的进程'


select COUNT(id),DealerID from SYS_NPM_DEALER where DealerID like '50%' group by DealerID

1
select * from CRM_DEALERS where DEALERID=500036
500037