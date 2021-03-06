
/****** Object:  StoredProcedure [dbo].[sp_lock2]    Script Date: 11/03/2010 16:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_lock2] 
@spid1 int = NULL,      /* server process id to check for locks */ 
@spid2 int = NULL       /* other process id to check for locks */ 
as

set nocount on
/*
** Show the locks for both parameters.
*/ 
declare @objid int,
   @dbid int,
   @string Nvarchar(255),
   @sqlspid int,
   @sqlstring varchar(100),
   @BATCHID BIGINT
--Create temp table
create table #t1(id int identity(1,1),a nvarchar(1000),
b Int,EventInfo nvarchar(4000))

--Set the batchID
SELECT @BATCHID=ISNULL(MAX(BATCHID),1000000000)+1 FROM sp_lock_tables WHERE BATCHID LIKE '10%'

if @spid1 is not NULL
begin
   insert #t1 exec('dbcc inputbuffer('+@spid1+')')
   INSERT sp_lock_tables
      (
      spid
      ,loginname
      ,hostname
      ,dbid
      ,dbname
      ,objId
      ,ObjName
      ,IndId
      ,Type
      ,Resource
      ,Mode
      ,Status
      ,SQLscript
      ,datetime
      ,BATCHID
      )
   select convert (smallint, l.req_spid) 
      --,coalesce(substring (user_name(req_spid), 1, 20),'')
      ,coalesce(substring (s.loginame, 1, 20),'')
      ,coalesce(substring (s.hostname, 1, 50),'')
      ,l.rsc_dbid
      ,substring (db_name(l.rsc_dbid), 1, 100)
      ,l.rsc_objid
      ,''
      ,l.rsc_indid
      ,substring (v.name, 1, 4)
      ,substring (l.rsc_text, 1, 16)
      ,substring (u.name, 1, 8)
      ,substring (x.name, 1, 5)
      ,e.EventInfo
      ,GETDATE()
      ,@BATCHID
   from master.dbo.syslockinfo l,
      master.dbo.spt_values v,
      master.dbo.spt_values x,
      master.dbo.spt_values u,
      master.dbo.sysprocesses s,
      #t1 e
   where l.rsc_type = v.number
   and   v.type = 'LR'
   and   l.req_status = x.number
   and   x.type = 'LS'
   and   l.req_mode + 1 = u.number
   and   u.type = 'L'
   and   req_spid in (@spid1, @spid2)
   and   req_spid = s.spid
   and   substring (u.name, 1, 8)<>'S'
end
/*
** No parameters, so show all the locks.
*/ 
else
begin
   INSERT sp_lock_tables
      (
      spid
      ,loginname
      ,hostname
      ,dbid
      ,dbname
      ,objId
      ,ObjName
      ,IndId
      ,Type
      ,Resource
      ,Mode
      ,Status
      ,DATETIME
      ,BATCHID
      )
   select convert (smallint, l.req_spid) 
      --,coalesce(substring (user_name(req_spid), 1, 20),'')
      ,coalesce(substring (s.loginame, 1, 20),'')
      ,coalesce(substring (s.hostname, 1, 50),'')
      ,l.rsc_dbid
      ,substring (db_name(l.rsc_dbid), 1, 100)
      ,l.rsc_objid
      ,''
      ,l.rsc_indid
      ,substring (v.name, 1, 4)
      ,substring (l.rsc_text, 1, 16)
      ,substring (u.name, 1, 8)
      ,substring (x.name, 1, 5)
      ,GETDATE()
      ,@BATCHID
   from master.dbo.syslockinfo l,
      master.dbo.spt_values v,
      master.dbo.spt_values x,
      master.dbo.spt_values u,
      master.dbo.sysprocesses s
   where l.rsc_type = v.number
   and   v.type = 'LR'
   and   l.req_status = x.number
   and   x.type = 'LS'
   and   l.req_mode + 1 = u.number
   and   u.type = 'L'
   and   req_spid = s.spid
   and   substring (u.name, 1, 8)<>'S' 
   order by spID
END
create table #t2(id int identity(1,1),a nvarchar(1000),
b Int,EventInfo nvarchar(4000))

DECLARE lock_cursor CURSOR
FOR SELECT DISTINCT dbid, ObjId,SPID FROM sp_lock_tables WHERE Type ='TAB' AND BATCHID=@BATCHID

OPEN lock_cursor
FETCH NEXT FROM lock_cursor INTO @dbid, @ObjId ,@sqlspid
WHILE @@FETCH_STATUS = 0
   BEGIN
   SELECT @string = 
      'USE ' + db_name(@dbid) + char(13)  
      + 'UPDATE sp_lock_tables SET ObjName =  object_name(' 
      + convert(varchar(32),@objId) + ') WHERE BATCHID='+CONVERT(VARCHAR(50),@BATCHID)+' AND dbid = ' + convert(varchar(32),@dbId) 
      + ' AND objid = ' + convert(varchar(32),@objId) 
   
   EXECUTE (@string) 
   --INSERT SQP script
    SELECT @sqlstring='dbcc inputbuffer('+cast(@sqlspid as varchar)+')'
	DELETE FROM #t1
	insert #t1 exec(@sqlstring)
	UPDATE SP_LOCK_TABLES SET SQLscript=(SELECT EventInfo FROM #t1) WHERE spid=@sqlspid AND BATCHID=@BATCHID
	--UPDATE SP_LOCK_TABLES SET ObjName=object_name(@objId) WHERE  dbid=@dbid  AND objId=@ObjId
   
   FETCH NEXT FROM lock_cursor INTO @dbid, @ObjId,@sqlspid
   END
CLOSE lock_cursor
DEALLOCATE lock_cursor

return (0) 
-- END sp_lock2

--exec sp_lock2

--delete from sp_lock_tables
--select * from sp_lock_tables




