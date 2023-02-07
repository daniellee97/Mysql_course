/*	Stored Procedure 				vs. 			User Defined Function
	- does not return value							- returns a value
    - CALL procedure								- SELECT function
    - can have multiple OUT parameters				- can return a single value only
*/


# User Defined Function
DROP FUNCTION IF EXISTS f_emp_avg_salary;

# Create user defined function
DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)

# this line is to prevent error code 1418 (binary log)
DETERMINISTIC
BEGIN
DECLARE v_avg_salary DECIMAL(10,2);
SELECT AVG(s.salary) 
INTO v_avg_salary FROM 
	employees e
		JOIN 
	salaries s ON e.emp_no=s.emp_no
WHERE e.emp_no = p_emp_no;

RETURN v_avg_salary;
END $$
DELIMITER ;

# call the user defined function
SELECT f_emp_avg_salary(11039);


/*
	Exercise: Create a function called ‘emp_info’ that takes for parameters 
			  the first and last name of an employee, and returns the salary 
              from the newest contract of that employee.

	Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date 
		  that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

			  Finally, select this function.
*/

DROP FUNCTION IF EXISTS f_emp_info;

DELIMITER $$
CREATE FUNCTION f_emp_info (p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_salary DECIMAL(10, 2);
DECLARE v_max_from_date DATE;
SELECT 
	MAX(s.from_date) INTO v_max_from_date
FROM 
	employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;

SELECT
	s.salary INTO v_salary
FROM 
	employees e
		JOIN
	salaries s 
		ON e.emp_no=s.emp_no
WHERE e.first_name=p_first_name AND e.last_name=p_last_name AND s.from_date=v_max_from_date;
RETURN v_salary;
END $$
DELIMITER ;

SELECT f_emp_info ('Mary', 'Sluis');