SELECT 
    dept_no
FROM
    departments;
    
SELECT 
    *
FROM
    departments;
    
# using WHERE clause
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
# AND operator
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';
    
# OR operator    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kelie'
        OR first_name = 'Aruna';

# using AND and OR operators together
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');
        
# IN operator
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';

# this is same query statement as the upper one using IN operator
# IN operator is slightly faster than using nested query
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    
# NOT IN operator
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
    
# LIKE and NOT LIKE operators
# use these with % or _
# %: a substitute for a sequence of characters
# _: helps match a single character
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000%');
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
# Wildcard character: '%', '_', '*'
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Jack%');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%');
    
# BETWEEN ... AND ... / NOT BETWEEN ... AND ...
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
    
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';    

# IS NULL and IS NOT NULL
SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;
    
# other comparison operators
# =, !=, <>, <, >, <=, >=
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01'
        AND gender = 'F';
        
SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;
    
# DISTINCT 
SELECT DISTINCT
    hire_date
FROM
    employees
LIMIT 2000;

/*
Aggregated Functions: they are applied on multiple rows of a single column 
					  of a table and return an output of a single value.
                      * COUNT(), SUM(), MIN(), MAX(), AVG()
*/
SELECT 
    COUNT(emp_no)
FROM
    employees;

SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;
    
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;
    
SELECT 
    COUNT(DISTINCT emp_no)
FROM
    dept_manager;
    
# ORDER BY clause with ASC (ascending) and DESC (Descending)
SELECT 
    *
FROM
    employees
ORDER BY first_name , last_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/* GROUP BY clause (Important)
	- GROUP BY must be placed immediately after the WHERE conditions, if any,
	  and just before the ORDER BY clause
	- In most cases, when you need an aggregated function, you must add
	  a GROUP BY  clause in your query
*/
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY COUNT(first_name) DESC;

# AS (alias)
SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
GROUP BY first_name
ORDER BY name_count DESC;

SELECT 
    salary, COUNT(salary) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

/* HAVING clause (this is similar with WHERE, but applied to the GROUP BY block)
	- after HAVING, you can have a condition with an aggregate function,
	  while WHERE cannot use aggregate functions within its conditions.
*/

SELECT 
    first_name, COUNT(first_name) AS name_counts
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 230
ORDER BY name_counts;

SELECT 
    emp_no, AVG(salary) AS avg_salary
FROM
    salaries
GROUP BY emp_no
HAVING avg_salary > 120000
ORDER BY avg_salary DESC;

# HAVING vs WHERE clauses
/*
- HAVING clause cannot contain both aggregated and non-aggregated condition
- Aggregated function => use GROUP BY and HAVING
- General conditions => use WHERE
*/
SELECT 
    first_name, COUNT(first_name) AS name_counts
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING name_counts < 200
ORDER BY first_name;

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no;

# LIMIT
SELECT emp_no
FROM
    salaries
ORDER BY salary DESC
LIMIT 10; 

SELECT 
    *
FROM
    dept_emp
LIMIT 100;