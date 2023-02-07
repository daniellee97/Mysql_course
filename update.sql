# UPDATE statement
#	- used to update the values of existing records in a table
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999999;
    
UPDATE employees 
SET 
    birth_date = '2000-07-27',
    first_name = 'Sandy',
    last_name = 'Joo',
    gender = 'F'
WHERE
    emp_no = 999999;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999999;
    
# COMMIT and ROLLBACK
# ROLLBACK will have an effect on the last execution you have performed
# you cannot restore data to a state corresponding to an earlier COMMIT

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;

# Making mistake on purpose
# this query will update all rows to be identical
UPDATE departments_dup 
SET 
    dept_no = 'd011',
    dept_name = 'Quality Control';

# Rollback to the last commit before the mistake happened
ROLLBACK;

# recommit to save errorless state
COMMIT;

# UPDATE exercise 
/*
Change the “Business Analysis” department name to “Data Analysis”.
*/
UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_no = 'Business Analysis';
    
SELECT 
    *
FROM
    departments
ORDER BY dept_no;
    
