select * from training_data;

-- 1. Rata2 income berdasarkan kriteria pengalaman kerja (experience)
select 
case
when experience < 5 then "intern"
when experience < 10 then "intermediate"
else
"expert"
end as category_exp,
avg(income) as avg_inc,
count(income) as counted
from training_data
group by category_exp;

-- 2. Rata2 gaji berdasarkan maried dan a house ownership
select married, house_ownership, avg(income) as avg_inc, count(income) as counted
from training_data
group by married, house_ownership
order by married, house_ownership;

-- 3. Rata2 pengalaman kerja berdasarkan maried
select married, avg(experience) as avg_exp
from training_data
group by married;

-- 4. apakah maried/single berpengaruh terhadap defaulted on a loan
select married, risk_flag, count(*) as counted
from training_data
group by married, risk_flag
order by married, risk_flag;

-- 5. Rata2 gaji berdasarkan kota dan profesi

delimiter $$
create procedure avg_inc_on_city_profesion(
in city_name text
)
begin
select profession, city, avg(income) as avg_inc
from training_data
where city like concat_ws("","%",city_name,"%")
group by profession, city
order by profession, city;
end $$
delimiter ;

drop procedure avg_inc_on_city_profesion;

select distinct city from training_data;

call avg_inc_on_city_profesion("lap");

-- 6. Mengetahui rata2 gaji berdasarkan kriteria umur dan menghitung brp banyak yang sudah memiliki rumah
select 
case
when age < 30 then "young"
when age < 50 then "adult"
else
"old"
end as criteria_age, avg(income) as avg_inc, count(*) as house_count
from training_data
where House_Ownership = "owned"
group by criteria_age;

-- 7. Mengetahui rata2 gaji berdasarkan profesi dan menghitung brp banyak yang sudah memiliki mobil
select profession, avg(income) as avg_inc, count(*) as car_count
from training_data
where car_ownership = "yes"
group by profession
order by Profession;

-- 8. Rata2 gaji berdasarkan current job year experience
select current_job_yrs, avg(income) as avg_inc
from training_data
group by CURRENT_JOB_YRS
order by CURRENT_JOB_YRS;

-- 9. Mengetahui kota atau prov yang memiliki rata2 gaji tertinggi
	-- city
    select city, avg(income) as avg_inc
    from training_data
    group by city
    order by avg_inc desc
    limit 10;
    
    -- state
    select state, avg(income) as avg_inc
    from training_data
    group by state
    order by avg_inc desc
    limit 10;