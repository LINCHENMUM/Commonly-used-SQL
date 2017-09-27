 
    CREATE TABLE sp_lock_records
    (
    FLAG NVARCHAR(100),
    SPID SMALLINT,
    KPID SMALLINT,
    BLOCKED SMALLINT,
    DB_NAME SMALLINT,
    UID SMALLINT,
    LOGINAME VARCHAR(50),
    CPU INT,
    LOGIN_TIME DATETIME,
    OPEN_TRAN SMALLINT,
    STATUS NCHAR(60),
    HOSTNAME NCHAR(256),
    PROGRAM_NAME NCHAR(256),
    HOSTPROCESS NCHAR(20),
    NT_DOMAIN NCHAR(256),
    NET_ADDRESS NCHAR(24),
    SQLSCRIPT NVARCHAR(255),
    DATE DATETIME
    )
    
   

declare @index integer
declare @t_time datetime
set @index = 0
set @t_time =getdate()

while @index < 2880
begin
   waitfor DELAY '000:00:5'

 set @t_time =dateadd(second,5,getdate())
 declare   @kill_lock_spid bit ,             --是否杀掉阻塞的进程,1   杀掉,   0   仅显示   
           @show_spid_if_nolock bit ,   --如果没有阻塞的进程,是否显示正常进程信息,1   显示,0不显示   
           @dbname   sysname                     --如果为空,则查询所有的库,如果为null,则查询当前库,否则查询指定库   
   
 set @kill_lock_spid=0
 set @show_spid_if_nolock =0
 set @dbname=Null
 
   set   nocount   on   
   declare   @count   int,@s   nvarchar(2000),@dbid   int   
   if   @dbname=''   set   @dbid=db_id()   else   set   @dbid=db_id(@dbname)   
     
   select   id=identity(int,1,1),标志,   
    进程ID=spid,线程ID=kpid,块进程ID=blocked,数据库ID=dbid,   
    数据库名=db_name(dbid),用户ID=uid,用户名=loginame,累计CPU时间=cpu,   
    登陆时间=login_time,打开事务数=open_tran,进程状态=status,   
    工作站名=hostname,应用程序名=program_name,工作站进程ID=hostprocess,   
    域名=nt_domain,网卡地址=net_address   
   into   #t   from(   
    select   标志='阻塞的进程',   
    spid,kpid,a.blocked,dbid,uid,loginame,cpu,login_time,open_tran,   
    status,hostname,program_name,hostprocess,nt_domain,net_address,   
    s1=a.spid,s2=0   
    from   master..sysprocesses   a   join   (   
    select   blocked   from   master..sysprocesses     
    where   blocked>0   
    and(@dbid   is   null   or   dbid=@dbid)   
    group   by   blocked   
    )b   on   a.spid=b.blocked     
    where   a.blocked=0   
    and(@dbid   is   null   or   dbid=@dbid)   
    union   all   
    select   '|_牺牲品_>',   
    spid,kpid,blocked,dbid,uid,loginame,cpu,login_time,open_tran,   
    status,hostname,program_name,hostprocess,nt_domain,net_address,   
    s1=blocked,s2=spid   
    from   master..sysprocesses   a     
    where   blocked<>0   
    and(@dbid   is   null   or   dbid=@dbid)   
    )a   order   by   s1,s2   
     
   select   @count=@@rowcount   
     
   if   @count=0   and   @show_spid_if_nolock=1   
   begin   
    insert   #t   
    select   标志='正常的进程',   
    spid,kpid,blocked,dbid,db_name(dbid),uid,loginame,cpu,login_time,   
    open_tran,status,hostname,program_name,hostprocess,nt_domain,net_address   
    from   master..sysprocesses   
    where   @dbid   is   null   or   dbid=@dbid   
    order   by   spid   
    set   @count=@@rowcount   
   end   
     
   if   @count>0   
   begin   
    create   table   #t1(id   int   identity(1,1),a   nvarchar(30),b   Int,EventInfo   nvarchar(255))   
    declare   tb   cursor   local   
    for   
    select   N'insert   #t1   exec(''dbcc   inputbuffer('+rtrim(进程ID)+')'')   
    if   @@rowcount=0   insert   #t1(a)   values(null)   
    '+case   when   @kill_lock_spid=1   and   标志=N'阻塞的进程'   
    then   'kill   '+rtrim(进程ID)   else   ''   end   
    from   #t   
    open   tb   
    fetch   tb   into   @s   
    while   @@fetch_status=0   
    begin   
    exec(@s)   
    fetch   tb   into   @s   
   end   
   close   tb   
   deallocate   tb   
 
--   select   a.*,进程的SQL语句=b.EventInfo  
--   from   #t   a   join   #t1   b   on   a.id=b.id   
--   order   by   a.ID   
 
   insert master.dbo.sp_lock_records
   select   a.*,进程的SQL语句=b.EventInfo ,getdate() 
   from   #t   a   join   #t1   b   on   a.id=b.id   
   order   by   a.ID   
 
   end   
   set   nocount   off   
 
 
 if exists (select * from tempdb.dbo.sysobjects where id = object_id(N'[tempdb].[dbo].[#t]'))
 drop table #t
 if exists (select * from tempdb.dbo.sysobjects where id = object_id(N'[tempdb].[dbo].[#t1]'))
 drop table #t1


-- select 'loop counter = ', @index
 set @index = @index + 1

end


--然后创建一个 SQL View . 主要是转换成中文的标识。

CREATE VIEW dbo.VIEW_sp_lock_records
AS
SELECT DATENAME(yy, 拦截时间) + REPLACE(STR(MONTH(拦截时间), 2), ' ', '0') 
      + REPLACE(STR(DAY(拦截时间), 2), ' ', '0') AS YYYYMMDD, 
      REPLACE(STR(DATENAME([hour], 拦截时间), 2), ' ', '0') 
      + REPLACE(STR(DATENAME([minute], 拦截时间), 2), ' ', '0') AS hhnn, *
FROM dbo.sp_lock_records
WHERE (标志 = '阻塞的进程')

 

--然后使用以下查询语句可以查出阻塞的进程有哪些，

SELECT TOP 100 PERCENT dbo.VIEW_sp_lock_records.YYYYMMDD, dbo.SP_01.T_TIME, 
      dbo.VIEW_sp_lock_records.进程的SQL语句, COUNT(*) AS t_count
FROM dbo.VIEW_sp_lock_records INNER JOIN
      dbo.SP_01 ON dbo.VIEW_sp_lock_records.hhnn >= dbo.SP_01.T_TIME_B AND 
      dbo.VIEW_sp_lock_records.hhnn < dbo.SP_01.T_TIME_E
GROUP BY dbo.SP_01.T_TIME, dbo.VIEW_sp_lock_records.YYYYMMDD, 
      dbo.VIEW_sp_lock_records.进程的SQL语句
HAVING (dbo.VIEW_sp_lock_records.YYYYMMDD >= N'20080810') AND (COUNT(*) >= 5)
ORDER BY dbo.VIEW_sp_lock_records.YYYYMMDD DESC, dbo.SP_01.T_TIME DESC, 
      COUNT(*) DESC 
--其实核心就是将数据自动加入到sp_lock_records 。然后自己查询需要的。
