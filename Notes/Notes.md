# SELECT queries 101

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

# Queries with constraints (Pt. 1)
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

# Queries with constraints (Pt. 2)
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

# Filtering and sorting Query results
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

# Multi-table queries with JOINs
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