use parks_and_recreation;

#The WHERE clause is used to filter records (rows of data)
#It's going to extract only those records that fulfill a specified condition.
# So basically if we say "Where name is = 'Alex' - only rows were the name = 'Alex' will return
# So this is only effecting the rows, not the columns

#we can use comparison operators like >, <, =, >=, <=, !=
# This command will show everything about a person whose salry is reater than 50k
select *
from employee_salary
where salary > 50000;

# This command will only show the first name if a person person whose salry is reater than 50k
select first_name, salary
from employee_salary
where salary > 50000;

# LIKE (% and _)
-- % means anything
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';

-- _ means a specific value
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';

# %a% means that the column should just have an a
# a% means that the column should start with a
# %a means that the column should end with a

# a__ means that a must be followed by two characters only
# a__- means that a must be followed by three characters only
# _a__ means that a must be followed by two characters and trailed by one
