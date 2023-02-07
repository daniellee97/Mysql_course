/*
Aggregated Function (Summarizing Functions)
	- they gather data from many rows of a table, then aggregate
	  it into a single value
	- aggregate functions typically ignore null values throughout the field to which they are applied
	* SUM(), COUNT(), MIN(), MAX(), AVG()
*/

# COUNT()
# - applicable to both numeric and non-numeric data (only in COUNT() function)
# - COUNT(*) returns the number of all rows of the table, NULL values included 
# 	(only in COUNT() function)

SELECT 
    COUNT(*)
FROM
    employees;

/* Exercise: How many departments are there in the “employees” database? 
			 Use the ‘dept_emp’ table to answer the question.
*/

SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
    
# SUM()
# - cannot use SUM(*) since SUM() function is only
#	applicable to numeric data
SELECT 
    SUM(salary) AS total_salary
FROM
    salaries;
    
/*
Exercise: What is the total amount of money spent on salaries for 
		  all contracts starting after the 1st of January 1997?
*/

SELECT 
    SUM(salary) as total_salary
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
# MIN() and MAX()
SELECT 
    MIN(salary)
FROM
    salaries;

/*
Exercise: 
	1. Which is the lowest employee number in the database?
	2. Which is the highest employee number in the database?
*/
SELECT 
    MIN(emp_no)
FROM
    employees;

SELECT 
    MAX(emp_no)
FROM
    employees;
    
# AVG()
# - extracts the average value of all non-null values in a field

/*
Exercise: What is the average annual salary paid to employees 
		  who started after the 1st of January 1997?
*/

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
# ROUND(#, decimal_places)
# the statement below will give the result with 2 decimal places
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;
    
/*
Exercise: Round the average amount of money spent on salaries 
		  for all contracts that started after the 1st of January 1997 
		  to a precision of cents.
*/

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';