-- STORED PROCEDURES: it is like functions in programing language
-- Helpful for storing complex queries


create procedure women_40()
	select first_name, last_name
	from employee_demographics
	where age > 40 and gender = 'Female';
	call women_40();


-- we can run multiple queries too in SQl, but first we have to make some changes
-- we should change delimeter for that specific instance from ; to $$ (most common practice is $$)
delimiter $$
create procedure procedure_1()
begin
	select first_name, last_name
	from employee_demographics
	where gender = 'Female';
	select first_name, last_name, salary
	from employee_salary;
    -- this procedure will show 2 differnt results for 2 different queries
end $$ -- this is the end of the procedure while ';' is end of a query in the procedure
delimiter ; -- it is necessary to chabge back the delimeter again to default
call procedure_1;



-- we can pass parameters too to store procedure
delimiter $$
create procedure salaries(p_employee_id INT) -- (name of input (p_employee_id) and datatype of input (INT))
begin
	select employee_id, first_name, last_name, salary
	from employee_salary
	where employee_id = p_employee_id;
end $$
delimiter ;

call salaries(5); -- it will show the salry of only select employee
