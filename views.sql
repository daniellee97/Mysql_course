/* VIEW
	- a virtual table whose contents are obtained from an existing table
	  or tables, called base tables
      - the retrieval happens through an SQL statement, incorporated into
	    view
	- think of a view object as a view into the base table
    - the view itself does not contain any real data; the data is physically
      stored in the base table
	- the view simply shows the data contained in the base table
    
  Advantages
	- save a lot of coding time
    - views occupy no extra memory
    - acts as a dynamic table because it instantly reflects data and structural changes
      in the base table
*/

SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS emp_count
FROM
    dept_emp
GROUP BY emp_no
HAVING emp_count > 1;

# create view (name convention: usualy start with 'v_' or 'w_')
# to indicate this is a view object
CREATE OR REPLACE VIEW v_dept_emp_lastest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
# select a created view
# (Don't forget to add AS after view's name and before SELECT statement)
SELECT 
    *
FROM
    employees.dept_emp_latest_date;
    
    
/*
	Exercise: Create a view that will extract the average salary of all managers 
			  registered in the database. Round this value to the nearest cent.

			  If you have worked correctly, after executing the view 
              from the “Schemas” section in Workbench, 
              you should obtain the value of 66924.27.
*/
CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(s.salary), 2) AS avg_salary
    FROM
        salaries s
            JOIN
        dept_manager dm ON s.emp_no = dm.emp_no;

# select a created view
SELECT 
    *
FROM
    v_manager_avg_salary;