-- CTE: Common Table Expression
-- CTEs are temporary result sets that exist only within the scope of a single SQL statement
-- They help improve code readability and can be referenced multiple times in the same query

-- Basic CTE Syntax:
-- WITH cte_name AS (
--     SELECT ...
-- )
-- SELECT ...
-- FROM cte_name;

-- Example 1: Simple CTE to calculate salary statistics by gender
with CTE_Example as
(
select gender,
avg(salary) as avg_sal,      -- Average salary per gender
max(salary) as max_sal,      -- Maximum salary per gender
min(salary) as min_sal,      -- Minimum salary per gender
count(salary) as count_sal   -- Count of employees per gender
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_Example
;

-- Example 2: Using the CTE result to calculate overall average of gender averages
with CTE_Example as
(
select gender,
avg(salary) as avg_sal,      -- Average salary per gender
max(salary) as max_sal,      -- Maximum salary per gender
min(salary) as min_sal,      -- Minimum salary per gender
count(salary) as count_sal   -- Count of employees per gender
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
group by gender
)
select avg(avg_sal)          -- Calculate average of the gender averages
from CTE_Example
;

-- Alternative approach using subquery (more complex and less readable)
-- This achieves the same result as the CTE above but is harder to read and maintain
select avg(avg_sal)
from (
select gender,
avg(salary) as avg_sal,      -- Average salary per gender
max(salary) as max_sal,      -- Maximum salary per gender
min(salary) as min_sal,      -- Minimum salary per gender
count(salary) as count_sal   -- Count of employees per gender
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
group by gender
)
example_subquery;
;

-- Example 3: Multiple CTEs in a single query
-- This demonstrates how to create and join multiple CTEs
with CTE_Example as
(
-- First CTE: Filter employees born after 1985
select employee_id, gender, birth_date
from employee_demographics as dem
where birth_date > "1985-01-01"
),
CTE_Example2 as
(
-- Second CTE: Filter employees with salary > 50000
select employee_id, salary
from employee_salary
where salary > 50000
)
-- Join the two CTEs to find young employees with high salaries
select *
from CTE_Example
join CTE_Example2
on CTE_Example.employee_id = CTE_Example2.employee_id
;