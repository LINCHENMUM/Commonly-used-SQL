SELECT customerid, PROMOTIONPLANDETAILID,COUNT(1) FROM crm_customers_promotion WITH(NOLOCK) WHERE 
ACTIVE=1 AND (enddate IS NULL OR enddate >GETDATE())
GROUP BY customerid, PROMOTIONPLANDETAILID
HAVING COUNT(1)>1


SELECT *FROM crm_customers_promotion WITH(NOLOCK) WHERE 
ACTIVE=1 AND (enddate IS NULL OR enddate >GETDATE())
AND CUSTOMERID=1400147436 AND PROMOTIONPLANDETAILID=1400000021
--GROUP BY customerid, PROMOTIONPLANDETAILID
--HAVING COUNT(1)>1
