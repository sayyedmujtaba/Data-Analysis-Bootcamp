-- ORDER BY --

select gender, avg(age), max(age), min(age), count(gender)
from employee_demographics
group by gender;

select salary
from employee_salary
group by salary; 				#multiple people have same salries but here it will show only one of each salary

select occupation, salary
from employee_salary
group by occupation, salary; 		# Multiple items can also be grouped together

select * from employee_demographics;
select * from employee_salary;


-- GROUP BY
-- It ascnd or descend the result set, by default it will ascend
select *
from employee_demographics
order by age ASC ;

select *
from employee_demographics
order by gender, age desc;