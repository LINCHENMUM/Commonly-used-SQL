create table tb(���� varchar(10) , �γ� varchar(10) , ���� int)
insert into tb values(N'1' , N'A' , 74)
insert into tb values(N'1' , N'B' , 83)
insert into tb values(N'1' , N'C' , 93)
insert into tb values(N'2' , N'A' , 74)
insert into tb values(N'2' , N'B' , 84)
insert into tb values(N'2' , N'C' , 94)
go
DELETE tb
SELECT *fROM  tb WITH(NOLOCK)
SELECT * FROM TB PIVOT(MAX(����) for �γ� in (A,B,C)) B

