--set disabled the dictionary
update SYS_DICTIONARY set STATEID=0 where DICTIONARYTYPE=25201 and DICTIONARYTEXT=''
--set enabled the dictionary
update SYS_DICTIONARY set STATEID=1 where DICTIONARYTYPE=25201 and DICTIONARYTEXT=''