CREATE function Get_StrArrayLength  
(  
@str varchar(1024), --Ҫ�ָ���ַ���  
@split varchar(10) --�ָ�����  
)  
returns int  
as  
begin  
declare @location int  
declare @start int  
declare @length int  

set @str=ltrim(rtrim(@str))  
set @location=charindex(@split,@str)  
set @length=1  
while @location<>0  
begin  
set @start=@location+1  
set @location=charindex(@split,@str,@start)  
set @length=@length+1  
end  
return @length  
end  
����ʾ����select dbo.Get_StrArrayLength('78,1,2,3',',') 
����ֵ��4 

������ָ�����ŷָ��ַ��������طָ��ָ�������ĵڼ���Ԫ�أ�������һ������ 

CREATE function Get_StrArrayStrOfIndex  
(  
@str varchar(1024), --Ҫ�ָ���ַ���  
@split varchar(10), --�ָ�����  
@index int --ȡ�ڼ���Ԫ��  
)  
returns varchar(1024)  
as  
begin  
declare @location int  
declare @start int  
declare @next int  
declare @seed int  

set @str=ltrim(rtrim(@str))  
set @start=1  
set @next=1  
set @seed=len(@split)  

set @location=charindex(@split,@str)  
while @location<>0 and @index>@next  
begin  
set @start=@location+@seed  
set @location=charindex(@split,@str,@start)  
set @next=@next+1  
end  
if @location =0 select @location =len(@str)+1  
--����������������1���ַ��������ڷָ����� 2���ַ����д��ڷָ����ţ�����whileѭ����@locationΪ0����Ĭ��Ϊ�ַ��������һ���ָ����š�  

return substring(@str,@start,@location-@start)  
end  
����ʾ����select dbo.Get_StrArrayStrOfIndex('8,9,4',',',2) 
����ֵ��9 

��������ϱ�����������������һ�������ַ����е�Ԫ�� 

declare @str varchar(50)  
set @str='1,2,3,4,5'  
declare @next int  
set @next=1  
while @next<=dbo.Get_StrArrayLength(@str,',')  
begin  
print dbo.Get_StrArrayStrOfIndex(@str,',',@next)  
set @next=@next+1  
end  
