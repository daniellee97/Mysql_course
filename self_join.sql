/* Self join
	- if you'd like to combine certain rows from a table with other rows from 
	  the same table, you need a self-join.
	- the self-join will reference both implied table and will treat them as
      two separate tables in its operation.
	- using alias is obligatory
		- the references to the original table let you use different blocks
		  of the available data
		- you can either filter both in the join, or you can filter one of them
          in the WHERE clause, and the other one in the JOIN
*/

SELECT 
    *
FROM
    emp_manager
ORDER BY emp_no;

# Self join query
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
# this query will have the same result as the above
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);