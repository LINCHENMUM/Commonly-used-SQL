select * from sys25_role where dealerid=380000 

update sys25_role set rolename = 'BEN ' + SUBSTRING(RoleName, 9, LEN(rolename) - 8) where dealerid=380000 and rolename like 'Ecof%'