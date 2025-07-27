-- CASE
-- it is like the if else cindition in programing language

SELECT first_name, 
last_name, 
age,
CASE
WHEN age <= 30 THEN 'Young'
WHEN age BETWEEN 31 AND 50 THEN 'Old'
WHEN age > 50 THEN "On Death's Door"
END as age_bracket
FROM employee_demographics
;
select first_name, last_name, salary,
case
when salary <= 40000 then "starter"
when salary between 41000 and 50000 then "Intermediate"
when salary >= 51000 then "rich"
end as salary_bracket
from employee_salary
;



select  dem.first_name, dem.last_name, dem.age,
case
WHEN dem.age <= 30 THEN 'Young'
WHEN dem.age BETWEEN 31 AND 50 THEN 'Old'
WHEN dem.age > 50 THEN "On Death's Door"
END as age_bracket,
sal.salary,
case
when sal.salary <= 40000 then "starter"
when sal.salary between 41000 and 50000 then "Intermediate"
when sal.salary >= 51000 then "rich"
end as salary_bracket
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
