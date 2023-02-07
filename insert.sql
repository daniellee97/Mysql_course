# INSERT INTO 
# must put the VALUES in the exact order, listed in the column names
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES (999903, '1997-07-09', 'Daniel', 'Lee', 'M', '2022-11-01');

SELECT 
    *
FROM
    employees
WHERE
    birth_date = '1997-07-09';
    
INSERT INTO employees VALUES (999999, '1998-07-27', 'Andy', 'Joo', 'M', '2024-06-09');


SELECT 
    *
FROM
    titles
LIMIT 10;

INSERT INTO titles (emp_no, title, from_date) 
VALUES (999903, 'Senior Engineer', '1997-10-01');

SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC;

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO dept_emp
VALUES (999903, 'd005', '1997-10-01', '9999-01-01');

# Inserting data into a new table (INSERT INTO SELECT)
CREATE TABLE IF NOT EXISTS departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

INSERT INTO departments_dup(dept_no, dept_name)
SELECT * 
FROM departments;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

INSERT INTO departments 
VALUES ('d010', 'Business Analysis');

SELECT 
    *
FROM
    departments
ORDER BY dept_no;



