/* Stored routine
	- an SQL statement, or a set of SQL statements, that can be stored
      on the database server
	- whenever a user needs to run the query in question, they can
      CALL, REFERENCE, or INVOKE the routine
	- always use temporary DELIMITER (usually '$$' or '//') to prevent
      unusual stop when calling stored procedures
	- always set DELIMITER back to ';' after defining procedure
	- always put '()' after typing procedure name
      
	Types of stored routine
		- Stored procedures
			= procedures
		- Functions
			= user-defined function
            != built-in functions
               (aggregated function, datetime function, etc.)
*/

# Create a procedure that will retrieve first 1000 rows from 'employees' table
USE employees;

# No '()' after procedure name when dropping
DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$

CREATE PROCEDURE select_employees()
BEGIN 
	SELECT * FROM employees 
    ORDER BY emp_no LIMIT 1000;
END $$ 

DELIMITER ;


# this is how to use the stored procedure
CALL select_employees();


/*
	Exercise: Create a procedure that will provide the average salary of all employees.

			  Then, call the procedure.
*/

DELIMITER $$

CREATE PROCEDURE avg_emp_salary()
BEGIN 
	SELECT ROUND(AVG(salary), 2) AS avg_salary FROM salaries;
END $$

DELIMITER ;

CALL avg_emp_salary();

DROP PROCEDURE IF EXISTS select_salaries;


/* Stored Procedure with an Input Parameter
	- a stored routine can perform a calculation that transforms an input
	  value in an output value
	- stored procedures can take an input value and then use it in the query,
      or queries, written in the body of the procedure
	- input value is represented by IN parameter
*/

DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN 
	SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
    FROM employees e 
		JOIN salaries s on e.emp_no=s.emp_no
	WHERE 
		e.emp_no = p_emp_no;
END$$

DELIMITER ;

# call stored procedure with parameter
call emp_salary(100039);

DROP PROCEDURE IF EXISTS emp_avg_salary;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT e.first_name, e.last_name, ROUND(AVG(s.salary), 2) as avg_salary
    FROM employees e 
			JOIN 
        salaries s ON e.emp_no = s.emp_no
	WHERE 
		e.emp_no = p_emp_no;
END $$
DELIMITER ;

call emp_avg_salary(11300);


/* Procedure without parameter
	- every time you create a procedure containing 
      both an IN and an OUT parameters, you must use
      SELECT - INTO structure
*/

DROP PROCEDURE IF EXISTS emp_avg_salary_out;
DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out (in p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN 	 
	SELECT avg(s.salary)
		INTO p_avg_salary FROM
        employees e 
			JOIN
		salaries s on e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ;

call emp_avg_salary_out(110039);

/*
	Exercise: Create a procedure called ‘emp_info’ that uses as parameters 
			  the first and the last name of an individual, 
              and returns their employee number.
*/

DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name VARCHAR(20), in p_last_name VARCHAR(20), out p_emp_no INTEGER)
BEGIN
	SELECT emp_no INTO p_emp_no
    FROM employees
    WHERE first_name = p_first_name AND last_name = p_last_name;
END $$
DELIMITER ;
