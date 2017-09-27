INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'common', 'common', 1036, 'French - France',
  'French - France', 0, NULL, 'LANGUAGE', GETDATE(), 1, 12001, NULL, NULL, null, 1)
  
  INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'common', 'common', 1025, 'Arabic-Saudi Arabia',
  'Arabic-Saudi Arabia', 0, NULL, 'LANGUAGE', GETDATE(), 1, 12001, NULL, NULL, null, 1)
    INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 1033, 'common', 'common', 1048, 'Romanian-Romanian',
  'Romanian-Romanian', 0, NULL, 'LANGUAGE', GETDATE(), 1, 12001, NULL, NULL, null, 1)
  
  
INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 3082, 'common', 'common', 1036, 'Francés - Francia',
  'French - France', 0, NULL, 'LANGUAGE', GETDATE(), 1, 12001, NULL, NULL, null, 1)
  
  INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 3082, 'common', 'common', 1025, 'Árabe-Arabia Saudí',
  'Arabic-Saudi Arabia', 0, NULL, 'LANGUAGE', GETDATE(), 1, 12001, NULL, NULL, null, 1)
    INSERT INTO SYS_MULTILINGUAL VALUES
((SELECT ISNULL(MAX(ID),1000000000) + 1 FROM SYS_MULTILINGUAL WHERE ID LIKE '100%'),
 -1, 3082, 'common', 'common', 1048, 'Rumano-rumano',
  'Romanian-Romanian', 0, NULL, 'LANGUAGE', GETDATE(), 1, 12001, NULL, NULL, null, 1)
  
  

 insert into SYS_DICTIONARY values (
 (select isnull(MAX(id),1000000000)+1 from SYS_DICTIONARY where ID like '10%'),
 (select MAX(dictionaryid)+1 from SYS_DICTIONARY),
 80631,
 12001,
 'French - France',
 1036,
 0,
 7,
 'French - France',
 null,
 'LANGUAGE',
 14,
 GETDATE(),
 14,
 GETDATE(),
 1
 )
 
 insert into SYS_DICTIONARY values (
 (select isnull(MAX(id),1000000000)+1 from SYS_DICTIONARY where ID like '10%'),
 (select MAX(dictionaryid)+1 from SYS_DICTIONARY),
 80631,
 12001,
 'Arabic-Saudi Arabia',
 1025,
 0,
 8,
 'Arabic-Saudi Arabia',
 null,
 'LANGUAGE',
 14,
 GETDATE(),
 14,
 GETDATE(),
 1
 )
 
 insert into SYS_DICTIONARY values (
 (select isnull(MAX(id),1000000000)+1 from SYS_DICTIONARY where ID like '10%'),
 (select MAX(dictionaryid)+1 from SYS_DICTIONARY),
 80631,
 12001,
 'Romanian-Romanian',
 1048,
 0,
 9,
 'Romanian-Romanian',
 null,
 'LANGUAGE',
 14,
 GETDATE(),
 14,
 GETDATE(),
 1
 )