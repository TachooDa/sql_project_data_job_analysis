SELECT
    company_id,
    name as company_name
from 
    company_dim
WHERE company_id in (
SELECT  
    company_id
from job_postings_fact
where
    job_no_degree_mention = true
    order by company_id
)

-- cte
with company_job_count as (
select  
    company_id,
    count(*) as total_jobs
from job_postings_fact
group by company_id
)
select 
    company_dim.name as company_name,
    company_job_count.total_jobs

from company_dim
left join company_job_count on company_job_count.company_id = company_dim.company_id
order by total_jobs desc;

-- practis subqueries 1
select
    sd.skill_id,
    sd.skills as skill_name,
    top_skill.skill_count
from (
select 
    skill_id,
    count(*) as skill_count 
from skills_job_dim
group by skill_id
order by skill_count  desc 
limit 5
) as top_skill
join skills_dim as sd on sd.skill_id = top_skill.skill_id
order by top_skill.skill_count desc;

-- practice 2
select
    cd.company_id,
    cd.name as company_name,
    job_count.total_job_posting,
    case
        when job_count.total_job_posting < 10 then 'small'
        when job_count.total_job_posting between 10 and 50 then 'medium'
        when job_count.total_job_posting > 50 then 'large'
    end as job_size_category
from (
select 
    company_id,
    count(*) as total_job_posting
from
    job_postings_fact
WHERE 
    company_id is not null 
group by 
    company_id 

) as job_count 
join company_dim as cd on cd.company_id = job_count.company_id;

-- practice problem 7 on subqueries and CTES
/*
find the count of the number of remote job posting per skill
    - display the top 5 skills by their demand in remote jobs
    - include skill idd, name, and count of postings requiring skills
*/

-- buat perhitungan nya duly
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