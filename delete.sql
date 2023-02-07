COMMIT;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;

# DELETE    
DELETE FROM employees 
WHERE
    emp_no = 999903;

ROLLBACK;

SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;

select * from departments_dup;

DELETE FROM departments_dup;

ROLLBACK;

DELETE FROM departments 
WHERE
    dept_no = 'd010';

# DROP vs TRUNCATE vs DELETE
/*
DROP
	- you won't be able to roll back to its initial state, or to the last COMMIT statement

TRUNCATE 
	- is similar to DELETE without WHERE clause (delete all records and only the table will be remained)
    - when truncating, auto-increment values will be reset
    
DELETE 
	- remove records row by row with certain condition (WHERE)
*/

/*
TRUNCATE vs DELETE without WHERE
	- TRUNCATE will be slightly faster than using DELETE without WHERE
    - auto-increment will not be reset with DELETE
*/






