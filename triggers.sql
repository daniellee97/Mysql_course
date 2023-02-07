USE employees;

COMMIT;

/*	Trigger
		- a type of stored program, associated with a table, that will be activated
          automatically once a specific event occurs
		- a trigger is a MySQL object that can 'trigger' a specific action or calculation
          'before' or 'after' an INSERT, UPDATE, DELETE statement has been executed
		- this event must be related to the associated table and represented by one
		  of the following three DML statements:
			- INSERT
            - UPDATE
            - DELETE
*/

# BEFORE INSERT
DELIMITER &&

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 then
		SET NEW.salary=0;
	END IF;
    
END &&

DELIMITER ;

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# insert negative value into salary column
INSERT INTO salaries 
VALUES ('10001', '-19938', '2010-06-22', '9999-01-01');

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# before update
DELIMITER &&

CREATE TRIGGER before_salaries_update
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN
	IF NEW.salary<0 THEN
		SET NEW.salary= OLD.salary;
	END IF;
END &&

DELIMITER ;

UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
UPDATE salaries 
SET 
    salary = - 987655
WHERE
    emp_no = '100001'
        AND from_date = '2010-06-22';
        
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
/* System function (built-in function)
	- 
*/
SELECT SYSDATE();

SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') AS today;

DELIMITER $$

CREATE TRIGGER trig_ins_dep_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;

SELECT 
    MAX(salary)
INTO v_curr_salary FROM
    salaries
WHERE
    emp_no = NEW.emp_no;
    
    IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries
        SET to_date = SYSDATE()
        WHERE emp_no=NEW.emp_no AND to_date = NEW.to_date;
	
		INSERT INTO salaries
		VALUES (NEW.emp_no, v_curr_salary+20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

INSERT INTO dept_manager
VALUES ('111534', 'd009', date_format(sysdate(), '%Y-%m-%d'), '9999-01-01');

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no = '111534';
    

/*
	Exercise: Create a trigger that checks if the hire date of an employee 
			  is higher than the current date. If true, set this date to be 
              the current date. Format the output appropriately (YY-MM-DD).
*/

DELIMITER $$

CREATE TRIGGER trig_ins_emp
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date>date_format(sysdate(), '%Y-%m-%d') THEN
		 SET NEW.hire_date=date_format(sysdate(), '%Y-%m-%d');
	END IF;
END $$

DELIMITER ;
    
INSERT INTO employees
VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT 
    *
FROM
    employees
WHERE
    emp_no = '999904';