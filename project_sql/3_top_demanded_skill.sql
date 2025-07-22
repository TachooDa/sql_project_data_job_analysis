/*
Question: What are the most in-demand skills for data analyts?
- join job postings to inner join table similar to query 2
- identify the top 5 skills for a data analyst.
- focus on all job postings,
- why? retrieves the top 5 skills with the highest demand in the job market.
    providing insights into the most valuable skills for job seekers
*/


select 
    skills,
    count(sjd.job_id) as demand_count
from job_postings_fact as jpf
inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
inner join skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = true
group BY    
    skills
order by 
    demand_count desc
limit 5