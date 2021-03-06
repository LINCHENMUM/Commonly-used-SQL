--对resource检查
select resource from CRM_CUSTOMERS_RESOURCEMB WHERE StatusID <> 20 and resource in 
(SELECT  a.[Resource] FROM SYS_NPM AS a INNER JOIN SYS_NPM_PROPERTY AS b 
on a.Resource = b.Resource where b.StatusID = 8)
 
--对ICC检查
select ICC from CRM_CUSTOMERS_RESOURCEMB WHERE StatusID <> 20 and ICC in(
select ICCID from  CRM_MOBILE_SIMCARDS WHERE Status =8)

--对Resource错误数据清除
--delete   from CRM_CUSTOMERS_RESOURCEMB WHERE StatusID <> 20 and resource in 
--(SELECT  a.[Resource] FROM SYS_NPM AS a INNER JOIN SYS_NPM_PROPERTY AS b 
--on a.Resource = b.Resource where b.StatusID = 8)
 
--对ICC错误数据清除
--delete   from CRM_CUSTOMERS_RESOURCEMB WHERE StatusID <> 20 and ICC in(
--select ICCID from  CRM_MOBILE_SIMCARDS WHERE Status =8)

--SimCard预激活不成功由provision配置导致的问题
 begin
 declare @proNullnum int;
 select @proNullnum =isnull(COUNT(*),0) from CRM_DEALERS_PROPERTIES where DEALERID like '15%' and PROVISIONID is null;
 if (@proNullnum > 0) 
 begin
 -- 这里的provisionid需要根据实际的环境库确定
  update CRM_DEALERS_PROPERTIES set PROVISIONID = 1500000001 where DEALERID like '15%' and PROVISIONID is null;
 end
 else 
  begin
  select * from CRM_DEALERS_PROPERTIES where DEALERID like '15%'
 end
 end