 --Rollback for the 1470 vouchers from BEN (Expired on 2012-08-31 23:59:59.000)   
  UPDATE crm_dealers_voucher SET STATUS=3,ENDDATE='2012-08-31 23:59:59.000' 
  WHERE  dealerid=380000 and enddate='2013-08-31 23:59:59.000' 
  AND STATUS=1

  GO 