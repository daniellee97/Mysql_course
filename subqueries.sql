/* Subqueries
	- allow for better structuring of the outer query
    - in some situations, the use of subqueries is much more intuitive 
	  compared to the use of complex joins and unions
	- many users prefer subqueries because they offer enhanced code readability
*/

# Subquery with IN 
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
/*
	Exercise: Extract the information about all department managers who were hired 
			  between the 1st of January 1990 and the 1st of January 1995.
*/
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            

/* Subqueries with EXISTS & NOT EXISTS nested inside WHERE
	- EXISTS
		- this check is conducted row by row
        - it returns a boolean value
*/
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);
            
/* EXISTS vs IN
	- EXISTS
		- tests row values for existence
        - quicker in retrieving large amounts of data
	- IN 
		- searches among values
        - faster with smaller datasets
*/

/*
	Exercise: Select the entire information for all employees 
			  whose job title is “Assistant Engineer”. 

	Hint: To solve this exercise, use the 'employees' table.
*/

SELECT 
    e.*
FROM
    employees e
WHERE
    EXISTS( SELECT 
            t.*
        FROM
            titles t
        WHERE
            t.title = 'Assistant Engineer'
                AND t.emp_no = e.emp_no);


/* Subqueries nested in SELECT and FROM

*/
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    e.emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = '110022') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= '10020'
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    e.emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = '110039') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no BETWEEN '10021' AND '10040'
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS B;
    
/*
	Exercise: Starting your code with “DROP TABLE”, create a table called “emp_manager” 
			  (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
*/
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE IF NOT EXISTS emp_manager (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT NOT NULL
);

/*
	Exercise: Fill emp_manager with data about employees, 
			  the number of the department they are working in, 
              and their managers.
	
    A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). 
    In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 
    (this must be subset A), and employee number 110039 as a manager to all employees from 10021 to 10040 
    (this must be subset B).

	Use the structure of subset A to create subset C, where you must assign employee number 110039 
    as a manager to employee 110022.

	Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 
    as a manager to employee 110039.
*/
INSERT INTO emp_manager SELECT U.* FROM (SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    e.emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = '110022') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= '10020'
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    e.emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = '110039') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no BETWEEN '10021' AND '10040'
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS B
UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    e.emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = '110039') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no ='110022'
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D
UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    e.emp_no
                FROM
                    employees e
                WHERE
                    e.emp_no = '110022') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no ='110039'
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) as U;