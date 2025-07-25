/*
Question : What are the top paying data analyst job ?
    - identify the top 10 highest-paying data analyst role that are available remotely.
    - Focus on job posting with specified salaries (remove nulls)
    - Why? highlight the top-paying opportunities for data analyst, offering insight to employee
*/

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
limit 10;