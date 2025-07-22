-- practice problem 7 on subqueries and CTES
/*
find the count of the number of remote job posting per skill
    - display the top 5 skills by their demand in remote jobs
    - include skill idd, name, and count of postings requiring skills
*/

-- buat perhitungan nya dulu
with remote_job_count as (
select
    skill_id,
    count(*) as skill_count
from skills_job_dim as sjd
inner join job_postings_fact as jpf on jpf.job_id = sjd.job_id
where 
    jpf.job_work_from_home = true and
    jpf.job_title_short = 'Data Engineer'
group by skill_id
)
select 
    sd.skill_id,
    skills as skill_name,
    skill_count
from remote_job_count as rjc
inner join skills_dim as sd on sd.skill_id = rjc.skill_id
order BY  
    skill_count desc limit 5;