SELECT * # Select all columns
FROM parks_and_recreation.employee_demographics;

# We can also select specific columns and perform operations
SELECT first_name, age, (age * 10) + 2, gender
FROM parks_and_recreation.employee_demographics;
# MySQL uses PEMDAS (Parentheses, Exponents, Multiplication, Division, Addition, Subtraction) for mathematical operations

# DISTINCT is used to find uniqueness in a column
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;
-- it will show Male and Female as the only 2 outputs