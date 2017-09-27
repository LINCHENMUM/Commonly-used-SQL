-- 1 row affected
-- Spend time about 00:00:00 
USE CRM25_CUSTOMER
GO

DELETE
FROM SYS_MULTILINGUAL
WHERE description LIKE '%currency%'
	AND dealerid = - 1
	AND languageid = 1033
	AND showtype = 1
	AND formfullname = 'Common'
	AND TEXT = 'MXN'
