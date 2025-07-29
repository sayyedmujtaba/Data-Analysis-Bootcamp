-- CTE: common table expression

-- syntax
-- WITH cte_name AS (
--     SELECT ...
-- )
-- SELECT ...
-- FROM cte_name;

with CTE_Example as
(
select gender,
avg(salary) as avg_sal,
max(salary) as max_sal,
min(salary) as min_sal,
count(salary) as count_sal
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_Example
;



with CTE_Example as
(
select gender,
avg(salary) as avg_sal,
max(salary) as max_sal,
min(salary) as min_sal,
count(salary) as count_sal
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
group by gender
)
select avg(avg_sal)
from CTE_Example
;



-- suppose we want to do the same via subqueries
select avg(avg_sal)
from (
select gender,
avg(salary) as avg_sal,
max(salary) as max_sal,
min(salary) as min_sal,
count(salary) as count_sal
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
group by gender
)
example_subquery;
;


-- we can join multiple CTEs in CTE too
with CTE_Example as
(
select employee_id, gender, birth_date
from employee_demographics as dem
where birth_date > "1985-01-01"
),
CTE_Example2 as
(
select employee_id, salary
from employee_salary
where salary > 50000
)
select *
from CTE_Example
join CTE_Example2
on CTE_Example.employee_id = CTE_Example2.employee_id
;