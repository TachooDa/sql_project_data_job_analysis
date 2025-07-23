/*
Question : what are the most optimal skills to learn (its in high demand and a high paying skills)
- identify skills in high demand and associated with high salaries for data analys roles
- Concentrate on remote position with speceific salaries
- Whiy? target skill tha offer job security (high demand) and financial benefits, (high salaries)
offering strategic insights for carrer development in data analysis
*/

-- CTE's
with skills_demand as (
    select 
        sd.skill_id,
        sd.skills,
        count(sjd.job_id) as demand_count
    from job_postings_fact as jpf
    inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
    inner join skills_dim as sd on sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst' AND
        jpf.salary_year_avg is not null and
        jpf.job_work_from_home = true
    group BY    
        sd.skill_id

), average_salary as (
    select 
        sjd.skill_id,
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
        sjd.skill_id
)
select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary_year_global,
    avg_salary_year_idr
from skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
order by 
    demand_count desc,
    avg_salary_year_global desc;


-- same result query

SELECT
    sd.skill_id,
    sd.skills,
    count(sjd.job_id) as demand_count,
    round(avg(jpf.salary_year_avg),0) as avg_salary_year_global,
    round(avg(jpf.salary_year_avg * 15800),S0) as avg_salary_year_idr

from job_postings_fact as jpf
inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
inner join skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE  
    jpf.job_title_short = 'Data Analyst'
    and jpf.salary_year_avg is not NULL
    and jpf.job_work_from_home = TRUE
group BY
    sd.skill_id
HAVING 
    Count(sjd.job_id) > 10
order BY
    demand_count DESC,
    avg_salary_year_global desc
limit 25;