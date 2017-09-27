 
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
 declare   @kill_lock_spid bit ,             --�Ƿ�ɱ�������Ľ���,1   ɱ��,   0   ����ʾ   
           @show_spid_if_nolock bit ,   --���û�������Ľ���,�Ƿ���ʾ����������Ϣ,1   ��ʾ,0����ʾ   
           @dbname   sysname                     --���Ϊ��,���ѯ���еĿ�,���Ϊnull,���ѯ��ǰ��,�����ѯָ����   
   
 set @kill_lock_spid=0
 set @show_spid_if_nolock =0
 set @dbname=Null
 
   set   nocount   on   
   declare   @count   int,@s   nvarchar(2000),@dbid   int   
   if   @dbname=''   set   @dbid=db_id()   else   set   @dbid=db_id(@dbname)   
     
   select   id=identity(int,1,1),��־,   
    ����ID=spid,�߳�ID=kpid,�����ID=blocked,���ݿ�ID=dbid,   
    ���ݿ���=db_name(dbid),�û�ID=uid,�û���=loginame,�ۼ�CPUʱ��=cpu,   
    ��½ʱ��=login_time,��������=open_tran,����״̬=status,   
    ����վ��=hostname,Ӧ�ó�����=program_name,����վ����ID=hostprocess,   
    ����=nt_domain,������ַ=net_address   
   into   #t   from(   
    select   ��־='�����Ľ���',   
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
    select   '|_����Ʒ_>',   
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
    select   ��־='�����Ľ���',   
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
    select   N'insert   #t1   exec(''dbcc   inputbuffer('+rtrim(����ID)+')'')   
    if   @@rowcount=0   insert   #t1(a)   values(null)   
    '+case   when   @kill_lock_spid=1   and   ��־=N'�����Ľ���'   
    then   'kill   '+rtrim(����ID)   else   ''   end   
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
 
--   select   a.*,���̵�SQL���=b.EventInfo  
--   from   #t   a   join   #t1   b   on   a.id=b.id   
--   order   by   a.ID   
 
   insert master.dbo.sp_lock_records
   select   a.*,���̵�SQL���=b.EventInfo ,getdate() 
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


--Ȼ�󴴽�һ�� SQL View . ��Ҫ��ת�������ĵı�ʶ��

CREATE VIEW dbo.VIEW_sp_lock_records
AS
SELECT DATENAME(yy, ����ʱ��) + REPLACE(STR(MONTH(����ʱ��), 2), ' ', '0') 
      + REPLACE(STR(DAY(����ʱ��), 2), ' ', '0') AS YYYYMMDD, 
      REPLACE(STR(DATENAME([hour], ����ʱ��), 2), ' ', '0') 
      + REPLACE(STR(DATENAME([minute], ����ʱ��), 2), ' ', '0') AS hhnn, *
FROM dbo.sp_lock_records
WHERE (��־ = '�����Ľ���')

 

--Ȼ��ʹ�����²�ѯ�����Բ�������Ľ�������Щ��

SELECT TOP 100 PERCENT dbo.VIEW_sp_lock_records.YYYYMMDD, dbo.SP_01.T_TIME, 
      dbo.VIEW_sp_lock_records.���̵�SQL���, COUNT(*) AS t_count
FROM dbo.VIEW_sp_lock_records INNER JOIN
      dbo.SP_01 ON dbo.VIEW_sp_lock_records.hhnn >= dbo.SP_01.T_TIME_B AND 
      dbo.VIEW_sp_lock_records.hhnn < dbo.SP_01.T_TIME_E
GROUP BY dbo.SP_01.T_TIME, dbo.VIEW_sp_lock_records.YYYYMMDD, 
      dbo.VIEW_sp_lock_records.���̵�SQL���
HAVING (dbo.VIEW_sp_lock_records.YYYYMMDD >= N'20080810') AND (COUNT(*) >= 5)
ORDER BY dbo.VIEW_sp_lock_records.YYYYMMDD DESC, dbo.SP_01.T_TIME DESC, 
      COUNT(*) DESC 
--��ʵ���ľ��ǽ������Զ����뵽sp_lock_records ��Ȼ���Լ���ѯ��Ҫ�ġ�
