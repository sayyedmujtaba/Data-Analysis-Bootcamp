-- JOIN
-- join columns from multiple tables having same data

-- INNER JOIN
-- by default join use inner join method, the most common and simple type

select *
from employee_demographics as dem
inner join employee_salary as sal
on dem.employee_id = sal.employee_id;
-- if a data is missing in the 2nd column it will be dropped

select dem.employee_id, age, occupation -- as employee id is common in both so we identified that use demographic column, while age is just in demographics and occupation is only in salary
from employee_demographics as dem
inner join employee_salary as sal
on dem.employee_id = sal.employee_id; 

-- OUTER JOIN
-- LEFT OUTER JOIN: take all columns from left table and only return the items matced to right table 
-- RIGHT OUTER JOIN: vice versa of left  outer join 

select *
from employee_demographics as dem
left join employee_salary as sal
on dem.employee_id = sal.employee_id;

select *
from employee_demographics as dem
right join employee_salary as sal
on dem.employee_id = sal.employee_id; -- if an item is missing in left, it will still populate null for that

-- SELF JOIN
-- it is used to join a table with itself
select *
from employee_salary emp1
join employee_salary emp2
on emp1.employee_id = emp2.employee_id;

select *
from employee_salary emp1 -- AS... we can just skip AS too
join employee_salary emp2
on emp1.employee_id + 1 = emp2.employee_id;

select
emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,

emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp

from employee_salary emp1
join employee_salary emp2
on emp1.employee_id + 1 = emp2.employee_id;

-- joining multiple tables together
select *
from employee_demographics as dem
inner join employee_salary as sal
on dem.employee_id = sal.employee_id
inner join parks_departments pd
on sal.dept_id = pd.department_id;