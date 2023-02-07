/*	Index
		- data is taken from a column of the table and is stored in a certain order in a distinct place
        - use of index will increase the speed of searches related to a table
			- the larger a database is, the slower the process of finding the record or records you need
		- primary and unique keys are MySQL indexes
			- they represent columns on which a person would typically base their search
		- index is useful for large datasets rather than small datasets since for small datasets,
		  cost of having index will be higher than its benefits
		
        * Format:
        CREATE INDEX index_name
        ON table_name (column_1, column_2, ...);
        
	Composite index
		- same as index but with multiple columns
*/

# Before using index, this query took 0.113sec
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
# Create index (rerun the previous SELECT query, then runtime is 0.0013sec)
CREATE INDEX i_hire_date ON employees(hire_date);

# Before using composite index, this query took (0.113 sec)
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';
        
# Create composite index (rerun the previous query, then it took 0.0012 sec)
CREATE INDEX i_first_last_name ON employees(first_name, last_name);

/*
	Exercise: 
		1. Drop the ‘i_hire_date’ index. 
        2. Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
		   Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
*/

ALTER TABLE employees
DROP INDEX i_hire_date;

SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;
    
CREATE INDEX i_salary ON salaries(salary);

ALTER TABLE salaries
DROP INDEX i_salary;