/* JOIN
	- shows a result set, containing fields 
	  derived from two or more tables
	- we must find a related column from the two tables 
      that contains the same type of data
	- the columns you use to relate tables must represent
	  the same object, such as id
	- the tables you are considering need not to be logically adjacent
*/

/* Exercise: If you currently have the ‘departments_dup’ table set up, 
			 use DROP COLUMN to remove the ‘dept_manager’ column 
             from the ‘departments_dup’ table.

			Then, use CHANGE COLUMN to change the ‘dept_no’ and ‘dept_name’ columns to NULL.
			
            (If you don’t currently have the ‘departments_dup’ table set up, create it. 
            Let it contain two columns: dept_no and dept_name. Let the data type of dept_no be CHAR of 4, 
            and the data type of dept_name be VARCHAR of 40. Both columns are allowed to have null values. 
            Finally, insert the information contained in ‘departments’ into ‘departments_dup’.)

			Then, insert a record whose department name is “Public Relations”.

			Delete the record(s) related to department number two.

			Insert two new records in the “departments_dup” table. Let their values 
            in the “dept_no” column be “d010” and “d011”.
*/
SELECT 
    *
FROM
    departments_dup;

# change the dept_no and dept_name columns to be able to have NULL value
ALTER TABLE departments_dup 
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

# insert 'Public Relations' department
INSERT INTO departments_dup (dept_name) 
VALUES ('Public Relations');

# delete a row that has 'd002' as the dept_no
DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';

# insert 'd010' and 'd011' as dept_no
INSERT INTO departments_dup (dept_no) 
VALUES ('d010'), ('d011');

# Exercise: create and fill in the ‘dept_manager_dup’ table, using the following code
DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

 

INSERT INTO dept_manager_dup
SELECT * 
FROM dept_manager;

 
INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES	(999904, '2017-01-01'),
		(999905, '2017-01-01'),
		(999906, '2017-01-01'),
		(999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES	('Public Relations');

 

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002'; 

/* INNER JOIN => same as JOIN
	- extracts only records in which the values in the related columns match
      (NULL values, or values appearing on just one of the two tables,
       and not appearing in the other are not displayed)
*/

# first check out two tables to be inner joined
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;


/*
Exercise: Extract a list containing information about all managers’ employee number, 
		  first and last name, department number, and hire date. 
*/
SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
ORDER BY emp_no;


# Handle duplicate rows

# insert duplicate row
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

# By using GROUP BY clause, this will remove the duplicate rows
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;


# remove duplicates from two tables
DELETE FROM dept_manager_dup 
WHERE
    emp_no = '110228';

DELETE FROM departments_dup 
WHERE
    dept_no = 'd009';
    
# add back the initial record
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

/* LEFT JOIN
	- the result set for LEFT JOIN will include the result set for inner join
      and the outside part of the inner join set from left table.
      (In Venn diagram, the result set of LEFT JOIN will be inner part 
       and the left outer part of Venn diagram)
	- when working with LEFT JOIN, the order in which you join tables matter.
    - can deliver a list with all records from the left table that do not match
	  any rows from the right table
*/

SELECT 
    m.emp_no, m.dept_no, d.dept_name, m.from_date
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

/*
	Exercise: Join the 'employees' and the 'dept_manager' tables to return 
			  a subset of all the employees whose last name is Markovitch. 
              See if the output contains a manager with that name.  

	Hint: Create an output containing information corresponding to the following fields: 
		  ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no'
          descending, and then by 'emp_no'.
*/
SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager m ON e.emp_no = m.emp_no
WHERE
    last_name = 'Markovitch'
GROUP BY e.emp_no
ORDER BY m.dept_no DESC, e.emp_no;


/* RIGHT JOIN 
	- same as LEFT JOIN, but in reverse direction
*/

# this result will be same as the LEFT JOIN query above
SELECT 
    m.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    dept_manager m
        RIGHT JOIN
    employees e ON m.emp_no = e.emp_no
WHERE
    last_name = 'Markovitch'
GROUP BY e.emp_no
ORDER BY m.dept_no DESC , m.emp_no;

/* Exercise: Extract a list containing information about all managers’ employee number, 
			 first and last name, department number, and hire date. Use the old type of 
             join syntax to obtain the result.
*/

# Old version of JOIN using WHERE clause
SELECT 
    m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e,
    dept_manager m
WHERE
    m.emp_no = e.emp_no
ORDER BY m.dept_no , m.emp_no;

# Using JOIN to get the same result
SELECT 
    m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    dept_manager m
        JOIN
    employees e ON m.emp_no = e.emp_no
ORDER BY m.dept_no , m.emp_no;


# Using JOIN and WHERE clause together
# Retreive employees whose salary is higher than $145,000
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000
ORDER BY e.emp_no;

/*
	Exercise: Select the first and last name, the hire date, and the job title of all employees 
			  whose first name is “Margareta” and have the last name “Markovitch”.
*/
SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;


/* CROSS JOIN
	- will take the values from a certain table and connect them
      with all the values from the tables we want to join it with
	- the Cartesian product of the values of two or more sets
    - particularly useful when the tables in a database are not well connected
*/

SELECT 
    m.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager m
ORDER BY m.emp_no , d.dept_no;

# CROSS JOIN more than two tables
SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
WHERE
    dm.dept_no <> d.dept_no
ORDER BY dm.emp_no , d.dept_no;


/*
	Exercise: Use a CROSS JOIN to return a list with all possible combinations 
			  between managers from the dept_manager table and department number 9.
*/
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY dm.emp_no;


/*
	Exercise: Return a list with the first 10 employees with 
			  all the departments they can be assigned to.

	Hint: Don’t use LIMIT; use a WHERE clause.
*/
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no <= '10010'
ORDER BY e.emp_no , d.dept_no;


# Using JOIN with aggregate functions
SELECT 
    e.gender, AVG(s.salary) AS salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;


# JOIN more than two tables
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
ORDER BY e.emp_no;

/*
	Exercise: Select all managers’ first and last name, hire date, 
			  job title, start date, and department name.
*/
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    titles t ON t.emp_no = dm.emp_no
        JOIN
    departments d ON d.dept_no = dm.dept_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;


# Tips and tricks for JOIN
SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    current_dept_emp cde ON d.dept_no = cde.dept_no
        JOIN
    salaries s ON s.emp_no = cde.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;


/*
	Exercise: How many male and how many female managers 
			  do we have in the ‘employees’ database?
*/
select e.gender, count(dm.emp_no) as gender_count
from employees e
join dept_manager dm on e.emp_no=dm.emp_no
group by gender;


/* UNION & UNION ALL
	- used to combine a few SELECT statement in a single output
    - must select same number of columns from each table
    - these columns should have the same names, should be in 
	  the same order, and should contain related data types.
*/ 
/*
	UNION:
		- displays only distinct values in the output
        * BETTER RESULT
	UNION ALL:
		- retrieves the duplicates as well
        * BETTER PERFORMANCE
*/
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;