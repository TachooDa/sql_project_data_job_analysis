/*
Quetsion : what skills are required for the top paying data analyst job?
    - Use the top 10 highest paying data analyst jobs from first query
    - add the specifics skills required for these roles
    - why? it provide a detailed look at which high-paying jobs demand certain skills
    helping job seekers understand which skills to develop that align with top salaries
*/

-- ww work with CTE's
with top_paying_jobs as (
    SELECT 
        jpf.job_id,
        jpf.job_title,
        jpf.job_location,
        jpf.job_schedule_type,
        round(jpf.salary_year_avg,0) as salary,
        jpf.job_posted_date,
        cd.name as company_name
    from job_postings_fact as jpf
    left join company_dim as cd on jpf.company_id = cd.company_id
    where jpf.job_title_short = 'Data Analyst' AND
        round(jpf.salary_year_avg,0) is not null AND
        jpf.job_location = 'Anywhere'
    order BY    
        salary desc
    limit 10
)
select 
    tpj.*,
    sd.skills
from top_paying_jobs as tpj
inner join skills_job_dim as sjd on tpj.job_id = sjd.job_id
inner join skills_dim as sd on sjd.skill_id = sd.skill_id
order BY
    salary desc;
    