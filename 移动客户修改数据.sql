


update SYS_NPM_DEALER set DealerID=220000 where Resource='31632191202'
update CRM_MOBILE_SIMCARDS  set DEALERID=220000 where ICCID='893105029090290002'

update CRM_CUSTOMERS set DEALERID=220029 where CUSTOMERID=1300109573
update CRM_CUSTOMERS_MAPPING set FISCALUNITID=220000,RESELLERID=220027,AGENTID=220028,SUBAGENTID=220029 WHERE CUSTOMERID=1300109573
update CRM_CUSTOMERS_RESOURCEMB set operatorcode=220000, PROVISIONID=1300000010 where CUSTOMERID=1300109573
update CRM_CUSTOMERS_PRODUCTS set packageid=1300000050,creditlimit=200,specialcreditlimit=200,exactcreditlimit=2000 where productid=1300110071 and customerid=1300109573

update CRM_CUSTOMERS_SERVICES set bundleid=1400000083,creditlimit=200 where serviceid=1300330475
update CRM_CUSTOMERS_SERVICES set bundleid=1300000087,creditlimit=200 where serviceid=1300330476
insert into CRM_CUSTOMERS_SERVICES(
serviceid,CUSTOMERID,BUNDLEID,CREDITLIMIT,UNBILLEDBALANCE,BILLEDBALANCE,INVOICETEMPLATEID,
STARTDATE,ENDDATE,CREATEDATE,USERID,PRODUCTID,DEPOSITAMOUNT
) values (
(select isnull(max(serviceid),1000000000)+1 from CRM_CUSTOMERS_SERVICES where serviceid like '10%'),
1300109573,1400000081,100,0,0,1,'2010-11-30 05:07:19.000',null,'2010-11-30 05:07:56.000',
14,1300110071,null
)





