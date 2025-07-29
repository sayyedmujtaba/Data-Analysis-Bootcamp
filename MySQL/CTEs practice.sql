-- Problem: Find the employees who earn more than the average salary for their gender

WITH gender_avg AS (
  SELECT gender, AVG(salary) AS avg_salary
  FROM employee_demographics d
  JOIN employee_salary s 
  ON d.employee_id = s.employee_id
  GROUP BY gender
)
SELECT
  d.first_name,
  d.last_name,
  d.gender,
  s.salary
FROM employee_demographics d
JOIN employee_salary s 
ON d.employee_id = s.employee_id
JOIN gender_avg g 
ON d.gender = g.gender
WHERE s.salary > g.avg_salary;
;
