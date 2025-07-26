-- limit
-- limit the number of rows we WILL use

select *
from employee_demographics
limit 3
;

select *
from employee_demographics
order by age desc
limit 3
;


-- aliasing (as)

select gender, avg(age) as avg_age
from employee_demographics
group by gender
;