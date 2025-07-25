/*
Question : What are the top skills base on salary
- look at the average salary for each skill
- focuses on roles with specified salaries, regarldles of location
- why? it reveals how different skills impact salary level for data analyst and helps identify
    the most financially rewarding skills to acquire or improve
*/

select 
    sd.skills,
    round(avg(jpf.salary_year_avg),0)as salary
from job_postings_fact as jpf
inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
inner join skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg is not null AND
    jpf.job_work_from_home = true
group BY    
    sd.skills
order by 
    salary desc
limit 25;

-- top paying skill in IDR (information for indonesia region per year)
select 
    sd.skills,
    round(avg(jpf.salary_year_avg),0)as avg_salary_year_global,
    round(avg(jpf.salary_year_avg * 15800),0)as avg_salary_year_idr -- 15800 nilai tukar rupiah terhadap dollar pada tahun 2023
from job_postings_fact as jpf
inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
inner join skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg is not null and
    jpf.job_work_from_home = true
group BY    
    sd.skills
order by 
   avg_salary_year_global desc
limit 25;