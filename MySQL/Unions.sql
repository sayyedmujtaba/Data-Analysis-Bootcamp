-- UNIONS
-- use to write multiple select statements together
-- we will use UNION to combine multiple selecct statements

select age, gender
from employee_demographics
union
select first_name, last_name
from employee_salary
;
-- in the result you can see that we have two columns at first they cover the age and gender while later they cover first_name and last_name
-- by default a UNION is a UNION DISTINCT

select first_name, last_name, "Old Man" as label
from employee_demographics
where age > 40 and gender = "Male"
union
select first_name, last_name, "Old Ldy" as label
from employee_demographics
where age > 40 and gender = "Female"
union
select first_name, last_name, "Highly Paid" as label
from employee_salary
where salary > 70000
order by first_name, last_name
;