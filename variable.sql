/* Variables
	- once the structure is solidified, then it will be applied to the database.
      The input value you insert is typically referred to as the 'argument'(input),
      while the obtained output value is stored in a 'variable' (output).
*/

# create variable ('v_' in the variable name means 'variable')
# according to the convention, you initialize the variable to be set to 0.
SET @v_avg_salary=0;
CALL emp_avg_salary_out(110039, @v_avg_salary);
SELECT @v_avg_salary;

/*
	Exercise: Create a variable, called ‘v_emp_no’, where you will store 
			  the output of the procedure you created in the last exercise.

			  Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ 
              as a first and last name respectively.

			  Finally, select the obtained output.
*/
SET @v_emp_no=0;
CALL emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;