--1.Create table sp_lock_tables
USE master
CREATE TABLE sp_lock_tables
   (
   spid       smallint
   ,loginname nvarchar(20)
   ,hostname  nvarchar(30)
   ,dbid      int
   ,dbname    nvarchar(50)
   ,objId     int
   ,ObjName   nvarchar(128)
   ,IndId     int
   ,Type      nvarchar(4)
   ,Resource  nvarchar(16)
   ,Mode      nvarchar(8)
   ,Status    nvarchar(5)
   )
   
--2.Create the procedure
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
   @string Nvarchar(255)
   
if @spid1 is not NULL
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
      )
   select convert (smallint, l.req_spid) 
      --,coalesce(substring (user_name(req_spid), 1, 20),'')
      ,coalesce(substring (s.loginame, 1, 20),'')
      ,coalesce(substring (s.hostname, 1, 30),'')
      ,l.rsc_dbid
      ,substring (db_name(l.rsc_dbid), 1, 20)
      ,l.rsc_objid
      ,''
      ,l.rsc_indid
      ,substring (v.name, 1, 4)
      ,substring (l.rsc_text, 1, 16)
      ,substring (u.name, 1, 8)
      ,substring (x.name, 1, 5)
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
   and   req_spid in (@spid1, @spid2)
   and   req_spid = s.spid
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
      )
   select convert (smallint, l.req_spid) 
      --,coalesce(substring (user_name(req_spid), 1, 20),'')
      ,coalesce(substring (s.loginame, 1, 20),'')
      ,coalesce(substring (s.hostname, 1, 30),'')
      ,l.rsc_dbid
      ,substring (db_name(l.rsc_dbid), 1, 20)
      ,l.rsc_objid
      ,''
      ,l.rsc_indid
      ,substring (v.name, 1, 4)
      ,substring (l.rsc_text, 1, 16)
      ,substring (u.name, 1, 8)
      ,substring (x.name, 1, 5)
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
   order by spID
END
DECLARE lock_cursor CURSOR
FOR SELECT dbid, ObjId FROM sp_lock_tables WHERE Type ='TAB'

OPEN lock_cursor
FETCH NEXT FROM lock_cursor INTO @dbid, @ObjId 
WHILE @@FETCH_STATUS = 0
   BEGIN
   SELECT @string = 
      'USE ' + db_name(@dbid) + char(13)  
      + 'UPDATE sp_lock_tables SET ObjName =  object_name(' 
      + convert(varchar(32),@objId) + ') WHERE dbid = ' + convert(varchar(32),@dbId) 
      + ' AND objid = ' + convert(varchar(32),@objId) 
   
   EXECUTE (@string) 
   FETCH NEXT FROM lock_cursor INTO @dbid, @ObjId    
   END
CLOSE lock_cursor
DEALLOCATE lock_cursor

--SELECT * FROM sp_lock_tables
return (0) 

--3. Create a job to run
--EXEC SP_LOCK2