#CREATE DATABASE IF NOT EXISTS Sales;

#USE Sales;

# Create table using CREATE statement
CREATE TABLE IF NOT EXISTS Sales 
(
	purchase_number INT NOT NULL AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code varchar(10) NOT NULL,
PRIMARY KEY (purchase_number)
);

CREATE TABLE IF NOT EXISTS Customers 
(
	customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

# Adding column using ALTER
ALTER TABLE Customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

# Insert values to the table using INSERT
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

CREATE TABLE IF NOT EXISTS Items
(
	item_code VARCHAR(255) NOT NULL,
    item VARCHAR(255),
    unit_price NUMERIC(10,2),
    company_id VARCHAR(255),
PRIMARY KEY (item_code)
);

CREATE TABLE IF NOT EXISTS Companies
(
	company_id VARCHAR(255) NOT NULL,
    company_name VARCHAR(255) DEFAULT 'X',
    headquarter_phone_number INT,
PRIMARY KEY(company_id),
UNIQUE KEY (headquarter_phone_number)
);

# adding NULL constraint to column
ALTER TABLE Companies
MODIFY headquarter_phone_number VARCHAR(255) NULL;

# another way to change column specification
ALTER TABLE Companies
CHANGE COLUMN headquarter_phone_number
headquarter_phone_number VARCHAR(255) NOT NULL;

ALTER TABLE Sales
ADD FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
	ON DELETE CASCADE;
    
ALTER TABLE Customers
ADD UNIQUE KEY (email_address);

ALTER TABLE Customers
DROP INDEX email_address;

SELECT * FROM Customers;

SELECT * FROM Sales.Customers;

DROP TABLE Sales;

DROP TABLE Customers;

DROP TABLE Companies;

DROP TABLE Items;