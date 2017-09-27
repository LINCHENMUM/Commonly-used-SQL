select 标志='DeadLockProcess', --死锁进程
spid,kpid,a.blocked,dbid,uid,loginame,cpu,login_time,open_tran,
status,hostname,program_name,hostprocess,nt_domain,net_address,
s1=a.spid,s2=0
from master..sysprocesses a join (
select blocked from master..sysprocesses group by blocked
)b on a.spid=b.blocked where a.blocked=0
union all
select 'BlockedProcess',--被死锁进程阻拦的进程
spid,kpid,blocked,dbid,uid,loginame,cpu,login_time,open_tran,
status,hostname,program_name,hostprocess,nt_domain,net_address,
s1=blocked,s2=1
from master..sysprocesses a where blocked<>0

kill 15
-- exec('kill '+@spid) 


--查看死锁进程对应执行语句的语法

use master
go
declare @spid int,@bl int
DECLARE s_cur CURSOR FOR 
select 0 ,blocked
from (select * from sysprocesses where blocked>0 ) a 
where not exists(select * from (select * from sysprocesses where blocked>0 ) b 
where a.blocked=spid)
union select spid,blocked from sysprocesses where blocked>0
OPEN s_cur
FETCH NEXT FROM s_cur INTO @spid,@bl
WHILE @@FETCH_STATUS = 0
begin
if @spid =0 
            select 'Lead to the dead lock is:'+ CAST(@bl AS VARCHAR(10)) + 'spid,the sql is as below'
else
            select 'SPID：'+ CAST(@spid AS VARCHAR(10))+ 'is blocked by ' + 'SPID：'+ CAST(@bl AS VARCHAR(10)) +',the current execute sql is'
DBCC INPUTBUFFER (@bl )
FETCH NEXT FROM s_cur INTO @spid,@bl
end
CLOSE s_cur
DEALLOCATE s_cur


--查看spid

--exec sp_who2

