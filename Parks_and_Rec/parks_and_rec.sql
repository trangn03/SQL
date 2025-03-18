-- SELECT Statement
-- Select actual column
-- * Means everything, select all

SELECT *
FROM employee_demographics;

-- If on the other database then you can specify the database that you want
SELECT * 
FROM parks_and_recreation.employee_demographics;

-- Select one column
SELECT first_name 
FROM parks_and_recreation.employee_demographics;

-- Multiple column with ,
SELECT first_name, last_name, birth_date
FROM parks_and_recreation.employee_demographics;

-- Calculation
-- PEMDAS format
SELECT first_name, last_name, birth_date, age, (age + 10) * 10
FROM parks_and_recreation.employee_demographics;

-- distinct: only the unique value within the column
-- will be only two output: Male and Female
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

-- WHERE Clause
-- Filter the record, rows of data
SELECT * 
FROM employee_salary
WHERE first_name = "Leslie";

-- Operator
SELECT * 
FROM employee_salary
WHERE salary > 50000;

SELECT * 
FROM employee_salary
WHERE salary < 50000;

SELECT *
FROM employee_demographics
WHERE gender != "Female";

SELECT *
FROM employee_demographics
WHERE birth_date > "1985-01-01";

-- Logical operators: AND OR NOT
SELECT *
FROM employee_demographics
WHERE birth_date > "1985-01-01"
AND gender = "Male";

SELECT *
FROM employee_demographics
WHERE birth_date > "1985-01-01"
OR gender = "Male";

SELECT *
FROM employee_demographics
WHERE birth_date > "1985-01-01"
OR NOT gender = "Male";

-- Parenthesis: isolation statement
SELECT *
FROM employee_demographics
WHERE (first_name = "Leslie" AND age = 44) OR age > 55;

-- LIKE statement
-- %: anything and _: specific values

-- As long as it has Jer then it will be return
-- % %: anything come before and after 
SELECT *
FROM employee_demographics
WHERE first_name LIKE "%er%";

SELECT *
FROM employee_demographics
WHERE first_name LIKE "a%";

-- Start with an a and has 2 more characters after - no more no less
SELECT *
FROM employee_demographics
WHERE first_name LIKE "a__";

-- Combine % _
-- Start with an a then has 2 chars after and then can have anything after that
SELECT *
FROM employee_demographics
WHERE first_name LIKE "a___%";

SELECT *
FROM employee_demographics
WHERE birth_date LIKE "1989%";

-- GROUP BY
