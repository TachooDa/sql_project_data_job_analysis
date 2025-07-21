CREATE table january_jobs as
select * 
from 
    job_postings_fact
where EXTRACT(month from job_posted_date) = 1;

CREATE table february_jobs as
select * 
from 
    job_postings_fact
where EXTRACT(month from job_posted_date) = 2;

CREATE table march_jobs as
select * 
from 
    job_postings_fact
where EXTRACT(month from job_posted_date) = 3;

select job_posted_date
from january_jobs;

