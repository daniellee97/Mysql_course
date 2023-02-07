/* CASE
	- similar to COALESCE and IFNULL
    
    * Syntax:
		SELECT 
			column_name(s),
            CASE condition_field
				WHEN condition_field_value_1 THEN result_1
                WHEN condition_field_value_2 THEN result_2
                ...
                ELSE
			END AS
		FROM 
			table_name;
*/


SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS title
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;
    
SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
    employees;
    
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 and less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no;

/*
	Exercise 1: Similar to the exercises done in the lecture, obtain a result set containing the employee number, 
			  first name, and last name of all employees with a number higher than 109990. 
              Create a fourth column in the query, indicating whether this employee is also a manager, 
              according to the data provided in the dept_manager table, or a regular employee. 
*/
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;

/*
	Exercise 2: Extract a dataset containing the following information about the managers: employee number, 
				first name, and last name. Add two columns at the end – one showing the difference between 
                the maximum and minimum salary of that employee, and another one saying 
                whether this salary raise was higher than $30,000 or NOT.

				If possible, provide more than one solution.
*/

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised more than $30,000'
        ELSE 'Salary was raised less than $30,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY dm.emp_no;


SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary raised more than $30,000',
        'Salary raised less than $30,000') as salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY s.emp_no;


/*
	Exercise 3: Extract the employee number, first name, and last name of the first 100 employees, 
				and add a fourth column, called “current_employee” saying “Is still employed” 
                if the employee is still working in the company, or “Not an employee anymore” if they aren’t.

				Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. 
*/

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) < DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN 'is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
GROUP BY de.emp_no
LIMIT 100;

