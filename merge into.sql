在日常操作中，merge into这个Sql语句是非常好用的。下面简单介绍如下：
merge into bd_defdoc d --要修改的表

using (
select l.pk_defdoclist,l.doclistcode from bd_defdoclist l  --关联/依据的表
) tt
on d.pk_defdoclist = tt.pk_defdoclist --更新的条件
when matched then update set d.doclistcode = tt.doclistcode  --匹配关联条件，作更新处理

when not matched then    --不匹配关联条件，作插入处理。如果只是作更新，下面的语句可以省略。
insert values( tt.pk_defdoclist,tt.……);

 

--关联表中可以采用多表关联，如：

示例1：

merge into aa_001 a using (
select s.pk_defdoclist,l.doclistcode,s.pk_defdoc,s.doccode,s.docname from bd_defdoc s
inner join bd_defdoclist l on s.pk_defdoclist=l.pk_defdoclist
) tt
on a.doclistcode = tt.doclistcode and a.doccode=tt.doccode
when matched then update set a.pk_defdoc = tt.pk_defdoc

--关联表中如果有重名的字段名，如果要查看，一定加上表名。如果只用到其中一个表的同名字段，可以将另一表中的同名字段屏蔽掉，见以下Sql中的注释部分。例如：

示例2：

merge into bd_defdoc d using (
select p.pk_defdoc as p_pk_defdoc,

--p.doclistcode as p_doclistcode,p.doccode as p_doccode,p.docname as p_docname,

s.doclistcode,s.doccode,s.docname ,s.pdoccode
from aa_001 s inner join aa_001 p on s.pdoclistcode=p.doclistcode and s.pdoccode=p.doccode
) tt
on d.doclistcode = tt.doclistcode and d.doccode=tt.doccode
when matched then update set d.pk_defdoc1 = tt.p_pk_defdoc

 

--如果在要修改的表上加条件，可以用如下语法：

示例3：

merge into bd_psndoc p using (select pk_om_job,jobseries from  om_job) o on p.pk_om_job=o.pk_om_job
 when matched and p.jobseries<>o.jobseries

 then update set p.jobseries=o.jobseries

示例4：

merge into bd_psndoc p using (select pk_om_job,jobseries from  om_job) o on p.pk_om_job=o.pk_om_job
 when matched and (p.jobseries ='0001B710000000000QYN' or p.jobseries='0001B710000000000QYQ')
 then update set p.jobseries=o.jobseries
