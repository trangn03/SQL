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
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

-- Max: highest value, Count: how many values on the column
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

-- Group multiple
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

-- ORDER BY: sort the result by descending or ascending order
-- Default is ASC 
SELECT * 
FROM employee_demographics
ORDER BY first_name DESC;

SELECT * 
FROM employee_demographics
ORDER BY gender, age;

SELECT * 
FROM employee_demographics
ORDER BY gender, age DESC;

-- HAVING vs WHERE
SELECT gender
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;

-- LIMIT 
SELECT *
FROM employee_demographics
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3
;

-- Limit: start at position 3 and then go 1 row after 
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1
;

-- ALIASING: change the name of the column
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;
;

-- JOINS: two table or more if they have common column
-- Default: INNER JOIN
-- INNER JOIN only brings over the rows that have the same value on both table
SELECT *
FROM employee_demographics
INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
;

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- OUTER JOIN: Left, Right
-- LEFT JOIN: takes everything from left table even if there's no match in the join and only return the matches from the right table
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;
-- RIGHT JOIN: takes everything from right table even if there's no match in the join and only return the matches from the left table
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- SELF JOIN: tie the table to itself
SELECT * 
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id = emp2.employee_id
;

SELECT * 
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

SELECT emp1.employee_id AS emp_santa, 
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name, 
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- JOIN multiple table together if there is common between them
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_and_recreation.parks_departments AS pd
	ON sal.dept_id = pd.department_id
;

SELECT * 
FROM parks_and_recreation.parks_departments;

-- UNIONS

