--1. crm_sms_history
DECLARE @intervalday INT ;
DECLARE @inc INT ;
SELECT  @intervalday = 7 ;
SELECT  @inc = 10
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  S
        FROM    CRM_SMS_HISTORY S WITH ( NOLOCK )
        WHERE   S.LOGID IN (
                SELECT TOP 1000
                        LOGID
                FROM    CRM_SMS_HISTORY WITH ( NOLOCK )
                WHERE   ISSENT = 1
                        AND DATEDIFF(DAY, CREATEDATE, GETDATE()) > @intervalday ) ;
        SELECT  @inc = @inc - 1 ;
    END ;
    
--2. CRM_MOBILE_PROVISIONINGQUEUE: job exist
--3. CRM_MVNO_TOPUP_HISTORY: job exist but disabled
--4. SYS25_LOG_OPERATION: job exist
--5. CRM_CUSTOMERS_PROMOTION_OPERATION_LOG
DECLARE @intervalday INT ;
DECLARE @inc INT ;
SELECT  @intervalday = 30 ;
SELECT  @inc = 5
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  L
        FROM    CRM_CUSTOMERS_PROMOTION_OPERATION_LOG L WITH ( NOLOCK )
        WHERE   L.LOGID IN (
                SELECT TOP 1000
                        LOGID
                FROM    CRM_CUSTOMERS_PROMOTION_OPERATION_LOG WITH ( NOLOCK )
                WHERE   DATEDIFF(DAY, OPERATIONDATE, GETDATE()) > @intervalday ) ;
        SELECT  @inc = @inc - 1 ;
    END ;
    
--6. CRM_CUSTOMERS_SERVICES: We can clean up the data, but we nee decide one strategy that how long the package history data we should provide for customer.
-- now we only clean up the invalid service.

DECLARE @inc INT ;
SELECT  @inc = 5 ;
SET NOCOUNT ON ;
WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  d
        FROM    dbo.CRM_CUSTOMERS_SERVICES d WITH ( NOLOCK )
        WHERE   d.SERVICEID IN (
                SELECT TOP 1000
                        SERVICEID
                FROM    CRM_CUSTOMERS_SERVICES WITH ( NOLOCK )
                WHERE   NOT EXISTS ( SELECT 1
                                     FROM   crm_customers WITH ( NOLOCK )
                                     WHERE  CUSTOMERID = CRM_CUSTOMERS_SERVICES.CUSTOMERID ) ) ;
        SELECT  @inc = @inc - 1 ;
        
    END ;  

--7. HLR_RequestErrors
DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 6
SELECT  @inc = 10 ;
SET NOCOUNT ON ;
WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  d
        FROM    dbo.HLR_RequestErrors d WITH ( NOLOCK )
        WHERE   d.SEQID IN (
                SELECT DISTINCT TOP 100
                        SEQID
                FROM    HLR_RequestErrors WITH ( NOLOCK )
                WHERE   DATEDIFF(month, CREATETIME, GETDATE()) > @intervalmonth ) ;
        SELECT  @inc = @inc - 1 ;
        
    END ;  
    
--8. MVNO_FC_LIFECYCLE_LOG
DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 1
SELECT  @inc = 5 ;
SET NOCOUNT ON ;

IF EXISTS ( SELECT  1
            FROM    MVNO_FC_LIFECYCLE_LOG b WITH ( NOLOCK )
            WHERE   b.Used = 1
                    AND DATEDIFF(month,
                                 CAST(SUBSTRING(b.TransactionTime, 1, 4) + '-'
                                 + SUBSTRING(b.TransactionTime, 5, 2) + '-'
                                 + SUBSTRING(b.TransactionTime, 7, 2) + ' '
                                 + SUBSTRING(b.TransactionTime, 9, 2) + ':'
                                 + SUBSTRING(b.TransactionTime, 11, 2) + ':'
                                 + SUBSTRING(b.TransactionTime, 13, 2) AS DATETIME),
                                 GETDATE()) > @intervalmonth ) 
    BEGIN
        WHILE ( @inc > 0 ) 
            BEGIN
                DELETE  F
                FROM    MVNO_FC_LIFECYCLE_LOG F WITH ( NOLOCK )
                WHERE   F.Logid IN (
                        SELECT TOP 100
                                Logid
                        FROM    MVNO_FC_LIFECYCLE_LOG a WITH ( NOLOCK )
                        WHERE   a.Used = 1
                                AND DATEDIFF(month,
                                             CAST(SUBSTRING(a.TransactionTime,
                                                            1, 4) + '-'
                                             + SUBSTRING(a.TransactionTime, 5,
                                                         2) + '-'
                                             + SUBSTRING(a.TransactionTime, 7,
                                                         2) + ' '
                                             + SUBSTRING(a.TransactionTime, 9,
                                                         2) + ':'
                                             + SUBSTRING(a.TransactionTime, 11,
                                                         2) + ':'
                                             + SUBSTRING(a.TransactionTime, 13,
                                                         2) AS DATETIME),
                                             GETDATE()) > @intervalmonth )
            END ;

    END 
    
-- 9. CRM_LIFECYCLE_RESOURCE_STATUSCHANGED_LOG
DECLARE @intervalmonth INT ;
DECLARE @ind INT ;
SELECT  @intervalmonth = 1 ;
SELECT  @ind = 5 ;
SET NOCOUNT ON ;
WHILE ( @ind > 0 ) 
    BEGIN
        DELETE  d
        FROM    dbo.CRM_LIFECYCLE_RESOURCE_STATUSCHANGED_LOG d WITH ( NOLOCK )
        WHERE   d.LOGID IN (
                SELECT TOP 4000
                        LOGID
                FROM    CRM_LIFECYCLE_RESOURCE_STATUSCHANGED_LOG WITH ( NOLOCK )
                WHERE   CREATEDATE < DATEADD(month, -@intervalmonth, GETDATE()) ) ;
        SELECT  @ind = @ind - 1 ;
        
    END ;


--10. CRM_CUSTOMERS_RESOURCEMB
DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 1 ;
SELECT  @inc = 5 ;
SET NOCOUNT ON ;
IF EXISTS ( SELECT  1 RESOURCEID
            FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK )
            WHERE   STATUSID = 20
                    AND CHANGESTATUSDATE < DATEADD(month, -@intervalmonth,
                                                   GETDATE()) ) 
    BEGIN

        WHILE ( @inc > 0 ) 
            BEGIN
        
                WITH    x AS ( SELECT TOP 1000
                                        RESOURCEID
                               FROM     CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK )
                               WHERE    STATUSID = 20
                                        AND CHANGESTATUSDATE < DATEADD(month,
                                                              -@intervalmonth,
                                                              GETDATE())
                             )
                    DELETE  g
                    FROM    CRM_RESMB_HUNTING_GROUP_DEST g WITH ( NOLOCK )
                    WHERE   g.GROUPID IN (
                            SELECT  GROUPID
                            FROM    CRM_RESMB_HUNTING_GROUP gg WITH ( NOLOCK ) ,
                                    x
                            WHERE   gg.resourceid = x.resourceid )
        
                DELETE  h
                FROM    CRM_RESMB_HUNTING_GROUP h WITH ( NOLOCK )
                WHERE   h.RESOURCEID IN (
                        SELECT TOP 1000
                                RESOURCEID
                        FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK )
                        WHERE   STATUSID = 20
                                AND CHANGESTATUSDATE < DATEADD(month,
                                                              -@intervalmonth,
                                                              GETDATE()) ) 
            
                DELETE  d
                FROM    CRM_CUSTOMERS_RESOURCEMB d WITH ( NOLOCK )
                WHERE   d.RESOURCEID IN (
                        SELECT TOP 1000
                                RESOURCEID
                        FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK )
                        WHERE   STATUSID = 20
                                AND CHANGESTATUSDATE < DATEADD(month,
                                                              -@intervalmonth,
                                                              GETDATE()) ) 
                SELECT  @inc = @inc - 1 ;
            END ;
    END ;
--11. CRM_MOBILE_CALLFORWARD_HISTORY
DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 1 ;
SELECT  @inc = 10
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  S
        FROM    CRM_MOBILE_CALLFORWARD_HISTORY S WITH ( NOLOCK )
        WHERE   S.Id IN (
                SELECT TOP 1000
                        Id
                FROM    CRM_MOBILE_CALLFORWARD_HISTORY WITH ( NOLOCK )
                WHERE   DATEDIFF(month, CREATEDATE, GETDATE()) > @intervalmonth ) ;
        SELECT  @inc = @inc - 1 ;
    END ;
    
--12. CRM_MOBILE_CALLFORWARD

DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 1 ;
SELECT  @inc = 5
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  S
        FROM    CRM_MOBILE_CALLFORWARD S WITH ( NOLOCK )
        WHERE   S.RESOURCEID IN (
                SELECT TOP 1000
                        RESOURCEID
                FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK )
                WHERE   STATUSID = 20
                        AND CHANGESTATUSDATE < DATEADD(month, -@intervalmonth,
                                                       GETDATE()) ) ;
        DELETE  SS
        FROM    CRM_MOBILE_CALLFORWARD SS WITH ( NOLOCK )
        WHERE   SS.RESOURCEID IN (
                SELECT DISTINCT TOP 100
                        RESOURCEID
                FROM    CRM_MOBILE_CALLFORWARD WITH ( NOLOCK )
                WHERE   RESOURCEID NOT IN (
                        SELECT  RESOURCEID
                        FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK ) ) )
                
        SELECT  @inc = @inc - 1 ;
    END ;

--13. VF_FILE_CDR_COUNT_USETYPE_LEBARA  this table is not used in Live 

--14. CRM_PROMOTION_EVENTSLOG

DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 2 ;
SELECT  @inc = 5
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        
        DELETE  S
        FROM    CRM_PROMOTION_EVENTSLOG S WITH ( NOLOCK )
        WHERE   S.EventId IN (
                SELECT TOP 1000
                        EventId
                FROM    CRM_PROMOTION_EVENTSLOG WITH ( NOLOCK )
                WHERE   CREATEDATE < DATEADD(month, -@intervalmonth, GETDATE()) ) ;
        SELECT  @inc = @inc - 1 ;
    END ;
--15. CRM_MOBILE_NETWORK
DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 1 ;
SELECT  @inc = 5
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  S
        FROM    CRM_MOBILE_NETWORK S WITH ( NOLOCK )
        WHERE   S.RESOURCEID IN (
                SELECT TOP 1000
                        RESOURCEID
                FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK )
                WHERE   STATUSID = 20
                        AND CHANGESTATUSDATE < DATEADD(month, -@intervalmonth,
                                                       GETDATE()) ) ;
        DELETE  SS
        FROM    CRM_MOBILE_NETWORK SS WITH ( NOLOCK )
        WHERE   SS.RESOURCEID IN (
                SELECT DISTINCT TOP 100
                        RESOURCEID
                FROM    CRM_MOBILE_NETWORK WITH ( NOLOCK )
                WHERE   RESOURCEID NOT IN (
                        SELECT  RESOURCEID
                        FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK ) ) )
        SELECT  @inc = @inc - 1 ;
    END ;
--16. CRM_DRE_OPERATION_LOG: CRM supply the form to client to search DRE log, we need decide one strategy that client can search how many month.
--Now we keep one month data
DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 1 ;
SELECT  @inc = 5
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  S
        FROM    CRM_DRE_OPERATION_LOG S WITH ( NOLOCK )
        WHERE   S.OPERATIONID IN (
                SELECT TOP 1000
                        OPERATIONID
                FROM    CRM_DRE_OPERATION_LOG WITH ( NOLOCK )
                WHERE   OPERATIONDATE < DATEADD(month, -@intervalmonth,
                                                GETDATE()) ) ;
        SELECT  @inc = @inc - 1 ;
    END ;

--17. CRM_MOBILE_CAMELUCSI
DECLARE @intervalmonth INT ;
DECLARE @inc INT ;
SELECT  @intervalmonth = 1 ;
SELECT  @inc = 5
SET NOCOUNT ON ;

WHILE ( @inc > 0 ) 
    BEGIN
        DELETE  S
        FROM    CRM_MOBILE_CAMELUCSI S WITH ( NOLOCK )
        WHERE   S.RESOURCEID IN (
                SELECT TOP 1000
                        RESOURCEID
                FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK )
                WHERE   STATUSID = 20
                        AND CHANGESTATUSDATE < DATEADD(month, -@intervalmonth,
                                                       GETDATE()) ) ;
        DELETE  SS
        FROM    CRM_MOBILE_CAMELUCSI SS WITH ( NOLOCK )
        WHERE   SS.RESOURCEID IN (
                SELECT DISTINCT TOP 100
                        RESOURCEID
                FROM    CRM_MOBILE_CAMELUCSI WITH ( NOLOCK )
                WHERE   RESOURCEID NOT IN (
                        SELECT  RESOURCEID
                        FROM    CRM_CUSTOMERS_RESOURCEMB WITH ( NOLOCK ) ) )
        
        SELECT  @inc = @inc - 1 ;
    END ;




 


