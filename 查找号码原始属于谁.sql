--查找号码原始属于谁
    
  SELECT COINID FROM CRM_COIN_PROVIDER_MAPPING WHERE PROVIDERID=
  (SELECT PROVIDERID FROM CRM_COIN_OPTA WHERE RANGE1 <= '31633000333' and RANGE2 >= '31633000333') AND
  LEN(LTRIM(RTRIM(COINID)))>0