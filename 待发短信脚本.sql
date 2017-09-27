--select * from crm_sms_history where issent=0 and VIRTUALDELETED=0


with x as (

    select DEALERID, cast(substring(SMSREGULARTIME,0,charindex('-',SMSREGULARTIME,0)) as int) starth,

    cast(substring(SMSREGULARTIME,charindex('-',SMSREGULARTIME,0)+1,2) as int) endh,SMSREGULARTIME from CRM_MVNO_PROPERTIES

)                       

select count(1) from CRM_SMS_HISTORY info left join x 

on info.DEALERID = x.DEALERID  

 where 

 info.VirtualDeleted = 0

and info.IsSent =0

and info.Priority != 3

and (info.Priority != 2

or info.DealerId not in 

(select distinct  MVNOID FROM CRM_LIFECYCLE_HOLIDAY holidayInfo 

WHERE  INTDATE=convert(int,convert(varchar(12), getdate(), 112)) ) )

and (

(info.CategoryId = 2 and info.Value3 in (1011,1012,1019,1050,1057,1058,1059,1006,1009,1010,1015,1017,1020,1036,1037,1038,1039,1060,1061))

or 

 (info.CategoryId != 2 and DATEPART(HOUR,getdate()) between isnull(x.starth,0)  and isnull(endh,24)))

 
