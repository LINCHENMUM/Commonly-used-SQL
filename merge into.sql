���ճ������У�merge into���Sql����Ƿǳ����õġ�����򵥽������£�
merge into bd_defdoc d --Ҫ�޸ĵı�

using (
select l.pk_defdoclist,l.doclistcode from bd_defdoclist l  --����/���ݵı�
) tt
on d.pk_defdoclist = tt.pk_defdoclist --���µ�����
when matched then update set d.doclistcode = tt.doclistcode  --ƥ����������������´���

when not matched then    --��ƥ����������������봦�����ֻ�������£������������ʡ�ԡ�
insert values( tt.pk_defdoclist,tt.����);

 

--�������п��Բ��ö��������磺

ʾ��1��

merge into aa_001 a using (
select s.pk_defdoclist,l.doclistcode,s.pk_defdoc,s.doccode,s.docname from bd_defdoc s
inner join bd_defdoclist l on s.pk_defdoclist=l.pk_defdoclist
) tt
on a.doclistcode = tt.doclistcode and a.doccode=tt.doccode
when matched then update set a.pk_defdoc = tt.pk_defdoc

--��������������������ֶ��������Ҫ�鿴��һ�����ϱ��������ֻ�õ�����һ�����ͬ���ֶΣ����Խ���һ���е�ͬ���ֶ����ε���������Sql�е�ע�Ͳ��֡����磺

ʾ��2��

merge into bd_defdoc d using (
select p.pk_defdoc as p_pk_defdoc,

--p.doclistcode as p_doclistcode,p.doccode as p_doccode,p.docname as p_docname,

s.doclistcode,s.doccode,s.docname ,s.pdoccode
from aa_001 s inner join aa_001 p on s.pdoclistcode=p.doclistcode and s.pdoccode=p.doccode
) tt
on d.doclistcode = tt.doclistcode and d.doccode=tt.doccode
when matched then update set d.pk_defdoc1 = tt.p_pk_defdoc

 

--�����Ҫ�޸ĵı��ϼ������������������﷨��

ʾ��3��

merge into bd_psndoc p using (select pk_om_job,jobseries from  om_job) o on p.pk_om_job=o.pk_om_job
 when matched and p.jobseries<>o.jobseries

 then update set p.jobseries=o.jobseries

ʾ��4��

merge into bd_psndoc p using (select pk_om_job,jobseries from  om_job) o on p.pk_om_job=o.pk_om_job
 when matched and (p.jobseries ='0001B710000000000QYN' or p.jobseries='0001B710000000000QYQ')
 then update set p.jobseries=o.jobseries
