For this exercise, we are going to work with our Employees table. Notice how the rows in this table have shared data, which will give us an opportunity to use aggregate functions to summarize some high-level metrics about the teams. Go ahead and give it a shot.

rolename  | name        | building | years_employed
----------|-------------|----------|----------------
Engineer  | Becky A.    | 1e       | 4
Engineer  | Dan B.      | 1e       | 2
Engineer  | Sharon F.   | 1e       | 6
Engineer  | Dan M.      | 1e       | 4
Engineer  | Malcom S.   | 1e       | 1
Artist    | Tylar S.    | 2w       | 2
Artist    | Sherman D.  | 2w       | 8
Artist    | Jakob J.    | 2w       | 6
Artist    | Lillia A.   | 2w       | 7
Artist    | Brandon J.  | 2w       | 7
Manager   | Scott K.    | 1e       | 9
Manager   | Shirlee M.  | 1e       | 3
Manager   | Daria O.    | 2w       | 6

1. Find the longest time that an employee has been at the studio
```sql
SELECT name, MAX(years_employed) FROM employees;
```
2. For each role, find the average number of years employed by employees in that role
```sql
SELECT role, AVG(years_employed) as Average_years_employed
FROM employees
GROUP BY role; 
```
3. Find the total number of employee years worked in each building
```sql
SELECT building, SUM(years_employed)
FROM employees
GROUP BY building
```
4. Find the number of Artists in the studio (without a HAVING clause)
```sql
SELECT role, COUNT(*) as Number_of_artists
FROM employees
WHERE role = "Artist";
```
or 
```sql
SELECT COUNT(role) as total FROM employees
WHERE role IS ("Artist")
GROUP BY role
```
5. Find the number of Employees of each role in the studio
```sql
SELECT role, COUNT(*)
FROM employees
GROUP BY role;
```
6. Find the total number of years employed by all Engineers
```sql
SELECT role, SUM(years_employed) FROM employees
WHERE role = "Engineer"
GROUP BY role
```
or 
```sql
SELECT role, SUM(years_employed)
FROM employees
GROUP BY role
HAVING role = "Engineer";
```