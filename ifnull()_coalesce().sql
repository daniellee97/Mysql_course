/* IFNULL(expression_1, expression_2)
	- returns the first of the two indicated values 
	  if the data value found in the table is not null,
      and returns the second value if there is a null value
      (ONLY TWO EXPRESSIONS for whether the value is null or not)
	- prints the returned value in the column of the output
*/

/* COALESCE(expression_1, expression_2, ..., expression_N)
	- think of COALESCE() as IFNULL() with more than two expressions
	  (CAN HAVE ONE, TWO, OR MORE ARGUMENTS)
    - COALESCE() will always return a single value of the ones 
	  we have within parentheses, and this value will be 
      the first non-null value of this list, reading the values
      from left to right
*/

/* IFNULL() and COALESCE() do not make any changes to the data set.
   They merely create an output where certain data values appear 
   in place of NULL values.
*/

/*
Exercise: Select the department number and name from the ‘departments_dup’ table 
		  and add a third column where you name the department number (‘dept_no’) 
          as ‘dept_info’. If ‘dept_no’ does not have a value, use ‘dept_name’.
*/
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;

/*
Exercise: Modify the code obtained from the previous exercise in the following way. 
		  Apply the IFNULL() function to the values from the first and second column, 
          so that ‘N/A’ is displayed whenever a department number has no value, 
          and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.
*/
SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;