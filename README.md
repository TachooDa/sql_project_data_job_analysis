# Introduction

📊 Dive into the data job market! Focusing on data analyst role, this project explores 💰 top-paying jobs, 🔥In-demand skills, and 📊 where high demand meets hight salary in data analytics

# SQL queries? Check them out here : [Projek](/project_sql/roject_sql)

# Background

Didorong oleh keinginan untuk memahami pasar kerja data analyst dengan lebih baik, proyek ini bertujuan untuk mengidentifikasi skill yang paling dibayar tinggi dan paling banyak dibutuhkan, sehingga memudahkan orang lain dalam mencari skill paling optimal untuk pekerjaan.

Data berasal dari [SQL Course](https://lukebarousse.com/sql). yang saya ikuti. Data ini penuh dengan insight seputar job title, gaji, lokasi, dan skill yang dibutuhkan

### The question i wanted to answer to answer through any SQL queries were :

1. What are the top paying data analyst job ?.
2. what skills are required for the top paying data analyst job ?.
3. What are the most in-demand skills for data analyts?.
4. What are the top skills base on salary.
5. what are the most optimal skills to learn (its in high demand and a high paying skills).

# Tools I used

For my deep dive into the data analyst job market, I harnessed the power of several key tools :

- **SQL:** The Backbone of my analysis, allowing me to query the database and unearch critikal insights.
- **PostgreSQL:** The chosen database managemen system, ideal for handling the job posting data.
- **Visual Studio Coda:** My go-to for database management and executing SQL queries.
- **Git&Github:** Essential for version control and sharing my Sql scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each Question:

### 1. Top Paying Data Analyst Jobs

Untuk mengetahui posisi dengan gaji tertinggi, saya memfilter posisi data analyst berdasarkan rata-rata gaji tahunan dan lokasi, dengan fokus pada pekerjaan remote. Query ini menyoroti peluang dengan bayaran tinggi di bidang ini.

```sql
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
```

Here's the breakdown of the top paying jobs data analyst in 2023:

- **Wide Salary Range:** 10 besar posisi data analyst dengan gaji tertinggi berkisar antara $184.000 hingga $650.000, menunjukkan potensi pendapatan yang besar.
- **Diverse Employers:** Perusahaan seperti SmartAsset, Meta, dan AT&T termasuk yang menawarkan gaji tinggi, mencerminkan ketertarikan luas dari berbagai industri.
- **Job title Variety:** Terdapat variasi besar pada job title, mulai dari data analyst hingga director of analytics, menunjukkan peran dan spesialisasi yang berbeda dalam bidang data analytics.

  ![Top Paying Roles](assets\1_top_paying_job.png)
  _Bar graph visualizing the salary for the top 10 salaries for data analyst_
  ![Salary trend overtime](assets\1_salary_trend.png)
  _Line graph/chart visualizing the salary trend over time of the top 10 salaries for data analyst jobs/role_

### 2. Skill for top Paying jobs

Untuk memahami skill apa saja yang dibutuhkan oleh pekerjaan dengan bayaran tertinggi, saya menggabungkan data posting pekerjaan dengan data skill, sehingga memberikan wawasan mengenai skill apa yang dinilai penting oleh perusahaan.

```sql
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
```

Here's the breakdown of the most in-demand skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL** menempati posisi teratas dengan jumlah kemunculan 8 kali.
- **Python** menyusul dengan 7 kali kemunculan.
- **Tableu** juga banyak dicari, muncul sebanyak 6 kali. Skill lain seperti _R_, _Snowflake_, dan _Excel_ juga menunjukkan tingkat permintaan yang beragam.

![Skill for Top/Highest Paying Roles](assets\2_top_in-demand_jobs.png)

### 3. In Demanded Skills For Data Analyst

Saya ingin mengetahui 5 skill teratas yang paling banyak dibutuhkan dalam peran data analyst. Maka saya menggabungkan tabel posting pekerjaan dengan data skill untuk melihat skill yang paling dicari khususnya dalam pekerjaan remote.
[Query for top demanded skills](project_sql\3_top_demanded_skills.sql)

Here's the breakdown of the top demanded skills for the top 5 demanded skills data analyst jobs in 2023 (remote only):

- SQL memimpin dengan 7.291 lowongan kerja (15,50%), menegaskan perannya sebagai skill paling penting bagi Data Analyst, diikuti oleh Excel (4.611) dan Python (4.330) yang masih sangat dihargai untuk data manipulation dan automation.
- Tableau (3.745) dan Power BI (2.609) melengkapi lima besar, mencerminkan tingginya permintaan akan kemampuan visualisasi data dan alat business intelligence dalam pekerjaan analis data (remote jobs).
  ![top demanded skill remote jobs only](assets\3_top_Demand_skills.png)
  _This chart show the top 5 In demanded skills for data analyst_

### 4. Skill Based on Salary

Untuk menemukan skill dengan bayaran tertinggi bagi peran Data Analyst, saya memfilter lowongan kerja remote dengan data gaji yang valid. Kemudian saya kelompokkan berdasarkan skill dan urutkan berdasarkan rata-rata gaji tahunan.
This bar chart shows which skills are linked to the highest average salaries for remote Data Analyst jobs in 2023.

- **PySpark** merupakan skill dengan bayaran tertinggi, dengan rata-rata gaji tahunan lebih dari $200.000.
- Skill lain yang juga dibayar tinggi meliputi _Bitbucket_, _Couchbase_, _Watson_, dan _Datarobot_, masing-masing dengan gaji di atas $170.000.
- Alat-alat terkait _data engineering_, _cloud platform_, dan machine learning (seperti _Databricks_, _Kubernetes_, _Airflow_, _GCP_, dll.) juga masuk dalam daftar teratas.
- Bahkan alat inti seperti _Pandas_, _Numpy_, dan _Jupyter_ masuk dalam 25 besar, menunjukkan nilai pasar mereka yang tinggi.
  ![top paying skills](assets\4_top_paying_skills.png)

### 5. Most Optimal Skills to learn

Untuk mengidentifikasi skill paling optimal bagi peran Data Analyst, saya menganalisis lowongan kerja remote dengan data gaji tahunan yang valid. Job Postings dikelompokkan berdasarkan skill, lalu dihitung dan diurutkan berdasarkan gaji rata-rata tahunan.

This chart shows the top 15 optimal skills with for remote Data Analyst roles in 2023. The insights below highlight key patterns in the results:

- SQL, Excel, dan Python berada di urutan teratas — mengonfirmasi bahwa skill dasar ini tetap krusial di pasar kerja.
- Tableau dan Power BI menunjukkan pentingnya kemampuan dalam visualisasi data.
- Tool seperti Snowflake, Azure, dan Go juga masuk daftar — mencerminkan kebutuhan yang semakin besar akan keahlian cloud dan big data.

![Optimal Skills](assets\5_optimal_skills.png)

# What I learned

Sepanjang eksplorasi ini, saya berhasil meningkatkan kemampuan SQL saya secara signifikan:

- **🚗Complex Query Crafting:** Menguasai teknik SQL lanjutan, menggabungkan tabel dengan efisien, dan menggunakan WITH clause untuk membuat temporary table dengan fleksibel.
- **📊 Data Aggregatiom:** Mahir menggunakan GROUP BY dan fungsi agregat seperti COUNT() dan AVG() untuk merangkum data.
- **🔥 Analytical Wizardry:** Meningkatkan kemampuan menyelesaikan masalah dunia nyata dengan mengubah pertanyaan menjadi query SQL yang memberikan insight nyata.

# Conclusions

### Insight

1. **Top Paying Data Analyst Job**: Pekerjaan data analyst dengan gaji tertinggi untuk pekerjaan remote memiliki rentang gaji yang lebar, dengan gaji tertinggi mencapai $650.000!
2. **Skills for Top Paying Jobs**: Pekerjaan dengan bayaran tinggi memerlukan keahlian tingkat lanjut dalam SQL, menandakan bahwa ini adalah skill kritis untuk meraih gaji tinggi.
3. **Most In-Demanded Skills**: SQL juga merupakan skill paling banyak dibutuhkan di pasar kerja data analyst, menjadikannya sangat penting bagi pencari kerja.
4. **Skills with higher salaries**: Skill khusus seperti SVN dan Solidity memiliki rata-rata gaji tertinggi, menunjukkan nilai lebih pada keahlian yang bersifat niche.
5. **Optimal Skill for Job Market Value**: SQL memimpin dalam hal permintaan dan juga menawarkan gaji rata-rata tinggi, menjadikannya salah satu skill paling optimal yang harus dipelajari untuk meningkatkan nilai di pasar kerja.

### Closing Thought

Proyek ini telah meningkatkan kemampuan SQL saya dan memberikan wawasan berharga tentang pasar kerja untuk Data Analyst. Temuan dari analisis ini bisa menjadi panduan untuk memprioritaskan pengembangan skill dan strategi pencarian kerja. Calon Data Analyst dapat memposisikan diri mereka lebih baik dalam pasar kerja yang kompetitif dengan berfokus pada skill yang memiliki permintaan tinggi dan gaji tinggi. Eksplorasi ini menyoroti pentingnya pembelajaran berkelanjutan dan adaptasi terhadap tren baru dalam dunia data analytics.
