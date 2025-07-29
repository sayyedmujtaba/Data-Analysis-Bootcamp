-- Windowfunction
-- it is like GROUP BY  except they don't roll everything up into 1 row when grouping. 

-- lets look at a GROUP BY example
select gender, avg(salary)
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id =  sal.employee_id
group by gender
;

-- example of window function
-- FUNCTION_NAME(...) OVER (PARTITION BY column ORDER BY column)
select gender, avg(salary) over (partition by gender) -- we can leave it as OVER() too
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id =  sal.employee_id
;

select dem.first_name, dem.last_name, gender, avg(salary) over (partition by gender) as avg_salary
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id =  sal.employee_id
;


-- now lets find sum instead of avg salary
select dem.first_name,
dem.last_name,
gender,
sum(salary) over (partition by gender) as sum
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id =  sal.employee_id
;

-- rolling total, just add the rows in ORDER BY
select dem.first_name,
dem.last_name,
gender,
salary,
sum(salary) over (partition by gender order by dem.employee_id) as rolling_total
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id =  sal.employee_id
;



-- some special funtins we can do in windows function
-- row_number()
-- rank ()

select dem.employee_id,
dem.first_name,
dem.last_name,
gender,
salary,
row_number() over(partition by gender order by salary desc) as row_Num,
rank() over(partition by gender order by salary desc) as ranking,
dense_rank() over(partition by gender order by salary desc) as dense_ranking
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id =  sal.employee_id
;


