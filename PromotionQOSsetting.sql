	
		DECLARE @MVNOID INT
		DEClARE @CATEGORYID INT
		DECLARE @CATEGORYNAME VARCHAR(30)
		SET @MVNOID=150000
		SET @CATEGORYID=11000
		SET @CATEGORYNAME='CustomerQOSsetting'
		--Daily 
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSMAXBITRATEDOWN_LOW','',1000,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSMAXBITRATEUP_LOW','',100,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSMAXBITRATEDOWN_NORMAL','',3600,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSMAXBITRATEUP_NORMAL','',384,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		--Daily GUARANTEED
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSGUARANTEEDBITRATEDOWN_LOW','',1000,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSGUARANTEEDBITRATEUP_LOW','',100,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSGUARANTEEDBITRATEDOWN_NORMAL','',3600,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'DAILYQOSGUARANTEEDBITRATEUP_NORMAL','',384,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		--Monthly 
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSMAXBITRATEDOWN_LOW','',1000,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSMAXBITRATEUP_LOW','',100,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSMAXBITRATEDOWN_NORMAL','',3600,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSMAXBITRATEUP_NORMAL','',384,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		--Monthly GUARANTEED
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSGUARANTEEDBITRATEDOWN_LOW','',1000,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSGUARANTEEDBITRATEUP_LOW','',100,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSGUARANTEEDBITRATEDOWN_NORMAL','',3600,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		insert into crm_mvno_configaction values(
		(select ISNULL(MAX(ID),1000000000)+1 FROM crm_mvno_configaction WHERE ID LIKE '10000%'),
		@MVNOID,@CATEGORYID,@CATEGORYNAME,'MONTHLYQOSGUARANTEEDBITRATEUP_NORMAL','',384,'Set the QOS value for customer',1,GETDATE(),null,GETDATE(),null,null,null,null,null
		)
		
		
