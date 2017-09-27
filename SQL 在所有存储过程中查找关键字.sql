CREATE    PROCEDURE [dbo].[sp_findproc] (@akey varchar(255)) AS

-- 在所有存储过程中查找关键字,关键字不区分大小写
declare @aname as varchar(700)
declare @atext as varchar(8000)
declare @acolid as int
declare @pos as int 
declare @start as int
declare @end as int
declare @shorttext as varchar(255)
create table #temp_proctext (oid int IDENTITY (1, 1),name varchar(700),text varchar(255),pos int)
declare proctext_cursor cursor local  for
select  A.name ,B.text,B.colid from sysobjects A,syscomments B  where A.id=B.id and A.type='P' 
and  B.text like '%'+@akey+'%' order by A.Name,B.colid
open proctext_cursor
FETCH NEXT FROM proctext_cursor INTO @aname, @atext, @acolid
while (@@FETCH_STATUS = 0) 
begin
 set @pos = charindex(@akey,@atext,1)
 while(@pos >0)
 begin 
       set @start = @pos - 10
       if @start <=0 
          set @start =1
       set @end = @pos + len(@akey) +20
       if @end > len(@atext) 
          set @end = len(@atext) 
       set @shorttext = Substring(@atext,@start,@end - @start)
       insert into #temp_proctext values(@aname,@shorttext,(@acolid-1)*4000+@pos)       
       set @pos = charindex(@akey,@atext,@end)   
 end
FETCH NEXT FROM proctext_cursor INTO @aname, @atext, @acolid
end
CLOSE proctext_cursor
DEALLOCATE proctext_cursor
select name,pos,text from #temp_proctext order by oid
drop table #temp_proctext

GO
 

查询：

USE [XXXXX] 
GO

DECLARE @return_value int

EXEC @return_value = [dbo].[sp_findproc]
  @akey = N'key'

SELECT 'Return Value' = @return_value

GO
