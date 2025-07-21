select
    job_id,
    job_title,
    job_posted_date:: date as job_date -- date looks like
from 
    job_postings_fact
limit 5;

select
    job_id,
    job_title,
    job_posted_date at time zone 'UTC' AT TIME ZONE 'EST' as job_date -- at time zone looks like
from 
    job_postings_fact
limit 5;

select
    count(job_id) as job_count_id,
    EXTRACT(month from job_posted_date) as month -- extract month looks like
   -- EXTRACT(year from job_posted_date) as year -- extract year looks like
from 
    job_postings_fact
where 
    job_title_short = 'Data Analyst'
group by 
    month
order by 
    job_count_id desc;

-- Practice Problem 1
select 
    job_schedule_type,
    job_posted_date::date as job_date,
    round(avg(salary_year_avg),0) as avg_year_salary,
    round(avg(salary_hour_avg),0) as avg_hour_salary
from job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
group by
    job_schedule_type,job_posted_date;


-- case - when sintaks
SELECT 
        count(job_id) as job_count,
        CASE
            when job_location = 'Anywhere' then 'Remote'
            when job_location = 'New York, NY' then 'Local'
            else 'onsite'
        END as location_category
from job_postings_fact
WHERE   
    job_title_short = 'Data Analyst'
group by location_category;

-- practice case-when problem
SELECT  
    job_title_short,
    round(salary_year_avg,0) as avg_salary,
    case
        when round(salary_year_avg,0) > 100000 then 'High Salary'
        when round(salary_year_avg,0) between 30000 and 100000 then 'Medium Salary'
        when round(salary_year_avg,0) < 30000 then 'Low Salary'
    END as salary_range
from job_postings_fact
where 
    job_title_short = 'Data Analyst' AND
    salary_year_avg is not null
order by avg_salary desc;