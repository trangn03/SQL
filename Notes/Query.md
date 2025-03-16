# 1. SELECT queries 101

**Select query for a specific columns**
```sql
SELECT column, another_column, …
FROM mytable;
```

**Select query for all columns**
```sql
SELECT * 
FROM mytable;
```

# 2. Queries with constraints (Pt. 1)
In order to filter certain results from being returned, we need to use a WHERE clause in the query. The clause is applied to each row of data by checking specific column values to determine whether it should be included in the results or not.

**Select query with constraints**
```sql
SELECT column, another_column, …
FROM mytable
WHERE condition
    AND/OR another_condition
    AND/OR …;
```

More complex clauses can be constructed by joining numerous AND or OR logical keywords (ie. num_wheels >= 4 AND doors <= 2). And below are some useful operators that you can use for numerical data (ie. integer or floating point):

| Operator           | Condition                                         | SQL Example                   |
|--------------------|---------------------------------------------------|-------------------------------|
| =, !=, <, <=, >, >= | Standard numerical operators                      | `col_name != 4`               |
| BETWEEN ... AND ... | Number is within range of two values (inclusive)  | `col_name BETWEEN 1.5 AND 10.5` |
| NOT BETWEEN ... AND ... | Number is not within range of two values (inclusive) | `col_name NOT BETWEEN 1 AND 10` |
| IN (...)           | Number exists in a list                           | `col_name IN (2, 4, 6)`       |
| NOT IN (...)       | Number does not exist in a list                   | `col_name NOT IN (1, 3, 5)`   |

# 3. Queries with constraints (Pt. 2)
When writing WHERE clauses with columns containing text data, SQL supports a number of useful operators to do things like case-insensitive string comparison and wildcard pattern matching. We show a few common text-data specific operators
| Operator | Condition | Example |
|---|---|---|
| `=` | Case sensitive exact string comparison (notice the single equals) | `col_name = "abc"` |
| `!=` or `<>` | Case sensitive exact string inequality comparison | `col_name != "abcd"` |
| `LIKE` | Case insensitive exact string comparison | `col_name LIKE "ABC"` |
| `NOT LIKE` | Case insensitive exact string inequality comparison | `col_name NOT LIKE "ABCD"` |
| `%` | Used anywhere in a string to match a sequence of zero or more characters (only with `LIKE` or `NOT LIKE`) | `col_name LIKE "%AT%"` (matches "AT", "ATTIC", "CAT" or even "BATS") |
| `_` | Used anywhere in a string to match a single character (only with `LIKE` or `NOT LIKE`) | `col_name LIKE "AN_"` (matches "AND", but not "AN") |
| `IN (...)` | String exists in a list | `col_name IN ("A", "B", "C")` |
| `NOT IN (...)` | String does not exist in a list | `col_name NOT IN ("D", "E", "F")` |

**Select query with constraints**
```sql
SELECT column, another_column, …
FROM mytable
WHERE condition
    AND/OR another_condition
    AND/OR …;
```

# 4. Filtering and sorting Query results
Even though the data in a database may be unique, the results of any particular query may not be – take our Movies table for example, many different movies can be released the same year. In such cases, SQL provides a convenient way to discard rows that have a duplicate column value by using the DISTINCT keyword.

**Select query with unique results**
```sql
SELECT DISTINCT column, another_column, …
FROM mytable
WHERE condition(s);
```
Since the DISTINCT keyword will blindly remove duplicate rows, we will learn in a future lesson how to discard duplicates based on specific columns using grouping and the GROUP BY clause.

## Ordering results

Unlike our neatly ordered table in the last few lessons, most data in real databases are added in no particular column order. As a result, it can be difficult to read through and understand the results of a query as the size of a table increases to thousands or even millions rows.

To help with this, SQL provides a way to sort your results by a given column in ascending or descending order using the ORDER BY clause.

**Select query with ordered results**
```sql
SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC;
```

## Limiting results to a subset
Another clause which is commonly used with the ORDER BY clause are the LIMIT and OFFSET clauses, which are a useful optimization to indicate to the database the subset of the results you care about.
The **LIMIT** will reduce the number of rows to return, and the optional **OFFSET** will specify where to begin counting the number rows from (skip the rows).

**Select query with limited rows**
```sql
SELECT column, another_column, …
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;
```

# 5. Multi-table queries with JOINs
Tables that share information about a single entity need to have a primary key that identifies that entity uniquely across the database. One common primary key type is an auto-incrementing integer (because they are space efficient), but it can also be a string, hashed value, so long as it is unique.

Using the JOIN clause in a query, we can combine row data across two separate tables using this unique key. The first of the joins that we will introduce is the INNER JOIN.

**Select query with INNER JOIN on multiple tables**
```sql
SELECT column, another_table_column, …
FROM mytable
INNER JOIN another_table 
    ON mytable.id = another_table.id
WHERE condition(s)
ORDER BY column, … ASC/DESC
LIMIT num_limit OFFSET num_offset;
```

The INNER JOIN is a process that matches rows from the first table and the second table which have the same key (as defined by the ON constraint) to create a result row with the combined columns from both tables. After the tables are joined, the other clauses we learned previously are then applied.

# 6. OUTER JOINs
If the two tables have asymmetric data, which can easily happen when data is entered in different stages, then we would have to use a LEFT JOIN, RIGHT JOIN or FULL JOIN instead to ensure that the data you need is not left out of the results.

**Select query with LEFT/RIGHT/FULL JOINs on multiple tables**
```sql
SELECT column, another_column, …
FROM mytable
INNER/LEFT/RIGHT/FULL JOIN another_table 
    ON mytable.id = another_table.matching_id
WHERE condition(s)
ORDER BY column, … ASC/DESC
LIMIT num_limit OFFSET num_offset;
```

Like the INNER JOIN these three new joins have to specify which column to join the data on.
When joining table A to table B, a LEFT JOIN simply includes rows from A regardless of whether a matching row is found in B. The RIGHT JOIN is the same, but reversed, keeping rows in B regardless of whether a match is found in A. Finally, a FULL JOIN simply means that rows from both tables are kept, regardless of whether a matching row exists in the other table.

When using any of these new joins, you will likely have to write additional logic to deal with NULLs in the result and constraints.

# 7. NULLs

It's always good to reduce the possibility of NULL values in databases because they require special attention when constructing queries, constraints (certain functions behave differently with null values) and when processing the results.

An alternative to NULL values in your database is to have data-type appropriate default values, like 0 for numerical data, empty strings for text data, etc. But if your database needs to store incomplete data, then NULL values can be appropriate if the default values will skew later analysis (for example, when taking averages of numerical data).

Sometimes, it's also not possible to avoid NULL values, as we saw in the last lesson when outer-joining two tables with asymmetric data. In these cases, you can test a column for NULL values in a WHERE clause by using either the IS NULL or IS NOT NULL constraint.

**Select query with constraints on NULL values**
```sql
SELECT column, another_column, …
FROM mytable
WHERE column IS/IS NOT NULL
AND/OR another_condition
AND/OR …;
```

# 8. Queries with expressions

**Example query with expressions**
```sql
SELECT particle_speed / 2.0 AS half_particle_speed
FROM physics_data
WHERE ABS(particle_position) * 10.0 > 500;
```

Each database has its own supported set of mathematical, string, and date functions that can be used in a query, which you can find in their own respective docs.

The use of expressions can save time and extra post-processing of the result data, but can also make the query harder to read, so we recommend that when expressions are used in the SELECT part of the query, that they are also given a descriptive alias using the AS keyword.

**Select query with expression aliases**
```sql
SELECT col_expression AS expr_description, …
FROM mytable;
```

In addition to expressions, regular columns and even tables can also have aliases to make them easier to reference in the output and as a part of simplifying more complex queries.

**Example query with both column and table name aliases**
```sql
SELECT column AS better_column_name, …
FROM a_long_widgets_table_name AS mywidgets
    INNER JOIN widget_sales
    ON mywidgets.id = widget_sales.widget_id;
```

# 9. Queries with aggregates (Pt. 1)
**Select query with aggregate functions over all rows**
```sql
SELECT AGG_FUNC(column_or_expression) AS aggregate_description, …
FROM mytable
WHERE constraint_expression;
```

## Common aggregates function
| Function          | Description                                                                                                                                                             |
|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| COUNT(*), COUNT(column) | A common function used to counts the number of rows in the group if no column name is specified. Otherwise, count the number of rows in the group with non-NULL values in the specified column. |
| MIN(column)       | Finds the smallest numerical value in the specified column for all rows in the group.                                                                                   |
| MAX(column)       | Finds the largest numerical value in the specified column for all rows in the group.                                                                                    |
| AVG(column)       | Finds the average numerical value in the specified column for all rows in the group.                                                                                   |
| SUM(column)       | Finds the sum of all numerical values in the specified column for the rows in the group.                                                                                 |

## 10. Grouped aggregate functions

**Select query with aggregate functions over groups**
```sql
SELECT AGG_FUNC(column_or_expression) AS aggregate_description, …
FROM mytable
WHERE constraint_expression
GROUP BY column;
```

# Queries with aggregates (Pt. 2)
SQL allows us to do this by adding an additional HAVING clause which is used specifically with the GROUP BY clause to allow us to filter grouped rows from the result set.

**Select query with HAVING constraint**
```sql
SELECT group_by_column, AGG_FUNC(column_expression) AS aggregate_result_alias, …
FROM mytable
WHERE condition
GROUP BY column
HAVING group_condition;
```

The HAVING clause constraints are written the same way as the WHERE clause constraints, and are applied to the grouped rows. With our examples, this might not seem like a particularly useful construct, but if you imagine data with millions of rows with different properties, being able to apply additional constraints is often necessary to quickly make sense of the data.


# 11. Order of execution of a Query

**Complete SELECT query**
```sql
SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
FROM mytable
    JOIN another_table
      ON mytable.column = another_table.column
    WHERE constraint_expression
    GROUP BY column
    HAVING constraint_expression
    ORDER BY column ASC/DESC
    LIMIT count OFFSET COUNT
```
## Query order of execution

1. FROM and JOINs

```sql
The FROM clause, and subsequent JOINs are first executed to determine the total working set of data that is being queried. This includes subqueries in this clause, and can cause temporary tables to be created under the hood containing all the columns and rows of the tables being joined.
```
2. WHERE

```sql
Once we have the total working set of data, the first-pass WHERE constraints are applied to the individual rows, and rows that do not satisfy the constraint are discarded. Each of the constraints can only access columns directly from the tables requested in the FROM clause. Aliases in the SELECT part of the query are not accessible in most databases since they may include expressions dependent on parts of the query that have not yet executed.
```

3. GROUP BY
```sql
The remaining rows after the WHERE constraints are applied are then grouped based on common values in the column specified in the GROUP BY clause. As a result of the grouping, there will only be as many rows as there are unique values in that column. Implicitly, this means that you should only need to use this when you have aggregate functions in your query.
```

4. HAVING
```sql
If the query has a GROUP BY clause, then the constraints in the HAVING clause are then applied to the grouped rows, discard the grouped rows that don't satisfy the constraint. Like the WHERE clause, aliases are also not accessible from this step in most databases.
```

5. SELECT
```sql
Any expressions in the SELECT part of the query are finally computed.
```

6. DISTINCT
```sql
Of the remaining rows, rows with duplicate values in the column marked as DISTINCT will be discarded.
```

7. ORDER BY
```sql
If an order is specified by the ORDER BY clause, the rows are then sorted by the specified data in either ascending or descending order. Since all the expressions in the SELECT part of the query have been computed, you can reference aliases in this clause.
```

8. LIMIT / OFFSET
```sql
Finally, the rows that fall outside the range specified by the LIMIT and OFFSET are discarded, leaving the final set of rows to be returned from the query.
```

# 12 Unions, Intersections & Exceptions

When working with multiple tables, the UNION and UNION ALL operator allows you to append the results of one query to another assuming that they have the same column count, order and data type. If you use the UNION without the ALL, duplicate rows between the tables will be removed from the result.

UNION: Combines the result sets of two or more SELECT statements into a single result set.

UNION ALL: If you want to include duplicate rows in the combined result set

INTERSECT: Returns the rows that are common to the result sets of two or more SELECT statements.

EXCEPT (or MINUS): Returns the rows from the first SELECT statement that are not present in the result set of the second SELECT statement.

**Select query with set operators**
```sql
SELECT column, another_column
   FROM mytable
UNION / UNION ALL / INTERSECT / EXCEPT
SELECT other_column, yet_another_column
   FROM another_table
ORDER BY column DESC
LIMIT n;
```

UNION happens before the ORDER BY and LIMIT. It's not common to use UNIONs, but if you have data in different tables that can't be joined and processed, it can be an alternative to making multiple queries on the database.

Similar to the UNION, the INTERSECT operator will ensure that only rows that are identical in both result sets are returned, and the EXCEPT operator will ensure that only rows in the first result set that aren't in the second are returned. This means that the EXCEPT operator is query order-sensitive, like the LEFT JOIN and RIGHT JOIN.

Both INTERSECT and EXCEPT also discard duplicate rows after their respective operations, though some databases also support INTERSECT ALL and EXCEPT ALL to allow duplicates to be retained and returned.