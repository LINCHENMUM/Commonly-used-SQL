
DELETE SYS_CRM25_DATABASE_COLUMNS_SAM
DECLARE @TABLENAME VARCHAR(100)
DECLARE @SQL VARCHAR(1000)

  
DECLARE CURSOR_TABLENAME CURSOR FOR
	  SELECT NAME   FROM   SYSOBJECTS   WHERE   XTYPE='U'  
	

OPEN CURSOR_TABLENAME
FETCH CURSOR_TABLENAME INTO @TABLENAME
WHILE (@@FETCH_STATUS = 0)
BEGIN
	SET @SQL ='INSERT INTO SYS_CRM25_DATABASE_COLUMNS_SAM (TABLENAME,COLUMNNAME) '
	SET @SQL = @SQL + N' SELECT   ' + '''' + @TABLENAME + ''', A.NAME AS COLUMNNAME   FROM   SYSCOLUMNS A,SYSOBJECTS B'
	SET @SQL = @SQL + N' WHERE   A.ID=B.ID'
	SET @SQL = @SQL + N' AND B.NAME = ' + '''' + @TABLENAME + ''''
	
	--PRINT @SQL
	EXECUTE(@SQL)

	FETCH CURSOR_TABLENAME INTO @TABLENAME	
END
CLOSE CURSOR_TABLENAME
DEALLOCATE CURSOR_TABLENAME
