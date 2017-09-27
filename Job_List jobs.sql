select category          = jc.name,
       category_id       = jc.category_id,
       job_name          = j.name,
       job_enabled       = j.enabled,
       last_run_time     = cast(js.last_run_date as varchar(10)) + '-' + cast(js.last_run_time as varchar(10)),
       last_run_duration = js.last_run_duration,
       last_run_status   = js.last_run_outcome,
       last_run_msg      = js.last_outcome_message + cast(nullif(js.last_run_outcome,1) as varchar(2)),
       job_created       = j.date_created,
       job_modified      = j.date_modified
  from msdb.dbo.sysjobs j
         inner join msdb.dbo.sysjobservers js
    on j.job_id = js.job_id
         inner join msdb.dbo.syscategories jc
    on j.category_id = jc.category_id
 where --j.enabled = 1
    js.last_run_outcome in (0,1,3,5)      -- 0:Fail 1:Succ 3:Cancel 5:First run
   and jc.category_id not between 10 and 20  -- repl
   AND j.name LIKE 'purge%'
   AND j.date_created>'2012-02-19'