DECLARE @d DATETIME
SET @d=GETDATE()
SELECT [语句执行花费时间(毫秒)]=datediff(ms,@d,getdate())